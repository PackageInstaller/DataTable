local AncientsBattleDetailPop = class("AncientsBattleDetailPop", require("app.fairyGUI.ancients.UI_AncientsBattleDetailPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsBattleDetailPop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.AncientsConst

function AncientsBattleDetailPop:ctor(arg_2_1)
	self:getView():center(true)
	self.m_List_detail:setVirtual(self)
	self.m_List_detail:setItemRenderer(handler(self, self._onRenderListDetailCell))

	self._report = arg_2_1.report
	self._details = self:_getDetails()
end

function AncientsBattleDetailPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)

	if var_0_1.DEBUG then
		self:_updateView()
	else
		self:_sendSimpleUserSnapshot()
	end
end

function AncientsBattleDetailPop:_updateView()
	self.m_List_detail:setNumItems(#self._details)
end

function AncientsBattleDetailPop:_onRenderListDetailCell(arg_5_1, arg_5_2)
	arg_5_2:updateCell({
		detail = self._details[arg_5_1 + 1]
	})
end

function AncientsBattleDetailPop:_onGetCommonSimpleUserSnapshot(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:_updateView()
end

function AncientsBattleDetailPop:_getDetails()
	local var_7_0 = {
		{
			formatType = var_0_1.PATH_TYPE.TYPE1
		},
		{
			formatType = var_0_1.PATH_TYPE.TYPE2
		},
		{
			formatType = var_0_1.PATH_TYPE.TYPE3
		}
	}

	for iter_7_0, iter_7_1 in ipairs(self._report.formation_positions or {}) do
		local var_7_1 = iter_7_1.pos <= 3 and var_7_0[1] or iter_7_1.pos <= 6 and var_7_0[2] or var_7_0[3]

		var_7_1.usersData = var_7_1.usersData or {}

		table.insert(var_7_1.usersData, {
			userId = iter_7_1.uid,
			score = self:_getUserScore(iter_7_1.uid)
		})

		var_7_1.turnsData = var_7_1.turnsData or {}

		for iter_7_2, iter_7_3 in ipairs((self:_getUserTurns(iter_7_1.uid))) do
			table.insert(var_7_1.turnsData, iter_7_3)
		end
	end

	local var_7_2 = {}

	for iter_7_4, iter_7_5 in ipairs(var_7_0) do
		if iter_7_5.usersData and #iter_7_5.usersData > 0 then
			table.insert(var_7_2, iter_7_5)
		end
	end

	return var_7_2
end

function AncientsBattleDetailPop:_getUserTurns(arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self._report.turns or {}) do
		if iter_8_1.atk_uid == arg_8_1 then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function AncientsBattleDetailPop:_getUserScore(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self._report.settles or {}) do
		if iter_9_1.uid == arg_9_1 then
			return iter_9_1.score or 0
		end
	end

	return 0
end

function AncientsBattleDetailPop:_sendSimpleUserSnapshot()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self._details or {}) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1.turnsData or {}) do
			if not table.indexof(var_10_0, iter_10_3.atk_uid) then
				table.insert(var_10_0, iter_10_3.atk_uid)
			end

			if not table.indexof(var_10_0, iter_10_3.def_uid) then
				table.insert(var_10_0, iter_10_3.def_uid)
			end
		end
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot(var_10_0) then
		self:_updateView()
	end
end

return AncientsBattleDetailPop
