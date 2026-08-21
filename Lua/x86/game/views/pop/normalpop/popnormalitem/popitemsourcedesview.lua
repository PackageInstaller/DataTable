local var_0_0 = class("PopItemSourceDesView", import("game.views.pop.PopItemView"))
local var_0_1 = import("game.tools.ItemTools")

function var_0_0.CustomInitUI(arg_1_0)
	arg_1_0.soureceDesControllerController:SetSelectedState("show")
	arg_1_0.tabControllerController:SetSelectedState("descripe")
	arg_1_0.btnShowControllerController:SetSelectedState("hide")
end

function var_0_0.RefreshContent(arg_2_0)
	local var_2_0 = arg_2_0.itemInfo_
	local var_2_1 = ItemCfg[var_2_0.id]

	arg_2_0.nameText_.text = var_0_1.getItemName(var_2_1.id)
	arg_2_0.countentText_.text = var_0_1.getItemDesc(var_2_1.id)

	if var_2_1.time == nil or var_2_1.time == "" then
		arg_2_0.timeController:SetSelectedState("no")
	else
		local var_2_2 = var_0_1.GetItemExpiredTimeByInfo(var_2_0)

		if var_2_2 <= manager.time:GetServerTime() then
			arg_2_0.timeController:SetSelectedState("no")
		else
			arg_2_0.timeController:SetSelectedState("yes")

			arg_2_0.timeLabel_.text = string.format(GetTips("TIME_DISPLAY_12"), manager.time:STimeDescS(var_2_2, "!%Y/%m/%d %H:%M"))
		end
	end

	if var_2_1.type == ItemConst.ITEM_TYPE.STICKER then
		if arg_2_0.extraInfo_.isForeign then
			SetActive(arg_2_0.isLockGo_, false)
		else
			local var_2_3 = PlayerData:GetSticker(var_2_1.id).lock

			SetActive(arg_2_0.isLockGo_, var_2_3)
		end
	else
		SetActive(arg_2_0.isLockGo_, false)
	end

	arg_2_0.sourceDesTxt_.text = GetI18NText(var_2_1.desc_source) or ""
end

return var_0_0
