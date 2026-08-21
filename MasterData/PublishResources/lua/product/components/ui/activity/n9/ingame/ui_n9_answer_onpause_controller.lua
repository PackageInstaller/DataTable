_class("UIN9AnswerOnPauseController", UIController)
UIN9AnswerOnPauseController = UIN9AnswerOnPauseController

function UIN9AnswerOnPauseController:OnShow(uiParams)
  self:InitWidget()
end

function UIN9AnswerOnPauseController:InitWidget()
  self.contentText = self:GetUIComponent("UILocalizedTMP", "ContentText")
  self:SetFontMat(self.contentText, "uieff_n9_ingame_pause.mat")
  self._transition = self:GetUIComponent("ATransitionComponent", "go")
  self._transition:PlayEnterAnimation(true)
end

function UIN9AnswerOnPauseController:OnHide()
end

function UIN9AnswerOnPauseController:NextButtonOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN9PauseClick, true)
  self:CloseDialog()
end

function UIN9AnswerOnPauseController:QuitButtonOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN9PauseClick, false)
  self:CloseDialog()
end

function UIN9AnswerOnPauseController:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end
