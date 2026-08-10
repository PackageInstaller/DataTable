local var_0_0 = class("PopItemOperateView", import("game.views.pop.sourcePop.PopItemSourceView"))
local var_0_1 = GameSetting.vitality_exchange_id_list.value

function var_0_0.CustomInitUI(arg_1_0)
	var_0_0.super.CustomInitUI(arg_1_0)
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)
	arg_2_0:RefreshUI()

	arg_2_0[ON_TRY_TO_USE_ITEM] = arg_2_0.UseItemFun
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0[ON_TRY_TO_USE_ITEM] = nil

	var_0_0.super.OnExit(arg_3_0)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	arg_4_0.addBtn_ = nil
	arg_4_0.delBtn_ = nil
	arg_4_0.materialCntText_ = nil
	arg_4_0.useNumSlider_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	var_0_0.super.AddListeners(arg_5_0)
end

function var_0_0.RemoveListeners(arg_6_0)
	var_0_0.super.RemoveListeners(arg_6_0)
end

function var_0_0.AddVitalityCnt(arg_7_0, arg_7_1)
	local var_7_0 = ItemCfg[arg_7_1]

	if var_7_0.sub_type == 401 or var_7_0.sub_type == 403 then
		return var_7_0.param[1][2]
	end

	return false
end

function var_0_0.UseItemFun(arg_8_0, arg_8_1, arg_8_2)
	if isSuccess(arg_8_1.result) then
		local var_8_0 = arg_8_0:GetItemID()
		local var_8_1 = arg_8_0:GetItemTimeValid()
		local var_8_2 = ItemTools.getItemNum(var_8_0, var_8_1)

		if var_8_2 <= 0 then
			arg_8_0:Back()
		else
			arg_8_0:RefreshUI()
			arg_8_0:RefreshCount()
			arg_8_0:SetCommonItem(var_8_2)
		end

		local var_8_3 = arg_8_1.drop_list
		local var_8_4 = arg_8_2.use_item_list[1].item_info.id

		if ItemCfg[var_8_4].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
			local var_8_5 = ItemCfg[var_8_4].param[1]
			local var_8_6 = SkinCfg[var_8_5].hero

			getReward(formatRewardCfgList({
				{
					var_8_5,
					1
				}
			}))
		elseif ItemCfg[var_8_4].sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM then
			local var_8_7 = BirthdayCfg[BirthdayCfg.get_id_list_by_commemorative_props_id[var_8_4][1]].story_id

			manager.story:StartStory(var_8_7)
		elseif ItemCfg[var_8_4].sub_type == ItemConst.ITEM_SUB_TYPE.BITRHDAY_LETTER then
			local var_8_8 = BirthdayCfg[BirthdayCfg.get_id_list_by_appendix_id[var_8_4][1]].story_id

			manager.story:StartStory(var_8_8)
			IllustratedData:ModifyPlot(var_8_8)
			getReward(var_8_3)
			SDKTools.SendMessageToSDK("birthday_received", {
				story_unlock = 1
			})
		elseif ItemCfg[var_8_4].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			ShowTips("EXCHANGE_SUCCESS")
		elseif ItemCfg[var_8_4].sub_type == ItemConst.ITEM_SUB_TYPE.MOON_CAKE_GIFT then
			getReward(var_8_3)

			local var_8_9 = ItemCfg[var_8_4].time[2][1]

			MoonCakeAction.OnOpenGift(var_8_9, arg_8_1.drop_list)
		else
			getReward(var_8_3)
		end

		manager.notify:CallUpdateFunc(NOTIFY_FOR_BAG_REFRESH_BUG)
	else
		ShowTips(arg_8_1.result)
	end
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0:GetItemID()

	arg_9_0.useNumSlider_.minValue = 0
	arg_9_0.useNumSlider_.maxValue = arg_9_0:GetMaxNum()
	arg_9_0.useNumSlider_.value = 1

	local var_9_1 = ItemCfg[var_9_0]

	if var_9_1.sub_type == ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE then
		SetActive(arg_9_0.operatePanel_, false)
	else
		local var_9_2 = var_9_1 and (var_9_1.use == 1 or var_9_1.use == 2) and MaterialConst.MATERIAL_TYPE.MYTHIC_REFRESH ~= var_9_1.sub_type

		SetActive(arg_9_0.operatePanel_, var_9_2)
	end

	if var_9_1.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or var_9_1.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE or var_9_1.type == ItemConst.ITEM_TYPE.GIFT and var_9_1.sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
		SetActive(arg_9_0.operateInfoGo_, false)
	else
		SetActive(arg_9_0.operateInfoGo_, true)
	end
end

function var_0_0.GetMaxNum(arg_10_0)
	local var_10_0 = arg_10_0:GetItemID()
	local var_10_1 = arg_10_0.itemInfo_.timeValid
	local var_10_2 = ItemCfg[var_10_0]

	if var_10_2.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or var_10_2.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE then
		return 1
	end

	local var_10_3 = ItemTools.getItemNum(var_10_0, var_10_1)

	if var_10_2.type == ItemConst.ITEM_TYPE.PROPS and (ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY == var_10_2.sub_type or ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID == var_10_2.sub_type) then
		local var_10_4 = var_10_2.param[1][2]
		local var_10_5 = math.floor((999 - ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)) / var_10_4)
		local var_10_6 = math.min(var_10_5, var_10_3)

		return (math.max(var_10_6, 1))
	end

	return var_10_3
end

function var_0_0.UpdateCount(arg_11_0)
	if arg_11_0.useNumSlider_.value < 1 then
		arg_11_0.useNumSlider_.value = 1
	end

	local var_11_0 = arg_11_0.useNumSlider_.value

	arg_11_0.materialCntText_.text = var_11_0
	arg_11_0.delBtn_.interactable = var_11_0 > 1

	local var_11_1 = arg_11_0:GetItemID()
	local var_11_2 = arg_11_0.useNumSlider_.value
	local var_11_3 = arg_11_0:GetMaxNum()

	arg_11_0.addBtn_.interactable = var_11_2 < var_11_3
end

return var_0_0
