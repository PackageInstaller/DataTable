--[[ 
-----------------------------------------------------
@filename       : ReadGameController
@Description    : 剧情游戏——阅读文件
@date           : 2020-12-24 16:31:01
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.controller.ReadGameController', Class.impl(Controller))


--构造
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_READ_GAME_PANEL, self.onOpenGameView, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 打开接水管小游戏界面
function onOpenGameView(self, args)
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MAIL, true) == false then
    --     return
    -- end
    if self.mGameView == nil then
        self.mGameView = UI.new(storyGame.ReadGameView)
        self.mGameView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGameViewHandler, self)
    end
    -- 剧情派发参数
    if (args) then
        self.storyArgs = args.data
    end
    self.mGameView:open(args)
end
-- ui销毁
function onDestroyGameViewHandler(self)
    self.mGameView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyGameViewHandler, self)
    self.mGameView = nil

    -- 剧情派发参数
    if (self.storyArgs) then
        GameDispatcher:dispatchEvent(EventName.STORY_BACK_TO_STORY, self.storyArgs)
        self.storyArgs = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
