-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/healthexchange/view/HealthExchangeTipsView.lua

module("logic.extensions.healthexchange.view.HealthExchangeTipsView", package.seeall)

local M = class("HealthExchangeTipsView", ViewComponent)

M.PageType = {
	Drug = 1,
	Yt = 2
}
M.MoneyShowType = {
	[M.PageType.Drug] = CommEnum.MoneyShowType.OnlyEnergyWithOutAddBtn,
	[M.PageType.Yt] = CommEnum.MoneyShowType.HealthExchangeShowType
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnExit = self:getBtnByPath("universal_second_tips_common_bg/clickExit")
	self._btnCancel = self:getBtnByPath("content/btnCancel")
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "content/btnUse"), CommButton)
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:addToggleTab(self:getUIComponent("health_exchange_tips_-1960489915", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("health_exchange_tips_1931461881", UIComponentType.SpaceXToggle))

	self._subView = {
		[M.PageType.Drug] = Astral.SimpleLuaComponentContainer.Add(self.mainGO, HealthExchangeByDrugFragmentView),
		[M.PageType.Yt] = Astral.SimpleLuaComponentContainer.Add(self.mainGO, HealthExchangeByYtFragmentView)
	}
	self._goTimeTips = self:getGo("health_exchange_tips_-1928207778")
	self._txtTimeNext = self:getUIComponent("health_exchange_tips_-288908961", UIComponentType.Text)
	self._txtTimeMax = self:getUIComponent("health_exchange_tips_2102832641", UIComponentType.Text)
	self._btn_skill_bonusGo = goutil.findChild(self.mainGO, "content/panel/normal/btn_skill_bonus")
	self._btnSkillUp = UIComponentType.ButtonAdapter(goutil.findChild(self._btn_skill_bonusGo, "btnUp"))
	self._btnSkillDown = UIComponentType.ButtonAdapter(goutil.findChild(self._btn_skill_bonusGo, "btnDown"))

	goutil.setActive(self._btnSkillUp.gameObject, AchievementModel.instance:isGetSkill(CommEnum.CharacterSkillType.Type8))
	goutil.setActive(self._btnSkillDown.gameObject, false)
end

function M:destroyUI()
	self._btnExit = nil
	self._btnCancel = nil
	self._btnConfirm = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._subView = nil
end

function M:bindEvents()
	self._btnExit:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnSkillUp:AddClickListener(self._onOpenSkillSmallTips, self)
end

function M:unbindEvents()
	self._btnExit:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnSkillUp:RemoveClickListener()
end

function M:onEnter()
	self._isEnter = true

	self:setEvent(true)

	local defaultPageIndex = 1

	self._subView[M.PageType.Drug]:prepareData()

	local drugLst = self._subView[M.PageType.Drug]:getItemLst()
	local len = drugLst and #drugLst or 0

	if len == 0 then
		defaultPageIndex = 2
	end

	self._toggleTabControl:selectTab(defaultPageIndex)

	for _, item in pairs(self._viewPresentor:getMoneyView():getMoneyItemList() or {}) do
		item:changeBgColor("#0B1117")
	end
end

function M:onExit()
	self._isEnter = false

	self:setEvent(false)

	self._activeIndex = nil

	for _, view in pairs(self._subView or {}) do
		view:onExit()
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKSECOND, self._updateTimer, self)
	else
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKSECOND, self._updateTimer, self)
	end
end

function M:_updateTimer()
	if not self._isEnter then
		return
	end

	local leftTime, totalLeftTime = EnergyRecoverModel.instance:getEnergyRecoverTimeAll()
	local isMax = EnergyRecoverModel.instance:isEnergyMaxLimit()

	if leftTime >= 0 then
		self._txtTimeNext.text = TimeUtil.instance:second2TimeString(leftTime, true)
		self._txtTimeMax.text = TimeUtil.instance:second2TimeString(totalLeftTime, true)
	end

	goutil.setActive(self._goTimeTips, leftTime > 0 or not isMax)
end

function M:_formatTime(totalSecond)
	local hour = math.floor(totalSecond / 3600)
	local minute = math.floor((totalSecond - hour * 3600) / 60)
	local second = totalSecond % 60

	return string.format("02%d")
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	local index = self._activeIndex

	if index and index > 0 then
		local view = self._subView[index]

		if view then
			view:onClickConfirm()
		end
	end
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		for _index, view in pairs(self._subView or {}) do
			if _index == tabIndex then
				view:onEnter()
			else
				view:onExit()
			end
		end

		self:_updateMoneyView(tabIndex)
	end

	goutil.setActive(self._btn_skill_bonusGo, tabIndex == 1)
end

function M:_onOpenSkillSmallTips()
	local param = {}

	param.obj = self._btnSkillUp.transform.parent.gameObject
	param.skillType = CommEnum.CharacterSkillType.Type8

	ViewMgr.instance:open(ViewName.AchievementSkillSmallTips, param)
end

function M:_updateMoneyView(tabIndex)
	local moneyShowType = M.MoneyShowType[tabIndex] or CommEnum.MoneyShowType.DefaultHideType

	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, moneyShowType)
end

return M
