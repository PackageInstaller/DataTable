local NewHeroSkinItem = class("NewHeroSkinItem", ReduxView)
local var_0_2 = 0.85
local var_0_3 = 0.775

function NewHeroSkinItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.isActive = false

	self:BindCfgUI()

	self.roleImg_.immediate = true

	self:InitUI()
	self:AddUIListener()
end

function NewHeroSkinItem:isUnlock(arg_2_1)
	return HeroTools.GetHasOwnedSkin(arg_2_1)
end

function NewHeroSkinItem:isUnlockOrCanChange(arg_3_1)
	return self:isUnlock(arg_3_1) or HeroTools.CanChangeSkin(arg_3_1)
end

function NewHeroSkinItem:SetActive(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)

	self.isActive = arg_4_1
end

function NewHeroSkinItem:SetOrder(arg_5_1)
	self.spriterenderer_.sortingOrder = arg_5_1
end

function NewHeroSkinItem:isSelect(arg_6_1)
	if HeroTools.HeroUsingSkinInfo(SkinCfg[arg_6_1].hero).id == arg_6_1 then
		return true
	end

	return false
end

function NewHeroSkinItem:SetDelegate(arg_7_1)
	self.delegate_ = arg_7_1
end

function NewHeroSkinItem:InitUI()
	self.selController_ = self.controllerEx_:GetController("sel")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.dlcController_ = self.controllerEx_:GetController("dlc")
	self.battleSkinController_ = self.controllerEx_:GetController("battleSkin")
	self.transform_.pivot = Vector2(0.5, 0.5)
	self.parentWidth_ = self.scrollTf_.rect.width / 2
	self.itemWidth_ = self.transform_.rect.width / 2 * (var_0_2 + var_0_3)
end

function NewHeroSkinItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		self:delegate_()
	end)
end

function NewHeroSkinItem:Show(arg_11_1, arg_11_2)
	self.skinID_ = arg_11_1
	self.index_ = arg_11_2
	self.skinState_ = self:SkinState()

	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.HERO_SKIN_ROUTE_ID .. self.skinID_)
	self:RefreshUI()
end

function NewHeroSkinItem:PlayAni(arg_12_1)
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	self.itemAni_.enabled = false
	self.itemTrs_.localPosition = Vector3(self.itemTrs_.localPosition.x, -562, self.itemTrs_.localPosition.z)
	self.aniTimer_ = Timer.New(function()
		self.itemAni_.enabled = true

		self.itemAni_:Play("aniSkinUI_item")
	end, arg_12_1, 1)

	self.aniTimer_:Start()
end

function NewHeroSkinItem:GetSkinID()
	return self.skinID_
end

function NewHeroSkinItem:RefreshUI()
	self.roleImg_.spriteSync = getSpritePathViaConfig("HeroIcon", SkinCfg[self.skinID_].picture_id)
	self.nameText_.text = GetI18NText(SkinCfg[self.skinID_].name)

	if self:isUnlock(self.skinID_) then
		self.lockController_:SetSelectedState("unlock")
	else
		self.lockController_:SetSelectedState("lock")
	end

	if self:isSelect(self.skinID_) then
		SetActive(self.iconGo_, true)
	else
		SetActive(self.iconGo_, false)
	end

	if self.skinState_ == 5 or manager.redPoint:getTipBoolean(RedPointConst.HERO_SKIN_ID_EXTEND .. self.skinID_) or manager.redPoint:getTipValue(RedPointConst.SKIN_GIFT .. "_" .. self.skinID_) == 1 then
		manager.redPoint:SetRedPointIndependent(self.itemTrs_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.itemTrs_, false)
	end
end

function NewHeroSkinItem:JudgeDLC(arg_16_1)
	self.dlcID_ = nil

	local var_16_0 = HeroTools.GetShopIdBySkinId(arg_16_1)

	if not var_16_0 then
		return false
	end

	local var_16_1 = getShopCfg(var_16_0)
	local var_16_2 = var_16_1 and var_16_1.dlc

	if var_16_1 and var_16_1.dlc and var_16_2 ~= 0 then
		self.dlcID_ = var_16_2

		return true
	end

	return false
end

function NewHeroSkinItem:SkinState()
	if self:isUnlock(self.skinID_) then
		if self:isSelect(self.skinID_) then
			return 1
		end

		return 2
	else
		if HeroTools.GetIsLimitTimeSkin(self.skinID_) then
			if self:isSelect(self.skinID_) then
				if HeroTools.IsSkinOutOfDate(self.skinID_) or self.showDlcState_ == 1 then
					return 1
				else
					return 10
				end
			elseif HeroTools.IsSkinOutOfDate(self.skinID_) or self.showDlcState_ == 1 then
				return 2
			else
				return 11
			end
		end

		if HeroTools.CanChangeSkin(self.skinID_) then
			return 5
		end

		if HeroTools.GetSkinIsCanUnLock(self.skinID_) then
			return 6
		end

		if HeroTools.IsSkinOutOfDate(self.skinID_) then
			return 4
		end

		if ShopTools.IsPC() and ShopTools.IsRMB((HeroTools.GetShopIdBySkinId(self.skinID_))) then
			return 12
		end

		return 3
	end
end

function NewHeroSkinItem:CheckDLC(arg_18_1)
	self.dlcController_:SetSelectedState(arg_18_1 and "haveDLC" or "noDLC")
end

function NewHeroSkinItem:ShowSelect(arg_19_1)
	self.selController_:SetSelectedState(arg_19_1 and "true" or "false")
end

function NewHeroSkinItem:ShowBattleSkin(arg_20_1)
	self.battleSkinController_:SetSelectedState(arg_20_1 and "true" or "false")
end

function NewHeroSkinItem:RefreshShow()
	local var_21_1 = math.max(var_0_2 - (var_0_2 - var_0_3) * (math.abs(self.scrollTf_:InverseTransformPoint(self.transform_:TransformPoint(Vector3.zero)).x) / self.itemWidth_), var_0_3)

	self.transform_.localScale = Vector3.New(var_21_1, var_21_1, var_21_1)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTf_)
end

function NewHeroSkinItem:GetLocalPosition()
	return self.transform_.localPosition
end

function NewHeroSkinItem:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(self.transform_)
	NewHeroSkinItem.super.Dispose(self)
end

return NewHeroSkinItem
