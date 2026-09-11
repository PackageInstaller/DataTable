local HeroFileMainTipsItem = class("HeroFileMainTipsItem", ReduxView)

function HeroFileMainTipsItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroFileMainTipsItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroFileMainTipsItem:InitUI()
	self:BindCfgUI()

	self.unlockStateController_ = self.btnControllerEx_:GetController("unlock")
	self.rewardItem_ = CommonItemView.New(self.item_)
end

function HeroFileMainTipsItem:AddUIListener()
	return
end

function HeroFileMainTipsItem:SetData(arg_5_1, arg_5_2)
	if arg_5_1 <= ArchiveData:GetTrustLevel(arg_5_2) then
		self.unlockStateController_:SetSelectedState("unlock")
	else
		self.unlockStateController_:SetSelectedState("lock")
	end

	self.titleText_.text = ArchiveTools.GetTrustLvDes(arg_5_1)

	if HeroTrustCfg.get_id_list_by_hero_id[arg_5_2][arg_5_1 - 1] then
		if HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[arg_5_2][arg_5_1 - 1]].reward_item_list[1] then
			local var_5_0 = clone(ItemTemplateData)

			var_5_0.id = HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[arg_5_2][arg_5_1 - 1]].reward_item_list[1][1]
			var_5_0.number = HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[arg_5_2][arg_5_1 - 1]].reward_item_list[1][2]

			function var_5_0.clickFun()
				ShowPopItem(POP_ITEM, {
					var_5_0.id
				})
			end

			self.rewardItem_:SetData(var_5_0)
			SetActive(self.item_, true)
		else
			SetActive(self.item_, false)
		end
	else
		SetActive(self.item_, false)
	end
end

function HeroFileMainTipsItem:Dispose()
	if self.rewardItem_ then
		self.rewardItem_:Dispose()

		self.rewardItem_ = nil
	end

	HeroFileMainTipsItem.super.Dispose(self)
end

return HeroFileMainTipsItem
