class = var_0_10000

local var_0_0 = "CheckHotfixCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1

	if arg_1_1.getBody(var_1_0).mediatorName then
		string = var_1_0

		if not var_1_0.find(var_2, "Combat") then
			string = var_1_0

			if var_1_0.find(var_2, "Battle") then
				return
			end

			getProxy = var_1_0
			SettingsProxy = var_1_10004

			local var_1_1 = var_1_0(var_1_10004)

			PLATFORM_CODE = var_1_10004
			PLATFORM_US = var_1_10005

			if var_1_10004 == var_1_10005 then
				VersionMgr = var_1_10004

				local var_1_2 = var_1_10004.Inst

				if var_1_10004.OnProxyUsing(var_1_2) then
					return
				end
			end

			BundleWizard = var_1_10004

			local var_1_3 = var_1_10004.Inst

			if var_4.GetGroupMgr(var_1_3, "DEFAULT_RES").CurrentVersion.Major > 0 then
				if var_1_1.lastRequestVersionTime then
					Time = var_1_5

					local var_1_5

					if var_1_5.realtimeSinceStartup - var_1_1.lastRequestVersionTime > 1800 then
						Time = var_1_5
						var_1_1.lastRequestVersionTime = var_1_5.realtimeSinceStartup
						pg = var_1_5

						local var_1_4 = var_1_5.UIMgr.GetInstance()

						var_1_5.LoadingOn(var_1_4)

						var_1_5 = true
						VersionMgr = var_1_4

						local var_1_6 = var_1_4.Inst

						var_6.FetchVersion(var_1_6, function(arg_2_0)
							pg = var_2_10001

							local var_2_0 = var_2_10001.UIMgr.GetInstance()

							var_1.LoadingOff(var_2_0)

							var_1_5 = false

							if arg_2_0.Major > var_0.CurrentVersion.Major or arg_2_0.Major == var_0.CurrentVersion.Major and arg_2_0.Minor > var_0.CurrentVersion.Minor or arg_2_0.Major == var_0.CurrentVersion.Major and arg_2_0.Minor == var_0.CurrentVersion.Minor and arg_2_0.Build > var_0.CurrentVersion.Build then
								nowWorld = var_1

								local var_2_1 = var_1()

								var_2_1.forceLock = true
								pg = var_2_1

								local var_2_2 = var_2_1.MsgboxMgr.GetInstance()
								local var_2_3 = var_1.ShowMsgBox
								local var_2_4 = {
									modal = true,
									locked = true,
									hideNo = true
								}

								i18n = var_2_10004
								var_2_4.content = var_2_10004("new_version_tip")

								function var_2_4.onYes()
									Application = var_3_10000

									var_3_10000.Quit()

									return
								end

								function var_2_4.onClose()
									Application = var_3_10000

									var_3_10000.Quit()

									return
								end

								var_2_3(var_2_2, var_2_4)
							end

							return
						end)

						LeanTween = var_6

						local var_1_7 = var_6.delayedCall
						local var_1_8 = 3

						System = var_8

						var_1_7(var_1_8, var_8.Action(function()
							if var_1_5 then
								pg = var_0

								local var_5_0 = var_0.UIMgr.GetInstance()

								var_0.LoadingOff(var_5_0)
							end

							return
						end))
					end

					if var_2 then
						string = var_1_5

						if var_1_5.find(var_2, "LoginMediator") then
							var_1_1.lastRequestVersionTime = nil
						end
					end

					return
				end
			end
		end
	end
end

return var_0_1
