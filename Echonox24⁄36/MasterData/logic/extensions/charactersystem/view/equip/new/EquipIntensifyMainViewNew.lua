-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/new/EquipIntensifyMainViewNew.lua

module("logic.extensions.charactersystem.view.equip.new.EquipIntensifyMainViewNew", package.seeall)

local M = class("EquipIntensifyMainViewNew", ViewComponent)

function M:buildUI()
	local equipDetailGo = self:getGo("1&backpack_equip_detail_tips_copy_154087081")

	self._equipDetailComp = Astral.LuaComponentContainer.Add(equipDetailGo, EquipLvUpDetailInfoComponentNew)

	local leftEquipShowGo = self:getGo("0&left_equip_show_1427460887")

	self._equipHoleInfoView = Astral.LuaComponentContainer.Add(leftEquipShowGo, EquipHoleComponentNew)

	self._equipHoleInfoView:setHolePos(EquipUtil.EquipHolePos1New)
	self._equipHoleInfoView:setEquipModelPos(EquipUtil.EquipIntensifyModelPos)

	self._equipTransform = leftEquipShowGo.transform
	self._tabGo = self:getGo("left_tab_content_-399612422")
	self._tabComp = Astral.LuaComponentContainer.Add(self._tabGo, LeftTabComp)
	self._toggleTabControl = EquipIntensifyTabControl.New()

	self._toggleTabControl:setFun(self._dealLeftTabComp, self, self._checkCanTiming)

	for index = 1, 2 do
		self._tabComp:setActiveTabIndex(index)
		self._tabComp:setTabShow(index, true)
		self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(index))
	end
end

function M:destroyUI()
	self._equipHoleInfoView:OnDestroy()
end

function M:bindEvents()
	self._equipDetailComp:bindEvents()
end

function M:unbindEvents()
	self._equipDetailComp:unbindEvents()
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshEquipStatus, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_INFO_REFRESH, self._refreshEquipStatus, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_LV_UP_SUCESS, self._refreshEquipInfo, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_TIMGING_TUOWEI, self._checkEquipTmingAni, self)
	self._equipHoleInfoView:onEnter()
	self:onShow()
end

function M:onHide()
	return
end

function M:onStatusChange(nextUIStatus)
	return
end

function M:_dealLeftTabComp(tabIndex)
	local samePage = self._lastIndex and self._lastIndex == tabIndex
	local duration = samePage and 0 or 0.3

	duration = orgIndex and math.abs(orgIndex - tabIndex) <= 1 and 0.2 or duration

	self._tabComp:setCanvasGroupShow(false, 1, 0.2)
	self._tabComp:MoveSelectMark(tabIndex, duration)

	self._lastIndex = tabIndex

	if not samePage then
		if tabIndex == 1 then
			EquipIntensifyModel.instance:clearTimingHoleIndex()
			GlobalDispatcher:dispatchEvent(EventType.EQUIP_UI_STATUS_CHANGED, EquipEnum.MainUIStatus.LvUp, false)
		else
			EquipIntensifyModel.instance:setTimingHoleIndex(1)
			self._equipHoleInfoView:refreshHole()
			GlobalDispatcher:dispatchEvent(EventType.EQUIP_UI_STATUS_CHANGED, EquipEnum.MainUIStatus.Retiming, false)
		end
	end
end

function M:setPageIndex(tabIndex)
	self._toggleTabControl:selectTab(tabIndex, true)

	local samePage = self._lastIndex and self._lastIndex == tabIndex
	local duration = samePage and 0 or 0.3

	duration = orgIndex and math.abs(orgIndex - tabIndex) <= 1 and 0.2 or duration

	self._tabComp:setCanvasGroupShow(false, 1, 0.2)
	self._tabComp:MoveSelectMark(tabIndex, duration)

	self._lastIndex = tabIndex
end

function M:checkJumpToTimingView()
	return self._equipHoleInfoView:checkJumpToTimingView()
end

function M:onShow()
	self._equipMo = EquipIntensifyModel.instance:getOperatingEquip()

	self._equipDetailComp:setEquipData(self._equipMo)
	self._equipHoleInfoView:setEquipData(self._equipMo)
	self._tabComp:setLock(2, not self:_checkCanTiming(false), false, true)

	local qa = self._equipMo:getQuality()

	goutil.setActive(self._tabGo, qa > GameEnum.QualityEnum.B)
end

function M:clearHoleSelect()
	self._equipHoleInfoView:clearHoleSelect()
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshEquipStatus, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_INFO_REFRESH, self._refreshEquipStatus, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_LV_UP_SUCESS, self._refreshEquipInfo, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_TIMGING_TUOWEI, self._checkEquipTmingAni, self)
	self._equipHoleInfoView:onExit()
end

function M:_refreshEquipStatus()
	if self._viewPresentor:inUIStatus(EquipEnum.MainUIStatus.Timing) then
		return
	end

	self._equipDetailComp:refreshStatus()
end

function M:_refreshEquipInfo()
	if self._viewPresentor:inUIStatus(EquipEnum.MainUIStatus.Timing) then
		return
	end

	self._equipDetailComp:playeLvUpEffect()
	self._equipDetailComp:refreshView()
	self._equipHoleInfoView:refreshHole()
	self._equipHoleInfoView:playEquipLvAni()
	self._tabComp:setLock(2, not self:_checkCanTiming(false), false, true)
end

function M:_checkEquipTmingAni()
	self._equipMo = EquipIntensifyModel.instance:getOperatingEquip()

	self._equipDetailComp:setEquipData(self._equipMo)
	self._equipHoleInfoView:setEquipData(self._equipMo)
	self._equipHoleInfoView:playEquipTmingAni()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqijiediantiaojiao3, nil, nil, nil)
end

function M:setEquipModPos(pos)
	local y = self._equipTransform.localPosition.y

	RectTransformUtils.SetAnchoredPosition(self._equipTransform, pos, y)
end

function M:setBgPos(pos)
	return
end

function M:_checkCanTiming(showTisp)
	if not EquipIntensifyModel.instance:isD6Open() then
		if showTisp then
			ToolTipsMgr.showCharacterTopToast(lang("tip_equip_timing_not_open"), CommEnum.CharacterTopToastIcon.Fail, 1)
		end

		return false
	end

	if self._equipMo then
		local res = self._equipMo:getUnlockHoleCount() > 0

		if not res and showTisp then
			ToolTipsMgr.showCharacterTopToast(lang("tip_equip_timing_hole_lv_less"), CommEnum.CharacterTopToastIcon.Fail, 1)
		end

		return res
	end

	return false
end

return M
