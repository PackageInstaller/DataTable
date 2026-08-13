class = var_0_10000

local var_0_0 = "ChapterRewardPanel"

BaseSubView = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.getUIName(arg_1_0)
	return "ChapterRewardPanel"
end

function var_0_1.OnInit(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "window/bg/text")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("desc_defense_reward"))

	UIItemList = var_1_10001

	local var_2_2 = var_1_10001.New
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_3.Find(var_2_3, "window/bg/panel/list")
	local var_2_5 = arg_2_0._tf

	arg_2_0.UIlist = var_2_2(var_2_4, var_4.Find(var_2_5, "window/bg/panel/list/item"))

	local var_2_6 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_6, "window/top/btnBack")

	local var_2_7 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_7, "window/btn_confirm")
	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0._tf

	local function var_2_10()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_2_5

	var_1(var_2_8, var_2_9, var_2_10, var_2_5)

	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.closeBtn

	local function var_2_13()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_2_5

	var_1(var_2_11, var_2_12, var_2_13, var_2_5)

	onButton = var_1

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.confirmBtn

	local function var_2_16()
		local var_5_0 = arg_2_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_2_5

	var_1(var_2_14, var_2_15, var_2_16, var_2_5)

	return
end

local var_0_2 = {
	"s",
	"a",
	"b"
}

local function var_0_3(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0.UIlist

	var_4.make(var_6_0, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_7_2:Find("title/Text"), "PHASE " .. arg_7_1 + 1)

			tostring = var_3

			local var_7_0 = var_3(arg_6_2[arg_7_1 + 1] - 1)

			if arg_6_2[arg_7_1 + 1] - 1 ~= arg_6_2[arg_7_1 + 2] then
				tostring = var_4
				var_7_0 = var_4(arg_6_2[arg_7_1 + 2]) .. "-" .. var_7_0
			end

			setText = var_4

			local var_7_1 = arg_7_2:Find("target/title")

			i18n = var_7

			var_4(var_7_1, var_7("text_rest_HP") .. "：")

			setText = var_4

			var_4(arg_7_2:Find("target/Text"), var_7_0)

			local var_7_2 = arg_6_3[arg_7_1 + 1]

			updateDrop = var_5

			var_5(arg_7_2:Find("award"), var_7_2, {
				hideName = true
			})

			onButton = var_5

			local var_7_3 = arg_6_0
			local var_7_4 = arg_7_2
			local var_7_5 = arg_7_2.Find(var_7_4, "award")

			local function var_7_6()
				local var_8_0 = arg_6_0
				local var_8_1 = var_0.emit

				BaseUI = var_3_10003

				var_8_1(var_8_0, var_3_10003.ON_DROP, var_7_2)

				return
			end

			SFX_PANEL = var_7_4

			var_5(var_7_3, var_7_5, var_7_6, var_7_4)

			setActive = var_5

			var_5(arg_7_2:Find("award/mask"), false)
		end

		return
	end)

	local var_6_1 = arg_6_0.UIlist

	var_4.align(var_6_1, #arg_6_3)

	return
end

function var_0_1.Show(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_9_0, arg_9_0._tf)
	var_0_1.super.Show(arg_9_0)

	return
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)

	pg = var_1

	local var_10_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_1.Enter(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.id

	pg = var_1_10003

	local var_11_1 = var_1_10003.chapter_defense[var_11_0]

	assert = var_1_10004

	var_1_10004(var_11_1, "Chapter Detail should only be Defense Type")

	Clone = var_1_10004

	local var_11_2 = var_1_10004(var_11_1.score)

	table = var_1_10005

	var_1_10005.insert(var_11_2, 1, var_11_1.port_hp + 1)

	local var_11_3 = {}

	ipairs = var_6

	for iter_11_0, iter_11_1 in var_6(var_0_2) do
		if #var_11_1["evaluation_display_" .. iter_11_1] > 0 then
			table = var_12

			var_12.insert(var_11_3, {
				type = var_11[1],
				id = var_11[2],
				count = var_11[3]
			})
		end
	end

	var_0_3(arg_11_0, var_11_1, var_11_2, var_11_3)
	arg_11_0:Show()

	Canvas = var_6

	var_6.ForceUpdateCanvases()

	return
end

function var_0_1.OnDestroy(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf, arg_12_0._parentTf)

	return
end

return var_0_1
