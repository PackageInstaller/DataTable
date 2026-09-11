local DormTaskRankItem = class("DormTaskRankItem", ReduxView)

function DormTaskRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormTaskRankItem:Init()
	self:InitUI()
end

function DormTaskRankItem:InitUI()
	self:BindCfgUI()

	self.rankRewardItem_ = CommonItemView.New(self.itemGo_, true)
end

function DormTaskRankItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self.index_ = arg_4_1
	self.rank_ = arg_4_2
	self.curNum = arg_4_3
	self.maxNum = arg_4_4
	self.cfg = arg_4_5

	self:UpdateView()
end

function DormTaskRankItem:UpdateView()
	self.numText_.text = self.cfg.item_id[2]
	self.slider_.value = self.index_ == 1 and (self.curNum >= self.cfg.item_id[2] and 1 or self.curNum % 100 / 100) or self.curNum >= self.cfg.item_id[2] and 1 or (self.curNum - IdolTraineeRewardRankCfg[self.index_ - 1].item_id[2]) / 100
	self.fillImg_.enabled = self.slider_.value ~= 0

	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = self.cfg.icon
	var_5_0.number = self.cfg.num
	var_5_0.clickFun = handler(self, self.OnClickCommonItem)

	self.rankRewardItem_:SetData(var_5_0)
	self.rankRewardItem_:RefreshCompleted(self.index_ < self.rank_)
end

function DormTaskRankItem:OnClickCommonItem(arg_6_1)
	ShowPopItem(POP_ITEM, {
		arg_6_1.id,
		arg_6_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function DormTaskRankItem:Dispose()
	if self.rankRewardItem_ then
		self.rankRewardItem_:Dispose()

		self.rankRewardItem_ = nil
	end

	DormTaskRankItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return DormTaskRankItem
