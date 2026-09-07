local CheckHotfixCommand = class("CheckHotfixCommand", pm.SimpleCommand)

function CheckHotfixCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().mediatorName

	if var_1_0 and (string.find(var_1_0, "Combat") or string.find(var_1_0, "Battle")) then
		return
	end

	local var_1_1 = getProxy(SettingsProxy)

	if PLATFORM_CODE == PLATFORM_US and VersionMgr.Inst:OnProxyUsing() then
		return
	end

	local var_1_2 = BundleWizard.Inst:GetGroupMgr("DEFAULT_RES")

	if var_1_2.CurrentVersion.Major > 0 and (not var_1_1.lastRequestVersionTime or Time.realtimeSinceStartup - var_1_1.lastRequestVersionTime > 1800) then
		var_1_1.lastRequestVersionTime = Time.realtimeSinceStartup

		pg.UIMgr.GetInstance():LoadingOn()

		local var_1_3 = true

		VersionMgr.Inst:FetchVersion(function(arg_2_0)
			pg.UIMgr.GetInstance():LoadingOff()

			var_1_3 = false

			if arg_2_0.Major > var_1_2.CurrentVersion.Major or arg_2_0.Major == var_1_2.CurrentVersion.Major and arg_2_0.Minor > var_1_2.CurrentVersion.Minor or arg_2_0.Major == var_1_2.CurrentVersion.Major and arg_2_0.Minor == var_1_2.CurrentVersion.Minor and arg_2_0.Build > var_1_2.CurrentVersion.Build then
				nowWorld().forceLock = true

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					modal = true,
					locked = true,
					hideNo = true,
					content = i18n("new_version_tip"),
					onYes = function()
						Application.Quit()

						return
					end,
					onClose = function()
						Application.Quit()

						return
					end
				})
			end

			return
		end)
		LeanTween.delayedCall(3, System.Action(function()
			if var_1_3 then
				pg.UIMgr.GetInstance():LoadingOff()
			end

			return
		end))
	end

	if var_1_0 and string.find(var_1_0, "LoginMediator") then
		var_1_1.lastRequestVersionTime = nil
	end

	return
end

return CheckHotfixCommand
