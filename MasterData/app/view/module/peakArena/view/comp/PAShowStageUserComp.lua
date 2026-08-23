local var_0_0 = g.core.model.User.knightsData
local var_0_1 = g.core.common.Path
local PAShowStageUserComp = class("PAShowStageUserComp", require("app.fairyGUI.peakArena.UI_PAShowStageUserComp"))

function PAShowStageUserComp:ctor()
	self._userData = nil
end

function PAShowStageUserComp:updateUserInfo(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._userData = arg_2_1

	self.m_userName:setText(arg_2_1.name)

	local var_2_0 = arg_2_1.show_knight_id
	local var_2_1

	if arg_2_1.show_knight_id and var_2_0 < 1 or not var_2_0 then
		var_2_0 = arg_2_1.base_id
		var_2_1 = {
			knightId = var_2_0
		}
	end

	var_2_1.skinId = arg_2_1.show_knight_dress

	self.m_showPic:setURL((var_0_1:getMiddleKnightPicById(var_0_0:getKnightResInfo(var_2_1).painted_id)))

	local var_2_2 = self.m_showPic:getContentSprite()

	if var_2_2 then
		var_2_2:showChangingRect({
			width = 140,
			height = 550,
			x = -70,
			y = -200
		}, 80)
	end

	if g.core.model.User.peakArenaData:isShowAlliance() then
		self.m_alliance:setVisible(true)
		self.m_alliance:setText(arg_2_1.alliance_name or "")
	else
		self.m_alliance:setVisible(false)
	end
end

return PAShowStageUserComp
