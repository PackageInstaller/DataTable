local var_0_0 = class("SummerRaceTipsPropertyItemView", ReduxView)
local var_0_1 = {
	ROF = true,
	Skill = true,
	HP = true,
	ATK = true,
	Cost = true
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.typeController_ = arg_2_0.controllerEx_ and arg_2_0.controllerEx_:GetController("type") or nil
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		SetActive(arg_3_0.gameObject_, false)

		return
	end

	local var_3_0 = tostring(arg_3_1.type or "")

	if var_0_1[var_3_0] ~= true then
		error("[SummerRaceTipsPropertyItemView] unsupported property type: " .. var_3_0)
	end

	SetActive(arg_3_0.gameObject_, true)
	arg_3_0.typeController_:SetSelectedState(var_3_0)

	arg_3_0.text_num_.text = tostring(arg_3_1.value or "")

	local var_3_1 = tonumber(arg_3_1.currentValue) or 0
	local var_3_2 = tonumber(arg_3_1.maxValue) or 0

	if var_3_2 <= 0 then
		error("[SummerRaceTipsPropertyItemView] invalid max value for `" .. var_3_0 .. "`")
	end

	arg_3_0.lightImage_.fillAmount = Mathf.Clamp01(var_3_1 / var_3_2)
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.typeController_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
