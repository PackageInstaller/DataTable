-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/avatar/config/AvatarConfig.lua

module("logic.extensions.avatar.config.AvatarConfig", package.seeall)

local AvatarConfig = class("AvatarConfig", BaseConfig)

function AvatarConfig:onInit()
	self._skeletonCfgs = nil
	self._partCfgs = nil
end

function AvatarConfig:getNames()
	return {
		"avatar_skeleton",
		"avatar_part",
		"skined_mesh"
	}
end

function AvatarConfig:handleConfig(name, content)
	if name == "avatar_skeleton" then
		self._avatarSkeleton = content
		self._skeletonCfgs = content
		self._defaultMo = {}
	elseif name == "avatar_part" then
		self._partCfgs = content
	elseif name == "skined_mesh" then
		self._skinedMesh = content

		self:_handleSkinedMesh()
	end
end

function AvatarConfig:_handleSkinedMesh()
	self._meshSortByGenders = {}

	for i = 1, #self._skinedMesh.dataList do
		local data = self._skinedMesh.dataList[i]

		if data.gender < 0 or data.gender > 1 then
			self:_addSkinedMeshByGender(0, data)
			self:_addSkinedMeshByGender(1, data)
		else
			self:_addSkinedMeshByGender(data.gender, data)
		end
	end
end

function AvatarConfig:_addSkinedMeshByGender(gender, data)
	self._meshSortByGenders[gender] = self._meshSortByGenders[gender] or {}

	local meshSortByGenders = self._meshSortByGenders[gender]

	meshSortByGenders[data.type] = meshSortByGenders[data.type] or {}

	table.insert(meshSortByGenders[data.type], data)
end

function AvatarConfig:getAllSkinedMeshCosByGender(gender)
	return self._meshSortByGenders[gender]
end

function AvatarConfig:getSkinMeshCo(id)
	return self._skinedMesh[id]
end

function AvatarConfig:getSkelCo(id)
	return self._avatarSkeleton[id]
end

function AvatarConfig:getAllSkelCos()
	return self._avatarSkeleton.dataList
end

function AvatarConfig:getSkeletonCfgs()
	if self._skeletonCfgs == nil then
		printError("Get Nil Avatar SkeletonCfgs")

		return
	end

	return self._skeletonCfgs.dataList
end

function AvatarConfig:getSkeletonCfgById(defineId)
	if self._skeletonCfgs == nil or defineId == nil then
		return
	end

	return self._skeletonCfgs[defineId]
end

function AvatarConfig:getPartCfgs()
	if self._partCfgs == nil then
		printError("Get Nil Avatar PartCfgs")

		return
	end

	return self._partCfgs.dataList
end

function AvatarConfig:getPartCfgById(defineId)
	if self._partCfgs == nil or defineId == nil then
		return
	end

	return self._partCfgs[defineId]
end

function AvatarConfig:getAvatarMoByCfgId(defineId)
	local skeletonCfg = self:getSkeletonCfgById(defineId)

	if not skeletonCfg then
		printError("get nil defaultMO Cfg")

		return
	end

	local type = skeletonCfg.type

	if type == AvatarCreateType.Player then
		return AvatarPlayerMo.New(defineId, true)
	elseif type == AvatarCreateType.Pig then
		return AvatarPetMo.New(defineId, true)
	elseif type == AvatarCreateType.Zoo then
		return AvatarZooMo.New(defineId, true)
	else
		return AvatarModel.New(defineId, true)
	end
end

function AvatarConfig:getAvatarDefaultDatasByCfg(defineId)
	local skeletonCfg = self:getSkeletonCfgById(defineId)

	if not skeletonCfg then
		return
	end

	local parts = {}
	local mostr = skeletonCfg.dressDefault

	if string.nilorempty(mostr) then
		return parts
	end

	local partstr = string.split(mostr, "#")

	for _, v in pairs(partstr) do
		local partId = checkint(v)

		if partId > 0 then
			table.insert(parts, partId)
		end
	end

	return parts
end

AvatarConfig.instance = AvatarConfig.New()

return AvatarConfig
