local var_0_0 = class("GuildManagerItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.commonPortrait_ = CommonHeadPortrait.New(arg_1_0.headItem_)

	arg_1_0:AddListeners()

	arg_1_0.memberController_ = arg_1_0.controller:GetController("playerState")
	arg_1_0.postController_ = arg_1_0.controller:GetController("posts")
	arg_1_0.buttonController_ = arg_1_0.btnControllerEx_:GetController("btnState")
	arg_1_0.onlineController = arg_1_0.onlineControllerEx_:GetController("online")

	arg_1_0:RegisterEvents()
end

function var_0_0.RegisterEvents(arg_2_0)
	arg_2_0:RegistEventListener(GUILD_CAPTAIN_IMPEACH, function()
		if arg_2_0.isMember_ then
			local var_3_0 = arg_2_0.id_

			if GuildData:GetGuildMemberData(var_3_0).post == GuildConst.GUILD_POST.CAPTAIN then
				arg_2_0:SetData(var_3_0, arg_2_0.isMember_, nil)
			end
		end
	end)
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_4_0)
	arg_4_0:RemoveAllEventListener()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0.commonPortrait_:RegisteClickCallback(function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_5_0.id_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonRemove_, nil, function()
		if not GuildTools:CheckCanExitGuild() then
			return
		end

		local var_7_0 = GuildData:GetGuildMemberData(arg_5_0.id_)
		local var_7_1 = GetTips("CLUB_REMOVE_MEMBER")

		ShowMessageBox({
			isTop = true,
			content = string.format(var_7_1, var_7_0.name),
			OkCallback = function()
				GuildAction.GuildRemoveMember(arg_5_0.id_, function(arg_9_0)
					ShowTips(arg_9_0.result)
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonPost_, nil, function()
		JumpTools.OpenPageByJump("guildMobilityPost", {
			memberID = arg_5_0.id_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonImpeach_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CLUB_IMPEACH_TIPS"),
			OkCallback = function()
				GuildAction.GuildImpeach(arg_5_0.id_, function(arg_14_0)
					ShowTips(arg_14_0.result)
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonCancelImpeach_, nil, function()
		GuildAction.GuildCancelImpeach(function(arg_17_0)
			if isSuccess(arg_17_0.result) then
				-- block empty
			else
				ShowTips(arg_17_0.result)
			end
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonAgree_, nil, function()
		GuildAction.GuildAgreeRequest(arg_5_0.id_, function(arg_19_0)
			if isSuccess(arg_19_0.result) then
				-- block empty
			else
				ShowTips(arg_19_0.result)
			end
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonRefuse_, nil, function()
		GuildAction.GuildRefuseRequest(arg_5_0.id_, function(arg_21_0)
			if isSuccess(arg_21_0.result) then
				-- block empty
			else
				ShowTips(arg_21_0.result)
			end
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.applyBtn_, nil, function()
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

function var_0_0.SetData(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0.id_ = arg_26_1
	arg_26_0.isMember_ = arg_26_2

	local var_26_0

	if arg_26_2 then
		var_26_0 = GuildData:GetGuildMemberData(arg_26_1)

		local var_26_1 = GuildData:GetGuildInfo()

		if var_26_1.post == GuildConst.GUILD_POST.CAPTAIN then
			if var_26_0.id == USER_ID then
				if var_26_1.impeachTime - manager.time:GetServerTime() > 0 then
					arg_26_0.buttonController_:SetSelectedState("impeach")
				else
					arg_26_0.buttonController_:SetSelectedState("null")
				end
			elseif var_26_0.post == GuildConst.GUILD_POST.TRAINEE then
				arg_26_0.buttonController_:SetSelectedState("remove")
			else
				arg_26_0.buttonController_:SetSelectedState("captain")
			end
		elseif var_26_1.post == GuildConst.GUILD_POST.DEPUTY then
			if var_26_0.id == USER_ID or var_26_0.post == GuildConst.GUILD_POST.DEPUTY then
				arg_26_0.buttonController_:SetSelectedState("null")
			elseif var_26_0.post == GuildConst.GUILD_POST.CAPTAIN then
				if var_26_1.impeachTime - manager.time:GetServerTime() > 0 then
					if var_26_1.isCandidate then
						arg_26_0.buttonController_:SetSelectedState("applied")
					else
						arg_26_0.buttonController_:SetSelectedState("impeaching")
					end
				else
					local var_26_2 = GuildData:GetCaptainOfflineTime()

					if manager.time:GetServerTime() > var_26_2 + 864000 then
						arg_26_0.buttonController_:SetSelectedState("deputy")
					else
						arg_26_0.buttonController_:SetSelectedState("null")
					end
				end
			else
				arg_26_0.buttonController_:SetSelectedState("remove")
			end
		elseif var_26_0.post == GuildConst.GUILD_POST.CAPTAIN then
			if var_26_1.impeachTime - manager.time:GetServerTime() > 0 then
				if var_26_1.isCandidate then
					arg_26_0.buttonController_:SetSelectedState("applied")
				else
					arg_26_0.buttonController_:SetSelectedState("impeaching")
				end
			else
				local var_26_3 = GuildData:GetCaptainOfflineTime()

				if manager.time:GetServerTime() > var_26_3 + 864000 then
					arg_26_0.buttonController_:SetSelectedState("deputy")
				else
					arg_26_0.buttonController_:SetSelectedState("null")
				end
			end
		else
			arg_26_0.buttonController_:SetSelectedState("null")
		end

		if arg_26_3 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
			arg_26_0.memberController_:SetSelectedState("member")
		else
			arg_26_0.memberController_:SetSelectedState("controubite")
		end
	else
		arg_26_0.memberController_:SetSelectedState("run")

		var_26_0 = GuildData:GetGuildRequestData(arg_26_1)

		arg_26_0.buttonController_:SetSelectedState("request")
	end

	arg_26_0.commonPortrait_:RenderHead(var_26_0.icon)
	arg_26_0.commonPortrait_:RenderFrame(var_26_0.frame)

	arg_26_0.textName_.text = GetI18NText(var_26_0.name)
	arg_26_0.textLevel_.text = GetTips("LEVEL") .. string.format("%s", var_26_0.level)
	arg_26_0.textContribute_.text = GetI18NText(var_26_0.weekContribute)

	if arg_26_3 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		arg_26_0.textContribute_.text = GetI18NText(var_26_0.contribute)
	end

	if var_26_0.offlineStamptime == 0 then
		arg_26_0.textOnline_.text = manager.time:GetOnLineText(var_26_0.offlineStamptime)

		arg_26_0.onlineController:SetSelectedState("yes")
	else
		arg_26_0.textOnline_.text = manager.time:GetOnLineText(var_26_0.offlineStamptime)

		arg_26_0.onlineController:SetSelectedState("no")
	end

	if var_26_0.post == GuildConst.GUILD_POST.CAPTAIN then
		arg_26_0.labelText_.text = GetTips("CLUB_CHAIR_MAN")

		arg_26_0.postController_:SetSelectedState("CAPTAIN")
	elseif var_26_0.post == GuildConst.GUILD_POST.DEPUTY then
		arg_26_0.labelText_.text = GetTips("CLUB_VICE_CHAIR_MAN")

		arg_26_0.postController_:SetSelectedState("DEPUTY")
	elseif var_26_0.post == GuildConst.GUILD_POST.MEMBER then
		arg_26_0.labelText_.text = GetTips("CLUB_MEMBER")

		arg_26_0.postController_:SetSelectedState("MEMBER")
	elseif var_26_0.post == GuildConst.GUILD_POST.TRAINEE then
		arg_26_0.labelText_.text = GetTips("CLUB_NOVICIATE")

		arg_26_0.postController_:SetSelectedState("TRAINEE")
	end
end

function var_0_0.RefreshTimer(arg_27_0)
	if arg_27_0.isMember_ and arg_27_0.id_ then
		local var_27_0 = GuildData:GetGuildInfo()
		local var_27_1 = GuildData:GetGuildMemberData(arg_27_0.id_)

		if var_27_0 and var_27_1 then
			if var_27_0.post and var_27_0.post == GuildConst.GUILD_POST.CAPTAIN then
				if var_27_1.id and var_27_1.id == USER_ID and var_27_0.impeachTime and var_27_0.impeachTime - manager.time:GetServerTime() > 0 then
					arg_27_0:CalTimer()
				end
			elseif var_27_0.post and var_27_0.post == GuildConst.GUILD_POST.DEPUTY then
				if var_27_1.id and var_27_1.id == USER_ID or var_27_1.post == GuildConst.GUILD_POST.DEPUTY then
					arg_27_0.buttonController_:SetSelectedState("null")
				elseif var_27_1.post == GuildConst.GUILD_POST.CAPTAIN and var_27_0.impeachTime and var_27_0.impeachTime - manager.time:GetServerTime() > 0 then
					if var_27_0.isCandidate then
						arg_27_0.buttonController_:SetSelectedState("applied")
					else
						arg_27_0.buttonController_:SetSelectedState("impeaching")
					end

					arg_27_0:CalTimer()
				end
			elseif var_27_1.post and var_27_1.post == GuildConst.GUILD_POST.CAPTAIN and var_27_0.impeachTime and var_27_0.impeachTime - manager.time:GetServerTime() > 0 then
				if var_27_0.isCandidate then
					arg_27_0.buttonController_:SetSelectedState("applied")
				else
					arg_27_0.buttonController_:SetSelectedState("impeaching")
				end

				arg_27_0:CalTimer()
			end
		end
	end
end

function var_0_0.CalTimer(arg_28_0)
	local var_28_0 = GuildData:GetGuildInfo()

	arg_28_0.textCountdown_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCDTime(var_28_0.impeachTime - manager.time:GetServerTime(), "%H:%M:%S"))

	local var_28_1 = var_28_0.impeachTime - manager.time:GetServerTime()

	arg_28_0.textCountdown_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCDTime(var_28_1, "%H:%M:%S"))

	if var_28_1 <= 0 then
		GuildAction.RequiredGuildMemberList(function(arg_29_0)
			if isSuccess(arg_29_0) then
				manager.notify:Invoke(GUILD_CAPTAIN_IMPEACH)
			end
		end)
	end
end

return var_0_0
