local AncientsBattleUserComp = class("AncientsBattleUserComp", require("app.fairyGUI.ancients.UI_AncientsBattleUserComp"), function()
	return fgui.GComponent:create({
		resName = "AncientsBattleUserComp",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	})
end)
local CommonKnight = require("app.view.common.CommonKnight")
local var_0_3 = g.core.const.ConstMgr.AncientsConst.ENEMY_POS
local var_0_4 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor(arg_2_1)
	self._team = arg_2_1.team
	self._teamUser = arg_2_1.teamUser
	self._formationPos = arg_2_1.formationPos
	self._curFormationPos = self._formationPos
	self._knightPic = nil
	self._dead = false

	self:_updateView()
end

function var_0_0:_updateView()
	self.m_Comp_spine:setScale(self:isEnemy() and -1 or 1, 1)
	self:setHpProg(100)
	self.m_is_leaderController:setSelectedIndex(g.core.model.User.ancientsData:isTeamUserLeader(self._teamUser.user_id, var_0_4.GET_TEAM_TYPE.CUSTOM_TEAM, self._team) and 1 or 0)
end

function var_0_0:updateUserBaseInfo()
	local var_4_0 = g.core.utils.Tools.ancientsFunc.getSnapshot(self:getUserId())

	if var_4_0 then
		self.m_name:setText(var_4_0.name)
		self.m_Comp_spine:removeChildren()

		local var_4_1 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(var_4_0)

		var_4_1.scale = 0.75
		self._knightPic = CommonKnight.new(var_4_1)

		self.m_Comp_spine:addChild(self._knightPic)
		self.m_fightValue:setText(g.core.lang:get(420401, {
			num = self._teamUser.fight_value
		}))
	end
end

function var_0_0:setHpProg(arg_5_1)
	self.m_Prog_hp:setMax(100)
	self.m_Prog_hp:setValue(arg_5_1)
end

function var_0_0:getUserId()
	if not self._teamUser then
		return 0
	end

	return self._teamUser.user_id
end

function var_0_0:isEnemy()
	return self._formationPos > var_0_3
end

function var_0_0.setCurFormationPos(arg_8_0, arg_8_1)
	arg_8_0._curFormationPos = arg_8_1
end

function var_0_0:getCurFormationPos()
	return self._curFormationPos
end

function var_0_0:getCurFrontFormationPos()
	local var_10_0 = 0

	if self:isEnemy() then
		if self._curFormationPos > var_0_3 then
			var_10_0 = self._curFormationPos - 1

			if (self._curFormationPos - 1 - var_0_3) % 3 == 0 then
				var_10_0 = self._formationPos - var_0_3
			end
		else
			var_10_0 = self._curFormationPos + 1
		end
	elseif self._curFormationPos < var_0_3 then
		var_10_0 = self._curFormationPos - 1

		if (self._curFormationPos - 1) % 3 == 0 then
			var_10_0 = self._formationPos + var_0_3
		end
	else
		var_10_0 = self._curFormationPos + 1
	end

	return var_10_0
end

function var_0_0:setDead(arg_11_1)
	self:setVisible(not arg_11_1)

	self._dead = arg_11_1
end

function var_0_0:isDead()
	return self._dead
end

function var_0_0:setPosAndZOrder(arg_13_1, arg_13_2)
	self:setPosition(arg_13_1, arg_13_2)
	self:displayObject():setLocalZOrder(arg_13_2)
end

function var_0_0:showBattleFlag(arg_14_1)
	self.m_show_battleController:setSelectedIndex(arg_14_1 and 1 or 0)
end

function var_0_0:playAction(arg_15_1, arg_15_2)
	if not self._knightPic then
		return
	end

	self._knightPic:playAction(arg_15_1, handler(self, function()
		if arg_15_2 then
			arg_15_2()
		end
	end))
end

function var_0_0.playPetWinEffect(arg_17_0)
	return
end

return var_0_0
