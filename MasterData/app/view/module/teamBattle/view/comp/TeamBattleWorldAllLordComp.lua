local var_0_0 = g.core.const.ConstMgr.SpineConst
local TeamBattleWorldAllLordComp = class("TeamBattleWorldAllLordComp", require("app.fairyGUI.teamBattle.UI_TeamBattleWorldAllLordComp"))

function TeamBattleWorldAllLordComp:ctor()
	self._snapShotDic = nil
	self.members = {}

	for iter_1_0 = 1, 3 do
		self["m_playInfoLoader" .. iter_1_0]:addClickListener(handler(self, self._onClickPlayer))
	end
end

function TeamBattleWorldAllLordComp:updateRankLordComp()
	local var_2_0 = g.core.model.User.teamBattleData:getRankInfo()
	local var_2_1 = var_2_0 and var_2_0.list

	if var_2_0 and var_2_0.list and var_2_1[1] then
		self.members = var_2_1[1].members
		self._snapShotDic = var_2_1[1].snapShotDic
	end

	for iter_2_0 = 1, 3 do
		if iter_2_0 <= #self.members then
			if g.core.config.knight_info.fetch(self._snapShotDic[self.members[iter_2_0]].base_id) then
				local var_2_2 = self["m_knightPicComp" .. iter_2_0]

				self["m_knightPicComp" .. iter_2_0]:getController("isEmpty"):setSelectedIndex(0)

				local var_2_3 = {
					scale = 0.9
				}

				if self._snapShotDic[self.members[iter_2_0]].show_knight_dress > 0 then
					var_2_3.resId = self._snapShotDic[self.members[iter_2_0]].show_knight_dress or self._snapShotDic[self.members[iter_2_0]].show_knight_id
				end

				var_2_2:updateKnight(var_2_3)
				var_2_2:setAlphaRect(var_0_0.MASK_TYPE.HORIZON, cc.rect(-300, 0, 400, 0), 200)
			end

			self["m_playerInfoComp" .. iter_2_0]:updateKnight(self._snapShotDic[self.members[iter_2_0]])
		else
			self["m_knightPicComp" .. iter_2_0]:getController("isEmpty"):setSelectedIndex(1)
			self["m_playInfoLoader" .. iter_2_0]:setVisible(false)
			self["m_knightPicComp" .. iter_2_0]:getChild("firstImg"):setVisible(false)
			self["m_playerInfoComp" .. iter_2_0]:setVisible(false)
		end
	end
end

function TeamBattleWorldAllLordComp:_onClickPlayer(arg_3_1)
	local var_3_0 = arg_3_1:getSender():getName()
	local var_3_1 = self.members[tonumber(string.sub(var_3_0, #var_3_0))]

	if var_3_1 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			uid = var_3_1
		})
	end
end

return TeamBattleWorldAllLordComp
