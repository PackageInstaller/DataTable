local ArtifactInfoKnightComp = class("ArtifactInfoKnightComp", require("app.fairyGUI.artifact.UI_ArtifactInfoKnightComp"))

function ArtifactInfoKnightComp:ctor()
	self._knightPicComp = self.m_knightMask:getChild("knightPicComp")
end

function ArtifactInfoKnightComp:updateComp(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1.knightId

	if arg_2_1.knightId > 0 then
		self._knightPicComp:updateKnight({
			useMidKnight = true,
			scale = 1.5,
			resId = tonumber(g.core.config.knight_info.get(var_2_0).res_id)
		})
	end

	self.m_qualityIcon:setURL(g.core.common.Path:getBelongKnightQualityBg(arg_2_1.quality))
end

return ArtifactInfoKnightComp
