--[[ 
-----------------------------------------------------
@filename       : NoteManager
@Description    : 便签数据管理
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("note.NoteManager", Class.impl(Manager))

-- 便签更新
NOTE_UPDATE = "NOTE_UPDATE"
-- 便签清理
NOTE_CLEAR = "NOTE_CLEAR"

-- 好友初始化
FRIEND_INIT = "FRIEND_INIT"
-- 好友更新
FRIEND_UPDATE = "FRIEND_UPDATE"

-- 邮件初始化
MAIL_INIT = "MAIL_INIT"
-- 邮件更新
MAIL_UPDATE = "MAIL_UPDATE"

-- 功能开启更新
FUN_OPEN_UPDATE = "FUN_OPEN_UPDATE"

-- 删除某类型便签
DEL_TYPE_NOTE = "DEL_TYPE_NOTE"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    -- 是否邮件已初始化
    self.hasTypeMailInit = false
    -- 是否好友已初始化
    self.hasTypeFriendInit = false

    -- 配置列表
    self.mNoteConfigList = nil
    
    -- 等待列表
    self.mNoteWaitList = {}
    -- 进行列表
    self.mNoteActionList = {}

    self:addEnableByUi(true)
    self:addEnableByLoading(true)
    self:addEnableByFight(true)
    self:setWillByCloseAll(false)
end

function parseConfigData(self)
    self.mNoteConfigList = {}
    local baseData = RefMgr:getData("note_data")
    for key, data in pairs(baseData) do
        local vo = note.NoteConfigVo.new()
        vo:parseConfigData(key, data)
        table.insert(self.mNoteConfigList, vo)
    end
end

-- 获取配置列表
function getNoteConfigList(self)
    if(not self.mNoteConfigList)then
        self:parseConfigData()
    end
    return self.mNoteConfigList
end

-- 获取配置数据vo
function getNoteConfigVo(self, noteType, funId)
    local noteConfigList = self:getNoteConfigList()
    for _, noteConfigVo in ipairs(noteConfigList) do
        if(noteConfigVo.type == noteType and noteConfigVo.funcId == funId)then
            return noteConfigVo
        end
    end
end

-- ui界面过程操作
function addEnableByUi(self, isEnable)
    self.mIsEnableByUi = isEnable
end
function getEnableByUi(self)
    return self.mIsEnableByUi
end

-- loading过程操作
function addEnableByLoading(self, isForbid)
    self.mIsEnableByLoading = isForbid
end
function getEnableByLoading(self)
    return self.mIsEnableByLoading
end

-- 战斗过程操作
function addEnableByFight(self, isForbid)
    self.mIsEnableByFight = isForbid
end
function getEnableByFight(self)
    return self.mIsEnableByFight
end

-- 设置是否即将关闭全部界面
function setWillByCloseAll(self, isWillClose)
    self.mIsWillClose = isWillClose
end
function getWillByCloseAll(self)
    return self.mIsWillClose
end

-- 检查一切是否初始化完毕，是则派发
function checkDispatch(self)
    if(not self.hasTypeFriendInit or not self.hasTypeMailInit)then
        return
    end
    if(not note.NoteManager:getEnableByUi() or not note.NoteManager:getEnableByLoading() or not note.NoteManager:getEnableByFight()) then
        return
    end
    if(#self.mNoteWaitList <= 0)then
        return
    end
    self:dispatchEvent(note.NoteManager.NOTE_UPDATE)
end

-- 好友初始化（只显示一条）
function onFriendInit(self, args)
    if(not self.hasTypeFriendInit)then
        self.hasTypeFriendInit = true
        local applyList = friend.FriendManager:getApplyList()
        if(#applyList > 0)then
            self:onFriendUpdate(args)
        end
        self:checkDispatch()
    end
end

-- 好友更新（只显示一条）
function onFriendUpdate(self, args)
    local vo = LuaPoolMgr:poolGet(note.NoteVo)
    vo:setData(note.NoteType.FRIEND_APPLY, nil)
    if(not self:isNoteExist(vo))then
        self:addNoteWait(vo)
        self:checkDispatch()
    else
        LuaPoolMgr:poolRecover(vo)
    end
end

-- 邮件初始化（只显示一条）
function onMailInit(self, args)
    if(not self.hasTypeMailInit)then
        self.hasTypeMailInit = true
        local mailList = mail.MailManager:getMailList()
        for k, mailVo in ipairs(mailList) do
            if(not mailVo:isRead())then
                self:onMailUpdate()
                break
            end
        end
        self:checkDispatch()
    end
end

-- 邮件更新（只显示一条）
function onMailUpdate(self, args)
    local vo = LuaPoolMgr:poolGet(note.NoteVo)
    vo:setData(note.NoteType.UNREAD_MAIL, nil)
    if(not self:isNoteExist(vo))then
        self:addNoteWait(vo)
        self:checkDispatch()
    else
        LuaPoolMgr:poolRecover(vo)
    end
end

-- 功能开启更新
function onFunOpenUpdate(self, funOpenId)
    local isInclude = false
    local noteConfigList = self:getNoteConfigList()
    for j, noteConfigVo in ipairs(noteConfigList) do
        if(noteConfigVo.type == note.NoteType.FUN_OPEN and noteConfigVo.funcId == funOpenId)then
            isInclude = true
            break
        end
    end
    if(isInclude)then
        local vo = LuaPoolMgr:poolGet(note.NoteVo)
        vo:setData(note.NoteType.FUN_OPEN, funOpenId)
        self:removeNote(vo.type, vo.funId)
        self:addNoteWait(vo)
        self:checkDispatch()
    end
end

-- 取出一个便签
function popNote(self)
    local noteVo = table.remove(self.mNoteWaitList, 1)
    table.insert(self.mNoteActionList, noteVo)
    return noteVo
end

-- 检查便签是否已存在
function isNoteExist(self, cusNoteVo)
    for _, noteVo in pairs(self.mNoteWaitList) do
        if(noteVo.type == cusNoteVo.type and noteVo.funId == cusNoteVo.funId)then
            return true
        end
    end
    for _, noteVo in pairs(self.mNoteActionList) do
        if(noteVo.type == cusNoteVo.type and noteVo.funId == cusNoteVo.funId)then
            return true
        end
    end
    return false
end

-- 添加便签
function addNoteWait(self, noteVo)
    table.insert(self.mNoteWaitList, noteVo)
    table.sort(self.mNoteWaitList, self.onSortNoteList)

    local waitCount = #self.mNoteWaitList
    if(waitCount > note.NoteShowNum and #self.mNoteActionList <= 0)then
        for i = note.NoteShowNum + 1, waitCount do
            table.remove(self.mNoteWaitList, i)
        end
    end
end

-- 便签排序
function onSortNoteList(note_1, note_2)
    if(note_1 and note_2)then
        if(note_1.sort ~= note_2.sort)then
            return note_1.sort < note_2.sort
        end
        if(note_1.time ~= note_2.time)then
            return note_1.time > note_2.time
        end
    end
    return nil
end

-- 删除某个类型的便签
function delTypeNoteWait(self, noteType)
    for i = 1, #self.mNoteWaitList do
        if(self.mNoteWaitList[i].type == noteType) then
            self:removeNote(noteType, self.mNoteWaitList[i].funId)
        end
    end
end

-- 移除便签
function removeNote(self, noteType, funId)
    for i = 1, #self.mNoteWaitList do
        if(self.mNoteWaitList[i].type == noteType and self.mNoteWaitList[i].funId == funId)then
            LuaPoolMgr:poolRecover(table.remove(self.mNoteWaitList, i))
            break
        end
    end
    for i = 1, #self.mNoteActionList do
        if(self.mNoteActionList[i].type == noteType and self.mNoteActionList[i].funId == funId)then
            LuaPoolMgr:poolRecover(table.remove(self.mNoteActionList, i))
            break
        end
    end
end

-- 移除所有便签
function removeAllNote(self)
    for i = 1, #self.mNoteWaitList do
        LuaPoolMgr:poolRecover(self.mNoteWaitList[i])
    end
    self.mNoteWaitList = {}
    for i = 1, #self.mNoteActionList do
        LuaPoolMgr:poolRecover(self.mNoteActionList[i])
    end
    self.mNoteActionList = {}

    self:dispatchEvent(note.NoteManager.NOTE_CLEAR)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
