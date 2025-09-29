-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingUnlockConditionTipsView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingUnlockConditionTipsView", package.seeall)

local M = class("FacilityHoldingUnlockConditionTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._imgIcon = self:getImage("facility_holding_unlock_condition_tips_-1023145298")
	self._txtName = self:getText("facility_holding_unlock_condition_tips_-1347143355")
	self.goDescRootLst = {}

	table.insert(self.goDescRootLst, self:getGo("facility_holding_unlock_condition_tips_-111511054").gameObject)
	table.insert(self.goDescRootLst, self:getGo("facility_holding_unlock_condition_tips_-296374774").gameObject)

	self._txtDescLst = {}

	table.insert(self._txtDescLst, self:getText("facility_holding_unlock_condition_tips_-222214105"))
	table.insert(self._txtDescLst, self:getText("facility_holding_unlock_condition_tips_-106671803"))

	self._btnCancel = self:getBtn("facility_holding_unlock_condition_tips_1930321694")
	self._btnEnsure = self:getBtn("facility_holding_unlock_condition_tips_1053026067")
	self._btnClose = self:getBtn("facility_holding_unlock_condition_tips_-743499375")
end

function M:destroyUI()
	self._imgIcon = nil
	self._txtName = nil
	self.goDescRootLst = nil
	self._txtDescLst = nil
	self._btnCancel = nil
	self._btnEnsure = nil
	self._btnClose = nil
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnEnsure:AddClickListener(self._onClickEnsure, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnEnsure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	local info = self:getFirstParam()

	self:updateShow(info.protomerId)
end

function M:onExit()
	return
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickEnsure()
	self:close()
end

function M:_onClickClose()
	self:close()
end

function M:updateShow(protomerId)
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)

	self._txtName.text = protomerInfoMo and protomerInfoMo:getProtomerName() or ""

	ContainmentUtil.setProtomerDynIcon(self._imgIcon, protomerId, true)

	local desc = {}
	local cfgProtomerInfo = ContainmentConfig.instance:getProtomerInfoById(protomerId)

	if cfgProtomerInfo then
		for index, value in ipairs(cfgProtomerInfo.unlockdesc or {}) do
			table.insert(desc, value)
		end
	end

	for index, value in ipairs(self.goDescRootLst) do
		if desc[index] then
			self._txtDescLst[index].text = desc[index]
		end

		goutil.setActive(value, desc[index] ~= nil)
	end
end

return M
