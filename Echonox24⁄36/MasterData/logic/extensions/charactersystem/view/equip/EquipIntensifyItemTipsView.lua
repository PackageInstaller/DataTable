-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipIntensifyItemTipsView.lua

module("logic.extensions.charactersystem.view.equip.EquipIntensifyItemTipsView", package.seeall)

local M = class("EquipIntensifyItemTipsView", ViewComponent)

function M:buildUI()
	self._clickBtn = self:getBtnByPath("empty_raycast_mask")
	self._passEvent = self._clickBtn.gameObject:GetComponent(ComponentType.PassEvent)
	self._passEvent.isPassEvent = true
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._equipDetailComp = Astral.LuaComponentContainer.Add(self.mainGO, EquipTipsDetailInfoComponent)

	self._equipDetailComp:buildUI()
end

function M:bindEvents()
	self._equipDetailComp:bindEvents()
	self._clickBtn:AddClickListener(self._clickMask, self)
end

function M:unbindEvents()
	self._equipDetailComp:unbindEvents()
	self._clickBtn:RemoveClickListener()
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._onEquipInfoChanged, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_ITEM_TIPS_REFRESH, self._refreshView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._onEquipInfoChanged, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_ITEM_TIPS_REFRESH, self._refreshView, self)
	end
end

function M:onEnter()
	self:_setEvents(true)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open1")

	local info = self:getFirstParam()

	self:_refreshView(nil, info)
end

function M:_refreshView(e, info)
	removetimer(self.close, self)

	self._equipMo = info.itemData
	self._isHideLock = info.isHideLock

	if not self._equipMo then
		return
	end

	self._equipDetailComp:setHideLock(self._isHideLock)
	self._equipDetailComp:setEquipData(self._equipMo)

	if info.obj then
		local x, y, z = GameUtils.getPos(info.obj)

		GameUtils.setPos(self.mainGO, x, y, z)
	end

	GlobalDispatcher:dispatchEvent(EventType.EQUIP_ITEM_TIPS_STATE, true)
end

function M:onExit()
	removetimer(self.close, self)
	self:_setEvents(false)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_ITEM_TIPS_STATE, false)
end

function M:_onEquipInfoChanged(e)
	if not self._equipMo then
		return
	end

	local equipUuid = self._equipMo:getUuid()

	self._equipMo = ItemModel.instance:getItemDataByUuid(equipUuid)

	self._equipDetailComp:setEquipData(self._equipMo)
end

function M:_clickMask()
	settimer(0.1, self.close, self, false)
end

function M:destroyUI()
	return
end

return M
