local FavorStoryContext = BaseClass("FavorStoryContext", BaseContext)
local M = FavorStoryContext

local function SortData(data1, data2)
    local a = data1.data.Num == 0
    local b = data2.data.Num == 0
    if a and not b then
        return b
    elseif not a and b then
        return b
    end
    local cfg1 = data1.data:GetItemCfg()
    local cfg2 = data2.data:GetItemCfg()
    --1、优先按照道具类型排序，类型数字按照1~18依次排序，配置字段type;
    if cfg1.type == cfg2.type then
        --2、同道具类型按照道具品质排序，品质高得排前面，即4在前，1最后；配置字段quality；
        if cfg1.quality == cfg2.quality then
            --3、同类型同品质，按照配置字段order
            return cfg1.order < cfg2.order
        else
            return cfg1.quality > cfg2.quality
        end
    else
        return cfg1.type < cfg2.type
    end
end

function M:CheckTaskItem(itemId)
    for k, v in pairs(self.taskItems) do
        if v.item == itemId then
            return true
        end
    end
    return false
end

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open(heroId, type, groupId, items, roomStoryLevel, action, closeCallback)
    self.heroId = heroId
    self.type = type
    self.groupId = groupId
    self.items = items
    self.roomStoryLevel = roomStoryLevel
    self.callback = action
    self.closeCallback = closeCallback
    DormHelper.CommanderEnterStory(Bind(self, self.EnterStoryCallback))
end

--角色进入story状态
function M:EnterStoryCallback(...)
    self:_Show(self.heroId, self.type, self.groupId, self.items, self.roomStoryLevel, self.callback, self.closeCallback)
end

function M:GetItemDatas(taskItems)
    self.taskItems = taskItems
    local allItems = self:GetHeroDatas(false)
    return allItems
end

function M:GetHeroDatas(selectable)
    if selectable == nil then selectable = false end

    local allItems = {}
    for _, tabInfo in pairs(BagConst.Tab) do
        local csItemDatas
        if tabInfo.Index == BagConst.Tab.PLOT.Index then
            csItemDatas = ItemDataMgr:GetInstance():GetAllItemDatas(tabInfo.types)
        elseif tabInfo.Index == BagConst.Tab.ITEM.Index or tabInfo.Index == BagConst.Tab.NURTURE.Index or
            tabInfo.Index == BagConst.Tab.FOODS.Index or tabInfo.Index == BagConst.Tab.FAVOR.Index then
            csItemDatas = ItemDataMgr:GetInstance():GetItemsByTypes(tabInfo.types)
        end
        if csItemDatas then
            local datas = {}
            for i = 0, csItemDatas.Count - 1 do
                local d = csItemDatas[i]
                -- 指定道具不显示
                if d:IsShow() and d:IsVaild() then
                    local data = {}
                    data.data = d
                    data.isSelect = false
                    data.selectable = selectable
                    table.insert(datas, data)
                end
            end
            table.sort(datas, function(data1, data2)
                local data1Task = self:CheckTaskItem(data1.data.Id)
                local data2Task = self:CheckTaskItem(data2.data.Id)
                if data1Task or data2Task then
                    if data1Task and not data2Task then
                        return data1Task
                    elseif not data1Task and data2Task then
                        return data1Task
                    end
                else
                    local a = data1.data.Num == 0
                    local b = data2.data.Num == 0
                    if a and not b then
                        return b
                    elseif not a and b then
                        return b
                    end
                    local cfg1 = data1.data:GetItemCfg()
                    local cfg2 = data2.data:GetItemCfg()
                    --1、优先按照道具类型排序，类型数字按照1~18依次排序，配置字段type;
                    if cfg1.type == cfg2.type then
                        --2、同道具类型按照道具品质排序，品质高得排前面，即4在前，1最后；配置字段quality；
                        if cfg1.quality == cfg2.quality then
                            --3、同类型同品质，按照配置字段order
                            return cfg1.order < cfg2.order
                        else
                            return cfg1.quality > cfg2.quality
                        end
                    else
                        return cfg1.type < cfg2.type
                    end
                end
                return false
            end)
            allItems[tabInfo.Index] = datas
        end
    end
    return allItems
end

return FavorStoryContext
