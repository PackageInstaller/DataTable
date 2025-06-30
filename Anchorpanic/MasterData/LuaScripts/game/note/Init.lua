note = {}

require("game/note/manager/NoteConst")

note.NoteVo = require("game/note/manager/vo/NoteVo")
note.NoteConfigVo = require("game/note/manager/vo/NoteConfigVo")
note.NoteManager = require("game/note/manager/NoteManager").new()
note.NoteController = require("game/note/controller/NoteController").new(note.NoteManager)
note.NoteView = require("game/note/view/NoteView")

local module = {note.NoteController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
