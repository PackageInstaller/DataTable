local UIBattleItemCounterAwaker, Super = System.NewComponent("UIBattleItemCounterAwaker")
UIBattleItemCounterAwaker.uiResCls = UI_Battle_Item_CounterAwakerResource

function UIBattleItemCounterAwaker:ctor(uiNode, tagTid)
  Super.ctor(self)
  self.gameObj = uiNode
  self.ui = UIBattleItemCounterAwaker.uiResCls(uiNode)
  self.tagTid = tagTid
  self.tagConfig = CopyDataUtils.GetTagConfig(tagTid)
end

function UIBattleItemCounterAwaker:OnBind(binder)
  self.binder = binder
  self.binder:BindComponent(UIBattleTagItem(self.ui.UI_Battle_Tag, self.tagTid))
  self:BindCounterAwakers()
  self:CreateAwakerTableView()
  self.awakerTableView:ReloadData()
end

function UIBattleItemCounterAwaker:BindCounterAwakers()
  local awakerList = self.tagConfig.CounterAwaker or {}
  self.binder:SetText(self.ui.Text_TagDesc, LT.Text(self.tagConfig.TagDesc))
  if 0 == #awakerList then
    self.binder:SetActive(self.ui.Group_Awaker, false)
    self.binder:SetText(self.ui.Text_CounterAwaker, LT.Text("NoCounterTagAwaker"))
    return
  end
  self.binder:SetActive(self.ui.Group_Awaker, true)
  self.binder:SetText(self.ui.Text_CounterAwaker, LT.Text("CounterTagAwaker"))
end

function UIBattleItemCounterAwaker:CreateAwakerTableView()
  local baseGameObj = self.ui.Item_AwakerHead
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  local awakerList = self.tagConfig.CounterAwaker or {}
  self.awakerTableView = self:CreateTableview(self.ui.AwakerView, function()
    return #awakerList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local Image_Awaker = gameObj.transform:Find("Image_Awaker")
    local awakerTid = awakerList[idx]
    if Image_Awaker then
      self.binder:SetImage(Image_Awaker.gameObject, AwakerDataUtils.GetLittleIcon(awakerTid, true))
    end
    return cell
  end, function(view, index)
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

return UIBattleItemCounterAwaker
