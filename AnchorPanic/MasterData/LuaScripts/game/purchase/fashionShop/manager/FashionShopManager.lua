module("purchase.FashionShopManager", Class.impl(Manager))

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
    -- 已购买皮肤列表
    self.mFashionsedTidList = {}
    -- 商店皮肤列表
    self.mFashionsList = {}
    -- 各皮肤商店类型数据
    self.mFashionShopList = {}
    -- 商店皮肤列表
    self.mFashionsIdList = {}
    -- 商店皮肤字典
    self.mFashionsDic = {}
    --当前展示皮肤
    self.mFashionShowVo = nil

    -- 是否使用打折卡
    self.isUseDiscount = false
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 解析服务器已购买皮肤列表
function parseFashionedInfoMsg(self, msg)
    if msg then
        self.mFashionsList = {}
        for i, id in ipairs(msg.buy_list) do
            if (not table.indexof(self.mFashionsedTidList, id)) then
                table.insert(self.mFashionsedTidList, id)
            end
        end
        for i, config in pairs(msg.goods_list) do
            local vo = purchase.FashionShopVo.new()
            vo:parseData(config.id, config)
            self.mFashionsDic[vo:getFashionModel()] = vo
            table.insert(self.mFashionsList, vo)
        end

        table.sort(self.mFashionsList, function(a, b)
            return a.sort < b.sort
        end)

    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOP_ITEM)
end

-- 解析服务器已购买皮肤列表
function parseFashionBuyMsg(self, msg)
    if msg.result > 0 then
        if (not table.indexof(self.mFashionsedTidList, msg.goods_id)) then
            table.insert(self.mFashionsedTidList, msg.goods_id)
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOP_ITEM)
end

-- 解析皮肤商品列表
-- function parseFanshionShopData(self)
--     self.mFashionsDic = {}
--     local baseData = RefMgr:getData("fashionshop_data")
--     for key, data in pairs(baseData) do
--         local vo = purchase.FashionShopVo.new()
--         vo:parseData(key, data)
--         self.mFashionsDic[vo:getFashionModel()] = vo
--         table.insert(self.mFashionsList, vo)
--     end
--     table.sort(self.mFashionsList, function(a, b)
--         return a.sort < b.sort
--     end)
-- end

-- 解析子页签配置数据
function parseFanshionShopTypeData(self)
    local baseData = RefMgr:getData("fashionshop_show_data")
    for key, data in pairs(baseData) do
        local vo = purchase.FashionShopTypeVo.new()
        vo:parseData(key, data)
        table.insert(self.mFashionShopList, vo)
    end
    table.sort(self.mFashionShopList, function(a, b)
        return a.sort < b.sort
    end)
end

function getFashionShopVoByModel(self, model)
    -- if not self.mFashionsDic then
    --     self:parseFanshionShopData()
    -- end
    return self.mFashionsDic[model]
end

function getFashionShopVoByType(self, type)
    if #self.mFashionShopList <= 0 then
        self:parseFanshionShopTypeData()
    end
    for _, vo in ipairs(self.mFashionShopList) do
        if type == vo.type then
            return vo
        end
    end
end

-- 获取已购买皮肤列表
function getFashionedTidList(self)
    return self.mFashionsedTidList or {}
end

-- 获取
function getCurShopList(self, type)
    local list = {}
    self.mFashionsIdList = {}
    if #self.mFashionsList <= 0 then
        self:parseFanshionShopData()
    end
    for i, vo in ipairs(self.mFashionsList) do
        if vo:getTime() ~= -1 and (type == vo.type) then
            table.insert(list, vo)
            table.insert(self.mFashionsIdList, vo.id)
        end
    end

    -- table.sort(list,function (vo1,vo2)
    --     return vo1.id>vo2.id
    -- end)
    return list or {}
end

-- 获取商品皮肤id列表
function getFashionsIdList(self)
    return self.mFashionsIdList or {}
end

-- 获取当前展示皮肤数据
function getFashionShowVo(self)
    return self.mFashionShowVo
end

-- 获取当前展示皮肤数据
function setFashionShowVo(self, data)
    self.mFashionShowVo = data
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]