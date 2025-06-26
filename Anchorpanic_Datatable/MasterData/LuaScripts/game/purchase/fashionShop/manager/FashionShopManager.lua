module("purchase.FashionShopManager", Class.impl(Manager))

-- 构造函数
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
    -- 当前展示皮肤
    self.mFashionShowVo = nil

    -- 是否使用打折卡
    self.isUseDiscount = false
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 解析服务器已购买皮肤列表
function parseFashionedInfoMsg(self, msg)
    if msg then
        self.mFashionsList = {}
        self.mFashionRechargeName = {}
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

            if vo.itemId ~= 0 then
                local propsVo =  props.PropsManager:getPropsConfigVo(vo.itemId)
                self.mFashionRechargeName[config.id] = propsVo:getName()
            end
        end

        table.sort(self.mFashionsList, function(a, b)
            return a.sort < b.sort
        end)

        self.mComboBuyList = {}
        for i = 1, #msg.combo_buy_list, 1 do --40001
            table.insert(self.mComboBuyList, msg.combo_buy_list[i])
        end

        self.mComboGoodsList = {}
        for i = 1, #msg.combo_goods_list, 1 do
            local vo = purchase.FashionComboVo.new()
            vo:parseData(msg.combo_goods_list[i].id, msg.combo_goods_list[i])
            table.insert(self.mComboGoodsList, vo)
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOP_ITEM)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_COMBO_VIEW)
    GameDispatcher:dispatchEvent(EventName.RECEIVE_UPDATE_FASHIONED_INFO_MSG)
end

function getRechargeName(self,id)
    return self.mFashionRechargeName[id]
end

function parseFashionComboBuyMsg(self, msg)
    if self.mComboBuyList == nil then
        self.mComboBuyList = {}
    end
    table.insert(self.mComboBuyList, msg.goods_combo_id)

    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_COMBO_VIEW)
end

function getComboIsBuy(self, id)
    if self.mComboBuyList == nil then
        return false
    end
    return table.indexof01(self.mComboBuyList, id) > 0
end

function getComboShopList(self)
    if self.mComboGoodsList == nil then
        return {}
    end
    local list = {}
    for _, vo in pairs(self.mComboGoodsList) do
        table.insert(list, vo)
    end
    table.sort(list, function (a, b)
        local aHas = purchase.FashionShopManager:checkComboIsAllGoodsHadBuy(a.id)
        local bHas = purchase.FashionShopManager:checkComboIsAllGoodsHadBuy(b.id)
        if aHas ~= bHas then
           return not aHas
        else
            return a.id < b.id 
        end
    end)
    return list
end

function getComboShopItemById(self, id)
    local list = self:getComboShopList()
    for i = 1,#list, 1 do
        if list[i].id == id then
            return list[i]
        end
    end
    return nil
end

-- 解析服务器已购买皮肤列表
function parseFashionBuyMsg(self, msg)
    if msg.result > 0 then
        if (not table.indexof(self.mFashionsedTidList, msg.goods_id)) then
            table.insert(self.mFashionsedTidList, msg.goods_id)
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOP_ITEM)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_COMBO_VIEW)
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

function parseFashionSceneData(self)
    self.mFashionSceneDic = {}
    local baseData = RefMgr:getData("hero_interact_scene_data")
    for key, data in pairs(baseData) do
        local vo = purchase.FashionSceneVo.new()
        vo:parseData(key, data)
        self.mFashionSceneDic[key] = vo
    end
end

function getFashionSceneDataByModelId(self, heroTid, model_id)
    if self.mFashionSceneDic == nil then
        self:parseFashionSceneData()
    end

    if self.mFashionSceneDic[heroTid] == nil then
        return nil
    end

    return self.mFashionSceneDic[heroTid]:getInteractSceneDataByModelId(model_id)
end

function getFashionSceneData(self, heroTid, sceneId)
    if self.mFashionSceneDic == nil then
        self:parseFashionSceneData()
    end
    return self.mFashionSceneDic[heroTid]:getSceneChildVo(sceneId)
end

function parseFashionComboData(self)
    self.mComboGoodsConfigDic = {}
    local baseData = RefMgr:getData("fashionshop_combo_data")
    for key, data in pairs(baseData) do
        local vo = purchase.FashionComboConfigVo.new()
        vo:parseData(key, data)
        self.mComboGoodsConfigDic[key] = vo
    end
end

function getFashionComboData(self, id)
    if self.mComboGoodsConfigDic == nil then
        self:parseFashionComboData()
    end
    return self.mComboGoodsConfigDic[id]
end

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

function getFashionSceneOrPairtsIsBuy(self, id)
    if self.mFashionsedTidList == nil then
        return false
    end
    return table.indexof01(self.mFashionsedTidList, id) > 0
end

--检查组合包中是否存在任一商品已被购买
function checkComboIsAnyGoodsHadBuy(self, comboCfgId)
    local fashionComboConfigVo = self:getFashionComboData(comboCfgId)
    for _, goods in pairs(fashionComboConfigVo.goodsList) do
        if self:getFashionSceneOrPairtsIsBuy(goods) then
           return true 
        end
    end
    return false 
end

--检查组合包中是否存在所有商品已被购买
function checkComboIsAllGoodsHadBuy(self, comboCfgId)
    local fashionComboConfigVo = self:getFashionComboData(comboCfgId)
    local isAll = true
    for _, goods in pairs(fashionComboConfigVo.goodsList) do
        isAll = isAll and self:getFashionSceneOrPairtsIsBuy(goods) 
    end
    return isAll 
end

-- 获取
function getCurShopList(self, type)
    local list = {}
    self.mFashionsIdList = {}
    -- if #self.mFashionsList <= 0 then
    --     self:parseFanshionShopData()
    -- end
    for i, vo in ipairs(self.mFashionsList) do
        if vo.type == fashionShop.ShopType.NOMAL and not hero.HeroManager:getHeroConfigVo(vo:getHeroTid()) then
        else
            if vo:getTime() ~= -1 and (type == vo.type) then
                table.insert(list, vo)
                table.insert(self.mFashionsIdList, vo.id)
            end
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

--设置默认打开的皮肤商店类型
function setDefOpenFashionType(self, type)
    self.defOpenType = type
end

--获取默认打开的皮肤商店类型
function getDefOpenFashionType(self)
    return self.defOpenType
end

-- 析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
