class = var_0_10000

local var_0_0 = "SnapshotShareLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "snapshotshareui"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.photoImgTrans = var_1.Find(var_2_0, "PhotoImg")

	local var_2_1 = arg_2_0.photoImgTrans

	arg_2_0.rawImage = var_1.GetComponent(var_2_1, "RawImage")

	local var_2_2 = arg_2_0._tf

	arg_2_0.shareBtnTrans = var_1.Find(var_2_2, "BtnPanel/ShareBtn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.confirmBtnTrans = var_1.Find(var_2_3, "BtnPanel/ConfirmBtn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.cancelBtnTrans = var_1.Find(var_2_4, "BtnPanel/CancelBtn")

	local var_2_5 = arg_2_0._tf

	arg_2_0.userAgreenTF = var_1.Find(var_2_5, "UserAgreement")

	local var_2_6 = arg_2_0.userAgreenTF

	arg_2_0.userAgreenMainTF = var_1.Find(var_2_6, "window")

	local var_2_7 = arg_2_0.userAgreenMainTF

	arg_2_0.closeUserAgreenTF = var_1.Find(var_2_7, "close_btn")

	local var_2_8 = arg_2_0.userAgreenMainTF

	arg_2_0.userRefuseConfirmTF = var_1.Find(var_2_8, "refuse_btn")

	local var_2_9 = arg_2_0.userAgreenMainTF

	arg_2_0.userAgreenConfirmTF = var_1.Find(var_2_9, "accept_btn")
	setActive = var_1

	var_1(arg_2_0.userAgreenTF, false)

	arg_2_0.rawImage.texture = arg_2_0.contextData.photoTex
	arg_2_0.bytes = arg_2_0.contextData.photoData

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.shareBtnTrans

	local function var_3_2()
		PlayerPrefs = var_2_10000

		if not var_2_10000.GetInt("snapshotAgress") or var_0 <= 0 then
			local var_4_0 = arg_3_0

			var_2_10001.showUserAgreement(var_4_0, function()
				PlayerPrefs = var_3_10000

				var_3_10000.SetInt("snapshotAgress", 1)

				pg = var_0

				local var_5_0 = var_0.ShareMgr.GetInstance()
				local var_5_1 = var_0.Share

				pg = var_3

				var_5_1(var_5_0, var_3.ShareMgr.TypePhoto)

				return
			end)
		else
			pg = var_2_10001

			local var_4_1 = var_2_10001.ShareMgr.GetInstance()
			local var_4_2 = var_1.Share

			pg = var_2_10004

			var_4_2(var_4_1, var_2_10004.ShareMgr.TypePhoto)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.confirmBtnTrans, function()
		YSNormalTool = var_2_10000

		var_2_10000.MediaTool.SaveImageWithBytes(arg_3_0.bytes, function(arg_7_0, arg_7_1)
			if arg_7_0 then
				pg = var_3_10002

				local var_7_0 = var_3_10002.TipsMgr.GetInstance()
				local var_7_1 = var_2.ShowTips

				i18n = var_3_10005

				var_7_1(var_7_0, var_3_10005("word_save_ok"))
			end

			return
		end)

		pg = var_0

		local var_6_0 = var_0.TipsMgr.GetInstance()
		local var_6_1 = var_0.ShowTips

		i18n = var_3

		var_6_1(var_6_0, var_3("word_save_ok"))

		local var_6_2 = arg_3_0

		var_0.closeView(var_6_2)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.cancelBtnTrans, function()
		local var_8_0 = arg_3_0

		var_0.closeView(var_8_0)

		return
	end)

	return
end

function var_0_1.willExit(arg_9_0)
	return
end

function var_0_1.showUserAgreement(arg_10_0, arg_10_1)
	setButtonEnabled = var_1_10002

	var_1_10002(arg_10_0.userAgreenConfirmTF, true)

	local var_10_0
	local var_10_1 = arg_10_0._tf

	arg_10_0.userAgreenTitleTF = var_3.Find(var_10_1, "UserAgreement/window/title")

	local var_10_2 = arg_10_0.userAgreenTitleTF
	local var_10_3 = var_3.GetComponent(var_10_2, "Text")

	i18n = var_4
	var_10_3.text = var_4("word_snapshot_share_title")
	setActive = var_10_3

	var_10_3(arg_10_0.userAgreenTF, true)

	setText = var_10_3

	local var_10_4 = arg_10_0.userAgreenTF
	local var_10_5 = var_5.Find(var_10_4, "window/container/scrollrect/content/Text")

	i18n = var_6

	var_10_3(var_10_5, var_6("word_snapshot_share_agreement"))

	onButton = var_10_3

	var_10_3(arg_10_0, arg_10_0.userRefuseConfirmTF, function()
		setActive = var_2_10000

		var_2_10000(arg_10_0.userAgreenTF, false)

		return
	end)

	onButton = var_10_3

	var_10_3(arg_10_0, arg_10_0.userAgreenConfirmTF, function()
		setActive = var_2_10000

		var_2_10000(arg_10_0.userAgreenTF, false)

		if arg_10_1 then
			arg_10_1()
		end

		return
	end)

	onButton = var_10_3

	var_10_3(arg_10_0, arg_10_0.closeUserAgreenTF, function()
		setActive = var_2_10000

		var_2_10000(arg_10_0.userAgreenTF, false)

		return
	end)

	return
end

return var_0_1
