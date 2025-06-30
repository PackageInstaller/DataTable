module("fashion.FashionController", Class.impl(Controller))

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
    -- 打开时装界面
    GameDispatcher:addEventListener(EventName.OPEN_FASHION_PANEL, self.__onOpenFashionPanelHandler, self)
    -- 请求战员穿戴时装
    GameDispatcher:addEventListener(EventName.REQ_HERO_WEAR_FASHION, self.__onReqHeroWearFashionHandler, self)
    -- 请求单个战员穿戴时装数据
    GameDispatcher:addEventListener(EventName.REQ_HERO_FASHION_DATA, self.__onReqHeroFashionDataHandler, self)
    -- 请求战员时装解锁
    GameDispatcher:addEventListener(EventName.REQ_HERO_FASHION_UNLOCK, self.__onReqHeroFashionUnlockHandler, self)
    -- 请求穿戴时装部位
    GameDispatcher:addEventListener(EventName.REQ_WEAR_FASHION_COLOR, self.onReqWearFashionColor, self)
    -- 请求战员当前皮肤对应部位信息
    GameDispatcher:addEventListener(EventName.REQ_LOOK_FASHION_COLOR, self.onReqLookFashionColor, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 所有战员的穿戴时装 13108
        SC_ALL_FASHION_INFO = self.__onResAllHeroFashionListHandler,
        --- *s2c* 返回单个战员穿戴时装数据 13107
        SC_FASHION_INFO = self.__onResHeroWearFashionInfoHandler,
        --- *s2c* 返回战员穿戴时装结果 13105
        SC_WEAR_FASHION = self.__onResHeroWearFashionResultHandler,
        --- *s2c* 返回战员时装解锁结果 13110
        SC_UNLOCK_FASHION = self.__onResHeroFashionUnlockHandler,
        --- *s2c* 所有战员穿戴的炫彩时装 13341
        SC_FASHION_COLOR_INFO = self.__onParseFashionColorInfo,
        --- *s2c* 战员穿戴炫彩 13343
        SC_WEAR_FASHION_COLOR = self.__onParseWearFashionColor,
        --- *s2c* 查看战员时装的炫彩 13345
        SC_LOOK_FASHION_COLOR = self.__onParseLookFashionColor,
        --- *s2c* 解锁时装炫彩 13346
        SC_UNLOCK_FASHION_COLOR = self.__onPareseUnlockFashionColor,
        --- *s2c* 时装拥有信息 13350
        SC_HERO_FASHION_HAVE_INFO = self.__onParseHeroFashionHaveInfo,

    }
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求战员穿戴时装
function __onReqHeroWearFashionHandler(self, args)
    --- *c2s* 战员穿戴时装 13104
    SOCKET_SEND(Protocol.CS_WEAR_FASHION, { hero_id = args.heroId, fashion_id = args.fashionId, fashion_type = fashion.getMsgFashionType(args.fashionType) })
end

-- 请求单个战员穿戴时装数据
function __onReqHeroFashionDataHandler(self, args)
    --- *c2s* 战员时装信息 13106
    SOCKET_SEND(Protocol.CS_FASHION_INFO, { hero_id = args.heroId })
end

-- 请求战员时装解锁
function __onReqHeroFashionUnlockHandler(self, args)
    --- *c2s* 战员时装解锁 13109
    SOCKET_SEND(Protocol.CS_UNLOCK_FASHION, { hero_tid = args.heroTid, fashion_id = args.fashionId, fashion_type = fashion.getMsgFashionType(args.fashionType) })
end

--- *c2s* 战员穿戴炫彩 13342
function onReqWearFashionColor(self, args)
    SOCKET_SEND(Protocol.CS_WEAR_FASHION_COLOR, { hero_id = args.heroId, fashion_id = args.fashionId, color_id = args.colorId })
end

--- *c2s* 查看战员时装的炫彩 13344
function onReqLookFashionColor(self, args)
    SOCKET_SEND(Protocol.CS_LOOK_FASHION_COLOR, { hero_tid = args.heroTid, fashion_id = args.fashionId })
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 返回所有战员的穿戴时装
function __onResAllHeroFashionListHandler(self, msg)
    fashion.FashionManager:parseMsgFashionList(msg.all_hero_fashion_info)
end

-- 返回单个战员穿戴时装数据
function __onResHeroWearFashionInfoHandler(self, msg)
    fashion.FashionManager:parseMsgFashionInfo(msg.hero_fashion_info)
end

-- 返回战员穿戴时装结果
function __onResHeroWearFashionResultHandler(self, msg)
    if (msg.result == 1) then
        fashion.FashionManager:parseMsgWearFashionResult(msg.fashion_type, msg.hero_id, msg.fashion_id)
    else
        print("穿戴失败：", msg.hero_id, msg.fashion_type, msg.fashion_id)
    end
end

-- 返回战员时装解锁结果
function __onResHeroFashionUnlockHandler(self, msg)
    if (msg.result == 1) then
        if self.ReceiveFashionSuccess == nil then
            self.ReceiveFashionSuccess = fashion.ReceiveFashionSuccess.new()
            self.ReceiveFashionSuccess:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyReceiveFashionSuccessHandler, self)
        end
        self.ReceiveFashionSuccess:open(msg)
        fashion.FashionManager:parseHeroFashionAddHaveInfo(msg.fashion_type, msg.hero_tid, msg.fashion_id)
        if msg.fashion_coin_num <= 0 then
            fashion.FashionManager:parseMsgWearFashionUnlock(msg.fashion_type, msg.hero_tid, msg.fashion_id)
        end
        
       
    else
        print("解锁失败：", msg.hero_tid, msg.fashion_type, msg.fashion_id)
    end
end

--- *s2c* 所有战员穿戴的炫彩时装 13341
function __onParseFashionColorInfo(self, msg)
    fashion.FashionManager:parseFashionColorInfoMsg(msg)
end
--- *s2c* 战员穿戴炫彩 13343
function __onParseWearFashionColor(self, msg)
    if msg.result == 1 then
        gs.Message.Show("替换成功")
    end
    fashion.FashionManager:onParseWearFashionColorMsg(msg)
end
--- *s2c* 查看战员时装的炫彩 13345
function __onParseLookFashionColor(self, msg)
    if msg.result == 0 then
        gs.Message.Show("查询皮肤部位信息出现错误！")
        return
    end
    fashion.FashionManager:parseLookFashionColorMsg(msg)
end
--- *s2c* 解锁时装炫彩 13346
function __onPareseUnlockFashionColor(self, msg)

end

--- *s2c* 时装拥有信息 13350
function __onParseHeroFashionHaveInfo(self,msg)
    fashion.FashionManager:parseHeroFashionHaveInfo(msg)
end

------------------------------------------------------------------------ 时装面板 ------------------------------------------------------------------------
function __onOpenFashionPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_FASHION, true) == false then
        return
    end

    local heroTid = nil
    local heroId = nil
    local type = nil
    if args then
        if args.propsVo then
            -- 背包道具跳转
            heroTid = args.propsVo.effectList[1]
            heroId = hero.HeroManager:getHeroIdByTid(heroTid)
            type = fashion.Type.CLOTHES
        else
            heroId = args.heroId
            type = args.type
        end
    else
        heroId = showBoard.ShowBoardManager:getHeroScrollList(nil, showBoard.panelSortType.LEVEL, true, {})[1]:getDataVo().heroId
        type = fashion.Type.CLOTHES
    end

    fashion.FashionManager:setHeroId(heroId)

    if self.m_fashionPanel == nil then
        self.m_fashionPanel = fashion.FashionPanel.new()
        self.m_fashionPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFashionPanelHandler, self)
    end
    self.m_fashionPanel:open({ type = type })
end

function onDestroyFashionPanelHandler(self)
    self.m_fashionPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFashionPanelHandler, self)
    self.m_fashionPanel = nil
end

function onDestroyReceiveFashionSuccessHandler(self)
    self.ReceiveFashionSuccess:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyReceiveFashionSuccessHandler, self)
    self.ReceiveFashionSuccess = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]