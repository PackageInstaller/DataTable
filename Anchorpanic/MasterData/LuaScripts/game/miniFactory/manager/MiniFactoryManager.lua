--[[ 
-----------------------------------------------------
@filename       : MiniFacManager
@Description    : 迷你工厂
@date           : 2022-2-28 
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("miniFac.MiniFactoryManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    -- 配置
    self.mFactoryConfigDic = nil
    self.mFactoryFormulaDic = nil
    -- 服务器数据
    self.mFactoryOrdersList = nil
    self.mFactoryCapacityVo = nil
    --信息面板第一个数据
    self.mFirstVoTid = nil
    --记录点击按钮数据tid
    self.mRecordBtnTid = 0
    -- 订单完成列表
    self.mFactoryCompleteList = {}
end

---------------------------------------------------------配置--------------------------------------------------------------
--获取迷你工厂信息
function parseFactoryDataConfigData(self)
    self.mFactoryConfigDic = {}
    local baseData = RefMgr:getData("factory_data")
    for _, data in pairs(baseData) do
        local vo = miniFac.MiniFactoryConfigVo.new()
        vo:parseData(data)
        if not self.mFactoryConfigDic[vo.type] then
            self.mFactoryConfigDic[vo.type] = {}
        end
        self.mFactoryConfigDic[vo.type] = vo
    end
end

--获取工坊商品信息
function parseFactoryFormulaConfigData(self)
    self.mFormulaConfigDic = {}
    local baseData = RefMgr:getData("factory_formula_data")
    for key, data in pairs(baseData) do
        local vo = miniFac.MiniFactoryFormulaVo.new()
        vo:parseFormula(data, key)
        if not self.mFormulaConfigDic[key] then
            self.mFormulaConfigDic[key] = {}
        end
        self.mFormulaConfigDic[key] = vo
    end
end

-- 获取工厂配置字典
function getFactoryDic(self)
    if (not self.mFactoryConfigDic) then
        self:parseFactoryDataConfigData()
    end
    return self.mFactoryConfigDic
end

function getFactoryFormulaDic(self)
    if (not self.mFormulaConfigDic) then
        self:parseFactoryFormulaConfigData()
    end
    return self.mFormulaConfigDic
end

-- 获取工厂配置vo
function getFactoryVo(self, type)
    return self:getFactoryDic()[type]
end

--根据物品订单id获取数据
function getFactoryFormulaVoById(self, id)
    local dic = self:getFactoryFormulaDic()
    return dic[id]
end

--根据物品tid获取数据
function getFactoryFormulaVoByTid(self, tid)
    local dic = self:getFactoryFormulaDic()
    for k, v in pairs(dic) do
        if (v.tid == tid) then
            return v
        end
    end
end

--获取工厂配置表数据通过类型
function getFactoryFormulaVoByTabType(self, tabType)
    local dic = self:getFactoryFormulaDic()
    local list = {}
    for k, v in pairs(dic) do
        if (v.type == tabType) then
            table.insert(list, v)
        end
    end
    local unlocklist = {}
    local locklist = {}
    local playerLv = role.RoleManager:getRoleVo():getPlayerLvl()
    for _, vo in ipairs(list) do
        if vo.lvLimit <= playerLv then
            table.insert(unlocklist, vo)
        else
            table.insert(locklist, vo)
        end
    end
    table.sort(unlocklist, function(a, b) return a.sort < b.sort end)
    local orderVo = miniFac.MiniFactoryManager:getOrderVo(tabType)
    if orderVo then
        local tempVo = nil
        --  if orderVo:getRemainTime() <= 0 then
        for i, vo in ipairs(unlocklist) do
            if vo.key == orderVo.orderId then
                tempVo = vo
                table.remove(unlocklist, i)
                table.insert(unlocklist, 1, tempVo)
            end
        end
        -- end
    end
    table.sort(locklist, function(a, b) return a.sort < b.sort end)
    for _, vo in ipairs(locklist) do
        table.insert(unlocklist, vo)
    end
    return unlocklist
end

---------------------------------------------------------服务器--------------------------------------------------------------
--返回加工厂信息
function updateFactoryInfo(self, msg)
    self:parseFactoryProduceListData(msg.module_list)
    self:parseFactoryProduceConvertData(msg.speed_material_info)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVERT_INFO)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FACTORY_INFO)
    -- 货币栏更新（统一）
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.POWER_TID)
    self:updateBubble()
end

--购买产能结果
function updateFactoryBuyInfo(self, msg)
    self:parseFactoryProduceConvertData(msg.speed_material_info)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVERT_INFO)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FACTORY_INFO)
    -- 货币栏更新（统一）
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.POWER_TID)
end

--加工厂生产订单结果
function updateFactoryOrdersInfo(self, msg)
    self:parseFactoryProduceData(msg.module_info, true)
    self:parseFactoryProduceConvertData(msg.speed_material_info)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVERT_INFO)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FACTORY_INFO)
    -- 货币栏更新（统一）
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.POWER_TID)
end

--加工厂领取订单返回
function updateFactoryReceiveInfo(self, msg)
    self:showAwardTip({ msg.module_id })
    self:removeOrdersList(msg.module_id)
    self:parseFactoryProduceConvertData(msg.speed_material_info)

    GameDispatcher:dispatchEvent(EventName.UPDATE_FACTORY_INFO)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVERT_INFO)
    -- 货币栏更新（统一）
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.POWER_TID)
    self:updateBubble()
end

--加工厂一键领取订单返回
function updateFactoryOneKeyReceiveInfo(self, msg)
    if #msg.module_list > 0 then
        self:showAwardTip(msg.module_list)
        for i, v in ipairs(msg.module_list) do
            self:removeOrdersList(v)
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_FACTORY_INFO)
        self:updateBubble()
    end
end

--加工厂终止订单返回
function updateFactoryStopInfo(self, msg)
    self:removeOrdersList(msg.module_id)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FACTORY_INFO)
end

--加工厂订单完成
function updateFactoryCompleteInfo(self, msg)
    self:setCompleteOrderList(msg.module_id)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FACTORY_INFO)
    self:updateBubble()
end

--产能结果
function updateFactoryCapacityInfo(self, msg)
    self:parseFactoryProduceConvertData(msg.speed_material_info)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVERT_INFO)
    -- 货币栏更新（统一）
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.POWER_TID)
end

--解析来自服务器的生产列表数据(列表)
function parseFactoryProduceListData(self, cusMsgList)
    self.mFactoryOrdersList = {}
    for i = 1, #cusMsgList do
        if (i == #cusMsgList) then
            self:parseFactoryProduceData(cusMsgList[i], true)
        else
            self:parseFactoryProduceData(cusMsgList[i], false)
        end
    end
end

--解析来自服务器的生产列表数据(结构体)
function parseFactoryProduceData(self, cusMsg, isSort)
    if (not self.mFactoryOrdersList) then
        self.mFactoryOrdersList = {}
    end
    local vo = LuaPoolMgr:poolGet(miniFac.MiniProduceVo)
    vo:parseOneProduce(cusMsg)
    if vo.endTime > 0 then
        table.insert(self.mFactoryOrdersList, vo)
    end
    if isSort then
        table.sort(self.mFactoryOrdersList, function(v1, v2)
            return v1:getRemainTime() < v2:getRemainTime()
        end)
    end
end


--解析来自服务器的产能数据
function parseFactoryProduceConvertData(self, cusMsg)
    local vo = miniFac.MiniConvertVo.new()
    vo:parmsProduce(cusMsg)
    self.mFactoryCapacityVo = vo
end

--获迷你工厂取产能数据
function getFactoryCapacityVo(self)
    return self.mFactoryCapacityVo
end

--获取迷你工厂生产列表数据
function getProduceList(self)
    return self.mFactoryOrdersList
end

--获取列表订单
function getOrderVo(self, id)
    for i, vo in ipairs(self.mFactoryOrdersList) do
        if id == vo.id then
            return vo
        end
    end
end

--删除指定订单
function removeOrdersList(self, id)
    for i = 1, #self.mFactoryOrdersList do
        local orderVo = self.mFactoryOrdersList[i]
        if orderVo.id == id then
            LuaPoolMgr:poolRecover(table.remove(self.mFactoryOrdersList, i))
            table.removebyvalue(self.mFactoryCompleteList, id)
            break
        end
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_FACTORY_INFO)
end

--获取已完成订单列表
function getCompleteOrderCount(self)
    return #self.mFactoryCompleteList
end

--获取已完成订单列表
function getCompleteOrderList(self)
    return self.mFactoryCompleteList
end

--修改已完成订单列表
function setCompleteOrderList(self, orderId)
    if (not table.indexof(self.mFactoryCompleteList, orderId)) then
        table.insert(self.mFactoryCompleteList, orderId)
    end
end

function getOpenModuleNums(self)
    local count = 0
    for _, configVo in pairs(self:getFactoryDic()) do
        if funcopen.FuncOpenManager:isOpen(configVo.funcId, false) == true then
            count = count + 1
        end
    end
    return count
end
--------------------------------------------红点-------------------------------------------------------
--传入红点状态
function setFlagValue(self, cusValue)
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_MINIFACTORY, cusValue)
end
-- 更新红点
function updateBubble(self)
    self:setFlagValue(self:checkProduceBubble()) end

-- 检查生产列表是否有完成订单未领
function checkProduceBubble(self)
    if self:getCompleteOrderCount() > 0 then
        return true
    end
    return false
end

function showAwardTip(self, list)
    local awardPropsList = {}
    if #list > 0 then
        for i, v in ipairs(list) do
            local orderVo = self:getOrderVo(v)
            local itemNum = miniFac.MiniFactoryManager:getFactoryFormulaVoByTid(orderVo:getPropsTid()).itemNum
            local propsVo = props.PropsManager:getPropsVo({ tid = orderVo:getPropsTid(), num = orderVo.orderNum * itemNum })
            table.insert(awardPropsList, propsVo)
        end
    end
    ShowAwardPanel:showPropsAwardMsg(awardPropsList)
end
--------------------------------------------工厂信息面板-------------------------------------------------------
-- 修改数据(用于显示第一个数据)
function setSelectVo(self, Vo)
    self.mFirstVoTid = Vo
end
--获取选择数据
function getSelectVo(self)
    return self.mFirstVoTid
end
--修改记录按钮操作数据Tid
function setRecordBtnTid(self, tid)
    self.mRecordBtnTid = tid
end
--获取记录按钮操作数据Tid
function getRecordBtnTid(self)
    return self.mRecordBtnTid
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]