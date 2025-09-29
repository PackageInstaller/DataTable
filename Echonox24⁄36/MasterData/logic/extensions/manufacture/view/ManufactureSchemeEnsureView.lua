-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureSchemeEnsureView.lua

module("logic.extensions.manufacture.view.ManufactureSchemeEnsureView", package.seeall)

local M = class("ManufactureSchemeEnsureView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._isReplace = false
	self._isSame = false
	self._countDownTimer = nil
end

function M:buildUI()
	local itemParent = self:getGo("facility_yield_hint_tips_-349809428")
	local itemGO = goutil.findChild(itemParent, "facility_yield_plan_item")

	self._schemeItem = Astral.LuaComponentContainer.Add(itemGO, ManufactureSchemeItem)
	self._txtCostTime = self:getText("facility_yield_hint_tips_-1026250192")
	self._btnClose = self:getBtn("1&small_tips_common_bg_1276053964")
	self._btnCancel = self:getBtn("facility_yield_hint_tips_-1086675504")
	self._btnConfirm = self:getBtn("facility_yield_hint_tips_-2115470035")
	self._btnReplace = self:getBtn("facility_yield_hint_tips_2014930914")
	self._goConfirm = self:getGo("facility_yield_hint_tips_-2115470035")
	self._goReplace = self:getGo("facility_yield_hint_tips_2014930914")
	self._textHint = goutil.findChildTextComponent(self.mainGO, "allContent/txtContent/layout/txtHint4")
	self._goApplyTips = goutil.findChild(self.mainGO, "allContent/txtContent/txtHint3")
	self._goSameTips = goutil.findChild(self.mainGO, "allContent/txtContent/txtHint5")
	self._goLimitTips = goutil.findChild(self.mainGO, "allContent/txtContent/txtHint6")
end

function M:destroyUI()
	self._isReplace = false
	self._isSame = false

	if self._isSame then
		self._countDownTimer:clear()

		self._countDownTimer = nil
	end
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnCancel:AddClickListener(self._onClickBtnCancel, self)
	self._btnConfirm:AddClickListener(self._onClickBtnConfirm, self)
	self._btnReplace:AddClickListener(self._onClickBtnReplace, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnReplace:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_INFO_REPLY, self._onManufactureInfoReply, self)
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_INFO_REPLY, self._onManufactureInfoReply, self)
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
	end
end

function M:onEnter()
	local params = self:getOpenParam()

	self._schemeCO = params[1]
	self._plantMO = params[2]

	self._schemeItem:updateData(self._schemeCO, self._plantMO)

	self._isReplace = self:_isReplaceScheme()
	self._isSame = self:_isSameScheme()

	self:refreshViews()
	self:_setEvents(true)
	self:_startCountDownTimer()
end

function M:onExit()
	self:_setEvents(false)
	self:_stopCountDownTimer()
end

function M:_startCountDownTimer()
	if self._isSame then
		if self._countDownTimer == nil then
			self._countDownTimer = SchedulerCtrl.New(self._refreshSchemeCountDown, self)
		end

		self._countDownTimer:restart(1, true)
	end
end

function M:_stopCountDownTimer()
	if self._countDownTimer then
		self._countDownTimer:stop()
	end
end

function M:_refreshSchemeCountDown()
	self:_refreshCostTime()
end

function M:_refreshCostTime()
	if self._isSame then
		local remainTime = -1

		remainTime = self._plantMO:getNextProductTimeStamp() - ServerTime.now()

		if remainTime < 0 then
			self._txtCostTime.text = ""
		else
			self._txtCostTime.text = TimeUtil.instance:numberToTime(remainTime, "h:m:s")
		end
	else
		self._txtCostTime.text = self._schemeItem:getCostTimeStr()
	end
end

function M:refreshViews()
	self:_refreshCostTime()

	local schemeCount = ManufactureModel.instance:getProducingSchemeCount(self._schemeCO.id)
	local isNumLimited = ManufactureConfig.instance:isSchemeMaxLimit(self._schemeCO.id, schemeCount)

	self._textHint.text = self._isSame and lang("tip_plant_end_time_hint") or lang("tip_plant_single_time_hint")

	self._goConfirm:SetActive(not self._isReplace)
	self._goReplace:SetActive(self._isReplace)
	self._goApplyTips:SetActive(not self._isSame and not isNumLimited)
	self._goSameTips:SetActive(self._isSame)
	self._goLimitTips:SetActive(not self._isSame and isNumLimited)
end

function M:_isReplaceScheme()
	return self._plantMO:getSchemeId() > 0 and not self:_isSameScheme()
end

function M:_isSameScheme()
	return self._plantMO:getSchemeId() == self._schemeCO.id
end

function M:_onClickBtnConfirm()
	if not self._isSame then
		ManufactureAgent.instance:sendChangeManufactureSchemaRequest(self._plantMO:getPlantId(), self._schemeCO.id)
	end

	self:close()
end

function M:_onClickBtnReplace()
	ManufactureAgent.instance:sendChangeManufactureSchemaRequest(self._plantMO:getPlantId(), self._schemeCO.id)
	self:close()
end

function M:_onClickBtnCancel()
	self:close()
end

function M:_onClickBtnClose()
	self:close()
end

function M:_onManufactureInfoReply()
	self:refreshViews()
end

function M:_onManufactureInfoChange()
	self:refreshViews()
end

return M
