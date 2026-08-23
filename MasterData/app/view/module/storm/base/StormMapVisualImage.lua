local MapConst = require("app.core.ksmap.MapConst")
local StormMapVisualImage = class("StormMapVisualImage", require("app.core.ksmap.entity.MapVisualImage"))

function StormMapVisualImage:ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	StormMapVisualImage.super.ctor(self, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
end

function StormMapVisualImage:_doInitBillboard()
	if self._resID == MapConst.MAP_PERMIT_ICON_NAME then
		local var_2_0 = cc.Node:create()

		var_2_0:addChild((display.newSprite("ui_cocos/biography/icon_zhuxianbiaoji.png")))
		var_2_0:setScale(1.5)
		var_2_0:setPosition(20, 110)
		self:addChild(var_2_0)
	end
end

return StormMapVisualImage
