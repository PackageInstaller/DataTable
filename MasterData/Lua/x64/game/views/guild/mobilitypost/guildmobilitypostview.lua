local GuildMobilityPostView = class("GuildMobilityPostView", ReduxView)

function GuildMobilityPostView:UIName()
	return "Widget/System/Club/ClubMobilityPostPopUI"
end

function GuildMobilityPostView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildMobilityPostView:Init()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()
end

function GuildMobilityPostView:OnEnter()
	self.memberID_ = self.params_.memberID

	self:RefreshPlayerInfo()

	self.mobilityDeputyText_.text = GuildData:GetGuildMemberData(self.memberID_).post == GuildConst.GUILD_POST.DEPUTY and GetTips("ERROR_CLUB_VICE_CHAIRMAN_CANCEL") or GetTips("ERROR_CLUB_VICE_CHAIRMAN_APPOINT")
end

function GuildMobilityPostView:RefreshPlayerInfo()
	local var_5_0 = GuildData:GetGuildMemberData(self.memberID_)

	self.nameText_.text = var_5_0.name

	self.commonPortrait_:RenderHead(var_5_0.icon)
	self.commonPortrait_:RenderFrame(var_5_0.frame)
end

function GuildMobilityPostView:OnExit()
	return
end

function GuildMobilityPostView:Dispose()
	self.commonPortrait_:Dispose()
	GuildMobilityPostView.super.Dispose(self)
end

function GuildMobilityPostView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonMobilityCaptain_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = string.format(GetTips("CLUB_MOBILITY_CAPTAIN"), GuildData:GetGuildMemberData(self.memberID_).name),
			OkCallback = function()
				GuildAction.GuildMobilityCaptain(self.memberID_, function(arg_12_0)
					if isSuccess(arg_12_0.result) then
						-- block empty
					else
						ShowTips(arg_12_0.result)
					end

					self:Go("/guildEntrace/guildMain")
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.buttonMobilityDeputy_, nil, function()
		if GuildData:GetGuildMemberData(self.memberID_).post == GuildConst.GUILD_POST.DEPUTY then
			ShowMessageBox({
				isTop = true,
				content = string.format(GetTips("CLUB_DISMISS"), GuildData:GetGuildMemberData(self.memberID_).name),
				OkCallback = function()
					GuildAction.GuildDismiss(self.memberID_, function(arg_16_0)
						if isSuccess(arg_16_0.result) then
							-- block empty
						else
							ShowTips(arg_16_0.result)
						end

						self:Back()
					end)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			local var_14_0 = {
				isTop = true
			}

			var_14_0.content = string.format(GetTips("CLUB_MOBILITY_DEPUTY"), GuildData:GetGuildMemberData(self.memberID_).name)

			function var_14_0.OkCallback()
				GuildAction.GuildMobilityDeputy(self.memberID_, function(arg_19_0)
					if isSuccess(arg_19_0.result) then
						-- block empty
					else
						ShowTips(arg_19_0.result)
					end

					self:Back()
				end)
			end

			function var_14_0.CancelCallback()
				return
			end

			ShowMessageBox(var_14_0)
		end
	end)
end

return GuildMobilityPostView
