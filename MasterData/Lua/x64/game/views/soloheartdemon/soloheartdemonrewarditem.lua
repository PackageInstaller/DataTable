local var_0_0 = {
	"SOLO_HEART_DEMON_EASY",
	"SOLO_HEART_DEMON_HARD",
	"SOLO_HEART_DEMON_NIGHTMARE"
}
local SoloHeartDemonRewardItem = class("SoloHeartDemonRewardItem", ReduxView)

function SoloHeartDemonRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function SoloHeartDemonRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SoloHeartDemonRewardItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.type ~= 1 then
			return
		end

		SoloHeartDemonAction.GetReward({
			reward_list = {
				self.data
			}
		})
	end)
end

function SoloHeartDemonRewardItem:InitUI()
	self:BindCfgUI()

	self.controller = self.allBtnController_:GetController("all")
	self.rewardItems_ = {}

	SetActive(self[string.format("awardItem%dObj_", 3)], false)
end

function SoloHeartDemonRewardItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index = arg_6_2
	self.data = arg_6_1
	self.type = arg_6_3

	self:UpdateView()
end

function SoloHeartDemonRewardItem:UpdateView()
	self.rewardCfg = SoloHeartDemonRewardCfg[self.data]
	self.conditionCfg = ConditionCfg[self.rewardCfg.condition]
	self.rewardList = SoloHeartDemonData:GetDataByPara("rewardList")[self.data]
	self.taskData = SoloHeartDemonData:GetDataByPara("taskData")[self.data]

	for iter_7_0, iter_7_1 in ipairs(self.rewardCfg.reward_list) do
		if self.rewardItems_[iter_7_0] == nil then
			self.rewardItems_[iter_7_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_7_0)])
		end

		local var_7_0 = clone(ItemTemplateData)

		var_7_0.id = iter_7_1[1]
		var_7_0.number = iter_7_1[2]
		var_7_0.completedFlag = not not self.rewardList

		function var_7_0:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItems_[iter_7_0]:SetData(var_7_0)
	end

	for iter_7_2 = #self.rewardCfg.reward_list + 1, #self.rewardItems_ do
		self.rewardItems_[iter_7_2]:SetData(nil)
	end

	if self.type == 1 then
		SetActive(self[string.format("awardItem%dObj_", 2)], true)
	else
		SetActive(self[string.format("awardItem%dObj_", 2)], false)
	end

	self[self.type == 1 and "UpdateNormalView" or "UpdateRankView"](self)
end

function SoloHeartDemonRewardItem:UpdateRankView()
	self.titleText_.text = string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS"), self.data == 1001 and string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS2"), self.rewardCfg.reward_rank[1]) or string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS1"), self.rewardCfg.reward_rank[1], self.rewardCfg.reward_rank[2]))
end

function SoloHeartDemonRewardItem:UpdateNormalView()
	if self.rewardList then
		self.controller:SetSelectedState("complete")
	elseif self.taskData[1] >= self.taskData[2] then
		self.controller:SetSelectedState("receive")
	else
		self.controller:SetSelectedState("lock")
	end

	SetActive(self.progressBar_.gameObject, self.conditionCfg.progress_show == 1)

	self.progressBar_.value = self.taskData[1] / self.taskData[2]
	self.progressText_.text = self.taskData[1] .. "/" .. self.taskData[2]

	if self.conditionCfg.type == 11001 then
		self.titleText_.text = string.format(GetI18NText(self.conditionCfg.desc), tostring(GetTips(var_0_0[self.conditionCfg.params[1]])))
	elseif self.conditionCfg.type == 11002 then
		self.titleText_.text = string.format(GetI18NText(self.conditionCfg.desc), tostring(GetTips(var_0_0[self.conditionCfg.params[1]])))
	elseif self.conditionCfg.type == 11003 then
		self.titleText_.text = string.format(GetI18NText(self.conditionCfg.desc), tostring(self.conditionCfg.params[1]))
	elseif self.conditionCfg.type == 11004 then
		self.titleText_.text = string.format(GetI18NText(self.conditionCfg.desc), tostring(self.conditionCfg.params[1]))
	elseif self.conditionCfg.type == 11005 then
		self.titleText_.text = string.format(GetI18NText(self.conditionCfg.desc), tostring(self.conditionCfg.params[1]))
	end
end

function SoloHeartDemonRewardItem:OnEnter()
	self:UpdateView()
end

function SoloHeartDemonRewardItem:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	for iter_12_0, iter_12_1 in pairs(self.rewardItems_) do
		iter_12_1:Dispose()
	end

	self.rewardItems_ = {}

	SoloHeartDemonRewardItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return SoloHeartDemonRewardItem
