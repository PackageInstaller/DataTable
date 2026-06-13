local M = BaseClass("ItemDataMgr", Singleton)
local tInsert = table.insert

function M:__init()
    ItemHelper.isHideItem = nil
    self.m_itemChangedTag = 0 -- 自增数
    self.m_itemChangedFun = {} -- 所有监听道具数量变化回调函数
    self.m_itemFuncTagDic = {} -- 回调函数Tag对应itemid
    self.m_notifyHandler = Bind(self, self.OnNotifyItemModify)
    IItemDataMgr:RegisterItemNotify(self.m_notifyHandler)
end

function M:Cleanup()

end

function M:Dispose()
    if self.m_rsUseItem then
        local messageId = Proto.MessageId.ResponseUseItem
        NetPack:UnRegistResponse(messageId, self.m_rsUseItem)
        self.m_rsUseItem = nil
    end
    IItemDataMgr:UnRegisterItemNotify(self.m_notifyHandler)
    self.m_notifyHandler = nil
    self.m_itemChangedTag = nil
    self.m_itemChangedFun = nil
    self.m_itemFuncTagDic = nil
end

function M:OnNotifyItemModify(itemId, oldNum, newNum)
    local hanlders = self.m_itemChangedFun[itemId]

    if not hanlders then return end

    for _, func in pairs(hanlders) do
        func(itemId, oldNum, newNum)
    end
end

function M:AddItemChange(itemId, onChange)
    if not (itemId > 0) or not onChange then return 0 end

    local hanlders = self.m_itemChangedFun[itemId]
    if not hanlders then
        hanlders = {}
        self.m_itemChangedFun[itemId] = hanlders
    end

    -- 同一个函数和id不能重复监听
    for _, handler in pairs(hanlders) do
        if handler == onChange then return end
    end

    self.m_itemChangedTag = self.m_itemChangedTag + 1
    self.m_itemFuncTagDic[self.m_itemChangedTag] = itemId
    hanlders[self.m_itemChangedTag] = onChange
    return self.m_itemChangedTag
end

function M:RemoveItemChange(itemId, onChange)
    if not itemId or not onChange or not (itemId > 0) then return end

    local handlers = self.m_itemChangedFun[itemId]
    if not handlers then return end
    for i, handler in pairs(handlers) do
        if handler == onChange then
            handlers[i] = nil
            return
        end
    end
end

function M:RemoveItemChangeByTag(tag)
    if not tag or not (tag > 0) then return end

    local itemId = self.m_itemFuncTagDic[tag]
    self.m_itemFuncTagDic[tag] = nil
    if not itemId or not (itemId > 0) then return end
    local hanlders = self.m_itemChangedFun[itemId]
    if hanlders then hanlders[tag] = nil end
end

function M:CheckItemRedPoint(itemId)
    return IItemDataMgr:CheckItemRedPoint(itemId)
end

function M:CheckTypeItemRedPoint(tabType)
    return IItemDataMgr:CheckItemRedPoint(tabType)
end

function M:GetItemsByTypes(types)
    return IItemDataMgr:GetItemsByTypes(types)
end

function M:GetItemsByType(type)
    return IItemDataMgr:GetItemsByType(type)
end

function M:GetItemByPackageId(nPackageId, isLimitItem)
    if isLimitItem == nil then isLimitItem = false end
    return IItemDataMgr:GetItemByPackageId(nPackageId, isLimitItem)
end

function M:GetItemById(nItemId)
    return IItemDataMgr:GetItemById(nItemId)
end

function M:GetItemNumById(nItemId)
    return IItemDataMgr:GetItemNumById(nItemId)
end

function M:GetItemsById(nItemId)
    return IItemDataMgr:GetItemsById(nItemId)
end

function M:GetAllItemDatas(types)
    return IItemDataMgr:GetAllItemDatas(types)
end

function M:UseItem(nRequest, onUseSuc)
    if self.m_rsUseItem then return end

    self.m_onUseSuc = onUseSuc
    local messageId = Proto.MessageId.ResponseUseItem
    local handler = Bind(self, self.OnResponseUseItem)
    self.m_rsUseItem = NetPack:RegistResponse(messageId, handler)
    NetPack:SendMessage(Proto.MessageId.RequestUseItem, nRequest)
end

function M:OnResponseUseItem(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsUseItem)
    self.m_rsUseItem = nil
    if result ~= 0 then return end

    if ItemHelper.isHideItem then
        if self.m_onUseSuc then
            self.m_onUseSuc()
            self.m_onUseSuc = nil
        end
        ItemHelper.isHideItem = nil
    else
        local items = {}
        for _, value in ipairs(msg.Objs or {}) do
            if #items > 0 then
                local isFindSameId = false
                for j = 1, #items do
                    if items[j].Id == value.Id then
                        items[j].Cnt = items[j].Cnt + value.Cnt
                        isFindSameId = true
                        break
                    end
                end
                if not isFindSameId then
                    tInsert(items, value)
                end
            else
                tInsert(items, value)
            end
        end

        if #items > 0 then
            GameHelper.ShowGetItemsByItems(items, self.m_onUseSuc)
        else
            if self.m_onUseSuc then
                self.m_onUseSuc()
                self.m_onUseSuc = nil
            end
        end
    end
end

return M
