SevenDaySkinPage_4_0 = import("game.views.activity.sign.pages.SevenDaySkinPage_4_0")

local var_0_0 = class("SevenDaySkinPage_5_0", SevenDaySkinPage_4_0)

function var_0_0.RefreshView(arg_1_0)
	arg_1_0.changePage_ = SevenDaySkinData_New:GetDlcReward()
	arg_1_0.data_ = SevenDaySkinData_New:GetActivityData(arg_1_0.activityID_)

	local var_1_0 = arg_1_0.data_.gift_reward

	if arg_1_0.changePage_ then
		arg_1_0.pageCon_:SetSelectedIndex(0)
	else
		arg_1_0.pageCon_:SetSelectedIndex(var_1_0 == 0 and 1 or 0)
	end

	arg_1_0.freeCon_:SetSelectedIndex(var_1_0 == 0 and 1 or 0)

	local var_1_1 = ActivityCumulativeSignCfg[arg_1_0.activityID_].gift_item_list[1]

	if not arg_1_0.itemData_ then
		arg_1_0.itemData_ = clone(ItemTemplateData)

		function arg_1_0.itemData_.clickFun(arg_2_0)
			ShowPopItem(POP_ITEM, {
				arg_2_0.id
			})
		end
	end

	arg_1_0.itemData_.id = var_1_1[1]
	arg_1_0.itemData_.number = var_1_1[2]

	arg_1_0.freeItemGo_:SetData(arg_1_0.itemData_)

	local var_1_2 = ItemCfg[arg_1_0.itemData_.id]

	arg_1_0.sItemNameTxt_.text = var_1_2.name
	arg_1_0.descText_.text = GetTips("ACTIVITY_4_0_SIGN_DESC")

	local var_1_3 = ActivityCfg[arg_1_0.activityID_]
	local var_1_4 = ActivityToggleCfg.get_id_list_by_activity_id[arg_1_0.activityID_][1]

	arg_1_0.titleTxt_.text = GetI18NText(ActivityToggleCfg[var_1_4].name)
	arg_1_0.leftTxt_.text = GetTips("SEVENDAY_SKIN_OPTIONAL_HERO")
	arg_1_0.rightTxt_.text = GetTips("SEVENDAY_SKIN_WELFARE_SIGNIN")

	arg_1_0:RefreshItems()
end

return var_0_0
