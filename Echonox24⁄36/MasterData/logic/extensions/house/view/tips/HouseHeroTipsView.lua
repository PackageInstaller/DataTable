-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/tips/HouseHeroTipsView.lua

module("logic.extensions.house.view.tips.HouseHeroTipsView", package.seeall)

local M = class("HouseHeroTipsView", ViewComponent)
local WorkStatus = HouseEnum.WorkStatus
local kRequestInterval = 600

function M:ctor()
	self._heroId = 0
	self._dictEffectItem = nil
end

function M:buildUI()
	self._txtName = self:getText("room_small_role_tips_-810060663")
	self._txtMoodValue = self:getText("room_small_role_tips_-168935565")
	self._txtMoodSpeedDesc = self:getText("room_small_role_tips_2086159584")
	self._txtMoodSpeedValue = self:getText("room_small_role_tips_2066992955")
	self._goMoodSpeedDown = self:getGo("room_small_role_tips_840302282")
	self._goMoodSpeedUp = self:getGo("room_small_role_tips_495714867")
	self._goEffectRoot = self:getGo("room_small_role_tips_-446073636")
	self._goEffectItem = self:getGo("room_small_role_tips_1941430242")
	self._btnDetail = self:getBtn("room_small_role_tips_1556163421")
	self._goStatusWork = goutil.findChild(self.mainGO, "layout/content1/status1")
	self._goStatusRest = goutil.findChild(self.mainGO, "layout/content1/status2")
	self._goStatusSleep = goutil.findChild(self.mainGO, "layout/content1/status3")
	self._goStatusEat = goutil.findChild(self.mainGO, "layout/content1/status4")
	self._dictEffectItem = {}

	goutil.setActive(self._goMoodSpeedDown, false)
	goutil.setActive(self._goMoodSpeedUp, false)

	self._requestTimer = SchedulerCtrl.New(self._requestHeroFeatureAgent, self)
end

function M:destroyUI()
	self._dictEffectItem = nil

	self._requestTimer:clear()

	self._requestTimer = nil
end

function M:bindEvents()
	self._btnDetail:AddClickListener(self._onClickBtnDetail, self)
end

function M:unbindEvents()
	self._btnDetail:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		self._requestTimer:restart(kRequestInterval, true)
		HouseDispatcher:addEventListener(HouseEventType.REPLY_GET_SINGLE_HERO_FEATURE, self._onReplyGetSingleHeroFeature, self)
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
		GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self._onChangeHouseWorkerSucceed, self)
	else
		self._requestTimer:stop()
		HouseDispatcher:removeEventListener(HouseEventType.REPLY_GET_SINGLE_HERO_FEATURE, self._onReplyGetSingleHeroFeature, self)
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
		GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self._onChangeHouseWorkerSucceed, self)
	end
end

function M:onEnter()
	self._heroUnit = self:getFirstParam()
	self._heroId = self._heroUnit.heroId

	self:_clearEffectItems()
	self:refreshView()
	self:_requestHeroFeatureAgent()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)

	if self._heroUnit then
		self._heroUnit.progressBar:clear()
	end

	self:_clearEffectItems()

	self._heroUnit = nil
	self._heroId = 0
end

function M:refreshView()
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._heroId)
	local featureMO = HeroHouseFeatureModel.instance:getFeatureMO(self._heroId)

	if heroMO and featureMO then
		self._txtName.text = heroMO:getName()

		local status = HouseSceneUtil.getWorkStatusByHeroId(self._heroId)

		goutil.setActive(self._goStatusWork, status == WorkStatus.Work)
		goutil.setActive(self._goStatusRest, status == WorkStatus.Rest)
		goutil.setActive(self._goStatusSleep, status == WorkStatus.Sleep)
		goutil.setActive(self._goStatusEat, status == WorkStatus.Eat)

		local maxMood = HouseConfig.instance:getHouseConst("MoodMax").numValue
		local currMood = math.floor(featureMO:getMood())

		self._txtMoodValue.text = string.format("%s/%s", currMood, maxMood)

		local isCost = featureMO:isMoodCostStatus(status)
		local descriptionStr = isCost and lang("tip_house_hero_tips_1") or lang("tip_house_hero_tips_2")

		self._txtMoodSpeedDesc.text = descriptionStr

		local moodSpeed = isCost and featureMO:getMoodCost() or featureMO:getMoodRecover()

		moodSpeed = MathUtil.preciseDecimal(moodSpeed * 60, 1)
		self._txtMoodSpeedValue.text = moodSpeed

		self:_refreshEffects(featureMO)
	end
end

function M:_refreshEffects(featureMO)
	for _, item in pairs(self._dictEffectItem) do
		item:setVisible(false)
	end

	local skillInfos = featureMO:getSkills()
	local buffInfos = featureMO:getBuffs()

	for idx, skillInfo in ipairs(skillInfos) do
		local item = self:_getOrCreateItem(idx)

		item:setData(skillInfo)
	end

	for idx, buffInfo in ipairs(buffInfos) do
		local item = self:_getOrCreateItem(idx + #skillInfos)

		item:setData(buffInfo)
	end

	goutil.setActive(self._goEffectRoot, #skillInfos > 0 or #buffInfos > 0)
end

function M:_getOrCreateItem(idx)
	local item = self._dictEffectItem[idx]

	if not item then
		local itemGO = goutil.clone(self._goEffectItem)

		item = Astral.LuaComponentContainer.Add(itemGO, HouseHeroTipsEffectItem)

		goutil.addChildToParent(itemGO, self._goEffectRoot)

		self._dictEffectItem[idx] = item
	end

	return item
end

function M:_clearEffectItems()
	for _, item in pairs(self._dictEffectItem) do
		goutil.destroy(item:getMainGO())
	end

	table.clear(self._dictEffectItem)
end

function M:_requestHeroFeatureAgent()
	if self._heroId > 0 then
		HouseAgent.instance:sendGetSingleHeroFeatureRequest(self._heroId)
	end
end

function M:_onClickBtnDetail()
	ViewMgr.instance:open(ViewName.HouseHeroMoodRecord, self._heroId)
end

function M:_onReplyGetSingleHeroFeature(e, heroId)
	if self._heroId == heroId then
		self:refreshView()
	end
end

function M:_onChangeHouseWorkerSucceed()
	self:refreshView()
end

function M:_onTickHour()
	self:_requestHeroFeatureAgent()
end

return M
