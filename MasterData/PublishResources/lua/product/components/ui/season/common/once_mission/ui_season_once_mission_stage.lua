_class("UISeasonOnceMissionStage", UIController)
UISeasonOnceMissionStage = UISeasonOnceMissionStage

function UISeasonOnceMissionStage:OnShow(uiParams)
  self._module = self:GetModule(MissionModule)
  self._missionID = uiParams[1]
  self._onceMissionData = uiParams[2]
  self._cmpt = uiParams[3]
  self._fromSeasonMain = uiParams[4]
  local subCfg = self._cmpt:GetLineSubCfg()
  self._campaignSubMatchTyhpe = subCfg.SubType
  self:InitWigets()
  self:Flush()
end

function UISeasonOnceMissionStage:InitWigets()
  local conditionPool = self:GetUIComponent("UISelectObjectPath", "condition")
  self._stageCondition = conditionPool:SpawnObject("UISeasonOnceMissionStageCondition")
  local awardPool = self:GetUIComponent("UISelectObjectPath", "award")
  self._stageAward = awardPool:SpawnObject("UISeasonOnceMissionStageAward")
  local enemyPool = self:GetUIComponent("UISelectObjectPath", "enemy")
  self._stageEnemy = enemyPool:SpawnObject("UISeasonOnceMissionStageEnemy")
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self._reLv = self:GetUIComponent("UILocalizationText", "ReLv")
  self._txtAttr = self:GetUIComponent("UILocalizationText", "txtAttr")
  self._noAttrGo = self:GetGameObject("noAttr")
  self._titleTxt = self:GetUIComponent("UILocalizationText", "titleTxt")
  self._titleTxtShadow = self:GetUIComponent("UILocalizationText", "titleTxtShadow")
  self._uiAnim = self:GetUIComponent("Animation", "uiAnim")
  self._uiAnim:Play("uieff_Stage_In")
end

function UISeasonOnceMissionStage:Flush()
  self._stageAward:SetData(self._missionID, self._onceMissionData, self._cmpt)
  self._stageCondition:SetData(self._missionID, self._onceMissionData, self._cmpt)
  self._stageEnemy:SetData(self._missionID, self._onceMissionData, self._cmpt)
  self:FlushFightInfo()
end

function UISeasonOnceMissionStage:FlushFightInfo()
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  local txt = StringTable.Get(missionCfg.Name)
  self._titleTxt:SetText(txt)
  self._titleTxtShadow:SetText(txt)
  local recommendAwaken = missionCfg.RecommendAwaken and missionCfg.RecommendAwaken or 0
  local recommendLV = missionCfg.RecommendLV and missionCfg.RecommendLV or 0
  local tex = StringTable.Get("str_discovery_node_recommend_lv")
  if recommendAwaken and 0 < recommendAwaken then
    tex = tex .. " " .. StringTable.Get("str_pet_config_common_advance") .. recommendAwaken
  end
  if recommendLV then
    tex = tex .. " LV." .. recommendLV
  end
  self._reLv:SetText(tex)
  local cfg = Cfg.cfg_season_brance_tab[self._cmpt:GetComponentCfgId()]
  local txtStr
  if cfg and cfg.FightAttrDesc then
    txtStr = StringTable.Get(cfg.FightAttrDesc)
  else
    local buff = missionCfg.BaseWordBuff
    if buff then
      local word_tb = {}
      for _, wordId in ipairs(buff) do
        local txt = self:_GetWordDesc(missionCfg.ID, wordId)
        if txt then
          table.insert(word_tb, txt)
        end
      end
      txtStr = table.concat(word_tb, [[


]])
    end
  end
  self._txtAttr:SetText(txtStr)
  self._noAttrGo:SetActive(string.isnullorempty(txtStr))
end

function UISeasonOnceMissionStage:_GetWordDesc(levelId, wordId)
  local word = Cfg.cfg_word_buff[wordId]
  if not word or not word.Word then
    return nil
  end
  if string.isnullorempty(word.Word[1]) and string.isnullorempty(word.Desc) then
    return nil
  end
  local name = StringTable.Get(word.Word[1])
  local desc = StringTable.Get(word.Desc)
  local tex = "【" .. name .. "】" .. desc
  return tex
end

function UISeasonOnceMissionStage:BtnFightOnClick(go)
  self:_DoFight()
end

function UISeasonOnceMissionStage:_DoFight()
  local subCfg = self._cmpt:GetLineSubCfg()
  local type = TeamOpenerType.Campaign
  if subCfg and subCfg.NeedFormation and subCfg.NeedFormation == 1 then
    type = TeamOpenerType.SeasonOnceMission
  end
  local ctx = GameGlobal.GetModule(MissionModule):TeamCtx()
  if type == TeamOpenerType.SeasonOnceMission then
    ctx:InitSeasonOnceTeam(self._cmpt:GetComponentInfo().formation_list)
    local param = {
      self._missionID,
      self._cmpt:GetCampaignMissionComponentId(),
      self._cmpt:GetCampaignMissionParamKeyMap(),
      self._cmpt
    }
    param.SeasonOnceMission = true
    ctx:Init(TeamOpenerType.SeasonOnceMission, param)
  elseif type == TeamOpenerType.Campaign then
    local param = {
      self._missionID,
      self._cmpt:GetCampaignMissionComponentId(),
      self._cmpt:GetCampaignMissionParamKeyMap(),
      self._cmpt
    }
    param.SeasonOnceMission = true
    ctx:Init(TeamOpenerType.Campaign, param)
  end
  UISeasonHelper.OnceMissionBattleFromSeasonMain = self._fromSeasonMain
  self:ShowDialog("UITeams")
end

function UISeasonOnceMissionStage:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UISeasonOnceMissionStage:BgOnClick()
  self:CloseDialog()
end
