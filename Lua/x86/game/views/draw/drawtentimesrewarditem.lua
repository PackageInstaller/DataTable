local var_0_0 = class("DrawTenTimesRewardItem", ReduxView)

local function var_0_1(arg_1_0)
	if arg_1_0 then
		return true
	end

	return false
end

function var_0_0.OnCtor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_1.transform

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.shareStartHandler_ = handler(arg_3_0, arg_3_0.ShareStart)
	arg_3_0.shareEndHandler_ = handler(arg_3_0, arg_3_0.ShareEnd)

	manager.notify:RegistListener(SHAER_DAW_TEN_TIMES_START, arg_3_0.shareStartHandler_)
	manager.notify:RegistListener(SHAER_DAW_TEN_TIMES_END, arg_3_0.shareEndHandler_)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.m_portrait.immediate = true
	arg_4_0.itemController_ = ControllerUtil.GetController(arg_4_0.transform_, "item")
	arg_4_0.switchController_ = ControllerUtil.GetController(arg_4_0.transform_, "switch")
	arg_4_0.rateController_ = ControllerUtil.GetController(arg_4_0.transform_, "rare")
	arg_4_0.starController_ = ControllerUtil.GetController(arg_4_0.transform_, "star")
	arg_4_0.item = CommonItemView.New(arg_4_0.m_item)
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index = arg_6_1
	arg_6_0.data_ = arg_6_2

	local var_6_0 = arg_6_2.id
	local var_6_1 = ItemWillConvert(arg_6_2) and arg_6_2.convert_from.id or var_6_0
	local var_6_2 = ItemCfg[var_6_0]
	local var_6_3 = ItemCfg[var_6_1]
	local var_6_4 = var_6_2.type
	local var_6_5 = var_6_3.type
	local var_6_6 = var_6_2.display_rare
	local var_6_7 = math.min(var_6_6, 5)

	arg_6_0.starController_:SetSelectedIndex(var_6_7)

	if var_6_6 >= 5 then
		arg_6_0.rateController_:SetSelectedIndex(0)
	elseif var_6_6 >= 4 then
		arg_6_0.rateController_:SetSelectedIndex(1)
	else
		arg_6_0.rateController_:SetSelectedIndex(2)
	end

	SetActive(arg_6_0.m_newTag, var_0_1(arg_6_2.newTag))

	if var_6_5 == ItemConst.ITEM_TYPE.HERO then
		arg_6_0.itemController_:SetSelectedIndex(0)

		local var_6_8 = HeroCfg[var_6_1]
		local var_6_9 = RaceEffectCfg[var_6_8.race]

		arg_6_0.m_camp.sprite = getSprite("Atlas/CampItemAtlas", var_6_9.icon)
		arg_6_0.m_portrait.spriteSync = "TextureConfig/Character/Icon/" .. var_6_3.id
	elseif var_6_5 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		arg_6_0.itemController_:SetSelectedIndex(1)

		local var_6_10 = WeaponServantCfg[var_6_1]
		local var_6_11 = RaceEffectCfg[var_6_10.race]

		arg_6_0.m_camp.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Group_l/" .. var_6_11.icon2)

		local var_6_12 = string.split(ItemTools.getItemName(var_6_3.id) or "", "·")

		arg_6_0.m_weaponName.text = var_6_12[1]
		arg_6_0.m_weaponImg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Icon/" .. var_6_3.icon)
	end

	if arg_6_0.timer then
		arg_6_0.timer:Stop()

		arg_6_0.timer = nil
	end

	if ItemWillConvert(arg_6_2) then
		if arg_6_3 then
			CommonTools.SetCommonData(arg_6_0.item, rewardToItemTemplate(arg_6_2))
		else
			arg_6_0.m_switchAnimator:Play("CommonItem_zhuanhua", 0, 0)

			arg_6_0.timer = Timer.New(function()
				if arg_6_0.index == arg_6_1 then
					CommonTools.SetCommonData(arg_6_0.item, rewardToItemTemplate(arg_6_2))
				end

				arg_6_0.timer = nil
			end, 1, 1)

			arg_6_0.timer:Start()
			CommonTools.SetCommonData(arg_6_0.item, rewardToItemTemplate(arg_6_2.convert_from))
		end

		arg_6_0.switchController_:SetSelectedIndex(1)
	else
		CommonTools.SetCommonData(arg_6_0.item, rewardToItemTemplate(arg_6_2))
		arg_6_0.switchController_:SetSelectedIndex(1)
		arg_6_0.switchController_:SetSelectedIndex(0)
	end
end

function var_0_0.ShareStart(arg_8_0)
	local var_8_0 = arg_8_0.data_.id

	if ItemCfg[var_8_0].type == ItemConst.ITEM_TYPE.HERO then
		arg_8_0.switchController_:SetSelectedIndex(0)
	end
end

function var_0_0.ShareEnd(arg_9_0)
	local var_9_0 = arg_9_0.data_
	local var_9_1 = var_9_0.id

	if ItemCfg[var_9_1].type == ItemConst.ITEM_TYPE.HERO and var_9_0.convert then
		arg_9_0.switchController_:SetSelectedIndex(1)
	end
end

function var_0_0.Dispose(arg_10_0)
	manager.notify:RemoveListener(SHAER_DAW_TEN_TIMES_START, arg_10_0.shareStartHandler_)
	manager.notify:RemoveListener(SHAER_DAW_TEN_TIMES_END, arg_10_0.shareEndHandler_)

	arg_10_0.shareStartHandler_ = nil
	arg_10_0.shareEndHandler_ = nil

	if arg_10_0.item then
		arg_10_0.item:Dispose()

		arg_10_0.item = nil
	end

	if arg_10_0.timer then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.switchController_:SetSelectedIndex(0)
end

return var_0_0
