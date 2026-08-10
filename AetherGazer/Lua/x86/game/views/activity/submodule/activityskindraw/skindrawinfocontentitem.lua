local var_0_0 = class("SkinDrawInfoContentItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.item_ = {}
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.RefreshData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.data_ = arg_5_1
	arg_5_0.isLast_ = arg_5_3
	arg_5_0.activityID_ = arg_5_2
	arg_5_0.mainActivityID_ = ActivityCfg.get_id_list_by_sub_activity_list[arg_5_0.activityID_][1]
	arg_5_0.isOath_ = arg_5_4.isOath
	arg_5_0.checkPoolStage_ = arg_5_4.checkPoolStage
	arg_5_0.poolID_ = arg_5_4.poolID

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0:RefreshContent()
	arg_6_0:RefreshTitle()
	arg_6_0:RefreshPool()
end

function var_0_0.RefreshTitle(arg_7_0)
	SetActive(arg_7_0.UpGo_, false)
	arg_7_0:Show(true)

	arg_7_0.labelTxt_.text = GetI18NText(arg_7_0.data_.name)
	arg_7_0.tips01.text = ""
	arg_7_0.tips02.text = ""
end

function var_0_0.RefreshPool(arg_8_0)
	if arg_8_0.isOath_ then
		arg_8_0:RefreshOathPool()
	else
		arg_8_0:RefreshNormalPool()
	end
end

function var_0_0.GetSkinDrawPoolHasGift(arg_9_0)
	local var_9_0 = arg_9_0.data_.list[1]
	local var_9_1 = ActivityLimitedDrawPoolCfg[var_9_0]

	if var_9_1 and var_9_1.reward[1] then
		local var_9_2 = var_9_1.reward[1][1]

		if ActivitySkinDrawTools.GetIsSkinGift(var_9_2) then
			local var_9_3 = clone(arg_9_0.data_.list)

			table.remove(var_9_3, 1)

			return var_9_3, true
		else
			return arg_9_0.data_.list, false
		end
	end
end

function var_0_0.RefreshNormalPool(arg_10_0)
	local var_10_0, var_10_1 = arg_10_0:GetSkinDrawPoolHasGift()

	arg_10_0:RefreshGiftItem(var_10_1, ActivitySkinDrawTools.GetDrawGiftItem(arg_10_0.mainActivityID_))

	for iter_10_0 = 1, #var_10_0 do
		local var_10_2 = var_10_0[iter_10_0]
		local var_10_3 = ActivityLimitedDrawPoolCfg[var_10_2]
		local var_10_4 = ActivitySkinDrawData:GetDrawInfo(arg_10_0.activityID_, var_10_2)

		if not arg_10_0.item_[iter_10_0] then
			local var_10_5 = Object.Instantiate(arg_10_0.rewardItem_, arg_10_0.contentTrs_2)

			arg_10_0.item_[iter_10_0] = SkinDrawInfoItem.New(var_10_5)
		end

		local var_10_6 = var_10_3.total
		local var_10_7 = var_10_4 and var_10_4.num or var_10_6
		local var_10_8 = var_10_3.reward[1][1]
		local var_10_9 = var_10_3.reward[1][2]
		local var_10_10 = var_10_7 .. "/" .. var_10_6

		arg_10_0.item_[iter_10_0]:RefreshData(var_10_8, var_10_9, var_10_10)

		if arg_10_0.checkPoolStage_ then
			arg_10_0.item_[iter_10_0]:SetLock(var_10_3.pool_stage > arg_10_0.checkPoolStage_)
		end
	end

	for iter_10_1 = #var_10_0 + 1, #arg_10_0.item_ do
		arg_10_0.item_[iter_10_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.contentTrs_)
end

function var_0_0.GetOathRewardData(arg_11_0)
	local var_11_0, var_11_1 = ActivityOathDrawData:GetGiftID()
	local var_11_2 = arg_11_0.data_.list[1]

	if var_11_1 == var_11_2 then
		local var_11_3 = clone(arg_11_0.data_.list)

		table.remove(var_11_3, 1)

		return var_11_3, var_11_2
	else
		return arg_11_0.data_.list, nil
	end
end

function var_0_0.RefreshOathPool(arg_12_0)
	local var_12_0, var_12_1 = arg_12_0:GetOathRewardData()

	arg_12_0:RefreshGiftItem(var_12_1 ~= nil, OathDrawTools.GetDrawGiftItem(arg_12_0.mainActivityID_))

	for iter_12_0 = 1, #var_12_0 do
		local var_12_2 = var_12_0[iter_12_0]
		local var_12_3 = ActivityLimitedDrawPoolCfg[var_12_2]
		local var_12_4 = ActivityOathDrawData:GetDrawInfo(arg_12_0.activityID_, var_12_2)

		if not arg_12_0.item_[iter_12_0] then
			local var_12_5 = Object.Instantiate(arg_12_0.rewardItem_, arg_12_0.contentTrs_2)

			arg_12_0.item_[iter_12_0] = SkinDrawInfoItem.New(var_12_5)
		end

		local var_12_6 = var_12_3.total
		local var_12_7 = var_12_4 and var_12_4.num or var_12_6
		local var_12_8 = var_12_3.reward[1][1]
		local var_12_9 = var_12_3.reward[1][2]
		local var_12_10 = var_12_7 .. "/" .. var_12_6

		arg_12_0.item_[iter_12_0]:RefreshData(var_12_8, var_12_9, var_12_10)
	end

	for iter_12_1 = #var_12_0 + 1, #arg_12_0.item_ do
		arg_12_0.item_[iter_12_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.contentTrs_)
end

function var_0_0.RefreshGiftItem(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 then
		if not arg_13_0.giftItem or arg_13_0.giftItemPath_ ~= arg_13_2 then
			arg_13_0.giftItemPath_ = arg_13_2

			local var_13_0 = Object.Instantiate(Asset.Load(arg_13_2), arg_13_0.contentTrs_2)

			arg_13_0.giftItem = arg_13_0.isOath_ and ActivityOathGiftItem.New(var_13_0) or ActivitySkinDrawGiftItem.New(var_13_0)
		end

		if not arg_13_0.giftOccupyItem then
			local var_13_1 = Object.Instantiate(arg_13_0.rewardItem_, arg_13_0.contentTrs_2)

			arg_13_0.giftOccupyItem = SkinDrawInfoItem.New(var_13_1)
		end

		local var_13_2 = arg_13_0.data_.list[1]
		local var_13_3 = arg_13_0.isOath_ and ActivityOathDrawData:GetDrawInfo(arg_13_0.activityID_, var_13_2) or ActivitySkinDrawData:GetDrawInfo(arg_13_0.activityID_, var_13_2)
		local var_13_4 = ActivityLimitedDrawPoolCfg[var_13_2]
		local var_13_5 = (var_13_3 and var_13_3.num or var_13_4.total) .. "/" .. var_13_4.total

		if arg_13_0.isOath_ then
			arg_13_0.giftItem:SetData(var_13_2, arg_13_0.activityID_, var_13_5, arg_13_0.poolID_, true)
		else
			arg_13_0.giftItem:SetData(var_13_4.reward[1][1], var_13_4.reward[1][2], var_13_5, arg_13_0.poolID_)
		end

		arg_13_0.giftItem.transform_:SetAsFirstSibling()
		arg_13_0.giftItem:Show(true)
		arg_13_0.giftItem:SetInPopView(true)
		arg_13_0.giftOccupyItem.transform_:SetAsFirstSibling()
		arg_13_0.giftOccupyItem:RefreshOccupyData()
	else
		if arg_13_0.giftItem then
			arg_13_0.giftItem:Show(false)
			arg_13_0.giftItem:SetInPopView(false)
		end

		if arg_13_0.giftOccupyItem then
			arg_13_0.giftOccupyItem:Show(false)
		end
	end
end

function var_0_0.RefreshContent(arg_14_0)
	if arg_14_0.isLast_ then
		arg_14_0.contentTrs_2:GetComponent("GridLayoutGroup").padding.bottom = 20
	end
end

function var_0_0.Show(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
end

function var_0_0.OnExit(arg_16_0)
	for iter_16_0 = 1, #arg_16_0.item_ do
		arg_16_0.item_[iter_16_0]:OnExit()
	end

	if arg_16_0.giftItem then
		arg_16_0.giftItem:Show(false)
	end

	if arg_16_0.giftOccupyItem then
		arg_16_0.giftOccupyItem:Show(false)
	end
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()

	for iter_17_0 = 1, #arg_17_0.item_ do
		arg_17_0.item_[iter_17_0]:Dispose()
	end

	arg_17_0.giftItemPath_ = nil

	if arg_17_0.giftItem then
		arg_17_0.giftItem:Dispose()
	end

	if arg_17_0.giftOccupyItem then
		arg_17_0.giftOccupyItem:Dispose()
	end

	arg_17_0.super.Dispose(arg_17_0)
end

return var_0_0
