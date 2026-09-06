-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/making/CORoadMakingScenceViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.copy.making.CORoadMakingScenceViewPresentor", package.seeall)

local CORoadMakingScenceViewPresentor = class("CORoadMakingScenceViewPresentor", ViewPresentor)

function CORoadMakingScenceViewPresentor:ctor()
	CORoadMakingScenceViewPresentor.super.ctor(self)
end

function CORoadMakingScenceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORoadMakingScenceViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/making/coroadmakingscenceview.prefab"
	}
end

function CORoadMakingScenceViewPresentor:buildViews()
	return {
		CORoadMakingScenceView.New()
	}
end

function CORoadMakingScenceViewPresentor:getTempResources()
	return {
		MakingMoonCakeModel.instance:getRoleUrl()
	}
end

return CORoadMakingScenceViewPresentor
