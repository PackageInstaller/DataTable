class = var_0_10000

local var_0_0 = "CombatPreviewLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))
local var_0_2 = 12
local var_0_3 = 3

Vector3 = var_3

local var_0_4 = var_3(0, 1, 40)

function var_0_1.getUIName(arg_1_0)
	return "CombatPreviewUI"
end

function var_0_1.OnInit(arg_2_0)
	pg = var_1_10001
	arg_2_0.OverlayMain = var_1_10001.UIMgr.GetInstance().OverlayMain
	setParent = var_1

	var_1(arg_2_0._go, arg_2_0.OverlayMain)

	pg = var_1

	local var_2_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = arg_2_0._tf

	arg_2_0.preview = var_1.Find(var_2_1, "preview")

	local var_2_2 = arg_2_0._tf

	arg_2_0.uiLayer = var_1.Find(var_2_2, "preview/ui")

	local var_2_3 = arg_2_0._tf

	arg_2_0.sea = var_1.Find(var_2_3, "preview/sea")

	local var_2_4 = arg_2_0.sea

	arg_2_0.rawImage = var_1.GetComponent(var_2_4, "RawImage")
	setText = var_1

	local var_2_5 = arg_2_0.preview
	local var_2_6 = var_3.Find(var_2_5, "bg/title/Image")

	i18n = var_4

	var_1(var_2_6, var_4("word_preview"))

	onButton = var_1

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.preview

	local function var_2_9()
		arg_2_0.callBack()

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_7, var_2_8, var_2_9, var_6)

	return
end

function var_0_1.Show(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.callBack = arg_4_2
	pg = var_1_10003

	local var_4_0 = var_1_10003.item_data_battleui[arg_4_1].key
	local var_4_1 = "CombatUI" .. var_4_0
	local var_4_2 = "CombatHPBar" .. var_4_0
	local var_4_3
	local var_4_4
	local var_4_5

	seriesAsync = var_1_10010

	var_1_10010({
		function(arg_5_0)
			PoolMgr = var_2_10001

			local var_5_0 = var_2_10001.GetInstance()

			var_1.GetUI(var_5_0, var_4_2, true, function(arg_6_0)
				var_4_4 = arg_6_0

				arg_5_0()

				return
			end)

			return
		end,
		function(arg_7_0)
			PoolMgr = var_2_10001

			local var_7_0 = var_2_10001.GetInstance()

			var_1.GetUI(var_7_0, var_4_2, true, function(arg_8_0)
				var_4_5 = arg_8_0

				arg_7_0()

				return
			end)

			return
		end,
		function(arg_9_0)
			PoolMgr = var_2_10001

			local var_9_0 = var_2_10001.GetInstance()

			var_1.GetUI(var_9_0, var_4_1, true, function(arg_10_0)
				var_4_3 = arg_10_0

				arg_9_0()

				return
			end)

			return
		end
	}, function()
		local var_11_0 = var_4_3.transform

		var_0.SetParent(var_11_0, arg_4_0.uiLayer, false)

		local var_11_1 = var_4_4.transform

		var_0.SetParent(var_11_1, arg_4_0.uiLayer, false)

		local var_11_2 = var_4_5.transform

		var_0.SetParent(var_11_2, arg_4_0.uiLayer, false)

		local var_11_3 = arg_4_0.sea.rect.width
		local var_11_4 = arg_4_0.sea.rect.height
		local var_11_5 = var_4_3.transform

		Vector3 = var_3
		var_11_5.localScale = var_3(var_11_3 / 0, var_11_4 / 1080, 1)

		local var_11_6 = arg_4_0

		CombatUIPreviewer = var_3
		var_11_6.previewer = var_3.New(arg_4_0.rawImage)

		local var_11_7 = arg_4_0.previewer

		var_2.setDisplayWeapon(var_11_7, {
			100
		})

		local var_11_8 = arg_4_0.previewer

		var_2.setCombatUI(var_11_8, var_4_3, var_4_4, var_4_5, var_4_0)

		Ship = var_2

		local var_11_9 = var_2.New({
			id = 100001,
			configId = 100001,
			skin_id = 100000
		})

		Ship = var_3

		local var_11_10 = var_3.New({
			id = 100011,
			configId = 100011,
			skin_id = 100010
		})
		local var_11_11 = arg_4_0.previewer

		var_4.load(var_11_11, 40000, var_11_9, var_11_10, {}, function()
			return
		end)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf)

	if arg_13_0.previewer then
		local var_13_1 = arg_13_0.previewer

		var_1.clear(var_13_1)

		arg_13_0.previewer = nil
	end

	return
end

return var_0_1
