local Quaternion = CS.UnityEngine.Quaternion
local ScrollDropDownComp, Super = System.NewComponent("ScrollDropDownComp")

function ScrollDropDownComp:ctor(res, data)
  Super.ctor(self)
  self.ui = Item_Public_DropdownResource(res)
  self.data = data
  self.expand = Vue.ref(false)
  self.chosenIndex = Vue.ref(1)
  self.descendingOrder = Vue.ref(true)
end

function ScrollDropDownComp:OnBind(binder)
  self.binder = binder
  self.imageShrinkArrowTf = self.ui.Image_Shrink_Arrow.transform
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.ChangeExpand))
  binder:BindButtonClick(self.ui.Btn_Filtrate_Mask, function()
    self:ChangeExpand(false)
  end)
  binder:BindButtonClick(self.ui.Btn_Sort, function()
    self.descendingOrder.value = not self.descendingOrder.value
    if self.data.orderTypeClickCb then
      self.data.orderTypeClickCb(self.descendingOrder.value)
    end
  end)
  binder:BindToRaw(function(_, nVal)
    if not nVal then
      return
    end
    local data = self.data.datas[nVal]
    if data then
      binder:SetText(self.ui.Text_Title, data.text)
    end
  end, function()
    return self.chosenIndex.value
  end)
  binder:BindToRaw(function(_, descendingOrder)
    local rotation = descendingOrder and -90 or 90
    self.imageShrinkArrowTf.rotation = Quaternion.Euler(0, 0, rotation)
  end, function()
    return self.descendingOrder.value
  end)
  binder:BindToRaw(function(_, expanded)
    self.ui.ScrollView_Select:SetActive(expanded)
    self.ui.Btn_Filtrate_Mask:SetActive(expanded)
  end, function()
    return self.expand.value
  end)
  self:BindScrollView()
end

function ScrollDropDownComp:BindScrollView()
  local binder = self.binder
  binder:BindToCircularListView(self.ui.ScrollView_Select, function()
    return self.data.datas
  end, function(itemBinder, obj, index)
    local data = self.data.datas[index]
    
    local function clickCb(itemIndex)
      if self.data.itemClickCb then
        self.data.itemClickCb(itemIndex)
      end
      self.chosenIndex.value = itemIndex
      self:ChangeExpand()
    end
    
    itemBinder:BindComponent(ScrollDropDownItem(obj, data, clickCb))
  end)
end

function ScrollDropDownComp:ChangeExpand(state)
  if nil ~= state then
    self.expand.value = state
    return
  end
  self.expand.value = not self.expand.value
end

return ScrollDropDownComp
