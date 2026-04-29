_class("UICN7N36PostGameClosingController", UIController)
UICN7N36PostGameClosingController = UICN7N36PostGameClosingController

function UICN7N36PostGameClosingController:OnShow(uiParams)
  self._missionID = uiParams[1]
  self._rt = uiParams[2]
  self._score = uiParams[3]
  self._missionCallBack = uiParams[4]
  self._hasPassed = uiParams[5]
  self._taskChainCallBack = uiParams[6]
  self._missionCfg = Cfg.cfg_season_debris_mission({
    ID = self._missionID
  })[1]
  self._txtCfg = Cfg.cfg_season_debris_level[self._missionID].SuccessMessage
  self:InitWidget()
  self:ShowDetail()
  self:PlayAnimIN()
end

function UICN7N36PostGameClosingController:InitWidget()
  self._RTBG = self:GetUIComponent("RawImage", "RTBG")
  self._RTBGRect = self:GetUIComponent("RectTransform", "RTBG")
  self._ScoreTxt = self:GetUIComponent("UILocalizationText", "ScoreTxt")
  self._anim = self:GetUIComponent("Animation", "anim")
  local standard = 1.7777777777777777
  local now = UnityEngine.Screen.width / UnityEngine.Screen.height
  self._RTBGRect.sizeDelta = Vector2(1080 * now, 1080)
  self._FishTxt = self:GetUIComponent("UILocalizationText", "FishTxt")
end

function UICN7N36PostGameClosingController:EnsureBtnOnClick()
  local lockName = "UICN7N36PostGameClosingController_AnimOUT"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._anim:Play("uieff_UICN7N36PostGameClosingController_out")
    YIELD(TT, 500)
    self:UnLock(lockName)
    GameGlobal.UIStateManager():CloseDialog("UICN7N36PostInnerGameController")
    self:CloseDialog()
    if self._missionCallBack then
      self._missionCallBack(not self._hasPassed)
    end
    if self._taskChainCallBack then
      self._taskChainCallBack(true)
    end
  end)
end

function UICN7N36PostGameClosingController:ShowDetail()
  self._ScoreTxt:SetText(self._score)
  self._FishTxt:SetText(StringTable.Get(self._txtCfg))
  self._RTBG.texture = self._rt
end

function UICN7N36PostGameClosingController:PlayAnimIN()
  local lockName = "UICN7N36PostGameClosingController_AnimIN"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._anim:Play("uieff_UICN7N36PostGameClosingController_in")
    YIELD(TT, 500)
    self:UnLock(lockName)
  end)
end
