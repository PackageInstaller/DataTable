local AlchemyDecomposeItemView, Super = NewClass("AlchemyDecomposeItemView", AlchemyDecomposeBaseView)

function AlchemyDecomposeItemView:ctor()
  Super.ctor(self)
  AlchemyDecomposeItemView.uiResCls = UI_Alchemy_Popup_ResolveWeapon_OptimizeResource
  self.model = AlchemyDecomposeItemExtModel.Instance
  self.mainModel = AlchemyMainExtModel.Instance
  self.model:OnInit()
end

function AlchemyDecomposeItemView:OnEnterView()
  Super.OnEnterView(self)
  if self.ui.Toggle_All then
    self.ui.Toggle_All:SetActive(false)
  end
  if self.ui.SelNum then
    self.ui.SelNum:SetActive(false)
  end
  self:_OnInitJumpToFormula()
end

function AlchemyDecomposeItemView:RefreshOnRendered()
  self.model:SetCurSelectItemUidGroup({})
  self.model:Set_curSelectUid(0, true)
  self.model:Update_curDecompositeList()
  self:RefreshView()
end

function AlchemyDecomposeItemView:_OnInitJumpToFormula()
  local jumpToConversionTid = self.mainModel:Get_jumpToItemTid()
  if not jumpToConversionTid or 0 == jumpToConversionTid then
    return
  end
  local oriLit = self.model.oriLit
  if not oriLit then
    return
  end
  local jumpIdx
  for idx, data in ipairs(oriLit) do
    if data.conversionId == jumpToConversionTid then
      self.model:Set_curSelectUid(data.itemUid)
      jumpIdx = idx
      break
    end
  end
  if jumpIdx and self.oriListView then
    if self.oriListView.isReady then
      local offset = self.oriListView:GetOffsetByIndex(jumpIdx - 1)
      self.oriListView:SetOffset(offset, false)
    else
      function self.oriListView.reloadFinishCallback()
        self.oriListView.reloadFinishCallback = nil
        
        local offset = self.oriListView:GetOffsetByIndex(jumpIdx - 1)
        self.oriListView:SetOffset(offset, false)
      end
    end
  end
  self.mainModel:Set_jumpToItemTid(nil)
end

function AlchemyDecomposeItemView:RegisterEvents()
  Super.RegisterEvents(self)
  self:AddButtonClickListener(self.ui.Btn_Role, System.fn(self, self._OnClickRule))
end

function AlchemyDecomposeItemView:_OnClickRule()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("AlchemyDecomposeItemRuleContent"))
end

function AlchemyDecomposeItemView:GetBagCapacity()
  local limitList = DT.GetOriginalConstant("BagCapacity")
  return limitList and limitList[3] or 0
end

function AlchemyDecomposeItemView:CheckCanAddDecompose(uid)
  local decompositeData = self.model:GetDecompositeDataByUid(uid)
  if not decompositeData then
    return true
  end
  local haveNum = ItemDataUtils.GetItemNum(decompositeData.itemTid)
  local selectNum = self.model:GetSelectCountByUid(uid)
  return haveNum <= selectNum
end

function AlchemyDecomposeItemView:OnDecompositeClick()
  if not self:CanDecomposite() then
    Alert.ShowStr(LT.Text("ChooseItemForDecompose"))
    return
  end
  
  local function confirmCb()
    local decomposeItemCountMap = {}
    for _, uid in ipairs(self.model.curSelectItemUidGroup) do
      decomposeItemCountMap[uid] = (decomposeItemCountMap[uid] or 0) + 1
    end
    AlchemyDataUtils.DecomposeList(decomposeItemCountMap)
    self.model:SetCurSelectItemUidGroup({})
    self.model:SetIsSelectAll(false)
    self.model:Set_curSelectUid(0, true)
    self.model:SetDecomposedItemUidGroup({})
    self.model:UpdateData()
    self:RefreshView()
  end
  
  UIManager.Instance:Reopen(Urls.AlchemyDecomposeConfirmView, confirmCb, self.model)
end

function AlchemyDecomposeItemView:OnToggleAll(isOn)
end

return AlchemyDecomposeItemView
