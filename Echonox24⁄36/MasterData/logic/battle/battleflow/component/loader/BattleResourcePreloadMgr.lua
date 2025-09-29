-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/loader/BattleResourcePreloadMgr.lua

module("logic.battle.battleflow.component.loader.BattleResourcePreloadMgr", package.seeall)

local BattleResourcePreloadMgr = class("BattleResourcePreloadMgr", IBattleFlowComp)
local kResourcePathList = {}

BattleResourcePreloadMgr._cacheResources = {}

function BattleResourcePreloadMgr:onInit()
	self._resLoader = BattleMultiResLoaderIncludeModel.New()
	self._handler = Handler.New()
end

function BattleResourcePreloadMgr:onStart()
	return
end

function BattleResourcePreloadMgr:onPreClear(isRestart)
	self._resLoader:clear()
end

function BattleResourcePreloadMgr:onClear(isRestart)
	self._resLoader:clear()
	self._handler:clear()
end

function BattleResourcePreloadMgr:preload(callback, callbackSelf)
	self._resLoader:clear()
	self:_collectUnitResource()
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(self._onAllLoaded, self)
end

function BattleResourcePreloadMgr:removeListener()
	self._handler:clear()
end

function BattleResourcePreloadMgr:clearPreloadResources()
	self._resLoader:clear()
end

function BattleResourcePreloadMgr:_onAllLoaded()
	if not self._resLoader:isAllSuccess() then
		if enableErrorLog then
			printError("preload resource failed!")
		end

		self._handler:call(false)

		return
	end

	self._handler:call(true)
end

function BattleResourcePreloadMgr:_collectUnitResource()
	local battleModel = BattleMgr.instance:getModel()
	local battleFieldInfo = battleModel:getBattleFieldInfo()
	local entityInfos = battleFieldInfo.entityInfos

	for _, entityInfo in pairs(entityInfos) do
		local entityCode = entityInfo.entityCode

		if entityInfo.entityType ~= BattleEnum.EntityType.HaloTerrain and entityInfo.entityType ~= BattleEnum.EntityType.Intangible then
			local entityCO = BattleEntityCOAdapter:getSharedEntityCOAdapter(entityInfo.entityCode, entityInfo.entityType)
			local modelCode = entityCO:getModelCode()
			local modelCO = ModelConfig.instance:getModelConfig(modelCode)
			local url = ModelCOUtil.getLowModelUrl(modelCO)

			if url then
				self._resLoader:addModelRes(url)
			end
		end
	end

	local battleType = battleModel:getBattleType()

	if AirWorkShopDefSceneUtil.isInAirBattle(battleType) then
		local messageAndHighlandBuildings = BattleTableUtil.getTempList()
		local airMapMO = self.flow:getMapMO()

		airMapMO:getBattlePreloadMOList(messageAndHighlandBuildings)

		for i, buildMO in ipairs(messageAndHighlandBuildings) do
			local buildId = buildMO:getId()
			local buildCO = AirWorkShopConfig.instance:getBuildingCO(buildId)
			local url = AirWorkShopDefSceneUtil.getBuildingPath(buildCO)

			self._resLoader:addNormalRes(url)
		end

		BattleTableUtil.releaseTempList(messageAndHighlandBuildings)
	end
end

return BattleResourcePreloadMgr
