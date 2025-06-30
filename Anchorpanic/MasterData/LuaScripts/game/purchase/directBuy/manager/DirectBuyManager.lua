module("purchase.DirectBuyManager", Class.impl(Manager))

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
    self.mDirectBuyList = {}
    self.mHadBuyDic = {}
    --今日已请求次数"
    self.mReqTimes = 0
    -- 配置
    self.mTypeConfigList = nil
end

-- 解析配置表
function parseConfig(self)
    self.mTypeConfigList = {}
    local baseData = RefMgr:getData("direct_gift_type_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(purchase.DirectBuyTypeConfigVo)
        vo:parseData(data)
        table.insert(self.mTypeConfigList, vo)
    end
    local function _sort(configVo1, configVo2)
        if (configVo1.sort ~= configVo2.sort) then
            return configVo1.sort < configVo2.sort
        end
    end
    table.sort(self.mTypeConfigList, _sort)
end

function getTypeConfigList(self)
    if (not self.mTypeConfigList) then
        self:parseConfig()
    end
    local playerLvl = role.RoleManager:getRoleVo():getPlayerLvl()
    local list = {}
    for i = 1, #self.mTypeConfigList do
        local configVo = self.mTypeConfigList[i]
        if (playerLvl and configVo:getLvl() >= playerLvl) then
            if (funcopen.FuncOpenManager:isOpen(configVo:getFunId(), false)) then
                table.insert(list, configVo)
            end
        end
    end
    return list
end



---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 解析面板信息
function parsePanelInfoMsg(self, msg)
    self.mDirectBuyList = {}
    for i = 1, #msg.goods_list do
        local vo = purchase.DirectBuyVo.new()
        vo:parseMsg(msg.goods_list[i])
        table.insert(self.mDirectBuyList, vo)
    end
    self.mHadBuyDic = {}
    for i = 1, #msg.buy_list do
        self.mHadBuyDic[msg.buy_list[i].key] = msg.buy_list[i].value
    end
    self.mReqTimes = msg.request_times
    GameDispatcher:dispatchEvent(EventName.UPDATE_DIRECT_BUY_INFO)
    purchase.PurchaseManager:dispatchEvent(purchase.PurchaseManager.BUBBLE_CHANGE, purchase.PurchaseTab.DIRECT_BUY)
end

-- 更新已购买数量
function parseBuyResultMsg(self, msg)
    if (not self.mHadBuyDic) then
        self.mHadBuyDic = {}
    end
    self.mHadBuyDic[msg.goods_id] = msg.num
    ShowAwardPanel:showPropsAwardMsg(msg.award_list)
    GameDispatcher:dispatchEvent(EventName.UPDATE_DIRECT_BUY_GO, { shopId = msg.goods_id })
    purchase.PurchaseManager:dispatchEvent(purchase.PurchaseManager.BUBBLE_CHANGE, purchase.PurchaseTab.DIRECT_BUY)
end

function getIsShowOneAdvertising(self)
    if ((not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_SHOPPING, false)) or (recharge.RechargeManager:getIsBuyOneGift()) or (purchase.DirectBuyManager:getReqTimes() >= 2)) then
        return false
    end
    return true
end

-- 获取直购商品列表
function getDirectBuyList(self, page)
    local list = {}
    if (self.mDirectBuyList) then
        for i = 1, #self.mDirectBuyList do
            local vo = self.mDirectBuyList[i]
            if (page == nil or vo:getType() == page) then
                table.insert(list, vo)
            end
        end
    end
    table.sort(list, function(vo1, vo2)
        if vo1:getIsOver() and not vo2:getIsOver() then
            return false
        elseif not vo1:getIsOver() and vo2:getIsOver() then
            return true
        else
            return vo1:getSort() < vo2:getSort()
        end
    end)
    return list
end

-- 根据id取直购礼包
function getDirectBuyVoById(self, id)
    for i, v in ipairs(self.mDirectBuyList) do
        if v:getId() == tonumber(id) then
            return v
        end
    end
    return nil
end

function getReqTimes(self)
    return self.mReqTimes or 0
end

-- 获取对应商品已购买数量
function getHadBuyNum(self, shopId)
    return self.mHadBuyDic[shopId] or 0
end

function checkRed(self)
    for i, v in pairs(self.mDirectBuyList) do
        if v:getPrice() <= 0 then
            local hadBuyNum = self:getHadBuyNum(v:getId())
            local limit = v:getLimit()
            if limit > hadBuyNum then
                return true
            end
        end
    end
    return false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]