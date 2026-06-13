local M = BaseClass("BagUIContext", BaseContext)
local MessageId = Proto.MessageId

function M:Init()
    self.m_useItemEvent = EventMgr:AddListener(UIMessageNames.BAG_USE_ITEM, Bind(self, self._UseItem))
    self.m_freeUseItemEvent = EventMgr:AddListener(UIMessageNames.BAG_FREE_USE_ITEM, Bind(self, self._UseItem))
end

--打开背景的时候，默认选择的页签
function M:Open(initTab)
    if initTab == 0 then initTab = 1 end

    OtakuFurniturDataMgr:GetFurnituresByPage(-1, function(list)
        local allItems = ItemHelper.GetBagItems(false, list)
        self:_Show(initTab, allItems)
    end)
end

function M:OnClose()
    if self.m_rsUseLimitTimeItem then
        local msgId = MessageId.ResponseUseLimitTimeItem
        NetPack:UnRegistResponse(msgId, self.m_rsUseLimitTimeItem)
        self.m_rsUseLimitTimeItem = nil
    end
    M.super.OnClose(self)
end

--使用道具 just for decompose
function M:_UseItem(packageId, number, indexArr, isLimitItem)
    local itemData = ItemDataMgr:GetInstance():GetItemByPackageId(packageId, isLimitItem)
    if not itemData then
        Logger.LogError("itemData is nil, packageId = " .. tostring(packageId))
        return
    end
    if indexArr and #indexArr > 0 then
        ItemHelper.UseFreeItem(itemData.Id, number, indexArr, ItemHelper.RefreshBag)
        return
    end

    -- 使用限时道具
    if isLimitItem then
        if itemData:IsVaild() then
            self:_RqUseLimitTimeItem({ Id = packageId, Count = number })
        else
            GameHelper.TipsById(10108) -- 道具已失效
        end
        return
    end

    local decompose = itemData:IsDecompose()
    ItemHelper.UseItem(itemData.Id, number, decompose, number, ItemHelper.RefreshBag)
end

-- 使用限时道具
function M:_RqUseLimitTimeItem(request)
    if self.m_rsUseLimitTimeItem then return end

    local limit = EnergyMgr:GetInstance():MaxEnergyLimit()
    local energy = EnergyMgr:GetInstance():EnergyValue()
    if energy >= limit then
        GameHelper.TipsById(5216)
        return
    end

    local msgId = MessageId.ResponseUseLimitTimeItem
    local infoHandler = Bind(self, self.OnRsUseLimitTimeItem)
    self.m_rsUseLimitTimeItem = NetPack:RegistResponse(msgId, infoHandler)
    NetPack:SendMessage(MessageId.RequestUseLimitTimeItem, request)
end

function M:OnRsUseLimitTimeItem(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsUseLimitTimeItem)
    self.m_rsUseLimitTimeItem = nil

    if result ~= 0 then return end

    local itemData = ItemDataMgr:GetInstance():GetItemByPackageId(msg.Id, true)
    local itemCfg = itemData:GetItemCfg()
    local value = itemCfg.effectArgs[0] * msg.Count
    local tips = ConfigHelper.GetLocalString(5185)
    -- 使用成功，增加体力%d
    GameHelper.Tips(string.format(tips, value))
    ItemHelper.RefreshBag()
end

return M
