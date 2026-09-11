ActivityRewardItemBase = import("game.views.activity.Submodule.destroyBoxGame.rewardBase.ActivityRewardItemBase")

local SequentialBattleRewardItem = class("SequentialBattleRewardItem", ActivityRewardItemBase)

function SequentialBattleRewardItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.buttonController = self.controllerEx_:GetController("status")
	self.rewardItemList_ = {}

	for iter_1_0 = 1, 3 do
		self.rewardItemList_[iter_1_0] = CommonItemView.New(self[string.format("rewardItem%s_", iter_1_0)])
	end
end

function SequentialBattleRewardItem:SetData(arg_2_1, arg_2_2)
	self.index_ = arg_2_2

	self:Show(true)

	self.rewardID_ = arg_2_1

	local var_2_0 = SequentialBattleRewardCfg[arg_2_1]

	self.indexText_.text = string.format("%02d", (table.keyof(SequentialBattleRewardCfg.get_id_list_by_activity_id[SequentialBattleRewardCfg[arg_2_1].activity_id], arg_2_1)))
	self.descText_.text = string.format(var_2_0.desc, var_2_0.complete_num)

	local var_2_1 = math.min(table.length(SequentialBattleData:GetFinishStageList(var_2_0.activity_id)), var_2_0.complete_num)

	self.progressText_.text = string.format("%s/%s", var_2_1, var_2_0.complete_num)
	self.slider_.value = var_2_1 / var_2_0.complete_num

	local var_2_2

	if var_2_0 then
		var_2_2 = var_2_0.item_list or {}
	end

	local var_2_3 = false

	if table.keyof(SequentialBattleData:GetReceiveRewardList(var_2_0.main_activity_id), arg_2_1) then
		self.buttonController:SetSelectedState("haveGet")

		var_2_3 = true
	elseif SequentialBattleTools.IsUnlockReward(arg_2_1) then
		self.buttonController:SetSelectedState("canGet")
	else
		self.buttonController:SetSelectedState("unFinish")
	end

	for iter_2_0, iter_2_1 in pairs(var_2_2) do
		local var_2_4 = clone(ItemTemplateData)

		var_2_4.id = iter_2_1[1]
		var_2_4.number = iter_2_1[2]
		var_2_4.grayFlag = not not var_2_3

		function var_2_4:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItemList_[iter_2_0]:SetData(var_2_4)
	end

	for iter_2_2 = #var_2_2 + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_2_2]:SetData(nil)
	end
end

function SequentialBattleRewardItem:Dispose()
	for iter_4_0, iter_4_1 in ipairs(self.rewardItemList_) do
		iter_4_1:Dispose()
	end

	self.rewardItemList_ = nil

	SequentialBattleRewardItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SequentialBattleRewardItem:AddListeners()
	self:AddBtnListener(self.getBtn_, nil, function()
		SequentialBattleAction.ReceiveReward(SequentialBattleRewardCfg[self.rewardID_].main_activity_id, {
			self.rewardID_
		}, function()
			manager.notify:Invoke(ACTIVITY_REWARD_REFRESH)
		end)
	end)
end

function SequentialBattleRewardItem:Update()
	self:SetData(self.rewardID_, self.index_)
end

return SequentialBattleRewardItem
