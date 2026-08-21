module("marriage.MarriageController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_MARRIAGE_USE_VIEW, self.onOpenMarriageUseView, self)
    GameDispatcher:addEventListener(EventName.OPEN_MARRIAGE_RENAME_VIEW, self.onOpenMarriageReNameView, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MARRIAGE_RENAME_VIEW, self.onCloseMarriageReNameView, self)
    

    GameDispatcher:addEventListener(EventName.OPEN_MARRIAGE_INFO_VIEW, self.onOpenMarriageInfoView, self)
    GameDispatcher:addEventListener(EventName.OPEN_MARRIAGE_SUCCEED_VIEW, self.onOpenMarriageSucceedView, self)
    

    GameDispatcher:addEventListener(EventName.REQ_MARRIAGE_HERO, self.onReqMarriageHeroHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_MARRIAGE_RENICKNAME, self.onReqMarriageReNameHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_SAVE_MARRIAGE_SIGNPOS, self.onReqMarriageSignposHandler, self)
    
    
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_PROMISE_HERO_RESULT = self.onPromiseHeroResultHandler,
        SC_PROMISE_RENICKNAME = self.onPromiseRenickNameResultHandler,
        SC_PROMISE_SIGN_POS_RESULT = self.onPromiseSignposResultHandler,
    }
    
end

function onReqMarriageHeroHandler(self,args)
    SOCKET_SEND(Protocol.CS_PROMISE_HERO,{hero_id = args.heroId},Protocol.SC_PROMISE_HERO_RESULT)
end

function onReqMarriageReNameHandler(self,args)
    SOCKET_SEND(Protocol.CS_PROMISE_RENICKNAME,{hero_id = args.heroId,name = args.name},Protocol.SC_PROMISE_RENICKNAME)
end

function onReqMarriageSignposHandler(self,args)
    SOCKET_SEND(Protocol.CS_PROMISE_SIGN_POS,{hero_id = args.heroId, sign_pos = args.signPos},Protocol.SC_PROMISE_SIGN_POS_RESULT)
end
function onPromiseHeroResultHandler(self,msg)
    if msg.result == 1 then
        marriage.MarriageManager:setMarriageSucceed(true)
        --gs.Message.Show("结婚成功")
        --
    end
end

function onPromiseRenickNameResultHandler(self,msg)
    if msg.result == 1 then
        gs.Message.Show(_TT(152001))
        GameDispatcher:dispatchEvent(EventName.CLOSE_MARRIAGE_RENAME_VIEW)
    end
end

function onPromiseSignposResultHandler(self,args)
    if args.result == 1 then
        gs.Message.Show(_TT(152002))
        GameDispatcher:dispatchEvent(EventName.UPDATE_SAVE_MARRIAGE_SIGNPOS_SUCCESS)
        --GameDispatcher:dispatchEvent(EventName.OPEN_MARRIAGE_INFO_VIEW,{heroId = args.hero_id})
    end
end

function onOpenMarriageUseView(self,args)
    if self.marriageUseView == nil then
        self.marriageUseView = marriage.MarriageUseView.new()
        self.marriageUseView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryMarriageUseHandler, self)
    end
    self.marriageUseView:open(args)
end

function onDestoryMarriageUseHandler(self)
    self.marriageUseView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryMarriageUseHandler, self)
    self.marriageUseView = nil
end

function onOpenMarriageReNameView(self,args)
    if self.marriageReNameView == nil then
        self.marriageReNameView = marriage.MarriageReNameView.new()
        self.marriageReNameView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryMarriageReNameHandler, self)
    end
    self.marriageReNameView:open(args)
end

function onDestoryMarriageReNameHandler(self)
    self.marriageReNameView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryMarriageReNameHandler, self)
    self.marriageReNameView = nil
end

function onCloseMarriageReNameView(self,args)
    if self.marriageReNameView then
        self.marriageReNameView:close()
    end
end

function onOpenMarriageInfoView(self,args)
    if self.marriageInfoView == nil then
        self.marriageInfoView = marriage.MarriageInfoView.new()
        self.marriageInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryMarriageInfoHandler, self)
    end
    self.marriageInfoView:open(args)
end

function onDestoryMarriageInfoHandler(self)
    self.marriageInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryMarriageInfoHandler, self)
    self.marriageInfoView = nil
end

function onOpenMarriageSucceedView(self,args)
    if self.marriageSucceedView == nil then
        self.marriageSucceedView = marriage.MarriageSucceedView.new()
        self.marriageSucceedView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryMarriageSucceedHandler, self)
    end
    self.marriageSucceedView:open(args)
end

function onDestoryMarriageSucceedHandler(self)
    self.marriageSucceedView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryMarriageSucceedHandler, self)
    self.marriageSucceedView = nil
end

return _M