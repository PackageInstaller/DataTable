-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/gm/HouseGMView.lua

module("logic.extensions.house.view.gm.HouseGMView", package.seeall)

local M = class("HouseGMView", ViewComponent)
local kNullStr = "无"

function M:buildUI()
	self._goGMRoot = self.mainGO
	self._btnReturn = self:getBtn("house_gm_view_-610330363")
	self._btnName = self:getBtn("house_gm_view_1583328968")
	self._txtName = self:getText("house_gm_view_-964619332")
	self._btnSchedule = self:getBtn("house_gm_view_-2103172115")
	self._txtSchedule = self:getText("house_gm_view_1786266903")
	self._btnBehavior = self:getBtn("house_gm_view_-1793885607")
	self._txtBehavior = self:getText("house_gm_view_-1614757921")
	self._btnPerform = self:getBtn("house_gm_view_-1632601950")
	self._txtOriginSchedule = self:getText("house_gm_view_1411084755")
	self._txtOriginBehavior = self:getText("house_gm_view_-1415006684")
	self._btnShelterInvalid = self:getBtn("house_gm_view_1754299775")
	self._btnTips = self:getBtn("house_gm_view_-85601477")
	self._refreshTimer = SchedulerCtrl.New(self._refreshOriginSchedule, self)
end

function M:destroyUI()
	self._refreshTimer:clear()

	self._refreshTimer = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnName:AddClickListener(self._onClickBtnName, self)
	self._btnSchedule:AddClickListener(self._onClickBtnSchedule, self)
	self._btnBehavior:AddClickListener(self._onClickBtnBehavior, self)
	self._btnPerform:AddClickListener(self._onClickBtnPerform, self)
	self._btnShelterInvalid:AddClickListener(self._onClickBtnShelterInvalid, self)
	self._btnTips:AddClickListener(self._onClickBtnTips, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnName:RemoveClickListener()
	self._btnSchedule:RemoveClickListener()
	self._btnBehavior:RemoveClickListener()
	self._btnPerform:RemoveClickListener()
	self._btnShelterInvalid:RemoveClickListener()
	self._btnTips:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.GM_VIEW_VISIBLE, self._refreshRootVisible, self)
		HouseDispatcher:addEventListener(HouseEventType.GM_CHANGE_FOCUS_HERO, self._onGmFocusHeroChange, self)
		HouseDispatcher:addEventListener(HouseEventType.END_HERO_CURR_BEHAVIOR, self._onUnitCurrBehaviorEnd, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.GM_VIEW_VISIBLE, self._refreshRootVisible, self)
		HouseDispatcher:removeEventListener(HouseEventType.GM_CHANGE_FOCUS_HERO, self._onGmFocusHeroChange, self)
		HouseDispatcher:removeEventListener(HouseEventType.END_HERO_CURR_BEHAVIOR, self._onUnitCurrBehaviorEnd, self)
	end
end

function M:onEnter()
	self:_refreshRootVisible()
	self:_refreshName()
	self:_refreshSchedule()
	self:_refreshBehavior()
	self:_refreshOriginBehavior()
	self:_setEvents(true)
end

function M:onExit()
	self._refreshTimer:stop()
	self:_setEvents(false)
	HouseGMController.instance:setGMToggle(false)
end

function M:_refreshRootVisible()
	local visible = HouseGMController.instance:showGMView()

	goutil.setActive(self._goGMRoot, visible)

	if not visible then
		self._refreshTimer:stop()
	end
end

function M:_refreshName()
	self._refreshTimer:stop()

	local textStr = "角色：%s"
	local nameStr = kNullStr
	local focusHero = HouseGMController.instance:getFocusHero()

	if focusHero then
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(focusHero)

		nameStr = heroMO:getName()

		self._refreshTimer:restart(30, true)
	end

	self._txtName.text = string.format(textStr, nameStr)

	self:_refreshOriginSchedule()
end

function M:_refreshSchedule()
	local textStr = "日程：%s"
	local scheduleStr = kNullStr
	local status = HouseGMController.instance:getFocusWorkStatus()

	if status then
		scheduleStr = HouseEnum.WorkStatus2Text[status]
	end

	self._txtSchedule.text = string.format(textStr, scheduleStr)
end

function M:_refreshBehavior()
	local textStr = string.format("行为：%s", kNullStr)
	local behavior = HouseGMController.instance:getFocusBehavior()

	if behavior then
		textStr = HouseEnum.BehaviorType2Text[behavior]
	end

	self._txtBehavior.text = textStr
end

function M:_refreshOriginSchedule()
	local status = HouseGMController.instance:getFocusHeroOriginWorkStatus()
	local txtStr = status == nil and "" or string.format("原日程：%s", HouseEnum.WorkStatus2Text[status])

	self._txtOriginSchedule.text = txtStr
end

function M:_refreshOriginBehavior()
	local focusHero = HouseGMController.instance:getFocusHero()
	local behavior = HouseGMController.instance:getCurrBehavior()
	local txtStr = ""

	if focusHero and behavior and HouseEnum.BehaviorType2Text[behavior] then
		local focusBehavior = HouseGMController.instance:getFocusBehavior()
		local strFormat = "当前行为：%s"

		if focusBehavior then
			strFormat = "原行为：%s"
		end

		txtStr = string.format(strFormat, HouseEnum.BehaviorType2Text[behavior])
	end

	self._txtOriginBehavior.text = txtStr
end

function M:_onGmFocusHeroChange()
	self:_refreshRootVisible()
	self:_refreshName()
	self:_refreshSchedule()
	self:_refreshBehavior()
	self:_refreshOriginBehavior()
end

function M:_onClickBtnName()
	HouseGMController.instance:openFocusHeroSelectedView()
end

function M:_checkFocusHero()
	local focusHero = HouseGMController.instance:getFocusHero()

	if not focusHero then
		FloatWordMgr.instance:show(lang("tip_select_role"))

		return false
	end

	return true
end

function M:_onClickBtnSchedule()
	if self:_checkFocusHero() then
		local luaTable = {}

		luaTable.confirmCallback = self._refreshSchedule
		luaTable.confirmTarget = self

		ViewMgr.instance:open(ViewName.HouseGmSchedule, luaTable)
	end
end

function M:_onClickBtnBehavior()
	if self:_checkFocusHero() then
		local luaTable = {}

		luaTable.confirmCallback = self._refreshBehavior
		luaTable.confirmTarget = self

		ViewMgr.instance:open(ViewName.HouseGmBehavior, luaTable)
	end
end

function M:_onClickBtnPerform()
	if self:_checkFocusHero() then
		HouseGMController.instance:performFocusHero()
	end
end

function M:_onClickBtnShelterInvalid()
	HouseDispatcher:dispatchEvent(HouseEventType.GM_SHELTER_ROOM_START_INVALID)
end

function M:_onClickBtnTips()
	local focusHero = HouseGMController.instance:getFocusHero()

	if focusHero then
		local heroUnit = HouseSceneUtil.getHousePlayerUnit(focusHero)

		HouseFacade.instance:openHeroTipsView(heroUnit)
	end
end

function M:_onClickReturn()
	HouseGMController.instance:setGMToggle(false)
end

function M:_onUnitCurrBehaviorEnd()
	self:_refreshOriginBehavior()
end

return M
