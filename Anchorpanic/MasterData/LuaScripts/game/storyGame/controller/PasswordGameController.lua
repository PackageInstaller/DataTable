--[[ 
-----------------------------------------------------
@filename       : PasswordGameController
@Description    : 剧情游戏——密码锁
@date           : 2020-12-28 17:14:24
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.controller.PasswordGameController', Class.impl(Controller))


--构造
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_PASSWORD_GAME_PANEL, self.onOpenPasswordGameView, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 打开密码锁游戏界面
function onOpenPasswordGameView(self, args)
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MAIL, true) == false then
    --     return
    -- end
    if self.mPasswordGameView == nil then
        self.mPasswordGameView = UI.new(storyGame.PasswordGameView)
        self.mPasswordGameView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    -- 剧情派发参数
    if (args) then
        self.storyArgs = args.data
    end
    self.mPasswordGameView:open()
end
-- ui销毁
function onDestroyViewHandler(self)
    self.mPasswordGameView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mPasswordGameView = nil

    -- 剧情派发参数
    if (self.storyArgs) then
        GameDispatcher:dispatchEvent(EventName.STORY_BACK_TO_STORY, self.storyArgs)
        self.storyArgs = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
