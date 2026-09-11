local CustomCenterHeroSkinItem = class("CustomCenterHeroSkinItem", ReduxView)
local var_0_2 = 0.85
local var_0_3 = 0.775

function CustomCenterHeroSkinItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.isActive = false

	self:BindCfgUI()

	self.roleImg_.immediate = true

	self:InitUI()
	self:AddUIListener()
end

function CustomCenterHeroSkinItem:isUnlock(arg_2_1)
	return HeroTools.GetHasOwnedSkin(arg_2_1)
end

function CustomCenterHeroSkinItem:isUnlockOrCanChange(arg_3_1)
	return self:isUnlock(arg_3_1) or HeroTools.CanChangeSkin(arg_3_1)
end

function CustomCenterHeroSkinItem:SetActive(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)

	self.isActive = arg_4_1
end

function CustomCenterHeroSkinItem:SetOrder(arg_5_1)
	self.spriterenderer_.sortingOrder = arg_5_1
end

function CustomCenterHeroSkinItem:SetDelegate(arg_6_1)
	self.delegate_ = arg_6_1
end

function CustomCenterHeroSkinItem:InitUI()
	self.selController_ = self.controllerEx_:GetController("sel")
	self.useController_ = self.controllerEx_:GetController("use")
	self.transform_.pivot = Vector2(0.5, 0.5)
	self.itemWidth_ = self.transform_.rect.width / 2 * (var_0_2 + var_0_3)
	self.battleSkinController_ = self.controllerEx_:GetController("battleSkin")
end

function CustomCenterHeroSkinItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		self:delegate_()
	end)
end

function CustomCenterHeroSkinItem:Show(arg_10_1, arg_10_2)
	self.skinID_ = arg_10_1
	self.index_ = arg_10_2

	self:RefreshUI()
end

function CustomCenterHeroSkinItem:PlayAni(arg_11_1)
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	self.itemAni_.enabled = false
	self.itemTrs_.localPosition = Vector3(self.itemTrs_.localPosition.x, -562, self.itemTrs_.localPosition.z)
	self.aniTimer_ = Timer.New(function()
		self.itemAni_.enabled = true

		self.itemAni_:Play("aniSkinUI_item")
	end, arg_11_1, 1)

	self.aniTimer_:Start()
end

function CustomCenterHeroSkinItem:GetSkinID()
	return self.skinID_
end

function CustomCenterHeroSkinItem:RefreshUI()
	self.roleImg_.spriteSync = getSpritePathViaConfig("HeroIcon", SkinCfg[self.skinID_].picture_id)
	self.nameText_.text = GetI18NText(SkinCfg[self.skinID_].name)

	self.useController_:SetSelectedState(tostring(not CustomCenterTools.IsRandomHero() and self.skinID_ == PlayerData:GetPosterGirlHeroSkinId() or table.keyof(PlayerData:GetCacheHeroSkinList(), self.skinID_) ~= nil))
end

function CustomCenterHeroSkinItem:ShowSelect(arg_15_1)
	self.selController_:SetSelectedState(arg_15_1 and "true" or "false")
end

function CustomCenterHeroSkinItem:RefreshShow()
	local var_16_1 = math.max(var_0_2 - (var_0_2 - var_0_3) * (math.abs(self.scrollTf_:InverseTransformPoint(self.transform_:TransformPoint(Vector3.zero)).x) / self.itemWidth_), var_0_3)

	self.transform_.localScale = Vector3.New(var_16_1, var_16_1, var_16_1)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTf_)
end

function CustomCenterHeroSkinItem:GetLocalPosition()
	return self.transform_.localPosition
end

function CustomCenterHeroSkinItem:ShowBattleSkin(arg_18_1)
	self.battleSkinController_:SetSelectedState(arg_18_1 and "true" or "false")
end

function CustomCenterHeroSkinItem:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	CustomCenterHeroSkinItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return CustomCenterHeroSkinItem
