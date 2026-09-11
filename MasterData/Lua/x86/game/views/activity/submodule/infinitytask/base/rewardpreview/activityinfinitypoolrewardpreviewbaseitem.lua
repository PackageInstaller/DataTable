local ActivityInfinityPoolRewardPreviewBaseItem = class("ActivityInfinityPoolRewardPreviewBaseItem", ReduxView)

function ActivityInfinityPoolRewardPreviewBaseItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
	self.rewardItem_ = self:GetRewardItem(arg_1_3)

	self:SetData(arg_1_3, arg_1_4, arg_1_5)
end

function ActivityInfinityPoolRewardPreviewBaseItem:GetRewardItem(arg_2_1)
	return RewardPoolItem.New(self.gameObject_, arg_2_1)
end

function ActivityInfinityPoolRewardPreviewBaseItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.rewardItem_:SetData(arg_3_1)

	if self.gameObject_.activeSelf == false then
		self:Show(true)
	end

	self.textCnt_.text = string.format("%s/%s", arg_3_2, arg_3_3)

	if arg_3_3 <= arg_3_2 then
		self.controller_:SetSelectedState("get")
	else
		self.controller_:SetSelectedState("normal")
	end
end

function ActivityInfinityPoolRewardPreviewBaseItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function ActivityInfinityPoolRewardPreviewBaseItem:Dispose()
	ActivityInfinityPoolRewardPreviewBaseItem.super.Dispose(self)
	self.rewardItem_:Dispose()

	self.rewardItem_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return ActivityInfinityPoolRewardPreviewBaseItem
