local PolyhedronPolicyRewardItem = class("PolyhedronPolicyRewardItem", ReduxView)

function PolyhedronPolicyRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronPolicyRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronPolicyRewardItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
end

function PolyhedronPolicyRewardItem:AddUIListener()
	if self.btn_ then
		self:AddBtnListener(self.btn_, nil, function()
			PolyhedronAction.QueryPolicyReward(2, self.level_)
		end)
	end
end

function PolyhedronPolicyRewardItem:SetData(arg_6_1, arg_6_2)
	self.ID_ = arg_6_1
	self.rewardCfg_ = PolyhedronPolicyCfg[self.ID_].rewards[1]
	self.level_ = PolyhedronPolicyCfg[self.ID_].level
	self.curLevel_ = arg_6_2

	self:UpdateView()
end

function PolyhedronPolicyRewardItem:UpdateView()
	self.levelText_.text = self.level_

	local var_7_0 = clone(ItemTemplateData)

	var_7_0.id = self.rewardCfg_[1]
	var_7_0.number = self.rewardCfg_[2]

	function var_7_0:clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.id,
			self.number
		})
	end

	if self.commonItem_ == nil then
		self.commonItem_ = CommonItemPool.New(self.rewardPanelGo_, var_7_0)
	else
		self.commonItem_:SetData(var_7_0)
	end

	if self.stateController_ then
		if PolyhedronData:GetPolicyApplyList()[self.level_] == true then
			self.stateController_:SetSelectedState("received")
		elseif self.curLevel_ >= self.level_ then
			self.stateController_:SetSelectedState("unreceive")
		else
			self.stateController_:SetSelectedState("uncomplete")
		end
	end
end

function PolyhedronPolicyRewardItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	PolyhedronPolicyRewardItem.super.Dispose(self)
end

return PolyhedronPolicyRewardItem
