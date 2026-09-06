-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/controller/BattleSettlementController.lua

module("logic.extensions.battlesettlement.controller.BattleSettlementController", package.seeall)

local BattleSettlementController = class("BattleSettlementController", BaseController)

function BattleSettlementController:onInit()
	self:onReset()
end

function BattleSettlementController:onReset()
	self._elementList = {}
end

function BattleSettlementController:getElements()
	return self._elementList
end

function BattleSettlementController:clearElements()
	self._elementList = {}
end

function BattleSettlementController:addConditionElement(desc, isReach)
	local ele = {}

	ele.txtDesc = desc
	ele.isReach = isReach

	table.insert(self._elementList, ele)
end

function BattleSettlementController:addDefaultConditions()
	local conditionType = BattleModel.instance:getConditionType()

	if not string.nilorempty(conditionType) and conditionType ~= GameEnum.Evaluate.BuffNum and conditionType ~= GameEnum.Evaluate.EnemyBuffNum then
		self:_setSpecialCondition(conditionType)
	else
		self:_addCommonCondition()
	end
end

function BattleSettlementController:_addCommonCondition()
	local enemys = BattleModel.instance:getEnemyUnits()
	local totalNum = 0
	local curNum = 0
	local isReach

	for k, v in pairs(enemys) do
		if not v.attrs:isFakePet() then
			totalNum = totalNum + 1

			if v.attrs:getCurHp() <= 0 then
				curNum = curNum + 1
			end
		end
	end

	isReach = totalNum <= curNum

	local color = self:_getColorStr(isReach)

	self:addConditionElement(string.format("击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", color, curNum, totalNum), isReach)
end

function BattleSettlementController:_setSpecialCondition(conditionType)
	local conditionParams = BattleModel.instance:getConditionParams()

	if conditionType == GameEnum.Evaluate.Combination then
		local jConditionParams = GameUtil.jsonToTable(conditionParams)

		for id, singleConditionParam in pairs(jConditionParams) do
			local cfgWinnerOp = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(checknumber(id))

			if cfgWinnerOp then
				self:_addSpecialCondition(cfgWinnerOp.type, singleConditionParam, cfgWinnerOp.params, cfgWinnerOp.desc)
			end
		end
	else
		local conditionTypeParams = BattleModel.instance:getConditionTypeParams()

		self:_addSpecialCondition(conditionType, conditionParams, conditionTypeParams)
	end
end

function BattleSettlementController:_addSpecialCondition(conditionType, conditionParams, conditionTypeParams, desc)
	local cfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(conditionType)

	if cfg then
		local element1 = {}

		element1.txtDesc = ""

		local jConditionParams = GameUtil.jsonToTable(conditionParams)
		local num = 0

		if cfg.paramNames and cfg.paramNames[1] and jConditionParams and jConditionParams[cfg.paramNames[1]] then
			num = jConditionParams[cfg.paramNames[1]]
		end

		local cfgStr = conditionTypeParams

		if cfg.type == GameEnum.Evaluate.DamageTotal then
			element1.txtDesc = string.format(cfg.desc, tostring(num))
		elseif cfg.type == GameEnum.Evaluate.MyActivePetContainsAttrs then
			local paramList = string.split(cfgStr, ",")

			if paramList and #paramList == 2 then
				element1.txtDesc = string.format(cfg.desc, paramList[2], paramList[1])
			elseif paramList and #paramList > 2 then
				local strJoint = paramList[2]

				for i = 3, #paramList do
					strJoint = strJoint .. paramList[i]
				end

				element1.txtDesc = string.format(cfg.desc, strJoint, paramList[1])
			else
				element1.txtDesc = cfg.desc
			end
		elseif cfg.type == GameEnum.Evaluate.MyPosIdMustActive then
			local paramList = string.split(cfgStr, ",")
			local str = ""

			if paramList and #paramList > 0 then
				for i, v in ipairs(paramList) do
					str = str .. checknumber(v) + 1

					if i ~= #paramList then
						str = str .. ","
					end
				end
			end

			element1.txtDesc = string.format(cfg.desc, str)
		elseif cfg.type == GameEnum.Evaluate.PosHpRate then
			local paramList = string.split(cfgStr, "_")

			element1.txtDesc = paramList and #paramList == 2 and string.format(cfg.desc, paramList[1] + 1, checknumber(paramList[2]) * 100) or cfg.desc
		elseif cfg.type == GameEnum.Evaluate.DamageTotalRange then
			local paramList = string.split(cfgStr, "_")

			element1.txtDesc = paramList and #paramList == 2 and string.format(cfg.desc, paramList[1], tostring(num), paramList[2]) or cfg.desc
		elseif cfg.type == GameEnum.Evaluate.CircleCount then
			element1.txtDesc = string.format(cfg.desc, cfgStr)
		elseif cfg.type == GameEnum.Evaluate.MyRaceIdMustActive then
			local petcfg = CharacterConfig.instance:getPetCo(checknumber(cfgStr))

			if petcfg then
				if not petcfg.name then
					local name = ""

					element1.txtDesc = string.format(cfg.desc, name)
				end
			end
		elseif cfg.type == GameEnum.Evaluate.EqualCircleCount then
			element1.txtDesc = string.format(cfg.desc, cfgStr)
		elseif cfg.type == GameEnum.Evaluate.CharacterActiveNum then
			element1.txtDesc = string.format(cfg.desc, tostring(num))
		elseif cfg.type == GameEnum.Evaluate.EnemyActiveCount then
			local curActNum = checknumber(num)
			local needActNum = checknumber(cfgStr)
			local isReach = true
			local color = self:_getColorStr(isReach)

			element1.txtDesc = string.format(cfg.desc, needActNum, color, curActNum, needActNum)
		elseif cfg.type == GameEnum.Evaluate.KillNum then
			local curKillNum = checknumber(num)
			local needKillNum = checknumber(cfgStr)

			element1.txtDesc = string.format(cfg.desc, curKillNum)
		elseif cfg.type == GameEnum.Evaluate.ActiveCountLessThan then
			local lessThanActNum = checknumber(num)
			local curActNum = checknumber(cfgStr)

			element1.txtDesc = string.format(cfg.desc, lessThanActNum)
		elseif cfg.type == GameEnum.Evaluate.EnemyActiveLessThanCount then
			local curActNum = checknumber(num)
			local needActNum = checknumber(cfgStr)
			local isReach = curActNum <= needActNum
			local color = self:_getColorStr(isReach)

			element1.txtDesc = string.format(cfg.desc, needActNum, color, curActNum, needActNum)
		elseif cfg.type == GameEnum.Evaluate.RaceHpRate then
			local curActNum = checknumber(num)
			local arr = string.split(cfgStr, "_")
			local raceId = checknumber(arr[1])
			local goalRate = checknumber(arr[2])

			raceId = checknumber(raceId)

			local petData = CharacterConfig.instance:getPetCo(raceId)

			if petData then
				if not petData.name then
					local petName = ""
					local isReach = curActNum >= checknumber(goalRate)
					local color = self:_getColorStr(isReach)

					curActNum = curActNum <= 0 and 0 or math.floor(curActNum * 100)
					element1.txtDesc = string.format(cfg.desc, petName, goalRate * 100, color, curActNum, goalRate * 100)
					element1.isReach = isReach
				end
			end
		else
			local color = self:_getColorStr(checknumber(num) >= checknumber(cfgStr))

			element1.txtDesc = string.format(cfg.desc, checknumber(cfgStr)) .. string.format("  <color=#%s>(%s/%s)</color>", color, tostring(num), cfgStr)
		end

		if not string.nilorempty(desc) then
			element1.txtDesc = desc
		end

		self:addConditionElement(element1.txtDesc, element1.isReach)
	end
end

function BattleSettlementController:_getColorStr(bValue)
	return (bValue or nil) and (SettlementTarget.Colors.Sucess or SettlementTarget.Colors.Fail)
end

function BattleSettlementController:getDescByWinId(winId)
	printInfo("test 胜利条件id", winId)

	local desc = "nil"
	local cfg1 = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(winId)

	if not cfg1 then
		return desc
	end

	local resultStr = ""
	local cfg2 = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(cfg1.type)
	local type = cfg1.type

	if not string.nilorempty(cfg1.desc) then
		resultStr = cfg1.desc
	elseif cfg2 then
		printInfo("test getBattleWinDesc", winId, cfg1.params, cfg2.desc)

		if type == GameEnum.Evaluate.KillNum or type == GameEnum.Evaluate.DamageTotal or type == GameEnum.Evaluate.DieCount or type == GameEnum.Evaluate.CircleCount or type == GameEnum.Evaluate.EqualCircleCount or type == GameEnum.Evaluate.ActiveCount or type == GameEnum.Evaluate.ActiveCountLessThan or type == GameEnum.Evaluate.EnemyActiveCount or type == GameEnum.Evaluate.EnemyActiveLessThanCount then
			resultStr = string.format(cfg2.winDesc, checknumber(cfg1.params))
		elseif type == GameEnum.Evaluate.MyActivePetContainsAttrs then
			resultStr = self:_getMyActivePetContainsAttrsDesc(cfg1.params, cfg2.winDesc)
		elseif type == GameEnum.Evaluate.MyPosIdMustActive then
			resultStr = self:_getMyPosIdMustActiveDesc(cfg1.params, cfg2.winDesc)
		elseif type == GameEnum.Evaluate.PosHpRate then
			resultStr = self:_getPosHpRateDesc(cfg1.params, cfg2.winDesc)
		elseif type == GameEnum.Evaluate.DamageTotalRange then
			resultStr = self:_getDamageTotalRangeDesc(cfg1.params, cfg2.winDesc)
		elseif type == GameEnum.Evaluate.MyRaceIdMustActive then
			resultStr = self:_getMyRaceIdMustActiveDesc(cfg1.params, cfg2.winDesc)
		end
	end

	if string.nilorempty(resultStr) then
		return string.format("胜利条件无描述 winId = %d, type = %s", winId, type)
	else
		return resultStr
	end
end

function BattleSettlementController:_getMyActivePetContainsAttrsDesc(params, desc)
	local arr = string.split(params, ",")

	if arr and arr[1] and arr[2] then
		return string.format(desc, arr[2], arr[1])
	end
end

function BattleSettlementController:_getMyPosIdMustActiveDesc(params, desc)
	local arr = string.split(params, ",")

	if arr and #arr > 0 then
		local str = ""

		if #arr > 1 then
			for i, v in ipairs(arr) do
				local pos = checknumber(arr[i]) + 1

				str = i == #arr and str .. pos or str .. pos .. ","
			end
		else
			str = checknumber(arr[1]) + 1
		end

		return string.format(desc, str)
	end
end

function BattleSettlementController:_getPosHpRateDesc(params, desc)
	local arr = string.split(params, "_")

	if arr and arr[1] and arr[2] then
		local pos = checknumber(arr[1]) + 1
		local hpPercent = checknumber(arr[2]) * 100

		return string.format(desc, pos, hpPercent)
	end
end

function BattleSettlementController:_getDamageTotalRangeDesc(params, desc)
	local arr = string.split(params, "_")

	if arr and arr[1] and arr[2] then
		local minNum = checknumber(arr[1])
		local maxNum = checknumber(arr[2])
		local str = "当前伤害"

		return string.format(desc, minNum, str, maxNum)
	end
end

function BattleSettlementController:_getMyRaceIdMustActiveDesc(params, desc)
	local arr = string.split(params, ",")

	if arr and #arr > 0 then
		local str = ""

		if #arr > 1 then
			for i, v in ipairs(arr) do
				local petcfg = CharacterConfig.instance:getPetCo(checknumber(arr[i]))

				if petcfg then
					if not petcfg.name then
						local name = ""

						str = i == #arr and str .. name or str .. name .. ","
					end
				end
			end
		else
			local petcfg = CharacterConfig.instance:getPetCo(checknumber(arr[1]))

			if petcfg then
				if not petcfg.name then
					str = ""
				end
			end
		end

		return string.format(desc, str)
	end
end

BattleSettlementController.instance = BattleSettlementController.New()

return BattleSettlementController
