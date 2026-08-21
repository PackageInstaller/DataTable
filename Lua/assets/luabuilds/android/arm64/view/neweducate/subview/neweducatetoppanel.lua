local var_0_0 = class("NewEducateTopPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateTopPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.animCom = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.progressPart = NewEducateTopProgress.New(arg_2_0._tf:Find("progress"), arg_2_0)
	arg_2_0.resPart = NewEducateTopRes.New(arg_2_0._tf:Find("res"), arg_2_0)

	arg_2_0.resPart:SetBgEnable(not arg_2_0.contextData.hideBlurBg)

	arg_2_0.toolbarTF = arg_2_0._tf:Find("toolbar")

	setActive(arg_2_0.toolbarTF:Find("btns/home"), not arg_2_0.contextData.hideHome)
	setActive(arg_2_0.toolbarTF:Find("btns/help/line"), not arg_2_0.contextData.hideHome)

	local var_2_0 = pg.gameset.child2_rank_switch.key_value == 1 and arg_2_0.contextData.char:GetPermanentData():IsTarotType()

	setActive(arg_2_0.toolbarTF:Find("btns/rank"), var_2_0)
	setAnchoredPosition(arg_2_0.resPart._tf, {
		x = var_2_0 and -697 or -565
	})

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.toolbarTF:Find("btns/rank"), function()
		arg_3_0:emit(NewEducateBaseUI.GO_SUBLAYER, Context.New({
			mediator = NewEducateRankMediator,
			viewComponent = NewEducateRankLayer
		}))

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.toolbarTF:Find("btns/collect"), function()
		arg_3_0:emit(NewEducateBaseUI.GO_SUBLAYER, Context.New({
			mediator = NewEducateCollectEntranceMediator,
			viewComponent = NewEducateCollectEntranceLayer,
			data = {
				id = arg_3_0.contextData.char.id
			}
		}))

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.toolbarTF:Find("btns/refresh"), function()
		arg_3_0:emit(NewEducateBaseUI.ON_BOX, {
			content = i18n("child_refresh_sure_tip"),
			onYes = function()
				pg.m02:sendNotification(GAME.NEW_EDUCATE_REFRESH, {
					id = arg_3_0.contextData.char.id,
					difficulty = arg_3_0.contextData.char.difficulty
				})

				return
			end
		})

		return
	end, SFX_PANEL)

	var_0_0.helps = {
		"child2_main_help",
		"child2_explorer_main_help"
	}

	onButton(arg_3_0, arg_3_0.toolbarTF:Find("btns/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n(var_0_0.helps[arg_3_0.contextData.char.id])
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.toolbarTF:Find("btns/home"), function()
		NewEducateHelper.TrackExitTime()
		arg_3_0:emit(NewEducateBaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	arg_3_0:OverlayPanel(arg_3_0._tf, {
		pbList = {
			arg_3_0.resPart._tf
		}
	})
	arg_3_0:Flush()

	return
end

function var_0_0.Flush(arg_10_0)
	arg_10_0.progressPart:Update(arg_10_0.contextData.char)
	arg_10_0.resPart:Update(arg_10_0.contextData.char)

	return
end

function var_0_0.FlushRes(arg_11_0)
	arg_11_0.resPart:Update(arg_11_0.contextData.char)

	return
end

function var_0_0.FlushProgress(arg_12_0, arg_12_1)
	arg_12_0.progressPart:Update(arg_12_0.contextData.char, arg_12_1)

	return
end

function var_0_0.PlayShow(arg_13_0)
	arg_13_0.animCom:Play("anim_educate_topui_show")

	return
end

function var_0_0.PlayHide(arg_14_0)
	arg_14_0.animCom:Play("anim_educate_topui_hide")

	return
end

function var_0_0.OnDestroy(arg_15_0)
	arg_15_0.progressPart:Dispose()
	arg_15_0.resPart:Dispose()
	arg_15_0:UnOverlayPanel(arg_15_0._tf)

	return
end

return var_0_0
