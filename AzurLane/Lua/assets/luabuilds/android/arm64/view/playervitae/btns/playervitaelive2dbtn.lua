local var_0_0 = class("PlayerVitaeLive2dBtn", import(".PlayerVitaeBaseBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:Load(arg_1_0.tf)
	setActive(arg_1_0.tf, true)

	return
end

function var_0_0.InitBtn(arg_2_0)
	return
end

function var_0_0.GetBgName(arg_3_0)
	local var_3_1
	local var_3_2 = arg_3_0:IsHrzType() and "share/btn_l2d_atlas" or "admiralui_atlas"

	var_3_1 = arg_3_0.ship and arg_3_0.ship:GetSkinConfig().spine_use_live2d == 1 and (arg_3_0:IsHrzType() and "spine_painting_bg" or "sp") or arg_3_0:IsHrzType() and "live2d_bg" or "l2d"

	return var_3_2, var_3_1
end

function var_0_0.IsActive(arg_4_0)
	return true
end

function var_0_0.Update(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_0.super.Update(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:NewGo()
	arg_5_0:RequesetLive2dRes()

	return
end

function var_0_0.RequesetLive2dRes(arg_6_0)
	arg_6_0:StartCheckUpdate((HXSet.autoHxShiftPath("live2d/" .. string.lower(arg_6_0.ship:getPainting()), nil, true)))

	return
end

function var_0_0.StartCheckUpdate(arg_7_0, arg_7_1)
	local var_7_0 = BundleWizard.Inst:GetGroupMgr("L2D"):CheckF(arg_7_1)

	if var_7_0 == DownloadState.CheckToUpdate or var_7_0 == DownloadState.UpdateFailure then
		arg_7_0:ShowOrHide(true)
		arg_7_0:UpdateBtnState(false, false)
		onButton(arg_7_0, arg_7_0.tf, function()
			local var_8_0, var_8_1

			if arg_7_0.isDownloading then
				do return end

				var_8_0 = {
					arg_7_1
				}
				var_8_1 = "L2D" .. arg_7_1
			end

			;({
				type = MSGBOX_TYPE_NORMAL
			}).content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((GroupHelper.CalcSizeWithFileArr("L2D", {
				arg_7_1
			}))))))
			;({
				type = MSGBOX_TYPE_NORMAL
			}).onYes = function()
				BundleWizardUpdater.Inst:StartUpdate((BundleWizardUpdater.Inst:CreateListInfo(var_8_1, BundleWizardUpdater.Inst:GetFileList(var_0, var_8_0), nil, function(arg_10_0, arg_10_1)
					if not arg_7_0.isDisposed then
						local var_10_0 = checkABExist(arg_7_1)

						arg_7_0:ShowOrHide(var_10_0)

						if var_10_0 then
							arg_7_0:UpdateBtnState(false, false)
							var_0_0.super.InitBtn(arg_7_0)
						end
					end

					arg_7_0.isDownloading = false

					return
				end, nil)))

				arg_7_0.isDownloading = true

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_NORMAL
			})

			return
		end, SFX_PANEL)
	else
		local var_7_1 = checkABExist(arg_7_1)

		arg_7_0:ShowOrHide(var_7_1)

		if var_7_1 then
			arg_7_0:UpdateBtnState(false, false)
			var_0_0.super.InitBtn(arg_7_0)
		end
	end

	return
end

function var_0_0.GetDefaultValue(arg_11_0)
	if Live2dConst.GetLive2DArm32MatchAble() then
		if getProxy(SettingsProxy):getCharacterSetting(arg_11_0.ship.id, SHIP_FLAG_L2D) then
			arg_11_0:OnSwitch(false)
		end

		return false
	end

	return getProxy(SettingsProxy):getCharacterSetting(arg_11_0.ship.id, SHIP_FLAG_L2D)
end

function var_0_0.OnSwitch(arg_12_0, arg_12_1)
	if Live2dConst.GetLive2DArm32MatchAble() and arg_12_1 then
		Live2dConst.ShowLive2DArm32Tips()

		return false
	end

	if not not ShipSkin.GetChangeSkinData(arg_12_0.ship:getSkinId()) then
		getProxy(SettingsProxy):setCharacterSetting(arg_12_0.ship.id, SHIP_FLAG_SP, arg_12_1)
	end

	getProxy(SettingsProxy):setCharacterSetting(arg_12_0.ship.id, SHIP_FLAG_L2D, arg_12_1)

	return true
end

function var_0_0.OnDispose(arg_13_0)
	arg_13_0.isDisposed = true

	return
end

function var_0_0.Load(arg_14_0, arg_14_1)
	var_0_0.super.Load(arg_14_0, arg_14_1)

	if arg_14_0:IsHrzType() then
		arg_14_1.gameObject.name = "live2d"
	end

	arg_14_0.tf:GetComponent(typeof(Image)):SetNativeSize()

	return
end

return var_0_0
