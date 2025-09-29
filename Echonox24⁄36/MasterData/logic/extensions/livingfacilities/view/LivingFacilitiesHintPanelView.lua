-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesHintPanelView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesHintPanelView", package.seeall)

local M = class("LivingFacilitiesHintPanelView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
end

function M:setRegistry(registry)
	self._registry = registry

	self:_buildUI()
end

function M:_buildUI()
	self._hintItem = self._registry:findUIElement("room_live_entry_view_-1489365144")
	self._hintGo = self._registry:findUIElement("room_live_entry_view_1621124370")
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_CHECK_CONFLICT, self._refreshHint, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_CHECK_CONFLICT, self._refreshHint, self)
	end
end

function M:_refreshHint(e, data)
	local function _addHint(add, txtStr)
		if add then
			local obj = goutil.clone(self._hintItem)

			goutil.addChildToParent(obj, self._hintGo)

			local hintText = goutil.findChildTextComponent(obj, "txtHint")

			hintText.text = txtStr

			goutil.setActive(obj, true)
		end
	end

	goutil.clearChildren(self._hintGo)

	if data then
		_addHint(data.furnitureOverlap, lang("tip_edit_furniture_lang_10"))
		_addHint(data.sealDoor, lang("tip_edit_furniture_lang_11"))
		_addHint(data.forbidSingleBed, lang("tip_edit_furniture_lang_12"))
		_addHint(data.forbidDoubleBed, lang("tip_edit_furniture_lang_13"))
		_addHint(data.overSingleBed, lang("tip_edit_furniture_lang_14"))
		_addHint(data.overDoubleBed, lang("tip_edit_furniture_lang_15"))
		_addHint(data.noPath, lang("tip_edit_furniture_lang_16"))
	end
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._hintItem = nil
	self._hintGo = nil
end

return M
