-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleConfigLoader.lua

module("logic.battle.battleflow.component.BattleConfigLoader", package.seeall)

local BattleConfigLoader = class("BattleConfigLoader", IBattleFlowComp)
local json = require("cjson")
local tempTerrainConfigTable = {}

function BattleConfigLoader:onInit()
	self._resLoader = MultiResLoader.New()
	self._terrainLoader = MultiResLoader.New()
	self._handler = Handler.New()
end

function BattleConfigLoader:onStart()
	self._boardModel = self.flow.boardModel or false

	local model = self.flow.model or false
	local url = BattleResourceUtil.getCheckerBoardConfig(model:getCheckBoardResPath())

	self._resLoader:addResPath(url)
end

function BattleConfigLoader:onClear()
	self._boardModel = false

	self._handler:clear()
	self._resLoader:clear()
	self._terrainLoader:clear()
end

function BattleConfigLoader:load(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(self._onAllBoardConfigLoaded, false, self)
end

function BattleConfigLoader:getConfigResource(resPath)
	return self._resLoader:getResource(resPath)
end

function BattleConfigLoader:removeListener()
	self._handler:clear()
end

function BattleConfigLoader:_onAllBoardConfigLoaded()
	local loader = self._resLoader

	if not loader:isAllSuccess() then
		if BattleLog.enableError then
			BattleLog.error("Load Board resource failed!")
		end

		self._handler:call(false)

		return
	end

	local boardModel = self._boardModel
	local resPaths = loader._resPaths

	for _, resPath in pairs(resPaths) do
		local res = loader:getResource(resPath)
		local textAsset = res and res:GetMainAsset()

		if textAsset then
			boardModel:registerBoardJsonConfig(resPath, textAsset.text)
		elseif BattleLog.enableError then
			BattleLog.error(string.format("BattleConfigLoader::board config of %s is nil!", resPath))
		end
	end

	self:_loadTerrainConfig()
end

function BattleConfigLoader:_loadTerrainConfig()
	local allBoardMO = self._boardModel:getAllBoardMO()
	local resLoader = self._terrainLoader

	for _, boardMO in pairs(allBoardMO) do
		for _, cellMO in boardMO:ipairs() do
			local terrainName = cellMO:getTerrainName()

			if not string.nilorempty(terrainName) then
				local terrainUrl = BattleResourceUtil.getTerrainConfigUrl(terrainName)

				resLoader:addResPath(terrainUrl)
			end
		end
	end

	resLoader:load(self._onAllTerrainConfigLoaded, false, self)
end

function BattleConfigLoader:_onAllTerrainConfigLoaded()
	local resLoader = self._terrainLoader

	if not resLoader:isAllSuccess() then
		if BattleLog.enableError then
			BattleLog.error("Load Terrain resource failed!")
		end

		self._handler:call(false)

		return
	end

	self:_applyTerrainConfig()
	resLoader:clear()
	self._handler:call(true)
end

function BattleConfigLoader:_applyTerrainConfig()
	local resLoader = self._terrainLoader
	local terrainConfigTable = tempTerrainConfigTable
	local allBoardMO = self._boardModel:getAllBoardMO()

	for _, boardMO in pairs(allBoardMO) do
		for _, cellMO in boardMO:ipairs() do
			local terrainName = cellMO:getTerrainName()

			if not string.nilorempty(terrainName) then
				local terrainConfig = terrainConfigTable[terrainName]

				if terrainConfig then
					boardMO:overrideCellMOByTerrainConfig(cellMO, terrainConfig)
				else
					local resPath = BattleResourceUtil.getTerrainConfigUrl(terrainName)
					local res = resLoader:getResource(resPath)
					local textAsset = res and res:GetMainAsset()

					terrainConfig = json.decode(textAsset.text)
					terrainConfigTable[terrainName] = terrainConfig

					boardMO:overrideCellMOByTerrainConfig(cellMO, terrainConfig)
				end
			end
		end
	end

	BattleTableUtil.clearTable(terrainConfigTable)
end

return BattleConfigLoader
