local AwakerPotencyState = CommonDefine.AwakerPotencyState
local RedType = RedPointDataUtils.RedType
local RedDotType = CommonDefine.RedDotType
local AwakerPotencyListItem, Super = System.NewComponent("AwakerPotencyListItem")

function AwakerPotencyListItem:ctor(obj, res, data)
  Super.ctor(self)
  self.ui = res(obj)
  self.selected = Vue.ref(false)
  self.potencyModel = data.potencyModel
  self.potency = data.potency
  self.index = data.index
  self.callback = data.clickCb
end

function AwakerPotencyListItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick), nil, nil, function()
    return self.potency ~= self.potencyModel.selectPotency
  end)
  binder:BindToVisible(self.ui.Image_Select, function()
    return self.potency == self.potencyModel.selectPotency
  end)
  binder:BindToVisible(self.ui.Image_Lock, function()
    if not AwakerDataUtils.HasOwnedAwaker(self.potencyModel.selectAwakerId) and not table.next(DataCenter.awakerData.mockAwakerMap) then
      return true
    end
    local potencyState = self.potencyModel:GetPotencyActiveState(self.index)
    return potencyState ~= AwakerPotencyState.Active
  end)
  binder:BindToText(self.ui.Text_Name, function()
    local mode = self.potencyModel.mode
    local potencyName = self.potencyModel:GetPotencyName(self.potency, mode)
    return potencyName
  end)
  binder:BindToTextColor(self.ui.Text_Name, function()
    local potencyState = self.potencyModel:GetPotencyActiveState(self.index)
    if potencyState == AwakerPotencyState.Active then
      return CommonDefine.ColorType.Light
    end
    return CommonDefine.ColorType.Dark
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    local potency = self.potency
    do return self.potencyModel.GetPotencyIconPath, self.potencyModel end
    return self.potencyModel.GetPotencyIconPath, self.potencyModel, potency
  end)
  self:_BindPotencyRedComp()
end

function AwakerPotencyListItem:_BindPotencyRedComp()
  local isFirstOpen = true
  self.binder:BindToRaw(function(cbinder, redValue)
    local delayTime = CommonDefine.AwakerRedUpdateDelay + 0.1
    if not redValue then
      delayTime = 0
    end
    if isFirstOpen then
      isFirstOpen = false
      delayTime = 0
    end
    cbinder:BindTimer(delayTime, 0, nil, function()
      cbinder:BindComponent(RedDotComponent(self.ui.Com_RedDot, RedDotType.Dot, nil, function()
        return redValue
      end))
    end)
  end, function()
    do return self._GetAttrPotencyRed end
    return self._GetAttrPotencyRed, self
  end)
end

function AwakerPotencyListItem:_GetAttrPotencyRed()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return false
  end
  local awakerTid = self.potencyModel.selectAwakerId
  if self.index ~= self.potencyModel.nextActivePotencyIndex then
    return false
  end
  do return RedPointDataUtils.GetRedPointState, RedType.AwakerPotency end
  return RedPointDataUtils.GetRedPointState, RedType.AwakerPotency, {awakerTid}, awakerTid
end

function AwakerPotencyListItem:OnClick()
  if not self.callback then
    return
  end
  self.callback(self.potency, self.index)
end

return AwakerPotencyListItem
