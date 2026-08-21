local var_0_0 = class("Match3Page", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.goBtn = arg_1_0.bg:Find("go")
	arg_1_0.itemList = UIItemList.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.drop = arg_2_0.activity:getConfig("config_client").drop
	arg_2_0.id = arg_2_0.activity:getConfig("config_client").gameId
	arg_2_0.day = #arg_2_0.drop

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	setActive(arg_3_0.item, false)

	local var_3_0 = getProxy(MiniGameProxy):GetHubByHubId(arg_3_0.activity:getConfig("config_id"))

	setActive(arg_3_0.item, false)
	arg_3_0.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			updateDrop(arg_4_2:Find("item"), {
				type = arg_3_0.drop[arg_4_1 + 1][1],
				id = arg_3_0.drop[arg_4_1 + 1][2],
				count = arg_3_0.drop[arg_4_1 + 1][3]
			})
			onButton(arg_3_0, arg_4_2, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		elseif arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_4_2:Find("mask")

			setActive(arg_4_2:Find("got"), arg_4_1 < var_3_0.usedtime)
			setActive(var_4_0, arg_4_1 >= var_3_0.usedtime + var_3_0.count)
		end

		return
	end)
	arg_3_0.itemList:align(arg_3_0.day)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, arg_3_0.id)

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	arg_7_0.itemList:align(arg_7_0.day)

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
