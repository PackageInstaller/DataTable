-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsEquipComp.lua

module("logic.extensions.tooltips.component.ToolTipsEquipComp", package.seeall)

local M = class("ToolTipsEquipComp", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._equipDetailComp = Astral.LuaComponentContainer.Add(self.mainGO, EquipTipsDetailInfoComponent)

	self._equipDetailComp:buildUI()
end

function M:destroyUI()
	return
end

function M:_bindEvents()
	self._equipDetailComp:bindEvents()
	GlobalDispatcher:addEventListener(EventType.TIPS_CHANGE_ENABLE_EVENT, self.changeComponentEnable, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshEquipInfo, self)
	GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_CHANGE_EVENT, self._handleItemChangedPush, self)
end

function M:_unbindEvents()
	self._equipDetailComp:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.TIPS_CHANGE_ENABLE_EVENT, self.changeComponentEnable, self)
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshEquipInfo, self)
	GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_CHANGE_EVENT, self._handleItemChangedPush, self)
end

function M:_handleItemChangedPush(e, msg)
	if msg and msg.optType == GameEnum.OptionType.ITEM_LOCK then
		local uuid = self._equipMo:getUuid()

		if uuid then
			local equipItemData = ItemModel.instance:getItemDataByUuid(uuid)

			self._equipMo = equipItemData

			self:_refreshEquipInfo()
		end
	end
end

function M:onEnter()
	TransformUtils.SetLocalScale(self.mainGO.transform, 1, 1, 1)
	self._guiAnimation:StopTimelineAni()
	self:_bindEvents()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)

	local info = self:getFirstParam()

	self._equipMo = info.baseData
	self._isHideLock = info.isHideLock

	self:_refreshEquipInfo()
end

function M:onExit()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
	self:_unbindEvents()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
end

function M:_refreshEquipInfo()
	if not self._equipMo then
		return
	end

	self._equipDetailComp:setHideLock(self._isHideLock)
	self._equipDetailComp:setEquipData(self._equipMo)
end

function M:_refreshLock()
	goutil.setActive(self._lockRootGo, false)

	if self._isHideLock or self._equipMo:getUuid() == 0 then
		return
	end

	local uuid = self._equipMo:getUuid()
	local equipItemData = ItemModel.instance:getItemDataByUuid(uuid)

	if not equipItemData then
		return
	end

	goutil.setActive(self._lockRootGo, true)

	self._equipMo = equipItemData

	self._lock:SetActive(equipItemData:getIsLock())
	self._unlock:SetActive(not equipItemData:getIsLock())
end

function M:changeComponentEnable(_, finish, viewName)
	if not finish then
		return
	end

	if self._viewPresentor:getViewName() == viewName then
		goutil.setActive(self.mainGO, true)
		self._guiAnimation:PlayAniByName("open1")
	end
end

return M
