pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.RepairResMgr = var_0_10001("RepairResMgr")
pg = var_0

local var_0_1 = var_0.RepairResMgr

var_0_1.TYPE_DEFAULT_RES = 2
var_0_1.TYPE_L2D = 4
var_0_1.TYPE_PAINTING = 8
var_0_1.TYPE_CIPHER = 16
var_0_1.TYPE_CV = 32

function var_0_1.Init(arg_1_0, arg_1_1)
	LoadAndInstantiateAsync = var_1_10002

	var_1_10002("ui", "RepairUI", function(arg_2_0)
		arg_1_0._go = arg_2_0
		arg_1_0._tf = arg_1_0._go.transform

		local var_2_0 = arg_1_0._go

		var_1.SetActive(var_2_0, false)

		local var_2_1 = arg_1_0
		local var_2_2 = arg_1_0._tf
		local var_2_3 = var_2.Find(var_2_2, "window/content/Text")
		local var_2_4 = var_2.GetComponent

		typeof = var_4
		Text = var_2_10005
		var_2_1.contentTxt = var_2_4(var_2_3, var_4(var_2_10005))

		local var_2_5 = arg_1_0

		pg = var_2
		var_2_5.parentTr = var_2.UIMgr.GetInstance().OverlayToast

		local var_2_6 = arg_1_0._go.transform

		var_1.SetParent(var_2_6, arg_1_0.parentTr, false)

		local var_2_7 = arg_1_0
		local var_2_8 = arg_1_0._tf

		var_2_7.closeBtn = var_2.Find(var_2_8, "window/top/btnBack")

		local var_2_9 = arg_1_0
		local var_2_10 = {}
		local var_2_11 = arg_1_0

		var_2_10[1] = var_3.InitDefaultResBtn(var_2_11)

		local var_2_12 = arg_1_0

		var_2_10[2] = var_3.InitL2dBtn(var_2_12)

		local var_2_13 = arg_1_0

		var_2_10[3] = var_3.InitPaintingBtn(var_2_13)

		local var_2_14 = arg_1_0

		var_2_10[4] = var_3.InitCipherBtn(var_2_14)

		local var_2_15 = arg_1_0

		var_2_10[5] = var_3.InitCvBtn(var_2_15)
		var_2_9.btns = var_2_10

		local var_2_16 = arg_1_0

		UIItemList = var_2_10

		local var_2_17 = var_2_10.New
		local var_2_18 = arg_1_0._tf
		local var_2_19 = var_3.Find(var_2_18, "window/buttons")
		local var_2_20 = arg_1_0._tf

		var_2_16.uiItemList = var_2_17(var_2_19, var_4.Find(var_2_20, "window/buttons/custom_button_1"))
		setText = var_2_16

		local var_2_21 = arg_1_0._tf
		local var_2_22 = var_2.Find(var_2_21, "window/top/title")

		i18n = var_2_21

		var_2_16(var_2_22, var_2_21("msgbox_repair_title"))
		arg_1_1()

		return
	end, true, true)

	return
end

function var_0_1.InitDefaultResBtn(arg_3_0)
	local var_3_0 = {
		type = var_0_1.TYPE_DEFAULT_RES
	}

	i18n = var_2
	var_3_0.text = var_2("msgbox_repair")

	function var_3_0.onCallback()
		PathMgr = var_2_10000

		local var_4_0 = var_2_10000.FileExists

		Application = var_2_10001

		local var_4_2

		if var_4_0(var_2_10001.persistentDataPath .. "/hashes.csv") then
			BundleWizard = var_0

			local var_4_1 = var_0.Inst

			var_4_2 = var_0.GetGroupMgr(var_4_1, "DEFAULT_RES")

			var_0.StartVerifyForLua(var_4_2)
		else
			pg = var_0

			local var_4_3 = var_0.TipsMgr.GetInstance()
			local var_4_4 = var_0.ShowTips

			i18n = var_4_2

			var_4_4(var_4_3, var_4_2("word_no_cache"))
		end

		return
	end

	return var_3_0
end

function var_0_1.InitL2dBtn(arg_5_0)
	local var_5_0 = {
		type = var_0_1.TYPE_L2D
	}

	i18n = var_2
	var_5_0.text = var_2("msgbox_repair_l2d")

	function var_5_0.onCallback()
		PathMgr = var_2_10000

		local var_6_0 = var_2_10000.FileExists

		Application = var_2_10001

		local var_6_2

		if var_6_0(var_2_10001.persistentDataPath .. "/hashes-live2d.csv") then
			BundleWizard = var_0

			local var_6_1 = var_0.Inst

			var_6_2 = var_0.GetGroupMgr(var_6_1, "L2D")

			var_0.StartVerifyForLua(var_6_2)
		else
			pg = var_0

			local var_6_3 = var_0.TipsMgr.GetInstance()
			local var_6_4 = var_0.ShowTips

			i18n = var_6_2

			var_6_4(var_6_3, var_6_2("word_no_cache"))
		end

		return
	end

	return var_5_0
end

function var_0_1.InitPaintingBtn(arg_7_0)
	local var_7_0 = {
		type = var_0_1.TYPE_PAINTING
	}

	i18n = var_2
	var_7_0.text = var_2("msgbox_repair_painting")

	function var_7_0.onCallback()
		PathMgr = var_2_10000

		local var_8_0 = var_2_10000.FileExists

		Application = var_2_10001

		local var_8_2

		if var_8_0(var_2_10001.persistentDataPath .. "/hashes-painting.csv") then
			BundleWizard = var_0

			local var_8_1 = var_0.Inst

			var_8_2 = var_0.GetGroupMgr(var_8_1, "PAINTING")

			var_0.StartVerifyForLua(var_8_2)
		else
			pg = var_0

			local var_8_3 = var_0.TipsMgr.GetInstance()
			local var_8_4 = var_0.ShowTips

			i18n = var_8_2

			var_8_4(var_8_3, var_8_2("word_no_cache"))
		end

		return
	end

	return var_7_0
end

function var_0_1.InitCipherBtn(arg_9_0)
	local var_9_0 = {
		type = var_0_1.TYPE_CIPHER
	}

	i18n = var_2
	var_9_0.text = var_2("msgbox_repair_cipher")

	function var_9_0.onCallback()
		PathMgr = var_2_10000

		local var_10_0 = var_2_10000.FileExists

		Application = var_2_10001

		local var_10_2

		if var_10_0(var_2_10001.persistentDataPath .. "/hashes-cipher.csv") then
			BundleWizard = var_0

			local var_10_1 = var_0.Inst

			var_10_2 = var_0.GetGroupMgr(var_10_1, "CIPHER")

			var_0.StartVerifyForLua(var_10_2)
		else
			pg = var_0

			local var_10_3 = var_0.TipsMgr.GetInstance()
			local var_10_4 = var_0.ShowTips

			i18n = var_10_2

			var_10_4(var_10_3, var_10_2("word_no_cache"))
		end

		return
	end

	return var_9_0
end

function var_0_1.InitCvBtn(arg_11_0)
	local var_11_0 = {
		type = var_0_1.TYPE_CV
	}

	i18n = var_2
	var_11_0.text = var_2("msgbox_repair_cv")

	function var_11_0.onCallback()
		PathMgr = var_2_10000

		local var_12_0 = var_2_10000.FileExists

		Application = var_2_10001

		local var_12_2

		if var_12_0(var_2_10001.persistentDataPath .. "/hashes-cv.csv") then
			BundleWizard = var_0

			local var_12_1 = var_0.Inst

			var_12_2 = var_0.GetGroupMgr(var_12_1, "CV")

			var_0.StartVerifyForLua(var_12_2)
		else
			pg = var_0

			local var_12_3 = var_0.TipsMgr.GetInstance()
			local var_12_4 = var_0.ShowTips

			i18n = var_12_2

			var_12_4(var_12_3, var_12_2("word_no_cache"))
		end

		return
	end

	return var_11_0
end

function var_0_1.Repair(arg_13_0, arg_13_1)
	local var_13_0

	if not arg_13_1 then
		::label_13_0::

		bit = var_13_0
		var_13_0 = var_13_0.bor(var_0_1.TYPE_DEFAULT_RES, var_0_1.TYPE_L2D, var_0_1.TYPE_PAINTING, var_0_1.TYPE_CIPHER, var_0_1.TYPE_CV)
	end

	local var_13_1 = {}

	ipairs = var_1_10004

	for iter_13_0, iter_13_1 in var_1_10004(arg_13_0.btns) do
		bit = var_1_10009

		if var_1_10009.band(iter_13_1.type, var_13_0) > 0 then
			table = var_1_10009

			var_1_10009.insert(var_13_1, iter_13_1)
		end
	end

	arg_13_0:Show(var_13_1)

	return
end

function var_0_1.Show(arg_14_0, arg_14_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_14_0)

	local var_14_0 = arg_14_0._go

	var_2.SetActive(var_14_0, true)

	pg = var_2

	local var_14_1 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_14_1, arg_14_0._tf)

	local var_14_2 = arg_14_0.uiItemList

	var_2.make(var_14_2, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_14_1[arg_15_1 + 1]

			setText = var_4

			var_4(arg_15_2:Find("Text"), var_15_0.text)

			onButton = var_4

			local var_15_1 = arg_14_0
			local var_15_2 = arg_15_2

			local function var_15_3()
				if var_15_0.onCallback then
					var_15_0.onCallback()
				end

				local var_16_0 = arg_14_0

				var_0.Hide(var_16_0)

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_15_1, var_15_2, var_15_3, var_2_10008)
		end

		return
	end)

	local var_14_3 = arg_14_0.uiItemList

	var_2.align(var_14_3, #arg_14_1)

	local var_14_4 = arg_14_0.contentTxt

	i18n = var_14_3
	var_14_4.text = var_14_3("resource_verify_warn")
	onButton = var_14_4

	local var_14_5 = arg_14_0
	local var_14_6 = arg_14_0._tf

	local function var_14_7()
		local var_17_0 = arg_14_0

		var_0.Hide(var_17_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_14_4(var_14_5, var_14_6, var_14_7, var_1_10006)

	onButton = var_14_4

	local var_14_8 = arg_14_0
	local var_14_9 = arg_14_0.closeBtn

	local function var_14_10()
		local var_18_0 = arg_14_0

		var_0.Hide(var_18_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_14_4(var_14_8, var_14_9, var_14_10, var_1_10006)

	return
end

function var_0_1.Hide(arg_19_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_19_0)

	local var_19_0 = arg_19_0._go

	var_1.SetActive(var_19_0, false)

	pg = var_1

	local var_19_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_19_1, arg_19_0._tf, arg_19_0.parentTr)

	return
end

return
