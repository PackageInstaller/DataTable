_class("UISeasonModeSwitchS4", UICustomWidget)
UISeasonModeSwitchS4 = UISeasonModeSwitchS4

function UISeasonModeSwitchS4:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.OnSeasonModeChanged, self._OnModeChanged)
  self:AttachEvent(GameEventType.OnEventPointProgressChange, self._OnEventPointProgressChange)
end

function UISeasonModeSwitchS4:OnHide()
  self:DetachEvent(GameEventType.OnSeasonModeChanged, self._OnModeChanged)
  self:DetachEvent(GameEventType.OnEventPointProgressChange, self._OnEventPointProgressChange)
end

function UISeasonModeSwitchS4:InitWidget()
  self._root = self:GetGameObject("Root")
  self._mask1 = self:GetGameObject("Mask1")
  self._mask2 = self:GetGameObject("Mask2")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonModeSwitchS4:SetData(seasonObj)
  self._seasonObj = seasonObj
  self._seasonManager = GameGlobal.GetModule(SeasonModule):UIModule():SeasonManager()
  self._mapManager = self._seasonManager:SeasonMapManager()
  self._componentInfo = self._seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._canSwitch = self:_CheckModeValid(SeasonMapMode.Mode2)
  self._root:SetActive(self._canSwitch)
  self:_OnModeChanged()
end

function UISeasonModeSwitchS4:BtnMode1OnClick(go)
  self:_SwitchTo(SeasonMapMode.Mode1)
end

function UISeasonModeSwitchS4:BtnMode2OnClick(go)
  self:_SwitchTo(SeasonMapMode.Mode2)
end

function UISeasonModeSwitchS4:BtnSwitchOnClick(go)
  local mode
  if self._curMode == SeasonMapMode.Mode1 then
    mode = SeasonMapMode.Mode2
  elseif self._curMode == SeasonMapMode.Mode2 then
    mode = SeasonMapMode.Mode1
  end
  self:_SwitchTo(mode)
end

function UISeasonModeSwitchS4:_SwitchTo(mode)
  if not self._canSwitch then
    Log.warn("不能切换赛季模式:", mode)
    return
  end
  if self._curMode == mode then
    Log.warn("无需切换赛季模式:", mode)
    return
  end
  if not self:_CheckModeValid(mode) then
    Log.warn("模式不可用 无法切换:", mode)
    return
  end
  self:StartTask(self._Switch, self, mode)
end

function UISeasonModeSwitchS4:_CheckModeValid(mode)
  local cfg = Cfg.cfg_season_map[self._seasonObj:GetSeasonID()]
  if not cfg then
    Log.exception("cfg_season_map 中找不到配置:", self._seasonObj:GetSeasonID())
    return false
  end
  if cfg.ModeUnlock == nil or next(cfg.ModeUnlock) == nil then
    return false
  end
  local condition = cfg.ModeUnlock[mode]
  if string.isnullorempty(condition) then
    return true
  end
  local valid = GameGlobal.GetModule(SeasonModule):CheckCondition(condition, self._componentInfo.m_stage_info)
  return valid
end

function UISeasonModeSwitchS4:_Switch(TT, mode)
  self:Lock("UISeasonModeSwitchS4:SwitchMode")
  self._anim:Stop()
  if mode == SeasonMapMode.Mode1 then
    self._anim:Play("uieff_UISeasonModeSwitchS4_02")
  elseif mode == SeasonMapMode.Mode2 then
    self._anim:Play("uieff_UISeasonModeSwitchS4_01")
  end
  YIELD(TT, 400)
  GameGlobal.UIStateManager():ShowDialog("UISeasonTransitionAnimations", "UISeasonTransitionAnimation_Style1", 500, 500, function()
    if self.view then
      self._mapManager:SwitchMapMode(mode)
      self._curMode = mode
      self:_RefreshBtn(mode)
    end
  end, function()
  end)
  YIELD(TT, 1000)
  self:UnLock("UISeasonModeSwitchS4:SwitchMode")
end

function UISeasonModeSwitchS4:_RefreshBtn(mode)
  if mode == SeasonMapMode.Mode1 then
    self._mask1:SetActive(false)
    self._mask2:SetActive(true)
  elseif mode == SeasonMapMode.Mode2 then
    self._mask1:SetActive(true)
    self._mask2:SetActive(false)
  end
end

function UISeasonModeSwitchS4:_OnModeChanged()
  self._curMode = self._mapManager:Mode()
  self:_RefreshBtn(self._curMode)
end

function UISeasonModeSwitchS4:_OnEventPointProgressChange()
  self._canSwitch = self:_CheckModeValid(SeasonMapMode.Mode2)
  self._root:SetActive(self._canSwitch)
end
