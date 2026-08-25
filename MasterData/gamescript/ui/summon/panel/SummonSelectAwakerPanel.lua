local SummonSelectAwakerPanel, Super = System.NewClass("SummonSelectAwakerPanel", UIBasePanel)
SummonSelectAwakerPanel.uiResCls = UI_Bag_Obtain_Awaken_TipsResource

function SummonSelectAwakerPanel:ctor(viewData)
  self.confirmFunc = viewData.confirmFunc
  self.selectItemTid = viewData.selectItemTid
  self.poolTid = viewData.poolTid
end

function SummonSelectAwakerPanel:OnBind(binder)
  self.binder = binder
  self:_BindEvent()
  self:_UpdateViewData()
  self:_RefreshView()
end

function SummonSelectAwakerPanel:_BindEvent()
  self.binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self.binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self._OnClickCancel))
  self.binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
end

function SummonSelectAwakerPanel:_OnClickCancel()
  local awakerTid = DT.Item[self._selectItemTid.value].SpParam[1]
  
  local function panelOpenFunc()
    local awakerBasePanelData = {}
    awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
    awakerBasePanelData.specialAwakerList = {
      AwakerDataUtils.GetAwakerData(awakerTid)
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end
  
  FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
end

function SummonSelectAwakerPanel:_OnClickConfirm()
  if self.confirmFunc then
    self.confirmFunc(self._selectItemTid.value)
  end
  self:Close()
end

function SummonSelectAwakerPanel:_UpdateViewData()
  self._awakerItemTidList = self:_GetAwakerItemTidList()
  self._selectItemTid = Vue.ref(self._awakerItemTidList[1])
end

function SummonSelectAwakerPanel:_GetAwakerItemTidList()
  local rst = DropCfgUtils.GetOneDropAwakerItemTidList(self.poolTid)
  table.sort(rst, function(a, b)
    local awakerTidA = ItemDataUtils.GetAwakerTidByItemTid(a)
    local awakerTidB = ItemDataUtils.GetAwakerTidByItemTid(b)
    local awakerCfgA = DT.AwakerConfig[awakerTidA]
    local awakerCfgB = DT.AwakerConfig[awakerTidB]
    local ownedWeightA = AwakerDataUtils.HasOwnedAwaker(awakerTidA) and 0 or 1
    local ownedWeightB = AwakerDataUtils.HasOwnedAwaker(awakerTidB) and 0 or 1
    if ownedWeightA ~= ownedWeightB then
      return ownedWeightA > ownedWeightB
    end
    local qualitSortWeightA = CommonDefine.QualitySortID[awakerCfgA.Quality]
    local qualitSortWeightB = CommonDefine.QualitySortID[awakerCfgB.Quality]
    if qualitSortWeightA ~= qualitSortWeightB then
      return qualitSortWeightA > qualitSortWeightB
    end
    local schoolTypeA = AwakerCfgUtils.GetAwakerSchoolType(awakerTidA)
    local schoolTypeB = AwakerCfgUtils.GetAwakerSchoolType(awakerTidB)
    local schoolTypeWeightA = CommonDefine.ShoolTypeSortWeight[schoolTypeA]
    local schoolTypeWeightB = CommonDefine.ShoolTypeSortWeight[schoolTypeB]
    if schoolTypeWeightA ~= schoolTypeWeightB then
      return schoolTypeWeightA > schoolTypeWeightB
    end
    local potencyLevelA = AwakerDataUtils.GetAwakerPotencyLevel(awakerTidA)
    local potencyLevelB = AwakerDataUtils.GetAwakerPotencyLevel(awakerTidB)
    if potencyLevelA ~= potencyLevelB then
      return potencyLevelA > potencyLevelB
    end
    return awakerCfgA.BaseSortID < awakerCfgB.BaseSortID
  end)
  return rst
end

function SummonSelectAwakerPanel:_SetSelectItemTid(itemTid)
  self._selectItemTid.value = itemTid
end

function SummonSelectAwakerPanel:_RefreshView()
  self.binder:SetText(self.ui.Text_C_Title, LT.Text("Formation_SelectRole_Title_String"))
  self.binder:BindToCircularListView(self.ui.ScrollView, function()
    return self._awakerItemTidList
  end, function(itemBinder, item, index)
    local itemTid = self._awakerItemTidList[index]
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
    local awakerCfg = DT.AwakerConfig[awakerTid]
    local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
    
    local function showTextFunc()
      do return LT.Text end
      return LT.Text, awakerCfg.Name
    end
    
    local function selectBgFunc()
      return self._selectItemTid.value == itemTid
    end
    
    local function fullAwakenFunc()
      do return ItemDataUtils.IsAwakerChipOverFlow end
      return ItemDataUtils.IsAwakerChipOverFlow, itemTid
    end
    
    local function clickFunc()
      self:_SetSelectItemTid(itemTid)
    end
    
    local function getWrongTextFunc()
      if fullAwakenFunc() then
        return ""
      end
      do return LT.Text end
      return LT.Text, "SummonSelectAwakerOwnedLabel"
    end
    
    local function wrongBgFunc()
      if fullAwakenFunc() then
        return true
      end
      do return AwakerDataUtils.HasOwnedAwaker end
      return AwakerDataUtils.HasOwnedAwaker, awakerTid
    end
    
    local itemData = {
      clickFunc = clickFunc,
      awakerData = awakerData,
      selectBgFunc = selectBgFunc,
      fullAwakenFunc = fullAwakenFunc,
      showTextFunc = showTextFunc,
      getWrongTextFunc = getWrongTextFunc,
      showPotencyInfoFunc = function()
        do return AwakerDataUtils.HasOwnedAwaker end
        return AwakerDataUtils.HasOwnedAwaker, awakerTid
      end,
      wrongBgFunc = wrongBgFunc
    }
    itemBinder:BindComponent(CommonAwakerListItem(item, itemData))
  end)
end

return SummonSelectAwakerPanel
