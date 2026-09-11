local GodEaterAwardItem = class("GodEaterAwardItem", ReduxView)

function GodEaterAwardItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.statusControlller = self.benefititemControllerexcollection_:GetController("isFull")
end

function GodEaterAwardItem:SetData(arg_2_1, arg_2_2)
	self.iconImg_.sprite = ItemTools.getItemSprite(arg_2_1.reward_param[1] or 0)
	self.textnumText_.text = arg_2_1.addedNum .. "/" .. arg_2_1.reward_param[3]
	self.premintextText_.text = string.format(GetTips("GODEATER_DES_4"), arg_2_1.reward_param[2] * (3600 / arg_2_1.second))

	self.statusControlller:SetSelectedState(arg_2_1.addedNum >= arg_2_1.reward_param[3] and "true" or "false")
end

function GodEaterAwardItem:ShowReceiveAnimation(arg_3_1)
	self.benefititemAni_:Play("idle", 0, 0)
	AnimatorTools.PlayAnimationWithCallback(self.benefititemAni_, "benefitItem_receive", function()
		if arg_3_1 then
			arg_3_1()
		end
	end)
end

function GodEaterAwardItem:Dispose()
	GodEaterAwardItem.super.Dispose(self)
	AnimatorTools.Stop()
end

return GodEaterAwardItem
