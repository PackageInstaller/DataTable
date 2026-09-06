-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/view/atlasclg/AtlasclgmainView.lua

module("logic.extensions.doloresclg.view.atlasclg.AtlasclgmainView", package.seeall)

local AtlasclgmainView = class("AtlasclgmainView", DoloresclgmainView)

function AtlasclgmainView:_getLevelView()
	return ViewName.AtlasclglevelView
end

return AtlasclgmainView
