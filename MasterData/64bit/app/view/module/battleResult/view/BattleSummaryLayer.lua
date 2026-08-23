local BattleSummaryLayer = class("BattleSummaryLayer", require("app.fairyGUI.battleResult.UI_BattleSummaryLayer"), function()
	return fgui.GComponent:create({
		resName = "BattleSummaryLayer",
		pkgPath = "ui/battleResult/battleResult",
		pkgName = "battleResult"
	})
end)
local var_0_1 = g.core.module.ModuleManager

function BattleSummaryLayer:ctor(arg_2_1)
	self:showAtCenter()
	self:setSize(display.width, display.height)

	local var_2_0 = arg_2_1.info

	self._info = arg_2_1.info
	self._stageName = arg_2_1.stageName
	self._waves = self:_getWaves()

	self.m_multiController:setSelectedIndex(self._waves > 1 and 1 or 0)

	self._curWave = 1

	if self._waves > 1 then
		local var_2_1 = {}

		for iter_2_0 = 1, self._waves do
			table.insert(var_2_1, g.core.lang:get(110414, {
				num = iter_2_0
			}))
		end

		self.m_waveComp:setSelectionData(var_2_1)
	end

	self:_updateView(var_2_0)
	self.m_touchPanel:setSize(display.width, display.height)
	self.m_touchPanel:addClickListener(handler(self, function()
		var_0_1:popComponent()
	end))
	self.m_infoController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
end

function BattleSummaryLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHAT, self._recvChat, self)
end

function BattleSummaryLayer:_recvChat(arg_5_1, arg_5_2, arg_5_3)
	g.core.module.ModuleManager:tip(g.core.lang:get(110402))
end

function BattleSummaryLayer:_getMainId(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if iter_6_1.avartar_id then
			if g.core.config.knight_info.get(iter_6_1.id).type == 1 then
				return iter_6_1.id
			end
		else
			return 210000
		end
	end
end

function BattleSummaryLayer:_updateView(arg_7_1)
	self:_showSelfBattleInfo()
end

function BattleSummaryLayer:_onChangeTabCtrl()
	if self.m_infoController:getSelectedIndex() == 1 then
		self:_showOtherBattleInfo()
	else
		self:_showSelfBattleInfo()
	end
end

function BattleSummaryLayer:_showOtherBattleInfo()
	local var_9_0 = self._info.battle_res_share_title or self._info.battle_res_share_info.share_title
	local var_9_1 = self._info.battle_res_share_info.enemy_monster
	local var_9_2 = {}
	local var_9_3 = {
		0,
		0
	}
	local var_9_4 = {
		0,
		0
	}
	local var_9_5 = {
		0,
		0
	}
	local var_9_6 = {
		0,
		0
	}
	local var_9_7 = 0
	local var_9_8 = 0
	local var_9_9 = 0
	local var_9_10 = {}
	local var_9_11 = self:_getWavesInfo(self._curWave, false)

	for iter_9_0, iter_9_1 in ipairs(var_9_11) do
		local var_9_12 = iter_9_1.dam or 0
		local var_9_13 = iter_9_1.take_dam or 0
		local var_9_14 = iter_9_1.recover or 0

		var_9_7 = math.max(var_9_7, var_9_12)
		var_9_8 = math.max(var_9_8, var_9_13)
		var_9_9 = math.max(var_9_9, var_9_14)
		var_9_3[1] = var_9_3[1] + var_9_12
		var_9_4[1] = var_9_4[1] + var_9_13
		var_9_5[1] = var_9_5[1] + var_9_14

		if var_9_12 + var_9_13 + var_9_14 > var_9_6[1] then
			var_9_6[1] = var_9_12 + var_9_13 + var_9_14
			var_9_10[1] = iter_9_1
		end
	end

	for iter_9_2 = 1, #var_9_11 do
		var_9_2[iter_9_2] = {}
		var_9_2[iter_9_2][1] = var_9_11[iter_9_2]
		var_9_2[iter_9_2].dmax = var_9_7
		var_9_2[iter_9_2].tmax = var_9_8
		var_9_2[iter_9_2].rmax = var_9_9
		var_9_2[iter_9_2].dtotal = var_9_3
		var_9_2[iter_9_2].ttotal = var_9_4
		var_9_2[iter_9_2].rtotal = var_9_5
	end

	self.m_list:setVirtual()
	self.m_list:setItemRenderer(function(arg_10_0, arg_10_1)
		arg_10_1:update(var_9_2[arg_10_0 + 1], var_9_0, 2, var_9_1)
	end)
	self.m_list:setNumItems(#var_9_11)
end

function BattleSummaryLayer:_showSelfBattleInfo()
	local var_11_0 = self._info.battle_res_share_title or self._info.battle_res_share_info.share_title
	local var_11_1 = {}
	local var_11_2 = {
		0,
		0
	}
	local var_11_3 = {
		0,
		0
	}
	local var_11_4 = {
		0,
		0
	}
	local var_11_5 = {
		0,
		0
	}
	local var_11_6 = 0
	local var_11_7 = 0
	local var_11_8 = 0
	local var_11_9 = {}
	local var_11_10 = self:_getWavesInfo(self._curWave, true)

	for iter_11_0, iter_11_1 in ipairs(var_11_10) do
		local var_11_11 = iter_11_1.dam or 0
		local var_11_12 = iter_11_1.take_dam or 0
		local var_11_13 = iter_11_1.recover or 0

		var_11_6 = math.max(var_11_6, var_11_11)
		var_11_7 = math.max(var_11_7, var_11_12)
		var_11_8 = math.max(var_11_8, var_11_13)
		var_11_2[1] = var_11_2[1] + var_11_11
		var_11_3[1] = var_11_3[1] + var_11_12
		var_11_4[1] = var_11_4[1] + var_11_13

		if var_11_11 + var_11_12 + var_11_13 > var_11_5[1] then
			var_11_5[1] = var_11_11 + var_11_12 + var_11_13
			var_11_9[1] = iter_11_1
		end
	end

	for iter_11_2 = 1, #var_11_10 do
		var_11_1[iter_11_2] = {}
		var_11_1[iter_11_2][1] = var_11_10[iter_11_2]
		var_11_1[iter_11_2].dmax = var_11_6
		var_11_1[iter_11_2].tmax = var_11_7
		var_11_1[iter_11_2].rmax = var_11_8
		var_11_1[iter_11_2].dtotal = var_11_2
		var_11_1[iter_11_2].ttotal = var_11_3
		var_11_1[iter_11_2].rtotal = var_11_4
	end

	self.m_list:setVirtual()
	self.m_list:setItemRenderer(function(arg_12_0, arg_12_1)
		arg_12_1:update(var_11_1[arg_12_0 + 1], var_11_0, 1)
	end)
	self.m_list:setNumItems(#var_11_10)
end

function BattleSummaryLayer:_getWaves()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self._info.battle_res_share_info.own_teams) do
		if iter_13_1.seq then
			var_13_0[iter_13_1.seq] = true
		end
	end

	return (math.max(1, table.nums(var_13_0)))
end

function BattleSummaryLayer:_getWavesInfo(arg_14_1, arg_14_2)
	if self._waves == 1 then
		if arg_14_2 then
			return self._info.battle_res_share_info.own_teams
		else
			return self._info.battle_res_share_info.enemy_teams
		end
	else
		local var_14_1 = {}

		for iter_14_0, iter_14_1 in ipairs(arg_14_2 and self._info.battle_res_share_info.own_teams or self._info.battle_res_share_info.enemy_teams) do
			if iter_14_1.seq == arg_14_1 then
				var_14_1[#var_14_1 + 1] = iter_14_1
			end
		end

		return var_14_1
	end
end

function BattleSummaryLayer:receiveCompEvent(arg_15_1, arg_15_2)
	if arg_15_1 == "onCheckBattleWave" then
		self._curWave = arg_15_2.index or 1

		self:_onChangeTabCtrl()
	end
end

return BattleSummaryLayer
