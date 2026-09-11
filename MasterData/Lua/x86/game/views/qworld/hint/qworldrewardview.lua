local QWorldRewardView = class("QWorldRewardView", QWorldHintBaseView)

function QWorldRewardView:UIName()
	return "Widget/System/SandPlay/SandPlay_InScenes/item/SandPlay_Get"
end

function QWorldRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function QWorldRewardView:InitUI()
	self.rewardList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, CommonItemView)

	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Hide()
	end)
end

function QWorldRewardView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = self.rewards_[arg_5_1]

	if ItemCfg[self.rewards_[arg_5_1].id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_5_0.id].type then
		if EquipCfg[var_5_0.id] then
			var_5_0.race = EquipCfg[var_5_0.id].race or 0
		end
	end

	local var_5_1 = clone(ItemTemplateData)

	var_5_1.id = var_5_0.id
	var_5_1.number = var_5_0.num
	var_5_1.race = var_5_0.race

	function var_5_1:clickFun()
		ShowPopItemOnly(POP_OTHER_ITEM, {
			self.id,
			self.number
		})
	end

	arg_5_2:SetData(var_5_1)
end

function QWorldRewardView:SetData(arg_7_1)
	self.rewards_ = {}

	for iter_7_0 = 1, math.min(#arg_7_1, 8) do
		table.remove(arg_7_1, 1)
		table.insert(self.rewards_, arg_7_1[1])
	end

	self.rewards_ = ItemTools.SortRewardItemList(self.rewards_)
end

function QWorldRewardView:RefreshUI()
	self.rewardList_:StartScroll(#self.rewards_)

	self.titleText_.text = GetTips("SANDPLAY_TIP_REWARD")
end

function QWorldRewardView:Dispose()
	if self.rewardList_ then
		self.rewardList_:Dispose()

		self.rewardList_ = nil
	end

	QWorldRewardView.super.Dispose(self)
end

return QWorldRewardView
