local var_0_0 = class("NewHeroSkinItem", ReduxView)
local var_0_1 = 154
local var_0_2 = 0.85
local var_0_3 = 0.775

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isActive = false

	arg_1_0:BindCfgUI()

	arg_1_0.roleImg_.immediate = true

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.isUnlock(arg_2_0, arg_2_1)
	return HeroTools.GetHasOwnedSkin(arg_2_1)
end

function var_0_0.isUnlockOrCanChange(arg_3_0, arg_3_1)
	return arg_3_0:isUnlock(arg_3_1) or HeroTools.CanChangeSkin(arg_3_1)
end

function var_0_0.SetActive(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)

	arg_4_0.isActive = arg_4_1
end

function var_0_0.SetOrder(arg_5_0, arg_5_1)
	arg_5_0.spriterenderer_.sortingOrder = arg_5_1
end

function var_0_0.isSelect(arg_6_0, arg_6_1)
	if HeroTools.HeroUsingSkinInfo(SkinCfg[arg_6_1].hero).id == arg_6_1 then
		return true
	end

	return false
end

function var_0_0.SetDelegate(arg_7_0, arg_7_1)
	arg_7_0.delegate_ = arg_7_1
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0.selController_ = arg_8_0.controllerEx_:GetController("sel")
	arg_8_0.lockController_ = arg_8_0.controllerEx_:GetController("lock")
	arg_8_0.dlcController_ = arg_8_0.controllerEx_:GetController("dlc")
	arg_8_0.battleSkinController_ = arg_8_0.controllerEx_:GetController("battleSkin")
	arg_8_0.transform_.pivot = Vector2(0.5, 0.5)
	arg_8_0.parentWidth_ = arg_8_0.scrollTf_.rect.width / 2
	arg_8_0.itemWidth_ = arg_8_0.transform_.rect.width / 2 * (var_0_2 + var_0_3)
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.itemBtn_, nil, function()
		arg_9_0.delegate_(arg_9_0)
	end)
end

function var_0_0.Show(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.skinID_ = arg_11_1
	arg_11_0.index_ = arg_11_2
	arg_11_0.skinState_ = arg_11_0:SkinState()

	local var_11_0 = SkinCfg[arg_11_1].hero

	manager.redPoint:bindUIandKey(arg_11_0.transform_, RedPointConst.HERO_SKIN_ROUTE_ID .. arg_11_0.skinID_)
	arg_11_0:RefreshUI()
end

function var_0_0.PlayAni(arg_12_0, arg_12_1)
	if arg_12_0.aniTimer_ then
		arg_12_0.aniTimer_:Stop()

		arg_12_0.aniTimer_ = nil
	end

	arg_12_0.itemAni_.enabled = false
	arg_12_0.itemTrs_.localPosition = Vector3(arg_12_0.itemTrs_.localPosition.x, -562, arg_12_0.itemTrs_.localPosition.z)
	arg_12_0.aniTimer_ = Timer.New(function()
		arg_12_0.itemAni_.enabled = true

		arg_12_0.itemAni_:Play("aniSkinUI_item")
	end, arg_12_1, 1)

	arg_12_0.aniTimer_:Start()
end

function var_0_0.GetSkinID(arg_14_0)
	return arg_14_0.skinID_
end

function var_0_0.RefreshUI(arg_15_0)
	local var_15_0 = SkinCfg[arg_15_0.skinID_]

	arg_15_0.roleImg_.spriteSync = getSpritePathViaConfig("HeroIcon", var_15_0.picture_id)
	arg_15_0.nameText_.text = GetI18NText(var_15_0.name)

	if arg_15_0:isUnlock(arg_15_0.skinID_) then
		arg_15_0.lockController_:SetSelectedState("unlock")
	else
		arg_15_0.lockController_:SetSelectedState("lock")
	end

	if arg_15_0:isSelect(arg_15_0.skinID_) then
		SetActive(arg_15_0.iconGo_, true)
	else
		SetActive(arg_15_0.iconGo_, false)
	end

	local var_15_1 = RedPointConst.HERO_SKIN_ID_EXTEND .. arg_15_0.skinID_

	if arg_15_0.skinState_ == 5 or manager.redPoint:getTipBoolean(var_15_1) or manager.redPoint:getTipValue(RedPointConst.SKIN_GIFT .. "_" .. arg_15_0.skinID_) == 1 then
		manager.redPoint:SetRedPointIndependent(arg_15_0.itemTrs_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_15_0.itemTrs_, false)
	end
end

function var_0_0.JudgeDLC(arg_16_0, arg_16_1)
	arg_16_0.dlcID_ = nil

	local var_16_0 = HeroTools.GetShopIdBySkinId(arg_16_1)

	if not var_16_0 then
		return false
	end

	local var_16_1 = getShopCfg(var_16_0)
	local var_16_2 = var_16_1 and var_16_1.dlc

	if var_16_2 and var_16_2 ~= 0 then
		arg_16_0.dlcID_ = var_16_2

		return true
	end

	return false
end

function var_0_0.SkinState(arg_17_0)
	if arg_17_0:isUnlock(arg_17_0.skinID_) then
		if arg_17_0:isSelect(arg_17_0.skinID_) then
			return 1
		end

		return 2
	else
		if HeroTools.GetIsLimitTimeSkin(arg_17_0.skinID_) then
			if arg_17_0:isSelect(arg_17_0.skinID_) then
				if HeroTools.IsSkinOutOfDate(arg_17_0.skinID_) or arg_17_0.showDlcState_ == 1 then
					return 1
				else
					return 10
				end
			elseif HeroTools.IsSkinOutOfDate(arg_17_0.skinID_) or arg_17_0.showDlcState_ == 1 then
				return 2
			else
				return 11
			end
		end

		if HeroTools.CanChangeSkin(arg_17_0.skinID_) then
			return 5
		end

		if HeroTools.GetSkinIsCanUnLock(arg_17_0.skinID_) then
			return 6
		end

		if HeroTools.IsSkinOutOfDate(arg_17_0.skinID_) then
			return 4
		end

		if ShopTools.IsPC() then
			local var_17_0 = HeroTools.GetShopIdBySkinId(arg_17_0.skinID_)

			if ShopTools.IsRMB(var_17_0) then
				return 12
			end
		end

		return 3
	end
end

function var_0_0.CheckDLC(arg_18_0, arg_18_1)
	arg_18_0.dlcController_:SetSelectedState(arg_18_1 and "haveDLC" or "noDLC")
end

function var_0_0.ShowSelect(arg_19_0, arg_19_1)
	arg_19_0.selController_:SetSelectedState(arg_19_1 and "true" or "false")
end

function var_0_0.ShowBattleSkin(arg_20_0, arg_20_1)
	arg_20_0.battleSkinController_:SetSelectedState(arg_20_1 and "true" or "false")
end

function var_0_0.RefreshShow(arg_21_0)
	local var_21_0 = arg_21_0.scrollTf_.rect.width / 2
	local var_21_1 = arg_21_0.scrollTf_:InverseTransformPoint(arg_21_0.transform_:TransformPoint(Vector3.zero))
	local var_21_2 = math.abs(var_21_1.x)
	local var_21_3 = math.max(var_0_2 - (var_0_2 - var_0_3) * (var_21_2 / arg_21_0.itemWidth_), var_0_3)

	arg_21_0.transform_.localScale = Vector3.New(var_21_3, var_21_3, var_21_3)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.contentTf_)
end

function var_0_0.GetLocalPosition(arg_22_0)
	return arg_22_0.transform_.localPosition
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.aniTimer_ then
		arg_23_0.aniTimer_:Stop()

		arg_23_0.aniTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_23_0.transform_)
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
