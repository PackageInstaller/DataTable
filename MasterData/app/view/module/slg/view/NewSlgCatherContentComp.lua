local NewSlgCatherContentComp = class("NewSlgCatherContentComp", require("app.fairyGUI.newSlg.UI_NewSlgCatherContentComp"))
local var_0_1 = g.core.const.ConstMgr.NewSlgConst

function NewSlgCatherContentComp:ctor()
	self._compCityAttack = self:getChild("Comp_cityAttack")
	self._listTeam = self:getChild("List_team")

	self._listTeam:setIniter(self)
	self._listTeam:setItemRenderer(handler(self, self._onRenderListTeamCell))

	self._bossTeamEmptyCtrl = self:getController("boss_team_empty")
end

function NewSlgCatherContentComp:setVis(arg_2_1)
	if arg_2_1 then
		g.core.utils.Tools.newSlgFunc.addSchedule({
			key = "NewSlgGatherComp_schedule"
		})
	else
		g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgGatherComp_schedule")
	end
end

function NewSlgCatherContentComp:updateView()
	self._compCityAttack:updateCell({
		gatherType = 0
	})

	self._statusArr = {}

	for iter_3_0, iter_3_1 in pairs((g.core.model.User.newSlgData:getMyTeamMap())) do
		local var_3_0 = g.core.model.User.newSlgData:getTeamStateByTeam(iter_3_1)

		if var_3_0.monsterType == var_0_1.MONSTER_TYPE.BOSS and (var_3_0.state == var_0_1.TEAM_CLIENT_STATUS_TYPE.FIGHTING or var_3_0.state == var_0_1.TEAM_CLIENT_STATUS_TYPE.MARCHING) then
			table.insert(self._statusArr, var_3_0)
		end
	end

	if #self._statusArr == 0 then
		self._bossTeamEmptyCtrl:setSelectedIndex(1)
	else
		self._bossTeamEmptyCtrl:setSelectedIndex(0)
		self._listTeam:setNumItems(#self._statusArr)
		self._listTeam:resizeToFit(#self._statusArr)
	end
end

function NewSlgCatherContentComp:_onRenderListTeamCell(arg_4_1, arg_4_2)
	arg_4_2:updateCell({
		gatherType = 1,
		data = self._statusArr[arg_4_1 + 1]
	})
end

return NewSlgCatherContentComp
