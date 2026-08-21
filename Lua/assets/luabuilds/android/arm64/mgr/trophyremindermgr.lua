pg = pg or {}

local var_0_0 = pg

pg.TrophyReminderMgr = singletonClass("TrophyReminderMgr")

function pg.TrophyReminderMgr.Ctor(arg_1_0)
	arg_1_0._go = nil

	return
end

function pg.TrophyReminderMgr.Init(arg_2_0, arg_2_1)
	print("initializing tip manager...")

	arg_2_0._count = 0
	arg_2_0._tipTable = {}

	PoolMgr.GetInstance():GetUI("TrophyRemindPanel", true, function(arg_3_0)
		arg_2_0._go = arg_3_0

		arg_2_0._go:SetActive(false)
		arg_2_0._go.transform:SetParent(GameObject.Find("Overlay/UIOverlay").transform, false)

		arg_2_0._tips = arg_2_0._go.transform:Find("trophyRemind")
		arg_2_0._grid = arg_2_0._go.transform:Find("Grid_trophy")

		arg_2_1()

		return
	end)

	return
end

function pg.TrophyReminderMgr.ShowTips(arg_4_0, arg_4_1)
	var_0_0.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_TIP)
	arg_4_0._go.transform:SetAsLastSibling()
	SetActive(arg_4_0._go, true)

	arg_4_0._count = arg_4_0._count + 1

	local var_4_0 = cloneTplTo(arg_4_0._tips, arg_4_0._grid)

	LoadImageSpriteAsync("medal/s_" .. var_0_0.medal_template[arg_4_1].icon, var_4_0.transform:Find("content/icon"), true)
	setText(var_4_0.transform:Find("content/name"), var_0_0.medal_template[arg_4_1].name)
	setText(var_4_0.transform:Find("content/label"), i18n("trophy_achieved"))

	local var_4_1 = var_4_0.transform:Find("content")

	var_4_0.transform:Find("content").localPosition = Vector3(-850, 0, 0)

	;(function(arg_5_0)
		LeanTween.moveX(rtf(var_4_1), -275, 0.5)
		LeanTween.moveX(rtf(var_4_1), -850, 0.5):setDelay(5):setOnComplete(System.Action(function()
			Destroy(arg_5_0)

			arg_4_0._count = arg_4_0._count - 1

			if arg_4_0._count == 0 then
				SetActive(arg_4_0._go, false)
			end

			return
		end))

		return
	end)(var_4_0)

	return
end

return
