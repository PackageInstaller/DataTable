local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = g.core.model.User.knightsData
local FogNightAssistantKnightComp = class("FogNightAssistantKnightComp", require("app.fairyGUI.fogNightmare.UI_FogNightAssistantKnightComp"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = false,
		pkgName = "fogNightmare",
		resName = "FogNightAssistantKnightComp"
	}, ...)
end)

function FogNightAssistantKnightComp:ctor()
	self._clickCallback = nil

	self.m_knightStarComp:initStar({
		index = 3,
		style = 1,
		num = 0,
		gap = 0,
		max = var_0_1.STAR_MAX
	})
	self.getSharedTrans(self, "enter_scaleIn", "CommonCardCellList", self)
end

function FogNightAssistantKnightComp:updateComp(arg_3_1, arg_3_2)
	local var_3_0 = tostring(arg_3_2)

	self.m_indexText:setText((arg_3_2 < 10 or nil) and "0" .. tostring(arg_3_2))

	if not arg_3_1 or arg_3_1 == 0 then
		self.m_hasKnightController:setSelectedIndex(0)
		self.m_qualityLine:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL(0))

		return
	end

	self.m_hasKnightController:setSelectedIndex(1)

	local var_3_1 = var_0_2:getKnightById(arg_3_1)

	self.m_qualityLine:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL((var_3_1:getQuality())))
	self.m_knightLoader:setURL(var_0_0:getKnightBookPicRes(var_3_1:getResInfo().painted_id))
	self.m_knightNameText:setText(var_3_1:getName())
	self.m_knightStarComp:setStarNum(var_3_1:getStarLv())
end

return FogNightAssistantKnightComp
