local FogNightmareKeepsakeStateComp = class("FogNightmareKeepsakeStateComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeStateComp"))

function FogNightmareKeepsakeStateComp:updateStateComp(arg_1_1)
	local var_1_0 = arg_1_1:getDevelopStruct("keepsake")

	if var_1_0 then
		self.m_ownSealStateController:setSelectedIndex(1)
		self.m_sealIcon:setURL(g.core.common.Path:getFogNightmareKeepsakePicRes(var_1_0:getBaseInfo().seal_icon))
		self.m_sealQualityIcon:setURL(g.core.common.Path:getUserIconQualityNewBg(var_1_0:getBaseInfo().type))
	else
		self.m_ownSealStateController:setSelectedIndex(0)
	end
end

return FogNightmareKeepsakeStateComp
