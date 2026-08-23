local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleGuardPoolPop = class("TeamBattleGuardPoolPop", require("app.fairyGUI.teamBattle.UI_TeamBattleGuardPoolPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleGuardPoolPop",
		pkgPath = "ui/teamBattle/teamBattle",
		isFullScreen = true,
		pkgName = "teamBattle"
	})
end)

function TeamBattleGuardPoolPop:ctor(arg_2_1)
	self._formationData = g.core.model.User.teamBattleData:getFormationData()
	self._guardMap = {}

	for iter_2_0, iter_2_1 in pairs((self._formationData:getTempGuardMap())) do
		self._guardMap[iter_2_0] = g.core.model.User.knightsData:getKnight({
			advance_id = iter_2_1
		})
	end

	self:_initView()

	if arg_2_1 then
		self.m_isTempController:setSelectedIndex(1)
	end

	self._lockSend = false

	self.m_enterTransition:play()
end

function TeamBattleGuardPoolPop:_initView()
	self.m_knightList:setVirtual(self)
	self.m_knightList:setItemRenderer(handler(self, self._onTeamItemRender))
	self.m_knightList:doFairyBatching(false)
	self.m_startBtn:addClickListener(handler(self, self._onClickStartBtn))
	self.m_easyBtn:addClickListener(handler(self, self._onClickEasyBtn))
end

function TeamBattleGuardPoolPop:_onTeamItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateGuardItem(self._guardMap[arg_4_1 + 1], arg_4_1 + 1)
end

function TeamBattleGuardPoolPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SETBATTLEKNIGHTS, handler(self, self.onS2CTeamBattleSetBattleKnights), self)
	self:_updateView()
end

function TeamBattleGuardPoolPop:_updateView()
	local var_6_0 = g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.KNIGHT_POOL_INIT_NUM_ID).parameter

	self.m_knightList:setNumItems(var_6_0)
	self.m_easyKeyStateController:setSelectedIndex(var_6_0 <= table.nums(self._guardMap) and 1 or 0)
end

function TeamBattleGuardPoolPop:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "formationGuard" then
		self:_onClickPlaceCellKnightIcon(arg_7_2.pos)

		return true
	end
end

function TeamBattleGuardPoolPop:_onClickPlaceCellKnightIcon(arg_8_1)
	local var_8_0

	var_8_0 = require("app.view.base.infoPop.lineup.CommonLineUpKnightPop").new({
		itemUrl = "ui://teamBattle/TeamBattleLineUpKnightCell",
		isFilter = true,
		allList = g.core.model.User.knightsData:getOwnKnightList(0),
		isLineUpCall = handler(self, function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_1:getAdvanceId()

			for iter_9_0, iter_9_1 in pairs(arg_9_0._guardMap) do
				if var_9_0 == iter_9_1:getAdvanceId() then
					return true
				end
			end

			return false
		end),
		clickCheckFunc = handler(self, function(arg_10_0, arg_10_1)
			local var_10_0 = arg_10_1:getAdvanceId()
			local var_10_1

			for iter_10_0, iter_10_1 in pairs(arg_10_0._guardMap) do
				if iter_10_1:getAdvanceId() == var_10_0 then
					var_10_1 = iter_10_0
				end
			end

			if var_10_1 then
				g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
					desc = g.core.lang:get(427011, {
						pos = arg_8_1
					}),
					itemDataArr = {
						{
							type = g.core.common.Goods.TYPE_KNIGHT,
							value = arg_10_1:getBaseId(),
							teamName = g.core.lang:get(427140)
						}
					},
					onConfirm = handler(arg_10_0, function(arg_11_0)
						arg_11_0._guardMap[var_10_1] = nil

						arg_11_0._formationData:setTempGuardByAdvanceId(nil, var_10_1)

						arg_11_0._guardMap[arg_8_1] = arg_10_1

						arg_11_0._formationData:setTempGuardByAdvanceId(arg_10_1:getAdvanceId(), arg_8_1)
						arg_11_0:_updateView()
						g.core.module.ModuleManager:onlyPopSelfByDisplay(var_8_0)
					end)
				}))

				return false
			else
				arg_10_0._formationData:setTempGuardByAdvanceId(arg_10_1:getAdvanceId(), arg_8_1)

				arg_10_0._guardMap[arg_8_1] = arg_10_1

				arg_10_0:_updateView()

				return true
			end
		end),
		cellParam = {
			isTempGuard = true,
			stationPos = arg_8_1
		}
	})

	g.core.module.ModuleManager:pushPopup(nil, {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function TeamBattleGuardPoolPop:_onClickStartBtn()
	if self._lockSend then
		return
	end

	if self.m_isTempController:getSelectedIndex() == 1 then
		self._formationData:saveKnightPoolInfo()
		g.core.module.ModuleManager:popComponent()
	else
		local var_12_0 = false

		for iter_12_0 = 1, g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.KNIGHT_POOL_INIT_NUM_ID).parameter do
			if not self._guardMap[iter_12_0] then
				var_12_0 = true
			end
		end

		if var_12_0 then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(302032),
				desc = g.core.lang:get(427142),
				onConfirm = handler(self, handler(self, self._sendTeam))
			}))
		else
			self:_sendTeam()
		end
	end
end

function TeamBattleGuardPoolPop:_sendTeam()
	local var_13_0 = {}

	for iter_13_0 = 1, g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.KNIGHT_POOL_INIT_NUM_ID).parameter do
		if self._guardMap[iter_13_0] then
			var_13_0[#var_13_0 + 1] = self._guardMap[iter_13_0]:getServerId()
		end
	end

	if #var_13_0 < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(427137))

		return
	end

	g.core.network.GameNetProxy:send_C2S_TeamBattle_SetBattleKnights({
		knight_ids = var_13_0
	})
	self:_lockSendTeam()
end

function TeamBattleGuardPoolPop:_lockSendTeam()
	self._lockSend = true

	self:newScheduleOnce(handler(self, self._unlockSendTeam), 1)
end

function TeamBattleGuardPoolPop:_unlockSendTeam()
	self._lockSend = false
end

function TeamBattleGuardPoolPop:_onClickEasyBtn()
	if self.m_easyKeyStateController:getSelectedIndex() == 0 then
		self:_onEasyLineUp()
	else
		self:_onEasyLineOff()
	end
end

function TeamBattleGuardPoolPop:_onEasyLineUp()
	local var_17_0 = table.nums(self._guardMap)
	local var_17_1 = g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.KNIGHT_POOL_INIT_NUM_ID).parameter

	for iter_17_0, iter_17_1 in ipairs((var_17_0 < var_17_1 or nil) and self._formationData:autoPoolMember(var_17_1 - var_17_0)) do
		for iter_17_2 = 1, var_17_1 do
			if not self._guardMap[iter_17_2] then
				self._guardMap[iter_17_2] = iter_17_1

				self._formationData:setTempGuardByAdvanceId(iter_17_1:getAdvanceId(), iter_17_2)

				break
			end
		end
	end

	self:_updateView()
end

function TeamBattleGuardPoolPop:_onEasyLineOff()
	for iter_18_0, iter_18_1 in pairs(self._guardMap) do
		self._formationData:setTempGuardByAdvanceId(nil, iter_18_0)
	end

	self._guardMap = {}

	self:_updateView()
end

function TeamBattleGuardPoolPop:onS2CTeamBattleSetBattleKnights()
	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:replaceModule(g.view.entrance.TEAM_BATTLE_MAP_LAYER)
end

return TeamBattleGuardPoolPop
