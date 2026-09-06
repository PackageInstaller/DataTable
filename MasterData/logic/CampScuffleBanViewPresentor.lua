-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleBanViewPresentor.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleBanViewPresentor", package.seeall)

local CampScuffleBanViewPresentor = class("CampScuffleBanViewPresentor", ViewPresentor)

CampScuffleBanViewPresentor.BluePath = "fx_ui_jinglingdaluandou/fx_ui_fapaixiaoguo_bule.prefab"
CampScuffleBanViewPresentor.RedPath = "fx_ui_jinglingdaluandou/fx_ui_fapaixiaoguo_red.prefab"

function CampScuffleBanViewPresentor:ctor()
	CampScuffleBanViewPresentor.super.ctor(self)
end

function CampScuffleBanViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CampScuffleBanViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/campscuffle/campscufflebanview.prefab"
	}
end

function CampScuffleBanViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(CampScuffleBanViewPresentor.BluePath),
		UIEffectManager.instance:getEffectPath(CampScuffleBanViewPresentor.RedPath)
	}
end

function CampScuffleBanViewPresentor:buildViews()
	return {
		CampScuffleBanView.New()
	}
end

return CampScuffleBanViewPresentor
