-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityfuyaosummaryView.lua

module("logic.extensions.operationsummary.view.ActivityfuyaosummaryView", package.seeall)

local ActivityfuyaosummaryView = class("ActivityfuyaosummaryView", ActivitySmallSummaryThreeView)

ActivityfuyaosummaryView.redKey = "RedKeyLease"

function ActivityfuyaosummaryView:buildUI()
	ActivityfuyaosummaryView.super.buildUI(self)

	self._txtDesc = self:getTxt("btnLease/imgTip/txtDesc")
	self._btnLease = self:getBtn("btnLease")
	self._redpointGo = self:getGo("btnLease/redpoint")
	self._imgTipGo = self:getGo("btnLease/imgTip")
	self._customInput = UICustomInput.Get(self._imgTipGo)
	self._txtDesc.text = ""

	goutil.setActive(self._imgTipGo, false)
end

function ActivityfuyaosummaryView:bindEvents()
	ActivityfuyaosummaryView.super.bindEvents(self)
	self._btnLease:AddClickListener(self._onClickbtnLease, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function ActivityfuyaosummaryView:unbindEvents()
	ActivityfuyaosummaryView.super.unbindEvents(self)
	self._btnLease:RemoveClickListener()
	self._customInput:RemoveListener()
end

function ActivityfuyaosummaryView:onEnter()
	ActivityfuyaosummaryView.super.onEnter(self)

	if not self.activityId or self.activityId <= 0 then
		return
	end

	self._timeTipsOpen = false
	self._leaseActivityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.BIRTHDAY_SPORTS_WISHES)

	GlobalDispatcher:addListener(GlobalNotify.BirthdaySportsWishInfoUpdate, self._onBirthdaySportsWishInfoUpdate, self)
	BirthdaySportsWishesAgent.instance:sendPM_BirthdaySportsWishesGetInfoReq(self._leaseActivityId)
	self:_setLeaseRed()
end

function ActivityfuyaosummaryView:onExit()
	ActivityfuyaosummaryView.super.onExit(self)
	removetimer(self._setLeaseTime, self)

	self._targetTime = nil

	GlobalDispatcher:removeListener(GlobalNotify.BirthdaySportsWishInfoUpdate, self._onBirthdaySportsWishInfoUpdate, self)
end

function ActivityfuyaosummaryView:_onClickbtnLease()
	local gainTime = BirthdaySportsWishModel.instance:getGainedTimes()
	local cfg = BirthdaySportsWishConfig.instance:getBuffCfgsByActId(self._leaseActivityId)

	if cfg and gainTime >= cfg.hireLimit then
		FloatWordMgr.instance:show("租借次数用尽，无法租借噢")

		return
	end

	if not self._targetTime then
		return
	end

	if self._targetTime - ServerTime.now() <= 0 then
		BirthdaySportsWishesAgent.instance:sendPM_BirthdaySportsWishesHirePetReq(self._leaseActivityId)
	else
		self._timeTipsOpen = true

		self:_updateLease()
		FloatWordMgr.instance:show("租借冷却未结束，无法租借噢")
	end

	GameUtil.saveUserData(ActivityfuyaosummaryView.redKey, true)
	self:_setLeaseRed()
end

function ActivityfuyaosummaryView:_onBirthdaySportsWishInfoUpdate(hirePet)
	local time = BirthdaySportsWishModel.instance:getCurCoolingTime()

	time = math.ceil(checknumber(time) / 1000) - 1
	self._targetTime = time + ServerTime.now()
	self._clientAddCoolTime = 0

	self:_updateLease(hirePet)
end

function ActivityfuyaosummaryView:_updateLease(hirePet)
	if not self._targetTime then
		return
	end

	local time = self._targetTime - ServerTime.now()

	if self._timeTipsOpen or hirePet and not self._timeTipsOpen and time > 0 then
		self._timeTipsOpen = true

		removetimer(self._setLeaseTime, self)

		if time > 0 then
			settimer(1, self._setLeaseTime, self, true)
		end

		self:_setLeaseTime()
		self:_checkHide()
	else
		goutil.setActive(self._imgTipGo, false)
	end
end

function ActivityfuyaosummaryView:_setLeaseTime()
	local leftTime = self._targetTime - ServerTime.now()
	local cfg = BirthdaySportsWishConfig.instance:getBuffCfgsByActId(self._leaseActivityId)

	if not cfg then
		printError("没有租借配置")

		return
	end

	if leftTime <= 0 then
		self:_checkHide()
	else
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(leftTime)

		self._txtDesc.text = day > 0 and string.format("活动期间可租借<color=red>%s</color>次，每次租借后需等待<color=red>%s</color>天后才可继续租借，距离下次租借时间：<color=red>%s天</color>", cfg.hireLimit, cfg.hireCD, day) or string.format("活动期间可租借<color=red>%s</color>次，每次租借后需等待<color=red>%s</color>天后才可继续租借，距离下次租借时间：<color=red>%02d:%02d:%02d</color>", cfg.hireLimit, cfg.hireCD, hour, min, sec)

		goutil.setActive(self._imgTipGo, true)
	end
end

function ActivityfuyaosummaryView:_checkHide()
	local gainTime = BirthdaySportsWishModel.instance:getGainedTimes()
	local leftTime = self._targetTime - ServerTime.now()

	if gainTime <= 0 or leftTime <= 0 then
		removetimer(self._setLeaseTime, self)

		self._txtDesc.text = ""

		goutil.setActive(self._imgTipGo, false)
	end
end

function ActivityfuyaosummaryView:_setLeaseRed()
	local red = GameUtil.getUserData(ActivityfuyaosummaryView.redKey)

	goutil.setActive(self._redpointGo, not red)
end

function ActivityfuyaosummaryView:_onCustomInputCallback(hover)
	self._timeTipsOpen = false

	goutil.setActive(self._imgTipGo, false)
	removetimer(self._setLeaseTime, self)
end

return ActivityfuyaosummaryView
