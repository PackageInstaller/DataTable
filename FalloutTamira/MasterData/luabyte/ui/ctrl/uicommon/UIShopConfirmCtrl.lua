-- baoruichang
-- 2022/11/24 10:21:27
-- Masquerade_Shop_Buy
local UIShopConfirmCtrl = BaseClass("UIShopConfirmCtrl", BaseUICtrl)
local M = UIShopConfirmCtrl
local mMin = math.min
local mModf = math.modf
local sfmt = string.format

function M:Init()
    self._view.ComNumSliderCtrl:SetChangedCallback(Bind(self, self._OnSliderValueChanged))
    self._view.btnMask:onClick(Bind(self, self.Close))
    self._view.btnOK:onClick(Bind(self, self._onBtnOKClick))
    self._view.btnTips:onClick(Bind(self, self.OnClickTips))
end

-- 进入UI，可传参数
function M:OnEnter(data, buyClick)
    self._data = data
    self._buyClick = buyClick
    self.selectNum = 1
    local shopItemId = data.shopItemId
    local item = ConfigHelper.GetCfgByLua("item", shopItemId)
    self._view.labName:SetText(item.name)
    self._view.labDes:SetText(item.desc)
    self._view.imgIcon:SetItemIcon(shopItemId)
    self._view.imgCost:SetItemIcon(data.costItemId)
    self._view.labCost:SetText(tostring(data.costItemNum))
    local haveConstNum = ItemDataMgr:GetInstance():GetItemNumById(data.costItemId)
    local canBuyNum = mModf(haveConstNum / data.costItemNum)
    self._maxNum = mMin(canBuyNum, data.canBuyNum)
    self._view.UIState:SetState(canBuyNum > 0 and 1 or 2)
    self._view.ComNumSliderCtrl:SetSliderInfo(1, self._maxNum, 1)
    if canBuyNum <= 0 then
        local finalItemCfg = ConfigHelper.GetCfgByLua("item", data.costItemId)
        local str = sfmt(ConfigHelper.GetLocalString(158), ConfigHelper.GetLocalString(finalItemCfg.name))
        self._view.txt_not:SetText(str)
    end
    self._view.labRemain:SetText(sfmt(ConfigHelper.GetLocalString(5798), data.canBuyNum))
    self._view.PropertyBar:Action(data.topItemId or data.costItemId)
end

function M:_OnSliderValueChanged(value)
    self.selectNum = value
    self._view.labCost:SetText(tostring(value * self._data.costItemNum))
end

function M:_onBtnOKClick()
    if self._data.canBuyNum <= 0 then
        return
    end
    if self._maxNum <= 0 then
        GameHelper.TipsById(27000308)
        return
    end
    if self._buyClick then
        self._buyClick(self.selectNum)
        self:Close()
    end
end

function M:OnClickTips()
    GameHelper.PopItem(self._data.shopItemId, 0, self._view)
end

function M:OnDispose()
    self._data = nil
    self._buyClick = nil
    self.selectNum = nil
    M.super.OnDispose(self)
end

return UIShopConfirmCtrl
