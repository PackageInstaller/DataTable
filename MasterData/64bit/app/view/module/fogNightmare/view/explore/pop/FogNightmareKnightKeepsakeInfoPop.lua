local var_0_0 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareKnightKeepsakeInfoPop = class("FogNightmareKnightKeepsakeInfoPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareKnightKeepsakeInfoPop"), function()
	return fgui.GComponent:create({
		pkgName = "fogNightmare",
		isFullScreen = false,
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareKnightKeepsakeInfoPop"
	}, ...)
end)

function FogNightmareKnightKeepsakeInfoPop:ctor(arg_2_1, arg_2_2)
	self._knightStruct = arg_2_1

	if arg_2_2 then
		self:_initViewByKeepsake()
	else
		self:_initView()
	end
end

function FogNightmareKnightKeepsakeInfoPop:_initView()
	self:showAtCenter()

	local var_3_0 = self._knightStruct:getDevelopStruct(var_0_0.KNIGHT_DEVELOP_KEY.KEEPSAKE)

	if var_3_0 then
		self.m_keepsakeComp:updateViewByStruct(var_3_0)
		self.m_hasSealController:setSelectedIndex(1)
		self.m_keepsakeComp:updateKnightByStruct(self._knightStruct)
	else
		self.m_hasSealController:setSelectedIndex(0)
	end

	self.m_knightIcon:updateIcon({
		struct = self._knightStruct
	})
end

function FogNightmareKnightKeepsakeInfoPop:_initViewByKeepsake()
	self:showAtCenter()
	self.m_keepsakeComp:updateViewByStruct(self._knightStruct)
	self.m_hasSealController:setSelectedIndex(1)
	self.m_hideKnightController:setSelectedIndex(1)
end

return FogNightmareKnightKeepsakeInfoPop
