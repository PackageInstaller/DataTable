-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchinfoViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchinfoViewPresentor", package.seeall)

local AnnimatchinfoViewPresentor = class("AnnimatchinfoViewPresentor", ViewPresentor)

AnnimatchinfoViewPresentor.VSPath = "fx_ui_jinglingdaluandou/fx_ui_pipei_vs.prefab"
AnnimatchinfoViewPresentor.IngPath = "fx_ui_jinglingdaluandou/fx_ui_pipei_ing.prefab"
AnnimatchinfoViewPresentor.SuccessPath = "fx_ui_jinglingdaluandou/fx_ui_pipeichenggong.prefab"

function AnnimatchinfoViewPresentor:ctor()
	AnnimatchinfoViewPresentor.super.ctor(self)
end

function AnnimatchinfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchinfoViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchinfoview.prefab"
	}
end

function AnnimatchinfoViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(AnnimatchinfoViewPresentor.VSPath),
		UIEffectManager.instance:getEffectPath(AnnimatchinfoViewPresentor.IngPath),
		UIEffectManager.instance:getEffectPath(AnnimatchinfoViewPresentor.SuccessPath)
	}
end

function AnnimatchinfoViewPresentor:buildViews()
	return {
		AnnimatchinfoView.New()
	}
end

return AnnimatchinfoViewPresentor
