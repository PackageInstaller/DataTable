_class("UIWidgetTrapSkillItem", UICustomWidget)
UIWidgetTrapSkillItem = UIWidgetTrapSkillItem

function UIWidgetTrapSkillItem:OnShow()
  self.enableFakeInput = true
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._selectImage = self:GetUIComponent("Image", "select")
  self._frame = self:GetUIComponent("Image", "frame")
end

function UIWidgetTrapSkillItem:OnHide()
end

function UIWidgetTrapSkillItem:Init(index, skillID, callBack)
  self._index = index
  self._callBack = callBack
  local activeSkillData = BattleSkillCfg(skillID)
  self._icon:LoadImage(activeSkillData.Icon)
end

function UIWidgetTrapSkillItem:OnSelect(visible, canCast)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetTrapSkillItem",
    input = "OnSelect",
    args = {visible, canCast}
  })
  self._selectImage.gameObject:SetActive(visible)
  self._frame.gameObject:SetActive(not canCast)
end

function UIWidgetTrapSkillItem:buttonBgOnClick(go)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetTrapSkillItem",
    input = "buttonBgOnClick",
    args = {}
  })
  if self._callBack then
    self._callBack(self._index)
  end
end
