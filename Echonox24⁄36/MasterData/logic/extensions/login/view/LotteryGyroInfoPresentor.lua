-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LotteryGyroInfoPresentor.lua

module("logic.extensions.login.view.LotteryGyroInfoPresentor", package.seeall)

local LotteryGyroInfoPresentor = class("LotteryGyroInfoPresentor", ViewPresentor)

function LotteryGyroInfoPresentor:dependWhatResources()
	return {
		ResName.Loading_gryoinfoview
	}
end

function LotteryGyroInfoPresentor:buildViews()
	local views = {}
	local gyroView = LotteryGyroInfoView.New()

	table.insert(views, gyroView)

	return views
end

return LotteryGyroInfoPresentor
