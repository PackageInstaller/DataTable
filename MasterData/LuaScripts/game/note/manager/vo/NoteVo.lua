--[[ 
-----------------------------------------------------
@filename       : NoteVo
@Description    : 便签数据vo
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("note.NoteVo", Class.impl())

function setData(self, noteType, funcId)
    -- 便签分类
    self.type = noteType
    -- 对应功能开启id
    self.funId = funcId

    self.time = GameManager:getClientTime()
    if(self.type == note.NoteType.FRIEND_APPLY)then
        self.sort = 1
    elseif(self.type == note.NoteType.UNREAD_MAIL)then
        self.sort = 2
    elseif(self.type == note.NoteType.FUN_OPEN)then
        self.sort = 3
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
