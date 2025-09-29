-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/JobWorkerSelectViewPrenstor.lua

module("logic.extensions.houseworker.view.JobWorkerSelectViewPrenstor", package.seeall)

local M = class("JobWorkerSelectViewPrenstor", ViewPresentor)

M.Url_View = ResName.Room_role_list_view

function M:dependWhatResources()
	return {
		M.Url_View,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, JobWorkerSelectView.New())
	table.insert(views, HouseTitleView.New())

	return views
end

return M
