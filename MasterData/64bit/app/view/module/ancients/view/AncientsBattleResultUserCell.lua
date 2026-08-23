local AncientsBattleResultUserCell = class("AncientsBattleResultUserCell", require("app.fairyGUI.ancients.UI_AncientsBattleResultUserCell"))

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0:updateCell(arg_2_1)
	local var_2_0 = g.core.model.User.ancientsData
	local var_2_1 = arg_2_1.settle
	local var_2_2 = arg_2_1.isWin
	local var_2_3 = arg_2_1.isFinal

	self.m_is_winController:setSelectedIndex(arg_2_1.isFinal and 0 or 1)
	self.m_Txt_kill:setText(var_2_1.kill)
	self.m_Txt_damage:setText(var_2_1.damage)

	local var_2_4 = var_2_1.score

	if not var_2_3 then
		local var_2_5 = var_2_0:getBattleWinScore()
		local var_2_6 = var_2_0:getBattleLoseScore()

		if var_2_2 then
			var_2_4 = var_2_1.score - var_2_5

			self.m_Txt_score_win:setText(g.core.lang:get(110411, {
				num = var_2_5
			}))
		else
			var_2_4 = var_2_1.score - var_2_6

			self.m_Txt_score_win:setText(g.core.lang:get(110411, {
				num = var_2_6
			}))
		end
	end

	self.m_Txt_score:setText(var_2_4)

	local var_2_7 = g.core.utils.Tools.ancientsFunc.getSnapshot(var_2_1.uid)

	if var_2_7 then
		self.m_Comp_icon:updateAsUser(var_2_7)
		self.m_Comp_name:setText(var_2_7.name)
		self.m_Txt_level:setText(g.core.lang:get(2052, {
			level = var_2_7.level
		}))
	end
end

return var_0_0
