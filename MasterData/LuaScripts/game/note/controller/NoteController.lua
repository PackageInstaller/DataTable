--[[ 
-----------------------------------------------------
@filename       : NoteController
@Description    : 便签控制器
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('note.NoteController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.EVENT_UI_OPEN, self.onUIOpenHandler, self)
    GameDispatcher:addEventListener(EventName.EVENT_UI_CLOSE, self.onUICloseHandler, self)

    -- 好友初始化
    note.NoteManager:addEventListener(note.NoteManager.FRIEND_INIT, self.onFriendInitHandler, self)
    -- 好友更新
    note.NoteManager:addEventListener(note.NoteManager.FRIEND_UPDATE, self.onFriendUpdateHandler, self)
    
    -- 邮件初始化
    note.NoteManager:addEventListener(note.NoteManager.MAIL_INIT, self.onMailInitHandler, self)
    -- 邮件更新
    note.NoteManager:addEventListener(note.NoteManager.MAIL_UPDATE, self.onMailUpdateHandler, self)
    
    -- 功能开启更新
    note.NoteManager:addEventListener(note.NoteManager.FUN_OPEN_UPDATE, self.onFunOpenUpdateHandler, self)

    -- 删除某类型便签
    note.NoteManager:addEventListener(note.NoteManager.DEL_TYPE_NOTE, self.onDelTypeNoteHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

function onUIOpenHandler(self, args)
    -- 处于战斗和loading的特殊处理 
    if(not note.NoteManager:getEnableByLoading() or not note.NoteManager:getEnableByFight()) then
        return
    end
    local allOpenCount = gs.PopPanelManager.GetAllPanelCount(1)
    local willReShowCount = gs.PopPanelManager.GetWillReShowCount()
    local isFull = args.panelType == 1 or allOpenCount == 0
    -- print("\n打开了" .. args.panelName .. "，需要恢复的窗口数量:" .. willReShowCount .. "，指定条件的窗口数量:" .. allOpenCount)
    if(willReShowCount == 0 and isFull)then
        note.NoteManager:addEnableByUi(false)
        note.NoteManager:removeAllNote()
    end
end

function onUICloseHandler(self, args)
    -- 点击关闭全部的特殊处理
    local willByCloseAll = note.NoteManager:getWillByCloseAll()
    if(willByCloseAll)then
        note.NoteManager:setWillByCloseAll(false)
        note.NoteManager:addEnableByUi(true)
        note.NoteManager:checkDispatch()
        return
    end

    -- 处于战斗和loading的特殊处理
    if(not note.NoteManager:getEnableByLoading() or not note.NoteManager:getEnableByFight()) then
        return
    end
    local allOpenCount = gs.PopPanelManager.GetAllPanelCount(1)
    local willReShowCount = gs.PopPanelManager.GetWillReShowCount()
    local isFull = args.panelType == 1 or allOpenCount == 0
    -- print("\n关闭了" .. args.panelName .. "，需要恢复的窗口数量:" .. willReShowCount .. "，指定条件的窗口数量:" .. allOpenCount)
    if (willReShowCount == 0 and isFull) then
        note.NoteManager:addEnableByUi(true)
        note.NoteManager:checkDispatch()
    end
end

-- 好友初始化
function onFriendInitHandler(self, args)
    note.NoteManager:onFriendInit(args)
end

-- 好友更新
function onFriendUpdateHandler(self, args)
    note.NoteManager:onFriendUpdate(args)
end

-- 邮件初始化
function onMailInitHandler(self, args)
    note.NoteManager:onMailInit(args)
end

-- 邮件更新
function onMailUpdateHandler(self, args)
    note.NoteManager:onMailUpdate(args)
end

-- 功能开启更新
function onFunOpenUpdateHandler(self, args)
    note.NoteManager:onFunOpenUpdate(args)
end

-- 删除某类型便签
function onDelTypeNoteHandler(self, args)
    note.NoteManager:delTypeNoteWait(args)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
