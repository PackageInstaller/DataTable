local var_0_0 = class("IdolMedalCollectionView3", import(".IdolMedalCollectionView2"))

function var_0_0.GetContainerPositions(arg_1_0)
	return {
		0,
		100
	}
end

function var_0_0.GetActivityID(arg_2_0)
	return ActivityConst.MUSIC_FESTIVAL_MEDALCOLLECTION_3
end

function var_0_0.getUIName(arg_3_0)
	return "IdolMedalCollectionUI3"
end

function var_0_0.didEnter(arg_4_0)
	local var_4_0 = math.random()

	setActive(arg_4_0.bg:Find("1"), var_4_0 >= 0.5)
	setActive(arg_4_0.bg:Find("2"), var_4_0 < 0.5)
	var_0_0.super.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.idol3rd_collection.tip
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.IsShowMainTip(arg_6_0)
	return Activity.IsActivityReady(arg_6_0)
end

return var_0_0
