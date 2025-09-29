-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/tools/BattleUnitPrefabLoader.lua

module("logic.extensions.battle.tools.BattleUnitPrefabLoader", package.seeall)

local M = class("BattleUnitPrefabLoader", PrefabLoader)

function M.Get(go)
	return Astral.LuaComponentContainer.Add(go, BattleUnitPrefabLoader)
end

function M:ctor(container)
	M.super.ctor(self, container)

	self._multiResLoader = MultiResLoader.New()
	self._clipPath2Name = {}
	self._resPath2Clip = {}
	self._name2Asset = {}
	self._autoLoadAnimationStatus = true
	self._setParentAfterLoad = true
end

function M:setLoadAnimationStatus(status)
	self._autoLoadAnimationStatus = status
end

function M:setParentAfterLoad(status)
	self._setParentAfterLoad = status
end

function M:_onPrefabLoaded(res)
	if res.IsSuccess and not self._prefabInst and self._url == res.ResPath and self._go and not goutil.isNil(self._go) then
		local prefabAsset = res:GetAsset(nil, nil)

		if prefabAsset then
			self._prefabRes = res

			self._prefabRes:Retain()
			self:_autoLoadAnimation()
		end
	end
end

function M:_autoLoadAnimation()
	if not self._autoLoadAnimationStatus then
		self:_invokeCallBack()

		return
	end

	local prefabAsset = self._prefabRes:GetAsset(nil, nil)
	local animationPlayer = AnimationPlayer.Get(prefabAsset)
	local animationNames = BattleTableUtil.getTempList()

	animationPlayer:GetAnimationNamesLua(animationNames)
	self:_loadAnimations(animationNames)
	BattleTableUtil.releaseTempList(animationNames)
end

function M:_onAnimationAllLoaded()
	if self._prefabRes and self._go and not goutil.isNil(self._go) then
		local prefabAsset = self._prefabRes:GetAsset(nil, nil)

		if self._setParentAfterLoad then
			self._prefabInst = Astral.GameObjectUtil.CloneAndSetParent(prefabAsset, self._go.transform, nil)
		else
			self._prefabInst = Astral.GameObjectUtil.Clone(prefabAsset, nil)
		end

		self._prefabInst.layer = self._go.layer

		local animationPlayer = AnimationPlayer.Get(self._prefabInst)

		for clipName, clip in pairs(self._name2Asset) do
			animationPlayer:ReplaceClip(clipName, clip)
		end

		self:_invokeCallBack()
	end
end

function M:loadAnimations(animationNames, handler, obj)
	if handler and obj then
		self._loadedHandler = handler
		self._loadedHandlerObj = obj
	end

	self:_loadAnimations(animationNames)
end

function M:_loadAnimations(animationNames)
	if self._prefabRes then
		local prefabAsset = self._prefabRes:GetAsset(nil, nil)
		local animationPlayer = AnimationPlayer.Get(prefabAsset)
		local paths = {}

		for i, name in ipairs(animationNames) do
			local path = animationPlayer:GetAnimationPath(name)

			if not string.nilorempty(path) then
				self._clipPath2Name[path] = name

				table.insert(paths, path)
			end
		end

		self._multiResLoader:clear()
		self._multiResLoader:setResPaths(paths)
		self._multiResLoader:load(self._onAnimationAllLoaded, self._onOneClipLoaded, self)
	end
end

function M:_onOneClipLoaded(res)
	if not res.IsSuccess then
		printError(string.format("资源加载失败:%s", res.ResPath))

		return
	end

	local clipName = self._clipPath2Name[res.ResPath]

	if string.nilorempty(clipName) then
		clipName = res.ResPath

		if enableLog then
			printWarn("[非阻断] 无法获取clipName:", res.ResPath)
		end
	end

	local prefabAsset = res:GetAsset(nil, nil)

	self._resPath2Clip[res.ResPath] = res

	res:Retain()

	self._name2Asset[clipName] = prefabAsset
end

function M:_invokeCallBack()
	local tempHandler = self._loadedHandler
	local tempHandlerObj = self._loadedHandlerObj

	self._loadedHandler = nil
	self._loadedHandlerObj = nil

	if tempHandler ~= nil then
		if tempHandlerObj == nil then
			tempHandler(self)
		else
			tempHandler(tempHandlerObj, self)
		end
	end
end

function M:clear()
	self._multiResLoader:clear()

	for _, res in pairs(self._resPath2Clip) do
		res:Release()
	end

	table.clear(self._name2Asset)
	table.clear(self._resPath2Clip)
	table.clear(self._clipPath2Name)
	M.super.clear(self)
end

return M
