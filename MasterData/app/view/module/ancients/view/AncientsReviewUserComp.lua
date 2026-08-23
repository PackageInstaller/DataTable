local var_0_0 = g.core.model.User.knightsData
local var_0_1 = g.core.common.Path
local AncientsReviewUserComp = class("AncientsReviewUserComp", require("app.fairyGUI.ancients.UI_AncientsReviewUserComp"))

function AncientsReviewUserComp:ctor()
	self._userData = nil

	if self.m_rankController:getSelectedIndex() == 0 then
		self.m_effFirst:addEffectSpine({
			anim = "play",
			name = "eff_ui_ancients_reviewlight",
			isLoop = true
		})
	end
end

function AncientsReviewUserComp:updateUserInfo(arg_2_1)
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
end

return AncientsReviewUserComp
