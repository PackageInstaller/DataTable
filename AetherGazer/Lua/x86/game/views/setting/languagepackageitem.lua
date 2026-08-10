local var_0_0 = class("LanguagePackageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = arg_2_0.comps_:GetController("status")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListenerScale(arg_3_0.downloadBtn_, nil, function()
		if gameContext:IsOpenRoute("setting") then
			manager.notify:CallUpdateFunc("JumpToLanguageManageUI")
			arg_3_0:Back()

			return
		end

		if AssetPendDownLoadManager.instance:GetVoicePackageSize(arg_3_0.info_.affix) + 200 > LuaForUtil.GetFreeDiskSpace() then
			ShowMessageBox({
				content = GetTips("VOICE_STORAGE_FULL"),
				OkCallback = function()
					return
				end,
				CancelCallback = function()
					return
				end,
				MaskCallback = function()
					return
				end
			})
		else
			OpenDownLoadPage(nil, arg_3_0.info_.affix, arg_3_0.needSetParent_)
		end
	end)
	arg_3_0:AddBtnListenerScale(arg_3_0.deleteBtn_, nil, function()
		ShowMessageBox({
			content = string.format(GetTips("VOICE_DELETE_INFO"), GetI18NText(arg_3_0.info_.name)),
			OkCallback = function()
				VoicePackageManager.Instance:DeleteDownLoadPackage(arg_3_0.info_.affix)
				manager.assetPend:UpdateAssetPendSize()
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_DELETED, arg_3_0.info_.affix)
				arg_3_0:RefreshData(arg_3_0.info_, arg_3_0.needSetParent_)
			end,
			CancelCallback = function()
				return
			end,
			MaskCallback = function()
				return
			end
		})
	end)
end

function var_0_0.Init(arg_12_0)
	arg_12_0:InitUI()
	arg_12_0:AddUIListener()
end

function var_0_0.Render(arg_13_0)
	arg_13_0:RefreshData(arg_13_0.info_, arg_13_0.needSetParent_)
end

function var_0_0.RefreshData(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 then
		arg_14_0.needSetParent_ = arg_14_2
		arg_14_0.info_ = arg_14_1
		arg_14_0.nameText_.text = GetI18NText(arg_14_1.name)

		local var_14_0 = VoicePackageManager.Instance:IsHavePackage(arg_14_1.affix)
		local var_14_1 = SettingData:GetSoundSettingData().voice_language
		local var_14_2 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

		if var_14_0 then
			arg_14_0.spaceText_.text = ""

			if var_14_1 == arg_14_1.id then
				arg_14_0.statusController_:SetSelectedState("in_use")

				arg_14_0.tipText_.text = GetTips("TIP_USING")
			else
				arg_14_0.statusController_:SetSelectedState("downloaded")

				if table.indexof(var_14_2.voice_list, arg_14_1.id) == 1 then
					SetActive(arg_14_0.deleteBtn_.gameObject, false)
				end

				arg_14_0.tipText_.text = GetTips("DOWNLOADED")
			end
		else
			arg_14_0.statusController_:SetSelectedState("not_downloaded")

			local var_14_3 = string.format("(%.2fMB)", AssetPendDownLoadManager.instance:GetVoicePackageSize(arg_14_1.affix))

			arg_14_0.spaceText_.text = var_14_3
			arg_14_0.tipText_.text = GetTips("NOT_DOWNLOADED")
		end
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.params_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
