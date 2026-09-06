-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleSpecialRuleViewPresentor.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleSpecialRuleViewPresentor", package.seeall)

local CampScuffleSpecialRuleViewPresentor = class("CampScuffleSpecialRuleViewPresentor", ViewPresentor)

CampScuffleSpecialRuleViewPresentor.IconPath = {
	"ui/bigbg/copychapter/board_dld_01.png",
	"ui/bigbg/copychapter/board_dld_02.png"
}

function CampScuffleSpecialRuleViewPresentor:ctor()
	CampScuffleSpecialRuleViewPresentor.super.ctor(self)
end

function CampScuffleSpecialRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CampScuffleSpecialRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/campscuffle/campscufflespecialruleview.prefab"
	}
end

function CampScuffleSpecialRuleViewPresentor:buildViews()
	return {
		CampScuffleSpecialRuleView.New()
	}
end

function CampScuffleSpecialRuleViewPresentor:getTempResources()
	local resultPath = {}

	table.insert(resultPath, CampScuffleSpecialRuleViewPresentor.IconPath[1])
	table.insert(resultPath, CampScuffleSpecialRuleViewPresentor.IconPath[2])

	return resultPath
end

return CampScuffleSpecialRuleViewPresentor
