local CombineGamePoolView = class("CombineGamePoolView", ReduxView)
local var_0_1 = 2

function CombineGamePoolView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfEggUI"
end

function CombineGamePoolView:UIParent()
	return manager.ui.uiMain.transform
end

function CombineGamePoolView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGamePoolView:InitUI()
	self:BindCfgUI()

	self.poolRewardItem_ = {}
	self.poolRewardItem_[1] = KagutsuchiGachaRewardItem.New(self.rewardItem1Go_)
	self.poolRewardItem_[2] = KagutsuchiGachaRewardItem.New(self.rewardItem2Go_)
	self.poolRewardItem_[3] = KagutsuchiGachaRewardItem.New(self.rewardItem3Go_)
end

function CombineGamePoolView:AddUIListener()
	self:AddBtnListener(self.draw10Btn_, nil, function()
		self:TryStartDraw(self.bigDrawTimes)
	end)
	self:AddBtnListener(self.draw1Btn_, nil, function()
		self:TryStartDraw(1)
	end)
	self:AddBtnListener(self.poolBtn_, nil, function()
		JumpTools.GoToSystem("CombineGamePoolPopView", {
			activityId = ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL,
			poolId = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]
		})
	end)
end

function CombineGamePoolView:OnEnter()
	if not ActivityData:GetActivityIsOpen((CombineGameData:GetDataByPara("activityId"))) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	self:UpdateView()
	self:BindRedPoint()
end

function CombineGamePoolView:UpdateView()
	local var_10_0 = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]
	local var_10_1 = KagutsuchiGachaData:GetMaxDrawTimes(var_10_0)
	local var_10_2 = math.max(var_10_1, var_0_1)
	local var_10_3, var_10_4 = KagutsuchiGachaData:GetDrawCost(var_10_0, 1)
	local var_10_5, var_10_6 = KagutsuchiGachaData:GetDrawCost(var_10_0, var_10_2)
	local var_10_7, var_10_8 = KagutsuchiGachaData:GetDrawCost(var_10_0, 1)

	self.bigDrawText_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_POOL_TIPS"), var_10_2)
	self.drawCostText_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_POOL_TIPS"), 1)
	self.bigDrawCostText_.text = "<color=#" .. (var_10_1 < var_0_1 and "CC0013" or "F3E7C3") .. ">x" .. var_10_6 .. "</color>"
	self.drawText_.text = "<color=#" .. (var_10_1 == 0 and "CC0013" or "F3E7C3") .. ">x" .. var_10_8 .. "</color>"
	self.bigDrawTimes = var_10_2
	self.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_POOL_NAME")
	self.getText_.text = GetTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_FINISH")
	self.draw1Img_.sprite = ItemTools.getItemSprite(var_10_3)
	self.draw2Img_.sprite = ItemTools.getItemSprite(var_10_3)

	for iter_10_0, iter_10_1 in ipairs((KagutsuchiGachaData:GetDisplayDrawItemIds(var_10_0))) do
		self.poolRewardItem_[iter_10_0]:SetData(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL, var_10_0, iter_10_1)
	end
end

function CombineGamePoolView:TryStartDraw(arg_11_1)
	local var_11_0 = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]

	if KagutsuchiGachaData:GetPoolRemains(var_11_0) == 0 then
		ShowTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_FINISH")

		return
	end

	if KagutsuchiGachaData:GetMaxDrawTimes(var_11_0) < arg_11_1 then
		ShowTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_COST_NOT_ENOUGH")

		return
	end

	KagutsuchiGachaAction:StartDraw(arg_11_1, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL, var_11_0, handler(self, self.OnFinishDraw))
end

function CombineGamePoolView:OnFinishDraw(arg_12_1, arg_12_2)
	self:UpdateView()

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.reward_list) do
		local var_12_1, var_12_2 = KagutsuchiGachaData:GetDrawItemReward(arg_12_1.pool_id, iter_12_1)

		table.insert(var_12_0, {
			id = var_12_1,
			num = var_12_2
		})
	end

	getReward(var_12_0)
end

function CombineGamePoolView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.draw1Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "ONE", {
		x = 150,
		y = 35
	})
	manager.redPoint:bindUIandKey(self.draw10Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "TEN", {
		x = 150,
		y = 35
	})
end

function CombineGamePoolView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.draw10Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "TEN")
	manager.redPoint:unbindUIandKey(self.draw1Btn_.transform, RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "ONE")
end

function CombineGamePoolView:OnExit()
	for iter_15_0, iter_15_1 in ipairs(self.poolRewardItem_) do
		self.poolRewardItem_[iter_15_0]:OnExit()
	end

	self:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function CombineGamePoolView:OnTop()
	local var_16_0, var_16_1 = KagutsuchiGachaData:GetDrawCost(KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1], 1)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_16_0
	})
	manager.windowBar:SetBarCanAdd(var_16_0, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_COMBINE_GAME_DRAW_POOL_DESC")
end

function CombineGamePoolView:Dispose()
	for iter_17_0, iter_17_1 in ipairs(self.poolRewardItem_) do
		self.poolRewardItem_[iter_17_0]:Dispose()
	end

	CombineGamePoolView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGamePoolView
