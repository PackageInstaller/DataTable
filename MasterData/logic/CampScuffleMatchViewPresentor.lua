-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleMatchViewPresentor.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleMatchViewPresentor", package.seeall)

local CampScuffleMatchViewPresentor = class("CampScuffleMatchViewPresentor", ViewPresentor)

CampScuffleMatchViewPresentor.VSPath = "fx_ui_jinglingdaluandou/fx_ui_pipei_vs.prefab"
CampScuffleMatchViewPresentor.IngPath = "fx_ui_jinglingdaluandou/fx_ui_pipei_ing.prefab"
CampScuffleMatchViewPresentor.SuccessPath = "fx_ui_jinglingdaluandou/fx_ui_pipeichenggong.prefab"

function CampScuffleMatchViewPresentor:ctor()
	CampScuffleMatchViewPresentor.super.ctor(self)
end

function CampScuffleMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CampScuffleMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/campscuffle/campscufflematchview.prefab"
	}
end

function CampScuffleMatchViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(CampScuffleMatchViewPresentor.VSPath),
		UIEffectManager.instance:getEffectPath(CampScuffleMatchViewPresentor.IngPath),
		UIEffectManager.instance:getEffectPath(CampScuffleMatchViewPresentor.SuccessPath)
	}
end

function CampScuffleMatchViewPresentor:buildViews()
	return {
		CampScuffleMatchView.New()
	}
end

return CampScuffleMatchViewPresentor
