local var_0_0 = class("PublicGuildMainScene", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "PublicGuildMainUI"
end

function var_0_0.OnUpdateDonateList(arg_2_0)
	if arg_2_0.page and isa(arg_2_0.page, PublicGuildOfficePage) and arg_2_0.page:GetLoaded() then
		arg_2_0.page:Flush()
	end

	return
end

function var_0_0.OnPlayerUpdate(arg_3_0, arg_3_1)
	arg_3_0:SetPlayer(arg_3_1)

	if arg_3_0.resPage and arg_3_0.resPage:GetLoaded() then
		arg_3_0.resPage:Update(arg_3_1)
	end

	return
end

function var_0_0.OnTechGroupUpdate(arg_4_0, arg_4_1)
	if arg_4_0.page and isa(arg_4_0.page, PublicGuildTechnologyPage) and arg_4_0.page:GetLoaded() then
		arg_4_0.page:OnTechGroupUpdate(arg_4_1)
	end

	return
end

function var_0_0.RefreshAll(arg_5_0)
	if arg_5_0.page and arg_5_0.page:GetLoaded() then
		arg_5_0.page:Show(arg_5_0.publicGuild)
	end

	return
end

function var_0_0.SetPublicGuild(arg_6_0, arg_6_1)
	arg_6_0.publicGuild = arg_6_1

	return
end

function var_0_0.SetPlayer(arg_7_0, arg_7_1)
	arg_7_0.player = arg_7_1

	return
end

function var_0_0.init(arg_8_0)
	arg_8_0._playerResOb = arg_8_0._tf:Find("blur_panel/adapt/top/res")
	arg_8_0.resPage = PublicGuildResPage.New(arg_8_0._playerResOb, arg_8_0.event)
	arg_8_0.backBtn = arg_8_0._tf:Find("blur_panel/adapt/top/back")
	arg_8_0.helpBtn = arg_8_0._tf:Find("blur_panel/adapt/left_length/frame/help")
	arg_8_0.toggles = {
		arg_8_0._tf:Find("blur_panel/adapt/left_length/frame/scroll_rect/tagRoot/office"),
		arg_8_0._tf:Find("blur_panel/adapt/left_length/frame/scroll_rect/tagRoot/technology")
	}

	local var_8_0 = arg_8_0._tf:Find("pages")

	arg_8_0.pages = {
		PublicGuildOfficePage.New(var_8_0, arg_8_0.event),
		PublicGuildTechnologyPage.New(var_8_0, arg_8_0.event)
	}

	return
end

function var_0_0.didEnter(arg_9_0)
	pg.GuildPaintingMgr.GetInstance():Enter(arg_9_0._tf:Find("bg/painting"))
	arg_9_0.resPage:ExecuteAction("Update", arg_9_0.player)
	onButton(arg_9_0, arg_9_0.backBtn, function()
		arg_9_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.helpBtn, function()
		if isa(arg_9_0.page, PublicGuildOfficePage) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("guild_public_office_tip")
			})
		elseif isa(arg_9_0.page, PublicGuildTechnologyPage) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("guild_public_tech_tip")
			})
		end

		return
	end, SFX_PANEL)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.toggles) do
		onToggle(arg_9_0, iter_9_1, function(arg_12_0)
			if arg_12_0 then
				arg_9_0:SwitchPage(iter_9_0)
			end

			return
		end, SFX_PANEL)

		if iter_9_0 == 1 then
			triggerToggle(iter_9_1, true)
		end
	end

	return
end

function var_0_0.SwitchPage(arg_13_0, arg_13_1)
	if arg_13_0.page then
		arg_13_0.page:Hide()
	end

	arg_13_0.pages[arg_13_1]:ExecuteAction("Show", arg_13_0.publicGuild)

	arg_13_0.page = arg_13_0.pages[arg_13_1]

	return
end

function var_0_0.willExit(arg_14_0)
	pg.GuildPaintingMgr.GetInstance():Exit()
	arg_14_0.resPage:Destroy()

	for iter_14_0, iter_14_1 in pairs(arg_14_0.pages) do
		iter_14_1:Destroy()
	end

	return
end

return var_0_0
