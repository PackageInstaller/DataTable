local HeroTrustGiftDisplaceHeroItem = class("HeroTrustGiftDisplaceHeroItem", ReduxView)

function HeroTrustGiftDisplaceHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroTrustGiftDisplaceHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrustGiftDisplaceHeroItem:InitUI()
	self:BindCfgUI()

	self.favorabilityController = ControllerUtil.GetController(self.transform_, "favorability")
end

function HeroTrustGiftDisplaceHeroItem:AddUIListener()
	return
end

function HeroTrustGiftDisplaceHeroItem:SetData(arg_5_1)
	self.roleImg_.sprite = getSpriteViaConfig("HeroItemshead", arg_5_1)
	self.nameText_.text = HeroCfg[arg_5_1].name

	local var_5_0 = ArchiveData:GetTrustLevel(arg_5_1)

	if var_5_0 > 0 then
		self.favorabilityController:SetSelectedIndex(1)

		self.favorExText_.text = ArchiveTools.GetTrustLvDes(var_5_0)
	else
		self.favorabilityController:SetSelectedIndex(0)

		self.favorExText_.text = GetTipsF("HERO_TRUST_DISPLACE_LOVE", ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[arg_5_1][1]).lv)
	end
end

function HeroTrustGiftDisplaceHeroItem:Dispose()
	HeroTrustGiftDisplaceHeroItem.super.Dispose(self)
end

return HeroTrustGiftDisplaceHeroItem
