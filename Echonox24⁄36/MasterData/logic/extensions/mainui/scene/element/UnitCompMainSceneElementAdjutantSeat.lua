-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/element/UnitCompMainSceneElementAdjutantSeat.lua

module("logic.extensions.mainui.scene.element.UnitCompMainSceneElementAdjutantSeat", package.seeall)

local M = class("UnitCompMainSceneElementAdjutantSeat", UnitCompMainSceneElementBase)

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)

	self._resLoader = MultiResLoader.New()
	self._resDict = {}
end

function M:Awake()
	M.super.Awake(self)
end

function M:OnEnable()
	M.super.OnEnable(self)
	self:setEvent(true)
end

function M:OnDisable()
	M.super.OnDisable(self)
	self:setEvent(false)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
	self:setEvent(false)
	self:_clear()

	self._resLoader = nil
	self._resDict = nil
end

function M:_initComponents()
	return
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:setElementId(elementId)
	local cfg = elementId and MainPerformConfig.instance:getConfigByKey(ConfigName.MainInteractElement, elementId) or nil

	if not cfg then
		return
	end

	local orgElementId = self:getElementId()

	M.super.setElementId(self, elementId)

	if orgElementId and orgElementId == elementId then
		return
	end

	self:_clear()

	local _toLoadPaths = {}

	if string.nilorempty(cfg.dynPath) then
		return
	end

	self._pathSeat = GameUrl.getMainSceneSeatUrl(cfg.dynPath)

	table.insert(_toLoadPaths, self._pathSeat)
	self._resLoader:setResPaths(_toLoadPaths)
	self._resLoader:load(self._onAllLoaded, self._onLoaded, self)
end

function M:getInst(resPath)
	if self._resDict then
		return self._resDict[resPath]
	end

	return nil
end

function M:_onAllLoaded(loader)
	self._resLoader:clear()
end

function M:_onLoaded(res)
	if not self._resDict then
		self._resDict = {}
	end

	if res.IsSuccess then
		res:Retain()

		if not self._resDict[res.ResPath] then
			local inst = goutil.cloneAndSetParent(res:GetAsset(nil, nil), self:getMainGO().transform)

			self._resDict[res.ResPath] = inst

			goutil.setActive(inst.gameObject, true)
		end
	end
end

function M:_clear()
	for _resTyp, go in pairs(self._resDict or {}) do
		goutil.destroy(go)
	end

	self._pathSeat = nil
	self._resDict = {}

	self._resLoader:clear()
end

return M
