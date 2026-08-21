local var_0_0 = class("GuildMobilityPostView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubMobilityPostPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)

	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.memberID_ = arg_4_0.params_.memberID

	arg_4_0:RefreshPlayerInfo()

	if GuildData:GetGuildMemberData(arg_4_0.memberID_).post == GuildConst.GUILD_POST.DEPUTY then
		arg_4_0.mobilityDeputyText_.text = GetTips("ERROR_CLUB_VICE_CHAIRMAN_CANCEL")
	else
		arg_4_0.mobilityDeputyText_.text = GetTips("ERROR_CLUB_VICE_CHAIRMAN_APPOINT")
	end
end

function var_0_0.RefreshPlayerInfo(arg_5_0)
	local var_5_0 = GuildData:GetGuildMemberData(arg_5_0.memberID_)

	arg_5_0.nameText_.text = var_5_0.name

	arg_5_0.commonPortrait_:RenderHead(var_5_0.icon)
	arg_5_0.commonPortrait_:RenderFrame(var_5_0.frame)
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.buttonClose_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonMobilityCaptain_, nil, function()
		local var_10_0 = GuildData:GetGuildMemberData(arg_8_0.memberID_)
		local var_10_1 = GetTips("CLUB_MOBILITY_CAPTAIN")

		ShowMessageBox({
			isTop = true,
			content = string.format(var_10_1, var_10_0.name),
			OkCallback = function()
				GuildAction.GuildMobilityCaptain(arg_8_0.memberID_, function(arg_12_0)
					if isSuccess(arg_12_0.result) then
						-- block empty
					else
						ShowTips(arg_12_0.result)
					end

					arg_8_0:Go("/guildEntrace/guildMain")
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonMobilityDeputy_, nil, function()
		if GuildData:GetGuildMemberData(arg_8_0.memberID_).post == GuildConst.GUILD_POST.DEPUTY then
			local var_14_0 = GuildData:GetGuildMemberData(arg_8_0.memberID_)
			local var_14_1 = GetTips("CLUB_DISMISS")

			ShowMessageBox({
				isTop = true,
				content = string.format(var_14_1, var_14_0.name),
				OkCallback = function()
					GuildAction.GuildDismiss(arg_8_0.memberID_, function(arg_16_0)
						if isSuccess(arg_16_0.result) then
							-- block empty
						else
							ShowTips(arg_16_0.result)
						end

						arg_8_0:Back()
					end)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			local var_14_2 = GuildData:GetGuildMemberData(arg_8_0.memberID_)
			local var_14_3 = GetTips("CLUB_MOBILITY_DEPUTY")

			ShowMessageBox({
				isTop = true,
				content = string.format(var_14_3, var_14_2.name),
				OkCallback = function()
					GuildAction.GuildMobilityDeputy(arg_8_0.memberID_, function(arg_19_0)
						if isSuccess(arg_19_0.result) then
							-- block empty
						else
							ShowTips(arg_19_0.result)
						end

						arg_8_0:Back()
					end)
				end,
				CancelCallback = function()
					return
				end
			})
		end
	end)
end

return var_0_0
