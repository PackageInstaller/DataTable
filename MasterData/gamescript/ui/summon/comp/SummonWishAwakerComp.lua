local SummonWishAwakerComp, Super = System.NewComponent("SummonWishAwakerComp")
SummonWishAwakerComp.uiResCls = UI_Summon_Panel_SelectLimitResource

function SummonWishAwakerComp:ctor(uiNode, poolCfg)
  Super.ctor(self)
  self.ui = SummonWishAwakerComp.uiResCls(uiNode)
  self._awakerItemList = {}
  self.poolCfg = poolCfg
end

function SummonWishAwakerComp:OnBind(binder)
  self.binder = binder
  binder:BindZ1Button(self.ui.Btn_Choose, System.fn(self, self._OnClickChoose), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "SummonSelectAwakeBtnTips"
  end)
  binder:BindToVisible(self.ui.Btn_Choose, function()
    return not self:IsChoosedAwaker()
  end)
  binder:BindToRaw(function(_, id2SummonData)
    self:_RefreshSelectedAwakerList(id2SummonData)
  end, function()
    if not self.poolCfg then
      print("SummonWishAwakerComp:_RefreshSelectedAwakerList poolCfg is nil")
      return
    end
    print("SummonWishAwakerComp:_RefreshSelectedAwakerList is ", table.tostring(SummonDataUtils.GetId2SummonData(self.poolCfg.ID)))
    do return SummonDataUtils.GetId2SummonData end
    return SummonDataUtils.GetId2SummonData, self.poolCfg.ID, table.tostring(SummonDataUtils.GetId2SummonData(self.poolCfg.ID))
  end)
  if self.ui.Group_SelectedAwaker then
    binder:BindToVisible(self.ui.Group_SelectedAwaker, function()
      do return self.IsChoosedAwaker end
      return self.IsChoosedAwaker, self
    end)
  end
  self:BindDesc()
end

function SummonWishAwakerComp:BindDesc()
  self.binder:BindToText(self.ui.Text_SelectAwake, function()
    local selectNum = SummonDataUtils.GetWishAwakerSelectNum(self.poolCfg and self.poolCfg.ID)
    if not self:IsChoosedAwaker() then
      do return LT.Textf, "SummonType_14SelectTips" end
      return LT.Textf, "SummonType_14SelectTips", selectNum
    end
    do return LT.Textf, "SummonType_14SelectUpTips" end
    return LT.Textf, "SummonType_14SelectUpTips", selectNum
  end)
end

function SummonWishAwakerComp:_GetSortedSelectedAwakerItemTidList(id2SummonData)
  if not id2SummonData or type(id2SummonData) ~= "table" then
    return {}
  end
  local list = {}
  for itemTid, _ in pairs(id2SummonData.selectedAwakerTidMap) do
    if itemTid and (DT.Item[itemTid] or {}).BaseSortID then
      list[#list + 1] = itemTid
    end
  end
  table.sort(list, function(a, b)
    local sortA = DT.Item[a] and DT.Item[a].BaseSortID or 0
    local sortB = DT.Item[b] and DT.Item[b].BaseSortID or 0
    return sortA < sortB
  end)
  return list
end

function SummonWishAwakerComp:_RefreshSelectedAwakerList(id2SummonData)
  if not id2SummonData then
    self.binder:SetActive(self.ui.Group_SelectedAwaker, false)
    return
  end
  self.binder:SetActive(self.ui.Group_SelectedAwaker, true)
  self.binder:SetActive(self.ui.UI_Summon_Item_SelectLimit, false)
  local list = self:_GetSortedSelectedAwakerItemTidList(id2SummonData)
  local itemGo = self.ui.UI_Summon_Item_SelectLimit
  print("SummonWishAwakerComp:_RefreshSelectedAwakerList list is ", table.tostring(list))
  for i = 1, #list do
    local itemTid = list[i]
    local item = self._awakerItemList[i]
    print("SummonWishAwakerComp:_RefreshSelectedAwakerList item is ", itemTid, item)
    if not item then
      local gameObj = self.binder:Instantiate(itemGo, itemGo.transform.parent)
      self.binder:SetActive(gameObj, true)
      item = self.binder:BindComponent(SummonSelectLimitItemComp(gameObj, itemTid))
      self._awakerItemList[i] = item
    else
      item:UpdateItemTid(itemTid)
    end
  end
end

function SummonWishAwakerComp:Show()
  self.binder:SetActive(self.ui.uiNode, true)
end

function SummonWishAwakerComp:Hide()
  self.binder:SetActive(self.ui.uiNode, false)
end

function SummonWishAwakerComp:_OnClickChoose()
  local awakerItemTidList = SummonDataUtils.GetWishAwakerChoiceItemTidList(self.poolCfg and self.poolCfg.ID)
  local selectNum = SummonDataUtils.GetWishAwakerSelectNum(self.poolCfg and self.poolCfg.ID)
  local viewData = {
    poolTid = self.poolCfg and self.poolCfg.ID,
    awakerItemTidList = awakerItemTidList,
    maxSelect = selectNum,
    miniSelect = selectNum,
    confirmFunc = function(itemTidList)
      self:ChooseMultiAwakerTargets(self.poolCfg and self.poolCfg.ID, itemTidList)
    end
  }
  UIManager.Instance:Reopen(Urls.SummonSelectLimitPanel, viewData)
end

function SummonWishAwakerComp:IsChoosedAwaker()
  local id2SummonData = SummonDataUtils.GetId2SummonData(self.poolCfg and self.poolCfg.ID)
  return id2SummonData and table.next(id2SummonData) ~= nil
end

function SummonWishAwakerComp:ChooseMultiAwakerTargets(summonId, awakerTidList)
  SummonDataUtils.ReqChooseMultiAwakerTargets(summonId, awakerTidList, function()
    print("SummonWishAwakerComp:ChooseMultiAwakerTargets Success")
  end)
end

return SummonWishAwakerComp
