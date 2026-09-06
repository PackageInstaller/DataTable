-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/expression/BattleExpresionBuff.lua

module("logic.extensions.battle.model.expression.BattleExpresionBuff", package.seeall)

local BattleExpresionBuff = class("BattleExpresionBuff", BattleExpressionBase)

function BattleExpresionBuff:ctor(expCo)
	self._expCo = expCo

	local limitParams = string.split(expCo.limitParams, "#")

	if limitParams[1] == "己阵" then
		self._teamId = BattleModel.instance.myTeamId
	elseif limitParams[1] == "敌阵" then
		self._teamId = BattleModel.instance:getEnemyPlayerTeam()
	end

	self._isTriggered = limitParams[2] == "触发"

	local index = 1

	self._petIds = nil

	for i = 2, #limitParams do
		if limitParams[i] == "触发" or limitParams[i] == "未触发" then
			self._isTriggered = limitParams[i] == "触发"
			index = i + 1

			break
		else
			self._petIds = self._petIds or {}
			self._petIds[tonumber(limitParams[i])] = true
		end
	end

	self._buffIds = {}

	local paramsLen = #limitParams

	for i = index, paramsLen do
		table.insert(self._buffIds, checknumber(limitParams[i]))
	end
end

function BattleExpresionBuff:isMet()
	local battleScene = SceneMgr.instance:getCurScene()
	local units = battleScene.unitFactory:getUnits(self._teamId)

	if units then
		local len = #self._buffIds
		local cnt = #units

		if self._isTriggered then
			for i = 1, cnt do
				local unit = units[i]

				if self:_containsPet(unit.raceId) and not unit.attrs:isDead() then
					for k = 1, len do
						if unit.buffList:getBuff(self._buffIds[k]) then
							return true
						end
					end
				end
			end

			return nil
		else
			for i = 1, cnt do
				if not unit.attrs:isDead() then
					local unit = units[i]

					if self:_containsPet(unit.raceId) then
						for k = 1, len do
							if unit.buffList:getBuff(self._buffIds[k]) then
								return nil
							end
						end
					end
				end
			end

			return true
		end
	end
end

function BattleExpresionBuff:_containsPet(petId)
	if not self._petIds then
		return true
	end

	return self._petIds[petId]
end

function BattleExpresionBuff:getTips()
	if self._expCo.limitTips and self._expCo.limitTips ~= 0 and #self._expCo.limitTips > 0 then
		return self._expCo.limitTips
	end

	if not self._buffsName then
		local t = {}
		local len = #self._buffIds

		for k = 1, len do
			local buffCo = BattleConfig.instance:getBuffCo(self._buffIds[i])

			if buffCo then
				table.insert(t, buffCo.name)

				if k ~= len then
					table.insert(t, ",")
				end
			end
		end

		self._buffsName = table.concat(t)
	end

	if self._teamId == BattleModel.instance.myTeamId then
		if self._isTriggered then
			return string.format(lang("catch_buff_self"), self._buffsName)
		else
			return string.format(lang("catch_no_buff_self"), self._buffsName)
		end
	elseif self._isTriggered then
		return string.format(lang("catch_buff_enemy"), self._buffsName)
	else
		return string.format(lang("catch_no_buff_enemy"), self._buffsName)
	end
end

return BattleExpresionBuff
