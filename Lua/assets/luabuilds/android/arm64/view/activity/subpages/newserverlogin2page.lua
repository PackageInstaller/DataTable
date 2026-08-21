local var_0_0 = class("NewServerLogin2Page", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("scrollrect/items")
	arg_1_0.itemList = UIItemList.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.config = pg.activity_7_day_sign[arg_2_0.activity:getConfig("config_id")]
	arg_2_0.Day = #arg_2_0.config.front_drops

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	setActive(arg_3_0.item, false)
	arg_3_0.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			updateDrop(arg_4_2:Find("item"), {
				type = arg_3_0.config.front_drops[arg_4_1 + 1][1],
				id = arg_3_0.config.front_drops[arg_4_1 + 1][2],
				count = arg_3_0.config.front_drops[arg_4_1 + 1][3]
			})
			onButton(arg_3_0, arg_4_2, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			GetImageSpriteFromAtlasAsync("ui/activityuipage/newserverlogin2page_atlas", arg_4_1 + 1, arg_4_2:Find("day"), true)
		elseif arg_4_0 == UIItemList.EventUpdate then
			setActive(arg_4_2:Find("got"), arg_4_1 < arg_3_0.nday)
		end

		return
	end)
	onButton(arg_3_0, arg_3_0.bg:Find("go_btn"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	arg_7_0.nday = arg_7_0.activity.data1

	arg_7_0.itemList:align(arg_7_0.Day)
	setLocalPosition(arg_7_0.items, Vector2(-185 - 106 * (arg_7_0.nday - 1), 0))

	return
end

function var_0_0.OnDestroy(arg_8_0)
	clearImageSprite(arg_8_0.bg)
	removeAllChildren(arg_8_0.items)

	return
end

return var_0_0
