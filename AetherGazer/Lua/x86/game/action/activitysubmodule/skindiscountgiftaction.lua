local var_0_0 = {}

manager.net:Bind(84311, function(arg_1_0)
	SkinDiscountGiftData:InitData(arg_1_0)
	var_0_0.RefresRedPointNewTag(arg_1_0.activity_id)
end)

function var_0_0.BuySkinDiscountGift(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	manager.net:SendWithLoadingNew(84312, {
		buy_id = arg_2_2,
		activity_id = arg_2_0,
		gift_id = arg_2_1
	}, 84313, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			SkinDiscountGiftData:AddUsedTimes(arg_2_1)
			getReward(mergeReward(arg_3_0.give_items))
			SkinDiscountGiftData:ClearGoodsIDList()
			arg_2_3()
		else
			ShowTips(arg_3_0.result)
		end
	end)
end

function var_0_0.DoReward(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		local var_4_2 = iter_4_1.skinGoodsID
		local var_4_3 = iter_4_1.sceneGoodsID

		if var_4_3 and iter_4_1.isSelectSceneID then
			table.insert(var_4_0, {
				goodId = var_4_2,
				dlcId = var_4_3
			})
		else
			table.insert(var_4_1, var_4_2)
		end
	end

	if #var_4_0 > 0 then
		var_0_0.DoSkinReward(var_4_1, 1, arg_4_1)
	else
		var_0_0.DoSkinReward(var_4_1, 1, arg_4_1)
	end
end

function var_0_0.DoSkinReward(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 > #arg_5_0 then
		arg_5_2()

		return
	end

	local var_5_0 = {
		doNextHandler = function()
			arg_5_1 = arg_5_1 + 1

			var_0_0.DoSkinReward(arg_5_0, arg_5_1, arg_5_2)
		end,
		itemList = {
			{
				num = 1,
				id = SkinDiscountGiftTools.GetItemIDByGoodsID(arg_5_0[arg_5_1])
			}
		},
		obtainsParams = {}
	}

	gameContext:Go("obtainView", var_5_0)
end

function var_0_0.DoNextReward(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 > #arg_7_0 then
		arg_7_2()

		return
	end

	local var_7_0 = arg_7_0[arg_7_1].skinGoodsID
	local var_7_1 = arg_7_0[arg_7_1].sceneGoodsID

	if var_7_1 and arg_7_0[arg_7_1].isSelectSceneID then
		JumpTools.OpenPageByJump("/skinDlcShow", {
			goodId = var_7_0,
			dlcId = var_7_1,
			callBack = function()
				arg_7_1 = arg_7_1 + 1

				var_0_0.DoNextReward(arg_7_0, arg_7_1, arg_7_2)
			end
		})
	else
		local var_7_2 = {
			doNextHandler = function()
				arg_7_1 = arg_7_1 + 1

				var_0_0.DoNextReward(arg_7_0, arg_7_1, arg_7_2)
			end,
			itemList = {
				{
					num = 1,
					id = SkinDiscountGiftTools.GetItemIDByGoodsID(var_7_0)
				}
			},
			obtainsParams = {}
		}

		gameContext:Go("obtainView", var_7_2)
	end
end

function var_0_0.GetSkinGiveBackList(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = getShopCfg(arg_10_0[1].buy_id)
	local var_10_2 = getShopCfg(arg_10_0[2].buy_id)
	local var_10_3
	local var_10_4

	if var_10_1.description then
		var_10_3 = RechargeShopDescriptionCfg[var_10_1.description]
	else
		var_10_3 = ItemCfg[var_10_1.give_id]
	end

	if var_10_2.description then
		var_10_4 = RechargeShopDescriptionCfg[var_10_2.description]
	else
		var_10_4 = ItemCfg[var_10_2.give_id]
	end

	local var_10_5 = var_10_3.param[1]
	local var_10_6 = {
		{
			var_10_5,
			1
		},
		{
			var_10_4.id,
			1
		}
	}

	if var_10_1.give_back_list and next(var_10_1.give_back_list) ~= nil then
		local var_10_7 = {}

		for iter_10_0, iter_10_1 in ipairs(var_10_1.give_back_list) do
			table.insert(var_10_7, {
				iter_10_1.id,
				iter_10_1.num
			})
		end

		table.insertto(var_10_6, var_10_7)
	end

	if var_10_2.give_back_list and next(var_10_2.give_back_list) ~= nil then
		local var_10_8 = {}

		for iter_10_2, iter_10_3 in ipairs(var_10_2.give_back_list) do
			table.insert(var_10_8, {
				iter_10_3.id,
				iter_10_3.num
			})
		end

		table.insertto(var_10_6, var_10_8)
	end

	local var_10_9 = formatRewardCfgList(var_10_6)

	return (mergeReward(var_10_9))
end

function var_0_0.InitRedPoint(arg_11_0)
	local var_11_0 = {
		string.format("%s_%s", RedPointConst.SKIN_DISCOUNT_GIFT_OPEN, arg_11_0)
	}

	for iter_11_0, iter_11_1 in ipairs(ActivityCfg[arg_11_0].sub_activity_list) do
		if ActivityCfg[iter_11_1].activity_template == ActivityTemplateConst.SKIN_DISCOUNT_GIFT_SIGN then
			local var_11_1 = string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, iter_11_1)

			table.insert(var_11_0, var_11_1)
		end
	end

	manager.redPoint:addGroup(RedPointConst.SKIN_DISCOUNT_GIFT, {
		string.format("%s_%s", RedPointConst.SKIN_DISCOUNT_GIFT, arg_11_0)
	})
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.SKIN_DISCOUNT_GIFT, arg_11_0), var_11_0)
	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_11_0), arg_11_0), {
		RedPointConst.SKIN_DISCOUNT_GIFT
	})
	var_0_0.RefresRedPointNewTag(arg_11_0)
end

function var_0_0.RefresRedPointNewTag(arg_12_0)
	local var_12_0 = SkinDiscountGiftTools.GetSignActivityID(arg_12_0)
	local var_12_1 = SkinDiscountGiftTools.GetSignState(var_12_0, 1)
	local var_12_2 = 1

	if var_12_1 and var_12_1 ~= ActivityConst.SIGN_STATE.NONE or not SkinDiscountGiftTools.HasGiftActivityID() then
		var_12_2 = 0
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_DISCOUNT_GIFT_OPEN, arg_12_0), var_12_2, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.ClearRedPointNewTag(arg_13_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_DISCOUNT_GIFT_OPEN, arg_13_0), 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.JumpToSkinDiscountGiftWindow(arg_14_0)
	local var_14_0 = SkinDiscountGiftTools.GetDiscountActivityID(arg_14_0)

	if var_14_0 then
		OperationRecorder.RecordButtonTouch({
			button_name = "homepage_banner_activity_" .. var_14_0
		})
		JumpTools.GoToSystem("/skinDiscountGiftMain", {
			activityID = var_14_0
		}, ViewConst.SYSTEM_ID.SKIN_DISCOUNT_GIFT)
	end
end

return var_0_0
