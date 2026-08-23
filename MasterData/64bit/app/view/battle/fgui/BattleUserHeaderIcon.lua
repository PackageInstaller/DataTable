local var_0_0 = g.core.model.User.knightsData
local UserConst = require("app.view.module.user.const.UserConst")
local BattleUserHeaderIcon = class("BattleUserHeaderIcon", require("app.fairyGUI.battle.UI_BattleUserHeaderIcon"))

function BattleUserHeaderIcon:ctor()
	self._user = {}
end

function BattleUserHeaderIcon:updateView(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if not arg_2_1 then
		self.m_fightStatusController:setSelectedIndex(3)
		self.m_nameText:setText(g.core.lang:get(110062, {
			index = arg_2_2
		}))

		return
	end

	self._user = arg_2_1

	local var_2_0 = self._user.user

	if arg_2_5 or arg_2_4 then
		if arg_2_1 and #arg_2_1.units > 0 then
			local var_2_1 = 7
			local var_2_2 = arg_2_1.units[1].id

			for iter_2_0, iter_2_1 in ipairs(arg_2_1.units) do
				if var_2_1 > iter_2_1.pos then
					var_2_1 = iter_2_1.pos
					var_2_2 = iter_2_1.id
				end
			end

			local var_2_3 = var_0_0:getKnight({
				base_id = var_2_2
			}):getResInfo()

			self.m_iconLoader:setURL((g.core.common.Path:getKnightIconById(var_2_3.icon_id)))

			if arg_2_4 then
				self.m_nameText:setText(g.core.lang:get(110062, {
					index = arg_2_2
				}))
			else
				self.m_nameText:setText(var_2_3.name)
			end
		end
	elseif var_2_0 then
		self.m_iconLoader:setURL(var_2_0.avata_id and var_2_0.avata_id ~= 0 and g.core.common.Path:getRoleHeadIcon(g.core.config.avata_info.get(var_2_0.avata_id).res) or g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get((var_2_0.robot_type and var_2_0.robot_type ~= 0 and var_2_0.robot_type ~= 999 and g.core.config.robot_info.get(var_2_0.base_id) or g.core.config.knight_info.get(var_2_0.base_id)).res_id).icon_id))

		local var_2_6 = g.core.utils.String.transRobotName(var_2_0)
		local var_2_7

		if var_2_0.robot_type and var_2_0.robot_type ~= 0 then
			var_2_6 = var_2_6 .. g.core.lang:get(302042)
			var_2_7 = g.core.utils.String.subStringByShow(var_2_6, UserConst.MAX_NAME_SHOW_LEN)
		end

		if g.core.utils.String.getCharactersNum(var_2_6) > g.core.utils.String.getCharactersNum(var_2_7) then
			var_2_7 = var_2_7 .. "..."
		end

		if arg_2_4 then
			self.m_nameText:setText(g.core.lang:get(110062, {
				index = arg_2_2
			}))
		else
			self.m_nameText:setText(var_2_7)
		end

		self.m_isFriendController:setSelectedIndex(0)

		if not g.core.model.User:isSelfById(var_2_0.id) and arg_2_3 then
			self.m_isFriendController:setSelectedIndex(1)
		end
	end

	if arg_2_2 == 1 then
		self:setStatus(1)
	end
end

function BattleUserHeaderIcon:setStatus(arg_3_1)
	self.m_fightStatusController:setSelectedIndex(arg_3_1)
end

function BattleUserHeaderIcon:setWin()
	self.m_fightStatusController:setSelectedIndex(4)
end

function BattleUserHeaderIcon:setLose()
	self.m_fightStatusController:setSelectedIndex(5)
end

return BattleUserHeaderIcon
