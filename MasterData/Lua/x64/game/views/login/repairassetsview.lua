local RepairAssetsView = class("RepairAssetsView", ReduxView)

function RepairAssetsView:UIName()
	return "Widget/System/LoginInterface/ResourcesCheckStartUI"
end

function RepairAssetsView:UIParent()
	return manager.ui.uiPop.transform
end

function RepairAssetsView:OnCtor()
	return
end

function RepairAssetsView:InitUI()
	self:BindCfgUI()
end

function RepairAssetsView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
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

function RepairAssetsView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RepairAssetsView:SetTitle(arg_9_1)
	self.titleText_.text = GetI18NText(arg_9_1)
end

function RepairAssetsView:SetContent(arg_10_1)
	self.contentText_.text = GetI18NText(arg_10_1)
end

function RepairAssetsView:SetProgress(arg_11_1, arg_11_2)
	self.progressImg_.fillAmount = arg_11_1
	self.progressText_.text = arg_11_2
end

function RepairAssetsView:OnEnter()
	RepairAssetsToLua.VerifyAssets()
	self:SetTitle(GetTips("VERIFY_ASSETS_PROCESSING_TITLE"))
	self:SetContent(GetTips("VERIFY_ASSETS_PROCESSING_CONTENT"))
	self:SetProgress(0, "")

	if self.updateTimer ~= nil then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	if self.updateTimer == nil then
		self.updateTimer = Timer.New(function()
			local var_13_0 = RepairAssetsToLua.GetCurrentVerifyIndex()
			local var_13_1 = RepairAssetsToLua.GetTotalVerifyCount()

			if var_13_1 < var_13_0 then
				var_13_0 = var_13_1
			end

			self:SetProgress((var_13_1 ~= 0 or nil) and var_13_0 / var_13_1, string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_13_0, var_13_1))

			if not RepairAssetsToLua.IsVerifying() then
				if self.updateTimer ~= nil then
					self.updateTimer:Stop()

					self.updateTimer = nil
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

	self.updateTimer:Start()
end

function RepairAssetsView:OnExit()
	if self.updateTimer ~= nil then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	RepairAssetsToLua.StopVerify()
end

function RepairAssetsView:Dispose()
	self.params_ = nil

	RepairAssetsView.super.Dispose(self)
end

return RepairAssetsView
