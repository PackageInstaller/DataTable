-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/util/LeaveMsgEventType.lua

module("logic.extensions.leavemsg.util.LeaveMsgEventType", package.seeall)

local LeaveMsgEventType = {}

LeaveMsgEventType.ON_EDIT_MSG_PART_CHANGE = UIDUtil.getEventUID()
LeaveMsgEventType.ON_EDIT_ALL_PREVIEW = UIDUtil.getEventUID()
LeaveMsgEventType.ON_EDIT_MSG_SAVE = UIDUtil.getEventUID()

return LeaveMsgEventType
