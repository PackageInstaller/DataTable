local UIBattleCounterAwakerPanel, Super = System.NewClass("UIBattleCounterAwakerPanel", UIBasePanel)
UIBattleCounterAwakerPanel.uiResCls = UI_Battle_Tip_CounterAwakerResource

function UIBattleCounterAwakerPanel:ctor(tagTidList)
  Super.ctor(self)
  self.tagTidList = tagTidList
end

function UIBattleCounterAwakerPanel:OnBind(binder)
  self.binder = binder
  self:BindTagCounterAwakwers()
  binder:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self.OnTouchBegin))
  binder:BindEvent(EventMgr.Instance.TouchEndEvent, System.fn(self, self.OnTouchEnd))
end

function UIBattleCounterAwakerPanel:OnTouchBegin(x, y)
  self.touchBeginX = x
  self.touchBeginY = y
  print("OnTouchBegin", x, y)
end

function UIBattleCounterAwakerPanel:OnTouchEnd(x, y)
  if not self.touchBeginX or not self.touchBeginY then
    return
  end
  self.touchEndX = x
  self.touchEndY = y
  if math.abs(self.touchBeginX - self.touchEndX) < 10 or math.abs(self.touchBeginY - self.touchEndY) < 10 then
    self:Close()
  end
  self.touchBeginX = nil
  self.touchBeginY = nil
  self.touchEndX = nil
  self.touchEndY = nil
end

function UIBattleCounterAwakerPanel:BindTagCounterAwakwers()
  local parent = self.ui.Group_CounterAwaker.transform
  local baseGameObj = self.ui.Item_CounterAwaker
  if 0 == #self.tagTidList then
    self.binder:SetActive(baseGameObj, false)
    return
  end
  for i, tagTid in ipairs(self.tagTidList) do
    local gameObj = baseGameObj
    if i > 1 then
      gameObj = self.binder:Instantiate(baseGameObj, parent)
    end
    self.binder:SetActive(gameObj, true)
    self.binder:BindComponent(UIBattleItemCounterAwaker(gameObj, tagTid))
  end
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(parent.gameObject)
end

return UIBattleCounterAwakerPanel
