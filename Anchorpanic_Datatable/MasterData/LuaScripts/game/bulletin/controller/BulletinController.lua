--[[ 
-----------------------------------------------------
@filename       : BulletinController
@Description    : 游戏内公告控制器
@date           : 2020-08-04 11:18:08
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.bulletin.controller.BulletinController', Class.impl(Controller))

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
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.__onCheckBubbleHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BULLETIN_PANEL, self.onOpenView, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_SYSTEM_ANNOUNCE = self.onBulletinHandler
    }
end

--- *s2c* 系统公告 10032
function onBulletinHandler(self, msg)
    if msg then
        bulletin.BulletinManager:parseBulletinMsg(msg)
    end
end

-- 请求公告数据
function onReqBulletin(self)
    SOCKET_SEND(Protocol.CS_SYSTEM_ANNOUNCE)
end

function __onCheckBubbleHandler(self, args)
    if (args) then
        if (args.type == ReadConst.SYSTEM_BULLETIN) then
            bulletin.BulletinManager:updateBubble()
        end
    else
        bulletin.BulletinManager:updateBubble()
    end
end

-- 打开界面
function onOpenView(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BULLETIN, true) == false then
        return
    end
    if not args.type then
        args.type = bulletin.BulletinConst:getTabList()[1].page
    end

    if self.mPanel == nil then
        self.mPanel = UI.new(bulletin.BulletinPanel)
        self.mPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.mPanel:open(args)
    --self:onReqBulletin()
end
-- ui销毁
function onDestroyViewHandler(self)
    self.mPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]