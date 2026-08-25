local CommonApproachItem, Super = System.NewComponent("CommonApproachItem")

function CommonApproachItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Common_Item_ExchangeResource(uiNode)
  self.itemGetsId = data.itemGetsId
  self.clickCb = data.clickCb
  self.itemTid = data.itemTid
  self.justShow = data.justShow or false
  self.itemGetsConfig = DT.ItemGets[self.itemGetsId]
  self.banClick = false
end

function CommonApproachItem:OnBind(binder)
  binder:BindEvent(EventMgr.Instance.CommonTipsCloseEvent, function()
    self.banClick = true
  end)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.JumpToFunc))
  binder:BindToText(self.ui.Text_Name, function()
    return self.itemGetsConfig and self.itemGetsConfig.Desc or ""
  end)
  binder:BindToTextColor(self.ui.Text_Name, function()
    if FuncJumpManager.Instance:CanJump(self.itemGetsId, self.itemTid) then
      return CommonDefine.ColorType.Light
    end
    return CommonDefine.ColorType.Dark
  end)
  binder:BindToVisible(self.ui.Group_Select, function()
    do return FuncJumpManager.Instance.CanJump, FuncJumpManager.Instance, self.itemGetsId end
    return FuncJumpManager.Instance.CanJump, FuncJumpManager.Instance, self.itemGetsId, self.itemTid
  end)
  binder:BindToVisible(self.ui.Image_Arrow, function()
    return not self.justShow
  end)
  binder:BindToVisible(self.ui.Group_Normal, function()
    return not FuncJumpManager.Instance:CanJump(self.itemGetsId, self.itemTid)
  end)
end

function CommonApproachItem:JumpToFunc()
  if bg.IsInBattle() or SceneMgr.Instance:IsInCopies() then
    local isForbid = true
    if bg.IsInBattle() and BattleManager.Instance:IsFinished() then
      isForbid = false
    end
    if isForbid then
      Alert.ShowStr("BacktrackCannotSkipTips")
      return
    end
  end
  if not self.justShow and not self.banClick then
    FuncJumpManager.Instance:JumpFunc(self.itemGetsId, self.itemTid)
    if FuncJumpManager.Instance:CanJump(self.itemGetsId, self.itemTid) and self.clickCb then
      self.clickCb()
    end
  end
end

return CommonApproachItem
