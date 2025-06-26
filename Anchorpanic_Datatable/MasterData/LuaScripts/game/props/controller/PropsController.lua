module('props.PropsController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_DETAIL_DATA, self.__onReqEquipDetailDataHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_ORDER_DETAIL_DATA, self.__onReqOrderDetailDataHandler, self)
    GameDispatcher:addEventListener(EventName.USE_PROPS_BY_ID, self.__onUsePropsByIdHandler, self)
    GameDispatcher:addEventListener(EventName.USE_PROPS_BY_TID, self.__onUsePropsByTidHandler, self)
    GameDispatcher:addEventListener(EventName.USE_MORE_PROPS_BY_TID, self.__onUseMorePropsTidHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_SELL_PROPS, self.onReqSellProps, self)
    GameDispatcher:addEventListener(EventName.REQ_BREAK_PROPS, self.onReqBreakProps, self)

    GameDispatcher:addEventListener(EventName.REQ_PROPS_LOCK_CHANGE, self.onPropsLockHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_ALL_PREVIEW_ATTR, self.__onReqAllPreviewAttrHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 装备详细信息 17005
        SC_EQUIP_DETAIL = self.__onUpdateEquipDetailDataHandler,
        --  ("已弃用")
        --SC_ORDER_DETAIL = self.__onUpdateOrderDetailDataHandler,
        SC_ATTR_PREVIEW_ALL = self.__onAllPreviewAttrHandler,
    }
end

function __onReqEquipDetailDataHandler(self, args)
    --- *c2s* 装备详细信息 17004
    SOCKET_SEND(Protocol.CS_EQUIP_DETAIL, {hero_id = args.heroId, equip_id = args.equipId}, Protocol.SC_EQUIP_DETAIL)
end

function __onReqOrderDetailDataHandler(self, args)
    cusLog("已弃用")
    --- *c2s* 序列物详细信息 17020
    --SOCKET_SEND(Protocol.CS_ORDER_DETAIL, { helper_id = args.helperId, order_id = args.orderId })
end

function __onUpdateEquipDetailDataHandler(self, msg)
    local equipVo = nil
    --if (msg.hero_id <= 0) then
    -- 背包中的装备
    equipVo = bag.BagManager:getPropsVoById(msg.equip_id)
    --else
    -- 英雄身上的装备
    --local heroVo = hero.HeroManager:getHeroVo(msg.hero_id)
    --equipVo = heroVo:getEquipById(msg.equip_id)
    --end
    if (equipVo) then
        equipVo:setTuPoAttachAttr(msg.break_add_attr)
        equipVo:setNuclearAttr(msg.nuclear_attr)
        equipVo:setStrengthenPreAttr(msg.strength_pre_attr)
        equipVo:setTuPoPreAttr(msg.break_pre_attr)
        equipVo:setRemakeAttr(msg.remake_attr)
        equipVo:setBracelet_remake_attr(msg.bracelet_remake_attr)
        equipVo:setSkillEffect(msg.skill_effect)
        equipVo:setRefineSkillPreEffect(msg.pre_bracelet_refine_skill_attr)
        equipVo:setTotalAttr(msg.total_attr, true)
        -- 此处派发详细数据更新和数据源的更新按需要使用
        equip.EquipManager:dispatchEvent(equip.EquipManager.UPDATE_EQUIP_DETAIL_DATA, {heroId = equipVo.heroId, equipId = equipVo.id})
        GameDispatcher:dispatchEvent(EventName.UPDATE_BRACELET_DETAIL_DATA)
    else
        Debug:log_error("PropsController", "装备详细信息更新错误：找不到对应装备数据")
    end
end

function __onUpdateOrderDetailDataHandler(self, msg)
    local orderVo = nil
    --if (msg.helper_id <= 0) then
    -- 背包中的装备
    orderVo = bag.BagManager:getPropsVoById(msg.order_id)
    --else
    -- 英雄身上的装备
    --    orderVo = covenantTalent.CovenantTalentManager:getOrderVoInHelper(msg.helper_id, msg.order_id)
    --end
    if (orderVo) then
        orderVo:setSkillEffect(msg.skill_effect)
        orderVo:setTotalAttr(msg.total_attr, true)
        -- 此处派发详细数据更新和数据源的更新按需要使用
        covenantTalent.CovenantTalentManager:dispatchEvent(covenantTalent.CovenantTalentManager.UPDATE_ORDER_DETAIL_DATA, {heroId = orderVo.heroId, equipId = orderVo.id})
    else
        Debug:log_error("PropsController", "序列物详细信息更新错误：找不到对应序列物数据")
    end
end

-- 通过道具id使用
function __onUsePropsByIdHandler(self, args)
    local id = args.id
    local count = args.count
    local targetId = args.targetId
    local use_arg = args.use_args
    local uicode = args.uicode
    local propsVo = bag.BagManager:getPropsVoById(id)
    if uicode and uicode > 0 then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = uicode, param = propsVo})
        return
    end
    if (propsVo and propsVo.count >= count) then
        -- self:__checkIsCanUse(propsVo, count, isJumpView, targetId, false)
        --- *c2s* 使用物品byId 17002
        SOCKET_SEND(Protocol.CS_USE_BY_ID, {id = id, target = targetId, count = count, use_args = use_arg})
    end
end

-- 通过道具tid使用
function __onUsePropsByTidHandler(self, args)
    local tid = args.tid
    local count = args.count
    local targetId = args.targetId
    local use_arg = args.use_args
    -- local isJumpView = args.isJumpView
    local hasCount = bag.BagManager:getPropsCountByTid(tid)
    if (hasCount >= count) then
        -- self:__checkIsCanUse(propsList, count, isJumpView, targetId, true)
        --- *c2s* 使用物品byTid 17003
        SOCKET_SEND(Protocol.CS_USE_BY_TID, {tid = tid, target = targetId, count = count, use_args = use_arg})
    end
end

-- 通过道具tid批量使用不同道具
function __onUseMorePropsTidHandler(self, args)
    SOCKET_SEND(Protocol.CS_USE_MORE_TID, {use_list = args})
end

-- function __checkIsCanUse(self, cusPropsVo, cusCount, cusIsJumpView, cusTargetId, cusIsUseTid)
-- if(isJumpView) then
--         gs.Message.Show("跳转道具使用界面")
--         return
-- end
-- if(cusIsUseTid) then
-- --- *c2s* 使用物品byTid 17003
-- SOCKET_SEND(Protocol.CS_USE_BY_TID, {tid = cusPropsVo.tid, target = cusTargetId, count = cusCount})
-- else
-- --- *c2s* 使用物品byId 17002
-- SOCKET_SEND(Protocol.CS_USE_BY_ID, {id = cusPropsVo.id, target = cusTargetId, count = cusCount})
-- end
-- end
-- 请求出售道具
function onReqSellProps(self)
    local sellData = bag.BagManager:getSellData()
    local pt_item_num = {item_id = sellData.id, num = sellData.num}
    SOCKET_SEND(Protocol.CS_SELL_ITEM, {item_list = {pt_item_num}})
end

-- 分解道具
function onReqBreakProps(self)
    local idList = bag.BagManager:getBreakList()
    SOCKET_SEND(Protocol.CS_DECOMPOSE_ITEM, {item_id_list = idList})
end

-- 道具加锁解锁
function onPropsLockHandler(self, args)
    local propsVo = args.propsVo
    local isLock = args.isLock
    if isLock == 1 then
        SOCKET_SEND(Protocol.CS_LOCK_ITEM, {item_id = propsVo.id, hero_id = propsVo.heroId})
        gs.Message.Show("锁定成功")
    else
        SOCKET_SEND(Protocol.CS_UNLOCK_ITEM, {item_id = propsVo.id, hero_id = propsVo.heroId})
        gs.Message.Show("解除锁定成功")
    end
end
-- 请求指定模块类型的所有阶段预览属性
function __onReqAllPreviewAttrHandler(self, args)
    -- previewType 1：请求装备所有等级强化属性
    -- previewType 2：请求英雄所有星级的进化属性
    SOCKET_SEND(Protocol.CS_ATTR_PREVIEW_ALL, {module_id = args.previewType, hero_id = args.heroId, param_int = args.param}, Protocol.SC_ATTR_PREVIEW_ALL)
end

-- 返回指定模块类型的所有阶段预览属性
function __onAllPreviewAttrHandler(self, msg)
    local heroId = msg.hero_id
    local previewType = msg.module_id
    local param = msg.param_int
    local allPreviewAttrList = msg.attr_preview
    if (previewType == hero.AllPreviewAttrType.EQUIP_STRENGTHEN) then -- 装备所有等级强化属性返回
        local equipVo = nil
        --if (heroId <= 0) then
        -- 背包中的装备
        equipVo = bag.BagManager:getPropsVoById(param)
        --else
        -- 英雄身上的装备
        --    local heroVo = hero.HeroManager:getHeroVo(heroId)
        --    equipVo = heroVo:getEquipById(param)
        --end
        if (equipVo) then
            equipVo:setAllLvStrengthenAttr(allPreviewAttrList)
            equip.EquipManager:dispatchEvent(equip.EquipManager.UPDATE_EQUIP_DETAIL_DATA, {heroId = equipVo.heroId, equipId = equipVo.id})
        else
            Debug:log_error("PropsController", "装备详细信息更新错误：找不到对应装备数据")
        end
    elseif (previewType == hero.AllPreviewAttrType.STAR_UP) then -- 英雄所有星级进化属性返回
        local heroVo = hero.HeroManager:getHeroVo(heroId)
        if (heroVo) then
            heroVo:setStarUpAllPreviewAttr(allPreviewAttrList)
        end
    elseif (previewType == hero.AllPreviewAttrType.FAVORABLE) then -- 英雄所有亲密度属性返回
        local heroVo = hero.HeroManager:getHeroVo(heroId)
        if (heroVo) then
            heroVo:setFavorablePreviewAttr(allPreviewAttrList)
        end

    elseif (previewType == hero.AllPreviewAttrType.BRACELET_TUPO) then --手环突破
        local equipVo = nil
        --if (heroId <= 0) then
        -- 背包中的装备
        equipVo = bag.BagManager:getPropsVoById(param)
        --else
        -- 英雄身上的装备
        --    local heroVo = hero.HeroManager:getHeroVo(heroId)
        --    equipVo = heroVo:getEquipById(param)
        --end
        if (equipVo) then
            equipVo:setAllBraceletsAttr(allPreviewAttrList)
            equip.EquipManager:dispatchEvent(equip.EquipManager.UPDATE_EQUIP_DETAIL_DATA, {heroId = equipVo.heroId, equipId = equipVo.id})
        else
            Debug:log_error("PropsController", "装备详细信息更新错误：找不到对应装备数据")
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
