module("purchase.GradeGiftController", Class.impl(Controller))

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
    -- GameDispatcher:addEventListener(EventName.REQ_MONTH_CARD_INFO, self.__onReqPanelInfoHandler, self)
    -- 请求领取等级礼包
    GameDispatcher:addEventListener(EventName.REQ_RECIVE_GRADE_GIFT, self.onReqGradeGiftHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.onUpdateBubble, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 月卡面板信息 24095
        SC_LEVEL_GIFT_PANEL = self.onResGradeGiftInfoHandler,
        SC_GAIN_LEVEL_GIFT = self.onResGradeGiftRecHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 更新等级礼包面板信息
function onResGradeGiftInfoHandler(self, msg)
    purchase.GradeGiftManager:parsePanelInfoMsg(msg)
    GameDispatcher:dispatchEvent(EventName.UPDATE_PANEL_BUBBLE)
end

-- 更新等级礼包领取信息
function onResGradeGiftRecHandler(self, msg)
    purchase.GradeGiftManager:parseGradeGiftRecedMsg(msg)
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求领取等级礼包
function onReqGradeGiftHandler(self, args)
    --- *c2s* 月卡面板信息 24094
    SOCKET_SEND(Protocol.CS_GAIN_LEVEL_GIFT, { gift_id = args.id })
end

function onUpdateBubble(self)
    --- *c2s* 月卡面板信息 24094
    GameDispatcher:dispatchEvent(EventName.UPDATE_PANEL_BUBBLE)
    purchase.GradeGiftManager:updateBubble()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]