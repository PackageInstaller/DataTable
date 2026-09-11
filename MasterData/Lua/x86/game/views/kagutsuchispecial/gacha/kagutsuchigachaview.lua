local WindowCurrencyItem = import("manager.windowBar.WindowCurrencyItem")
local KagutsuchiGachaView = class("KagutsuchiGachaView", ReduxView)

function KagutsuchiGachaView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionKagutsuchiJackpotUI"
end

function KagutsuchiGachaView:UIParent()
	return manager.ui.uiMain.transform
end

function KagutsuchiGachaView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.drawController_ = ControllerUtil.GetController(self.transform_, "draw")
	self.bigDrawController_ = ControllerUtil.GetController(self.transform_, "bigDraw")
	self.poolRewardItem_ = {}
	self.poolRewardItem_[1] = KagutsuchiGachaRewardItem.New(self.rewardItem1Go_)
	self.poolRewardItem_[2] = KagutsuchiGachaRewardItem.New(self.rewardItem2Go_)
	self.poolRewardItem_[3] = KagutsuchiGachaRewardItem.New(self.rewardItem3Go_)

	local var_3_0 = WindowCurrencyItem.New(self.token2Go_, CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)

	var_3_0:SetActive(true)
	var_3_0:SetCanAdd(false)
	var_3_0:SetCanClick(true)

	self.token2_ = var_3_0
end

function KagutsuchiGachaView:OnEnter()
	self:InitBar()

	self.isAniPlaying_ = false

	self:RefreshUI()
	self:AddTimer()

	local var_4_0 = ActivityTools.GetRedPointKey(ActivityConst.KAGUTSUCHI_ACTIVITY) .. ActivityConst.KAGUTSUCHI_ACTIVITY

	manager.redPoint:bindUIandKey(self.oneDrawBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_ONE, var_4_0)))
	manager.redPoint:bindUIandKey(self.bigDrawBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_MULTI, var_4_0)))
	KagutsuchiWorkAction:UpdateRedPoint(ActivityConst.KAGUTSUCHI_ACTIVITY)
end

function KagutsuchiGachaView:InitBar()
	return
end

function KagutsuchiGachaView:OnExit()
	for iter_6_0, iter_6_1 in ipairs(self.poolRewardItem_) do
		self.poolRewardItem_[iter_6_0]:OnExit()
	end

	AnimatorTools.Stop()
	self:StopTimer()

	local var_6_0 = ActivityTools.GetRedPointKey(ActivityConst.KAGUTSUCHI_ACTIVITY) .. ActivityConst.KAGUTSUCHI_ACTIVITY

	manager.redPoint:unbindUIandKey(self.oneDrawBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_ONE, var_6_0)))
	manager.redPoint:unbindUIandKey(self.bigDrawBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA_MULTI, var_6_0)))
end

function KagutsuchiGachaView:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.poolRewardItem_) do
		self.poolRewardItem_[iter_7_0]:Dispose()
	end

	self.token2_:Dispose()
	KagutsuchiGachaView.super.Dispose(self)
end

function KagutsuchiGachaView:AddListeners()
	self:AddBtnListener(self.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("kagutsuchiGachaPreview", {
			activityId = self:GetActivityID(),
			poolId = self:GetPoolId()
		})
	end)
	self:AddBtnListener(self.oneDrawBtn_, nil, function()
		self:TryStartDraw(1)
	end)
	self:AddBtnListener(self.bigDrawBtn_, nil, function()
		self:TryStartDraw(self.bigDrawTimes)
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		if self.isAniPlaying_ then
			return
		end

		JumpTools.Back()
	end)
	self:AddBtnListener(self.homeBtn_, nil, function()
		if self.isAniPlaying_ then
			return
		end

		gameContext:Go("/home", nil, nil, true)
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		local var_14_0

		if self.isAniPlaying_ then
			do return end

			var_14_0 = {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips("ACTIVITY_KAGUTSUCHI_REWARD_DESCRIBE")
			}
		end

		var_14_0.key = "ACTIVITY_KAGUTSUCHI_REWARD_DESCRIBE"

		JumpTools.OpenPageByJump("gameHelp", var_14_0)
	end)
end

function KagutsuchiGachaView:RefreshUI()
	local var_15_0 = self:GetPoolId()
	local var_15_1 = KagutsuchiGachaData:GetMaxDrawTimes(var_15_0)
	local var_15_2 = math.max(var_15_1, 2)
	local var_15_3 = KagutsuchiGachaData:GetPoolRemains(var_15_0)

	if var_15_3 == 0 then
		self.drawController_:SetSelectedState("empty")
	elseif var_15_3 == 1 then
		self.bigDrawController_:SetSelectedState("lack")
	end

	local var_15_4, var_15_5 = KagutsuchiGachaData:GetDrawCost(var_15_0, var_15_2)

	self.bigDrawText_.text = var_15_2
	self.bigDrawCostText_.text = var_15_1 < 2 and "x<color=#CC0013>" .. var_15_5 .. "</color>" or "x" .. var_15_5

	local var_15_6, var_15_7 = KagutsuchiGachaData:GetDrawCost(var_15_0, 1)

	self.oneDrawText_.text = 1
	self.oneDrawCostText_.text = var_15_1 == 0 and "x<color=#CC0013>" .. var_15_7 .. "</color>" or "x" .. var_15_7
	self.bigDrawTimes = var_15_2

	self:RefreshPoolDisplayItems(var_15_0)

	self.coinText_.text = KagutsuchiWorkData:GetCoins()

	local var_15_8 = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)

	self.coinImage_.sprite = var_15_8
	self.oneDrawImage_.sprite = var_15_8
	self.bigDrawImage_.sprite = var_15_8
end

function KagutsuchiGachaView:RefreshPoolDisplayItems(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs((KagutsuchiGachaData:GetDisplayDrawItemIds(arg_16_1))) do
		self.poolRewardItem_[iter_16_0] = self.poolRewardItem_[iter_16_0] or KagutsuchiGachaRewardItem.New((Object.Instantiate(self.templateItem_, self.poolRewardContent_)))

		self.poolRewardItem_[iter_16_0]:SetData(self:GetActivityID(), arg_16_1, iter_16_1)
	end
end

function KagutsuchiGachaView:RefreshTimeUI()
	self.timeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData((self:GetActivityID())).stopTime, nil)
end

function KagutsuchiGachaView:AddTimer()
	self:StopTimer()
	self:RefreshTimeUI()

	self.timer_ = Timer.New(function()
		self:RefreshTimeUI()
	end, 1, -1)

	self.timer_:Start()
end

function KagutsuchiGachaView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function KagutsuchiGachaView:TryStartDraw(arg_21_1)
	if self.isAniPlaying_ then
		return
	end

	local var_21_0 = self:GetPoolId()
	local var_21_1, var_21_2 = KagutsuchiGachaData:GetDrawCost(var_21_0, arg_21_1)

	if KagutsuchiGachaData:GetMaxDrawTimes(var_21_0) < arg_21_1 then
		ShowTips("ACTIVITY_KAGUTSUCHI_POLL_COST_NOTE_ENOUGH")

		return
	end

	KagutsuchiGachaAction:StartDraw(arg_21_1, self:GetActivityID(), var_21_0, handler(self, self.OnFinishDraw))
end

function KagutsuchiGachaView:OnFinishDraw(arg_22_1, arg_22_2)
	self:PlayEffects(function()
		self:RefreshUI()

		local var_23_0 = {}

		for iter_23_0, iter_23_1 in ipairs(arg_22_1.reward_list) do
			local var_23_1, var_23_2 = KagutsuchiGachaData:GetDrawItemReward(arg_22_1.pool_id, iter_23_1)

			table.insert(var_23_0, {
				id = var_23_1,
				num = var_23_2
			})
		end

		getReward(var_23_0)
		KagutsuchiWorkAction:UpdateRedPoint(ActivityConst.KAGUTSUCHI_ACTIVITY)
	end)
end

function KagutsuchiGachaView:GetActivityID()
	return ActivityConst.KAGUTSUCHI_ACTIVITY_REWARD
end

function KagutsuchiGachaView:GetPoolId()
	return KagutsuchiGachaData:GetPoolIds(self:GetActivityID())[1]
end

function KagutsuchiGachaView:PlayEffects(arg_26_1)
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_toy", "")

	self.isAniPlaying_ = true

	self.gachaDrawAni_:Play("JapanRegionKagutsuchiJackpotUI_roll", -1, 0)
	self.gachaDrawAni_:Update(0)
	AnimatorTools.PlayAnimationWithCallback(self.gachaDrawAni_, "JapanRegionKagutsuchiJackpotUI_roll", function()
		self.isAniPlaying_ = false

		arg_26_1()
	end)
end

return KagutsuchiGachaView
