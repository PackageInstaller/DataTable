_class("UIWidgetPopStarNum", UICustomWidget)
UIWidgetPopStarNum = UIWidgetPopStarNum

function UIWidgetPopStarNum:Constructor()
end

function UIWidgetPopStarNum:OnShow()
  self._anim = self:GetUIComponent("Animation", "UIWidgetPopStarNum")
  self._root = self:GetGameObject("root")
  self._selectRect = self:GetUIComponent("RectTransform", "root")
  self._txtNormalGridCount = self:GetUIComponent("UILocalizationText", "txtNormalGridCount")
  self._txtSuperGridCount = self:GetUIComponent("UILocalizationText", "txtSuperGridCount")
  self._goLeftParenthesis = self:GetGameObject("txtLeftParenthesis")
  self._goAdd = self:GetGameObject("txtAdd")
  self._goSuperGridCount = self:GetGameObject("txtSuperGridCount")
  self._goRightParenthesis = self:GetGameObject("txtRightParenthesis")
  self:SetSuperGridVisible(false)
end

function UIWidgetPopStarNum:OnHide()
end

function UIWidgetPopStarNum:SetSuperGridVisible(visible)
  self._goLeftParenthesis:SetActive(visible)
  self._goAdd:SetActive(visible)
  self._goSuperGridCount:SetActive(visible)
  self._goRightParenthesis:SetActive(visible)
end

function UIWidgetPopStarNum:Init(normalGridNum, superGridNum)
  self:GetGameObject():SetActive(true)
  self._txtNormalGridCount:SetText(tostring(normalGridNum))
  if superGridNum and 0 < superGridNum then
    self._txtSuperGridCount:SetText(tostring(superGridNum))
    self:SetSuperGridVisible(true)
  else
    self:SetSuperGridVisible(false)
  end
end

function UIWidgetPopStarNum:HideNum()
  GameGlobal.TaskManager():StartTask(function(TT)
    self._anim:Play("uieff_UIWidgetPopStarNum_out")
    YIELD(TT, 500)
    self:GetGameObject():SetActive(false)
  end)
end
