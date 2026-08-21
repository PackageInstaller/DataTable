local var_0_0 = class("NewServerMainPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.time = arg_1_0.bg:Find("time")
	arg_1_0.shopBtn = arg_1_0.bg:Find("btn_list/shop")
	arg_1_0.fightBtn = arg_1_0.bg:Find("btn_list/fight")
	arg_1_0.buildBtn = arg_1_0.bg:Find("btn_list/build")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.shopBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.NEW_SERVER_CARNIVAL, {
			page = NewServerCarnivalScene.SHOP_PAGE
		})

		return
	end)
	onButton(arg_2_0, arg_2_0.buildBtn, function()
		local var_4_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD)

		if var_4_0 and not var_4_0:isEnd() then
			arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
				page = BuildShipScene.PAGE_NEWSERVER
			})
		else
			arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT)
		end

		return
	end)
	onButton(arg_2_0, arg_2_0.fightBtn, function()
		arg_2_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end)
	arg_2_0:updateTime()

	return
end

function var_0_0.updateTime(arg_6_0)
	local var_6_0 = pg.TimeMgr.GetInstance()

	setText(arg_6_0.time, var_6_0:STimeDescS(arg_6_0.activity:getStartTime(), "%m.%d") .. " - " .. var_6_0:STimeDescS(arg_6_0.activity.stopTime, "%m.%d %H:%M"))

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	return
end

return var_0_0
