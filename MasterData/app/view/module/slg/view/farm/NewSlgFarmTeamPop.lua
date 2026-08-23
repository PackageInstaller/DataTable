local NewSlgFarmTeamPop = class("NewSlgFarmTeamPop", function()
	return fgui.GComponent:create({
		resName = "NewSlgFarmTeamPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.NewSlgConst

function NewSlgFarmTeamPop:ctor(arg_2_1)
	self:getView():center(true)

	arg_2_1 = arg_2_1 or {}
	self._teamTp = arg_2_1.tp or var_0_1.FARM_TEAM_POP_TYPE.ATK
	self._farmId = arg_2_1.id
	self._panel = self:getChild("ComPopSmallPanel")
	self._txtFarmNum = self:getChild("Txt_farmNum")
	self._txtDefNum = self:getChild("Txt_defNum")
	self._txtAuthority = self:getChild("Txt_authority")
	self._txtDesc = self:getChild("Txt_desc")
	self._listTeam = self:getChild("List_team")

	self._listTeam:setVirtual(self)
	self._listTeam:setItemRenderer(handler(self, self._onRenderListTeamCell))
	self._listTeam:setItemProvider(handler(self, self._onProviderTeamCell))

	self._btnHelp = self:getChild("Btn_help")

	self._btnHelp:addClickListener(handler(self, self._onClickHelp))

	self._popTpCtrl = self:getController("pop_tp")

	self._popTpCtrl:setSelectedIndex(self._teamTp - 1)
end

function NewSlgFarmTeamPop:_onClickHelp()
	return
end

function NewSlgFarmTeamPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETFARMDEFINFO, handler(self, self._onRcvNewSlgGetFarmDefInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETFARMBATTLEINFO, handler(self, self._onRcvNewSlgGetFarmAtkInfo), self)

	if self._teamTp == var_0_1.FARM_TEAM_POP_TYPE.ATK then
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetFarmBattleInfo({
			farm_id = self._farmId
		})
	elseif self._teamTp == var_0_1.FARM_TEAM_POP_TYPE.DEF then
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetFarmDefInfo({
			farm_id = self._farmId
		})
	end
end

function NewSlgFarmTeamPop:_sortTeam(arg_5_1)
	table.sort(arg_5_1, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0.move.start_time
		local var_6_1 = arg_6_1.move.start_time
		local var_6_2 = g.core.model.User.newSlgData:getPath(cc.p(arg_6_0.move.start_pos.x, arg_6_0.move.start_pos.y), (cc.p(arg_6_0.move.end_pos.x, arg_6_0.move.end_pos.y)))
		local var_6_3 = g.core.model.User.newSlgData:getPath(cc.p(arg_6_1.move.start_pos.x, arg_6_1.move.start_pos.y), (cc.p(arg_6_1.move.end_pos.x, arg_6_1.move.end_pos.y)))
		local var_6_4 = arg_6_0.move.move_privilege or 0
		local var_6_5 = arg_6_1.move.move_privilege or 0
		local var_6_6 = g.core.model.User.newSlgData:isReachDest(var_6_2, var_6_0, var_6_4) and 1 or 0
		local var_6_7 = g.core.model.User.newSlgData:isReachDest(var_6_3, var_6_1, var_6_5) and 1 or 0

		if var_6_6 ~= var_6_7 then
			return var_6_7 < var_6_6
		end

		local var_6_8 = g.utils.ToolUtils.newSlgFunc.getMarchDurationByPath(var_6_2, var_6_4)
		local var_6_9 = g.utils.ToolUtils.newSlgFunc.getMarchDurationByPath(var_6_3, var_6_5)

		if var_6_0 + var_6_8 ~= var_6_1 + var_6_9 then
			return var_6_0 + var_6_8 > var_6_1 + var_6_9
		end

		return arg_6_0.move.id < arg_6_1.move.id
	end)
end

function NewSlgFarmTeamPop:_onRcvNewSlgGetFarmDefInfo(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = g.core.model.User.newSlgData:getFarmInfoById(self._farmId)
	local var_7_1 = arg_7_4.def_data

	self._defTeams = arg_7_4.def_data.def_teams or {}
	self._farmTeams = var_7_1.farm_teams or {}

	self:_sortTeam(self._defTeams)
	self:_sortTeam(self._farmTeams)

	local var_7_2 = #self._farmTeams

	self._txtDefNum:setText(g.core.lang:get(105014, {
		num1 = #self._defTeams,
		num2 = var_7_0.defend_team
	}))
	self._txtFarmNum:setText(g.core.lang:get(105014, {
		num1 = var_7_2,
		num2 = var_7_0.farm_together
	}))

	local var_7_3 = 0

	for iter_7_0, iter_7_1 in ipairs(self._defTeams) do
		var_7_3 = var_7_3 + iter_7_1.authority
	end

	for iter_7_2, iter_7_3 in ipairs(self._farmTeams) do
		var_7_3 = var_7_3 + iter_7_3.authority
	end

	local var_7_4 = {}

	for iter_7_4, iter_7_5 in ipairs(var_7_1.users or {}) do
		var_7_4[iter_7_5.id] = iter_7_5
	end

	local var_7_5 = {}

	for iter_7_6, iter_7_7 in ipairs(var_7_1.alli_to_province or {}) do
		var_7_5[iter_7_7.alli_id] = iter_7_7
	end

	self._arr = {}

	if #self._defTeams == 0 then
		-- block empty
	else
		for iter_7_8, iter_7_9 in ipairs(self._defTeams) do
			table.insert(self._arr, {
				realTeam = iter_7_9,
				user = var_7_4[iter_7_9.uid],
				province = var_7_5[var_7_4[iter_7_9.uid].alliance_id]
			})
		end
	end

	table.insert(self._arr, {
		title = g.core.lang:get(429699)
	})

	if var_7_2 == 0 then
		-- block empty
	else
		for iter_7_10, iter_7_11 in ipairs(self._farmTeams) do
			table.insert(self._arr, {
				realTeam = iter_7_11,
				user = var_7_4[iter_7_11.uid],
				province = var_7_5[var_7_4[iter_7_11.uid].alliance_id]
			})
		end
	end

	local var_7_6 = var_7_1.robot_teams or {}

	self._defTeams = var_7_6

	for iter_7_12, iter_7_13 in ipairs(self._defTeams) do
		var_7_3 = var_7_3 + iter_7_13.authority
	end

	self._txtAuthority:setText(var_7_3)

	if #var_7_6 > 0 then
		table.sort(var_7_6, function(arg_8_0, arg_8_1)
			if arg_8_0.authority ~= arg_8_1.authority then
				return arg_8_0.authority > arg_8_1.authority
			elseif arg_8_0.troops ~= arg_8_1.troops then
				return arg_8_0.troops > arg_8_1.troops
			else
				return arg_8_0.team_id < arg_8_1.team_id
			end
		end)
	end

	for iter_7_14, iter_7_15 in ipairs(var_7_6) do
		table.insert(self._arr, {
			defTeam = iter_7_15
		})
	end

	self._listTeam:setNumItems(#self._arr)
end

function NewSlgFarmTeamPop:_onRcvNewSlgGetFarmAtkInfo(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self._atkTeams = arg_9_4.atk_data.atk_teams or {}

	self:_sortTeam(self._atkTeams)
	self._txtDefNum:setText(#self._atkTeams)

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(self._atkTeams) do
		var_9_0 = var_9_0 + iter_9_1.authority
	end

	self._txtAuthority:setText(var_9_0)

	local var_9_1 = {}

	for iter_9_2, iter_9_3 in ipairs(arg_9_4.atk_data.users or {}) do
		var_9_1[iter_9_3.id] = iter_9_3
	end

	local var_9_2 = {}

	for iter_9_4, iter_9_5 in ipairs(arg_9_4.atk_data.alli_to_province or {}) do
		var_9_2[iter_9_5.alli_id] = iter_9_5
	end

	self._arr = {}

	if #self._atkTeams == 0 then
		-- block empty
	else
		for iter_9_6, iter_9_7 in ipairs(self._atkTeams) do
			table.insert(self._arr, {
				realTeam = iter_9_7,
				user = var_9_1[iter_9_7.uid],
				province = var_9_2[var_9_1[iter_9_7.uid].alliance_id]
			})
		end
	end

	self._listTeam:setNumItems(#self._arr)
end

function NewSlgFarmTeamPop:_onRenderListTeamCell(arg_10_1, arg_10_2)
	if self._arr[arg_10_1 + 1].realTeam then
		arg_10_2:updateCell(self._arr[arg_10_1 + 1].realTeam, self._arr[arg_10_1 + 1].user, self._arr[arg_10_1 + 1].province)
	elseif self._arr[arg_10_1 + 1].defTeam then
		arg_10_2:updateCell(self._arr[arg_10_1 + 1].defTeam)
	end
end

function NewSlgFarmTeamPop:_onProviderTeamCell(arg_11_1)
	if self._arr[arg_11_1 + 1].realTeam then
		return "ui://newSlg/NewSlgFarmTeamCell"
	elseif self._arr[arg_11_1 + 1].defTeam then
		return "ui://newSlg/NewSlgPvcDefenderInfoCell"
	end
end

function NewSlgFarmTeamPop:onUnload()
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgFarmTeamCell_updateSch")
end

return NewSlgFarmTeamPop
