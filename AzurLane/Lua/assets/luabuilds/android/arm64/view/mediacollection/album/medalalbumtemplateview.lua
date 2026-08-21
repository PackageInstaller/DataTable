local var_0_0 = class("StarLightMedalAlbumView", import("view.base.BaseUI"))

var_0_0.ICON_SCALE = 1.35
var_0_0.MEDAL_COUNT = 8

function var_0_0.SetMedalGroupData(arg_1_0, arg_1_1)
	arg_1_0.medalGroupList = arg_1_1
	arg_1_0.currentMedalGroup = arg_1_0.medalGroupList[arg_1_0.GROUP_ID] or ActivityMedalGroup.New(arg_1_0.GROUP_ID)

	if arg_1_0.currentMedalGroup:GetMedalGroupState() == ActivityMedalGroup.STATE_ACTIVE then
		arg_1_0.medalTaskView:SetMedalGroup(arg_1_0.currentMedalGroup)
	end

	arg_1_0.medalDetailView:SetMedalGroup(arg_1_0.currentMedalGroup)

	local var_1_0 = arg_1_0.currentMedalGroup:GetMedalIds()

	for iter_1_0 = 1, arg_1_0.MEDAL_COUNT do
		LoadImageSpriteAsync("activitymedal/" .. var_1_0[iter_1_0] .. "_l", arg_1_0.slots[iter_1_0].slot, true)
		LoadImageSpriteAsync("activitymedal/" .. var_1_0[iter_1_0], arg_1_0.slots[iter_1_0].active, true)
	end

	return
end

function var_0_0.ShowPageBtn(arg_2_0, arg_2_1)
	setActive(arg_2_0.prevBtn, false)
	setActive(arg_2_0.nextBtn, false)

	return
end

function var_0_0.UpdateMedalList(arg_3_0)
	return
end

function var_0_0.init(arg_4_0)
	arg_4_0:FindUI()

	arg_4_0.loader = AutoLoader.New()

	return
end

function var_0_0.FindUI(arg_5_0)
	local var_5_0 = arg_5_0._tf:Find("Top")

	arg_5_0.bg = arg_5_0._tf:Find("mask")
	arg_5_0.backBtn = var_5_0:Find("BackBtn")
	arg_5_0.helpBtn = var_5_0:Find("InfoBtn")
	arg_5_0.taskBtn = arg_5_0._tf:Find("Desk/taskBtn")
	arg_5_0.prevBtn = arg_5_0._tf:Find("Desk/prevBtn")
	arg_5_0.nextBtn = arg_5_0._tf:Find("Desk/nextBtn")
	arg_5_0.slots = {}

	for iter_5_0 = 1, arg_5_0.MEDAL_COUNT do
		arg_5_0.slots[iter_5_0] = {
			slot = arg_5_0._tf:Find("Desk/Slot" .. iter_5_0),
			active = arg_5_0._tf:Find("Desk/Slot" .. iter_5_0 .. "/active"),
			tips = arg_5_0._tf:Find("Desk/Slot" .. iter_5_0 .. "/reddot"),
			click = arg_5_0._tf:Find("Desk/Slot" .. iter_5_0 .. "/Click")
		}
	end

	arg_5_0.medalLock = arg_5_0._tf:Find("Desk/medal")
	arg_5_0.trophyLock = arg_5_0._tf:Find("Desk/trophy")
	arg_5_0.medalDetailView = MedalDetailPanel.New(arg_5_0._tf:Find("DetailView"), arg_5_0)

	arg_5_0.medalDetailView:SetIconScale(arg_5_0.ICON_SCALE)

	arg_5_0.medalTaskView = MedalTaskPanel.New(arg_5_0._tf:Find("TaskView"), arg_5_0)

	return
end

function var_0_0.didEnter(arg_6_0)
	var_0_0.super.didEnter(arg_6_0)
	arg_6_0:AddListener()
	arg_6_0:UpdateView()
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	return
end

function var_0_0.AddListener(arg_7_0)
	onButton(arg_7_0, arg_7_0.backBtn, function()
		arg_7_0:closeView()

		return
	end, SFX_CANCEL)

	for iter_7_0 = 1, arg_7_0.MEDAL_COUNT do
		onButton(arg_7_0, arg_7_0.slots[iter_7_0].click, function()
			arg_7_0:showMedalView(iter_7_0)

			return
		end)
	end

	onButton(arg_7_0, arg_7_0.taskBtn, function()
		arg_7_0:showTaskView()

		return
	end)
	onButton(arg_7_0, arg_7_0.bg, function()
		arg_7_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[arg_7_0.HELP_TIPS].tip
		})

		return
	end)
	onButton(arg_7_0, arg_7_0.medalLock, function()
		local var_13_0 = arg_7_0.currentMedalGroup:getConfig("item_show")[2]

		arg_7_0:emit(BaseUI.ON_DROP, {
			type = var_13_0[1],
			id = var_13_0[2],
			count = var_13_0[3]
		})

		return
	end, SFX_PANEL)

	if arg_7_0.trophyLock then
		onButton(arg_7_0, arg_7_0.trophyLock, function()
			local var_14_0 = arg_7_0.currentMedalGroup:getConfig("item_show")[1]

			arg_7_0:emit(BaseUI.ON_DROP, {
				type = var_14_0[1],
				id = var_14_0[2],
				count = var_14_0[3]
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.showMedalView(arg_15_0, arg_15_1)
	arg_15_0.medalDetailView:SetCurrentIndex(arg_15_1)
	arg_15_0.medalDetailView:UpdateMedal()
	arg_15_0.medalDetailView:SetActive(true)

	return
end

function var_0_0.showTaskView(arg_16_0)
	arg_16_0.medalTaskView:ShowMedalTask()
	arg_16_0.medalTaskView:SetActive(true)

	return
end

function var_0_0.UpdateView(arg_17_0)
	local var_17_0 = arg_17_0.currentMedalGroup:GetMedalIds()
	local var_17_1 = arg_17_0.currentMedalGroup:GetMedalList()

	for iter_17_0 = 1, arg_17_0.MEDAL_COUNT do
		if var_17_1[var_17_0[iter_17_0]].timeStamp then
			setActive(arg_17_0.slots[iter_17_0].active, true)
		else
			setActive(arg_17_0.slots[iter_17_0].active, false)
		end
	end

	if arg_17_0.trophyLock then
		arg_17_0.trophyLock:GetComponent(typeof(Image)).enabled = not arg_17_0:OwnTrophy()
	end

	arg_17_0.medalLock:GetComponent(typeof(Image)).enabled = not arg_17_0:OwnMedal()

	setActive(arg_17_0.taskBtn, arg_17_0.currentMedalGroup:GetMedalGroupState() == ActivityMedalGroup.STATE_ACTIVE)

	return
end

function var_0_0.OwnTrophy(arg_18_0)
	local var_18_0 = arg_18_0.currentMedalGroup:getConfig("task_show")
	local var_18_1 = -1

	if var_18_0 and type(var_18_0) == "table" then
		var_18_1 = var_18_0[1]
	end

	if var_18_1 <= 0 then
		return false
	end

	return Task.OwnSpAward(pg.task_data_template[var_18_1].award_display[1])
end

function var_0_0.OwnMedal(arg_19_0)
	local var_19_0 = arg_19_0.currentMedalGroup:getConfig("task_show")
	local var_19_1 = -1

	if var_19_0 and type(var_19_0) == "table" then
		var_19_1 = var_19_0[2]
	end

	if var_19_1 <= 0 then
		return false
	end

	return Task.OwnSpAward(pg.task_data_template[var_19_1].award_display[#pg.task_data_template[var_19_1].award_display])
end

function var_0_0.FlushTaskPanel(arg_20_0)
	arg_20_0.medalTaskView:SetMedalGroup(arg_20_0.currentMedalGroup)
	arg_20_0.medalTaskView:ShowMedalTask()

	return
end

function var_0_0.willExit(arg_21_0)
	arg_21_0.medalDetailView:SetActive(false)
	arg_21_0.medalTaskView:SetActive(false)
	arg_21_0.medalDetailView:Dispose()
	arg_21_0.medalTaskView:Dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0._tf)
	arg_21_0.loader:Clear()

	return
end

return var_0_0
