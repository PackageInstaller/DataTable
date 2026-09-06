-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/anlong/AnLongCopyViewPresentor.lua

module("logic.extensions.scenariocopy.view.anlong.AnLongCopyViewPresentor", package.seeall)

local AnLongCopyViewPresentor = class("AnLongCopyViewPresentor", ViewPresentor)

AnLongCopyViewPresentor.BgEffectPath = "fx_ui_longzun/fx_ui_longzunjuqing_01.prefab"
AnLongCopyViewPresentor.ChapterEffectPath = "fx_ui_longzun/fx_ui_longzunjuqing_03aniu.prefab"
AnLongCopyViewPresentor.LevelEffectPath = "fx_ui_longzun/fx_ui_longzunjuqing_02aniu.prefab"

function AnLongCopyViewPresentor:ctor()
	AnLongCopyViewPresentor.super.ctor(self)
end

function AnLongCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnLongCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/anlong/anlongcopyview.prefab"
	}
end

function AnLongCopyViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(AnLongCopyViewPresentor.BgEffectPath),
		UIEffectManager.instance:getEffectPath(AnLongCopyViewPresentor.ChapterEffectPath),
		UIEffectManager.instance:getEffectPath(AnLongCopyViewPresentor.LevelEffectPath)
	}
end

function AnLongCopyViewPresentor:buildViews()
	return {
		AnLongCopyView.New()
	}
end

return AnLongCopyViewPresentor
