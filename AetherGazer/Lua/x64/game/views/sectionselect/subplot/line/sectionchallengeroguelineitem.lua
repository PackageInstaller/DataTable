local var_0_0 = class("SectionChallengeRogueLineItem", ReduxView)
local var_0_1 = 400

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.lineGo1_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.lineTf1_ = arg_1_0.lineGo1_:GetComponent("RectTransform")
	arg_1_0.straightLineImg_ = arg_1_0.lineGo1_:GetComponent(typeof(Image))
	arg_1_0.curveLineGo_ = arg_1_0.lineGo1_.transform:Find("curveline")
	arg_1_0.gameObject_ = arg_1_0.lineGo1_

	arg_1_0:BindCfgUI()

	arg_1_0.lockController_ = arg_1_0.controller_:GetController("unlock")
end

function var_0_0.RefreshUI(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:RefreshLine1(arg_2_1, arg_2_2)
end

function var_0_0.RefreshLine1(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_1
	local var_3_1 = math.abs(arg_3_2.x - arg_3_1.x)

	if var_3_1 < var_0_1 then
		var_3_0 = var_3_1
	end

	if math.abs(arg_3_1.y - arg_3_2.y) == 0 then
		arg_3_0.lineTf1_.localPosition = Vector3(arg_3_1.x + var_3_0 / 2, arg_3_1.y, 0)
		arg_3_0.lineTf1_.sizeDelta = Vector2(var_3_0, 10)
		arg_3_0.lineTf1_.localEulerAngles = Vector3(0, 0, 0)

		arg_3_0.lineTf1_:SetAsFirstSibling()

		arg_3_0.straightLineImg_.enabled = true

		SetActive(arg_3_0.curveLineGo_, false)
	elseif math.abs(arg_3_1.y) > math.abs(arg_3_2.y) then
		arg_3_0.lineTf1_.localPosition = Vector3(arg_3_1.x + var_3_0 / 2, 0, 0)
		arg_3_0.lineTf1_.sizeDelta = Vector2(var_3_0, 10)

		if arg_3_1.y > arg_3_2.y then
			arg_3_0.lineTf1_.localEulerAngles = Vector3(0, 180, 0)
		else
			arg_3_0.lineTf1_.localEulerAngles = Vector3(0, 0, 180)
		end

		arg_3_0.lineTf1_:SetAsFirstSibling()

		arg_3_0.straightLineImg_.enabled = false

		SetActive(arg_3_0.curveLineGo_, true)
	else
		arg_3_0.lineTf1_.localPosition = Vector3(arg_3_1.x + var_3_0 / 2, arg_3_1.y, 0)
		arg_3_0.lineTf1_.sizeDelta = Vector2(var_3_0, 10)

		local var_3_2 = arg_3_1.y - arg_3_2.y > 0 and 1 or 0

		arg_3_0.lineTf1_.localEulerAngles = Vector3(180 * var_3_2, 0, 0)

		arg_3_0.lineTf1_:SetAsFirstSibling()

		arg_3_0.straightLineImg_.enabled = false

		SetActive(arg_3_0.curveLineGo_, true)
	end
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.lineGo1_, arg_4_1)
end

function var_0_0.SetUnlockState(arg_5_0, arg_5_1)
	arg_5_0.lockController_:SetSelectedState(tostring(arg_5_1))
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	Object.Destroy(arg_6_0.lineGo1_)

	arg_6_0.lineTf1_ = nil
	arg_6_0.lineGo1_ = nil
end

return var_0_0
