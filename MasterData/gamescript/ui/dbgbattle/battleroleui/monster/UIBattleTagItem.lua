local UIBattleTagItem, Super = System.NewComponent("UIBattleTagItem")
UIBattleTagItem.uiResCls = UI_Battle_TagResource

function UIBattleTagItem:ctor(uiNode, tagTid, tagList)
  Super.ctor(self)
  self.gameObj = uiNode
  self.ui = UIBattleTagItem.uiResCls(uiNode)
  self.tagTid = tagTid
  self.tagConfig = CopyDataUtils.GetTagConfig(tagTid)
  self.tagList = tagList
end

function UIBattleTagItem:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Tag, LT.Text(self.tagConfig.TagName))
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
end

function UIBattleTagItem:GetSize()
  local x = self.binder:GetTextPreferredWH(self.ui.Text_Tag)
  return x + 22, 35
end

function UIBattleTagItem:OnClick()
  if UIManager.Instance:GetWindow(Urls.UIBattleCounterAwakerPanel) then
    UIManager.Instance:CloseByUrl(Urls.UIBattleCounterAwakerPanel)
    return
  end
  UIManager.Instance:Reopen(Urls.UIBattleCounterAwakerPanel, self.tagList)
end

return UIBattleTagItem
