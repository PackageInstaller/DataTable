_class("UIN25VampireBattleResult", UICustomWidget)
UIN25VampireBattleResult = UIN25VampireBattleResult

function UIN25VampireBattleResult:OnShow(uiParams)
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._currentWaveLabel = self:GetUIComponent("UILocalizationText", "CurrentWave")
  self._totalWaveLabel = self:GetUIComponent("UILocalizationText", "TotalWave")
  self._levelOldLabel = self:GetUIComponent("UILocalizationText", "LevelOld")
  self._levelNewLabel = self:GetUIComponent("UILocalizationText", "LevelNew")
  self._expLabel = self:GetUIComponent("UILocalizationText", "Exp")
  self._addExpLabel = self:GetUIComponent("UILocalizationText", "AddExp")
  self._expBar = self:GetUIComponent("Image", "ExpBar")
  self._newLevelPanel = self:GetGameObject("NewLevelPanel")
  self._addExpPanel = self:GetGameObject("AddExpPanel")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._passedpets = self:GetUIComponent("UISelectObjectPath", "Passed")
  self._prePointText = self:GetUIComponent("UILocalizationText", "pre")
  self._lastPointText = self:GetUIComponent("UILocalizationText", "last")
  self._prePointGo = self:GetGameObject("pre")
  self._upGo = self:GetGameObject("up")
  self._passInfoGo = self:GetGameObject("passInfo")
end

function UIN25VampireBattleResult:OnHide()
end

function UIN25VampireBattleResult:SetData(matchResult)
  self:StartTask(self.LoadData, self, matchResult)
end

function UIN25VampireBattleResult:LoadData(TT, matchResult)
  self:Lock("UIN25VampireBattleResult_LoadData")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, campaign._id, nil, nil)
    self:UnLock("UIN25VampireBattleResult_LoadData")
    return false
  end
  local localProcess = campaign:GetLocalProcess()
  if not localProcess then
    self:UnLock("UIN25VampireBattleResult_LoadData")
    return false
  end
  self._localProcess = localProcess
  campaign:ReLoadCampaignInfo_Force(TT, res)
  local bloodsuckerComponent = localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  local bloodsuckerInfo = localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  if bloodsuckerComponent == nil then
    self:UnLock("UIN25VampireBattleResult_LoadData")
    return
  end
  local talentInfo = bloodsuckerInfo.talent_info
  local cfg = Cfg.cfg_bloodsucker_mission[matchResult.m_nID]
  if cfg then
    self._nameLabel:SetText(StringTable.Get(cfg.MissionName))
    self._currentWaveLabel:SetText(matchResult.wave)
    self._totalWaveLabel:SetText(cfg.WaveCount)
    local oldLevel = UIN25VampireUtil.GetOldLevel()
    local curLevel = talentInfo.talent_level
    local oldExp = UIN25VampireUtil.GetOldExp()
    local curExp = talentInfo.cur_exp
    local currentLevelCfg
    local cfgs = Cfg.cfg_component_bloodsucker_talent_level({
      ComponentID = bloodsuckerComponent:GetComponentCfgId()
    })
    for k, cfg in pairs(cfgs) do
      if cfg.Level == curLevel then
        currentLevelCfg = cfg
        break
      end
    end
    local oldLevelCfg
    for k, cfg in pairs(cfgs) do
      if cfg.Level == oldLevel then
        oldLevelCfg = cfg
        break
      end
    end
    local addExp = 0
    if oldLevel == curLevel then
      addExp = curExp - oldExp
    else
      addExp = oldLevelCfg.Exp - oldExp + curExp
      for i = oldLevel + 1, curLevel - 1 do
        for k, cfg in pairs(cfgs) do
          if cfg.Level == i then
            addExp = addExp + cfg.Exp
            break
          end
        end
      end
    end
    self._levelOldLabel:SetText(oldLevel)
    self._expLabel:SetText("<color=#f6cb7c>" .. curExp .. "</color>/" .. currentLevelCfg.Exp)
    local rate = curExp / currentLevelCfg.Exp
    self._expBar.fillAmount = rate
    if oldLevel == curLevel then
      self._newLevelPanel:SetActive(false)
    else
      self._newLevelPanel:SetActive(true)
      self._levelNewLabel:SetText(curLevel)
    end
    if 0 < addExp then
      self._addExpPanel:SetActive(true)
      self._addExpLabel:SetText("+" .. addExp)
    else
      self._addExpPanel:SetActive(false)
    end
  end
  local news = self:GetPassPets()
  if matchResult and #news ~= 0 then
    self._passInfoGo:SetActive(true)
    self:ShowNewPassPets()
  else
    self._passInfoGo:SetActive(false)
  end
  self:SetTalentPoint()
  self:UnLock("UIN25VampireBattleResult_LoadData")
end

function UIN25VampireBattleResult:PlayAnim(TT, matchResult)
  self._anim:Play("uieffanim_UIN25VampireBattleResult_in")
  YIELD(TT, 600)
  if matchResult.m_vecFirstPassAward and table.count(matchResult.m_vecFirstPassAward) > 0 then
    UIN25VampireUtil.ShowRewards(matchResult.m_vecFirstPassAward, nil)
  end
end

function UIN25VampireBattleResult:ShowNewPassPets()
  local news = self:GetPassPets()
  self._passedpets:SpawnObjects("UIN25VampireResultPetItem", #news)
  local pets = UIN25VampireUtil.GetVampireResultPets(news)
  local uis = self._passedpets:GetAllSpawnList()
  for i, pet in pairs(pets) do
    local ui = uis[i]
    local tplId = pets[i]
    ui:Flush(tplId, pets[i])
  end
end

function UIN25VampireBattleResult:SetTalentPoint()
  local bloodsuckerInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  local data = bloodsuckerInfo.talent_info
  local oldData = UIN25VampireUtil.GetOldInfo()
  self._prePointGo:SetActive(oldData.cur_talent_point ~= data.cur_talent_point)
  self._upGo:SetActive(oldData.cur_talent_point ~= data.cur_talent_point)
  self._prePointText:SetText(oldData.cur_talent_point)
  self._lastPointText:SetText(data.cur_talent_point)
end

function UIN25VampireBattleResult:GetPassPets()
  local bloodsuckerInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  local oldData = UIN25VampireUtil.GetOldComponentInfo()
  local passedpets = bloodsuckerInfo.pass_pet_list
  local news = {}
  
  local function checkFun(petId)
    for k = 1, #oldData do
      if petId == oldData[k] then
        return true
      end
    end
    return false
  end
  
  for i = 1, #passedpets do
    if not checkFun(passedpets[i]) and passedpets[i] ~= 0 then
      table.insert(news, passedpets[i])
    end
  end
  return news
end
