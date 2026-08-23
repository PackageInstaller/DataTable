local NewSlgSettleComp = class("NewSlgSettleComp")

function NewSlgSettleComp:ctor()
	self._txtAllianceName = self:getChild("Txt_allianceName")
	self._txtTime = self:getChild("Txt_time")
	self._txtLv = self:getChild("Txt_lv")
	self._txtName = self:getChild("Txt_name")
	self._compAllianceLeaderName = self:getChild("Comp_allianceLeaderName")
	self._compPlace = self:getChild("Comp_place")
	self._rankData = nil
	self._compEffect = self:getChild("Comp_effect")

	self:setVisible(false)
end

function NewSlgSettleComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETRANK, handler(self, self._getFinalRank), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self._updateView), self)
	self:_updateSch()
	self:_updateView()
end

function NewSlgSettleComp:_getFinalRank(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_4.id == 4 then
		local var_3_0 = arg_3_4.rank_units or {}

		if var_3_0[1] then
			self._rankData = var_3_0[1]

			self:_updateView()
		end
	end
end

function NewSlgSettleComp:_updateSch()
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgSettleComp_updateTime",
		startTime = g.core.model.User.newSlgData:getSettleStartTime(),
		endTime = g.core.model.User.newSlgData:getActEndTime()
	})
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgSettleComp_updateView",
		isOnce = true,
		startTime = g.core.model.User.newSlgData:getSettleStartTime(),
		endTime = g.core.model.User.newSlgData:getActEndTime()
	})
end

function NewSlgSettleComp:_onSchedule(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = self:isVisible()

	if arg_5_3.key == "NewSlgSettleComp_updateTime" then
		if not self:isVisible() then
			self:setVisible(true)
		end

		self:_updateView()
		self:updateTime()

		if g.core.common.ServerTime:getTime() >= arg_5_3.endTime then
			self:setVisible(false)
		end
	elseif arg_5_3.key == "NewSlgSettleComp_updateView" then
		if not self._rankData then
			if g.core.model.User.newSlgData:getSName() == "S1" then
				g.core.network.GameNetProxy:send_C2S_NewSlg_GetRank({
					id = 4,
					limit = 1
				})
			end
		else
			self:_updateView()
		end

		if not var_5_0 then
			self:getTransition("enter"):play()
		end
	end
end

function NewSlgSettleComp:_updateView()
	if not g.core.model.User.newSlgData:isSettle() then
		self:setVisible(false)

		return
	end

	if self._sprite then
		self._sprite:removeFromParent()

		self._sprite = nil
	end

	local var_6_0 = g.core.model.User.newSlgData:getLastCityInfo()
	local var_6_1 = g.core.model.User.newSlgData:getCityComponentById(var_6_0.id)

	self._sprite = display.newSprite("#" .. g.core.common.Path:getNewSlgBuilding(var_6_1.res_1))

	self._sprite:setScale(var_6_1.scale / 10000)
	self._sprite:setAnchorPoint(0.5, 0.5)
	self._compPlace:addNode(self._sprite)

	if not self._rankData then
		self:setCtrlState("isAttacked", {
			index = 1
		})

		return
	else
		self:setCtrlState("isAttacked", {
			index = 0
		})
	end

	local var_6_2 = self._rankData

	self:setVisible(true)
	self._txtName:setText(var_6_0.name)
	self._txtLv:setText(g.core.lang:get(429006, {
		level = var_6_0.level
	}))

	local var_6_3 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, g.core.common.GlobalFunc.rankUnit_param(var_6_2.param, "NewSlgAlliRankData", true).id)

	if var_6_3 then
		self._txtAllianceName:setText(var_6_3.name)
		self._compAllianceLeaderName:setText(var_6_3.leader_name)
	end
end

function NewSlgSettleComp:updateTime()
	self._txtTime:setText((g.core.common.ServerTime:secondToHMSString(g.core.model.User.newSlgData:getActEndTime() - g.core.common.ServerTime:getTime())))
end

return NewSlgSettleComp
