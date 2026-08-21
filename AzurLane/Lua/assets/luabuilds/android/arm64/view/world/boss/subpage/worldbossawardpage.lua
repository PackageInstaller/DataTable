local var_0_0 = class("WorldBossAwardPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "WorldBossAwardUI"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf:Find("frame/list/container1/tpl")

	arg_3_0.uilist1 = UIItemList.New(arg_3_0._tf:Find("frame/list/container1"), var_3_0)
	arg_3_0.uilist2 = UIItemList.New(arg_3_0._tf:Find("frame/list/container2"), var_3_0)

	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Update(arg_5_0, arg_5_1)
	arg_5_0.worldBoss = arg_5_1

	arg_5_0:UpdateAwards()
	arg_5_0:Show()

	return
end

function var_0_0.UpdateAwards(arg_6_0)
	local var_6_0 = arg_6_0.worldBoss:GetAwards()

	local function var_6_1(arg_7_0, arg_7_1)
		local var_7_0 = {
			count = 0,
			type = var_6_0[arg_7_0 + 1][1],
			id = var_6_0[arg_7_0 + 1][2]
		}

		updateDrop(arg_7_1:Find("equipment/bg"), {
			count = 0,
			type = var_6_0[arg_7_0 + 1][1],
			id = var_6_0[arg_7_0 + 1][2]
		})
		arg_7_1:Find("mask/name"):GetComponent("ScrollText"):SetText((({
			count = 0,
			type = var_6_0[arg_7_0 + 1][1],
			id = var_6_0[arg_7_0 + 1][2]
		}):getConfig("name")))
		onButton(arg_6_0, arg_7_1, function()
			arg_6_0:emit(BaseUI.ON_DROP, var_7_0)

			return
		end, SFX_PANEL)

		return
	end

	arg_6_0.uilist1:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			var_6_1(arg_9_1, arg_9_2)
		end

		return
	end)
	arg_6_0.uilist2:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			var_6_1(arg_10_1 + 4, arg_10_2)
		end

		return
	end)
	arg_6_0.uilist1:align(math.min(#var_6_0, 4))
	arg_6_0.uilist2:align(math.max(0, #var_6_0 - 4))

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
