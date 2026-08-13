class = var_0_10000

local var_0_0 = "EscapeManorCollectMsgBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.DOA.DOACoreActivityMsgBox"))

function var_0_1.getUIName(arg_1_0)
	return "EscapeManorCollectMsgBox"
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)

	return
end

function var_0_1.Show(arg_3_0, arg_3_1)
	var_0_1.super.super.Show(arg_3_0)

	pg = var_2

	local var_3_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_3_0, arg_3_0._tf, {
		staticBlur = true
	})

	Drop = var_2

	local var_3_1 = var_2.New({
		type = arg_3_1.drop_type,
		id = arg_3_1.drop_id
	})

	updateDrop = var_3

	var_3(arg_3_0.iconTF, var_3_1)

	UpdateOwnDisplay = var_3

	var_3(arg_3_0.ownTF, var_3_1)

	local var_3_2 = var_3_1.cfg

	changeToScrollText = var_4

	var_4(arg_3_0.title, var_3_2.name)

	setText = var_4

	var_4(arg_3_0.desc, var_3_1.desc)

	setActive = var_4

	var_4(arg_3_0.owner, false)

	setActive = var_4

	var_4(arg_3_0.ownerLimit, true)

	setText = var_4

	local var_3_3 = arg_3_0.ownerLimit
	local var_3_4 = var_5.Find(var_3_3, "Text")
	local var_3_5 = arg_3_1.count
	local var_3_6 = "/"
	local var_3_7

	if not arg_3_1.count_limit then
		var_3_7 = 0
	end

	var_4(var_3_4, var_3_5 .. var_3_6 .. var_3_7)

	local var_3_8 = #arg_3_1.skipable_list
	local var_3_9

	if 1 < var_3_8 then
		var_3_9 = arg_3_0.list
		Vector3 = var_6
		var_3_9.localPosition = var_6(130, -49, 0)
	end

	UIItemList = var_3_9

	var_3_9.StaticAlign(arg_3_0.list, arg_3_0.tpl, var_3_8, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_1.skipable_list[arg_4_1 + 1][1]
			local var_4_1 = var_3[2]
			local var_4_2 = var_3[3]

			changeToScrollText = var_2_10007

			var_2_10007(arg_4_2:Find("mask/title"), var_4_2)

			local var_4_3 = arg_4_2
			local var_4_4 = arg_4_2.Find(var_4_3, "skip_btn")

			setText = var_4_3

			local var_4_5 = var_4_4
			local var_4_6 = var_4_4.Find(var_4_5, "text")

			i18n = var_4_5

			var_4_3(var_4_6, var_4_5("task_go"))

			onButton = var_4_3

			local var_4_7 = arg_3_0
			local var_4_8 = var_4_4

			local function var_4_9()
				if var_4_0 == var_0_1.SKIP_TYPE_SCENE then
					pg = var_0

					local var_5_0 = var_0.m02
					local var_5_1 = var_0.sendNotification

					GAME = var_3_10002
					var_3_10002 = var_3_10002.GO_SCENE
					var_3_10003 = var_4_1[1]

					local var_5_2

					if not var_4_1[2] then
						var_5_2 = {}
					end

					var_5_1(var_5_0, var_3_10002, var_3_10003, var_5_2)
				elseif var_4_0 == var_0_1.SKIP_TYPE_ACTIVITY then
					pg = var_0

					local var_5_3 = var_0.m02
					local var_5_4 = var_0.sendNotification

					GAME = var_3_10002

					local var_5_5 = var_3_10002.GO_SCENE

					SCENE = var_3_10003

					var_5_4(var_5_3, var_5_5, var_3_10003.ACTIVITY, {
						id = var_4_1
					})
				end

				local var_5_6 = arg_3_0

				var_0.Hide(var_5_6)

				return
			end

			SFX_PANEL = var_2_10012

			var_4_3(var_4_7, var_4_8, var_4_9, var_2_10012)

			Canvas = var_4_3

			var_4_3.ForceUpdateCanvases()
		end

		return
	end)

	return
end

return var_0_1
