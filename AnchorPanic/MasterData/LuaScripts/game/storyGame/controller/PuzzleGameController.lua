--[[ 
-----------------------------------------------------
@filename       : PuzzleGameController
@Description    : 剧情游戏——拼图游戏
@date           : 2020-12-14 14:47:38
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.controller.PuzzleGameController', Class.impl(Controller))


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
    GameDispatcher:addEventListener(EventName.OPEN_PUZZLE_GAME_PANEL, self.onOpenPuzzleView, self)
    GameDispatcher:addEventListener(EventName.OPEN_STORY_GAME_PANEL, self.onOpenStoryGameView, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 打开拼图界面
function onOpenPuzzleView(self, args)
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MAIL, true) == false then
    --     return
    -- end
    if self.mPuzzzleView == nil then
        self.mPuzzzleView = UI.new(storyGame.PuzzleGameView)
        self.mPuzzzleView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPuzzleViewHandler, self)
    end
    -- 剧情派发参数
    if (args) then
        self.storyArgs = args.data
    end
    self.mPuzzzleView:open()
end
-- ui销毁
function onDestroyPuzzleViewHandler(self)
    self.mPuzzzleView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPuzzleViewHandler, self)
    self.mPuzzzleView = nil

    -- 剧情派发参数
    if (self.storyArgs) then
        GameDispatcher:dispatchEvent(EventName.STORY_BACK_TO_STORY, self.storyArgs)
        self.storyArgs = nil
    end
end

-- 打开小游戏界面
function onOpenStoryGameView(self, args)
    if self.mStoryGame == nil then
        self.mStoryGame = UI.new(storyGame.StoryGameSelectView)
        self.mStoryGame:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStoryGameViewHandler, self)
    end
    self.mStoryGame:open()
end
-- ui销毁
function onDestroyStoryGameViewHandler(self)
    self.mStoryGame:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyStoryGameViewHandler, self)
    self.mStoryGame = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
