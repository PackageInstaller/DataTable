local AncientsBattleDetailUserIcon = class("AncientsBattleDetailUserIcon", require("app.fairyGUI.ancients.UI_AncientsBattleDetailUserIcon"))

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0:updateView(arg_2_1)
	if not arg_2_1.userId or arg_2_1.userId == 0 then
		self:setVisible(false)

		return
	else
		self:setVisible(true)

		local var_2_0 = arg_2_1.score or 0
		local var_2_1 = g.core.utils.Tools.ancientsFunc.getSnapshot(arg_2_1.userId)

		if var_2_1 then
			self.m_Comp_icon:updateAsUser(var_2_1)
			self.m_Comp_name:setText(var_2_1.name)
			self.m_levelTxt:setText(g.core.lang:get(2052, {
				level = var_2_1.level
			}))
		end

		self.m_Txt_score:setText(g.core.lang:get(433396, {
			score = var_2_0
		}))
	end
end

return var_0_0
