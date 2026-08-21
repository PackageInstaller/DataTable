local var_0_0 = class("HodurMainlineHeroModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.affixItemList_ = {}
	arg_2_0.isShow_ = false
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.heroBtn_, nil, function()
		local var_4_0 = HodurTools.GetAffix(arg_3_0.chapterID_)
		local var_4_1 = 0

		if (var_4_0 == nil and 0 or #var_4_0) == 0 then
			arg_3_0:ShowTips(false)

			return
		end

		arg_3_0:ShowTips(not arg_3_0.isShow_)
	end)
	arg_3_0:AddBtnListener(arg_3_0.bgBtn_, nil, function()
		if arg_3_0.isShow_ then
			arg_3_0:ShowTips(false)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.chapterID_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.ShowTips(arg_7_0, arg_7_1)
	arg_7_0.isShow_ = arg_7_1

	SetActive(arg_7_0.tipsGo_, arg_7_1)
	SetActive(arg_7_0.bgBtn_.gameObject, arg_7_1)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = HodurTools.GetAffix(arg_8_0.chapterID_)
	local var_8_1 = 0
	local var_8_2 = var_8_0 == nil and 0 or #var_8_0

	arg_8_0.affixNumText_.text = tostring(var_8_2)
	arg_8_0.affixPanelCanvasGroup_.alpha = 1

	if var_8_2 == 0 then
		arg_8_0.affixNumText_.text = ""
		arg_8_0.affixPanelCanvasGroup_.alpha = 0
	end

	for iter_8_0 = 1, #var_8_0 do
		local var_8_3 = var_8_0[iter_8_0]

		if not arg_8_0.affixItemList_[iter_8_0] then
			local var_8_4 = Object.Instantiate(arg_8_0.tipsItem_, arg_8_0.tipsContent_)

			arg_8_0.affixItemList_[iter_8_0] = HodurMainlineAffixItem.New(var_8_4)
		end

		arg_8_0.affixItemList_[iter_8_0]:SetData(var_8_3)
		arg_8_0.affixItemList_[iter_8_0]:SetActive(true)
	end

	for iter_8_1 = #var_8_0 + 1, #arg_8_0.affixItemList_ do
		arg_8_0.affixItemList_[iter_8_1]:SetActive(false)
	end

	local var_8_5 = HodurTools.GetMainlineHeroID(arg_8_0.chapterID_)
	local var_8_6, var_8_7 = HodurTools.GetChapterHeroHP(arg_8_0.chapterID_, var_8_5)

	if var_8_6 == -1 then
		arg_8_0.hpFillImg_.fillAmount = 1
		arg_8_0.hpText_.text = "100%"
	elseif var_8_7 == 0 then
		arg_8_0.hpFillImg_.fillAmount = 0
		arg_8_0.hpText_.text = "0%"
	else
		local var_8_8 = math.max(1, math.floor(var_8_6 / var_8_7 * 100))

		arg_8_0.hpFillImg_.fillAmount = var_8_6 / var_8_7

		if var_8_6 == 0 then
			var_8_8 = 0
		end

		arg_8_0.hpText_.text = string.format("%d%%", var_8_8)
	end
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.affixItemList_ do
		arg_9_0.affixItemList_[iter_9_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
