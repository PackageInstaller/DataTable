class = var_0_10000

local var_0_0 = "DOACoreActivityMsgBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.SKIP_TYPE_SCENE = 2
var_0_1.SKIP_TYPE_ACTIVITY = 3

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return
end

function var_0_1.getUIName(arg_2_0)
	return "DOACoreActivityMsgBox"
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.bg = var_1.Find(var_3_0, "bg")

	local var_3_1 = arg_3_0._tf

	arg_3_0.btnClose = var_1.Find(var_3_1, "window/top/btnBack")
	onButton = var_1

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.btnClose

	local function var_3_4()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_3_2, var_3_3, var_3_4, var_1_10005)

	onButton = var_1

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.bg

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_3_5, var_3_6, var_3_7, var_1_10005)

	return
end

function var_0_1.OnInit(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.window = var_1.Find(var_6_0, "window")

	local var_6_1 = arg_6_0._tf

	arg_6_0.page = var_1.Find(var_6_1, "window/page")

	local var_6_2 = arg_6_0.page

	arg_6_0.title = var_1.Find(var_6_2, "name_mask/name")

	local var_6_3 = arg_6_0.page

	arg_6_0.owner = var_1.Find(var_6_3, "owner")
	setText = var_1

	local var_6_4 = arg_6_0.owner
	local var_6_5 = var_2.Find(var_6_4, "title")

	i18n = var_6_4

	var_1(var_6_5, var_6_4("collect_page_got"))

	local var_6_6 = arg_6_0.page

	arg_6_0.ownerLimit = var_1.Find(var_6_6, "owner_limit")
	setText = var_1

	local var_6_7 = arg_6_0.ownerLimit
	local var_6_8 = var_2.Find(var_6_7, "title")

	i18n = var_6_7

	var_1(var_6_8, var_6_7("collect_page_got"))

	local var_6_9 = arg_6_0.page

	arg_6_0.iconTF = var_1.Find(var_6_9, "left/IconTpl")

	local var_6_10 = arg_6_0.page

	arg_6_0.ownTF = var_1.Find(var_6_10, "left/own")

	local var_6_11 = arg_6_0.page

	arg_6_0.detailTF = var_1.Find(var_6_11, "left/detail")

	local var_6_12 = arg_6_0.page

	arg_6_0.desc = var_1.Find(var_6_12, "content/desc")

	local var_6_13 = arg_6_0.page

	arg_6_0.list = var_1.Find(var_6_13, "content/skipable_list")

	local var_6_14 = arg_6_0.list

	arg_6_0.tpl = var_1.Find(var_6_14, "tpl")

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_0._tf, {
		staticBlur = true
	})

	Drop = var_2

	local var_7_1 = var_2.New({
		type = arg_7_1.drop_type,
		id = arg_7_1.drop_id
	})

	updateDrop = var_3

	var_3(arg_7_0.iconTF, var_7_1)

	UpdateOwnDisplay = var_3

	var_3(arg_7_0.ownTF, var_7_1)

	local var_7_2 = var_7_1.cfg

	changeToScrollText = var_4

	var_4(arg_7_0.title, var_7_2.name)

	setText = var_4

	var_4(arg_7_0.desc, var_7_1.desc)

	setActive = var_4

	var_4(arg_7_0.owner, false)

	setActive = var_4

	var_4(arg_7_0.ownerLimit, true)

	setText = var_4

	local var_7_3 = arg_7_0.ownerLimit
	local var_7_4 = var_5.Find(var_7_3, "Text")
	local var_7_5 = arg_7_1.count
	local var_7_6 = "/"
	local var_7_7

	if not arg_7_1.count_limit then
		var_7_7 = 0
	end

	var_4(var_7_4, var_7_5 .. var_7_6 .. var_7_7)

	local var_7_8 = #arg_7_1.skipable_list

	if 1 < var_7_8 then
		arg_7_0:setWindowSize(var_7_8 - 1)
	end

	UIItemList = var_5

	var_5.StaticAlign(arg_7_0.list, arg_7_0.tpl, var_7_8, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_7_1.skipable_list[arg_8_1 + 1][1]
			local var_8_1 = var_3[2]
			local var_8_2 = var_3[3]

			changeToScrollText = var_2_10007

			var_2_10007(arg_8_2:Find("mask/title"), var_8_2)

			local var_8_3 = arg_8_2
			local var_8_4 = arg_8_2.Find(var_8_3, "skip_btn")

			onButton = var_8_3

			local var_8_5 = arg_7_0
			local var_8_6 = var_8_4

			local function var_8_7()
				if var_8_0 == var_0_1.SKIP_TYPE_SCENE then
					pg = var_0

					local var_9_0 = var_0.m02
					local var_9_1 = var_0.sendNotification

					GAME = var_3_10002
					var_3_10002 = var_3_10002.GO_SCENE
					var_3_10003 = var_8_1[1]

					local var_9_2

					if not var_8_1[2] then
						var_9_2 = {}
					end

					var_9_1(var_9_0, var_3_10002, var_3_10003, var_9_2)
				elseif var_8_0 == var_0_1.SKIP_TYPE_ACTIVITY then
					pg = var_0

					local var_9_3 = var_0.m02
					local var_9_4 = var_0.sendNotification

					GAME = var_3_10002

					local var_9_5 = var_3_10002.GO_SCENE

					SCENE = var_3_10003

					var_9_4(var_9_3, var_9_5, var_3_10003.ACTIVITY, {
						id = var_8_1
					})
				end

				local var_9_6 = arg_7_0

				var_0.Hide(var_9_6)

				return
			end

			SFX_PANEL = var_2_10012

			var_8_3(var_8_5, var_8_6, var_8_7, var_2_10012)

			Canvas = var_8_3

			var_8_3.ForceUpdateCanvases()
		end

		return
	end)

	return
end

function var_0_1.setWindowSize(arg_10_0, arg_10_1)
	setSizeDelta = var_1_10002

	local var_10_0 = arg_10_0.window

	Vector2 = var_1_10004

	var_1_10002(var_10_0, var_1_10004(716, 7 + 50 * arg_10_1))

	return
end

function var_0_1.Hide(arg_11_0)
	if arg_11_0:isShowing() then
		var_0_1.super.Hide(arg_11_0)

		pg = var_1

		local var_11_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_11_0, arg_11_0._tf, arg_11_0._parentTf)
	end

	return
end

return var_0_1
