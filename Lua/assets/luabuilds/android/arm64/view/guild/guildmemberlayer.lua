local var_0_0 = class("GuildMemberLayer", import("..base.BaseUI"))

function var_0_0.setGuildVO(arg_1_0, arg_1_1)
	arg_1_0.guildVO = arg_1_1

	arg_1_0:setMemberVOs(arg_1_1:getSortMember())

	return
end

function var_0_0.setMemberVOs(arg_2_0, arg_2_1)
	arg_2_0.memberVOs = arg_2_1

	return
end

function var_0_0.setPlayerVO(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_0.SetRanks(arg_4_0, arg_4_1)
	arg_4_0.ranks = arg_4_1

	return
end

function var_0_0.getUIName(arg_5_0)
	return "GuildMemberUI"
end

function var_0_0.init(arg_6_0)
	arg_6_0.buttonsPanel = arg_6_0._tf:Find("buttons_panel")
	arg_6_0.toggleGroup = arg_6_0._tf:Find("buttons_panel"):GetComponent(typeof(ToggleGroup))
	arg_6_0.chatPanel = arg_6_0._tf:Find("chat")

	setActive(arg_6_0.chatPanel, false)
	setActive(arg_6_0.buttonsPanel, false)

	arg_6_0.btns = {
		arg_6_0._tf:Find("buttons_panel/info_btn"),
		arg_6_0._tf:Find("buttons_panel/duty_btn"),
		arg_6_0._tf:Find("buttons_panel/fire_btn"),
		arg_6_0._tf:Find("buttons_panel/impeach_btn")
	}
	arg_6_0.helpBtn = arg_6_0._tf:Find("help")
	arg_6_0.pages = {
		GuildMemberInfoPage.New(arg_6_0._tf, arg_6_0.event),
		GuildAppiontPage.New(arg_6_0._tf, arg_6_0.event),
		GuildFirePage.New(arg_6_0._tf, arg_6_0.event),
		GuildImpeachPage.New(arg_6_0._tf, arg_6_0.event)
	}
	arg_6_0.contextData.rankPage = GuildRankPage.New(arg_6_0._tf, arg_6_0.event)
	arg_6_0.listPage = GuildMemberListPage.New(arg_6_0._tf, arg_6_0.event, arg_6_0.contextData)

	function arg_6_0.listPage.OnClickMember(arg_7_0)
		arg_6_0:LoadPainting(arg_7_0)

		return
	end

	arg_6_0.buttonPos = arg_6_0.buttonsPanel.localPosition

	return
end

function var_0_0.didEnter(arg_8_0)
	local function var_8_0()
		if arg_8_0.page then
			setActive(arg_8_0.btns[table.indexof(arg_8_0.pages, arg_8_0.page)]:Find("sel"), false)
		end

		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.btns) do
		onButton(arg_8_0, iter_8_1, function()
			if iter_8_0 == 2 and arg_8_0.memberVO:IsRecruit() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_trainee_duty_change_tip"))

				return
			end

			if arg_8_0.page and not arg_8_0.page:GetLoaded() then
				return
			end

			local var_10_0 = arg_8_0.pages[iter_8_0]

			pg.UIMgr.GetInstance():LoadingOn()
			var_10_0:ExecuteAction("Show", arg_8_0.guildVO, arg_8_0.playerVO, arg_8_0.memberVO, function()
				if arg_8_0.page then
					arg_8_0.page:Hide()
				end

				var_8_0()
				setActive(iter_8_1:Find("sel"), true)

				arg_8_0.page = var_10_0

				pg.UIMgr.GetInstance():LoadingOff()

				return
			end)

			return
		end, SFX_PANEL)
		arg_8_0.pages[iter_8_0]:SetCallBack(function(arg_12_0)
			arg_8_0.buttonsPanel.localPosition = arg_12_0

			setParent(arg_8_0.buttonsPanel, pg.UIMgr.GetInstance().OverlayMain)

			return
		end, function()
			var_8_0()
			setParent(arg_8_0.buttonsPanel, arg_8_0._tf)

			arg_8_0.buttonsPanel.localPosition = arg_8_0.buttonPos

			return
		end)
	end

	onButton(arg_8_0, arg_8_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.guild_member_tip.tip
		})

		return
	end, SFX_PANEL)
	arg_8_0.listPage:ExecuteAction("SetUp", arg_8_0.guildVO, arg_8_0.memberVOs, arg_8_0.ranks)

	return
end

function var_0_0.LoadPainting(arg_15_0, arg_15_1)
	arg_15_0.memberVO = arg_15_1

	local var_15_0 = arg_15_1.duty
	local var_15_1 = arg_15_0.guildVO:getDutyByMemberId(arg_15_0.playerVO.id)

	setActive(arg_15_0.buttonsPanel, true)

	local var_15_2 = arg_15_1:GetManifesto()

	if HXSet.isHxPropose() then
		var_15_2 = ""
	end

	if not var_15_2 or var_15_2 == "" then
		setActive(arg_15_0.chatPanel, false)
	else
		setActive(arg_15_0.chatPanel, true)
		setText(arg_15_0.chatPanel:Find("Text"), var_15_2)
	end

	if HXSet.isHxPropose() then
		pg.GuildPaintingMgr.GetInstance():Update(arg_15_0.guildVO:GetOfficePainting(), Vector3(-643, -160, 0))
	else
		local var_15_4 = Ship.New({
			configId = arg_15_1.icon,
			skin_id = arg_15_1.skinId
		})

		pg.GuildPaintingMgr.GetInstance():Update(var_15_4:getPainting(), Vector3(-484, 0, 0), true)
	end

	setActive(arg_15_0.btns[4], var_15_1 == GuildConst.DUTY_DEPUTY_COMMANDER and var_15_0 == GuildConst.DUTY_COMMANDER and arg_15_1:isLongOffLine())

	local var_15_5 = (var_15_1 == GuildConst.DUTY_DEPUTY_COMMANDER or var_15_1 == GuildConst.DUTY_COMMANDER) and var_15_1 < var_15_0

	setButtonEnabled(arg_15_0.btns[2], (var_15_1 == GuildConst.DUTY_DEPUTY_COMMANDER or var_15_1 == GuildConst.DUTY_COMMANDER) and var_15_1 < var_15_0)
	setGray(arg_15_0.btns[2], not var_15_5, true)

	local var_15_6 = (var_15_1 == GuildConst.DUTY_DEPUTY_COMMANDER or var_15_1 == GuildConst.DUTY_COMMANDER) and var_15_1 < var_15_0

	setButtonEnabled(arg_15_0.btns[3], (var_15_1 == GuildConst.DUTY_DEPUTY_COMMANDER or var_15_1 == GuildConst.DUTY_COMMANDER) and var_15_1 < var_15_0)
	setGray(arg_15_0.btns[3], not var_15_6, true)

	return
end

function var_0_0.RefreshMembers(arg_16_0)
	if arg_16_0.listPage:GetLoaded() then
		arg_16_0.listPage:Flush(arg_16_0.guildVO, arg_16_0.memberVOs, arg_16_0.ranks)
	end

	return
end

function var_0_0.ActiveDefaultMenmber(arg_17_0)
	if arg_17_0.listPage:GetLoaded() then
		arg_17_0.listPage:TriggerFirstCard()
	end

	return
end

function var_0_0.UpdateRankList(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.ranks[arg_18_1] = arg_18_2

	if arg_18_0.contextData.rankPage and arg_18_0.contextData.rankPage:GetLoaded() then
		arg_18_0.contextData.rankPage:ExecuteAction("OnUpdateRankList", arg_18_1, arg_18_2)
	end

	return
end

function var_0_0.ShowInfoPanel(arg_19_0, arg_19_1)
	arg_19_0.pages[1]:ExecuteAction("Flush", arg_19_1)

	return
end

function var_0_0.onBackPressed(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.pages) do
		if iter_20_1:GetLoaded() and iter_20_1:isShowing() then
			iter_20_1:Hide()

			return
		end
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	arg_20_0:emit(var_0_0.ON_BACK)

	return
end

function var_0_0.willExit(arg_21_0)
	arg_21_0.contextData.rankPage:Destroy()

	arg_21_0.listPage.OnClickMember = nil

	arg_21_0.listPage:Destroy()

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.pages) do
		iter_21_1:Destroy()
	end

	if isActive(pg.MsgboxMgr.GetInstance()._go) then
		triggerButton(pg.MsgboxMgr.GetInstance()._closeBtn)
	end

	return
end

return var_0_0
