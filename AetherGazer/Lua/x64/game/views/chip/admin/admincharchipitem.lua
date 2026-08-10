AdminChipBaseItem = import("game.views.chip.Admin.AdminChipBaseItem")

local var_0_0 = class("AdminCharChipItem", AdminChipBaseItem)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockControl_ = arg_1_0.conEx_:GetController("lock")
	arg_1_0.selectControl_ = arg_1_0.conEx_:GetController("Select")
	arg_1_0.useControl_ = arg_1_0.conEx_:GetController("subscript")
	arg_1_0.starControl_ = arg_1_0.conEx_:GetController("star")
	arg_1_0.selected_ = false
	arg_1_0.skillItems_ = {}

	for iter_1_0 = 1, 3 do
		local var_1_0 = arg_1_0["skillGo" .. iter_1_0 .. "_"]

		if var_1_0 then
			arg_1_0.skillItems_[iter_1_0] = CharChipExtraItem.New(var_1_0.gameObject)
		end
	end
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.selectBtn_, nil, function()
		manager.notify:CallUpdateFunc("OnClickCharItem", arg_2_0, arg_2_0.charBaseID_)
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0.charBaseID_ = arg_4_1
	arg_4_0.index_ = arg_4_2
	arg_4_0.animInfo_ = arg_4_5
	arg_4_0.sectionProxy_ = arg_4_6

	arg_4_0:Show(true)
	arg_4_0:RefreshUI(arg_4_3, arg_4_4)
end

function var_0_0.GetItemHeight(arg_5_0)
	if arg_5_0.selected_ then
		return arg_5_0.posTrs_.sizeDelta.x + arg_5_0.descTrs_.sizeDelta.x
	else
		return arg_5_0.posTrs_.sizeDelta.x
	end
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.gameObject_.name = arg_6_0.charBaseID_

	local var_6_0 = ChipCfg[arg_6_0.charBaseID_]

	arg_6_0.charName_.text = var_6_0.suit_name
	arg_6_0.charImg_.spriteSync = ChipTools.GetCharChipIcon(arg_6_0.charBaseID_)

	local var_6_1 = arg_6_0:IsCharChipBaseUnlock(arg_6_0.charBaseID_)
	local var_6_2 = #arg_6_0:GetCharChipExtraIDListUnlock(arg_6_0.charBaseID_)

	if var_6_1 then
		var_6_2 = var_6_2 + 1
	end

	arg_6_0.selectControl_:SetSelectedState(arg_6_1 and "selected" or "unselected")

	if var_6_1 then
		local var_6_3 = ChipTools.GetNextCharChipIDToUnlock(arg_6_0.charBaseID_)

		if var_6_3 ~= 0 and arg_6_0:IsCharChipExtraCanUnlock(var_6_3) then
			arg_6_0.lockControl_:SetSelectedState("AffixUnlock")
		else
			arg_6_0.lockControl_:SetSelectedState("unlock")
		end
	elseif arg_6_0:IsCharChipBaseCanUnlock(arg_6_0.charBaseID_) then
		arg_6_0.lockControl_:SetSelectedState("RoleUnlock")
	else
		arg_6_0.lockControl_:SetSelectedState("locked")
	end

	arg_6_0.useControl_:SetSelectedState(arg_6_2 and "equiped" or "unequiped")
	arg_6_0.starControl_:SetSelectedState(tostring(var_6_2))

	arg_6_0.skillCanvasGroup_.blocksRaycasts = arg_6_1

	local var_6_4 = arg_6_1 and "RoleItem_expand" or "RoleItem_fold"

	arg_6_0:UpdateAnim(arg_6_1, var_6_4)

	arg_6_0.selected_ = arg_6_1

	local var_6_5 = ChipTools.GetCharChipExtraIDList(arg_6_0.charBaseID_)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.skillItems_) do
		if iter_6_0 == 1 then
			iter_6_1:SetData(arg_6_0.charBaseID_, nil, arg_6_0.sectionProxy_)
		else
			iter_6_1:SetData(var_6_5[iter_6_0 - 1], nil, arg_6_0.sectionProxy_)
		end
	end

	if arg_6_0:IsCharChipCanOperate() then
		arg_6_0:BindRedPoint()
	end
end

function var_0_0.IsCharChipCanOperate(arg_7_0)
	if arg_7_0.sectionProxy_ == nil then
		return true
	end

	return arg_7_0.sectionProxy_:IsCharChipCanOperate()
end

function var_0_0.IsCharChipBaseUnlock(arg_8_0, arg_8_1)
	if arg_8_0.sectionProxy_ == nil then
		return ChipTools.IsCharChipBaseUnlock(arg_8_1)
	end

	return arg_8_0.sectionProxy_:IsCharChipBaseUnlock(arg_8_1)
end

function var_0_0.GetCharChipExtraIDListUnlock(arg_9_0, arg_9_1)
	if arg_9_0.sectionProxy_ == nil then
		return ChipTools.GetCharChipExtraIDListUnlock(arg_9_1)
	end

	return arg_9_0.sectionProxy_:GetCharChipExtraIDListUnlock(arg_9_1)
end

function var_0_0.IsCharChipExtraCanUnlock(arg_10_0, arg_10_1)
	if arg_10_0.sectionProxy_ == nil then
		return ChipTools.IsCharChipExtraCanUnlock(arg_10_1)
	end

	return arg_10_0.sectionProxy_:IsCharChipExtraCanUnlock(arg_10_1)
end

function var_0_0.IsCharChipBaseCanUnlock(arg_11_0, arg_11_1)
	if arg_11_0.sectionProxy_ == nil then
		return ChipTools.IsCharChipBaseCanUnlock(arg_11_1)
	end

	return arg_11_0.sectionProxy_:IsCharChipBaseCanUnlock(arg_11_1)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.skillItems_) do
		iter_12_1:Dispose()
	end

	arg_12_0:UnbindRedPoint()
	Object.Destroy(arg_12_0.gameObject_)

	arg_12_0.gameObject_ = nil
	arg_12_0.transform_ = nil
end

function var_0_0.BindRedPoint(arg_13_0)
	manager.redPoint:bindUIandKey(arg_13_0.posTrs_, string.format("%s_%s", RedPointConst.CHIP_CHAR_CHIP, arg_13_0.charBaseID_))
end

function var_0_0.UnbindRedPoint(arg_14_0)
	manager.redPoint:unbindUIandKey(arg_14_0.posTrs_)
end

return var_0_0
