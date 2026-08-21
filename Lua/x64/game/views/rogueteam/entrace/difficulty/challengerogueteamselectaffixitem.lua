local var_0_0 = class("ChallengeRogueTeamSelectAffixItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.itemList_ = {}

	for iter_1_0 = 1, 4 do
		local var_1_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_1_0, arg_1_0["affixItem_" .. iter_1_0])

		var_1_0.gameObject_ = arg_1_0["affixItem_" .. iter_1_0]
		var_1_0.index = iter_1_0
		var_1_0.selectController_ = var_1_0.controllerEx_:GetController("select")
		var_1_0.stateController_ = var_1_0.controllerEx_:GetController("state")

		var_1_0.selectController_:SetSelectedState("off")
		arg_1_0:AddBtnListener(var_1_0.btn_, nil, function()
			arg_1_0:OnClickAffix(var_1_0, iter_1_0)
		end)

		arg_1_0.itemList_[iter_1_0] = var_1_0
	end
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.selectBtn_, nil, function()
		if arg_3_0.selectCb_ then
			arg_3_0.selectCb_(arg_3_0.index_)
		end
	end)
end

function var_0_0.OnClickAffix(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.clickAffixCb_ then
		arg_5_0.clickAffixCb_(arg_5_0.info_.group, arg_5_0.info_.affixList[arg_5_2], arg_5_1)
	end

	if arg_5_0.selectedItem then
		arg_5_0.selectedItem.selectController_:SetSelectedState("off")

		if arg_5_0.selectedItem.index == arg_5_2 then
			arg_5_0.selectedItem = nil

			return
		end
	end

	arg_5_0.selectedItem = arg_5_1

	arg_5_0.selectedItem.selectController_:SetSelectedState("on")
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_0.info_ = arg_6_1
	arg_6_0.index_ = arg_6_2
	arg_6_0.selectCb_ = arg_6_4
	arg_6_0.clickAffixCb_ = arg_6_5
	arg_6_0.selectedItem = nil

	for iter_6_0 = 1, 4 do
		local var_6_0 = arg_6_0.info_.affixList[iter_6_0]

		if var_6_0 then
			local var_6_1 = arg_6_0.itemList_[iter_6_0]
			local var_6_2 = ActivityAffixPoolCfg[var_6_0]
			local var_6_3 = arg_6_3 and arg_6_3 == var_6_0

			var_6_1.iconImg_.sprite = getAffixSprite(var_6_2.affix)
			var_6_1.numText_.text = var_6_2.point

			var_6_1.stateController_:SetSelectedState(var_6_2.point > 0 and "red" or "blue")
			var_6_1.selectController_:SetSelectedState(var_6_3 and "on" or "off")

			if var_6_3 then
				arg_6_0.selectedItem = var_6_1
			end

			SetActive(var_6_1.gameObject_, true)
		else
			SetActive(arg_6_0.itemList_[iter_6_0].gameObject_, false)
		end
	end

	arg_6_0.nameText_.text = AffixTypeCfg[arg_6_0.info_.group].name
end

function var_0_0.GetGroup(arg_7_0)
	return arg_7_0.info_.group
end

function var_0_0.GetItemByAffixId(arg_8_0, arg_8_1)
	for iter_8_0 = 1, 4 do
		if arg_8_0.info_.affixList[iter_8_0] == arg_8_1 then
			return arg_8_0.itemList_[iter_8_0]
		end
	end

	return nil
end

function var_0_0.GetLocalPosition(arg_9_0)
	return arg_9_0.transform_.localPosition
end

function var_0_0.SetChildrenTransform(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0.childrenTf_.localPosition

	var_10_0.x = arg_10_1
	arg_10_0.childrenTf_.localPosition = var_10_0

	local var_10_1 = arg_10_0.childrenTf_.localEulerAngles

	var_10_1.x = arg_10_3
	arg_10_0.childrenTf_.localEulerAngles = var_10_1

	local var_10_2 = arg_10_0.childrenTf_.localScale

	var_10_2.x = arg_10_2
	var_10_2.y = arg_10_2
	arg_10_0.childrenTf_.localScale = var_10_2
end

return var_0_0
