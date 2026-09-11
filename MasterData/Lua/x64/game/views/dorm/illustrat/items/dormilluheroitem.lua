local DormIlluHeroItem = class("DormIlluHeroItem", ReduxView)

function DormIlluHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormIlluHeroItem:InitUI()
	self:BindCfgUI()

	self.unLockController_ = self.mainControllerEx_:GetController("have")

	self:AddUIListener()
end

function DormIlluHeroItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		self.clickFunc_(self.heroID_, self.index_)
	end)
end

function DormIlluHeroItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.heroID_ = arg_5_2
	self.archiveID_ = HeroRecordCfg.get_id_list_by_hero_id[self.heroID_][1]
	self.isUnlock_ = HeroTools.GetHeroIsUnlock(self.heroID_)

	self:RefreshUI()
end

function DormIlluHeroItem:RefreshUI()
	self.unLockController_:SetSelectedIndex(self.isUnlock_ and 1 or 0)

	self.headImage_.sprite = DormHeroTools.GetBackHomeHeroSkinIcon(self.heroID_)
	self.nameText_.text = HeroCfg[self.heroID_].name
end

function DormIlluHeroItem:SetUnlock(arg_7_1)
	self.unLockController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function DormIlluHeroItem:RegistCallBack(arg_8_1)
	self.clickFunc_ = arg_8_1
end

function DormIlluHeroItem:Dispose()
	self:RemoveAllEventListener()
	DormIlluHeroItem.super.Dispose(self)
end

return DormIlluHeroItem
