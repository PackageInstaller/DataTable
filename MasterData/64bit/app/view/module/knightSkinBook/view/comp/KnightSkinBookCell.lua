local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.skinData
local var_0_2 = g.core.config.skin_info
local var_0_3 = g.core.config.knight_base_info
local KnightSkinBookCell = class("KnightSkinBookCell", require("app.fairyGUI.knightSkinBook.UI_KnightSkinBookCell"))

function KnightSkinBookCell:ctor()
	self.getSharedTrans(self, "enter_right", "CommonCardCellList", self)
end

function KnightSkinBookCell:updateCell(arg_2_1)
	self.m_ownStateController:setSelectedIndex((var_0_1:getSkinOwnAndWearState(arg_2_1.id)))

	local var_2_0 = var_0_2.get(arg_2_1.id)

	self.m_skinNameTxt:setText(var_2_0.name)
	self.m_skinPicLoader:setIcon(var_0_0:getKnightPicRes(var_0_3.get(arg_2_1.res).painted_id))
	self.m_knightNameTxt:setText(g.core.config.knight_info.get(arg_2_1.knight_advance_id).name)
	self.m_isLimitController:setSelectedIndex(var_2_0.limit == 1 and 1 or 0)
	self.m_effHolder:removeAllEffect()

	if var_2_0.limit == 1 then
		self.m_effHolder:addEffectSpine({
			isLoop = true,
			name = "eff_ui_recharge_limitmarkcn",
			anim = "play_handbook"
		})
	end
end

return KnightSkinBookCell
