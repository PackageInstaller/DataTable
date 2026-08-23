local AncientsLineupUserComp = class("AncientsLineupUserComp", require("app.fairyGUI.ancients.UI_AncientsLineupUserComp"), function()
	return fgui.GComponent:create({
		resName = "AncientsLineupUserComp",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	})
end)
local var_0_2 = g.core.const.ConstMgr.AncientsConst
local CommonKnight = require("app.view.common.CommonKnight")

function var_0_0:ctor(arg_2_1)
	self._teamUser = arg_2_1.teamUser
	self._formationPos = arg_2_1.formationPos

	self:_updateView()
end

function var_0_0:_updateView()
	self.m_is_leaderController:setSelectedIndex(g.core.model.User.ancientsData:isTeamUserLeader(self._teamUser.user_id, var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) and 1 or 0)
	self.m_is_selfController:setSelectedIndex(self:getUserId() == g.core.model.User:getId() and 1 or 0)
end

function var_0_0:updateUserBaseInfo()
	local var_4_0 = g.core.utils.Tools.ancientsFunc.getSnapshot(self:getUserId())

	if var_4_0 then
		self.m_Comp_name:setText(var_4_0.name)
		self.m_Comp_spine:removeChildren()

		local var_4_1 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(var_4_0)

		var_4_1.scale = 0.75
		self._knightPic = CommonKnight.new(var_4_1)

		self.m_Comp_spine:addChild(self._knightPic)

		local var_4_2 = self._teamUser.fight_value

		if g.core.model.User:getId() == self:getUserId() then
			local var_4_3 = g.core.model.User.mulFormationData:getFormationStruct(g.core.const.ConstMgr.LineUpConst.MulTeamType.ANCIENTS, 1)

			if var_4_3:getFightValue() > 0 then
				var_4_2 = var_4_3:getFightValue()
			end
		end

		self.m_Comp_fight_value:setText(var_4_2)
	end
end

function var_0_0:getUserId()
	if not self._teamUser then
		return 0
	end

	return self._teamUser.user_id
end

function var_0_0.setFormationPos(arg_6_0, arg_6_1)
	arg_6_0._formationPos = arg_6_1
end

function var_0_0:getFormationPos()
	return self._formationPos
end

function var_0_0:setPosAndZOrder(arg_8_1, arg_8_2)
	self:setPosition(arg_8_1, arg_8_2)
	self:displayObject():setLocalZOrder(arg_8_2)
end

return var_0_0
