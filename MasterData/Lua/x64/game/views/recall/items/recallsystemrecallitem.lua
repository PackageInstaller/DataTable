local RecallSystemRecallItem = class("RecallSystemRecallItem", ReduxView)

function RecallSystemRecallItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RecallSystemRecallItem:Init()
	self:InitUI()
end

function RecallSystemRecallItem:InitUI()
	self:BindCfgUI()

	self.getController = ControllerUtil.GetController(self.gameObject_.transform, "getted")

	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityRecallAction.RequireRecallReward(ActivityRecallData:GetDataByPara("recallActivityID"), self.data[1])
	end)
	self:AddBtnListener(self.item1Btn_, nil, function()
		ShowPopItem(POP_ITEM, self.data[2])
	end)
	self:AddBtnListener(self.item2Btn_, nil, function()
		ShowPopItem(POP_ITEM, self.data[3])
	end)
end

function RecallSystemRecallItem:SetData(arg_7_1, arg_7_2)
	self.data = arg_7_1
	self.id = arg_7_2

	self:UpdateView()
end

function RecallSystemRecallItem:UpdateView()
	self.useNum = ActivityRecallData:GetDataByPara("codeUseNum")
	self.recallRewardList = ActivityRecallData:GetDataByPara("recallRewardList")

	if self.recallRewardList[self.id] == nil and self.useNum >= self.data[1] then
		self.getController:SetSelectedState("canget")
	else
		self.getController:SetSelectedState(self.recallRewardList[self.id] and "true" or "false")
	end

	self.inviteTxt_.text = string.format(GetTips("RECALLED_INVITE"), self.data[1])
	self.item1Img_.sprite = ItemTools.getItemSprite(self.data[2][1])
	self.item2Img_.sprite = ItemTools.getItemSprite(self.data[3][1])
	self.item1Txt_.text = "+" .. self.data[2][2]
	self.item2Txt_.text = "+" .. self.data[3][2]
end

function RecallSystemRecallItem:OnEnter()
	return
end

function RecallSystemRecallItem:OnExit()
	self.getController = nil
end

function RecallSystemRecallItem:Dispose()
	RecallSystemRecallItem.super.Dispose(self)
end

return RecallSystemRecallItem
