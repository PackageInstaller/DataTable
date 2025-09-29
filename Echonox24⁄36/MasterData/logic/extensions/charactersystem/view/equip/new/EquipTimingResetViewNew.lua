-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/new/EquipTimingResetViewNew.lua

module("logic.extensions.charactersystem.view.equip.new.EquipTimingResetViewNew", package.seeall)

local M = class("EquipTimingResetViewNew", ViewComponent)

function M:buildUI()
	local attributePanelGo = self:getGo("3&attriubte_d6_right_tips_copy_-1908349022")

	self._attrPanelView = Astral.LuaComponentContainer.Add(attributePanelGo, D6AttrRetimingComponentNew)
	self._txtTimingTimes = self:getText("equip_function_view_copy_670675399")
	self._btnTimingTips = self:getBtn("equip_function_view_copy_1824192740")
end

function M:destroyUI()
	self._attrPanelView:OnDestroy()
end

function M:bindEvents()
	self._btnTimingTips:AddClickListener(self._onClickTips, self)
	self._attrPanelView:bindEvents()
end

function M:unbindEvents()
	self._btnTimingTips:RemoveClickListener()
	self._attrPanelView:unbindEvents()
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.EQUIP_RETIMING_RESULT, self._showEquipTimingResultView, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_TIMGING_TUOWEI, self.onShow, self)
end

function M:onHide()
	return
end

function M:onShow()
	self._equipMo = EquipIntensifyModel.instance:getOperatingEquip()

	local holeIndex = EquipIntensifyModel.instance:getTimingHoleIndex()
	local equipHoleAttrMo = EquipIntensifyModel.instance:genEquipHoleAttrMo(self._equipMo, holeIndex)

	if equipHoleAttrMo.status == EquipEnum.HoleStatus.NoCalibration then
		local part = self._equipMo:getPart()

		EquipIntensifyModel.instance:setTimingD6Part(part)
		self._attrPanelView:showFirstTiming(true)
		self:_refreshRetimingTimes()
	elseif equipHoleAttrMo.status == EquipEnum.HoleStatus.Unlock then
		local d6Mo = self._equipMo:getFixedD6ByHoleIndex(holeIndex)

		self._attrPanelView:showFirstTiming(false)
		self._attrPanelView:setData(d6Mo)
		self:_refreshRetimingTimes()
	end
end

function M:onExit()
	self._attrPanelView:onExit()
	GlobalDispatcher:removeEventListener(EventType.EQUIP_RETIMING_RESULT, self._showEquipTimingResultView, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_TIMGING_TUOWEI, self.onShow, self)
end

function M:_showEquipTimingResultView()
	local equipMo = EquipIntensifyModel.instance:getOperatingEquip()
	local holeIndex = EquipIntensifyModel.instance:getTimingHoleIndex()
	local fixedD6Mo = equipMo:getFixedD6ByHoleIndex(holeIndex)

	ViewMgr.instance:open(ViewName.EquipTimingAnimation, fixedD6Mo)
end

function M:_onClickTips()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.GuideID.EquipTimingReset
	})
end

function M:_onSelectHoleChanged()
	local holeIndex = EquipIntensifyModel.instance:getTimingHoleIndex()
	local d6Mo = self._equipMo:getFixedD6ByHoleIndex(holeIndex)

	self._attrPanelView:setData(d6Mo)
	self:_refreshRetimingTimes()
end

function M:_refreshRetimingTimes()
	local maxTimes = EquipIntensifyModel.instance:getMaxTimingTimes()
	local usedTimes = self._equipMo:getThrowTimes()

	self._txtTimingTimes.text = string.format(lang("tip_timing_times"), usedTimes, maxTimes)
end

return M
