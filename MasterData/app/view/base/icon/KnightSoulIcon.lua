local BaseKnightSoulIcon = require("app.view.base.icon.BaseKnightSoulIcon")
local KnightSoulIcon = class("KnightSoulIcon", require("app.fairyGUI.base_new.UI_BaseKnightSoulIcon"))

function KnightSoulIcon:ctor()
	BaseKnightSoulIcon.ctor(self)
end

return KnightSoulIcon
