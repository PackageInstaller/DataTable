local var_0_0 = g.core.config.game_eliminate_res_info
local var_0_1 = g.core.const.ConstMgr.WaitGameConst
local WaitGameBgCell = class("WaitGameBgCell", require("app.fairyGUI.upgrade.UI_WaitGameBgCell"))

function WaitGameBgCell:setStarVisible(arg_1_1)
	if not arg_1_1 ~= self:isHideStar() then
		self.m_hideStarController:setSelectedIndex(not arg_1_1 and 1 or 0)
	end
end

function WaitGameBgCell:isHideStar(arg_2_1)
	return self.m_hideStarController:getSelectedIndex() == 1
end

function WaitGameBgCell:playEliminateAni(arg_3_1)
	local var_3_0 = var_0_0.get(arg_3_1)

	self.m_eliEffDad:addEffectSpine({
		isLoop = false,
		remove = true,
		name = var_0_1.ELI_EFF_PRE_NAME .. var_3_0.eff_id,
		anim = var_0_1.ANI_PRE_NAME .. var_3_0.ani_id
	})
end

function WaitGameBgCell:setGameId(arg_4_1)
	self.m_gameIdController:setSelectedIndex(arg_4_1)
end

return WaitGameBgCell
