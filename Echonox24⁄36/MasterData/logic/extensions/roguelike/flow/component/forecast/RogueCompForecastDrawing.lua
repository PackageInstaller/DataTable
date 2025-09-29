-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/forecast/RogueCompForecastDrawing.lua

module("logic.extensions.roguelike.flow.component.forecast.RogueCompForecastDrawing", package.seeall)

local M = class("RogueCompForecastDrawing", IRogueFlowComp)
local kDeltaLineY = 0

function M:onInit()
	self._resDict = {}
	self._allLineList = {}

	local resLoader = MultiResLoader.New()

	self._resLoader = resLoader

	local resPaths = {}

	table.insert(resPaths, BattleResourceName.AttackForecast)
	resLoader:setResPaths(resPaths)
	resLoader:load(self._onAllLoaded, self._onAdditionalLoaded, self)
end

function M:_onAdditionalLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end
end

function M:_onAllLoaded(loader)
	self._resLoader:clear()
end

function M:getRes(resPath)
	return self._resDict[resPath]
end

function M:getAsset(resPath)
	return self:getRes(resPath):GetAsset(nil, nil)
end

function M:getInst(resPath)
	local prefab = self:getAsset(resPath)

	return prefab and goutil.clone(prefab) or false
end

function M:onStart()
	self:setEvent(true)
end

function M:onClear()
	self:setEvent(false)
	self:clearForecastResult(true)
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_FORECAST_LINE, self._showForecastDrawing, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_FORECAST_LINE, self._showForecastDrawing, self)
	end
end

function M:_showForecastDrawing(sender, isShow, actionId, isMonster)
	if not isShow and self._lastIsMonster ~= nil and self._lastIsMonster ~= isMonster then
		return
	end

	if not isShow then
		self:clearForecastResult()

		return
	end

	self._lastIsMonster = isMonster

	local unit = RogueMgr.instance:getModel():getCurRoleUnit()
	local roleIndex = RogueMgr.instance:getModel():getCurRoleIndex()
	local targetPoss = {}
	local actionCo = isMonster and RoguelikeConfig.instance:getMonsterActionById(actionId) or RoguelikeConfig.instance:getRoleActionById(actionId)
	local rolePos = RoguelikeController.instance:getRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local monsterPos = RogueMgr.instance:getModel():getCurMonster().transform:getPosition()
	local startPos = isMonster and monsterPos or unit.transform:getPosition()

	for k, v in pairs(actionCo.tailTarget or {}) do
		if v == 2 then
			local roleMos = RogueMgr.instance:getModel():getAllRoleMos()

			for k1, v1 in pairs(roleMos) do
				if not v1.roleProp:getIsDeath() and roleIndex ~= k1 then
					table.insert(targetPoss, v1.transform:getPosition())
				end
			end
		end

		if v == 3 then
			local pos = Vector3.New(rolePos.x + kMapItemSize * 1.5, rolePos.y, rolePos.z + kMapItemSize * 1)

			table.insert(targetPoss, pos)
		end

		if v == 4 then
			table.insert(targetPoss, monsterPos)
		end

		if v == 5 then
			local pos = Vector3.New(rolePos.x + kMapItemSize * 4, rolePos.y, rolePos.z + kMapItemSize * 1)

			table.insert(targetPoss, pos)
		end

		if v == 6 then
			local roleMos = RogueMgr.instance:getModel():getAllRoleMos()
			local findTarget = false
			local index = RogueMgr.instance:getModel():getCurRoleIndex()

			for k1, v1 in pairs(roleMos) do
				if index < k1 and not v1.roleProp:getIsDeath() and not findTarget then
					table.insert(targetPoss, v1.transform:getPosition())

					findTarget = true
				end
			end

			for k1, v1 in pairs(roleMos) do
				if index ~= k1 and not v1.roleProp:getIsDeath() and not findTarget then
					table.insert(targetPoss, v1.transform:getPosition())

					findTarget = true
				end
			end
		end
	end

	for k, v in pairs(targetPoss) do
		local line = RogueForecastCurveLine:createInstance()

		line:setStartPositionXYZ(startPos.x, startPos.y + kDeltaLineY, startPos.z)
		line:setEndPositionXYZ(v.x, v.y + kDeltaLineY, v.z)
		line:setPlaySpeed(1)
		line:seLineWidth(0.1)
		line:rebuild()

		if isMonster then
			line:setColor("#D66D6D")
		else
			line:setColor("#ffffff")
		end

		table.insert(self._allLineList, line)
	end
end

function M:clearForecastResult(isDestroy)
	for k, v in pairs(self._allLineList or {}) do
		v:returnSelf()

		if isDestroy then
			v:destroy()
		end

		self._allLineList[k] = nil
	end
end

return M
