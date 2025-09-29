-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/prefabpool/PoolFactoryProducer.lua

module("logic.common.pool.prefabpool.PoolFactoryProducer", package.seeall)

local M = class("PoolFactoryProducer")

function M:ctor()
	self._prefabPoolFactorys = {}
	self._effectPoolFactorys = {}
	self._characterPoolFactorys = {}
	self._type2Factory = {
		[PoolObjectType.NormalPrefab] = {
			self._prefabPoolFactorys,
			PrefabPoolFactory
		},
		[PoolObjectType.Effect] = {
			self._effectPoolFactorys,
			EffectPoolFactory
		},
		[PoolObjectType.Character] = {
			self._characterPoolFactorys,
			CharacterPoolFactory
		}
	}
end

function M:getFactory(resPath, poolObjectType)
	poolObjectType = poolObjectType or PoolObjectType.NormalPrefab

	local config = self._type2Factory[poolObjectType]
	local factory = config[1][resPath]

	if not factory then
		factory = config[2].New()
		config[1][resPath] = factory
	end

	return factory
end

M.instance = M.New()

return M
