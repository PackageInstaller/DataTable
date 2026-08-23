local var_0_0 = g.core.config.game_eliminate_res_info
local GemEliminateConst = require("app.view.module.summerTheme.const.GemEliminateConst")
local var_0_2 = GemEliminateConst.ELI_EFF_PRE_NAME
local var_0_3 = GemEliminateConst.ANI_PRE_NAME
local GEGemBgCell = class("GEGemBgCell", require("app.fairyGUI.summerThemeGame.UI_GEGemBgCell"))

function GEGemBgCell:setStarVisible(arg_1_1)
	if not arg_1_1 ~= self:isHideStar() then
		self.m_hideStarController:setSelectedIndex(not arg_1_1 and 1 or 0)
	end
end

function GEGemBgCell:isHideStar(arg_2_1)
	return self.m_hideStarController:getSelectedIndex() == 1
end

function GEGemBgCell:playEliminateAni(arg_3_1)
	local var_3_0 = var_0_0.get(arg_3_1)

	self.m_eliEffDad:addEffectSpine({
		remove = true,
		isLoop = false,
		name = var_0_2 .. var_3_0.eff_id,
		anim = var_0_3 .. var_3_0.ani_id
	})
end

function GEGemBgCell:setGameId(arg_4_1)
	self.m_gameIdController:setSelectedIndex(arg_4_1)
end

return GEGemBgCell
