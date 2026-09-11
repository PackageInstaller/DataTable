local DodgeBarrageEnterView = class("DodgeBarrageEnterView", ActivityMainBasePanel)

function DodgeBarrageEnterView:GetUIName()
	return "Widget/Version/ShashwatUI_3_7/ShashwatUI_3_7_BarrageUI/ShashwatUI_3_7_Barrage01UI"
end

function DodgeBarrageEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DodgeBarrageEnterView:InitUI()
	self:BindCfgUI()

	self.rewardList_ = LuaList.New(handler(self, self.IndexItem), self.rewardListGo_, CommonItemView)
end

function DodgeBarrageEnterView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("dodgeBarrageMainView")
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		local var_6_0 = {
			content = GetTips("ACTIVITY_DODGE_BARRAGE_DESC")
		}

		var_6_0.key = "ACTIVITY_DODGE_BARRAGE_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_6_0)
	end)
end

function DodgeBarrageEnterView:OnEnter()
	self.redPointKey_ = DodgeBarrageData:GetRedPointKey()

	manager.redPoint:bindUIandKey(self.goBtn_.transform, self.redPointKey_)
	self:UpdateView()
end

function DodgeBarrageEnterView:UpdateView()
	self.rewrdScroll_.horizontalNormalizedPosition = 0
	self.activityId_ = DodgeBarrageData:GetActivityId()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	self.remainTime = 0
	self.remainTime = ActivityData:GetActivityData(self.activityId_).stopTime
	self.remainTxt_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.remainTime)
	self.updateTimer_ = Timer.New(function()
		self.remainTxt_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.remainTime)
	end, 1, self.remainTime - manager.time:GetServerTime() + 1, 1)

	self.updateTimer_:Start()

	self.describeTxt_.text = GetTips("DODGE_BARRAGE_ENTER_DESCRIBE")

	self:RefreshMainReward()
end

function DodgeBarrageEnterView:RefreshMainReward()
	self.showRewards_ = {}

	for iter_10_0, iter_10_1 in ipairs((DodgeBarrageData:GetTaskList())) do
		for iter_10_2, iter_10_3 in ipairs(AssignmentCfg[iter_10_1.id].reward) do
			if ItemCfg[iter_10_3[1]].rare >= 5 and not table.indexof(self.showRewards_, iter_10_3[1]) then
				table.insert(self.showRewards_, iter_10_3[1])
			end
		end
	end

	table.sort(self.showRewards_, function(arg_11_0, arg_11_1)
		return arg_11_0 < arg_11_1
	end)
	self.rewardList_:StartScroll(#self.showRewards_)
end

function DodgeBarrageEnterView:IndexItem(arg_12_1, arg_12_2)
	local var_12_0 = clone(ItemTemplateData)

	var_12_0.id = self.showRewards_[arg_12_1]
	var_12_0.hideBottomRightTextFlag = true

	function var_12_0:clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.id
		})
	end

	arg_12_2:SetData(var_12_0)
end

function DodgeBarrageEnterView:OnExit()
	DodgeBarrageEnterView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, self.redPointKey_)
end

function DodgeBarrageEnterView:Dispose()
	DodgeBarrageEnterView.super.Dispose(self)
	self.rewardList_:Dispose()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

return DodgeBarrageEnterView
