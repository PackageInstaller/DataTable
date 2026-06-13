local M = BaseClass("ComPopupEnergyCtrl", BaseUICtrl)

function M:Init()
    self.m_itemTag = 0
    self.m_useIndex = 1
    self.m_useDatas = {}
    self.m_initCount = 1
    self.m_costItemId = 0
    self.m_selectData = nil
    self.m_buyEnergyNum = 0
    self.m_remainRecTime = 0
    self.m_descFormat = "%d"
    local itemCtrl = require("UI.Ctrl.Energy.EnergyItemCtrl")
    local itemView = require("UI.View.Energy.EnergyItemView")
    self._view.node_loopList:Init(itemCtrl, itemView)
    self._view.node_mask:onClick(Bind(self, self.OnDeviceBack))
    self._view.btn_useCancel:onClick(Bind(self, self.OnDeviceBack))
    self._view.btn_buyCancel:onClick(Bind(self, self.OnDeviceBack))
    self._view.btn_useConfirm:onClick(Bind(self, self.OnUseConfirmClick))
    self._view.btn_buyConfirm:onClick(Bind(self, self.OnBuyConfirmClick))
    self._view.tgl_change:OnToggleClick(Bind(self, self.OnToggleChanged))
    self._view.numSlider:SetChangedCallback(Bind(self, self.OnNumChanged))
    self._view.node_loopList:SetCreateItemCallback(Bind(self, self.OnCreateEnergyItem))

    self.m_itemHandler = Bind(self, self.OnItemChanged)
    self.m_recHandler = Bind(self, self.OnRecEnergyTimer)
    local buyEvent = UIMessageNames.ENERGY_BUYTIMES_NOTIFY
    local changedEvent = UIMessageNames.ENERGY_CHANGED_NOTIFY
    self._energyChanged = EventMgr:AddListener(changedEvent, Bind(self, self.OnEnergyChanged))
    self._buyTimesChanged = EventMgr:AddListener(buyEvent, Bind(self, self.OnBuyTimesChanged))
end

function M:OnEnter()
    -- 防止短时间点击2次
    if self.m_initCount > 1 then return end
    self.m_initCount = self.m_initCount + 1

    local isFullEnergy = EnergyMgr:GetInstance():IsFullEnergy()
    if not isFullEnergy then
        self.m_remainRecTime = EnergyMgr:GetInstance():RemainRecTime()
        self._view.txt_recTime:SetText(TimeUtil.TimeStampToStringFormat(self.m_remainRecTime))
        self.m_recTimer = TimerManager:GetInstance():GetTimer(1, self.m_recHandler, self, false, nil, true)
        self.m_recTimer:Start()
    end

    self._view.img_icon:SetItemIcon(9)
    self._view.img_energy:SetItemIcon(9)
    self.m_descFormat = ConfigHelper.GetLocalString(30172)

    local count = self:_UpdateEnergyItems()
    local isOn = self._view.tgl_change:GetIsOn()
    local limit = EnergyMgr:GetInstance():EnergyLimit()
    local energy = EnergyMgr:GetInstance():EnergyValue()
    local remainTimes = EnergyMgr:GetInstance():RemainBuyTimes()

    self._view.txt_energy:SetText(string.format("%d/%d", energy, limit))
    self._view.txt_recTime:SetActive(not isFullEnergy)
    self._view.tgl_change:SetIsOn(not isOn)

    -- 显示的优先级顺序为：体力药水＞货币购买
    if count > 0 then
        --true:药水 false：购买
        self._view.tgl_change:SetIsOn(true)
    else
        if remainTimes > 0 then
            --1.但当玩家无任意一个体力药水时，则优先显示货币购买
            self._view.tgl_change:SetIsOn(false)
        else
            --2.当玩家即无体力药水也无货币购买次数时则优先显示体力药水
            self._view.tgl_change:SetIsOn(true)
        end
    end
end

--点击设置退出键
function M:OnDeviceBack()
    JumpMgr:GetInstance():ClearBackCommand("OpenEnergyUI")
    self:Close()
    return true
end

function M:OnClose()
    if self.m_recTimer then
        self.m_recTimer:Stop()
    end

    self.m_recTimer = nil
    self.m_initCount = nil
    self.m_selectData = nil
    self.m_buyEnergyNum = nil

    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
    EventMgr:RemoveListener(UIMessageNames.ENERGY_CHANGED_NOTIFY, self._energyChanged)
    EventMgr:RemoveListener(UIMessageNames.ENERGY_BUYTIMES_NOTIFY, self._buyTimesChanged)
    if self.m_rsUseLimitTimeItem then
        local msgId = Proto.MessageId.ResponseUseLimitTimeItem
        NetPack:UnRegistResponse(msgId, self.m_rsUseLimitTimeItem)
        self.m_rsUseLimitTimeItem = nil
    end
end

function M:OnRecEnergyTimer()
    self.m_remainRecTime = math.max(0, self.m_remainRecTime - 1)
    self._view.txt_recTime:SetText(TimeUtil.TimeStampToStringFormat(self.m_remainRecTime))

    if self.m_remainRecTime <= 0 then
        if self.m_recTimer then
            self.m_recTimer:Stop()
            self.m_recTimer = nil
        end
    end
end

function M:OnEnergyChanged()
    if self.m_recTimer then
        self.m_recTimer:Stop()
        self.m_recTimer = nil
    end

    local limit = EnergyMgr:GetInstance():EnergyLimit()
    local energy = EnergyMgr:GetInstance():EnergyValue()
    self._view.txt_energy:SetText(string.format("%d/%d", energy, limit))

    local isFullEnergy = EnergyMgr:GetInstance():IsFullEnergy()
    self._view.txt_recTime:SetActive(not isFullEnergy)
    if not isFullEnergy then
        self.m_remainRecTime = EnergyMgr:GetInstance():RemainRecTime()
        self._view.txt_recTime:SetText(TimeUtil.TimeStampToStringFormat(self.m_remainRecTime))
        self.m_recTimer = TimerManager:GetInstance():GetTimer(1, self.m_recHandler, self, false, nil, true)
        self.m_recTimer:Start()
    end

    if self.m_selectData then -- 有可用体力恢复道具
        local totalNum = self.m_selectData.TotalNum
        local tmpCfg = ConfigHelper.GetCfg("item", self.m_selectData.Id)
        --体力类型
        if tmpCfg.type == BagConst.ItemType.EIT_EnergyItem then
            --可兑换的体力
            local effectValue = tmpCfg.effectArgs[1]
            local useTimes = math.floor((1000 - energy) / effectValue)
            --最多10次
            useTimes = math.min(useTimes, 10)
            useTimes = math.min(useTimes, self.m_selectData.TotalNum)
            totalNum = useTimes
            self._view.numSlider:SetSliderInfo(1, totalNum)
        end
    end
end

function M:OnBuyTimesChanged()
    self:_InitBuyPanel()
end

function M:OnCreateEnergyItem(ctrl)
    ctrl:SetItemClickCallback(Bind(self, self.OnSelectItem))
end

function M:OnNumChanged(num)
    self.m_selectNum = num
    local value = self.m_selectData.Value
    self._view.txt_desc:SetText(string.format(self.m_descFormat, value * self.m_selectNum))
end

-- 确认使用
function M:OnUseConfirmClick(go)
    --	当未选中任意类型体力药水时则点击确认按钮无反馈；同时确认按钮为灰态
    if not self.m_selectData then return end

    local limit = EnergyMgr:GetInstance():MaxEnergyLimit()
    local energy = EnergyMgr:GetInstance():EnergyValue()
    if energy >= limit then
        GameHelper.TipsById(5216)
        return
    end

    -- 此处正常不会进判断，数量大于0才能被选中
    if self.m_selectData.TotalNum <= 0 then
        GameHelper.TipsById(30171) -- 消耗不足
        return
    end

    self.m_useDatas = {}
    for key, itemData in pairs(self.m_selectData.DataDic) do
        local itemCfg = self.m_selectData.ConfigDic[key]
        local decompose = itemCfg.decompose == 1 and true or false
        if itemData.Num > 0 then
            local data = {
                Id = itemData.Id,
                Num = itemData.Num,
                Decompose = decompose,
                PackageId = itemData.PackageId,
                ExpireTime = itemData.ExpireTime
            }
            table.insert(self.m_useDatas, data)
        end
    end

    table.sort(self.m_useDatas, function(a, b)
        if (a.ExpireTime > 0) and (b.ExpireTime > 0) then
            if (a.ExpireTime == b.ExpireTime) then
                if a.Num == b.Num then
                    -- ID从小到大
                    return a.Id < b.Id
                else
                    -- 数量从小到大
                    return a.Num < b.Num
                end
            else
                -- 限时道具先使用
                return a.ExpireTime < b.ExpireTime
            end
        else
            -- 无期限道具后使用
            return a.ExpireTime > b.ExpireTime
        end
    end)


    self.m_useIndex = 1
    local count = self.m_selectNum * self.m_selectData.Value
    if energy + count > limit then
        -- 即将超过当前可储存的体力上限，是否继续？
        local context = ConfigHelper.GetLocalString(30168)
        -- 超过的体力将被浪费
        local tips = ConfigHelper.GetLocalString(30169)
        GameHelper.Confirm(context .. "\n" .. tips, function(ok)
            if ok then
                self:_UseItems()
            end
        end)
    else
        self:_UseItems()
    end
end

-- 确认兑换
function M:OnBuyConfirmClick(go)
    local remainTimes = EnergyMgr:GetInstance():RemainBuyTimes()
    if remainTimes > 0 then
        if self._view.node_buyPanel.selectState == 2 then
            -- 消耗不足
            GameHelper.TipsById(30171)
        else
            local limit = EnergyMgr:GetInstance():MaxEnergyLimit()
            local energy = EnergyMgr:GetInstance():EnergyValue()
            if energy >= limit then
                GameHelper.TipsById(5216)
                return
            end

            local count = self.m_buyEnergyNum
            if energy + count > limit then
                -- 即将超过当前可储存的体力上限，是否继续？
                local context = ConfigHelper.GetLocalString(30168)
                -- 超过的体力将被浪费
                local tips = ConfigHelper.GetLocalString(30169)
                GameHelper.Confirm(context .. "\n" .. tips, function(ok)
                    if ok then
                        EnergyMgr:GetInstance():RqBuyEnenry()
                    end
                end)
            else
                EnergyMgr:GetInstance():RqBuyEnenry()
            end
            if self.buyCfg.costItem == 5 then
                local dataValues = { 2, self.buyCfg.costNum }
                IBuriedPointDataMgr:SubmitData(BuriedPointConst.Item5Use, dataValues)
            end
        end
    else
        -- 兑换次数不足
        GameHelper.TipsById(30170)
    end
end

function M:OnToggleChanged(isOn)
    self._view.node_usePanel:SetActive(isOn)
    self._view.node_unselect:SetActive(isOn)
    self._view.node_select:SetActive(not isOn)
    self._view.node_buyPanel:SetActive(not isOn)
    if isOn then
        self:_InitUsePanel()
    else
        self:_InitBuyPanel()
    end
end

function M:_InitBuyPanel()
    local buyTimes = EnergyMgr:GetInstance():BuyTimes()
    local buyLimit = EnergyMgr:GetInstance():BuyLimit()
    local remTimes = EnergyMgr:GetInstance():RemainBuyTimes()
    local buyId = buyTimes < buyLimit and buyTimes + 1 or buyLimit
    local buyCfg = ConfigHelper.GetCfgByLua("energyBuy", buyId) or {}
    local itemCfg = ConfigHelper.GetCfgByLua("item", buyCfg.costItem) or {}
    self.buyCfg = buyCfg
    if self.m_costItemId == 0 then
        self.m_costItemId = buyCfg.costItem
        if self.m_costItemId > 0 then
            ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
            self.m_itemTag = ItemDataMgr:GetInstance():AddItemChange(self.m_costItemId, self.m_itemHandler)
        end
    end

    self.m_buyEnergyNum = buyCfg.addEnergy
    self._view.txt_costName:SetText(itemCfg.name)
    self._view.img_costIcon:SetItemIcon(buyCfg.costItem)
    self._view.txt_costCount:SetText(tostring(buyCfg.costNum))
    self._view.txt_buyCount:SetText(tostring(buyCfg.addEnergy))
    self._view.txt_buyTimes:SetText(string.format("%d/%d", remTimes, buyLimit))

    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(buyCfg.costItem)
    if itemNum >= buyCfg.costNum and remTimes > 0 then
        -- 道具足够，次数足够
        self._view.node_buyPanel:SetState(1)
    elseif itemNum < buyCfg.costNum and remTimes > 0 then
        -- 道具不足，次数足够
        self._view.node_buyPanel:SetState(2)
    elseif itemNum >= buyCfg.costNum and remTimes <= 0 then
        -- 道具足够，次数不足
        self._view.node_buyPanel:SetState(3)
    else
        -- 都不足
        self._view.node_buyPanel:SetState(4)
    end
end

function M:_InitUsePanel()
    self.m_selectData = nil
    local count = self:_UpdateEnergyItems() -- 玩家体力道具数量
    if count > 0 then
        self._view.node_usePanel:SetState(1)
    else
        self._view.node_usePanel:SetState(2)
    end
    self._view.node_loopList:SetDataList(self.m_itemList)
    self._view.txt_desc:SetActive(false)
    self:OnSelectItem(self.m_selectData)
    self._view.node_layout.enabled = true
end

-- 无法选中未拥有类型的药水
function M:OnSelectItem(selectData)
    if not selectData or selectData.TotalNum <= 0 then return end

    if self.m_selectData then
        self.m_selectData.IsSelect = false
    end
    self.m_selectData = selectData
    self.m_selectData.IsSelect = true
    self._view.txt_desc:SetActive(true)
    self._view.node_loopList:UpdateList()

    local totalNum = self.m_selectData.TotalNum
    local tmpCfg = ConfigHelper.GetCfg("item", self.m_selectData.Id)
    --体力类型
    if tmpCfg.type == BagConst.ItemType.EIT_EnergyItem then
        --可兑换的体力
        local effectValue = tmpCfg.effectArgs[1]
        local energy = EnergyMgr:GetInstance():EnergyValue()
        local useTimes = math.floor((1000 - energy) / effectValue)
        --最多10次
        useTimes = math.min(useTimes, self.m_selectData.TotalNum)
        useTimes = math.min(useTimes, 10)
        totalNum = useTimes
    end

    self._view.numSlider:SetSliderInfo(1, totalNum)
end

-- 刷新体力恢复数据，返回体力恢复道具数量
function M:_UpdateEnergyItems()
    local types = { BagConst.ItemType.EIT_EnergyItem }
    local itemDatas = ItemDataMgr:GetInstance():GetAllItemDatas(types)
    local dataDic = {}
    for i = 0, itemDatas.Count - 1, 1 do
        local itemData = itemDatas[i]
        local itemCfg = itemData:GetItemCfg()
        if itemCfg.type == BagConst.ItemType.EIT_EnergyItem then
            local efcArg = itemCfg.effectArgs[0]
            local data = dataDic[efcArg]
            local pid = itemData.PackageId
            local key = itemData.Id .. "_" .. pid -- 永久和限时 pid 可能重复
            if not data then
                data = {
                    Id = itemData.Id,
                    PackageId = pid,
                    TotalNum = 0,
                    DataDic = {},
                    ConfigDic = {},
                    Value = efcArg,
                    IsSelect = false,
                }
                dataDic[efcArg] = data
            end

            if itemData:IsVaild() then
                data.TotalNum = data.TotalNum + itemData.Num
            end
            if not data.DataDic[key] then
                data.DataDic[key] = itemData
                data.ConfigDic[key] = itemCfg
            end
        end
    end

    local allCount = 0
    self.m_itemList = {}
    for _, value in pairs(dataDic) do
        allCount = allCount + value.TotalNum
        table.insert(self.m_itemList, value)
    end

    table.sort(self.m_itemList, function(a, b)
        return a.Value < b.Value
    end)

    -- 选中第一个有效道具
    for _, value in ipairs(self.m_itemList) do
        if value.TotalNum > 0 then
            value.IsSelect = true
            self.m_selectData = value
            break
        end
    end

    return allCount
end

function M:_UseItems()
    local curStamp = TimeUtil.GetNowTimeStamp()
    local value = self.m_useDatas[self.m_useIndex]
    -- 是否在有效期
    if value and ((value.ExpireTime == 0) or (value.ExpireTime > curStamp)) then
        local num = value.Num
        local useCnt = 0
        if self.m_selectNum >= num then
            useCnt = num
        else
            useCnt = self.m_selectNum
        end
        self:_RqUseLimitTimeItem({
            Id = value.PackageId,
            Count = useCnt
        })
    else
        self.m_useIndex = self.m_useIndex + 1
        -- 道具已失效
        GameHelper.TipsById(10108)
        local len = #self.m_useDatas
        if (self.m_useIndex > len) or (self.m_selectNum <= 0) then
            self:_InitUsePanel()
        else
            self:_UseItems()
        end
    end
end

function M:OnItemChanged()
    self:_InitBuyPanel()
end

-- 使用限时道具
function M:_RqUseLimitTimeItem(request)
    if self.m_rsUseLimitTimeItem then return end

    local msgId = Proto.MessageId.ResponseUseLimitTimeItem
    local infoHandler = Bind(self, self.OnRsUseLimitTimeItem)
    self.m_rsUseLimitTimeItem = NetPack:RegistResponse(msgId, infoHandler)
    NetPack:SendMessage(Proto.MessageId.RequestUseLimitTimeItem, request)
end

function M:OnRsUseLimitTimeItem(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsUseLimitTimeItem)
    self.m_rsUseLimitTimeItem = nil
    self.m_useIndex = self.m_useIndex + 1
    if result ~= 0 then return end

    self.m_selectNum = self.m_selectNum - msg.Count
    local itemData = ItemDataMgr:GetInstance():GetItemByPackageId(msg.Id, true)
    local itemCfg = itemData:GetItemCfg()
    local value = itemCfg.effectArgs[0] * msg.Count
    local tips = ConfigHelper.GetLocalString(5185)
    -- 使用成功，增加体力%d
    GameHelper.Tips(string.format(tips, value))

    local len = #self.m_useDatas
    local isFullEnergy = EnergyMgr:GetInstance():IsFullEnergy()
    if (self.m_useIndex > len) or (self.m_selectNum <= 0) or isFullEnergy then
        self:_InitUsePanel()
    else
        self:_UseItems()
    end
end

return M
