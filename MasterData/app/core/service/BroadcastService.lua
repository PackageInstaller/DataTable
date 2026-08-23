local var_0_0 = fgui
local var_0_1 = display
local var_0_2 = json.decode
local var_0_3 = g.core.const.ConstMgr.PARAMETER_CONST
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local BroadcastService = class("BroadcastService")

function BroadcastService:ctor()
	self:_resetData()

	self._firstDelay = 10
	self._compGmTip = nil
	self._showLabel = nil
	self._isShowBtnCtr = nil
	self._moveRate = 0.01
	self._cdTime = g.core.config.parameter_info.get(var_0_3.GM_TIP_CD).parameter

	self:_registerEvents()
end

function BroadcastService:_resetData()
	self._init = false
	self._isFirstIn = true
	self._firstInTime = 0
	self._curShowList = {}
	self._gmDataList = {}
	self._curShowId = 0
	self._hasShowList = {}
	self._isGmShowing = false
end

function BroadcastService:_registerEvents()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_LAUNCH, self._onGameLaunch, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ON_PRE_LOADING_FINISH, self._onGameLoadFinsh, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_LOGOUT_ACCOUNT, self._onGameLogout, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNOUNCE_INFO, self._onRecvGmBroadcast, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANNOUNCE_FLUSH, self._onRecvGmBroadcast, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NOTIFY_USER_VIEW_DETAIL, self._onRecvViewPlayer, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NOTICE, self._onRecvNoticeTips, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_HOME_GUIDE_CHECK, self._onRecvNoticeTips, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_HOMELAYER_UNLOAD, self._onHideNoticeTips, self)
end

function BroadcastService:_onGameLaunch()
	self:_initGMBroadCastWidget()
	self:_initViewPlayerWidget()
	self:_initNoticeTipsWidget()
end

function BroadcastService:_initGMBroadCastWidget()
	local var_5_0 = var_0_0.GComponent:create()
	local var_5_1 = var_0_0.UIPackage:createObject("base_new", "TxtGmBroadcast")

	g.core.layer.LayerManager:getSysTipLayer():addChild(var_5_0)
	var_5_0:addChild(var_5_1)
	var_5_1:setOpaque(false)
	var_5_1:setVisible(false)
	var_5_1:setPosition(cc.p(var_0_1.width / 2, 105))

	self._showComp = var_5_0
	self._compGmTip = var_5_1
	self._showLabel = var_5_1:getChild("label")
	self._isShowBtnCtr = var_5_1:getController("showBtn")

	self._showLabel:getChild("title"):disableAutoChange()
	var_5_1:getChild("closeBtn"):addClickListener(handler(self, self._onCloseGmTip))

	self._init = true

	self:_createSchedule()
end

function BroadcastService:_initViewPlayerWidget()
	self._viewPlayerComp = var_0_0.UIPackage:createObject("base_new", "TxtViewPlayerComp")

	self._viewPlayerComp:setOpaque(false)
	self._viewPlayerComp:setVisible(false)
	self._viewPlayerComp:setPosition(cc.p(var_0_1.width / 2, 190))
	self._showComp:addChild(self._viewPlayerComp)
end

function BroadcastService:_initNoticeTipsWidget()
	self._noticeTipsComp = var_0_0.UIPackage:createObject("base_new", "TxtNoticeComp")

	self._noticeTipsComp:setOpaque(false)
	self._noticeTipsComp:setVisible(false)
	self._noticeTipsComp:setPosition(cc.p(var_0_1.width / 2, 135))
	self._noticeTipsComp:getChild("touchLoader"):addClickListener(handler(self, self._onNoticeTipsClick))

	self._noticeTipsCompText = self._noticeTipsComp:getChild("title")

	self._noticeTipsCompText:enableRich()
	self._showComp:addChild(self._noticeTipsComp)
end

function BroadcastService:_onCloseGmTip()
	if self._curShowId ~= 0 then
		self:_updateGmShowTime()

		self._curShowId = 0

		self:_startGmShowText()
	end
end

function BroadcastService:_onGameLoadFinsh()
	self._firstInTime = g.core.common.ServerTime:getTime()

	self:_createSchedule()
end

function BroadcastService:_createSchedule()
	if not self._init or self._firstInTime == 0 then
		return
	end

	local var_10_0 = g.core.common.Scheduler

	if self._schedule then
		var_10_0:cancelSchedule(self._schedule)

		self._schedule = nil
	end

	local var_10_1 = self:_getNextScheduleTime()

	if var_10_1 < 0 then
		return
	elseif var_10_1 == 0 and self._isFirstIn and self._firstDelay > 0 then
		local var_10_2 = g.core.common.ServerTime:getTime() - self._firstInTime

		if var_10_2 > self._firstDelay then
			self._firstDelay = 0
		else
			var_10_1 = self._firstDelay - var_10_2
		end
	end

	if var_10_1 == 0 then
		self:_scheduleUpdate()
	else
		self._schedule = var_10_0:newScheduleOnce(handler(self, self._scheduleUpdate), var_10_1)
	end
end

function BroadcastService:_scheduleUpdate()
	self._isFirstIn = false

	self:showGmNotice()
end

function BroadcastService:_onRecvGmBroadcast(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.announces then
		for iter_12_0, iter_12_1 in ipairs(arg_12_3.announces) do
			if iter_12_1.frequent == 0 or not iter_12_1.announcement or iter_12_1.announcement == "" then
				self:_removeGmById(iter_12_1.id)
			else
				self:_pushGmNotice(iter_12_1)
			end
		end

		self:_sortGmNotice()
		self:_createSchedule()
	end
end

function BroadcastService:_pushGmNotice(arg_13_1)
	local var_13_0 = {
		id = arg_13_1.id,
		beginTime = arg_13_1.begin,
		endTime = arg_13_1["end"],
		frequent = arg_13_1.frequent,
		notice = arg_13_1.announcement
	}

	var_13_0.notice = var_0_2(var_13_0.notice)

	if var_13_0.notice then
		local var_13_1 = false

		for iter_13_0, iter_13_1 in ipairs(self._gmDataList) do
			if iter_13_1.id == var_13_0.id then
				self._gmDataList[iter_13_0] = var_13_0
				var_13_1 = true

				break
			end
		end

		if var_13_1 == false then
			table.insert(self._gmDataList, var_13_0)
		end
	end
end

function BroadcastService:_sortGmNotice()
	table.sort(self._gmDataList, function(arg_15_0, arg_15_1)
		if arg_15_0.beginTime ~= arg_15_1.beginTime then
			return arg_15_0.beginTime < arg_15_1.beginTime
		end

		return arg_15_0.id > arg_15_1.id
	end)
end

function BroadcastService:_getGmNoticeDataById(arg_16_1)
	if not arg_16_1 then
		return nil
	end

	for iter_16_0, iter_16_1 in ipairs(self._gmDataList) do
		if iter_16_1.id == arg_16_1 then
			return iter_16_1
		end
	end

	return nil
end

function BroadcastService:_removeGmById(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(self._gmDataList) do
		if iter_17_1.id == arg_17_1 then
			table.remove(self._gmDataList, iter_17_0)

			break
		end
	end
end

function BroadcastService:_gmIsActive(arg_18_1)
	if not arg_18_1 then
		return false
	end

	local var_18_0 = g.core.common.ServerTime:getTime()

	return var_18_0 >= arg_18_1.beginTime and var_18_0 < arg_18_1.endTime
end

function BroadcastService:_isExpire(arg_19_1)
	if not arg_19_1 then
		return true
	end

	return arg_19_1.frequent == 0 or arg_19_1.endTime <= g.core.common.ServerTime:getTime()
end

function BroadcastService:_getNextScheduleTime()
	local var_20_0 = -1
	local var_20_1 = g.core.common.ServerTime:getTime()

	local function var_20_2(arg_21_0, arg_21_1)
		arg_21_1 = arg_21_1 == -1 and arg_21_0 or math.min(arg_21_0, arg_21_1)

		return arg_21_1
	end

	for iter_20_0, iter_20_1 in ipairs(self._gmDataList) do
		if not self:_isExpire(iter_20_1) then
			if self:_gmIsActive(iter_20_1) then
				var_20_0 = not iter_20_1.nextShowTime and 0 or var_20_2(math.max(iter_20_1.nextShowTime - var_20_1, 0), var_20_0)

				if var_20_0 == 0 then
					break
				end
			else
				var_20_0 = var_20_2(iter_20_1.beginTime - var_20_1, var_20_0)
			end
		end
	end

	return var_20_0
end

function BroadcastService:showGmNotice()
	self:_updateShowList()
	self:_startGmShowText()
end

function BroadcastService:_updateShowList()
	local var_23_0 = g.core.common.ServerTime:getTime()
	local var_23_1 = {}
	local var_23_2 = self._curShowList

	for iter_23_0, iter_23_1 in ipairs(self._curShowList) do
		var_23_1[iter_23_1] = true
	end

	for iter_23_2 = #self._gmDataList, 1, -1 do
		if self:_isExpire(self._gmDataList[iter_23_2]) then
			table.remove(self._gmDataList, iter_23_2)
		end
	end

	for iter_23_3, iter_23_4 in ipairs(self._gmDataList) do
		local var_23_3 = iter_23_4.id
		local var_23_4 = false

		if self._curShowId == 0 then
			var_23_4 = false
		elseif self._curShowId == var_23_3 then
			var_23_4 = true
		end

		if not var_23_4 and not var_23_1[var_23_3] and self:_gmIsActive(iter_23_4) then
			if not iter_23_4.nextShowTime or var_23_0 - iter_23_4.nextShowTime >= 0 then
				var_23_1[var_23_3] = true

				table.insert(var_23_2, var_23_3)
			end
		end
	end
end

function BroadcastService:_updateGmShowTime()
	if self._curShowId == 0 then
		return
	end

	local var_24_0 = self:_getGmNoticeDataById(self._curShowId)

	if var_24_0 and next(var_24_0) then
		var_24_0.nextShowTime = var_24_0.nextShowTime or var_24_0.beginTime + math.ceil((g.core.common.ServerTime:getTime() - var_24_0.beginTime) / var_24_0.frequent) * var_24_0.frequent
		var_24_0.nextShowTime = var_24_0.nextShowTime + math.ceil(self._cdTime / var_24_0.frequent) * var_24_0.frequent
	end
end

function BroadcastService:_startGmShowText()
	if self._curShowId ~= 0 then
		return
	end

	local var_25_0 = self._curShowList[1]
	local var_25_1 = self:_getGmNoticeDataById(self._curShowList[1])

	self._curShowId = self._curShowList[1] or 0

	table.remove(self._curShowList, 1)

	if var_25_1 then
		local var_25_2 = var_25_1.notice[tostring((MultilingualMgr:getLangIdByDesc((MultilingualMgr:getUseLang()))))]

		if var_25_2 then
			self._compGmTip:setVisible(true)
			self:_onHideNoticeTips()

			local var_25_3 = self._showLabel:getChild("title")

			var_25_3:stopAllFGActions()

			self._isGmShowing = true

			self._isShowBtnCtr:setSelectedIndex(self._hasShowList[var_25_0] and 1 or 0)
			var_25_3:setText(var_25_2)

			local var_25_4 = self._showLabel:getWidth()
			local var_25_5 = var_25_3:getWidth()

			if var_25_4 < var_25_5 then
				var_25_3:setPivot(0, 0.5, true)
				var_25_3:setPosition(var_25_4, 15)
				var_25_3:runFGAction((var_0_0.FRepeatForever:create(var_0_0.FSequence:create({
					var_0_0.FMoveTo:create((var_25_5 + var_25_4) * self._moveRate, cc.p(-var_25_5, 15)),
					var_0_0.FCallFunc:create(handler(self, function()
						self:_resetTip()
					end))
				}))))
			else
				var_25_3:setPivot(0.5, 0.5, true)
				var_25_3:setPosition(var_25_4 / 2, 15)
				g.core.common.Scheduler:newScheduleOnce(handler(self, function()
					self._hasShowList[self._curShowId] = true

					self._isShowBtnCtr:setSelectedIndex(1)
				end), 2)
			end
		else
			self:_removeGmById(self._curShowId)

			self._curShowId = 0

			self:_endGmShow()
		end
	else
		self:_endGmShow()
	end
end

function BroadcastService:_resetTip()
	if self._curShowId ~= 0 and not self._hasShowList[self._curShowId] then
		self._hasShowList[self._curShowId] = true

		self._isShowBtnCtr:setSelectedIndex(1)
	end

	self._showLabel:getChild("title"):setPosition(self._showLabel:getWidth(), 15)
end

function BroadcastService:_endGmShow()
	self._compGmTip:setVisible(false)

	self._isGmShowing = false

	if #self._curShowList > 0 then
		self:_startGmShowText()
	else
		self:_createSchedule()
	end
end

function BroadcastService:_onGameLogout()
	self._compGmTip:setVisible(false)

	if self._schedule then
		g.core.common.Scheduler:cancelSchedule(self._schedule)

		self._schedule = nil
	end

	self:_resetData()
end

function BroadcastService:_onRecvViewPlayer()
	local var_31_0 = g.core.module.ModuleManager:getCurModule()

	if var_31_0 and var_31_0.module == g.view.entrance.HOME then
		self._viewPlayerComp:setVisible(true)
		self._viewPlayerComp:getTransition("in"):play(handler(self, self._onPlayViewPlayerIn))
	end
end

function BroadcastService:_onPlayViewPlayerIn()
	g.core.common.Scheduler:newScheduleOnce(handler(self, function(arg_33_0)
		arg_33_0._viewPlayerComp:getTransition("out"):play(handler(arg_33_0, arg_33_0._onPlayViewPlayerOut))
	end), 2)
end

function BroadcastService:_onPlayViewPlayerOut()
	self._viewPlayerComp:setVisible(false)
end

function BroadcastService:_onNoticeTipsClick()
	if g.core.guide.GuideProxy:isGuideRunning() or g.core.battle.BattleProxy:isInBattle() or g.core.model.User.storyData:isInStory() or g.core.utils.Tools.checkSilentFull() ~= 0 then
		return
	end

	if self._noticeData and self._noticeData.uid and self._noticeData.uid > 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			uid = self._noticeData.uid
		})
	elseif self._noticeData and self._noticeData.cfgId then
		local var_35_0 = g.core.config.notice_info.get(self._noticeData.cfgId)

		if var_35_0.jump and var_35_0.jump > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(var_35_0.jump)
		end
	end
end

function BroadcastService:_onRecvNoticeTips()
	local var_36_0 = g.core.module.ModuleManager:getCurModule()
	local var_36_1 = g.core.module.ModuleManager:getFirstFullModule()

	if (not var_36_0 or var_36_0.module ~= g.view.entrance.HOME) and (not var_36_1 or var_36_1.module ~= g.view.entrance.HOME) or self._isShowNoticeTips or self._isHideHomeLayerUI then
		return
	end

	self._noticeData = g.core.model.User.chatData:getTopNoticeTip()

	if self._noticeData then
		self._isShowNoticeTips = true

		self._noticeTipsCompText:setText(self._noticeData.content, false, true)
		self._noticeTipsCompText:setPosition(550, 15)

		self._noticeTipsCompTextWidth = self._noticeTipsCompText:getWidth()

		self._noticeTipsComp:setVisible(not self._compGmTip:isVisible())

		if self._noticeTipsComp:isVisible() then
			self:_onPlayNoticeTipsIn()
		else
			self._noticeTipsComp:getTransition("in"):play(handler(self, self._onPlayNoticeTipsIn))
		end
	else
		self._noticeTipsComp:getTransition("out"):play(handler(self, self._onPlayNoticeTipsOut))
	end
end

function BroadcastService:_onPlayNoticeTipsIn()
	self._noticeTipsCompText:runFGAction(var_0_0.FMoveTo:create(8, cc.p(-self._noticeTipsCompTextWidth, 15)))
	g.core.common.Scheduler:newScheduleOnce(handler(self, function(arg_38_0)
		arg_38_0._isShowNoticeTips = false

		arg_38_0:_onRecvNoticeTips()
	end), 8)
end

function BroadcastService:_onPlayNoticeTipsOut()
	if not self._isShowNoticeTips then
		self:_onHideNoticeTips()
	end
end

function BroadcastService:_onHideNoticeTips()
	self._noticeTipsComp:setVisible(false)
end

function BroadcastService:setHideHomeLayerUI(arg_41_1)
	if arg_41_1 then
		self:_onHideNoticeTips()
	end

	self._isHideHomeLayerUI = arg_41_1
end

return BroadcastService
