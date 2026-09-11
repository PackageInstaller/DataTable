local RecallSystemRewardItem = class("RecallSystemRewardItem", ReduxView)

function RecallSystemRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RecallSystemRewardItem:Init()
	self:InitUI()
end

function RecallSystemRewardItem:InitUI()
	self:BindCfgUI()

	self.commonItem = CommonItemView.New(self.itemGo_, true)
end

function RecallSystemRewardItem:SetData(arg_4_1)
	self.data = arg_4_1

	CommonTools.SetCommonData(self.commonItem, {
		id = self.data.id,
		number = self.data.num,
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	})

	self.nameTxt_.text = ItemTools.getItemName(self.data.id)
end

function RecallSystemRewardItem:UpdateView()
	return
end

function RecallSystemRewardItem:OnEnter()
	return
end

function RecallSystemRewardItem:OnExit()
	return
end

function RecallSystemRewardItem:Dispose()
	self.commonItem:Dispose()
	RecallSystemRewardItem.super.Dispose(self)
end

return RecallSystemRewardItem
