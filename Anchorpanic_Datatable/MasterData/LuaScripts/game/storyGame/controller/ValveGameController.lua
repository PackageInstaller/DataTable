--[[ 
-----------------------------------------------------
@filename       : ValveGameController
@Description    : 剧情游戏——阀门游戏
@date           : 2020-12-14 14:47:38
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.controller.ValveGameController', Class.impl(Controller))


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
    GameDispatcher:addEventListener(EventName.OPEN_VALVE_GAME_PANEL, self.onOpenValveGameView, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 打开阀门游戏界面
function onOpenValveGameView(self, args)
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MAIL, true) == false then
    --     return
    -- end
    if self.mValveGameView == nil then
        self.mValveGameView = UI.new(storyGame.ValveGameView)
        self.mValveGameView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    -- 剧情派发参数
    if (args) then
        self.storyArgs = args.data
    end
    self.mValveGameView:open()
end
-- ui销毁
function onDestroyViewHandler(self)
    self.mValveGameView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mValveGameView = nil

    -- 剧情派发参数
    if (self.storyArgs) then
        GameDispatcher:dispatchEvent(EventName.STORY_BACK_TO_STORY, self.storyArgs)
        self.storyArgs = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
