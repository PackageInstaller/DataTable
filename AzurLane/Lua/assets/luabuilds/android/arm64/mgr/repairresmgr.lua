pg = pg or {}
pg.RepairResMgr = singletonClass("RepairResMgr")

local var_0_0 = pg.RepairResMgr

pg.RepairResMgr.TYPE_DEFAULT_RES = 2
pg.RepairResMgr.TYPE_L2D = 4
pg.RepairResMgr.TYPE_PAINTING = 8
pg.RepairResMgr.TYPE_CIPHER = 16
pg.RepairResMgr.TYPE_CV = 32

function pg.RepairResMgr.Init(arg_1_0, arg_1_1)
	LoadAndInstantiateAsync("ui", "RepairUI", function(arg_2_0)
		arg_1_0._go = arg_2_0
		arg_1_0._tf = arg_1_0._go.transform

		arg_1_0._go:SetActive(false)

		arg_1_0.contentTxt = arg_1_0._tf:Find("window/content/Text"):GetComponent(typeof(Text))
		arg_1_0.parentTr = pg.UIMgr.GetInstance().OverlayToast

		arg_1_0._go.transform:SetParent(arg_1_0.parentTr, false)

		arg_1_0.closeBtn = arg_1_0._tf:Find("window/top/btnBack")
		arg_1_0.btns = {
			arg_1_0:InitDefaultResBtn(),
			arg_1_0:InitL2dBtn(),
			arg_1_0:InitPaintingBtn(),
			arg_1_0:InitCipherBtn(),
			arg_1_0:InitCvBtn()
		}
		arg_1_0.uiItemList = UIItemList.New(arg_1_0._tf:Find("window/buttons"), arg_1_0._tf:Find("window/buttons/custom_button_1"))

		setText(arg_1_0._tf:Find("window/top/title"), i18n("msgbox_repair_title"))
		arg_1_1()

		return
	end, true, true)

	return
end

function pg.RepairResMgr.InitDefaultResBtn(arg_3_0)
	return {
		type = var_0_0.TYPE_DEFAULT_RES,
		text = i18n("msgbox_repair"),
		onCallback = function()
			if PathMgr.FileExists(Application.persistentDataPath .. "/hashes.csv") then
				BundleWizard.Inst:GetGroupMgr("DEFAULT_RES"):StartVerifyForLua()
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_no_cache"))
			end

			return
		end
	}
end

function pg.RepairResMgr.InitL2dBtn(arg_5_0)
	return {
		type = var_0_0.TYPE_L2D,
		text = i18n("msgbox_repair_l2d"),
		onCallback = function()
			if PathMgr.FileExists(Application.persistentDataPath .. "/hashes-live2d.csv") then
				BundleWizard.Inst:GetGroupMgr("L2D"):StartVerifyForLua()
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_no_cache"))
			end

			return
		end
	}
end

function pg.RepairResMgr.InitPaintingBtn(arg_7_0)
	return {
		type = var_0_0.TYPE_PAINTING,
		text = i18n("msgbox_repair_painting"),
		onCallback = function()
			if PathMgr.FileExists(Application.persistentDataPath .. "/hashes-painting.csv") then
				BundleWizard.Inst:GetGroupMgr("PAINTING"):StartVerifyForLua()
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_no_cache"))
			end

			return
		end
	}
end

function pg.RepairResMgr.InitCipherBtn(arg_9_0)
	return {
		type = var_0_0.TYPE_CIPHER,
		text = i18n("msgbox_repair_cipher"),
		onCallback = function()
			if PathMgr.FileExists(Application.persistentDataPath .. "/hashes-cipher.csv") then
				BundleWizard.Inst:GetGroupMgr("CIPHER"):StartVerifyForLua()
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_no_cache"))
			end

			return
		end
	}
end

function pg.RepairResMgr.InitCvBtn(arg_11_0)
	return {
		type = var_0_0.TYPE_CV,
		text = i18n("msgbox_repair_cv"),
		onCallback = function()
			if PathMgr.FileExists(Application.persistentDataPath .. "/hashes-cv.csv") then
				BundleWizard.Inst:GetGroupMgr("CV"):StartVerifyForLua()
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_no_cache"))
			end

			return
		end
	}
end

function pg.RepairResMgr.Repair(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 or bit.bor(var_0_0.TYPE_DEFAULT_RES, var_0_0.TYPE_L2D, var_0_0.TYPE_PAINTING, var_0_0.TYPE_CIPHER, var_0_0.TYPE_CV)
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.btns) do
		if bit.band(iter_13_1.type, var_13_0) > 0 then
			table.insert(var_13_1, iter_13_1)
		end
	end

	arg_13_0:Show(var_13_1)

	return
end

function pg.RepairResMgr.Show(arg_14_0, arg_14_1)
	pg.DelegateInfo.New(arg_14_0)
	arg_14_0._go:SetActive(true)
	pg.UIMgr.GetInstance():BlurPanel(arg_14_0._tf)
	arg_14_0.uiItemList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			setText(arg_15_2:Find("Text"), arg_14_1[arg_15_1 + 1].text)
			onButton(arg_14_0, arg_15_2, function()
				if var_0.onCallback then
					var_0.onCallback()
				end

				arg_14_0:Hide()

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_14_0.uiItemList:align(#arg_14_1)

	arg_14_0.contentTxt.text = i18n("resource_verify_warn")

	onButton(arg_14_0, arg_14_0._tf, function()
		arg_14_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0.closeBtn, function()
		arg_14_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function pg.RepairResMgr.Hide(arg_19_0)
	pg.DelegateInfo.Dispose(arg_19_0)
	arg_19_0._go:SetActive(false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_19_0._tf, arg_19_0.parentTr)

	return
end

return
