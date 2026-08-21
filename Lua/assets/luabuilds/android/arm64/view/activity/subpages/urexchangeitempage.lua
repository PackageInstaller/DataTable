local var_0_0 = class("UrExchangeItemPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.exchangeBtn = arg_1_0._tf:Find("AD/exchange")
	arg_1_0.exchangeTip = arg_1_0._tf:Find("AD/exchange/tip")
	arg_1_0.battleBtn = arg_1_0._tf:Find("AD/battle")
	arg_1_0.taskBtn = arg_1_0._tf:Find("AD/task")
	arg_1_0.progress = arg_1_0._tf:Find("AD/progress/Image")
	arg_1_0.progressTxt = arg_1_0._tf:Find("AD/Text"):GetComponent(typeof(Text))
	arg_1_0.itemTF = arg_1_0._tf:Find("AD/item")
	arg_1_0.helpBtn = arg_1_0._tf:Find("AD/help")
	arg_1_0.moreBtn = arg_1_0._tf:Find("AD/more")

	onButton(arg_1_0, arg_1_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ur_exchange_help_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.moreBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ur_exchange_help_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.exchangeBtn, function()
		local var_4_0, var_4_1 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "FragmentShop")

		if not var_4_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_4_1)

			return
		end

		arg_1_0:emit(ActivityMediator.GO_SHOPS_LAYER_STEEET, {
			warp = NewShopsScene.TYPE_FRAGMENT
		})

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.taskBtn, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnFirstFlush(arg_7_0)
	local var_7_0 = getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])

	arg_7_0.progressTxt.text = var_7_0 .. "/" .. pg.gameset.urpt_chapter_max.description[2]

	setFillAmount(arg_7_0.progress, var_7_0 / pg.gameset.urpt_chapter_max.description[2])
	updateDrop(arg_7_0.itemTF, Drop.New({
		count = 0,
		type = DROP_TYPE_ITEM,
		id = pg.gameset.urpt_chapter_max.description[1]
	}))
	setActive(arg_7_0.exchangeTip, NotifyTipHelper.ShouldShowUrTip())

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	return
end

function var_0_0.OnDestroy(arg_9_0)
	return
end

return var_0_0
