class = var_0_10000

local var_0_0 = "Msgbox4LinkCollectGuide"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MsgboxSubPanel"))

var_0_1.SHOW_TYPE_NORMAL = 1
var_0_1.SHOW_TYPE_LIMIT = 2
var_0_1.SKIP_TYPE_SCENE = 2
var_0_1.SKIP_TYPE_ACTIVITY = 3

function var_0_1.getUIName(arg_1_0)
	return "Msgbox4LinkCollectGuide"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.title = var_1.Find(var_2_0, "name_mask/name")

	local var_2_1 = arg_2_0._tf

	arg_2_0.owner = var_1.Find(var_2_1, "owner")
	setText = var_1

	local var_2_2 = arg_2_0.owner
	local var_2_3 = var_2.Find(var_2_2, "title")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("collect_page_got"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.ownerLimit = var_1.Find(var_2_4, "owner_limit")
	setText = var_1

	local var_2_5 = arg_2_0.ownerLimit
	local var_2_6 = var_2.Find(var_2_5, "title")

	i18n = var_2_5

	var_1(var_2_6, var_2_5("collect_page_got"))

	local var_2_7 = arg_2_0._tf

	arg_2_0.iconTF = var_1.Find(var_2_7, "left/IconTpl")

	local var_2_8 = arg_2_0._tf

	arg_2_0.ownTF = var_1.Find(var_2_8, "left/own")

	local var_2_9 = arg_2_0._tf

	arg_2_0.detailTF = var_1.Find(var_2_9, "left/detail")

	local var_2_10 = arg_2_0._tf

	arg_2_0.desc = var_1.Find(var_2_10, "content/desc")

	local var_2_11 = arg_2_0._tf

	arg_2_0.list = var_1.Find(var_2_11, "content/skipable_list")

	local var_2_12 = arg_2_0.list

	arg_2_0.tpl = var_1.Find(var_2_12, "tpl")

	return
end

function var_0_1.OnRefresh(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.SetWindowSize

	Vector2 = var_1_10004

	var_3_1(var_3_0, var_1_10004(930, 540))

	setActive = var_3_1

	var_3_1(arg_3_0.viewParent._btnContainer, false)

	Drop = var_3_1

	local var_3_2 = var_3_1.New({
		type = arg_3_1.drop_type,
		id = arg_3_1.drop_id
	})

	updateDrop = var_3

	var_3(arg_3_0.iconTF, var_3_2)

	UpdateOwnDisplay = var_3

	var_3(arg_3_0.ownTF, var_3_2)

	RegisterDetailButton = var_3

	var_3(arg_3_0.viewParent, arg_3_0.detailTF, var_3_2)

	local var_3_3 = var_3_2.cfg

	changeToScrollText = var_4

	var_4(arg_3_0.title, var_3_3.name)

	setText = var_4

	var_4(arg_3_0.desc, var_3_2.desc)

	if arg_3_1.show_type == var_0_1.SHOW_TYPE_NORMAL then
		setActive = var_4

		var_4(arg_3_0.owner, true)

		setActive = var_4

		var_4(arg_3_0.ownerLimit, false)

		setText = var_4

		local var_3_4 = arg_3_0.owner

		var_4(var_5.Find(var_3_4, "Text"), arg_3_1.count)
	elseif arg_3_1.show_type == var_0_1.SHOW_TYPE_LIMIT then
		setActive = var_4

		var_4(arg_3_0.owner, false)

		setActive = var_4

		var_4(arg_3_0.ownerLimit, true)

		setText = var_4

		local var_3_5 = arg_3_0.ownerLimit
		local var_3_6 = var_5.Find(var_3_5, "Text")
		local var_3_7 = arg_3_1.count
		local var_3_8 = "/"
		local var_3_9

		if not arg_3_1.count_limit then
			var_3_9 = 0
		end

		var_4(var_3_6, var_3_7 .. var_3_8 .. var_3_9)
	end

	UIItemList = var_4

	var_4.StaticAlign(arg_3_0.list, arg_3_0.tpl, #arg_3_1.skipable_list, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_1.skipable_list[arg_4_1 + 1][1]
			local var_4_1 = var_3[2]
			local var_4_2 = var_3[3]

			changeToScrollText = var_2_10007

			var_2_10007(arg_4_2:Find("mask/title"), var_4_2)

			local var_4_3 = arg_4_2
			local var_4_4 = arg_4_2.Find(var_4_3, "skip_btn")

			onButton = var_4_3

			local var_4_5 = arg_3_0
			local var_4_6 = var_4_4

			local function var_4_7()
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

				local var_5_6 = arg_3_0.viewParent

				var_0.hide(var_5_6)

				return
			end

			SFX_PANEL = var_2_10012

			var_4_3(var_4_5, var_4_6, var_4_7, var_2_10012)

			Canvas = var_4_3

			var_4_3.ForceUpdateCanvases()
		end

		return
	end)

	return
end

return var_0_1
