-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/BabybuscodetipViewPresentor.lua

module("logic.extensions.babybus.view.BabybuscodetipViewPresentor", package.seeall)

local BabybuscodetipViewPresentor = class("BabybuscodetipViewPresentor", BirthdaytipsViewPresentor)

function BabybuscodetipViewPresentor:buildViews()
	return {
		Babybuscodetipview.New()
	}
end

return BabybuscodetipViewPresentor
