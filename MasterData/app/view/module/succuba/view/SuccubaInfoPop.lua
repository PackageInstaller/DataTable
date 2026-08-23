local DrawSuccuba = require("app.view.common.DrawSuccuba")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local SuccubaInfoPop = class("SuccubaInfoPop", require("app.fairyGUI.succuba.UI_SuccubaInfoPop"), function()
	return fgui.GComponent:create({
		resName = "SuccubaInfoPop",
		pkgPath = "ui/succuba/succuba",
		isFullScreen = true,
		pkgName = "succuba"
	}, ...)
end)

function SuccubaInfoPop:ctor(arg_2_1)
	self._succubaStruct = arg_2_1 and arg_2_1.succubaStruct

	self:showAtCenter()
	self:_initView()
end

function SuccubaInfoPop:onLoad()
	return
end

function SuccubaInfoPop:_initView(arg_4_1)
	if not self._succubaStruct then
		return
	end

	local var_4_0 = self._succubaStruct:getCurCfg()
	local var_4_1 = fgui.UIPackage:createObject("succuba", "SuccubaPopNameComp")

	var_4_1:updateComp(self._succubaStruct)

	local var_4_2 = DrawSuccuba.new({
		isAlphaNode = true,
		showCfg = self._succubaStruct:getShowCfg()
	})

	var_4_2:setAlphaRect(var_0_1.MASK_TYPE.HORIZON, cc.rect(-500, 0, 750, 0), 200)
	self.m_infoPopBase:setPopView({
		quality = self._succubaStruct:getQuality(),
		tabParam = {
			{
				package = "succuba",
				compName = "SuccubaPopInfoComp",
				title = g.core.lang:get(421219)
			},
			{
				package = "succuba",
				compName = "SuccubaPopTalentComp",
				title = g.core.lang:get(202530)
			}
		},
		commonParam = self._succubaStruct,
		nameComp = var_4_1,
		itemComp = var_4_2,
		itemCompPos = {
			x = -100,
			y = -100
		}
	})
end

return SuccubaInfoPop
