local AncientsFinalBattleReportPop = class("AncientsFinalBattleReportPop", require("app.fairyGUI.ancients.UI_AncientsFinalBattleReportPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsFinalBattleReportPop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.AncientsConst

function AncientsFinalBattleReportPop:ctor(arg_2_1)
	self:getView():center(true)
	self.m_List_path:setVirtual(self)
	self.m_List_path:setItemRenderer(handler(self, self._onRenderListPathCell))

	arg_2_1 = arg_2_1 or {}
	self._report = arg_2_1.report
end

function AncientsFinalBattleReportPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)
	self:_updateView()
end

function AncientsFinalBattleReportPop:_updateView()
	self.m_is_winController:setSelectedIndex(self._report.is_win and 1 or 0)

	local var_4_1 = self._report.atk_team or {}
	local var_4_2 = self._report.def_team or {}
	local var_4_3 = g.core.model.User.ancientsData:getTeam(var_0_1.GET_TEAM_TYPE.CURRENT_TEAM)

	if var_4_3 then
		local var_4_4 = var_4_3.team_id or 0

		if var_4_1.team_id == var_4_4 then
			self.m_isSelfController:setSelectedIndex(2)
		elseif var_4_2.team_id == var_4_4 then
			self.m_isSelfController:setSelectedIndex(1)
		end
	end

	self.m_isSelfController:setSelectedIndex(0)

	local var_4_5 = g.core.config.ancients_pet_info.get(var_4_1.pet.base_id)
	local var_4_6 = g.core.utils.Tools.ancientsFunc.getSnapshot(var_4_1.captain)

	self.m_Txt_atk_score:setText(self._report.atk_score)

	if var_4_6 then
		self.m_Comp_atk_icon:updateAsUser(var_4_6)
		self.m_Txt_atk_name:setText(g.core.lang:get(433332, {
			name = var_4_6.name
		}))
	end

	self.m_Txt_atk_fight_value:setText(var_4_1.pet_fight_value or 0)

	local var_4_7 = g.core.config.ancients_pet_info.get(var_4_2.pet.base_id)
	local var_4_8 = g.core.utils.Tools.ancientsFunc.getSnapshot(var_4_2.captain)

	self.m_Txt_def_score:setText(self._report.def_score)

	if var_4_8 then
		self.m_Comp_def_icon:updateAsUser(var_4_8)
		self.m_Txt_def_name:setText(g.core.lang:get(433332, {
			name = var_4_8.name
		}))
	end

	self.m_Txt_def_fight_value:setText(var_4_2.pet_fight_value or 0)

	self._pathsData = self:_getPathData()

	self.m_List_path:setNumItems(#self._pathsData)
end

function AncientsFinalBattleReportPop:_onRenderListPathCell(arg_5_1, arg_5_2)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self._report.scores or {}) do
		if iter_5_1.path_type == self._pathsData[arg_5_1 + 1].pathType then
			var_5_0 = iter_5_1
		end
	end

	arg_5_2:updateCell({
		pathData = self._pathsData[arg_5_1 + 1],
		scoreData = var_5_0
	})
end

function AncientsFinalBattleReportPop:_onGetCommonSimpleUserSnapshot(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:_updateView()
end

function AncientsFinalBattleReportPop:_getPathData()
	local var_7_0 = self._report.atk_team or {}
	local var_7_1 = self._report.def_team
	local var_7_2

	if not self._report.def_team then
		var_7_1 = {}
		var_7_2 = {
			{
				pathType = var_0_1.PATH_TYPE.TYPE1,
				atkUserIds = {},
				defUserIds = {},
				turnsData = {}
			},
			{
				pathType = var_0_1.PATH_TYPE.TYPE2,
				atkUserIds = {},
				defUserIds = {},
				turnsData = {}
			},
			{
				pathType = var_0_1.PATH_TYPE.TYPE3,
				atkUserIds = {},
				defUserIds = {},
				turnsData = {}
			}
		}
	end

	for iter_7_0, iter_7_1 in ipairs({
		var_7_0,
		var_7_1
	}) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1.formation_positions or {}) do
			local var_7_4 = iter_7_3.pos <= 3 and var_7_2[1] or iter_7_3.pos <= 6 and var_7_2[2] or var_7_2[3]

			if iter_7_0 == 1 then
				table.insert(var_7_4.atkUserIds, iter_7_3.uid)
			else
				table.insert(var_7_4.defUserIds, iter_7_3.uid)
			end
		end
	end

	for iter_7_4, iter_7_5 in ipairs(self._report.turns or {}) do
		local var_7_7 = g.core.model.User.ancientsData:getUserFormationPos(iter_7_5.atk_uid, var_0_1.GET_TEAM_TYPE.CUSTOM_TEAM, var_7_0)

		table.insert((var_7_7 <= 3 and var_7_2[1] or var_7_7 <= 6 and var_7_2[2] or var_7_2[3]).turnsData, iter_7_5)
	end

	if self._report.extra_turns and #self._report.extra_turns > 0 then
		local var_7_8 = {
			pathType = var_0_1.PATH_TYPE.TYPE4,
			atkUserIds = {},
			defUserIds = {},
			turnsData = {}
		}

		for iter_7_6, iter_7_7 in ipairs(self._report.extra_turns) do
			if not table.indexof(var_7_8.atkUserIds, iter_7_7.atk_uid) then
				table.insert(var_7_8.atkUserIds, iter_7_7.atk_uid)
			end

			if not table.indexof(var_7_8.defUserIds, iter_7_7.def_uid) then
				table.insert(var_7_8.defUserIds, iter_7_7.def_uid)
			end

			table.insert(var_7_8.turnsData, iter_7_7)
		end

		table.insert(var_7_2, var_7_8)
	end

	return var_7_2
end

function AncientsFinalBattleReportPop:_sendSimpleUserSnapshot()
	local var_8_0 = {}
	local var_8_1 = {}

	var_8_1[1] = self._report.atk_team or {}
	var_8_1[2] = self._report.def_team or {}

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1.users or {}) do
			if not table.indexof(var_8_0, iter_8_3.user_id) then
				table.insert(var_8_0, iter_8_3.user_id)
			end
		end
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot(var_8_0) then
		self:_updateView()
	end
end

return AncientsFinalBattleReportPop
