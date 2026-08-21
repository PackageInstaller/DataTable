StoreExpiredView = import("game.views.store.expired.StoreExpiredView")

local var_0_0 = class("FrameExpiredView", StoreExpiredView)

function var_0_0.indexItem(arg_1_0, arg_1_1, arg_1_2)
	arg_1_2:RefreshData({
		id = arg_1_0.params_.materialList[arg_1_1].id,
		number = arg_1_0.params_.materialList[arg_1_1].num,
		timeValid = arg_1_0.params_.materialList[arg_1_1].timeValid
	})
	arg_1_2:RegistCallBack(function(arg_2_0)
		ShowPopItem(POP_OTHER_ITEM, {
			arg_2_0.id,
			arg_2_0.number,
			0,
			arg_2_0.timeValid
		})
	end)
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = arg_4_0.params_.type
	local var_4_1 = arg_4_0.titleText1_
	local var_4_2 = arg_4_0.descText1_

	if #arg_4_0.getItemDataList_ > 0 then
		var_4_1 = arg_4_0.titleText2_
		var_4_2 = arg_4_0.descText2_
	end

	if var_4_0 == ItemConst.ITEM_TYPE.FRAME then
		var_4_1.text = GetTips("PROFILE_AVATAR_FRAME_OVERDUE_TITLE")
		var_4_2.text = GetTips("PROFILE_AVATAR_FRAME_OVERDUE_CONTENT")
	elseif var_4_0 == ItemConst.ITEM_TYPE.CARD_BG then
		var_4_1.text = GetTips("PROFILE_BUSINESS_CARD_OVERDUE_TITLE")
		var_4_2.text = GetTips("PROFILE_BUSINESS_CARD_OVERDUE_CONTENT")
	elseif var_4_0 == ItemConst.ITEM_TYPE.TAG then
		var_4_1.text = GetTips("PROFILE_LABEL_OVERDUE_TITLE")
		var_4_2.text = GetTips("PROFILE_LABEL_OVERDUE_CONTENT")
	end
end

return var_0_0
