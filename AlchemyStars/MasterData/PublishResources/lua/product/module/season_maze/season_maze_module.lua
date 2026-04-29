_class("SeasonMazeModule", GameModule)
SeasonMazeModule = SeasonMazeModule

function SeasonMazeModule:Constructor()
  self.uiModule = self.uiModule
  self._mazeCampaignType = ECampaignType.CAMPAIGN_TYPE_SEASON_MAZE
  self._attrReason = {}
end

function SeasonMazeModule:UIModule()
  return self.uiModule
end

function SeasonMazeModule:Init()
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self._seasonMazeObj = nil
  self._seasonMazeCollageDataMgr = SeasonMazeCollageDataMgr:New()
end

function SeasonMazeModule:Update(dt)
  self.uiModule:Update(dt)
end

function SeasonMazeModule:GetLocalProcess(type, id)
  if not self._campModule:IsDisposed() then
    return self._campModule:GetCampaignLocalProcessByCampaignId_Local(type, id)
  end
end

function SeasonMazeModule:CheckErrorCode(result)
  if not self._campModule:IsDisposed() then
    return self._campModule:CheckErrorCode(result, nil, nil, nil)
  end
end

function SeasonMazeModule:GetSeasonMazeCollageDataMgr()
  return self._seasonMazeCollageDataMgr
end

function SeasonMazeModule:ReqCurSeasonMazeDetailInfo(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local sample = self:GetCurSample()
  if not sample then
    Log.error("没有简易数据,无法请求赛季秘境玩法详细数据")
    res:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN)
    return res
  end
  local id = sample.id
  Log.info("请求赛季秘境详细数据:", id)
  self._campModule:CampaignComProtoLoadInfo(TT, res, id)
  if not res:GetSucc() then
    Log.error("获取赛季秘境详细数据失败:", res:GetResult())
    return res
  end
  if self._campModule:IsDisposed() then
    Log.error("活动数据已经析构 无法获取赛季秘境详细数据:", id)
    res:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN)
    return res
  end
  local obj = self._campModule:GetCampaignObj(id)
  if not obj then
    Log.error("强制拉取赛季秘境数据成功 但无法获取详细数据:", id)
    res:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN)
    return res
  end
  local localProcess = self._campModule:GetCampaignLocalProcessByCampaignId_Local(self._mazeCampaignType, id)
  if not localProcess then
    Log.error("强制拉取赛季秘境数据成功 无法获取赛季秘境 LocalProcess:", id)
    res:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN)
    return res
  end
  localProcess:InitComponent(obj)
  self._seasonMazeObj = UISeasonMazeObj:New(sample, self)
  local comp = self._seasonMazeObj:GetMazeComponent()
  self._seasonMazeComponent = comp
  if comp then
    local compInfo = comp:GetComponentInfo()
    local compId = UIActivityHelper.GetComponentID(compInfo)
    self._seasonMazeComponentId = compId
    self._seasonMazeCollageDataMgr:Init(compId)
    local moneyLv = compInfo.save_info.lv
    self._seasonMazeCollageDataMgr:Refresh(moneyLv)
  else
    self._seasonMazeComponentId = -1
    self._seasonMazeCollageDataMgr:Init(0)
  end
  return res
end

function SeasonMazeModule:GetSeasonMazeComponentId()
  return self._seasonMazeComponentId
end

function SeasonMazeModule:GetSeasonMazeComponent()
  return self._seasonMazeComponent
end

function SeasonMazeModule:ReqSeasonMazeChangeFormationInfo(TT, id, name, pets)
  local seasonMazeComponent = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  local reqRes = AsyncRequestRes:New()
  local formation = SeasonMazeFormationItem:New()
  formation.id = id
  formation.name = name
  formation.pet_list = pets
  local response = seasonMazeComponent:HandleSeasonMazeChangeFormation(TT, reqRes, formation)
  if self:CheckSeasonMazeClose(reqRes) then
    return reqRes
  end
  return reqRes, response
end

function SeasonMazeModule:GetCurSample()
  if not self._campModule:IsDisposed() then
    return self._campModule:GetSampleByType(self._mazeCampaignType)
  end
end

function SeasonMazeModule:GetPetDispatchData(petID)
  local seasonMazeComponent = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  if seasonMazeComponent then
    local compInfo = seasonMazeComponent:GetComponentInfo()
    local map = compInfo.occupy_ore
    return map[petID]
  end
  return nil
end

function SeasonMazeModule:CurSeasonMazeID()
  local sample = self:GetCurSample()
  if sample then
    return sample.id
  end
  return UISeasonMazeID.SM1
end

function SeasonMazeModule:CurSeasonObj()
  return self._seasonMazeObj
end

function SeasonMazeModule:CheckCanAutoFight(matchInfo)
  return true, ""
end

function SeasonMazeModule:SetAttrReason(attId, reason, old_info, new_info)
  if not reason then
    return
  end
  old_info = old_info or 0
  if not self._attrReason[reason] then
    self._attrReason[reason] = {}
  end
  self._attrReason[reason][attId] = {old_info, new_info}
  self:UIModule():OnAttrChanged(attId, reason, old_info, new_info)
end

function SeasonMazeModule:GetLevelMonsterList(levelID, waveRandoms)
  local cfg = Cfg.cfg_level[levelID]
  if cfg == nil then
    Log.exception("找不到关卡：", levelID)
  end
  local waveArr = cfg.MonsterWave
  local ret = {}
  for i, wave in ipairs(waveArr) do
    local wavecfg = Cfg.cfg_monster_wave[wave]
    local refreshcfg = Cfg.cfg_refresh[wavecfg.WaveBeginRefreshID]
    local monsterWeight = refreshcfg.MonsterWeight
    local monsterRIds = refreshcfg.MonsterRefreshIDList
    local totalw = 0
    for _, w in ipairs(monsterWeight) do
      totalw = totalw + w
    end
    local monsterRefreshId = 0
    local ww = waveRandoms[2 * i - 1] * totalw
    for j, w in ipairs(monsterWeight) do
      ww = ww - w
      if ww <= 0 then
        monsterRefreshId = monsterRIds[j]
        break
      end
    end
    local monsters
    local refreshMonsterCfg = Cfg.cfg_refresh_monster[monsterRefreshId]
    if refreshMonsterCfg.RandomMonsterIDList then
      local monsterList = table.cloneconf(refreshMonsterCfg.RandomMonsterIDList)
      local weightList = table.cloneconf(refreshMonsterCfg.RandomWeightList)
      weightList = weightList or self:_MakeDefaultRandomWeightList(monsterList)
      monsters = self:_ParseRandomMonsterID(monsterList, weightList, waveRandoms)
    else
      monsters = table.cloneconf(refreshMonsterCfg.MonsterIDList)
    end
    table.appendArray(ret, monsters)
  end
  ret = table.unique(ret)
  return ret
end

function SeasonMazeModule:_MakeDefaultRandomWeightList(monsterList)
  local weightList = {}
  for index, value in ipairs(monsterList) do
    local monsterGroup = value
    local weightGroup = {}
    for groupIndex, monsterID in ipairs(monsterGroup) do
      table.insert(weightGroup, 1)
    end
    table.insert(weightList, weightGroup)
  end
  return weightList
end

function SeasonMazeModule:_ParseRandomMonsterID(monsterList, weightList, waveRandoms)
  local monsterIDList = {}
  if #monsterList ~= #weightList then
    return monsterIDList
  end
  for i = 1, #monsterList do
    local monsterGroup = monsterList[i]
    local weightGroup = weightList[i]
    local totalWeight = 0
    for _, w in ipairs(weightGroup) do
      totalWeight = totalWeight + w
    end
    local index = math.fmod(i - 1, #waveRandoms) + 1
    local rand = waveRandoms[index]
    local curWeight = rand * totalWeight
    for i, w in ipairs(weightGroup) do
      curWeight = curWeight - w
      if curWeight <= 0 then
        table.insert(monsterIDList, monsterGroup[i])
        break
      end
    end
  end
  return monsterIDList
end

function SeasonMazeModule:GetAttrsByReason(reason)
  local attrs = self._attrReason[reason]
  if not attrs or not next(attrs) then
    return nil
  end
  local result = {}
  for key, value in pairs(attrs) do
    result[key] = value[2] - value[1]
  end
  return result
end

function SeasonMazeModule:CheckSeasonMazeClose(res)
  if res and not res:GetSucc() then
    local result = res:GetResult()
    if result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED or result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE then
      self:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
      if self.uiModule:IsRunning() then
        self.uiModule:ExitTo(UIStateType.UIMain)
      else
        GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
      end
      return true
    end
  end
  return false
end
