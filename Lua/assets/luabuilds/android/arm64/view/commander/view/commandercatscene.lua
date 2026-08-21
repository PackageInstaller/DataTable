local var_0_0 = class("CommanderCatScene", import("view.base.BaseUI"))

var_0_0.MODE_VIEW = 1
var_0_0.MODE_SELECT = 2
var_0_0.SELECT_MODE_SINGLE = 1
var_0_0.SELECT_MODE_MULTI = 2
var_0_0.PAGE_PLAY = 1
var_0_0.PAGE_TALENT = 2
var_0_0.PAGE_DOCK = 3
var_0_0.FLEET_TYPE_COMMON = 1
var_0_0.FLEET_TYPE_ACTBOSS = 2
var_0_0.FLEET_TYPE_HARD_CHAPTER = 3
var_0_0.FLEET_TYPE_CHALLENGE = 4
var_0_0.FLEET_TYPE_GUILDBOSS = 5
var_0_0.FLEET_TYPE_WORLD = 6
var_0_0.FLEET_TYPE_BOSSRUSH = 7
var_0_0.FLEET_TYPE_LIMIT_CHALLENGE = 8
var_0_0.FLEET_TYPE_BOSSSINGLE = 9
var_0_0.FLEET_TYPE_BOSSSINGLE_VARIABLE = 10
var_0_0.EVENT_SELECTED = "CommanderCatScene:EVENT_SELECTED"
var_0_0.EVENT_BACK = "CommanderCatScene:EVENT_BACK"
var_0_0.EVENT_FOLD = "CommanderCatScene:EVENT_FOLD"
var_0_0.EVENT_PREV_ONE = "CommanderCatScene:EVENT_PREV_ONE"
var_0_0.EVENT_NEXT_ONE = "CommanderCatScene:EVENT_NEXT_ONE"
var_0_0.EVENT_CLOSE_DESC = "CommanderCatScene:EVENT_CLOSE_DESC"
var_0_0.EVENT_OPEN_DESC = "CommanderCatScene:EVENT_OPEN_DESC"
var_0_0.EVENT_UPGRADE = "CommanderCatScene:EVENT_UPGRADE"
var_0_0.EVENT_QUICKLY_TOOL = "CommanderCatScene:EVENT_QUICKLY_TOOL"
var_0_0.EVENT_SWITCH_PAGE = "CommanderCatScene:EVENT_SWITCH_PAGE"
var_0_0.EVENT_PREVIEW_PLAY = "CommanderCatScene:EVENT_PREVIEW_PLAY"
var_0_0.EVENT_PREVIEW = "CommanderCatScene:EVENT_PREVIEW"
var_0_0.EVENT_PREVIEW_REVERSE = "CommanderCatScene:EVENT_PREVIEW_REVERSE"
var_0_0.EVENT_PREVIEW_ADDITION = "CommanderCatScene:EVENT_PREVIEW_ADDITION"
var_0_0.MSG_RESERVE_BOX = "CommanderCatScene:MSG_RESERVE_BOX"
var_0_0.MSG_QUICKLY_FINISH_TOOL_ERROR = "CommanderCatScene:MSG_QUICKLY_FINISH_TOOL_ERROR"
var_0_0.MSG_UPGRADE = "CommanderCatScene:MSG_UPGRADE"
var_0_0.MSG_LOCK = "CommanderCatScene:MSG_LOCK"
var_0_0.MSG_RENAME = "CommanderCatScene:MSG_RENAME"
var_0_0.MSG_FETCH_TALENT_LIST = "CommanderCatScene:MSG_FETCH_TALENT_LIST"
var_0_0.MSG_LEARN_TALENT = "CommanderCatScene:MSG_LEARN_TALENT"
var_0_0.MSG_UPDATE = "CommanderCatScene:MSG_UPDATE"
var_0_0.MSG_HOME_TIP = "CommanderCatScene:MSG_HOME_TIP"
var_0_0.MSG_BUILD = "CommanderCatScene:MSG_BUILD"
var_0_0.MSG_OPEN_BOX = "CommanderCatScene:MSG_OPEN_BOX"
var_0_0.MSG_BATCH_BUILD = "CommanderCatScene:MSG_BATCH_BUILD"
var_0_0.MSG_RES_UPDATE = "CommanderCatScene:MSG_RES_UPDATE"

function var_0_0.getUIName(arg_1_0)
	return "CommanderCatUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bgTF = arg_2_0._tf:Find("background")
	arg_2_0.bgImg = arg_2_0.bgTF:GetComponent(typeof(Image))
	arg_2_0.paintingTF = arg_2_0._tf:Find("painting/frame")
	arg_2_0.blurPanel = arg_2_0._tf:Find("blur_panel")
	arg_2_0.backBtn = findTF(arg_2_0.blurPanel, "top/back_btn")
	arg_2_0.topPanel = findTF(arg_2_0.blurPanel, "top")
	arg_2_0.pageContainer = findTF(arg_2_0.blurPanel, "pages")
	arg_2_0.leftPanel = findTF(arg_2_0.blurPanel, "left_panel")
	arg_2_0.eyeBtn = findTF(arg_2_0.leftPanel, "eye")
	arg_2_0.helpBtn = findTF(arg_2_0.leftPanel, "help_btn")
	arg_2_0.titles = {
		[var_0_0.PAGE_PLAY] = findTF(arg_2_0._tf, "blur_panel/top/title/play"),
		[var_0_0.PAGE_TALENT] = findTF(arg_2_0._tf, "blur_panel/top/title/talent"),
		[var_0_0.PAGE_DOCK] = findTF(arg_2_0._tf, "blur_panel/top/title/Text")
	}
	arg_2_0.toggles = {
		[var_0_0.PAGE_PLAY] = findTF(arg_2_0.leftPanel, "toggles/play"),
		[var_0_0.PAGE_TALENT] = findTF(arg_2_0.leftPanel, "toggles/talent"),
		[var_0_0.PAGE_DOCK] = findTF(arg_2_0.leftPanel, "toggles/detail")
	}
	arg_2_0.pages = {
		[var_0_0.PAGE_PLAY] = CommanderCatPlayPage.New(arg_2_0.pageContainer, arg_2_0.event, arg_2_0.contextData),
		[var_0_0.PAGE_TALENT] = CommanderCatTalentPage.New(arg_2_0.pageContainer, arg_2_0.event, arg_2_0.contextData),
		[var_0_0.PAGE_DOCK] = CommanderCatDockPage.New(arg_2_0.pageContainer, arg_2_0.event, arg_2_0.contextData)
	}
	arg_2_0.detailPage = CommanderDetailPage.New(arg_2_0.pageContainer, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.contextData.msgBox = CommanderMsgBoxPage.New(pg.UIMgr.GetInstance().OverlayMain, arg_2_0.event)
	arg_2_0.contextData.treePanel = CommanderTreePage.New(pg.UIMgr.GetInstance().OverlayMain, arg_2_0.event)
	arg_2_0.commanderPaintingUtil = CommanderPaintingUtil.New(arg_2_0.paintingTF)
	;({})[1] = findTF(arg_2_0.blurPanel, "top/res/1/Text"):GetComponent(typeof(Text))
	;({})[2] = findTF(arg_2_0.blurPanel, "top/res/2/Text"):GetComponent(typeof(Text))
	;({})[3] = findTF(arg_2_0.blurPanel, "top/res/3/Text"):GetComponent(typeof(Text))
	arg_2_0.resources = {}
	arg_2_0.goldTxt = findTF(arg_2_0.blurPanel, "top/res/gold/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		if arg_3_0.pageType == var_0_0.PAGE_PLAY or arg_3_0.pageType == var_0_0.PAGE_TALENT then
			triggerButton(arg_3_0.toggles[var_0_0.PAGE_DOCK])
		else
			arg_3_0:emit(var_0_0.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_commander_info.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.eyeBtn, function()
		arg_3_0:Fold()

		return
	end, SFX_PANEL)
	addSlip(SLIP_TYPE_HRZ, arg_3_0.bgTF, function()
		arg_3_0:emit(CommanderCatScene.EVENT_PREV_ONE, arg_3_0.selectedCommander.id)

		return
	end, function()
		arg_3_0:emit(CommanderCatScene.EVENT_NEXT_ONE, arg_3_0.selectedCommander.id)

		return
	end)

	arg_3_0.contextData.mode = arg_3_0.contextData.mode or var_0_0.MODE_VIEW

	arg_3_0:RegisterEvent()
	arg_3_0:UpdateStyle()
	arg_3_0:UpdateResources()
	arg_3_0:UpdateGold()
	arg_3_0:UpdateToggles()
	triggerButton(arg_3_0.toggles[var_0_0.PAGE_DOCK])
	setActive(arg_3_0.toggles[var_0_0.PAGE_DOCK], false)

	return
end

function var_0_0.RegisterEvent(arg_9_0)
	arg_9_0:bind(var_0_0.EVENT_SELECTED, function(arg_10_0, arg_10_1, arg_10_2)
		arg_9_0:UpdateMainView(arg_10_1, arg_10_2)

		return
	end)
	arg_9_0:bind(var_0_0.EVENT_BACK, function(arg_11_0)
		arg_9_0:emit(var_0_0.ON_BACK)

		return
	end)
	arg_9_0:bind(var_0_0.MSG_RESERVE_BOX, function(arg_12_0, arg_12_1)
		arg_9_0:UpdateResources()
		arg_9_0:UpdateGold()

		return
	end)
	arg_9_0:bind(var_0_0.MSG_RES_UPDATE, function(arg_13_0)
		arg_9_0:UpdateGold()

		return
	end)
	arg_9_0:bind(var_0_0.MSG_BUILD, function(arg_14_0)
		arg_9_0:UpdateResources()

		return
	end)

	return
end

function var_0_0.UpdateStyle(arg_15_0)
	setActive(arg_15_0.helpBtn, var_0_0.MODE_VIEW == arg_15_0.contextData.mode)

	if arg_15_0.contextData.mode == var_0_0.MODE_SELECT then
		if arg_15_0.contextData.maxCount > 1 then
			setActive(arg_15_0.topPanel, false)
			onButton(arg_15_0, go(arg_15_0.bgTF), function()
				arg_15_0:emit(var_0_0.ON_BACK)

				return
			end, SOUND_BACK)
		end

		setActive(arg_15_0.leftPanel, false)
	end

	return
end

function var_0_0.UpdateResources(arg_17_0)
	for iter_17_0, iter_17_1 in pairs((getProxy(CommanderProxy):getPools())) do
		if arg_17_0.resources[iter_17_1.id] then
			arg_17_0.resources[iter_17_1.id].text = iter_17_1:getItemCount()
		end
	end

	return
end

function var_0_0.UpdateGold(arg_18_0)
	arg_18_0.goldTxt.text = getProxy(PlayerProxy):getRawData().gold

	return
end

function var_0_0.UpdateToggles(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.toggles) do
		onButton(arg_19_0, iter_19_1, function()
			if arg_19_0.pageType then
				setActive(arg_19_0.toggles[arg_19_0.pageType]:Find("Image"), false)
			end

			arg_19_0:SwitchPage(iter_19_0)
			setActive(iter_19_1:Find("Image"), true)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.SwitchPage(arg_21_0, arg_21_1)
	if (arg_21_1 == var_0_0.PAGE_PLAY or arg_21_1 == var_0_0.PAGE_TALENT) and not arg_21_0.selectedCommander then
		return
	end

	if arg_21_1 == var_0_0.PAGE_PLAY and arg_21_0.selectedCommander.inBattle then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_battle"))

		return
	end

	if arg_21_0.pageType then
		if arg_21_0.pages[arg_21_0.pageType]:GetLoaded() then
			arg_21_0.pages[arg_21_0.pageType]:Hide()
		end

		setActive(arg_21_0.titles[arg_21_0.pageType], false)
	end

	if arg_21_1 == var_0_0.PAGE_DOCK then
		var_21_0:ExecuteAction("Show")
	else
		var_21_0:ExecuteAction("Show", arg_21_0.selectedCommander)
	end

	setActive(arg_21_0.titles[arg_21_1], true)
	arg_21_0:CheckFirstHelp(arg_21_1)

	arg_21_0.pageType = arg_21_1

	arg_21_0:emit(var_0_0.EVENT_SWITCH_PAGE, arg_21_1)

	return
end

function var_0_0.CheckFirstHelp(arg_22_0, arg_22_1)
	if arg_22_1 == var_0_0.PAGE_PLAY then
		checkFirstHelpShow("help_commander_play")
	elseif arg_22_1 == var_0_0.PAGE_TALENT then
		checkFirstHelpShow("help_commander_ability")
	end

	return
end

function var_0_0.UpdateMainView(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_2 and arg_23_0.selectedCommander and arg_23_1.id == arg_23_0.selectedCommander.id then
		return
	end

	local var_23_0 = arg_23_1:getPainting()

	if not arg_23_0.paintingName or var_23_0 ~= arg_23_0.paintingName then
		arg_23_0.paintingName = var_23_0

		arg_23_0:ReturnCommanderPainting()
		setCommanderPaintingPrefab(arg_23_0.paintingTF, var_23_0, "info")

		local var_23_1 = arg_23_0.paintingTF:Find("fitter"):GetChild(0)

		if var_23_1 then
			var_23_1:GetComponent(typeof(Image)).raycastTarget = false
		end
	end

	local var_23_2 = arg_23_1:getConfig("bg")

	if arg_23_0.bgName ~= var_23_2 then
		LoadSpriteAsync("bg/commander_bg_" .. var_23_2, function(arg_24_0)
			if arg_23_0.exited then
				return
			end

			arg_23_0.bgImg.sprite = arg_24_0

			return
		end)

		arg_23_0.bgName = var_23_2
	end

	arg_23_0.detailPage:ExecuteAction("Update", arg_23_1, arg_23_0.contextData.mode == var_0_0.MODE_SELECT)

	local var_23_3 = arg_23_1:getTalentPoint()

	if var_23_3 > 0 then
		setText(arg_23_0.toggles[var_0_0.PAGE_TALENT]:Find("tip/Text"), var_23_3)
	end

	setActive(arg_23_0.toggles[var_0_0.PAGE_TALENT]:Find("tip"), var_23_3 > 0)

	arg_23_0.selectedCommander = arg_23_1

	return
end

function var_0_0.ReturnCommanderPainting(arg_25_0)
	if arg_25_0.selectedCommander then
		retCommanderPaintingPrefab(arg_25_0.paintingTF, arg_25_0.selectedCommander:getPainting())

		arg_25_0.selectedCommander = nil
	end

	return
end

function var_0_0.Fold(arg_26_0)
	if arg_26_0.doAnimation then
		return
	end

	arg_26_0.doAnimation = true

	arg_26_0.commanderPaintingUtil:Fold()
	LeanTween.moveX(rtf(arg_26_0.leftPanel), -300, 0.5)
	LeanTween.moveY(rtf(arg_26_0.topPanel), 300, 0.5):setOnComplete(System.Action(function()
		arg_26_0.doAnimation = false

		return
	end))
	onButton(arg_26_0, arg_26_0.bgTF, function()
		arg_26_0:UnFold()

		return
	end, SFX_PANEL)
	arg_26_0:emit(var_0_0.EVENT_FOLD, true)

	return
end

function var_0_0.UnFold(arg_29_0)
	if arg_29_0.doAnimation then
		return
	end

	arg_29_0.doAnimation = true

	removeOnButton(arg_29_0.bgTF)
	arg_29_0.commanderPaintingUtil:UnFold()
	LeanTween.moveX(rtf(arg_29_0.leftPanel), 0, 0.5)
	LeanTween.moveY(rtf(arg_29_0.topPanel), 0, 0.5):setOnComplete(System.Action(function()
		arg_29_0.doAnimation = false

		return
	end))
	arg_29_0:emit(var_0_0.EVENT_FOLD, false)

	return
end

function var_0_0.onBackPressed(arg_31_0)
	if arg_31_0.pageType and (arg_31_0.pageType == var_0_0.PAGE_PLAY or arg_31_0.pageType == var_0_0.PAGE_TALENT) then
		triggerButton(arg_31_0.toggles[var_0_0.PAGE_DOCK])

		return
	end

	if arg_31_0.contextData.msgBox and arg_31_0.contextData.msgBox:GetLoaded() and arg_31_0.contextData.msgBox:isShowing() then
		arg_31_0.contextData.msgBox:Hide()

		return
	end

	if arg_31_0.contextData.treePanel and arg_31_0.contextData.treePanel:GetLoaded() and arg_31_0.contextData.treePanel:isShowing() then
		arg_31_0.contextData.treePanel:Hide()

		return
	end

	if arg_31_0.pageType and arg_31_0.pages[arg_31_0.pageType] then
		if arg_31_0.pages[arg_31_0.pageType].CanBack and not arg_31_0.pages[arg_31_0.pageType]:CanBack() then
			return
		end
	end

	if arg_31_0.detailPage and arg_31_0.detailPage:GetLoaded() and arg_31_0.detailPage.CanBack and not arg_31_0.detailPage:CanBack() then
		return false
	end

	var_0_0.super.onBackPressed(arg_31_0)

	return
end

function var_0_0.willExit(arg_32_0)
	arg_32_0:ReturnCommanderPainting()

	for iter_32_0, iter_32_1 in pairs(arg_32_0.pages) do
		iter_32_1:Destroy()
	end

	arg_32_0.pages = {}

	if arg_32_0.detailPage then
		arg_32_0.detailPage:Destroy()

		arg_32_0.detailPage = nil
	end

	if arg_32_0.contextData.msgBox then
		arg_32_0.contextData.msgBox:Destroy()

		arg_32_0.contextData.msgBox = nil
	end

	if arg_32_0.contextData.treePanel then
		arg_32_0.contextData.treePanel:Destroy()

		arg_32_0.contextData.treePanel = nil
	end

	return
end

return var_0_0
