local MainActivityBtnView = class("MainActivityBtnView", import("...base.MainBaseView"))

function MainActivityBtnView:Ctor(arg_1_1, arg_1_2)
	MainActivityBtnView.super.Ctor(self, arg_1_1, arg_1_2)

	self.initPos = nil
	self.isInit = nil
	self.actBtnTpl = arg_1_1:Find("actBtn")
	self.linkBtnTopFoldableHelper = MainFoldableHelper.New(self._tf.parent:Find("link_top"), Vector2(0, 1))
	self.checkNotchRatio = NotchAdapt.CheckNotchRatio

	self:InitBtns()
	self:Register()

	return
end

function MainActivityBtnView.GetActivityBtnList()
	return {
		MainActSummaryBtn,
		MainCoreActivityBtn,
		MainActEscortBtn,
		MainActMapBtn,
		MainActBossBtn,
		MainActBackHillBtn,
		MainActAtelierBtn,
		MainLanternFestivalBtn,
		MainActBossRushBtn,
		MainActAprilFoolBtn,
		MainActMedalCollectionBtn,
		MainActSenranBtn,
		MainActBossSingleBtn,
		MainActLayerBtn,
		MainActDreamlandBtn,
		MainActBoatAdBtn,
		MainActBlackFridaySalesBtn,
		MainActToLoveBtn,
		MainActHolidayVillaBtn,
		MainCoreActivityBtn2
	}
end

function MainActivityBtnView.GetSpecailBtns()
	return {
		MainActInsBtn,
		MainActTraingCampBtn,
		MainActRefluxBtn,
		MainActNewServerBtn,
		MainActDelegationBtn,
		MainIslandActDelegationBtn,
		MainVoteEntranceBtn,
		MainActCompensatBtn
	}
end

function MainActivityBtnView:InitBtns()
	self.activityBtns = {}

	for iter_4_0, iter_4_1 in ipairs(MainActivityBtnView.GetActivityBtnList()) do
		if iter_4_0 == 1 then
			table.insert(self.activityBtns, iter_4_1.New(self.actBtnTpl, self.event, true))
		elseif iter_4_0 == 2 then
			table.insert(self.activityBtns, iter_4_1.New(self.actBtnTpl, self.event, false))
		else
			table.insert(self.activityBtns, iter_4_1.New(self.actBtnTpl, self.event))
		end
	end

	self.specailBtns = {}

	for iter_4_2, iter_4_3 in ipairs(MainActivityBtnView.GetSpecailBtns()) do
		table.insert(self.specailBtns, iter_4_3.New(self._tf, self.event))
	end

	if pg.SdkMgr.GetInstance():CheckAudit() then
		self.specailBtns = {
			MainActTraingCampBtn.New(self._tf, self.event)
		}
	end

	return
end

function MainActivityBtnView:Register()
	self:bind(GAME.REMOVE_LAYERS, function(arg_6_0, arg_6_1)
		self:OnRemoveLayer(arg_6_1.context)

		return
	end)
	self:bind(GAME.REQ_NEW_INSTAGRAM_DATA_DONE, function(arg_7_0)
		self:OnInstagramDataUpdate()

		return
	end)
	self:bind(MiniGameProxy.ON_HUB_DATA_UPDATE, function(arg_8_0)
		self:Refresh()

		return
	end)
	self:bind(GAME.SEND_MINI_GAME_OP_DONE, function(arg_9_0)
		self:Refresh()

		return
	end)
	self:bind(GAME.GET_FEAST_DATA_DONE, function(arg_10_0)
		self:Refresh()

		return
	end)
	self:bind(GAME.FETCH_VOTE_INFO_DONE, function(arg_11_0)
		self:Refresh()

		return
	end)
	self:bind(GAME.ZERO_HOUR_OP_DONE, function(arg_12_0)
		self:Refresh()

		return
	end)
	self:bind(CompensateProxy.UPDATE_ATTACHMENT_COUNT, function(arg_13_0)
		self:Refresh()

		return
	end)
	self:bind(CompensateProxy.All_Compensate_Remove, function(arg_14_0)
		self:Refresh()

		return
	end)

	return
end

function MainActivityBtnView:GetBtn(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(self.activityBtns) do
		if isa(iter_15_1, arg_15_1) then
			return iter_15_1
		end
	end

	for iter_15_2, iter_15_3 in ipairs(self.specailBtns) do
		if isa(iter_15_3, arg_15_1) then
			return iter_15_3
		end
	end

	return nil
end

function MainActivityBtnView:OnRemoveLayer(arg_16_1)
	local var_16_0

	if arg_16_1.mediator == LotteryMediator then
		var_16_0 = self:GetBtn(MainActLotteryBtn)
	elseif arg_16_1.mediator == InstagramMainMediator then
		var_16_0 = self:GetBtn(MainActInsBtn)
	end

	if var_16_0 and var_16_0:InShowTime() then
		var_16_0:OnInit()
	end

	return
end

function MainActivityBtnView:OnInstagramDataUpdate()
	local var_17_0 = self:GetBtn(MainActInsBtn)

	if var_17_0 and var_17_0:InShowTime() then
		var_17_0:OnInit()
	end

	return
end

function MainActivityBtnView:Init()
	self:Flush()

	self.isInit = true

	return
end

function MainActivityBtnView:FilterActivityBtns()
	local var_19_0 = {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(self.activityBtns) do
		if iter_19_1:InShowTime() then
			table.insert(var_19_0, iter_19_1)
		else
			table.insert(var_19_1, iter_19_1)
		end
	end

	table.sort(var_19_0, CompareFuncs({
		function(arg_20_0)
			return arg_20_0.config.group_id
		end
	}))

	return var_19_0, var_19_1
end

function MainActivityBtnView:FilterSpActivityBtns()
	local var_21_0 = {}
	local var_21_1 = {}

	for iter_21_0, iter_21_1 in ipairs(self.specailBtns) do
		if iter_21_1:InShowTime() then
			table.insert(var_21_0, iter_21_1)
		else
			table.insert(var_21_1, iter_21_1)
		end
	end

	return var_21_0, var_21_1
end

function MainActivityBtnView:Flush()
	if self.checkNotchRatio ~= NotchAdapt.CheckNotchRatio then
		self.checkNotchRatio = NotchAdapt.CheckNotchRatio
		self.initPos = nil
	end

	local var_22_0, var_22_1 = self:FilterActivityBtns()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		iter_22_1:Init(iter_22_0)
	end

	for iter_22_2, iter_22_3 in ipairs(var_22_1) do
		iter_22_3:Clear()
	end

	local var_22_2 = #var_22_0
	local var_22_3 = #var_22_0 <= 3
	local var_22_4 = #var_22_0 <= 3 and 390 or 420

	self._tf.localScale = Vector3(#var_22_0 <= 3 and 1 or 0.85, #var_22_0 <= 3 and 1 or 0.85, 1)
	self.initPos = self.initPos or self._tf.localPosition

	onNextTick(function()
		if not IsNil(self._tf) then
			self._tf.localPosition = Vector3(self.initPos.x, var_22_4, 0)
		end

		return
	end)

	local var_22_5, var_22_6 = self:FilterSpActivityBtns()

	for iter_22_4, iter_22_5 in pairs(var_22_5) do
		iter_22_5:Init(not var_22_3, var_22_2 >= 5)
	end

	for iter_22_6, iter_22_7 in pairs(var_22_6) do
		iter_22_7:Clear()
	end

	return
end

function MainActivityBtnView:Refresh()
	if not self.isInit then
		return
	end

	self:Flush()

	for iter_24_0, iter_24_1 in ipairs(self.specailBtns) do
		if iter_24_1:InShowTime() then
			iter_24_1:Refresh()
		end
	end

	return
end

function MainActivityBtnView:Disable()
	for iter_25_0, iter_25_1 in ipairs(self.specailBtns) do
		if iter_25_1:InShowTime() then
			iter_25_1:Disable()
		end
	end

	return
end

function MainActivityBtnView:Dispose()
	MainActivityBtnView.super.Dispose(self)
	self.linkBtnTopFoldableHelper:Dispose()

	for iter_26_0, iter_26_1 in ipairs(self.activityBtns) do
		iter_26_1:Dispose()
	end

	for iter_26_2, iter_26_3 in ipairs(self.specailBtns) do
		iter_26_3:Dispose()
	end

	self.specailBtns = nil
	self.activityBtns = nil

	return
end

function MainActivityBtnView:Fold(arg_27_1, arg_27_2)
	MainActivityBtnView.super.Fold(self, arg_27_1, arg_27_2)
	self.linkBtnTopFoldableHelper:Fold(arg_27_1, arg_27_2)

	return
end

function MainActivityBtnView:GetDirection()
	return Vector2(1, 0)
end

return MainActivityBtnView
