-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/ActivitysignView.lua

module("logic.extensions.operationsignin.view.ActivitysignView", package.seeall)

local ActivitysignView = class("ActivitysignView", ViewComponent)
local actId1 = 49001
local actId2 = 49002

function ActivitysignView:ctor()
	ActivitysignView.super.ctor(self)
end

function ActivitysignView:buildUI()
	ActivitysignView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTop = self:getGo("item1/top")
	self.maskTop = self:getGo("item1/mark")
	self.txtMaskTop = self:getTxt("item1/mark/txt")
	self.btnDown = self:getGo("item2/top")
	self.maskDown = self:getGo("item2/mark")
	self.txtMaskDown = self:getTxt("item2/mark/txt")
	self.items1 = {}
	self.items2 = {}

	for i = 1, 3 do
		local con1 = self:getGo("item1/con" .. i)

		table.insert(self.items1, con1)

		local con2 = self:getGo("item2/con" .. i)

		table.insert(self.items2, con2)
	end
end

function ActivitysignView:bindEvents()
	ActivitysignView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTop, self.onClickTop, self)
	GameUtil.addClickHandler(self.btnDown, self.onClickDown, self)
end

function ActivitysignView:unbindEvents()
	ActivitysignView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTop)
	GameUtil.rmClickHandler(self.btnDown)
end

function ActivitysignView:destroyUI()
	ActivitysignView.super.destroyUI(self)
end

function ActivitysignView:onEnter()
	ActivitysignView.super.onEnter(self)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SignIn2, actId1)

	if GameUtil.getTimePeriodTypeBySec(startTime, endTime) == GameUtil.inTimePeriod then
		self:sendMsg(actId1)
	else
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SignIn2, actId2)

		if GameUtil.getTimePeriodTypeBySec(startTime, endTime) == GameUtil.inTimePeriod then
			self:sendMsg(actId2)
		end
	end

	self:refreshUI()
end

function ActivitysignView:onEnterFinished()
	ActivitysignView.super.onEnterFinished(self)
end

function ActivitysignView:onExit()
	ActivitysignView.super.onExit(self)
	self:removeAllEff()
end

function ActivitysignView:onExitFinished()
	ActivitysignView.super.onExitFinished(self)
end

function ActivitysignView:onClickTop()
	self:onGetPrize(actId1)
end

function ActivitysignView:onClickDown()
	self:onGetPrize(actId2)
end

function ActivitysignView:onGetPrize(activityId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SignIn2, activityId)
	local type = GameUtil.getTimePeriodTypeBySec(startTime, endTime)

	if type == GameUtil.beforeTimePeriod then
		TipsFacade.instance:openCommonTips(lang("活动还没开始"))

		return
	elseif type == GameUtil.afterTimePeriod then
		TipsFacade.instance:openCommonTips(lang("活动已经结束"))

		return
	elseif type == GameUtil.inTimePeriod then
		if not self.hasGainDays then
			do
				local hasGainDays = {}

				if table.keyof(hasGainDays, 1) then
					TipsFacade.instance:openCommonTips(lang("奖励已领取"))

					return
				end
			end

			local day = 1

			OperationCheckInAgent.instance:sendPM_OperationCheckInGainPrizeReq(activityId, day, function(msg)
				self.hasGainDays = self.hasGainDays or {}

				table.insert(self.hasGainDays, day)
				self:refreshUI()

				if checknumber(msg.changeSetId) > 0 then
					MaterialFacade.instance:popAndShowChangeSetItems(msg.changeSetId)
				end
			end)
		end
	end
end

function ActivitysignView:sendMsg(activityId)
	OperationCheckInAgent.instance:sendPM_OperationCheckInGetInfoReq(activityId, function(msg)
		self.hasGainDays = GameUtil.pbToTable(msg.hasGainPrizeDays) or {}

		self:refreshUI()
	end)
end

function ActivitysignView:initCellView(actId, items, mask, txtMask)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SignIn2, actId)
	local type = GameUtil.getTimePeriodTypeBySec(startTime, endTime)

	GameUtil.SetActive(mask, false)

	local hasEff = false

	if type == GameUtil.beforeTimePeriod then
		GameUtil.SetActive(mask, true)

		txtMask.text = lang("活动还没开始")
	elseif type == GameUtil.afterTimePeriod then
		GameUtil.SetActive(mask, true)

		txtMask.text = lang("活动已经结束")
	elseif type == GameUtil.inTimePeriod then
		if not self.hasGainDays then
			do
				local hasGainDays = {}

				if table.keyof(hasGainDays, 1) then
					GameUtil.SetActive(mask, true)

					txtMask.text = lang("奖励已领取")
				else
					hasEff = true
				end
			end

			local day = 1
			local cfg = OperationSignInConfig.instance:getSignInCfg(actId, day)

			if cfg == nil then
				return
			end

			self.effList = self.effList or {}

			local prizeList = string.split(cfg.reward, "#")

			for i = 1, #items do
				local con = items[i]

				GameUtil.SetActive(con, false)

				if prizeList and prizeList[i] then
					GameUtil.SetActive(con, true)

					local itemCell = goutil.findChild(con, "itemCell")
					local effGo = goutil.findChild(con, "eff")

					MaterialMgr.setCellByCfg(prizeList[i], itemCell)

					if hasEff then
						local effPath = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
						local temp = UIEffectManager.instance:playEffect(self, effPath, effGo, 0, 0, true, false, nil, function(target, eff)
							eff:setClipping(effGo:GetComponent(goutil.Type_RectTransform))
						end)

						temp:setParent(effGo.transform)
						temp:setLocalPos(0, 0, 0)
						temp:setScale(1)
						table.insert(self.effList, temp)
					end
				end
			end
		end
	end
end

function ActivitysignView:refreshUI()
	self:removeAllEff()
	self:initCellView(actId1, self.items1, self.maskTop, self.txtMaskTop)
	self:initCellView(actId2, self.items2, self.maskDown, self.txtMaskDown)
end

function ActivitysignView:removeAllEff()
	if self.effList then
		for i, eff in ipairs(self.effList) do
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self.effList = nil
end

return ActivitysignView
