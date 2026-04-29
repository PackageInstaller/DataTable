_class("UIN16AnswerOnPauseController", UIController)
UIN16AnswerOnPauseController = UIN16AnswerOnPauseController

function UIN16AnswerOnPauseController:OnShow(uiParams)
  self:InitWidget()
end

function UIN16AnswerOnPauseController:InitWidget()
  self.contentText = self:GetUIComponent("UILocalizedTMP", "ContentText")
  self:SetFontMat(self.contentText, "uieff_n16_ingame_pause.mat")
  self._transition = self:GetUIComponent("ATransitionComponent", "go")
  self._transition:PlayEnterAnimation(true)
end

function UIN16AnswerOnPauseController:OnHide()
  self._mat = nil
end

function UIN16AnswerOnPauseController:NextButtonOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN16PauseClick, true)
  self:CloseDialog()
end

function UIN16AnswerOnPauseController:QuitButtonOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN16PauseClick, false)
  self:CloseDialog()
end

function UIN16AnswerOnPauseController:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if not res then
    return
  end
  self._mat = res
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end
