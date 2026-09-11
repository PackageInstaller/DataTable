local GuildManagerItem = class("GuildManagerItem", ReduxView)

function GuildManagerItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()

	self.memberController_ = self.controller:GetController("playerState")
	self.postController_ = self.controller:GetController("posts")
	self.buttonController_ = self.btnControllerEx_:GetController("btnState")
	self.onlineController = self.onlineControllerEx_:GetController("online")

	self:RegisterEvents()
end

function GuildManagerItem:RegisterEvents()
	self:RegistEventListener(GUILD_CAPTAIN_IMPEACH, function()
		if self.isMember_ then
			if GuildData:GetGuildMemberData(self.id_).post == GuildConst.GUILD_POST.CAPTAIN then
				self:SetData(self.id_, self.isMember_, nil)
			end
		end
	end)
end

function GuildManagerItem:Dispose()
	self.commonPortrait_:Dispose()
	GuildManagerItem.super.Dispose(self)
	self:RemoveAllEventListener()
end

function GuildManagerItem:AddListeners()
	self.commonPortrait_:RegisteClickCallback(function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(self.id_)
	end)
	self:AddBtnListener(self.buttonRemove_, nil, function()
		local var_7_0

		if not GuildTools:CheckCanExitGuild() then
			do return end

			var_7_0 = {
				isTop = true
			}
		end

		var_7_0.content = string.format(GetTips("CLUB_REMOVE_MEMBER"), GuildData:GetGuildMemberData(self.id_).name)

		function var_7_0.OkCallback()
			GuildAction.GuildRemoveMember(self.id_, function(arg_9_0)
				ShowTips(arg_9_0.result)
			end)
		end

		function var_7_0.CancelCallback()
			return
		end

		ShowMessageBox(var_7_0)
	end)
	self:AddBtnListener(self.buttonPost_, nil, function()
		JumpTools.OpenPageByJump("guildMobilityPost", {
			memberID = self.id_
		})
	end)
	self:AddBtnListener(self.buttonImpeach_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CLUB_IMPEACH_TIPS"),
			OkCallback = function()
				GuildAction.GuildImpeach(self.id_, function(arg_14_0)
					ShowTips(arg_14_0.result)
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.buttonCancelImpeach_, nil, function()
		GuildAction.GuildCancelImpeach(function(arg_17_0)
			if isSuccess(arg_17_0.result) then
				-- block empty
			else
				ShowTips(arg_17_0.result)
			end
		end)
	end)
	self:AddBtnListener(self.buttonAgree_, nil, function()
		GuildAction.GuildAgreeRequest(self.id_, function(arg_19_0)
			if isSuccess(arg_19_0.result) then
				-- block empty
			else
				ShowTips(arg_19_0.result)
			end
		end)
	end)
	self:AddBtnListener(self.buttonRefuse_, nil, function()
		GuildAction.GuildRefuseRequest(self.id_, function(arg_21_0)
			if isSuccess(arg_21_0.result) then
				-- block empty
			else
				ShowTips(arg_21_0.result)
			end
		end)
	end)
	self:AddBtnListener(self.applyBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CLUB_APPLY_CAPTAIN_TIPS"),
			OkCallback = function()
				GuildAction.ApplyCaptain(function(arg_24_0)
					ShowTips(arg_24_0.result)
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function GuildManagerItem:SetData(arg_26_1, arg_26_2, arg_26_3)
	self.id_ = arg_26_1
	self.isMember_ = arg_26_2

	local var_26_0

	if arg_26_2 then
		var_26_0 = GuildData:GetGuildMemberData(arg_26_1)

		local var_26_1 = GuildData:GetGuildInfo()

		if var_26_1.post == GuildConst.GUILD_POST.CAPTAIN then
			if var_26_0.id == USER_ID then
				if var_26_1.impeachTime - manager.time:GetServerTime() > 0 then
					self.buttonController_:SetSelectedState("impeach")
				else
					self.buttonController_:SetSelectedState("null")
				end
			elseif var_26_0.post == GuildConst.GUILD_POST.TRAINEE then
				self.buttonController_:SetSelectedState("remove")
			else
				self.buttonController_:SetSelectedState("captain")
			end
		elseif var_26_1.post == GuildConst.GUILD_POST.DEPUTY then
			if var_26_0.id == USER_ID or var_26_0.post == GuildConst.GUILD_POST.DEPUTY then
				self.buttonController_:SetSelectedState("null")
			elseif var_26_0.post == GuildConst.GUILD_POST.CAPTAIN then
				if var_26_1.impeachTime - manager.time:GetServerTime() > 0 then
					if var_26_1.isCandidate then
						self.buttonController_:SetSelectedState("applied")
					else
						self.buttonController_:SetSelectedState("impeaching")
					end
				elseif manager.time:GetServerTime() > GuildData:GetCaptainOfflineTime() + 864000 then
					self.buttonController_:SetSelectedState("deputy")
				else
					self.buttonController_:SetSelectedState("null")
				end
			else
				self.buttonController_:SetSelectedState("remove")
			end
		elseif var_26_0.post == GuildConst.GUILD_POST.CAPTAIN then
			if var_26_1.impeachTime - manager.time:GetServerTime() > 0 then
				if var_26_1.isCandidate then
					self.buttonController_:SetSelectedState("applied")
				else
					self.buttonController_:SetSelectedState("impeaching")
				end
			elseif manager.time:GetServerTime() > GuildData:GetCaptainOfflineTime() + 864000 then
				self.buttonController_:SetSelectedState("deputy")
			else
				self.buttonController_:SetSelectedState("null")
			end
		else
			self.buttonController_:SetSelectedState("null")
		end

		if arg_26_3 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
			self.memberController_:SetSelectedState("member")
		else
			self.memberController_:SetSelectedState("controubite")
		end
	else
		self.memberController_:SetSelectedState("run")

		var_26_0 = GuildData:GetGuildRequestData(arg_26_1)

		self.buttonController_:SetSelectedState("request")
	end

	self.commonPortrait_:RenderHead(var_26_0.icon)
	self.commonPortrait_:RenderFrame(var_26_0.frame)

	self.textName_.text = GetI18NText(var_26_0.name)
	self.textLevel_.text = GetTips("LEVEL") .. string.format("%s", var_26_0.level)
	self.textContribute_.text = GetI18NText(var_26_0.weekContribute)

	if arg_26_3 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		self.textContribute_.text = GetI18NText(var_26_0.contribute)
	end

	if var_26_0.offlineStamptime == 0 then
		self.textOnline_.text = manager.time:GetOnLineText(var_26_0.offlineStamptime)

		self.onlineController:SetSelectedState("yes")
	else
		self.textOnline_.text = manager.time:GetOnLineText(var_26_0.offlineStamptime)

		self.onlineController:SetSelectedState("no")
	end

	if var_26_0.post == GuildConst.GUILD_POST.CAPTAIN then
		self.labelText_.text = GetTips("CLUB_CHAIR_MAN")

		self.postController_:SetSelectedState("CAPTAIN")
	elseif var_26_0.post == GuildConst.GUILD_POST.DEPUTY then
		self.labelText_.text = GetTips("CLUB_VICE_CHAIR_MAN")

		self.postController_:SetSelectedState("DEPUTY")
	elseif var_26_0.post == GuildConst.GUILD_POST.MEMBER then
		self.labelText_.text = GetTips("CLUB_MEMBER")

		self.postController_:SetSelectedState("MEMBER")
	elseif var_26_0.post == GuildConst.GUILD_POST.TRAINEE then
		self.labelText_.text = GetTips("CLUB_NOVICIATE")

		self.postController_:SetSelectedState("TRAINEE")
	end
end

function GuildManagerItem:RefreshTimer()
	if self.isMember_ and self.id_ then
		local var_27_0 = GuildData:GetGuildInfo()
		local var_27_1 = GuildData:GetGuildMemberData(self.id_)

		if var_27_0 and var_27_1 then
			if var_27_0.post and var_27_0.post == GuildConst.GUILD_POST.CAPTAIN then
				if var_27_1.id and var_27_1.id == USER_ID and var_27_0.impeachTime and var_27_0.impeachTime - manager.time:GetServerTime() > 0 then
					self:CalTimer()
				end
			elseif var_27_0.post and var_27_0.post == GuildConst.GUILD_POST.DEPUTY then
				if var_27_1.id and var_27_1.id == USER_ID or var_27_1.post == GuildConst.GUILD_POST.DEPUTY then
					self.buttonController_:SetSelectedState("null")
				elseif var_27_1.post == GuildConst.GUILD_POST.CAPTAIN and var_27_0.impeachTime and var_27_0.impeachTime - manager.time:GetServerTime() > 0 then
					if var_27_0.isCandidate then
						self.buttonController_:SetSelectedState("applied")
					else
						self.buttonController_:SetSelectedState("impeaching")
					end

					self:CalTimer()
				end
			elseif var_27_1.post and var_27_1.post == GuildConst.GUILD_POST.CAPTAIN and var_27_0.impeachTime and var_27_0.impeachTime - manager.time:GetServerTime() > 0 then
				if var_27_0.isCandidate then
					self.buttonController_:SetSelectedState("applied")
				else
					self.buttonController_:SetSelectedState("impeaching")
				end

				self:CalTimer()
			end
		end
	end
end

function GuildManagerItem:CalTimer()
	local var_28_0 = GuildData:GetGuildInfo()

	self.textCountdown_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCDTime(var_28_0.impeachTime - manager.time:GetServerTime(), "%H:%M:%S"))

	local var_28_1 = var_28_0.impeachTime - manager.time:GetServerTime()

	self.textCountdown_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCDTime(var_28_1, "%H:%M:%S"))

	if var_28_1 <= 0 then
		GuildAction.RequiredGuildMemberList(function(arg_29_0)
			if isSuccess(arg_29_0) then
				manager.notify:Invoke(GUILD_CAPTAIN_IMPEACH)
			end
		end)
	end
end

return GuildManagerItem
