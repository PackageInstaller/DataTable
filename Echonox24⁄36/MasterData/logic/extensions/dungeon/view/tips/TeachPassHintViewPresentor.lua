-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/tips/TeachPassHintViewPresentor.lua

module("logic.extensions.dungeon.view.tips.TeachPassHintViewPresentor", package.seeall)

local TeachPassHintViewPresentor = class("TeachPassHintViewPresentor", ViewPresentor)

function TeachPassHintViewPresentor:dependWhatResources()
	return {
		ResName.Teach_pass_hint
	}
end

function TeachPassHintViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TeachPassHintViewPresentor:buildViews()
	local views = {}

	table.insert(views, TeachPassHintView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return TeachPassHintViewPresentor
