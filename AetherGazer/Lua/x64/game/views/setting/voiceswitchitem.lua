local var_0_0 = class("VoiceSwitchItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = arg_2_0.comps_:GetController("status")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddToggleListener(arg_3_0.toggle_, function(arg_4_0)
		if arg_4_0 then
			manager.notify:CallUpdateFunc(GAME_VOICE_SETTING, arg_3_0.info_.id)
		end
	end)
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
			OpenDownLoadPage(nil, arg_3_0.info_.affix)
		end
	end)
end

function var_0_0.Init(arg_9_0)
	arg_9_0:InitUI()
	arg_9_0:AddUIListener()
end

function var_0_0.Render(arg_10_0)
	arg_10_0:RefreshData(arg_10_0.info_)
end

function var_0_0.RefreshData(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0.info_ = arg_11_1
		arg_11_0.nameText_.text = GetI18NText(arg_11_1.name)

		local var_11_0 = VoicePackageManager.Instance:IsHavePackage(arg_11_1.affix)
		local var_11_1 = SettingData:GetSoundSettingData().voice_language
		local var_11_2 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

		if var_11_0 then
			arg_11_0.spaceText_.text = ""

			if var_11_1 == arg_11_1.id then
				arg_11_0.statusController_:SetSelectedState("in_use")

				arg_11_0.toggle_.isOn = true
			else
				arg_11_0.statusController_:SetSelectedState("downloaded")
			end
		else
			arg_11_0.statusController_:SetSelectedState("not_downloaded")

			local var_11_3 = string.format("(%.2fMB)", AssetPendDownLoadManager.instance:GetVoicePackageSize(arg_11_1.affix))

			arg_11_0.spaceText_.text = var_11_3
		end
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.params_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
