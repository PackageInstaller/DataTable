_class("UIN28ErrandMapNode", UICustomWidget)
UIN28ErrandMapNode = UIN28ErrandMapNode

function UIN28ErrandMapNode:OnShow(uiParams)
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self.atlas = self:GetAsset("UIN28Errand.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetUIComponent("Animation", "anim")
  self._go = self:GetGameObject()
  self._go:SetActive(false)
end

function UIN28ErrandMapNode:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UIN28ErrandMapNode:SetData(lineCfg, passInfo, cb, unlock, yieldTime)
  self._missionID = lineCfg.CampaignMissionId
  self._callback = cb
  self._unlock = unlock
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self:_SetRectTransform(lineCfg)
  local missionType = missionCfg.Type
  local cfg_c_line_mission = Cfg.cfg_component_line_mission({
    CampaignMissionId = self._missionID
  })[1]
  local param = cfg_c_line_mission.CustomParams and cfg_c_line_mission.CustomParams[1]
  if param and next(param) and param[1] == 2 and missionType == DiscoveryStageType.FightNormal then
    missionType = 4
  end
  self:_SetState(missionType)
  self:_SetName_TMP(missionCfg.Type, StringTable.Get(missionCfg.Name))
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  self.missionType = missionCfg.Type
  self:_SetStar(passInfo)
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
  end
  self._event = GameGlobal.Timer():AddEvent(yieldTime, function()
    self._go:SetActive(true)
  end)
end

function UIN28ErrandMapNode:_SetRectTransform(lineCfg)
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UIN28ErrandMapNode:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
  end
  if self._cliclEvent then
    GameGlobal.Timer():CancelEvent(self._cliclEvent)
    self._cliclEvent = nil
  end
  self:UnLock("UIN28ErrandMapNode:BtnOnClick")
end

function UIN28ErrandMapNode:_SetName(state, text)
  local tb = {
    "name_normal",
    "name_boss",
    "name_plot"
  }
  UIWidgetHelper.SetLocalizationText(self, tb[state], text)
end

function UIN28ErrandMapNode:_SetName_TMP(state, text)
  local nameTex_boss = self:GetUIComponent("UILocalizationText", "name_boss")
  local nameTex_norm = self:GetUIComponent("UILocalizationText", "name_normal")
  local nameTex_plot = self:GetUIComponent("UILocalizationText", "name_plot")
  local texGo_boss = nameTex_boss.gameObject
  local texGo_norm = nameTex_norm.gameObject
  local texGo_plot = nameTex_plot.gameObject
  texGo_boss:SetActive(state == DiscoveryStageType.FightBoss)
  texGo_norm:SetActive(state == DiscoveryStageType.FightNormal)
  texGo_plot:SetActive(state == DiscoveryStageType.Plot)
  if state == DiscoveryStageType.Plot then
    nameTex_plot:SetText(text)
  elseif state == DiscoveryStageType.FightNormal then
    nameTex_norm:SetText(text)
  else
    nameTex_boss:SetText(text)
  end
end

function UIN28ErrandMapNode:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "bg_normal",
      "name_normal",
      "star"
    },
    {
      "bg_boss",
      "name_boss",
      "star"
    },
    {"bg_plot", "name_plot"},
    {
      "bg_normal2",
      "name_normal",
      "star"
    }
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIN28ErrandMapNode:_SetStar(passInfo)
  local missionModule = self:GetModule(MissionModule)
  local stars = passInfo and missionModule:ParseStarInfo(passInfo.star) or 0
  local tb = {
    self:GetGameObject("Star1"),
    self:GetGameObject("Star2"),
    self:GetGameObject("Star3")
  }
  for i = 1, 3 do
    local pass = stars >= i
    tb[i]:SetActive(pass)
  end
  local lockGo = self:GetGameObject("lockGo")
  lockGo:SetActive(not self._unlock)
  self._selectGo = self:GetGameObject("selectGo")
  self._selectGo:SetActive(false)
  local localdbMissionKey = "UIN28ErrandSideEnter_Mission"
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local mission_key = localdbMissionKey .. self._missionID .. openID
  local mission_val = LocalDB.GetInt(mission_key, 0)
  self._redGo = self:GetGameObject("red")
  self._redGo:SetActive(mission_val == 0 and self._unlock)
end

function UIN28ErrandMapNode:Select(missionID)
  self._selectGo:SetActive(missionID == self._missionID)
end

function UIN28ErrandMapNode:BtnOnClick(go)
  if self._unlock then
    self:Lock("UIN28ErrandMapNode:BtnOnClick")
    if self._cliclEvent then
      GameGlobal.Timer():CancelEvent(self._cliclEvent)
      self._cliclEvent = nil
    end
    self._anim:Play("uieff_UIN28ErrandMapNode_xuanzhong")
    self._cliclEvent = GameGlobal.Timer():AddEvent(300, function()
      self:UnLock("UIN28ErrandMapNode:BtnOnClick")
      self._callback(self._missionID, self._isStoryNode, self._rectTransform.position)
      self._redGo:SetActive(false)
    end)
  end
end
