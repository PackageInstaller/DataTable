class = var_0_10000

local var_0_0 = var_0_10000("GuildBossFormationShipCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._char = arg_1_1
	arg_1_0._go = arg_1_1:GetModel()
	tf = var_2

	local var_1_0 = var_2(arg_1_0._go)

	Vector2 = var_1_10003
	var_1_0.pivot = var_1_10003(0.5, 0)
	tf = var_1_0

	local var_1_1 = var_1_0(arg_1_0._go)

	Vector2 = var_3
	var_1_1.sizeDelta = var_3(200, 300)

	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.SetLocalScale

	Vector3 = var_5

	var_1_3(var_1_2, var_5(0.6, 0.6, 0.6))

	return
end

function var_0_0.RefreshPosition(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.soltIndex = arg_2_1

	if arg_2_2 then
		arg_2_0:UpdateLocalPosition()
	end

	return
end

function var_0_0.UpdateLocalPosition(arg_3_0)
	local var_3_0 = arg_3_0._go.transform.parent
	local var_3_1 = var_1.Find(var_3_0, arg_3_0.soltIndex).localPosition

	arg_3_0:SetLocalPosition(var_3_1)

	return
end

function var_0_0.SetLocalPosition(arg_4_0, arg_4_1)
	arg_4_0._go.transform.localPosition = arg_4_1

	return
end

function var_0_0.GetLocalPosition(arg_5_0)
	return arg_5_0._go.transform.localPosition
end

function var_0_0.GetSoltIndex(arg_6_0)
	return arg_6_0.soltIndex
end

function var_0_0.Update(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.shipId = arg_7_1.id
	arg_7_0.teamType = arg_7_1:getTeamType()

	arg_7_0:RefreshPosition(arg_7_2, true)

	return
end

function var_0_0.Dispose(arg_8_0)
	local var_8_0

	if arg_8_0._go then
		tf = var_8_0
		var_8_0 = var_8_0(arg_8_0._go)
		Vector2 = var_1_10002
		var_8_0.pivot = var_1_10002(0.5, 0.5)
	end

	ClearEventTrigger = var_8_0
	GetOrAddComponent = var_1_10003

	var_8_0(var_1_10003(arg_8_0._go, "EventTriggerListener"))

	if arg_8_0._char then
		local var_8_1 = arg_8_0._char

		var_1.Dispose(var_8_1)
	end

	return
end

return var_0_0
