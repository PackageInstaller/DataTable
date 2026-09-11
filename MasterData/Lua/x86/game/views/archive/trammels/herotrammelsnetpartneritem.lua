local HeroTrammelsNetPartnerItem = class("HeroTrammelsNetPartnerItem", ReduxView)

function HeroTrammelsNetPartnerItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroTrammelsNetPartnerItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrammelsNetPartnerItem:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
end

function HeroTrammelsNetPartnerItem:AddUIListener()
	self:AddBtnListener(nil, self.m_btn, function()
		if self.callback_ then
			self.callback_(self.hero_id)
		end
	end)
end

function HeroTrammelsNetPartnerItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.hero_id = arg_6_1
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_6_1)

	self.selectController:SetSelectedIndex(arg_6_1 == arg_6_2 and 1 or 0)

	local var_6_0 = ArchiveTools.GetRelationConfig(arg_6_3, arg_6_1)

	if var_6_0 ~= nil and var_6_0.story_id ~= 0 and not ArchiveData:GetRelationStoryRead(var_6_0.id) and IsConditionAchieved(var_6_0.story_condtion_id, {
		heroId = self.hero_id
	}) then
		manager.redPoint:SetRedPointIndependent(self.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

function HeroTrammelsNetPartnerItem:RegistCallBack(arg_7_1)
	self.callback_ = arg_7_1
end

function HeroTrammelsNetPartnerItem:Dispose()
	HeroTrammelsNetPartnerItem.super.Dispose(self)
end

return HeroTrammelsNetPartnerItem
