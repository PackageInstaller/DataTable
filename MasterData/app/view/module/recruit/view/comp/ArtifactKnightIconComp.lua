local ArtifactKnightIconComp = class("ArtifactKnightIconComp", require("app.fairyGUI.recruitArtifact.UI_ArtifactKnightIconComp"))

function ArtifactKnightIconComp:ctor()
	self._knightId = nil
end

function ArtifactKnightIconComp:updateComp(arg_2_1, arg_2_2)
	self._knightId = g.core.config.knight_info.get(arg_2_1).advance_id

	self.m_knightIcon:getChild("icon"):setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_KNIGHT, self._knightId)))
	self.m_borderLoader:setURL("ui://base_new/bg_zm_gmwz2_pinzhidi_" .. arg_2_2 + 1)
end

return ArtifactKnightIconComp
