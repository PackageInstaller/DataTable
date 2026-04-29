_class("UILuckLandGameEndPopUp", UIController)
UILuckLandGameEndPopUp = UILuckLandGameEndPopUp

function UILuckLandGameEndPopUp:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandGameEndPopUp:OnShow(uiParams)
  self:InitWidget()
  self.restartCB = uiParams[1]
end

function UILuckLandGameEndPopUp:InitWidget()
  self._animObj = self:GetGameObject("_anim")
  self.titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self.tipsText = self:GetUIComponent("UILocalizationText", "TipsText")
  self.reBattleText = self:GetUIComponent("UILocalizationText", "ReBattleText")
  self.endGameText = self:GetUIComponent("UILocalizationText", "EndGameText")
  self._anim = self:GetUIComponent("Animation", "_anim")
end

function UILuckLandGameEndPopUp:BgOnClick(go)
end

function UILuckLandGameEndPopUp:ReBattleBtnOnClick(go)
  GameGlobal.UIStateManager():CloseDialog("UILuckLandMainGameController")
  GameGlobal.UIStateManager():CloseDialog("UILuckLandLevelInfo")
  self:Lock("UILuckLandGameEndPopUp:Restart")
  GameGlobal.Timer():AddEvent(33, function()
    self:UnLock("UILuckLandGameEndPopUp:Restart")
    LuckLandData:GetInstance():CurCardDatas():Reset(false)
    LuckLandData:GetInstance():CurBuildingDatas():Reset()
    local id = LuckLandData:GetInstance():GetCurMissionID()
    self:ShowDialog("UILuckLandMainGameController", id)
    self:CloseDialog()
  end)
end

function UILuckLandGameEndPopUp:EndGameBtnOnClick(go)
  GameGlobal.UIStateManager():CloseDialog("UILuckLandMainGameController")
  GameGlobal.UIStateManager():CloseDialog("UILuckLandLevelInfo")
  self._anim:Play("uieff_UILuckLandGameEndPopUp_in")
  GameGlobal.Timer():AddEvent(390, function()
    self:CloseDialog()
  end)
end
