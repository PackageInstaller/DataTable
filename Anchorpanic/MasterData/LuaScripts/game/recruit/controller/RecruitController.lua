module("recruit.RecruitController", Class.impl(Controller))
--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)

    self.canSendRecruitHero = true
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    if self.m_heroRecruitPanel then
        self.m_heroRecruitPanel:close()
    end
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 打开英雄招募面板
    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_PANEL, self.onOpenHeroRecruitPanelHandler, self)
    GameDispatcher:addEventListener(EventName.Close_RECRUIT_PANEL, self.onCloseHeroRecruitPanelHandler, self)
    --打开新手招募结果确定窗口
    GameDispatcher:addEventListener(EventName.OPEN_RECRUITNEWPLAYRESULIT_PANEL, self.onOpenRecruitNewPlayResulitPanelHandler, self)

    -- 打开英雄招募日志面板
    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_LOG_PANEL, self.onOpenHeroRecruitLogPanelHandler, self)
    -- 打开英雄招募规则面板
    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_RULE_PANEL, self.onOpenHeroRecruitRulePanelHandler, self)
    -- 关闭英雄招募规则面板
    GameDispatcher:addEventListener(EventName.CLOSE_RECRUIT_RULE_PANEL, self.onCloseHeroRecruitRulePanelHandler, self)
    -- 打开英雄招募拨号面板
    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_DIAL_PANEL, self.onOpenHeroRecruitDialPanelHandler, self)
    -- 打开英雄招募临时面板
    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_TEMP_PANEL, self.onOpenRecruitTmpPanelHandler, self)

    -- 打开抽卡视频播放界面
    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_MASKVIEW, self.onOpenRecuitMaskView, self)
    GameDispatcher:addEventListener(EventName.CLOSE_RECRUIT_MASKVIEW, self.onCloseRecuitMaskView, self)

    --背包数据更新
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    --主题活动试玩红点更新
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updateRedState, self)

    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateRedState, self)

    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_DATA_UPDATE, self.updateRedState, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_TYPE_UPDATE, self.updateRedState, self)
    shop.ShopManager:addEventListener(shop.ShopManager.EVENT_SHOP_ITEM_UPDATE, self.updateRedState, self)

    -- 打开招募单人展示
    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, self.openRecruitShowOneView, self)
    --打开手环展示
    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_CARD_SHOW_ONE_VIEW, self.openRecruitCardShowOneView, self)
    -- 打开招募十连总览
    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_SHOW_ALL_VIEW, self.onOpenRecruitShowAllView, self)
    GameDispatcher:addEventListener(EventName.CLOSE_RECRUIT_SHOW_ALL_VIEW, self.onCloseRecruitShowAllViewHandlerHandler, self)

    --打开手环十连
    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_CARD_SHOW_ALL_VIEW, self.onOpenRecruitCardShowAllView, self)
    --打开跳过界面
    GameDispatcher:addEventListener(EventName.OPENRECRUITSKIPVIEW, self.onOpenRecruitSkipView, self)
    GameDispatcher:addEventListener(EventName.CLOSERECRUITSKIPVIEW, self.onCloseRecruitSkipView, self)

    GameDispatcher:addEventListener(EventName.OPEN_MAINACTIVITY_TRIAL_PANEL, self.onOpenMainActivityTrialPanelHandler, self)

    --抽卡结束
    GameDispatcher:addEventListener(EventName.RECRUIT_FINISH, self.onRecruitOver, self)

    GameDispatcher:addEventListener(EventName.OPEN_RECRUIT_APP_SELECTPANEL, self.openRecruitAppSelectHeroPanel, self)
    GameDispatcher:addEventListener(EventName.CLOSE_RECRUIT_APP_SELECTPANEL, self.closeRecruitAppSelectHeroPanel, self)

    --商店购买返回
    GameDispatcher:addEventListener(EventName.SHOPBUYSUCCESS, self.shopBuySucce, self)

    -- 请求招募战员
    GameDispatcher:addEventListener(EventName.REQ_RECRUIT_HERO, self.onReqRecruitHeroHandler, self)
    --招募
    GameDispatcher:addEventListener(EventName.SEND_RECRUIT, self.onRecruitSend, self)
    -- 请求新手招募上一次结果
    GameDispatcher:addEventListener(EventName.REQ_NEWPLAY_RECRUIT_RESULT, self.onReqNewPlayRecruitHero, self)
    --请求确定新手招募结果
    GameDispatcher:addEventListener(EventName.REQ_CONFIRM_NEWPLAY_RECRUIT_RESULT, self.onNewPlayRecruitResultConfirm, self)

    -- 请求招募日志
    GameDispatcher:addEventListener(EventName.REQ_RECRUIT_LOG, self.onReqRecruitLogHandler, self)

    --请求选择定向卡池目标
    GameDispatcher:addEventListener(EventName.REQ_APP_RECRUITSELECTTID, self.onReqRecruitSelectTid, self)

    -- GameDispatcher:addEventListener(EventName.OPEN_HERO_DISMISS_PANEL, self.onOpenHeroDismissPanel, self)
    -- GameDispatcher:addEventListener(EventName.OPEN_HERO_DISMISS_PRE_PANEL, self.onOpenHeroDismissPrePanel, self)
    -- GameDispatcher:addEventListener(EventName.OPEN_HERO_DISMISS_SURE_PANEL, self.onOpenHeroDismissSurePanel, self)
    --GameDispatcher:addEventListener(EventName.REQ_HERO_DISMISS, self.__onReqHeroDismissHandler, self)

    -- 请求活动招募最大保底领取
    -- GameDispatcher:addEventListener(EventName.REQ_RECRUIT_GUARANTEED_PLUS, self.__onReqRecruitGuaranteedPlusHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 招募信息 13050
        SC_RECRUIT_INFO = self.onResRecruitInfoHandler,
        --- *s2c* 招募战员 13052
        SC_RECRUIT_ITEM = self.onResRecruitHandler,
        --- *s2c* 查看招募日志 13054
        SC_GET_RECRUIT_LOG = self.onResRecruitLogHandler,

        --- *s2c* 战员退役 13131
        SC_HERO_RETIRE = self.onResDismissHandler,

        --- *s2c* 新手招募 13293
        SC_RECRUIT_HERO_NEW_PREPARE = self.onResNewPlayRecruitInfoHandler,
        ---* s2c * 新手招募保存的招募列表 13291
        SC_RECRUIT_HERO_NEW_SAVE_LIST = self.onResNewPlayRecruitHero,
        --- *s2c* 新手招募确认 13295
        SC_RECRUIT_HERO_NEW_CONFIRM = self.onResNewPlayRecruitConfirmResult,
        --- *s2c* 限定up池招募大保底信息 13057
        SC_RECRUIT_DEBUG_UP_INFO = self.onDebugShowRecruitUpInfo,

        --- *s2c* 自选up选择 13059
        SC_SELECT_RECRUIT = self.onResAppRecruitSelectTid,

        --- *s2c* 战员试玩信息 19601
        SC_HERO_TRY_INFO = self.onRes_Activity_Trial_Handler

        --- *s2c* 领取保底奖励 13056
        -- SC_RECRUIT_GUARANTEED_AWARD = self.onResRecruitGuaranteedPlusHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------

--- *s2c* 限定up池招募大保底信息 13057
function onDebugShowRecruitUpInfo(self, msg)
    recruit.RecruitManager:onDebugShowRecruitUpInfoMsg(msg)
end

--- *s2c* 自选up选择 13059
function onResAppRecruitSelectTid(self, msg)
    if msg.result == 0 then
        gs.Message.Show("选择失败")
        return
    end

    GameDispatcher:dispatchEvent(EventName.RES_APP_RECRUITSELECTTID)
end

--- *s2c* 新手招募确认 13295
function onResNewPlayRecruitConfirmResult(self, msg)
    if msg.result == 1 then
        self:onCloseRecruitNewPlayResulitPanelHandler()
        self:onCloseRecruitShowAllViewHandlerHandler()
        GameDispatcher:dispatchEvent(EventName.RECRUIT_FINISH)
        gs.Message.Show(_TT(28039))
    else
        gs.Message.Show("确认结果失败")
    end
end

--* s2c * 新手招募保存的招募列表 13291（上一次新手抽卡的结果战员）
function onResNewPlayRecruitHero(self, msg)
    if not table.empty(msg.item_list) then
        local recruit_id = recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_NEW_PLAYER)
        recruit.RecruitManager:setRecruitActionId(recruit_id)

        local recruitResultList = {}
        for i = 1, #msg.item_list do
            local resultVo = recruit.RecruitReslutVo.new()
            resultVo:parseMsgData(msg.item_list[i])
            table.insert(recruitResultList, resultVo)
        end

        recruit.RecruitManager:setRecruitHeroResultList(recruitResultList)
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ALL_VIEW)
    end
end

--- *s2c* 新手招募 13293
function onResNewPlayRecruitInfoHandler(self, msg)
    self.canSendRecruitHero = true

    if (msg.result == 1) then
        local recruit_id = recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_NEW_PLAYER)
        recruit.RecruitManager:setRecruitActionId(recruit_id)

        local recruitResultList = {}
        for i = 1, #msg.item_list do
            local resultVo = recruit.RecruitReslutVo.new()
            resultVo:parseMsgData(msg.item_list[i])
            table.insert(recruitResultList, resultVo)
        end

        recruit.RecruitManager:setRecruitHeroResultList(recruitResultList)
        self:onOpenHeroRecruitMap()

        GameDispatcher:dispatchEvent(EventName.UPDATE_RECRUIT_PANEL, {type = recruit.RecruitType.RECRUIT_NEW_PLAYER})
    else
        gs.Message.Show(_TT(28004)) --"招募失败"
    end
end

--- *s2c* 招募信息 13050
function onResRecruitInfoHandler(self, msg)
    recruit.RecruitManager:parseRecruitInfo(msg)
    self:updateRedState()
end

--- *s2c* 招募战员 13052
function onResRecruitHandler(self, msg)
    self.canSendRecruitHero = true

    if (msg.result == 1) then
        recruit.RecruitManager:setRecruitActionId(msg.recruit_id)
        local type = recruit.RecruitManager:getRecruitTypeById(msg.recruit_id)

        if type == recruit.RecruitType.RECRUIT_BRACELETS or type == recruit.RecruitType.RECRUIT_APP_BRACELETS or type == recruit.RecruitType.RECRUIT_ACTIVITY_2 then
            if subPack.SubDownLoadController:isExistNeedUpdate() then
                if #msg.detail_item_list > 1 then
                    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_CARD_SHOW_ALL_VIEW, msg.detail_item_list)
                elseif #msg.detail_item_list == 1 then

                    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_CARD_SHOW_ONE_VIEW, {tid = msg.detail_item_list[1].tid, propsList = propsList, isNoSkip = true})
                end

                gs.Message.Show("请等待资源下载完成获得最佳体验")
                return
            else
                recruit.RecruitManager:setRecruitCardResultList(msg.detail_item_list)
                GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.RECRUIT_CARD)
            end
        else
            local recruitResultList = {}
            for i = 1, #msg.item_list do
                local resultVo = recruit.RecruitReslutVo.new()
                resultVo:parseMsgData(msg.item_list[i])
                table.insert(recruitResultList, resultVo)
            end

            recruit.RecruitManager:setRecruitHeroResultList(recruitResultList)
            self:onOpenHeroRecruitMap()
        end

        GameDispatcher:dispatchEvent(EventName.UPDATE_RECRUIT_PANEL, {type = type})
    else
        gs.Message.Show(_TT(28004)) --"招募失败"
    end
end

--- *s2c* 查看招募日志 13054
function onResRecruitLogHandler(self, msg)
    -- logAll(msg, " *s2c* 查看招募日志 13054---")
    recruit.RecruitManager:updateRecruitLog(msg)
end

function onResDismissHandler(self, msg)
    recruit.RecruitManager:setDismissResResult(msg)
end

--[[--- *s2c* 领取保底奖励 13056
function onResRecruitGuaranteedPlusHandler(self, msg)
    if (msg.result == 1) then
        local vo = recruit.RecruitManager:getRecruitInfo(msg.type)
        if (vo) then
            vo.is_guaranteed_award = 1
            gs.Message.Show2("领取成功")
            GameDispatcher:dispatchEvent(EventName.UPDATE_RECRUIT_GUARANTEED_PLUS, {type = msg.type})
        end
    else
        gs.Message.Show2("领取失败")
    end
end--]]

--购买返回
function shopBuySucce(self, propTid)
    if not self.m_CurRecruitTimes then return end

    local costTid = 0
    local configVo = recruit.RecruitManager:getRecruitConfigVo(self.m_CurRecruitId)
    if (self.m_CurRecruitTimes == 1) then
        costTid = configVo:getCostOneId()
    elseif (self.m_CurRecruitTimes == 10) then
        costTid = configVo:getCostTenId()
    end

    if costTid ~= propTid then return end

    self:onRecruitSend({recruitId = self.m_CurRecruitId, times = self.m_CurRecruitTimes})
end

--- *s2c* 战员试玩信息 19601
function onRes_Activity_Trial_Handler(self, msg)
    -- logAll(msg, "*s2c* 战员试玩信息 19601--------------")
    recruit.RecruitManager:updateTrialStateMsg(msg)
end

---------------------------------------------------------------请求-----------------------------------------------------------------

--- *c2s* 自选up选择 13058
function onReqRecruitSelectTid(self, args)
    local cmd = {recruit_id = args.recruit_id, select_tid = args.tid}
    logAll(cmd, "*c2s* 自选up选择 13058")
    SOCKET_SEND(Protocol.CS_SELECT_RECRUIT, cmd, Protocol.SC_SELECT_RECRUIT)
end

-- 招募站员
function onRecruitSend(self, args)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(args.recruitId)
    local costTid = 0
    local costCount = 0
    if (args.times == 1) then
        local RecruitInfo = recruit.RecruitManager:getRecruitInfo(args.recruitId)
        local RecruitConfigVo = recruit.RecruitManager:getRecruitConfigVo(args.recruitId)
        if RecruitInfo.free_times < RecruitConfigVo.free_times then
            self:onReqRecruitHeroHandler({recruitId = args.recruitId, times = args.times})
            self.m_CurRecruitId = nil
            self.m_CurRecruitTimes = nil

            return
        end

        costTid = configVo:getCostOneId()
        costCount = configVo:getCostOneNum()
    elseif (args.times == 10) then
        costTid = configVo:getCostTenId()
        costCount = configVo:getCostTenNum()
    end

    local hasCount = MoneyUtil.getMoneyCountByTid(costTid)
    if (hasCount >= costCount) then
        self:onReqRecruitHeroHandler({recruitId = args.recruitId, times = args.times})
        self.m_CurRecruitId = nil
        self.m_CurRecruitTimes = nil
    else
        local itemVo = props.PropsManager:getPropsConfigVo(costTid)
        if itemVo.type == 0 then
            logError("道具不足，商城无出售")
            return
        end

        local shopVo = shop.ShopManager:getShopItemByTid(ShopType.NOMAL, costTid)
        if (shopVo) then
            local needCount = costCount - hasCount
            local needMoney = needCount * shopVo:getPrice()
            local moneyTid = shopVo:getRealPayType()
            local moneyName = props.PropsManager:getName(moneyTid)

            local buyCall = function()
                local hasMoney = MoneyUtil.getMoneyCountByTid(moneyTid)
                if (hasMoney >= needMoney) then
                    self.m_CurRecruitId = args.recruitId
                    self.m_CurRecruitTimes = args.times
                    GameDispatcher:dispatchEvent(EventName.REQ_SHOP_BUY, {type = shopVo:getType(), id = shopVo:getId(), num = needCount})
                else
                    local deletionMoney = needMoney - hasMoney
                    UIFactory:alertMessge(_TT(67, deletionMoney), true, function()
                        local sum = MoneyUtil.getMoneyCountByTid(MoneyTid.PAY_ITIANIUM_TID)
                        if sum >= deletionMoney then
                            GameDispatcher:dispatchEvent(EventName.REQ_CONVERT_TITANIUM, {num = deletionMoney, aTid = MoneyTid.PAY_ITIANIUM_TID, bTid = moneyTid})
                        else
                            UIFactory:alertMessge(_TT(66), true, function()
                                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Purchase})
                            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
                        )
                    end

                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
            end
        end

        local costName = props.PropsManager:getName(costTid)
        UIFactory:alertMessge(_TT(28038, needCount, costName, needMoney, moneyName), true, buyCall, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)

    else
        gs.Message.Show(_TT(156))--"道具不足"
    end
end
end

-- 请求招募战员
function onReqRecruitHeroHandler(self, args)
    -- logAll(args, "请求招募")
    if not self.canSendRecruitHero then return end

    --新手招募走另外一条协议
    local type = recruit.RecruitManager:getRecruitTypeById(args.recruitId)
    if type == recruit.RecruitType.RECRUIT_NEW_PLAYER then
        SOCKET_SEND(Protocol.CS_RECRUIT_HERO_NEW_PREPARE, {})
    else
        local recruitId = args.recruitId
        local times = args.times
        --- *c2s* 招募战员 13039
        SOCKET_SEND(Protocol.CS_RECRUIT_ITEM, {recruit_id = recruitId, times = times}, Protocol.SC_RECRUIT_ITEM)
    end

    self.canSendRecruitHero = false
end

--新手招募结果确定
function onNewPlayRecruitResultConfirm(self)
    SOCKET_SEND(Protocol.CS_RECRUIT_HERO_NEW_CONFIRM, {})
end

--请求上一次新手抽卡抽到的战员
function onReqNewPlayRecruitHero(self)
    SOCKET_SEND(Protocol.CS_RECRUIT_HERO_NEW_SAVE_LIST, {})
end

-- 请求招募日志
function onReqRecruitLogHandler(self, args)
    local recruit_id = args.recruit_id
    --- *c2s* 查看招募日志 13041
    SOCKET_SEND(Protocol.CS_GET_RECRUIT_LOG, {recruit_id = recruit_id}, Protocol.SC_GET_RECRUIT_LOG)
end

--遣散战员
function __onReqHeroDismissHandler(self, args)
    SOCKET_SEND(Protocol.CS_HERO_RETIRE, {cost_hero_list = args.ids})
end

-- --请求活动招募最大保底领取
-- function __onReqRecruitGuaranteedPlusHandler(self, args)
--     local type = args.type
--     --- *c2s* 领取保底奖励 13055
--     SOCKET_SEND(Protocol.CS_RECRUIT_GUARANTEED_AWARD, { type = type })
-- end

------------------------------------------------------------------------ 新手抽卡结果确定弹窗 ------------------------------------------------------------------------

--打开新手抽卡结果确定弹窗
function onOpenRecruitNewPlayResulitPanelHandler(self, args)
    if self.m_RecruitNewPlayResulitPanel == nil then
        self.m_RecruitNewPlayResulitPanel = recruit.RecruitNewPlayResulitPanel.new()
        self.m_RecruitNewPlayResulitPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitNewPlayResulitPanelHandler, self)
    end
    self.m_RecruitNewPlayResulitPanel:open(args)
end

function onDestroyRecruitNewPlayResulitPanelHandler(self)
    self.m_RecruitNewPlayResulitPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitNewPlayResulitPanelHandler, self)
    self.m_RecruitNewPlayResulitPanel = nil
end

--关闭新手抽卡结果确定弹窗
function onCloseRecruitNewPlayResulitPanelHandler(self)
    if self.m_RecruitNewPlayResulitPanel == nil then
        return
    end
    self.m_RecruitNewPlayResulitPanel:close()
end

--抽卡结束
function onRecruitOver(self)
    if map.MapLoader:getCurSceneType() == MAP_TYPE.MAIN_CITY then
        return
    end

    local curRecruitType = recruit.RecruitManager:getRecruitActionType()
    local linkCode = LinkCode.RecruitSuper

    if curRecruitType == recruit.RecruitType.RECRUIT_TOP then
        linkCode = LinkCode.RecruitSuper
    elseif curRecruitType == recruit.RecruitType.RECRUIT_COMMON then
        linkCode = LinkCode.RecruitNomal
    elseif curRecruitType == recruit.RecruitType.RECRUIT_NEW_PLAYER then
        linkCode = LinkCode.RecruitNewPlayer
    elseif curRecruitType == recruit.RecruitType.RECRUIT_BRACELETS then
        linkCode = LinkCode.RecruitBracelets
    elseif curRecruitType == recruit.RecruitType.RECRUIT_ACTIVITY_1 then
        linkCode = LinkCode.RecruitActivity
    elseif curRecruitType == recruit.RecruitType.RECRUIT_ACTIVITY_2 then
        linkCode = LinkCode.RecruitBraceletsActivity
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_MASKVIEW)

    mainui.MainUIManager:setWaitOpenUIcode(linkCode)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
end

------------------------------------------------------------------------ 英雄招募面板 ------------------------------------------------------------------------

function onOpenHeroRecruitPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, true) == false then
        return
    end

    if self.m_heroRecruitPanel == nil then
        self.m_heroRecruitPanel = recruit.RecruitPanel.new()
        self.m_heroRecruitPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroRecruitPanelHandler, self)
    end

    local recruitId = recruit.RecruitManager:getRecruitActionId()
    if (recruitId) then
        recruit.RecruitManager:setRecruitActionId(nil)
    else
        if (args and args.recruitId) then
            recruitId = args.recruitId
        else
            recruitId = recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_NEW_PLAYER)
        end
    end
    self.m_heroRecruitPanel:open({recruitId = recruitId})
    GameDispatcher:dispatchEvent(EventName.CLOSE_RECRUIT_MASKVIEW)
end

function onDestroyHeroRecruitPanelHandler(self)
    self.m_heroRecruitPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroRecruitPanelHandler, self)
    self.m_heroRecruitPanel = nil
end

function onCloseHeroRecruitPanelHandler(self)
    if self.m_heroRecruitPanel == nil then
        return
    end
    self.m_heroRecruitPanel:close()
end

------------------------------------------------------------------------ 英雄招募日志面板 ------------------------------------------------------------------------
function onOpenHeroRecruitLogPanelHandler(self, args)
    if self.m_heroRecruitLogPanel == nil then
        self.m_heroRecruitLogPanel = recruit.RecruitLogPanel.new()
        self.m_heroRecruitLogPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroRecruitLogPanelHandler, self)
    end
    self.m_heroRecruitLogPanel:open(args)
end

function onDestroyHeroRecruitLogPanelHandler(self)
    self.m_heroRecruitLogPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroRecruitLogPanelHandler, self)
    self.m_heroRecruitLogPanel = nil
end

------------------------------------------------------------------------ 英雄招募规则面板 ------------------------------------------------------------------------
function onOpenHeroRecruitRulePanelHandler(self, args)
    if self.m_heroRecruitRulePanel == nil then
        self.m_heroRecruitRulePanel = recruit.RecruitRulePanel.new()
        self.m_heroRecruitRulePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroRecruitRulePanelHandler, self)
    end
    self.m_heroRecruitRulePanel:open(args)
end

function onDestroyHeroRecruitRulePanelHandler(self)
    self.m_heroRecruitRulePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroRecruitRulePanelHandler, self)
    self.m_heroRecruitRulePanel = nil
end

function onCloseHeroRecruitRulePanelHandler(self)
    if not self.m_heroRecruitRulePanel then return end

    self.m_heroRecruitRulePanel:close()
end

------------------------------------------------------------------------ 英雄招募拨号面板 ------------------------------------------------------------------------
function onOpenHeroRecruitDialPanelHandler(self, args)
    if self.m_heroRecruitDialPanel == nil then
        self.m_heroRecruitDialPanel = recruit.RecruitDialPanel.new()
        self.m_heroRecruitDialPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroRecruitDialPanelHandler, self)
    end
    self.m_heroRecruitDialPanel:open(args)
end

function onDestroyHeroRecruitDialPanelHandler(self)
    self.m_heroRecruitDialPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroRecruitRulePanelHandler, self)
    self.m_heroRecruitDialPanel = nil
end

------------------------------------------------------------------------ 英雄招募成功面板 ------------------------------------------------------------------------
function __onOpenRecruitSucPanelHandler(self, args)
    if self.m_recruitSucPanel == nil then
        self.m_recruitSucPanel = recruit.RecruitSucPanel.new()
        self.m_recruitSucPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitSucPanelHandler, self)
    end
    local heroTidList = args.heroTidList
    local times = args.times
    self.m_recruitSucPanel:open({times = times, heroTidList = heroTidList})
end

function onDestroyRecruitSucPanelHandler(self)
    self.m_recruitSucPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitSucPanelHandler, self)
    self.m_recruitSucPanel = nil
end

------------------------------------------------------------------------ 英雄招募临时面板 ------------------------------------------------------------------------
function onOpenRecruitTmpPanelHandler(self)
    if self.m_recruitTmpPanel == nil then
        self.m_recruitTmpPanel = recruit.RecruitTmpPanel.new()
        self.m_recruitTmpPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitTmpPanelHandler, self)
    end
    self.m_recruitTmpPanel:open()
end

function onDestroyRecruitTmpPanelHandler(self)
    self.m_recruitTmpPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitTmpPanelHandler, self)
    self.m_recruitTmpPanel = nil
end

------------------------------------------------------------------------ 英雄招募单人展示 ------------------------------------------------------------------------
--打开抽卡黑屏过渡界面
function onOpenRecuitMaskView(self, args)
    if self.mRecuitMaskView == nil then
        self.mRecuitMaskView = recruit.RecruitMaskView.new()
        self.mRecuitMaskView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecuitMaskViewHandler, self)
    end

    self.mRecuitMaskView:open(args)
end

function onCloseRecuitMaskView(self)
    if self.mRecuitMaskView and self.mRecuitMaskView.isPop then
        self.mRecuitMaskView:close()
    end
end

function onDestroyRecuitMaskViewHandler(self)
    self.mRecuitMaskView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecuitMaskViewHandler, self)
    self.mRecuitMaskView = nil
end

--打开英雄展示界面
function openRecruitShowOneView(self, heroData)
    if not heroData then return false end

    if self.mRecruitShowOneView == nil then
        self.mRecruitShowOneView = recruit.RecruitShowOneView.new()
        self.mRecruitShowOneView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitShowOneViewHandler, self)
    end

    self.mRecruitShowOneView:open(heroData)
end

function onDestroyRecruitShowOneViewHandler(self)
    self.mRecruitShowOneView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitShowOneViewHandler, self)
    self.mRecruitShowOneView = nil
end

--打开手环展示界面
function openRecruitCardShowOneView(self, heroData)
    if not heroData then return false end

    if self.mRecruitCardShowOneView == nil then
        self.mRecruitCardShowOneView = recruit.RecruitCardShowOneView.new()
        self.mRecruitCardShowOneView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitCardShowOneViewHandler, self)
    end

    self.mRecruitCardShowOneView:open(heroData)
end

function onDestroyRecruitCardShowOneViewHandler(self)
    self.mRecruitCardShowOneView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitCardShowOneViewHandler, self)
    self.mRecruitCardShowOneView = nil
end

--打开定向选择界面
function openRecruitAppSelectHeroPanel(self, args)
    if self.mRecruitSelectHeroPanel == nil then
        self.mRecruitSelectHeroPanel = recruit.RecruitSelectHeroPanel.new()
        self.mRecruitSelectHeroPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitSelectHeroPanelHandler, self)
    end

    self.mRecruitSelectHeroPanel:open(args)
end

function onDestroyRecruitSelectHeroPanelHandler(self)
    self.mRecruitSelectHeroPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitSelectHeroPanelHandler, self)
    self.mRecruitSelectHeroPanel = nil
end

--关闭新手抽卡结果确定弹窗
function closeRecruitAppSelectHeroPanel(self)
    if self.mRecruitSelectHeroPanel == nil then
        return
    end
    self.mRecruitSelectHeroPanel:close()
end

------------------------------------------------------------------------ 英雄招募十连总览 ------------------------------------------------------------------------
function onOpenRecruitShowAllView(self, args)
    if self.mRecruitShowAllView == nil then
        self.mRecruitShowAllView = recruit.RecruitShowAllView.new()
        self.mRecruitShowAllView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitShowAllViewHandler, self)
    end
    self.mRecruitShowAllView:open(args)
end

function onDestroyRecruitShowAllViewHandler(self)
    self.mRecruitShowAllView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitShowAllViewHandler, self)
    self.mRecruitShowAllView = nil
end

--关闭新手抽卡结果确定弹窗
function onCloseRecruitShowAllViewHandlerHandler(self)
    if self.mRecruitShowAllView == nil then
        return
    end
    self.mRecruitShowAllView:close()
end

------------------------------------------------------------------------ 手环招募十连总览 ------------------------------------------------------------------------
function onOpenRecruitCardShowAllView(self, args)
    if self.mRecruitCardShowAllView == nil then
        self.mRecruitCardShowAllView = recruit.RecruitCardShowAllView.new()
        self.mRecruitCardShowAllView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitCardShowAllViewHandler, self)
    end
    self.mRecruitCardShowAllView:open(args)
end

function onDestroyRecruitCardShowAllViewHandler(self)
    self.mRecruitCardShowAllView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitCardShowAllViewHandler, self)
    self.mRecruitCardShowAllView = nil
end
------------------------------------------------------------------------ 跳过十连动画 ------------------------------------------------------------------------
function onOpenRecruitSkipView(self, args)
    if self.mRecruitSkipView == nil then
        self.mRecruitSkipView = recruit.RecruitSkipView.new()
        self.mRecruitSkipView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitSkipViewHandler, self)
    end
    self.mRecruitSkipView:open(args)
    self.mRecruitSkipView:refreshView(args)
end

function onCloseRecruitSkipView(self)
    if self.mRecruitSkipView and self.mRecruitSkipView.isPop then
        self.mRecruitSkipView:close()
    end
end

function onDestroyRecruitSkipViewHandler(self)
    self.mRecruitSkipView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecruitSkipViewHandler, self)
    self.mRecruitSkipView = nil
end

------------------------------------------------------------------------ 打开战员遣散面板 ------------------------------------------------------------------------
function onOpenHeroDismissPanel(self, args)
    if self.mHeroDismissPanel == nil then
        self.mHeroDismissPanel = recruit.HeroDisPanel.new() --recruit.HeroDismissPanel.new()
        self.mHeroDismissPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onHeroDismissDestroyHandler, self)
    end
    self.mHeroDismissPanel:open(args)
end

function onHeroDismissDestroyHandler(self)
    self.mHeroDismissPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onHeroDismissDestroyHandler, self)
    self.mHeroDismissPanel = nil
end

------------------------------------------------------------------------ 打开战员遣散预览面板 ------------------------------------------------------------------------
function onOpenHeroDismissPrePanel(self, args)
    if self.mHeroDismissPrePanel == nil then
        self.mHeroDismissPrePanel = recruit.HeroDisPrePanel.new() --recruit.HeroDismissPanel.new()
        self.mHeroDismissPrePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onHeroDismissPreDestroyHandler, self)
    end
    self.mHeroDismissPrePanel:open(args)
end

function onHeroDismissPreDestroyHandler(self)
    self.mHeroDismissPrePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onHeroDismissPreDestroyHandler, self)
    self.mHeroDismissPrePanel = nil
end

------------------------------------------------------------------------ 打开战员遣散预览面板 ------------------------------------------------------------------------
function onOpenHeroDismissSurePanel(self, args)
    if self.mHeroDismissSurePanel == nil then
        self.mHeroDismissSurePanel = recruit.HeroDisSurePanel.new() --recruit.HeroDismissPanel.new()
        self.mHeroDismissSurePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onHeroDismissSureDestroyHandler, self)
    end
    self.mHeroDismissSurePanel:open(args)
end

function onHeroDismissSureDestroyHandler(self)
    self.mHeroDismissSurePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onHeroDismissSureDestroyHandler, self)
    self.mHeroDismissSurePanel = nil
end

---进入战员招募
function onOpenHeroRecruitMap(self)
    if map.MapLoader:getCurSceneType() == MAP_TYPE.RECRUIT_HERO then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERORECRUIT_MAP)
    else
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.RECRUIT_HERO)
    end
end

---------------------------------1,1活动 试玩-----------------------\

function onOpenMainActivityTrialPanelHandler(self, args)
    if self.mMainActivityTrialPanel == nil then
        self.mMainActivityTrialPanel = mainActivity.MainActivityTrialPanel.new()
        self.mMainActivityTrialPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivityTrialPanel,
        self)
    end
    self.mMainActivityTrialPanel:open(args)
end

function onDestroyMainActivityTrialPanel(self)
    self.mMainActivityTrialPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainActivityTrialPanel, self)
    self.mMainActivityTrialPanel = nil
end

function onBagUpdateHandler(self)
    self:updateRedState()
end

--红点更新
function updateRedState(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, false) then
        if recruit.RecruitManager:updateNewPlayRedState() then
            mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, true)
            return
        end

        if recruit.RecruitManager:updatRecruitFreeRedState() then
            mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, true)
            return
        end

        local actTopRecruitList = recruit.RecruitManager:getRecruitConfigListByType(recruit.RecruitType.RECRUIT_ACTIVITY_1)
        for _, configVo in pairs(actTopRecruitList) do
            local menuVo = recruit.RecruitManager:getRecruitMenuVo(configVo.id)
            if menuVo:isOpenTime() then
                if funcopen.FuncOpenManager:isOpen(menuVo.funcId) then
                    if recruit.RecruitManager:getIsShowTrial(configVo:getTry_hero()) then
                        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, true)
                        return
                    end
                end
            end
        end

        if recruit.RecruitManager:updateActBraceletsShopRedState() then
            mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, true)
            return
        end

        if recruit.RecruitManager:updateAppBraceletsShopRedState() then
            mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, true)
            return
        end

        if not table.empty(shop.ShopManager:getShopItemData(ShopType.COVENANT)) then
            local recruitList = recruit.RecruitManager:getRecruitConfigListByType(recruit.RecruitType.RECRUIT_ACTIVITY_2)
            for _, configVo in pairs(recruitList) do
                if recruit.RecruitManager:updateActBraceletsShopBuyRedState(configVo.id) then
                    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, true)
                    return
                end
            end

            local recruitList = recruit.RecruitManager:getRecruitConfigListByType(recruit.RecruitType.RECRUIT_APP_BRACELETS)
            for _, configVo in pairs(recruitList) do
                if recruit.RecruitManager:updateAppBraceletsShopBuyRedState(configVo.id) then
                    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, true)
                    return
                end
            end
        end

        if recruit.RecruitManager:updateSeniorAppBraceletsRedState() then
            mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, true)
            return
        end

        if recruit.RecruitManager:updateSeniorAppActRedState() then
            mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, true)
            return
        end

        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_RECRUIT, false)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
