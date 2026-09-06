-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleMainViewPresentor.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleMainViewPresentor", package.seeall)

local CampScuffleMainViewPresentor = class("CampScuffleMainViewPresentor", ViewPresentor)

CampScuffleMainViewPresentor.PlayerBgPath = "fx_ui_jinglingdaluandou/fx_ui_jiemianrenwuxiaoguo.prefab"
CampScuffleMainViewPresentor.MainViewBgPath = "fx_ui_jinglingdaluandou/fx_ui_jiemianbeijingxiaoguo.prefab"
CampScuffleMainViewPresentor.ScoreUpPath = "fx_ui_jinglingdaluandou/fx_ui_jifenzengjia.prefab"

function CampScuffleMainViewPresentor:ctor()
	CampScuffleMainViewPresentor.super.ctor(self)
end

function CampScuffleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CampScuffleMainViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/campscuffle/campscufflemainview.prefab"
	}
end

function CampScuffleMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(CampScuffleMainViewPresentor.PlayerBgPath),
		UIEffectManager.instance:getEffectPath(CampScuffleMainViewPresentor.MainViewBgPath),
		UIEffectManager.instance:getEffectPath(CampScuffleMainViewPresentor.ScoreUpPath)
	}
end

function CampScuffleMainViewPresentor:buildViews()
	return {
		CampScuffleMainView.New()
	}
end

return CampScuffleMainViewPresentor
