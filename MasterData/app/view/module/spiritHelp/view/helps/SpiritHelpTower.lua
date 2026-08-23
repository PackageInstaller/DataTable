local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.const.ConstMgr.TowerConst
local var_0_2 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.model.User.towerData
local SpiritHelpTower = class("SpiritHelpTower", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpTower:initData()
	self._cellName = "SpiritHelpCell1"
	self._needAddEventList = {
		[var_0_3.EVENT_NET_S2C_TOWER_HELPONEKEYCHALLENGE] = handler(self, self._onRcvAllBlitz)
	}
	self._getContents = {}
	self._awardDict = {}
end

function SpiritHelpTower:getAwardText(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self._getContents) do
		local var_2_1, var_2_2, var_2_3 = var_0_4:getCurTowerIdByType(iter_2_1.stage_type)
		local var_2_4 = var_0_0.get(var_2_2) or {}
		local var_2_5 = var_2_4.stage_order
		local var_2_6, var_2_7

		if not var_2_3 then
			var_2_5 = var_2_4.stage_order - 1
			var_2_6 = var_2_0
			var_2_7 = g.core.lang:get(308001 + iter_2_1.stage_type)
		end

		table.insert(var_2_0, var_2_7 .. g.core.lang:get(308022, {
			stageOrder = var_2_5
		}))
	end

	return {
		langId = 409523,
		param = {
			desc = table.concat(var_2_0, " ")
		}
	}
end

function SpiritHelpTower:refreshState()
	self._isTip = false

	local var_3_0 = true

	for iter_3_0, iter_3_1 in pairs(var_0_1.STAGE_TYPE) do
		if var_0_4:isSpiritHelpShow(iter_3_1) then
			var_3_0 = false

			break
		end
	end

	if var_3_0 then
		self._state = var_0_2.STATE.LOCK
		self._isTip = true
		self._tipStr = g.core.lang:get(409511)
	else
		self._state = var_0_2.STATE.NORMAL
	end
end

function SpiritHelpTower:doing()
	for iter_4_0, iter_4_1 in pairs(var_0_1.STAGE_TYPE) do
		if var_0_4:isSpiritHelpShow(iter_4_1) then
			self:send(function()
				g.core.network.GameNetProxy:send_C2S_Tower_HelpOneKeyChallenge({
					play_type = 1,
					stage_type = iter_4_1
				})
			end)

			self._isFinish = false

			return
		end
	end

	self._getContents = {}
	self._awardDict = {}
	self._isFinish = true
end

function SpiritHelpTower:_onRcvAllBlitz(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	for iter_6_0, iter_6_1 in ipairs(arg_6_4.awards) do
		self:addCurDoAward(iter_6_1.award)
	end

	table.insert(self._getContents, arg_6_4)

	for iter_6_2, iter_6_3 in pairs(var_0_1.STAGE_TYPE) do
		if var_0_4:isSpiritHelpShow(iter_6_3) then
			self:setDoingState(var_0_2.DOING_STATE.DOING)

			return
		end
	end

	self:setDoingState(var_0_2.DOING_STATE.SUCCESS)
end

function SpiritHelpTower:addCurDoAward(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		self._awardDict[iter_7_1.type .. "_" .. iter_7_1.value] = not self._awardDict[iter_7_1.type .. "_" .. iter_7_1.value] and iter_7_1.size or self._awardDict[iter_7_1.type .. "_" .. iter_7_1.value] + iter_7_1.size
	end
end

function SpiritHelpTower:getCurDoingAward()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self._awardDict) do
		local var_8_1 = string.split(iter_8_0, "_")

		table.insert(var_8_0, {
			type = tonumber(var_8_1[1]),
			value = tonumber(var_8_1[2]),
			size = iter_8_1
		})
	end

	return var_8_0
end

return SpiritHelpTower
