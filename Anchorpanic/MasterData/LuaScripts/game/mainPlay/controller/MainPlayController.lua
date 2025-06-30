module("mainPlay.MainPlayController",Class.impl(Controller)) 

--构造函数
function ctor(self, cusMgr)
    super.ctor(self,cusMgr)
    self:__init()
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:__init()
end

function __init(self)
   
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_MAINPLAY_PANEL, self.__onMainPlayHandler, self)
end

function __onMainPlayHandler(self,args)
    if not args then
        args = {}
    end
    if not args.type then
        args.type = mainPlay.MainPlayConst.MAINPLAY_MAIN -- 页签索引
    end

    if self.mMainPlayView == nil then
        self.mMainPlayView = mainPlay.MainPlayView.new()
        self.mMainPlayView:addEventListener(View.EVENT_VIEW_DESTROY,self.onMainPlayViewDestroyHandler,self)
    end
    self.mMainPlayView:open(args)
    if(args.subPage) then 
        GameDispatcher:dispatchEvent(EventName.CHANGE_STORY_PANEL, args.subPage)
    end
end

function onMainPlayViewDestroyHandler(self)
    self.mMainPlayView:removeEventListener(View.EVENT_VIEW_DESTROY,self.onMainPlayViewDestroyHandler,self)
    self.mMainPlayView = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
