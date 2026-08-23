local PreciousSuitStruct = require("app.view.module.precious.model.PreciousSuitStruct")
local PreciousInfoPop = class("PreciousInfoPop", require("app.fairyGUI.precious.UI_PreciousInfoPop"), function()
	return fgui.GComponent:create({
		resName = "PreciousInfoPop",
		pkgPath = "ui/precious/precious",
		isFullScreen = true,
		pkgName = "precious"
	}, ...)
end)

function PreciousInfoPop:ctor(arg_2_1)
	self._preciousStruct = arg_2_1.preciousStruct

	self:showAtCenter()
	self:_updateView()
end

function PreciousInfoPop:_updateView()
	if not self._preciousStruct then
		return
	end

	local var_3_0 = self._preciousStruct:getCfg()
	local var_3_1 = fgui.UIPackage:createObject("precious", "PreciousInfoNameComp")

	var_3_1:setData(self._preciousStruct)

	local var_3_2 = fgui.GLoader:create()

	var_3_2:setAutoSize(true)
	var_3_2:setPivot(0.5, 0.5, true)
	var_3_2:setURL(g.core.common.Path:getPreciousBigIconByResId(var_3_0.res_id))
	self.m_infoPopBase:setPopView({
		quality = self._preciousStruct:getQuality(),
		tabParam = {
			{
				package = "precious",
				compName = "PreciousInfoComp",
				title = g.core.lang:get(421219)
			}
		},
		commonParam = self._preciousStruct,
		nameComp = var_3_1,
		itemComp = var_3_2
	})
end

return PreciousInfoPop
