local var_0_0 = class("HoloLivePage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.listbtn = arg_1_0.bg:Find("list")
	arg_1_0.btnFubuki = arg_1_0.listbtn:Find("1")
	arg_1_0.btnBattle = arg_1_0.listbtn:Find("2")
	arg_1_0.btnSora = arg_1_0.listbtn:Find("3")
	arg_1_0.btnShion = arg_1_0.listbtn:Find("4")
	arg_1_0.btnMio = arg_1_0.listbtn:Find("5")
	arg_1_0.btnAqua = arg_1_0.listbtn:Find("6")
	arg_1_0.btnAyame = arg_1_0.listbtn:Find("7")
	arg_1_0.btnMatsuri = arg_1_0.listbtn:Find("8")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.btnFubuki, function()
		arg_2_0:emit(ActivityMediator.BATTLE_OPERA)

		return
	end)
	onButton(arg_2_0, arg_2_0.btnBattle, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	onButton(arg_2_0, arg_2_0.btnSora, function()
		arg_2_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.HOLOLIVE_MORNING_ID)

		return
	end)
	onButton(arg_2_0, arg_2_0.btnShion, function()
		arg_2_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.HOLOLIVE_PT_ID)

		return
	end)
	onButton(arg_2_0, arg_2_0.btnMio, function()
		arg_2_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.HOLOLIVE_MIO_ID)

		return
	end)
	onButton(arg_2_0, arg_2_0.btnAqua, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.HOLOLIVE_LINKLINK_SELECT_SCENE)

		return
	end)
	onButton(arg_2_0, arg_2_0.btnAyame, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.HOLOLIVE_MEDAL)

		return
	end)
	onButton(arg_2_0, arg_2_0.btnMatsuri, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)

	return
end

return var_0_0
