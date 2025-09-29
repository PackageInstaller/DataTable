-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/MonumentLabelMO.lua

module("logic.extensions.playerinfo.model.MonumentLabelMO", package.seeall)

local MonumentLabelMO = class("MonumentLabelMO")

function MonumentLabelMO:ctor(cfg)
	self._id = cfg.id
	self._name = cfg.name
	self._monuments = nil
end

function MonumentLabelMO:getId()
	return self._id
end

function MonumentLabelMO:getName()
	return self._name
end

function MonumentLabelMO:getMonuments()
	if not self._monuments then
		self._monuments = {}

		local allMonumentCfgs = MonumentConfig.instance:getAllMonumentCfgs()

		for _, cfg in ipairs(allMonumentCfgs) do
			if cfg.label == self._id then
				table.insert(self._monuments, cfg.id)
			end
		end
	end

	return self._monuments
end

return MonumentLabelMO
