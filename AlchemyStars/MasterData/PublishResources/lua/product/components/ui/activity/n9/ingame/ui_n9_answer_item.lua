_class("UIN9AnswerItem", UICustomWidget)
UIN9AnswerItem = UIN9AnswerItem

function UIN9AnswerItem:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.OnN9SelectClick, self._ShowOnError)
end

function UIN9AnswerItem:OnHide()
  self:DetachEvent(GameEventType.OnN9SelectClick, self._ShowOnError)
end

function UIN9AnswerItem:InitWidget()
  self.selet = self:GetUIComponent("RawImage", "Selet")
  self.option = self:GetUIComponent("UILocalizationText", "Option")
  self.content = self:GetUIComponent("UILocalizationText", "Content")
  self.isRight = self:GetGameObject("IsRight")
  self.isError = self:GetGameObject("IsError")
  self.noContentMask = self:GetGameObject("NoContentMask")
  self.mask = self:GetGameObject("Mask")
  self.aniObj = self:GetGameObject("kuang1")
  self.aniObj1 = self:GetGameObject("kuang2")
  self.anim = self:GetUIComponent("Animation", "go")
end

function UIN9AnswerItem:Refresh(data)
  self.option:SetText(self:GetOption())
  self.content:SetText(data)
  self.noContentMask:SetActive(not data)
  self.isRight:SetActive(false)
  self.isError:SetActive(false)
  self.mask:SetActive(false)
  self:SetColorDefault()
  if data == "" or not data then
    self.selet.color = Color(0.66, 0.66, 0.66, 1)
  end
end

function UIN9AnswerItem:SetData(nIndex, callback)
  self._onClickCallback = callback
  self._index = nIndex
end

function UIN9AnswerItem:SeletOnClick(go)
  if self._onClickCallback then
    self._onClickCallback(self._index)
  end
end

function UIN9AnswerItem:_ShowOnError(rightIndex, seletIndex)
  self.isRight:SetActive(rightIndex == self._index)
  self.isError:SetActive(seletIndex == self._index and rightIndex ~= self._index)
  self.mask:SetActive(seletIndex == self._index and rightIndex ~= self._index)
  self.aniObj:SetActive(seletIndex == self._index)
  self.aniObj1:SetActive(seletIndex == self._index)
  if seletIndex == self._index and rightIndex ~= self._index then
    self.anim:Play("uieff_AnswerItem_SelectWrong")
  end
  if rightIndex == self._index then
    self.anim:Play("uieff_AnswerItem_SelectRight")
  end
  if seletIndex ~= self._index and rightIndex ~= self._index then
    self.selet.color = Color(0.66, 0.66, 0.66, 1)
  end
  if self._index == seletIndex then
    if seletIndex == rightIndex then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameSuccess)
    else
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameFail)
    end
  end
end

function UIN9AnswerItem:GetOption()
  local op = ""
  if self._index == 1 then
    op = "A"
  elseif self._index == 2 then
    op = "B"
  elseif self._index == 3 then
    op = "C"
  elseif self._index == 4 then
    op = "D"
  end
  return op
end

function UIN9AnswerItem:SetColorDefault()
  self.selet.color = Color(1, 1, 1, 1)
end
