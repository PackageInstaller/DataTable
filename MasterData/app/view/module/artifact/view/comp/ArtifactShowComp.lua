local var_0_0 = g.core.common.Path
local ArtifactShowComp = class("ArtifactShowComp", require("app.fairyGUI.artifact.UI_ArtifactShowComp"))

function ArtifactShowComp:ctor()
	return
end

function ArtifactShowComp:updateShowView(arg_2_1, arg_2_2)
	if arg_2_1 then
		self.m_isEmptyController:setSelectedIndex(0)

		local var_2_0 = arg_2_1:getCfg()

		self.m_icon:setURL((var_0_0:getArtifactImg(var_2_0.res_id)))
		self.m_nameComp:updateNameInfo(var_2_0, arg_2_1)
		self.m_bgIcon:setURL((var_0_0:getArtifactGroupIcon((arg_2_1:getBelongToGroup()))))
	elseif arg_2_2 then
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

return ArtifactShowComp
