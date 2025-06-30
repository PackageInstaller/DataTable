--[[ 
-----------------------------------------------------
@filename       : OrderFactoryManager
@Description    : 序列物加工厂
@date           : 2021-06-23 20:24:56
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.orderFactory.manager.OrderFactoryManager', Class.impl(Manager))

-- 选择材料更新
EVENT_MATERIAL_SELECT_UPDATE = "EVENT_MATERIAL_SELECT_UPDATE"
-- 加工成功
EVENT_PROCESS_SUCCESS = "EVENT_PROCESS_SUCCESS"

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

--初始化
function init(self)
    self.mSelectMaterialList = {}
    self.needMaterialCount = 0
end


-- 解析基础数据
function parseConfigData(self)
    self.mOrderProcessData = {}
    self.mOrderProcessList = {}
    local baseData = RefMgr:getData("order_process_data")
    for key, v in pairs(baseData) do
        local vo = orderFactory.OrderFactoryConfigVo.new()
        vo:parseConfigData(key, v)
        self.mOrderProcessData[key] = vo
        table.insert(self.mOrderProcessList, vo)
    end
    table.sort(self.mOrderProcessList, function(a, b)
        return a.id < b.id
    end)
end

-- 加工成功
function parseProcessOrderMsg(self, msg)
    if msg.result == 1 then
        self:dispatchEvent(self.EVENT_PROCESS_SUCCESS)
    else
        gs.Message.Show(_TT(40509, msg.result))
    end
end

-- 加工列表
function getProcessList(self)
    if not self.mOrderProcessList then
        self:parseConfigData()
    end
    return self.mOrderProcessList
end
-- 获取加工数据
function getProcessData(self, cusId)
    if not self.mOrderProcessData then
        self:parseConfigData()
    end
    return self.mOrderProcessData[cusId]
end

-- 已选材料列表
function getSelectMaterialList(self)
    return self.mSelectMaterialList
end

-- 已选材料变化
function setSelectMaterialList(self, cusId)
    local index = table.indexof(self.mSelectMaterialList, cusId)
    local state = 1
    if index == false then
        state = 1
        table.insert(self.mSelectMaterialList, cusId)
    else
        state = 2
        table.remove(self.mSelectMaterialList, index)
    end

    self:dispatchEvent(self.EVENT_MATERIAL_SELECT_UPDATE, { state = state, id = cusId })
end
-- 清空选中列表
function clearSelectMaterialList(self)
    self.mSelectMaterialList = {}
end
-- 是否已经材料放满
function isFullMaterial(self)
    local num = #self:getSelectMaterialList()
    if self.needMaterialCount <= num then
        return true
    end
    return false
end

-- 获取页签对应的背包道具列表
function getEquipList(self, cusPageType, cusColor, cusSortType)
    local propsDic = bag.BagManager:getPropsDic(bag.BagType.Bag)
    local list = {}
    for id, propsVo in pairs(propsDic) do
        if (bag.BagManager:isBelongPage(propsVo, cusPageType)) then
            if not cusColor or cusColor == propsVo.color then
                if cusSortType == 0 or cusSortType == propsVo.subType then
                    table.insert(list, propsVo)
                end
            end
        end
    end
    -- if cusSortData then
    --     -- 是否降序
    --     local isDescending = cusSortData.isDescending
    --     local sortList = cusSortData.sortList
    local function _sort(equipVo1, equipVo2)
        if (equipVo1 and equipVo2) then
            local sortFun = nil
            sortFun = bag.getSortFun(true, bag.BagSortType.ID)
            local result = sortFun(equipVo1, equipVo2)
            sortFun = nil
            if (result ~= nil) then
                return result
            end
        end
        return false
    end
    table.sort(list, _sort)
    -- end
    return list
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
