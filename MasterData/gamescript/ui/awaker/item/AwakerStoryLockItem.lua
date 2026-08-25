local AwakerStoryLockItem, Super = System.NewComponent("AwakerStoryLockItem")

function AwakerStoryLockItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Story_LockResource(uiNode)
  self.desc = data.desc
  self.unlock = data.unlock
end

function AwakerStoryLockItem:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Story, System.fn(self, self.OnTodoFunc))
  binder:BindToText(self.ui.Text_Story, function()
    do return LT.Text end
    return LT.Text, self.desc
  end)
  binder:BindToText(self.ui.Text_Story_Lock, function()
    do return LT.Text end
    return LT.Text, self.desc
  end)
  binder:BindToVisible(self.ui.Group_Lock, function()
    return not self.unlock
  end)
  binder:BindToVisible(self.ui.Group_Normal, function()
    return self.unlock
  end)
end

function AwakerStoryLockItem:OnTodoFunc()
end

return AwakerStoryLockItem
