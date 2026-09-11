local SummerPubPartnerItem = class("SummerPubPartnerItem", ReduxView)

PARTNER_PATH = "TextureConfig/Character/Icon/"

function SummerPubPartnerItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.index = arg_1_2
	self.transform_ = self.gameObject_.transform
	self.id = SummerPubHeroCfg.get_id_list_by_profile_position[arg_1_2][1]
	self.cfg = SummerPubHeroCfg[self.id]
	self.clickFunc_ = arg_1_3

	self:AddListeners()
	self:InitUI()
end

function SummerPubPartnerItem:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.controller_:GetController("lock")
	self.heroName_.text = GetI18NText(self.cfg.hero_name)
	self.heroIcon_.sprite = pureGetSpriteWithoutAtlas(PARTNER_PATH .. self.cfg.profile_icon_head)

	self.lockController_:SetSelectedState("lock")
end

function SummerPubPartnerItem:Dispose()
	SummerPubPartnerItem.super.Dispose(self)
end

function SummerPubPartnerItem:UpdateState()
	if SummerPubData:isUnlockPartner(self.id) then
		self.lockController_:SetSelectedState("unlock")

		if (getData("summer_pub_partner", "hero_anim_" .. self.index) or 0) == 0 then
			saveData("summer_pub_partner", "hero_anim_" .. self.index, 1)
			self.unlockAnim_:Play("UI_bigheroitem_cx", -1, 0)
		else
			self.unlockAnim_:Play("UI_unlock_cx")
		end
	end
end

function SummerPubPartnerItem:AddListeners()
	self:AddBtnListener(self.detailBtn, nil, function()
		if SummerPubData:isUnlockPartner(self.id) then
			self.clickFunc_()
			JumpTools.OpenPageByJump("summerPubPartnerDetailView", {
				id = self.id
			})
		else
			ShowTips("NYA_TEAM_NOT_RECRUITED")
		end
	end)
end

return SummerPubPartnerItem
