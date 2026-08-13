class = var_0_10000

local var_0_0 = "PlayerVitaeLive2dBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PlayerVitaeBaseBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:Load(arg_1_0.tf)

	setActive = var_3

	var_3(arg_1_0.tf, true)

	return
end

function var_0_1.InitBtn(arg_2_0)
	return
end

function var_0_1.GetBgName(arg_3_0)
	local var_3_0
	local var_3_1
	local var_3_2 = arg_3_0:IsHrzType() and "share/btn_l2d_atlas" or "admiralui_atlas"

	if arg_3_0.ship then
		local var_3_3 = arg_3_0.ship

		if var_3.GetSkinConfig(var_3_3).spine_use_live2d == 1 then
			var_3_1 = arg_3_0:IsHrzType() and "spine_painting_bg" or "sp"

			goto label_3_0
		end
	end

	var_3_1 = arg_3_0:IsHrzType() and "live2d_bg" or "l2d"

	::label_3_0::

	return var_3_2, var_3_1
end

function var_0_1.IsActive(arg_4_0)
	return true
end

function var_0_1.Update(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_1.super.Update(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:NewGo()
	arg_5_0:RequesetLive2dRes()

	return
end

function var_0_1.RequesetLive2dRes(arg_6_0)
	local var_6_0 = arg_6_0.ship
	local var_6_1 = "live2d/"

	string = var_1_10003

	local var_6_2 = var_6_1 .. var_1_10003.lower(var_6_0:getPainting())

	HXSet = var_3

	local var_6_3 = var_3.autoHxShiftPath(var_6_2, nil, true)

	arg_6_0:StartCheckUpdate(var_6_3)

	return
end

function var_0_1.StartCheckUpdate(arg_7_0, arg_7_1)
	BundleWizard = var_1_10002

	local var_7_0 = var_1_10002.Inst
	local var_7_1 = var_2.GetGroupMgr(var_7_0, "L2D")
	local var_7_2 = var_2.CheckF(var_7_1, arg_7_1)

	DownloadState = var_7_0

	if var_7_2 ~= var_7_0.CheckToUpdate then
		DownloadState = var_4

		if var_7_2 == var_4.UpdateFailure then
			arg_7_0:ShowOrHide(true)
			arg_7_0:UpdateBtnState(false, false)

			onButton = var_4

			local var_7_3 = arg_7_0
			local var_7_4 = arg_7_0.tf

			local function var_7_5()
				if arg_7_0.isDownloading then
					return
				end

				local var_8_0 = "L2D"
				local var_8_1 = {
					arg_7_1
				}
				local var_8_2 = var_8_0 .. arg_7_1

				GroupHelper = var_3

				local var_8_3 = var_3.CalcSizeWithFileArr(var_8_0, var_8_1)

				HashUtil = var_2_10004

				local var_8_4 = var_2_10004.BytesToString(var_8_3)

				pg = var_5

				local var_8_5 = var_5.MsgboxMgr.GetInstance()
				local var_8_6 = var_5.ShowMsgBox
				local var_8_7 = {}

				MSGBOX_TYPE_NORMAL = var_2_10009
				var_8_7.type = var_2_10009
				string = var_2_10009

				local var_8_8 = var_2_10009.format

				i18n = var_2_10011
				var_8_7.content = var_8_8(var_2_10011("group_download_tip", var_8_4))

				function var_8_7.onYes()
					local function var_9_0(arg_10_0, arg_10_1)
						if not arg_7_0.isDisposed then
							checkABExist = var_2

							local var_10_0 = var_2(arg_7_1)
							local var_10_1 = arg_7_0

							var_3.ShowOrHide(var_10_1, var_10_0)

							if var_10_0 then
								local var_10_2 = arg_7_0

								var_3.UpdateBtnState(var_10_2, false, false)
								var_0_1.super.InitBtn(arg_7_0)
							end
						end

						arg_7_0.isDownloading = false

						return
					end

					BundleWizardUpdater = var_3_10001

					local var_9_1 = var_3_10001.Inst
					local var_9_2 = var_1.GetFileList(var_9_1, var_8_0, var_8_1)

					BundleWizardUpdater = var_3_10002

					local var_9_3 = var_3_10002.Inst
					local var_9_4 = var_2.CreateListInfo(var_9_3, var_8_2, var_9_2, nil, var_9_0, nil)

					BundleWizardUpdater = var_9_1

					local var_9_5 = var_9_1.Inst

					var_3.StartUpdate(var_9_5, var_9_4)

					arg_7_0.isDownloading = true

					return
				end

				var_8_6(var_8_5, var_8_7)

				return
			end

			SFX_PANEL = var_1_10009

			var_4(var_7_3, var_7_4, var_7_5, var_1_10009)
		else
			checkABExist = var_4

			local var_7_6 = var_4(arg_7_1)

			arg_7_0:ShowOrHide(var_7_6)

			if var_7_6 then
				arg_7_0:UpdateBtnState(false, false)
				var_0_1.super.InitBtn(arg_7_0)
			end
		end

		return
	end
end

function var_0_1.GetDefaultValue(arg_11_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1 = var_1.getCharacterSetting
	local var_11_2 = arg_11_0.ship.id

	SHIP_FLAG_L2D = var_1_10005

	local var_11_3 = var_11_1(var_11_0, var_11_2, var_1_10005)

	Live2dConst = var_1_10002

	if var_1_10002.GetLive2DArm32MatchAble() then
		if var_11_3 then
			var_11_2 = arg_11_0

			arg_11_0.OnSwitch(var_11_2, false)
		end

		return false
	end

	getProxy = var_2
	SettingsProxy = var_11_2

	local var_11_4 = var_2(var_11_2)
	local var_11_5 = var_2.getCharacterSetting
	local var_11_6 = arg_11_0.ship.id

	SHIP_FLAG_L2D = var_1_10006

	return var_11_5(var_11_4, var_11_6, var_1_10006)
end

function var_0_1.OnSwitch(arg_12_0, arg_12_1)
	Live2dConst = var_1_10002

	if var_1_10002.GetLive2DArm32MatchAble() and arg_12_1 then
		Live2dConst = var_2

		var_2.ShowLive2DArm32Tips()

		return false
	end

	ShipSkin = var_2

	local var_12_0 = var_2.GetChangeSkinData
	local var_12_1 = arg_12_0.ship

	if var_12_0(var_4.getSkinId(var_12_1)) and true or false then
		getProxy = var_1_10003
		SettingsProxy = var_1_10005
		var_1_10005 = var_1_10003(var_1_10005)
		var_1_10003 = var_1_10003.setCharacterSetting

		local var_12_2 = arg_12_0.ship.id

		SHIP_FLAG_SP = var_1_10007

		var_1_10003(var_1_10005, var_12_2, var_1_10007, arg_12_1)
	end

	getProxy = var_1_10003
	SettingsProxy = var_1_10005

	local var_12_3 = var_1_10003(var_1_10005)
	local var_12_4 = var_3.setCharacterSetting
	local var_12_5 = arg_12_0.ship.id

	SHIP_FLAG_L2D = var_1_10007

	var_12_4(var_12_3, var_12_5, var_1_10007, arg_12_1)

	return true
end

function var_0_1.OnDispose(arg_13_0)
	arg_13_0.isDisposed = true

	return
end

function var_0_1.Load(arg_14_0, arg_14_1)
	var_0_1.super.Load(arg_14_0, arg_14_1)

	if arg_14_0:IsHrzType() then
		arg_14_1.gameObject.name = "live2d"
	end

	local var_14_0 = arg_14_0.tf
	local var_14_1 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007

	local var_14_2 = var_14_1(var_14_0, var_5(var_1_10007))

	var_2.SetNativeSize(var_14_2)

	return
end

return var_0_1
