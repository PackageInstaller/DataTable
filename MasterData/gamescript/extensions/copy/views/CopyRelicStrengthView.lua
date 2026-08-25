local StrenthNum = 1
local CopyRelicStrengthView, Super = NewClass("CopyRelicStrengthView", BaseView)
CopyRelicStrengthView.uiResCls = UI_Dbgcopy_Panel_RelicPreviewResource

function CopyRelicStrengthView:ctor(shopUid)
  Super.ctor(self)
  self.shopUid = shopUid
end

function CopyRelicStrengthView:OnEnterView()
  Super.OnEnterView(self)
  self:UpdateRelicList()
  self:RefreshView()
end

function CopyRelicStrengthView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.OnRelicEnhance, System.fn(self, self._OnRelicEnhance))
  self:AddButtonClickListener(self.ui.Btn_Close, System.fn(self, self.Close))
  self:_OnCreateTableView()
end

function CopyRelicStrengthView:_OnRelicEnhance()
  local relicList = RelicDataUtils.GetStrengthRelictList()
  if not table.next(relicList) then
    self:Close()
    return
  end
  self:UpdateRelicList()
end

function CopyRelicStrengthView:_OnClick()
end

function CopyRelicStrengthView:RefreshView()
  self:SetText(self.ui.Text_Title, LT.Textf("RelicStrengthShopTitle", StrenthNum))
  self:SetButtonState(self.ui.Btn_Close, CommonDefine.BtnType.High)
end

function CopyRelicStrengthView:UpdateRelicList()
  self._relictList = RelicDataUtils.GetStrengthRelictList()
  self.relicListView:ReloadData()
end

function CopyRelicStrengthView:_OnCreateTableView()
  self.relicListView = self:CreateTableview(self.ui.RelicView, function()
    if not self._relictList then
      return 0
    end
    return #self._relictList
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.Item_RelicPreview)
    self:_FillRelicCell(cell, index)
    return cell
  end)
  self.relicListView:ReloadData()
end

function CopyRelicStrengthView:_FillRelicCell(cell, index)
  local relicData = self._relictList[index]
  self:AddViewComponentOnce(cell.gameObject, CopyRelicStrenthItem, relicData, self.shopUid)
end

return CopyRelicStrengthView
