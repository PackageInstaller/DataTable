-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneAnimClip.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneAnimClip", package.seeall)

local M = class("UnitCompMainSceneAnimClip", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = MultiResLoader.New()
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onDestroy()
	self:onReset()
	self:clear()

	self._resLoader = nil
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:onReset()
	self:setEvent(false)
end

function M:onReuse()
	self:setEvent(true)
end

function M:getIsLoadedFinish()
	return self._isAllFinish
end

function M:clear()
	self._isAllFinish = false

	if self._delayTween then
		self._delayTween:Kill(false)
	end

	self._delayTween = nil

	if self._resDic then
		for _, res in pairs(self._resDic) do
			res:Release()
		end
	end

	self._resDic = nil
	self._resClip = nil

	if self._resLoader then
		self._resLoader:clear()
	end
end

function M:setEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
	end
end

function M:_handleOnMeshModelLoaded()
	self:_loadClip()
end

function M:getRandomAvaiableClipName()
	if self._resClip and self._resClip.shafa_idle then
		return "shafa_idle"
	end

	if self._resClip and self._resClip.shafa_loop then
		return "shafa_loop"
	end

	local clipName

	for _clipName, _clip in pairs(self._resClip or {}) do
		clipName = clipName or _clipName
	end

	return clipName
end

function M:setAnimLoadList(list)
	self._animLoadList = list
end

function M:getAnimLoadList()
	return self._animLoadList
end

function M:_loadClip()
	self:clear()

	local animPlayer = self._unit.meshModel:getAnimationPlayer()
	local allAniNames = {}

	animPlayer:GetAnimationNamesLua(allAniNames)

	local animRegList = self:getAnimLoadList()
	local needAniNames = {}

	for _, _name in ipairs(allAniNames) do
		for _, _regStr in pairs(animRegList) do
			if string.match(_name, _regStr) then
				needAniNames[_name] = 1
			end
		end
	end

	local paths = {}

	self._path2Name = {}

	for _name, _ in pairs(needAniNames) do
		local _path = animPlayer:GetAnimationPath(_name)

		if not string.nilorempty(_path) then
			table.insert(paths, _path)

			self._path2Name[_path] = _name
		end
	end

	self._resLoader:setResPaths(paths)
	self._resLoader:load(self._onAllResLoaded, self._onResLoaded, self)
end

function M:_onAllResLoaded(loader)
	local animPlayer = self._unit.meshModel:getAnimationPlayer()

	if animPlayer and not goutil.isNil(animPlayer) then
		local hasShafaIdle = animPlayer:ContainsAnimation("shafa_idle")
		local canExcute = self._unit:checkInScene() and not self:isDestroyed()

		if canExcute then
			for clipName, clip in pairs(self._resClip or {}) do
				animPlayer:ReplaceClip(clipName, clip)
			end

			self._isAllFinish = true

			self._unit:dispatchInnerEvent(UnitActionType.MainSceneHeroAniPrepareFinish)
		end
	end
end

function M:_onResLoaded(res)
	if not res.IsSuccess then
		printError(string.format("资源加载失败:%s", res.ResPath))

		return
	end

	local clipName = self._path2Name[res.ResPath]

	if string.nilorempty(clipName) then
		clipName = res.ResPath

		if enableLog then
			printWarn("[非阻断] 无法获取clipName:", res.ResPath)
		end
	end

	local prefabAsset = res:GetAsset(nil, nil)
	local realName = prefabAsset and prefabAsset.name or "nil"

	if not self._resDic then
		self._resDic = {}
	end

	self._resDic[res.ResPath] = res

	res:Retain()

	if not self._resClip then
		self._resClip = {}
	end

	self._resClip[clipName] = prefabAsset
end

return M
