-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/making/CORoadMakingScenceView.lua

module("logic.extensions.cantonoperaroad.view.copy.making.CORoadMakingScenceView", package.seeall)

local CORoadMakingScenceView = class("CORoadMakingScenceView", MakingMoonCakeView)

function CORoadMakingScenceView:_handlePM_MakingMoonCakeEndGameRes()
	if self._score >= 0 then
		UIStateManager.instance:push(ViewName.CORoadMakingResultView, self._score)
	end
end

return CORoadMakingScenceView
