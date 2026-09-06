-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/ActivityPopupBase.lua

module("logic.extensions.activitypopup.view.ActivityPopupBase", package.seeall)

local ActivityPopupBase = class("ActivityPopupBase", ViewComponent)

function ActivityPopupBase:getActivityPopupCfg()
	local param = self:getOpenParam()

	if param then
		local cfg = param[2]

		if cfg then
			return cfg
		end
	end

	local cfgs = ActivityPopupConfig.instance:getCfgs()

	for i, v in ipairs(cfgs) do
		if v.uiName == self._viewPresentor.viewName and ActivityPopupModel.instance:isMatchCondition(v) then
			return v
		end
	end

	return nil
end

function ActivityPopupBase:buildUI()
	self._btnClose = self:getBtn("btnClose")
	self._togTip = self:getToggle("togTip")
	self._timeBg = self:getGo("timeBg")
	self._txtTime = self:getTxt("timeBg/txtTime")
end

function ActivityPopupBase:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function ActivityPopupBase:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function ActivityPopupBase:onEnter()
	self._togTip.isOn = GameUtil.getUserDayData(ActivityPopupModel.instance:getSignString())

	self:_setTxtTime()
end

function ActivityPopupBase:_onClickClose()
	local isSendEvent = self:getFirstParam()

	GameUtil.saveUserDayData(ActivityPopupModel.instance:getSignString(), self._togTip.isOn)

	if isSendEvent then
		GlobalDispatcher:dispatch(GlobalNotify.ActivityPopupClickClose)
	else
		self:close()
	end
end

function ActivityPopupBase:_setTxtTime()
	if self._timeBg and self._txtTime then
		local cfg = self:getActivityPopupCfg()

		if cfg then
			goutil.setActive(self._timeBg.gameObject, true)

			self._txtTime.text = cfg.words
		else
			goutil.setActive(self._timeBg.gameObject, false)
		end
	end
end

return ActivityPopupBase
