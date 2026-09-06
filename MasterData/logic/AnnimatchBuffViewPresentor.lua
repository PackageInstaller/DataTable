-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchBuffViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchBuffViewPresentor", package.seeall)

local AnnimatchBuffViewPresentor = class("AnnimatchBuffViewPresentor", ViewPresentor)

function AnnimatchBuffViewPresentor:ctor()
	AnnimatchBuffViewPresentor.super.ctor(self)
end

function AnnimatchBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnnimatchBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scufflebuffview.prefab"
	}
end

function AnnimatchBuffViewPresentor:buildViews()
	return {
		AnnimatchBuffView.New()
	}
end

function AnnimatchBuffViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab")
	}
end

function AnnimatchBuffViewPresentor:setGrayMaskGO(grayMaskGO)
	AnnimatchBuffViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return AnnimatchBuffViewPresentor
