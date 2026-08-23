local PreciousSuitStruct = require("app.view.module.precious.model.PreciousSuitStruct")
local PreciousSuitInfoPop = class("PreciousSuitInfoPop", require("app.fairyGUI.precious.UI_PreciousSuitInfoPop"), function()
	return fgui.GComponent:create({
		resName = "PreciousSuitInfoPop",
		pkgPath = "ui/precious/precious",
		isFullScreen = true,
		pkgName = "precious"
	}, ...)
end)

function PreciousSuitInfoPop:ctor(arg_2_1)
	self._suitStruct = arg_2_1.suitStruct

	if arg_2_1.suitGroup then
		for iter_2_0, iter_2_1 in g.core.config.precious_suit_info.ipairs() do
			if iter_2_1.suit_group == arg_2_1.suitGroup and iter_2_1.star == 0 then
				local var_2_0 = PreciousSuitStruct.new()

				var_2_0:setCfg(iter_2_1)

				self._suitStruct = var_2_0

				break
			end
		end
	end

	self:showAtCenter()
	self:_updateView()
end

function PreciousSuitInfoPop:_updateView()
	if not self._suitStruct then
		return
	end

	local var_3_0 = fgui.UIPackage:createObject("precious", "PreciousSuitItemComp")

	var_3_0:updateSuitComp(self._suitStruct)
	self.m_infoPopBase:setPopView({
		quality = self._suitStruct:getQuality(),
		tabParam = {
			{
				package = "precious",
				compName = "PreciousSuitInfoComp",
				title = g.core.lang:get(421219)
			}
		},
		commonParam = self._suitStruct,
		nameComp = var_3_0
	})
end

return PreciousSuitInfoPop
