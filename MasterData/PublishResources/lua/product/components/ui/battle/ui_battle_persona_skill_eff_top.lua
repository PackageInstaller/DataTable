_class("UIBattlePersonaSkillEffTop", UIController)
UIBattlePersonaSkillEffTop = UIBattlePersonaSkillEffTop

function UIBattlePersonaSkillEffTop:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIBattlePersonaSkillEffTop:OnShow(uiParams)
  self:InitWidget()
  self._tarCamera = uiParams[1]
  self._petImgRes = uiParams[2]
  self._petWordStr = uiParams[3]
  self._showCloseBtn = uiParams[4]
  self._animName = uiParams[5]
  self:SetCamera(self._tarCamera)
  if self._petWordStr then
    self._petWordText:SetText(StringTable.Get(self._petWordStr))
  end
  if self._petImgRes then
    self._petHeadLoader:LoadImage(self._petImgRes)
  end
  if self._showCloseBtn then
    self.closeBtnGo:SetActive(true)
  else
    self.closeBtnGo:SetActive(false)
  end
  if self._animName and self._anim then
    self._anim:Play(self._animName)
  end
end

function UIBattlePersonaSkillEffTop:InitWidget()
  self._petWordText = self:GetUIComponent("UILocalizationText", "PetWord")
  self._uiCanvas = self:GetUIComponent("Canvas", "UICanvas")
  self._petHeadLoader = self:GetUIComponent("RawImageLoader", "PetHead")
  self._anim = self:GetUIComponent("Animation", "UIBattlePersonaSkillEffTop")
  self.closeBtnGo = self:GetGameObject("CloseButton")
end

function UIBattlePersonaSkillEffTop:CloseButtonOnClick(go)
  Log.debug("###[UIBattlePersonaSkillEffTop] close btn !")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN19P5SkipBigView)
  self:CloseDialog()
end

function UIBattlePersonaSkillEffTop:SetCamera(camera)
  if self._uiCanvas and camera then
    self._uiCanvas.worldCamera = camera
  end
end
