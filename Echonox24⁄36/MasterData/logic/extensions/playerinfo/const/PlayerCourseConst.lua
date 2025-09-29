-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/const/PlayerCourseConst.lua

module("logic.extensions.playerinfo.const.PlayerCourseConst", package.seeall)

local M = class("PlayerCourseConst")
local EditType = GameEnum.DisplayTypeEnum
local EditValue = GameEnum.DisplayTargetEnum

M.Edit2View = {
	[EditValue.All] = 0,
	[EditValue.Friend] = 1,
	[EditValue.Self] = 2
}
M.EditTypeUnlockId = {
	[EditType.Hero] = 12000,
	[EditType.Cup] = 31003,
	[EditType.HouseLiveRoom] = 21000,
	[EditType.AirStudio] = 16014,
	[EditType.Roguelike] = 16015
}
M.View2Edit = {
	[0] = EditValue.All,
	EditValue.Friend,
	EditValue.Self
}
M.VisitorType = {
	Friend = 2,
	Self = 1,
	Other = 3
}

return M
