local var_0_0 = class("RepairAssetsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/LoginInterface/ResourcesCheckStartUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		if RepairAssetsToLua.HasError() then
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("VERIFY_ASSETS_HAS_ERROR"),
				OkCallback = function()
					LuaHelper.Quit()
				end
			})
		elseif gameContext:IsOpenRoute("repairAssetsView") then
			JumpTools.Back()
		end
	end)
end

function var_0_0.Init(arg_8_0)
	arg_8_0:InitUI()
	arg_8_0:AddUIListener()
end

function var_0_0.SetTitle(arg_9_0, arg_9_1)
	arg_9_0.titleText_.text = GetI18NText(arg_9_1)
end

function var_0_0.SetContent(arg_10_0, arg_10_1)
	arg_10_0.contentText_.text = GetI18NText(arg_10_1)
end

function var_0_0.SetProgress(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.progressImg_.fillAmount = arg_11_1
	arg_11_0.progressText_.text = arg_11_2
end

function var_0_0.OnEnter(arg_12_0)
	RepairAssetsToLua.VerifyAssets()
	arg_12_0:SetTitle(GetTips("VERIFY_ASSETS_PROCESSING_TITLE"))
	arg_12_0:SetContent(GetTips("VERIFY_ASSETS_PROCESSING_CONTENT"))
	arg_12_0:SetProgress(0, "")

	if arg_12_0.updateTimer ~= nil then
		arg_12_0.updateTimer:Stop()

		arg_12_0.updateTimer = nil
	end

	if arg_12_0.updateTimer == nil then
		arg_12_0.updateTimer = Timer.New(function()
			local var_13_0 = RepairAssetsToLua.GetCurrentVerifyIndex()
			local var_13_1 = RepairAssetsToLua.GetTotalVerifyCount()

			if var_13_1 < var_13_0 then
				var_13_0 = var_13_1
			end

			local var_13_2 = 0

			if var_13_1 ~= 0 then
				var_13_2 = var_13_0 / var_13_1
			end

			arg_12_0:SetProgress(var_13_2, string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_13_0, var_13_1))

			if not RepairAssetsToLua.IsVerifying() then
				if arg_12_0.updateTimer ~= nil then
					arg_12_0.updateTimer:Stop()

					arg_12_0.updateTimer = nil
				end

				if RepairAssetsToLua.HasError() then
					ShowMessageBox({
						isTop = true,
						title = GetTips("PROMPT"),
						content = GetTips("VERIFY_ASSETS_HAS_ERROR"),
						OkCallback = function()
							LuaHelper.Quit()
						end
					})
				else
					ShowMessageBox({
						isTop = true,
						title = GetTips("PROMPT"),
						content = GetTips("VERIFY_ASSETS_COMPLETE"),
						OkCallback = function()
							if gameContext:IsOpenRoute("repairAssetsView") then
								JumpTools.Back()
							end
						end
					})
				end
			end
		end, 0.1, -1)
	end

	arg_12_0.updateTimer:Start()
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.updateTimer ~= nil then
		arg_16_0.updateTimer:Stop()

		arg_16_0.updateTimer = nil
	end

	RepairAssetsToLua.StopVerify()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.params_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
