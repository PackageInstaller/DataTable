local var_0_0 = class("SculptureScene", import("view.base.BaseUI"))

var_0_0.OPEN_GRATITUDE_PAGE = "SculptureScene:OPEN_GRATITUDE_PAGE"

local var_0_1 = 5
local var_0_2 = 6

function var_0_0.getUIName(arg_1_0)
	return "SculptureUI"
end

function var_0_0.SetActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	return
end

function var_0_0.GetBaseActivity(arg_3_0)
	return getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)
end

function var_0_0.OnUpdateActivity(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:SetActivity(arg_4_3)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.cards) do
		if iter_4_1.id == arg_4_2 then
			iter_4_1:Flush(arg_4_3)

			break
		end
	end

	if arg_4_1 == SculptureActivity.STATE_FINSIH then
		if arg_4_0.gratitudePage and arg_4_0.gratitudePage:GetLoaded() then
			arg_4_0.gratitudePage:Flush(arg_4_3)
		end

		arg_4_0:UpdateAward()
	elseif arg_4_1 == SculptureActivity.STATE_UNLOCK then
		arg_4_0:EnterDrawLinePage(arg_4_2)
		arg_4_0:UpdateRes()
	elseif arg_4_1 == SculptureActivity.STATE_DRAW then
		arg_4_0:EnterPuzzlePage(arg_4_2)
	elseif arg_4_1 == SculptureActivity.STATE_JOINT then
		arg_4_0:EnterPresentedPage(arg_4_2)
	end

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.backBtn = arg_5_0._tf:Find("back")
	arg_5_0.helpBtn = arg_5_0._tf:Find("help")
	arg_5_0.awardBtn = arg_5_0._tf:Find("award")
	arg_5_0.awardTxt = arg_5_0._tf:Find("award/Text"):GetComponent(typeof(Text))
	arg_5_0.ore = arg_5_0._tf:Find("ore")
	arg_5_0.oreIcon = arg_5_0._tf:Find("ore/icon"):GetComponent(typeof(Image))
	arg_5_0.oreTxt = arg_5_0._tf:Find("ore/Text"):GetComponent(typeof(Text))
	arg_5_0.feather = arg_5_0._tf:Find("feather")
	arg_5_0.featherIcon = arg_5_0._tf:Find("feather/icon"):GetComponent(typeof(Image))
	arg_5_0.featherTxt = arg_5_0._tf:Find("feather/Text"):GetComponent(typeof(Text))
	arg_5_0.tpl = arg_5_0._tf:Find("frame/content/tpl")

	setActive(arg_5_0.tpl, false)

	arg_5_0.tpls = {}
	arg_5_0.drawLinePage = SculptureDrawLinePage.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextData)
	arg_5_0.puzzlePage = SculpturePuzzlePage.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextData)
	arg_5_0.presentedPage = SculpturePresentedPage.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextData)
	arg_5_0.gratitudePage = SculptureGratitudePage.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextDat)
	arg_5_0.awardInfoPage = SculptureAwardInfoPage.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextDat)
	arg_5_0.resMsgBoxPage = SculptureResMsgBoxPage.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.contextData.msgBoxPage = SculptureMsgBoxPage.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.contextData.tipPage = SculptureTipPage.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.contextData.miniMsgBox = SculptureMiniMsgBoxPage.New(arg_5_0._tf, arg_5_0.event)
	Input.multiTouchEnabled = false

	arg_5_0:bind(var_0_0.OPEN_GRATITUDE_PAGE, function(arg_6_0, arg_6_1)
		arg_5_0.gratitudePage:ExecuteAction("Show", arg_6_1, arg_5_0.activity, function()
			if arg_5_0.presentedPage and arg_5_0.presentedPage:GetLoaded() then
				arg_5_0.presentedPage:Hide()
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.didEnter(arg_8_0)
	seriesAsync({
		function(arg_9_0)
			arg_8_0:UpdateResIcon()
			arg_8_0:UpdateRes()
			arg_8_0:UpdateAward()
			arg_8_0:InitMainView(arg_9_0)

			return
		end,
		function(arg_10_0)
			arg_8_0:RegisterEvent(arg_10_0)

			return
		end
	})

	return
end

function var_0_0.UpdateResIcon(arg_11_0)
	arg_11_0.oreIcon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[var_0_1].icon)
	arg_11_0.featherIcon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[var_0_2].icon)
	rtf(arg_11_0.oreIcon.gameObject).sizeDelta = Vector2(80, 80)
	rtf(arg_11_0.featherIcon.gameObject).sizeDelta = Vector2(80, 80)

	return
end

function var_0_0.InitMainView(arg_12_0, arg_12_1)
	arg_12_0.cards = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.activity:getConfig("config_data")) do
		table.insert({}, function(arg_13_0)
			local var_13_0 = #arg_12_0.tpls > 0
			local var_13_1 = #arg_12_0.tpls > 0 and table.remove(arg_12_0.tpls, 1) or Object.Instantiate(arg_12_0.tpl, arg_12_0.tpl.parent).transform

			setActive(var_13_1, true)
			table.insert(arg_12_0.cards, (arg_12_0:CreateNewCard(var_13_1, iter_12_1)))

			if not var_13_0 then
				onNextTick(arg_13_0)
			else
				arg_13_0()
			end

			return
		end)
	end

	seriesAsync({}, arg_12_1)

	return
end

function var_0_0.UpdateRes(arg_14_0)
	local var_14_0 = arg_14_0:GetBaseActivity()

	arg_14_0.oreTxt.text = var_14_0:getVitemNumber(var_0_1)
	arg_14_0.featherTxt.text = var_14_0:getVitemNumber(var_0_2)

	return
end

function var_0_0.UpdateAward(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0.activity:GetAwardProgress()

	arg_15_0.awardTxt.text = var_15_0 .. "/" .. var_15_1

	return
end

function var_0_0.CreateNewCard(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = SculptureCard.New(arg_16_1)

	var_16_0:Update(arg_16_2, arg_16_0.activity)
	onButton(arg_16_0, var_16_0.continueBtn, function()
		local var_17_0 = arg_16_0.activity:GetSculptureState(arg_16_2)

		if var_17_0 == SculptureActivity.STATE_UNLOCK then
			arg_16_0:EnterDrawLinePage(arg_16_2)
		elseif var_17_0 == SculptureActivity.STATE_DRAW then
			arg_16_0:EnterPuzzlePage(arg_16_2)
		end

		return
	end, SFX_PANEL)
	onButton(arg_16_0, var_16_0.lockBtn, function()
		local var_18_0, var_18_1 = arg_16_0.activity:_GetComsume(arg_16_2)

		arg_16_0.contextData.msgBoxPage:ExecuteAction("Show", {
			nextBtn = true,
			content = arg_16_0.activity:getDataConfig(arg_16_2, "describe"),
			consume = var_18_1,
			consumeId = var_18_0,
			onYes = function()
				arg_16_0:emit(SculptureMediator.ON_UNLOCK_SCULPTURE, arg_16_2)

				return
			end,
			iconName = arg_16_0.activity:GetResorceName(arg_16_2),
			title = arg_16_0.activity:GetResorceName(arg_16_2) .. "_title"
		})

		return
	end, SFX_PANEL)
	onButton(arg_16_0, var_16_0.finishBtn, function()
		arg_16_0.contextData.msgBoxPage:ExecuteAction("Show", {
			content = arg_16_0.activity:getDataConfig(arg_16_2, "describe"),
			title = arg_16_0.activity:GetResorceName(arg_16_2) .. "_title"
		})

		return
	end, SFX_PANEL)
	onButton(arg_16_0, var_16_0.tr, function()
		if arg_16_0.activity:GetSculptureState(arg_16_2) == SculptureActivity.STATE_FINSIH then
			triggerButton(var_16_0.finishBtn)
		else
			triggerButton(var_16_0.continueBtn)
		end

		return
	end, SFX_PANEL)
	onButton(arg_16_0, var_16_0.presentedBtn, function()
		arg_16_0:EnterPresentedPage(arg_16_2)

		return
	end, SFX_PANEL)

	return var_16_0
end

function var_0_0.RegisterEvent(arg_23_0, arg_23_1)
	onButton(arg_23_0, arg_23_0.backBtn, function()
		arg_23_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_23_0, arg_23_0.awardBtn, function()
		arg_23_0.awardInfoPage:ExecuteAction("Show", arg_23_0.activity)

		return
	end, SFX_PANEL)
	onButton(arg_23_0, arg_23_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.gift_act_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_23_0, arg_23_0.ore, function()
		arg_23_0.resMsgBoxPage:ExecuteAction("Show", var_0_1)

		return
	end, SFX_PANEL)
	onButton(arg_23_0, arg_23_0.feather, function()
		arg_23_0.resMsgBoxPage:ExecuteAction("Show", var_0_2)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.EnterDrawLinePage(arg_29_0, arg_29_1)
	arg_29_0.drawLinePage:ExecuteAction("Show", arg_29_1, arg_29_0.activity)

	return
end

function var_0_0.EnterPresentedPage(arg_30_0, arg_30_1)
	arg_30_0.presentedPage:ExecuteAction("Show", arg_30_1, arg_30_0.activity, function()
		if arg_30_0.puzzlePage and arg_30_0.puzzlePage:GetLoaded() then
			arg_30_0.puzzlePage:Hide()
		end

		return
	end)

	return
end

function var_0_0.EnterPuzzlePage(arg_32_0, arg_32_1)
	arg_32_0.puzzlePage:ExecuteAction("Show", arg_32_1, arg_32_0.activity, function()
		if arg_32_0.drawLinePage and arg_32_0.drawLinePage:GetLoaded() then
			arg_32_0.drawLinePage:Hide()
		end

		return
	end)

	return
end

function var_0_0.onBackPressed(arg_34_0)
	var_0_0.super.onBackPressed(arg_34_0)

	return
end

function var_0_0.willExit(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.cards) do
		iter_35_1:Dispose()
	end

	arg_35_0.cards = nil

	if arg_35_0.contextData.msgBoxPage then
		arg_35_0.contextData.msgBoxPage:Destroy()

		arg_35_0.contextData.msgBoxPage = nil
	end

	if arg_35_0.drawLinePage then
		arg_35_0.drawLinePage:Destroy()

		arg_35_0.drawLinePage = nil
	end

	if arg_35_0.contextData.tipPage then
		arg_35_0.contextData.tipPage:Destroy()

		arg_35_0.contextData.tipPage = nil
	end

	if arg_35_0.puzzlePage then
		arg_35_0.puzzlePage:Destroy()

		arg_35_0.puzzlePage = nil
	end

	if arg_35_0.contextData.miniMsgBox then
		arg_35_0.contextData.miniMsgBox:Destroy()

		arg_35_0.contextData.miniMsgBox = nil
	end

	if arg_35_0.awardInfoPage then
		arg_35_0.awardInfoPage:Destroy()

		arg_35_0.awardInfoPage = nil
	end

	if arg_35_0.resMsgBoxPage then
		arg_35_0.resMsgBoxPage:Destroy()

		arg_35_0.resMsgBoxPage = nil
	end

	Input.multiTouchEnabled = true

	return
end

return var_0_0
