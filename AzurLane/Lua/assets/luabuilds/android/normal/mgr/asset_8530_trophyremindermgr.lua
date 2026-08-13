pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.TrophyReminderMgr = var_0_10001("TrophyReminderMgr")

local var_0_1 = var_0.TrophyReminderMgr

function var_0_1.Ctor(arg_1_0)
	arg_1_0._go = nil

	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	print = var_1_10002

	var_1_10002("initializing tip manager...")

	arg_2_0._count = 0
	arg_2_0._tipTable = {}
	PoolMgr = var_2

	local var_2_0 = var_2.GetInstance()

	var_2.GetUI(var_2_0, "TrophyRemindPanel", true, function(arg_3_0)
		arg_2_0._go = arg_3_0

		local var_3_0 = arg_2_0._go

		var_1.SetActive(var_3_0, false)

		GameObject = var_1

		local var_3_1 = var_1.Find("Overlay/UIOverlay")
		local var_3_2 = arg_2_0._go.transform

		var_2.SetParent(var_3_2, var_3_1.transform, false)

		local var_3_3 = arg_2_0
		local var_3_4 = arg_2_0._go.transform

		var_3_3._tips = var_3.Find(var_3_4, "trophyRemind")

		local var_3_5 = arg_2_0
		local var_3_6 = arg_2_0._go.transform

		var_3_5._grid = var_3.Find(var_3_6, "Grid_trophy")

		arg_2_1()

		return
	end)

	return
end

function var_0_1.ShowTips(arg_4_0, arg_4_1)
	local var_4_0 = var_0.CriMgr.GetInstance()
	local var_4_1 = var_2.PlaySoundEffect_V3

	SFX_UI_TIP = var_1_10004

	var_4_1(var_4_0, var_1_10004)

	local var_4_2 = arg_4_0._go.transform

	var_2.SetAsLastSibling(var_4_2)

	SetActive = var_2

	var_2(arg_4_0._go, true)

	arg_4_0._count = arg_4_0._count + 1
	cloneTplTo = var_2

	local var_4_3 = var_2(arg_4_0._tips, arg_4_0._grid)
	local var_4_4 = var_0.medal_template[arg_4_1]

	LoadImageSpriteAsync = var_4

	local var_4_5 = "medal/s_" .. var_4_4.icon
	local var_4_6 = var_4_3.transform

	var_4(var_4_5, var_6.Find(var_4_6, "content/icon"), true)

	setText = var_4

	local var_4_7 = var_4_3.transform

	var_4(var_5.Find(var_4_7, "content/name"), var_4_4.name)

	setText = var_4

	local var_4_8 = var_4_3.transform
	local var_4_9 = var_5.Find(var_4_8, "content/label")

	i18n = var_4_8

	var_4(var_4_9, var_4_8("trophy_achieved"))

	local var_4_10 = var_4_3.transform
	local var_4_11 = var_4.Find(var_4_10, "content")

	Vector3 = var_4_10
	var_4_11.localPosition = var_4_10(-850, 0, 0)

	;(function(arg_5_0)
		LeanTween = var_2_10001

		local var_5_0 = var_2_10001.moveX

		rtf = var_2_10002

		var_5_0(var_2_10002(var_4_11), -275, 0.5)

		LeanTween = var_5_0

		local var_5_1 = var_5_0.moveX

		rtf = var_2

		local var_5_2 = var_5_1(var_2(var_4_11), -850, 0.5)
		local var_5_3 = var_1.setDelay(var_5_2, 5)
		local var_5_4 = var_1.setOnComplete

		System = var_3

		var_5_4(var_5_3, var_3.Action(function()
			Destroy = var_3_10000

			var_3_10000(arg_5_0)

			arg_4_0._count = arg_4_0._count - 1

			if arg_4_0._count == 0 then
				SetActive = var_0

				var_0(arg_4_0._go, false)
			end

			return
		end))

		return
	end)(var_4_3)

	return
end

return
