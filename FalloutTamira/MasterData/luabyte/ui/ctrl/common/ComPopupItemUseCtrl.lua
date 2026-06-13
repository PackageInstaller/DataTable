local M = BaseClass("ComPopupItemUseCtrl", BaseUICtrl)

function M:Init()
    self.m_batch = 1
    self.m_data = nil
    self.m_curNum = 1
    self.m_maxNum = 1
    self.m_itemCfg = nil
    self.m_useLimit = GameHelper.GetParamter(345)
    self._view.btn_mask:onClick(Bind(self, self.Close)) -- GZ-6661
    self._view.btn_cancle:onClick(Bind(self, self.Close))
    self._view.btn_tips:onClick(Bind(self, self.OnClickTips))
    self._view.btn_confirm:onClick(Bind(self, self.OnClickConfirm))
    self._view.numSlider:SetChangedCallback(Bind(self, self.OnNumChanged))
end

function M:OnEnter(data)
    self.m_data = data
    self.m_itemCfg = self.m_data:GetItemCfg()
    local EffectType = BagConst.ItemEffectType
    local effectType = self.m_itemCfg.effectType
    if (effectType == EffectType.Frag) or (effectType == EffectType.Combine) then
        self.m_batch = self.m_itemCfg.effectArgs[0]
    end
    if (effectType == EffectType.MonthCard) or (effectType == EffectType.Passport) then
        self.m_useLimit = 1 -- 锵锵：月卡和通行证道具使用上限1个 23/08/10
    end
    self._view.txt_name:SetText(self.m_itemCfg.name)
    self._view.img_icon:SetItemIcon(self.m_itemCfg.id)
    self._view.txt_holdNum:SetText(tostring(self.m_data.Num))
    self.m_maxNum = math.floor(self.m_data.Num / self.m_batch)

    if self.m_maxNum > self.m_useLimit then
        self.m_maxNum = self.m_useLimit
        self._view.limitTips:SetActive(true)
        self._view.txt_limitValue:SetText(tostring(self.m_useLimit))
    else
        self._view.limitTips:SetActive(false)
    end
    self._view.numSlider:SetSliderInfo(self.m_curNum, self.m_maxNum)
end

--点击设置退出键【关闭带顶栏的popup窗口】
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnClose()
    self.m_data = nil
    self.m_batch = nil
    self.m_curNum = nil
    self.m_maxNum = nil
    self.m_itemCfg = nil
    self.m_useLimit = nil
end

function M:OnNumChanged(num)
    self.m_curNum = num
end

function M:OnClickTips(go)
    UIContextMgr:GetInstance():Show("ComPopupItemTips",
        self.m_itemCfg,
        self.m_data.Num,
        Vector2.up,
        self._view.btn_tips,
        2,
        Bind(self, self.Close)
    )
end

function M:OnClickConfirm(go)
    if (not self.m_itemCfg) or (self.m_maxNum <= 0) then return end

    local packageId = self.m_data.PackageId
    local useNum = self.m_curNum * self.m_batch
    local isLimitItem = self.m_data:IsLimitItem()
    EventMgr:Broadcast(UIMessageNames.BAG_USE_ITEM, packageId, useNum, nil, isLimitItem)
    self:Close()
end

return M
