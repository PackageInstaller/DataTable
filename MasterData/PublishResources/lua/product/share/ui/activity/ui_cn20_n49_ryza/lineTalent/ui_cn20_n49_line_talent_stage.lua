_class("UICN20N49LineTalentStage", UIController)
UICN20N49LineTalentStage = UICN20N49LineTalentStage

function UICN20N49LineTalentStage:OnShow(uiParams)
  self._module = self:GetModule(MissionModule)
  self._missionID = uiParams[1]
  self._cmpt = uiParams[2]
  self._campaign = uiParams[3]
  if uiParams[4] then
    self._actionPointComponentId = uiParams[4]
    self._pointComp = self._campaign:GetComponent(self._actionPointComponentId)
  end
  self._campType = self._campaign:GetCampaignType()
  self:InitWigets()
  self:Init()
  self:Flush()
end

function UICN20N49LineTalentStage:InitWigets()
  local conditionPool = self:GetUIComponent("UISelectObjectPath", "sweepCondition")
  self._stageCondition = conditionPool:SpawnObject("UICN20N49LineTalentStageSweepCondition")
  local awardPool = self:GetUIComponent("UISelectObjectPath", "award")
  self._stageAward = awardPool:SpawnObject("UICN20N49LineTalentStageAward")
  local enemyPool = self:GetUIComponent("UISelectObjectPath", "enemy")
  self._stageEnemy = enemyPool:SpawnObject("UICN20N49LineTalentStageEnemy")
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
  self._btnIcon = self:GetUIComponent("Image", "powerIcon")
  self._txtCost = self:GetUIComponent("UILocalizationText", "txtCost")
  self._costGo = self:GetGameObject("cost")
  self._sweepAreaGo = self:GetGameObject("SweepArea")
  self._btnSweepGo = self:GetGameObject("BtnSweep")
  self._btnSweepLockAreaGo = self:GetGameObject("BtnSweepLockArea")
end

function UICN20N49LineTalentStage:Init()
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  self._powerID = RoleAssetID.RoleAssetPhyPoint
  self._needPower = missionCfg.NeedPower
  if missionCfg.NeedAP then
    self._powerID = missionCfg.NeedAP[1]
    self._needPower = missionCfg.NeedAP[2]
  end
  local hasPass = self._cmpt:GetComponentInfo().m_pass_mission_info[self._missionID]
  if hasPass then
    self._canSweep = true
  else
    self._canSweep = false
  end
  self:AttachEvents()
end

function UICN20N49LineTalentStage:AttachEvents()
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemChanged)
end

function UICN20N49LineTalentStage:Flush()
  self._stageAward:SetData(self._missionID, self._cmpt)
  self._stageCondition:SetData(self._missionID, self._cmpt)
  self._stageEnemy:SetData(self._missionID, self._cmpt)
  if self._actionPointComponentId then
    self._costGo:SetActive(true)
    self._sweepAreaGo:SetActive(true)
    self:FlushCostInfo()
    self:FlushSweepInfo()
    self:_SetActionPoint("_actionPoint")
  else
    self._costGo:SetActive(false)
    self._sweepAreaGo:SetActive(false)
  end
  self:FlushFightInfo()
end

function UICN20N49LineTalentStage:FlushCostInfo()
  local needPowerText = self._needPower
  if self._powerID == RoleAssetID.RoleAssetPhyPoint then
  else
    if not self._pointComp then
      Log.exception("关卡体力为行动点,但没有活动的行动点组件")
    end
    local cmpID = self._pointComp:GetComponentCfgId()
    local pointCfg = self._pointComp:GetActionPointConfig()
    local itemCfg = Cfg.cfg_top_tips[pointCfg.ItemID]
    self._btnIcon.sprite = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas):GetSprite(itemCfg.Icon)
    local cur, ceil = self._pointComp:GetItemCount()
    if cur < self._needPower then
      needPowerText = "<color=#FF0000>" .. self._needPower .. "</color>"
    end
  end
  self._txtCost:SetText(needPowerText)
end

function UICN20N49LineTalentStage:FlushFightInfo()
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
  local txtStr
  if missionCfg.Desc then
    txtStr = StringTable.Get(missionCfg.Desc)
  else
    txtStr = ""
  end
  self._txtAttr:SetText(txtStr)
  self._noAttrGo:SetActive(string.isnullorempty(txtStr))
end

function UICN20N49LineTalentStage:_GetWordDesc(levelId, wordId)
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

function UICN20N49LineTalentStage:BtnFightOnClick(go)
  self:_DoFight()
end

function UICN20N49LineTalentStage:_DoFight()
  local subCfg = self._cmpt:GetLineSubCfg()
  local type = TeamOpenerType.Campaign
  local ctx = GameGlobal.GetModule(MissionModule):TeamCtx()
  if type == TeamOpenerType.Campaign then
    local param = {
      self._missionID,
      self._cmpt:GetCampaignMissionComponentId(),
      self._cmpt:GetCampaignMissionParamKeyMap(),
      self._cmpt
    }
    ctx:Init(TeamOpenerType.Campaign, param)
  end
  self:ShowDialog("UITeams")
end

function UICN20N49LineTalentStage:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UICN20N49LineTalentStage:BgOnClick()
  self:CloseDialog()
end

function UICN20N49LineTalentStage:BtnSweepOnClick(go)
  do
    local id = self._missionID
    local power = self._needPower
    local unlock = true
    local campParams = UISerialAutoFightOptionCampParams:New(self._pointComp, self._campType, 2, 0, self._cmpt:GetCampaignMissionComponentId(), self._cmpt:GetCampaignMissionParamKeyMap())
    campParams._displayTitleState = 1
    campParams._displayTitleText = StringTable.Get("str_cn20_line_talent_sweep_title")
    local matchType = MatchType.MT_Campaign
    local params = {
      matchType = matchType,
      stageId = id,
      needPower = power,
      uuid = nil,
      unlock = unlock,
      trackData = nil,
      campParams = campParams,
      toIndex = nil,
      checkFunction = function()
        return true
      end,
      autoFightCallback = function(count)
        self:_DoFight(count)
      end,
      resultHideEnough = true
    }
    self:ShowDialog("UISerialAutoFightOptionNew", params)
  end
end

function UICN20N49LineTalentStage:BtnSweepLockOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_cn20_line_talent_sweep_lock_tips"))
end

function UICN20N49LineTalentStage:FlushSweepInfo()
  self._btnSweepGo:SetActive(self._canSweep)
  self._btnSweepLockAreaGo:SetActive(not self._canSweep)
end

function UICN20N49LineTalentStage:_SetActionPoint(widgetName)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UICN20N49ActionPointLineTalent")
  obj:SetData(self._campaign, ECampaignCN20ComponentID.ECN20_ACTION_POINT, "UICN20N49ActionPointDetail", false, self:GetName())
end

function UICN20N49LineTalentStage:_OnItemChanged(id)
  self:FlushCostInfo()
  self:_SetActionPoint("_actionPoint")
end
