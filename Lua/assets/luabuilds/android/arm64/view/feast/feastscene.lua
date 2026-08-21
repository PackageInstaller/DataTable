local var_0_0 = class("FeastScene", import("view.base.BaseUI"))

var_0_0.PAGE_INVITATION = 1
var_0_0.ON_TASK_UPDATE = "FeastScene:ON_TASK_UPDATE"
var_0_0.ON_ACT_UPDATE = "FeastScene:ON_ACT_UPDATE"
var_0_0.ON_SKIP_GIVE_GIFT = "FeastScene:ON_SKIP_GIVE_GIFT"
var_0_0.ON_BACK_FEAST = "FeastScene:ON_BACK_FEAST"
var_0_0.ON_MAKE_TICKET = "FeastScene:ON_MAKE_TICKET"
var_0_0.ON_GOT_TICKET = "FeastScene:ON_GOT_TICKET"
var_0_0.ON_GOT_GIFT = "FeastScene:ON_GOT_GIFT"
var_0_0.GO_INTERACTION = "FeastScene:GO_INTERACTION"
var_0_0.GO_INVITATION = "FeastScene:GO_INVITATION"

function var_0_0.getUIName(arg_1_0)
	return "FeastUI"
end

function var_0_0.forceGC(arg_2_0)
	return true
end

function var_0_0.PlayBGM(arg_3_0)
	pg.CriMgr.GetInstance():StopBGM()

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.mainCG = GetOrAddComponent(arg_4_0._tf, typeof(CanvasGroup))
	arg_4_0.backBtn = arg_4_0._tf:Find("main/return")
	arg_4_0.invitationBtn = arg_4_0._tf:Find("btns/invitation")
	arg_4_0.invitationBtnTip = arg_4_0.invitationBtn:Find("tip")
	arg_4_0.taskBtn = arg_4_0._tf:Find("btns/task")
	arg_4_0.taskBtnTip = arg_4_0.taskBtn:Find("tip")
	arg_4_0.invitationPage = FeastInvitationPage.New(arg_4_0._tf, arg_4_0.event)
	arg_4_0.taskPage = FeastTaskPage.New(arg_4_0._tf, arg_4_0.event)
	arg_4_0.helpBtn = arg_4_0._tf:Find("main/help")
	arg_4_0.homeBtn = arg_4_0._tf:Find("main/home")
	arg_4_0.buffUIlist = UIItemList.New(arg_4_0._tf:Find("main/buffs"), arg_4_0._tf:Find("main/buffs/tpl"))

	setText(arg_4_0.invitationBtn:Find("Text"), i18n("feast_invitation_btn_label"))
	setText(arg_4_0.taskBtn:Find("Text"), i18n("feast_task_btn_label"))

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:BlockEvents()
	arg_5_0:SetUpCourtYard()

	return
end

function var_0_0.OnCourtYardLoaded(arg_6_0)
	arg_6_0:UnBlockEvents()
	onButton(arg_6_0, arg_6_0.backBtn, function()
		arg_6_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.invitationBtn, function()
		arg_6_0.invitationPage:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.taskBtn, function()
		arg_6_0.taskPage:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.feast_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.homeBtn, function()
		arg_6_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	arg_6_0:bind(FeastScene.ON_TASK_UPDATE, function()
		arg_6_0:UpdateTips()

		return
	end)
	arg_6_0:bind(FeastScene.ON_ACT_UPDATE, function()
		arg_6_0:UpdateTips()

		return
	end)
	arg_6_0:bind(FeastScene.ON_GOT_GIFT, function()
		arg_6_0:UpdateTips()

		return
	end)
	arg_6_0:bind(FeastScene.ON_GOT_TICKET, function()
		arg_6_0:UpdateTips()

		return
	end)
	arg_6_0:bind(FeastScene.GO_INTERACTION, function()
		if arg_6_0.taskPage and arg_6_0.taskPage:GetLoaded() and arg_6_0.taskPage:isShowing() then
			arg_6_0.taskPage:Hide()
		end

		return
	end)
	arg_6_0:bind(FeastScene.GO_INVITATION, function()
		if arg_6_0.taskPage and arg_6_0.taskPage:GetLoaded() and arg_6_0.taskPage:isShowing() then
			arg_6_0.taskPage:Hide()
		end

		arg_6_0.invitationPage:ExecuteAction("Show")

		return
	end)
	arg_6_0:bind(FeastScene.ON_ACT_UPDATE, function()
		arg_6_0:UpdateBuffs()

		return
	end)
	arg_6_0:bind(FeastScene.ON_BACK_FEAST, function()
		if arg_6_0.invitationPage and arg_6_0.invitationPage:GetLoaded() and arg_6_0.invitationPage:isShowing() then
			arg_6_0.invitationPage:Hide()
		end

		return
	end)
	arg_6_0:PlayEnterStory()
	arg_6_0:UpdateTips()
	arg_6_0:UpdateBuffs()

	if arg_6_0.contextData.page and arg_6_0.contextData.page == var_0_0.PAGE_INVITATION then
		triggerButton(arg_6_0.invitationBtn)
	end

	return
end

function var_0_0.UpdateBuffs(arg_20_0)
	local var_20_0 = getProxy(FeastProxy):GetBuffList()

	arg_20_0.buffUIlist:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = var_20_0[arg_21_1 + 1]

			onButton(arg_20_0, arg_21_2, function()
				arg_20_0:emit(BaseUI.ON_DROP, {
					type = DROP_TYPE_BUFF,
					id = var_21_0.id
				})

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_20_0.buffUIlist:align(#getProxy(FeastProxy):GetBuffList())

	return
end

function var_0_0.PlayEnterStory(arg_23_0)
	local var_23_9000
	local var_23_0 = getProxy(ActivityProxy)
	local var_23_1 = var_23_0.getActivityByType(var_23_9000, ActivityConst.ACTIVITY_TYPE_FEAST):getConfig("config_client")[6]

	if var_23_0 and var_23_1 ~= "" then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(var_23_1) then
			pg.NewStoryMgr.GetInstance():Play(var_23_1)
		end
	end

	return
end

function var_0_0.UpdateTips(arg_24_0)
	setActive(arg_24_0.invitationBtnTip, getProxy(FeastProxy):ShouldTipInvitation())
	setActive(arg_24_0.taskBtnTip, getProxy(FeastProxy):ShouldTipTask())

	return
end

function var_0_0.SetUpCourtYard(arg_25_0)
	arg_25_0.contextData.mode = CourtYardConst.SYSTEM_FEAST

	arg_25_0:emit(FeastMediator.SET_UP, 1)

	return
end

function var_0_0.BlockEvents(arg_26_0)
	arg_26_0.mainCG.blocksRaycasts = false

	return
end

function var_0_0.UnBlockEvents(arg_27_0)
	arg_27_0.mainCG.blocksRaycasts = true

	return
end

function var_0_0.onBackPressed(arg_28_0)
	if arg_28_0.invitationPage and arg_28_0.invitationPage:GetLoaded() and arg_28_0.invitationPage:isShowing() then
		arg_28_0.invitationPage:onBackPressed()

		return
	end

	if arg_28_0.taskPage and arg_28_0.taskPage:GetLoaded() and arg_28_0.taskPage:isShowing() then
		arg_28_0.taskPage:Hide()

		return
	end

	arg_28_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

function var_0_0.willExit(arg_29_0)
	if arg_29_0.invitationPage then
		arg_29_0.invitationPage:Destroy()

		arg_29_0.invitationPage = nil
	end

	if arg_29_0.taskPage then
		arg_29_0.taskPage:Destroy()

		arg_29_0.taskPage = nil
	end

	return
end

return var_0_0
