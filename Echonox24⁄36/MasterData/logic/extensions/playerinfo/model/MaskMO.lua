-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/MaskMO.lua

module("logic.extensions.playerinfo.model.MaskMO", package.seeall)

local MaskMO = class("MaskMO")

function MaskMO:ctor(cfg)
	self._id = cfg.id
	self._icon = cfg.icon
	self._desc = cfg.desc
	self._name = cfg.name
end

function MaskMO:getId()
	return self._id
end

function MaskMO:getIcon()
	return self._icon
end

function MaskMO:getName()
	return self._name
end

function MaskMO:getDesc()
	return self._desc
end

return MaskMO
