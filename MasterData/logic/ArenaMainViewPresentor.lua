-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaMainViewPresentor.lua

module("logic.extensions.arena.view.ArenaMainViewPresentor", package.seeall)

local ArenaMainViewPresentor = class("ArenaMainViewPresentor", ViewWithGuidePresentor)

function ArenaMainViewPresentor:ctor()
	ArenaMainViewPresentor.super.ctor(self)
end

function ArenaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArenaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/arena/arenamainview.prefab"
	}
end

function ArenaMainViewPresentor:buildViews()
	return {
		ArenaMainView.New()
	}
end

function ArenaMainViewPresentor:getTempResources()
	local oldList = ArenaModel.instance:getChallengers()

	if oldList == nil then
		return nil
	end

	local challengers = {}

	for i, v in ipairs(oldList) do
		table.insert(challengers, v)
	end

	local challengerDat = {
		_userName = RoleModel.instance:getUserName(),
		_maxZdl = RoleModel.instance:getMaxPower(),
		_position = ArenaModel.instance:getPosition(),
		gender = RoleModel.instance:getGender()
	}

	table.insert(challengers, challengerDat)

	local assetsList = {}

	for i = 1, #challengers do
		local vo = challengers[i]

		if vo then
			if vo.gender == 0 then
				local avatarMo = DressModel.instance:getDefaultAvatarMo(DressModel.defaultFemaleSkelId or DressModel.defaultMaleSkelId)
				local assets = avatarMo:getAssetsList(AvatarType.UI)

				for j = 1, #assets do
					table.insert(assetsList, assets[j])
				end
			end
		end
	end

	return table.unique(assetsList, true)
end

function ArenaMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ArenaMainViewPresentor
