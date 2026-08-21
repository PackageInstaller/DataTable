local var_0_0 = class("DrawInfoMessageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.items = {}
end

function var_0_0.RefreshData(arg_2_0, arg_2_1)
	SetActive(arg_2_0.UpGo_, true)
	arg_2_0:Show(true)

	arg_2_0.labelTxt_.text = GetI18NText(arg_2_1.name)
	arg_2_0.tips01.text = GetI18NText(arg_2_1.probability)
	arg_2_0.tips02.text = ""

	if arg_2_1.probability2 then
		arg_2_0.tips02.text = GetI18NText(arg_2_1.probability2)
	end

	if arg_2_1.s_all_hero then
		if arg_2_1.s_up_probability then
			local var_2_0 = arg_2_1.s_up_probability .. "%"

			arg_2_0.infoTxt_.text = string.format(GetTips("DRAW_POOL_UP_1"), var_2_0)
		end

		arg_2_0:RefreshItem(arg_2_1.s_all_hero, true, arg_2_1.s_up_hero)
	end

	if arg_2_1.a_all_hero then
		if arg_2_1.a_up_probability then
			local var_2_1 = arg_2_1.a_up_probability .. "%"

			arg_2_0.infoTxt_.text = string.format(GetTips("DRAW_POOL_UP_2"), var_2_1)
		end

		if not arg_2_1.a_up_hero or not (#arg_2_1.a_up_hero > 0) then
			SetActive(arg_2_0.UpGo_, false)
		end

		arg_2_0:RefreshItem(arg_2_1.a_all_hero, true, arg_2_1.a_up_hero)
	end

	if arg_2_1.b_hero then
		SetActive(arg_2_0.UpGo_, false)
		arg_2_0:RefreshItem(arg_2_1.b_hero, true)
	end

	if arg_2_1.s_all_servant then
		SetActive(arg_2_0.UpGo_, false)
		arg_2_0:RefreshItem(arg_2_1.s_all_servant, false, arg_2_1.s_up_servant)
	end

	if arg_2_1.a_all_servant then
		SetActive(arg_2_0.UpGo_, false)
		arg_2_0:RefreshItem(arg_2_1.a_all_servant, false, arg_2_1.a_up_servant)
	end

	if arg_2_1.b_servant then
		SetActive(arg_2_0.UpGo_, false)
		arg_2_0:RefreshItem(arg_2_1.b_servant, false)
	end
end

function var_0_0.RefreshItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = #arg_3_1

	for iter_3_0 = 1, var_3_0 do
		if not arg_3_0.items[iter_3_0] then
			local var_3_1 = Object.Instantiate(arg_3_0.infoItem_, arg_3_0.contentTrs_)

			arg_3_0.items[iter_3_0] = DrawInfoCommonItem.New(var_3_1)
		end

		local var_3_2 = arg_3_1[iter_3_0]

		arg_3_0.items[iter_3_0]:RefreshData(var_3_2, arg_3_2)
		arg_3_0.items[iter_3_0]:RefreshUp(arg_3_3, arg_3_2)
	end

	for iter_3_1 = var_3_0 + 1, #arg_3_0.items do
		arg_3_0.items[iter_3_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.contentTrs_)
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	if arg_5_0.items then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.items) do
			iter_5_1:Dispose()
			Object.Destroy(arg_5_0.items[iter_5_0].gameObject_)
		end

		arg_5_0.items = nil
	end

	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil
end

return var_0_0
