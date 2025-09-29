-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/monsterdata/HandbookMonsterdataViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.monsterdata.HandbookMonsterdataViewPresentor", package.seeall)

local M = class("HandbookMonsterdataViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_mosterdata_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookMonsterdataView.New())

	return views
end

return M
