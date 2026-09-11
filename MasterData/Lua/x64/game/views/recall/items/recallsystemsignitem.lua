local RecallSystemSignItem = class("RecallSystemSignItem", ReduxView)

function RecallSystemSignItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RecallSystemSignItem:Init()
	self:InitUI()
	self:AddBtnListener(self.signBtn_, nil, function()
		if ActivityRecallData:GetSevenDaySignIndex(self.index) > 0 then
			ActivityRecallAction.RequireRecalledSign(ActivityRecallData:GetDataByPara("signActivityID"), self.index)
		end
	end)
end

function RecallSystemSignItem:InitUI()
	self:BindCfgUI()

	self.item = CommonItemView.New(self.m_item, true)
end

function RecallSystemSignItem:SetData(arg_5_1, arg_5_2)
	self.data = arg_5_1
	self.index = arg_5_2

	self:UpdateView()
end

function RecallSystemSignItem:UpdateView()
	local var_6_0 = ActivityRecallData:GetDataByPara("getRewardList")
	local var_6_1 = ActivityRecallData:GetDataByPara("signCount")

	CommonTools.SetCommonData(self.item, {
		id = self.data.reward[1],
		number = self.data.reward[2],
		clickFun = function(self)
			ShowPopItem(POP_OTHER_ITEM, {
				self.id,
				self.number
			})
		end
	})
	SetActive(self.canGetGo_, var_6_1 >= self.index and var_6_0[self.index] == nil)
	SetActive(self.getGo_, var_6_0[self.index] ~= nil)

	self.dayTxt_.text = self.data.day
end

function RecallSystemSignItem:OnEnter()
	return
end

function RecallSystemSignItem:OnExit()
	return
end

function RecallSystemSignItem:Dispose()
	RecallSystemSignItem.super.Dispose(self)

	if self.item then
		self.item:Dispose()

		self.item = nil
	end
end

return RecallSystemSignItem
