-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseHouseEditView.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseHouseEditView", package.seeall)

local M = class("PlayerCourseHouseEditView", PlayerCourseEditView)

function M:ctor()
	self._editType = GameEnum.DisplayTypeEnum.HouseLiveRoom
	self._itemPrefabName = "player_course_house_edit_item"
	self._viewName = ViewName.PlayerCourseHouseEditView
	self._cellCls = CourseHouseEditItem
	self._callDataCls = CourseHouseData
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	M.super.onEnter(self)
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	M.super.onExit(self)
end

return M
