local var_0_0 = class("HodurChallengeAffixModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectedAffixList_ = {}
	arg_2_0.itemList_ = {}
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.chapterID_ = arg_4_1

	local var_4_0 = ActivityHodurChapterCfg[arg_4_1]

	for iter_4_0, iter_4_1 in ipairs(var_4_0.affix) do
		local var_4_1 = arg_4_0.itemList_[iter_4_0]

		if not var_4_1 then
			var_4_1 = HodurChallengeSelectAffixItem.New(Object.Instantiate(arg_4_0.affixGo_, arg_4_0.affixContentTrs_))
			arg_4_0.itemList_[iter_4_0] = var_4_1
		end

		var_4_1:SetData(iter_4_1)
		var_4_1:SetActive(true)
		var_4_1:SetClickHandler(function(arg_5_0)
			arg_4_0:OnClickAffixItem(arg_5_0, var_4_1)
		end)
	end

	for iter_4_2 = #var_4_0.affix + 1, #arg_4_0.itemList_ do
		arg_4_0.itemList_[iter_4_2]:SetActive(false)
	end

	for iter_4_3, iter_4_4 in ipairs(arg_4_0.itemList_) do
		local var_4_2 = false

		for iter_4_5, iter_4_6 in ipairs(arg_4_0.selectedAffixList_) do
			if iter_4_6 == iter_4_4.affixID_ then
				var_4_2 = true

				break
			end
		end

		iter_4_4:SetSelected(var_4_2)
	end
end

function var_0_0.SetSelectedAffix(arg_6_0, arg_6_1)
	arg_6_0.selectedAffixList_ = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList_) do
		local var_6_0 = false

		for iter_6_2, iter_6_3 in ipairs(arg_6_1) do
			if iter_6_3 == iter_6_1.affixID_ then
				table.insert(arg_6_0.selectedAffixList_, iter_6_3)

				var_6_0 = true

				break
			end
		end

		iter_6_1:SetSelected(var_6_0)
	end
end

function var_0_0.OnClickAffixItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2.selected_ then
		arg_7_0:ShowTips(false)

		for iter_7_0, iter_7_1 in ipairs(arg_7_0.selectedAffixList_) do
			if iter_7_1 == arg_7_1 then
				table.remove(arg_7_0.selectedAffixList_, iter_7_0)

				break
			end
		end

		arg_7_2:SetSelected(false)
	else
		table.insert(arg_7_0.selectedAffixList_, arg_7_1)
		arg_7_2:SetSelected(true)
		arg_7_0:ShowTips(true, arg_7_1)
	end
end

function var_0_0.GetSelectedAffix(arg_8_0)
	return arg_8_0.selectedAffixList_
end

function var_0_0.ShowTips(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.showTips_ = arg_9_1

	SetActive(arg_9_0.tipsGo_, arg_9_1)

	if arg_9_1 then
		arg_9_0.tipsNameText_.text = AffixTypeCfg[arg_9_2].name
		arg_9_0.tipsDescText_.text = DescriptionCfg[AffixTypeCfg[arg_9_2].description[1]].description

		local var_9_0 = PublicBuffCfg[arg_9_2]

		if var_9_0 then
			local var_9_1 = ActivityAffixPoolCfg[var_9_0.buff_class_id]

			arg_9_0.tipsNumText_.text = var_9_1.point .. "%"
		end
	end
end

function var_0_0.Clear(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.itemList_) do
		iter_11_1:Dispose()
	end

	var_0_0.super.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
end

return var_0_0
