local var_0_0 = class("RefluxScene", import("..base.BaseUI"))

var_0_0.Sign = 1
var_0_0.Task = 2
var_0_0.PT = 3
var_0_0.Shop = 4

function var_0_0.getUIName(arg_1_0)
	return "RefluxUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	if getProxy(ShopsProxy):ShouldRefreshChargeList() then
		pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
			callback = function()
				arg_2_1()

				return
			end
		})
	else
		(function()
			arg_2_1()

			return
		end)()
	end

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0:findUI()
	arg_4_0:initData()
	arg_4_0:addListener()

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:updateRedPotList()

	if not getProxy(RefluxProxy):isInRefluxTime() then
		arg_5_0:closeView()

		return
	end

	if not arg_5_0:tryOpenLetterView() then
		arg_5_0:tryAutoOpenLastView()
	end

	arg_5_0:updateDay()

	return
end

function var_0_0.willExit(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.viewList) do
		if iter_6_1 and iter_6_1:GetLoaded() then
			iter_6_1:Destroy()
		end
	end

	return
end

function var_0_0.onBackPressed(arg_7_0)
	if arg_7_0.letterView and arg_7_0.letterView:isShowing() then
		arg_7_0.letterView:OnBackPress()

		return
	end

	arg_7_0:closeView()

	return
end

function var_0_0.findUI(arg_8_0)
	arg_8_0.letterContainer = arg_8_0._tf:Find("PanelLetter")
	arg_8_0.panelContainer = arg_8_0._tf:Find("PanelContainer")

	local var_8_0 = arg_8_0._tf:Find("left/left_bar")

	arg_8_0.letterBtn = var_8_0:Find("letter")
	arg_8_0.signToggle = var_8_0:Find("tabs/sign")
	arg_8_0.taskToggle = var_8_0:Find("tabs/task")
	arg_8_0.ptToggle = var_8_0:Find("tabs/pt")
	arg_8_0.shopToggle = var_8_0:Find("tabs/shop")
	arg_8_0.toggleList = {
		[var_0_0.Sign] = arg_8_0.signToggle,
		[var_0_0.Task] = arg_8_0.taskToggle,
		[var_0_0.PT] = arg_8_0.ptToggle,
		[var_0_0.Shop] = arg_8_0.shopToggle
	}
	arg_8_0.redPotList = {
		[var_0_0.Sign] = arg_8_0.signToggle:Find("Red"),
		[var_0_0.Task] = arg_8_0.taskToggle:Find("Red"),
		[var_0_0.PT] = arg_8_0.ptToggle:Find("Red"),
		[var_0_0.Shop] = arg_8_0.shopToggle:Find("Red")
	}
	arg_8_0.backBtn = var_8_0:Find("back")
	arg_8_0.dayText = arg_8_0._tf:Find("time/text")

	setText(arg_8_0._tf:Find("time/icon"), i18n("reflux_word_1"))
	setText(arg_8_0._tf:Find("time/icon1"), i18n("word_date"))

	return
end

function var_0_0.initData(arg_9_0)
	arg_9_0.curViewIndex = 0
	arg_9_0.letterView = RefluxLetterView.New(arg_9_0.letterContainer, arg_9_0.event, arg_9_0.contextData)
	arg_9_0.signView = RefluxSignView.New(arg_9_0.panelContainer, arg_9_0.event, arg_9_0.contextData)
	arg_9_0.taskView = RefluxTaskView.New(arg_9_0.panelContainer, arg_9_0.event, arg_9_0.contextData)
	arg_9_0.ptView = RefluxPTView.New(arg_9_0.panelContainer, arg_9_0.event, arg_9_0.contextData)
	arg_9_0.shopView = RefluxShopView.New(arg_9_0.panelContainer, arg_9_0.event, arg_9_0.contextData)
	arg_9_0.viewList = {
		[var_0_0.Sign] = arg_9_0.signView,
		[var_0_0.Task] = arg_9_0.taskView,
		[var_0_0.PT] = arg_9_0.ptView,
		[var_0_0.Shop] = arg_9_0.shopView
	}

	return
end

function var_0_0.addListener(arg_10_0)
	onButton(arg_10_0, arg_10_0.backBtn, function()
		arg_10_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_10_0, arg_10_0.letterBtn, function()
		arg_10_0:switchLetter()

		return
	end, SFX_PANEL)
	onToggle(arg_10_0, arg_10_0.signToggle, function(arg_13_0)
		if arg_13_0 == true then
			arg_10_0:switchPage(var_0_0.Sign)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_10_0, arg_10_0.taskToggle, function(arg_14_0)
		if arg_14_0 == true then
			arg_10_0:switchPage(var_0_0.Task)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_10_0, arg_10_0.ptToggle, function(arg_15_0)
		if arg_15_0 == true then
			arg_10_0:switchPage(var_0_0.PT)
		end

		return
	end, SFX_PANEL)
	onToggle(arg_10_0, arg_10_0.shopToggle, function(arg_16_0)
		if arg_16_0 == true then
			arg_10_0:switchPage(var_0_0.Shop)
			arg_10_0:updateRedPotList()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.tryOpenLetterView(arg_17_0)
	local var_17_0 = getProxy(PlayerProxy):getRawData().id .. "_" .. getProxy(RefluxProxy).returnTimestamp

	if PlayerPrefs.GetInt(var_17_0, 0) ~= 1 then
		PlayerPrefs.SetInt(var_17_0, 1)
		PlayerPrefs.Save()
		arg_17_0.letterView:ActionInvoke("setCloseFunc", function()
			triggerToggle(arg_17_0.toggleList[var_0_0.Sign], true)

			return
		end)
		arg_17_0:switchLetter()

		return true
	else
		return false
	end

	return
end

function var_0_0.switchPage(arg_19_0, arg_19_1)
	if arg_19_0.curViewIndex ~= arg_19_1 then
		arg_19_0.viewList[arg_19_1]:Load()
		arg_19_0.viewList[arg_19_1]:ActionInvoke("Show")
		arg_19_0.viewList[arg_19_1]:ActionInvoke("updateOutline")

		if arg_19_0.curViewIndex > 0 then
			arg_19_0.viewList[arg_19_0.curViewIndex]:Hide()
		end

		arg_19_0.curViewIndex = arg_19_1
		arg_19_0.contextData.lastViewIndex = arg_19_1
	end

	return
end

function var_0_0.tryAutoOpenLastView(arg_20_0)
	if arg_20_0.contextData.lastViewIndex then
		triggerToggle(arg_20_0.toggleList[arg_20_0.contextData.lastViewIndex], true)
	else
		triggerToggle(arg_20_0.toggleList[var_0_0.Sign], true)
	end

	return
end

function var_0_0.switchLetter(arg_21_0)
	arg_21_0.letterView:Load()
	arg_21_0.letterView:ActionInvoke("Show")

	return
end

function var_0_0.updateRedPotList(arg_22_0)
	setActive(arg_22_0.redPotList[var_0_0.Sign], false)
	setActive(arg_22_0.redPotList[var_0_0.Task], (RefluxTaskView.isAnyTaskCanGetAward()))
	setActive(arg_22_0.redPotList[var_0_0.PT], (RefluxPTView.isAnyPTCanGetAward()))
	setActive(arg_22_0.redPotList[var_0_0.Shop], (RefluxShopView.isShowRedPot()))

	return
end

function var_0_0.updateDay(arg_23_0)
	local var_23_0 = pg.TimeMgr.GetInstance()

	setText(arg_23_0.dayText, #pg.return_sign_template.all - math.clamp(var_23_0:DiffDay(getProxy(RefluxProxy).returnTimestamp, var_23_0:GetServerTime()), 0, #pg.return_sign_template.all - 1))

	return
end

return var_0_0
