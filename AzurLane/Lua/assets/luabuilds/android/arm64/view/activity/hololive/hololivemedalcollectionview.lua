local var_0_0 = class("HololiveMedalCollectionView", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "HololiveMedalCollectionUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:InitData()
	arg_2_0:FindUI()
	arg_2_0:AddListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:UpdateView()

	return
end

function var_0_0.InitData(arg_4_0)
	arg_4_0.taskProxy = getProxy(TaskProxy)
	arg_4_0.actMedal = getProxy(ActivityProxy):getActivityById(ActivityConst.HOLOLIVE_MEDAL_COLLECTION)
	arg_4_0.allIDList = arg_4_0.actMedal:getConfig("config_data")
	arg_4_0.taskGroup = pg.activity_template[ActivityConst.HOLOLIVE_MEDAL_COLLECTION_TASK].config_data
	arg_4_0.activatableIDList = arg_4_0.actMedal.data1_list
	arg_4_0.activeIDList = arg_4_0.actMedal.data2_list

	return
end

local var_0_1 = {
	"mio",
	"fubuki",
	"matsuri",
	"sora",
	"shion",
	"aqua",
	"ayame",
	"purer",
	"tnt"
}
local var_0_2 = {
	1,
	2,
	3,
	6,
	9,
	8,
	7,
	4,
	5
}

function var_0_0.FindUI(arg_5_0)
	arg_5_0.bg = arg_5_0._tf:Find("bg")
	arg_5_0.top = arg_5_0._tf:Find("top")
	arg_5_0.backBtn = arg_5_0.top:Find("back")
	arg_5_0.helpBtn = arg_5_0.top:Find("help")
	arg_5_0.progressText = arg_5_0._tf:Find("middle/board/progress")
	arg_5_0.taskScroll = arg_5_0._tf:Find("middle/board/Scroll View")
	arg_5_0.taskScrollBar = arg_5_0._tf:Find("middle/board/Scrollbar")
	arg_5_0.taskListItems = CustomIndexLayer.Clone2Full(arg_5_0.taskScroll:Find("Content"), #arg_5_0.taskGroup)
	arg_5_0.medalListItems = CustomIndexLayer.Clone2Full(arg_5_0._tf:Find("middle/console/grid"), 9)
	arg_5_0.medalImg = arg_5_0._tf:Find("middle/console/slot"):GetComponent(typeof(Image))
	arg_5_0.medalGet = arg_5_0._tf:Find("middle/console/get")
	arg_5_0.medalGot = arg_5_0._tf:Find("middle/console/got")

	for iter_5_0 = 1, #arg_5_0.taskGroup do
		local var_5_0 = LoadSprite("ui/HololiveMedalCollectionUI_atlas", var_0_1[iter_5_0])
		local var_5_1 = arg_5_0.taskListItems[iter_5_0]:Find("icon"):GetComponent(typeof(Image))

		var_5_1.sprite = var_5_0
		var_5_1.enabled = true

		local var_5_2 = arg_5_0.medalListItems[var_0_2[iter_5_0]]:Find("icon"):GetComponent(typeof(Image))

		var_5_2.sprite = var_5_0
		var_5_2.enabled = true
	end

	arg_5_0.materialGray = LoadAny("ui/HololiveMedalCollectionUI_atlas", "gray.mat")

	return
end

function var_0_0.AddListener(arg_6_0)
	onButton(arg_6_0, arg_6_0.backBtn, function()
		arg_6_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_dalaozhang.tip
		})

		return
	end, SFX_PANEL)

	local var_6_0 = arg_6_0._tf:Find("middle/board/arrow")

	onScroll(arg_6_0, arg_6_0.taskScroll, function(arg_9_0)
		setActive(var_6_0, arg_9_0.y > 0.001)

		return
	end)
	onButton(arg_6_0, arg_6_0.medalGet, function()
		arg_6_0:GetFinal()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.DataSetting(arg_11_0)
	if #arg_11_0.activatableIDList > 0 then
		local var_11_0

		while #arg_11_0.activatableIDList >= 1 do
			if not table.contains(arg_11_0.activeIDList, arg_11_0.activatableIDList[1]) then
				var_11_0 = arg_11_0.activatableIDList[1]

				break
			end
		end

		if var_11_0 then
			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = var_11_0,
				actId = ActivityConst.HOLOLIVE_MEDAL_COLLECTION
			})

			return true
		end
	end

	return
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0:InitData()

	if arg_12_0:DataSetting() then
		return
	end

	local var_12_0 = #arg_12_0.activeIDList == #arg_12_0.allIDList and arg_12_0.actMedal.data1 ~= 1
	local var_12_1 = arg_12_0.actMedal.data1 == 1
	local var_12_2 = 0

	for iter_12_0 = 1, #arg_12_0.taskGroup do
		local var_12_4 = arg_12_0.taskGroup[iter_12_0]
		local var_12_5 = arg_12_0.taskProxy:getTaskVO(arg_12_0.taskGroup[iter_12_0])
		local var_12_6 = arg_12_0.taskListItems[iter_12_0]:Find("btn_go")
		local var_12_7 = arg_12_0.taskListItems[iter_12_0]:Find("btn_get")
		local var_12_8 = arg_12_0.taskListItems[iter_12_0]:Find("btn_got")
		local var_12_9 = table.contains(arg_12_0.activeIDList, arg_12_0.allIDList[iter_12_0])
		local var_12_10
		local var_12_11 = 0

		if var_12_5 then
			setText(var_12_3:Find("desc"), (string.gsub(string.gsub(var_12_5:getConfig("desc"), "$1", (var_12_5:getProgress())), "$2", (var_12_5:getConfig("target_num")))))

			var_12_11 = var_12_5:getTaskStatus()
			var_12_10 = var_12_11 == 2 and arg_12_0.materialGray or nil

			onButton(arg_12_0, var_12_6, function()
				arg_12_0:emit(ActivityMediator.ON_TASK_GO, var_12_5)

				return
			end, SFX_PANEL)
			onButton(arg_12_0, var_12_7, function()
				arg_12_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_12_5)

				return
			end, SFX_PANEL)
		else
			local var_12_12 = pg.task_data_template[var_12_4].target_num

			setText(var_12_3:Find("desc"), (string.gsub(string.gsub(pg.task_data_template[var_12_4].desc, "$1", var_12_9 and var_12_12 or 0), "$2", pg.task_data_template[var_12_4].target_num)))

			var_12_11 = var_12_9 and 2 or 0
			var_12_10 = arg_12_0.materialGray

			onButton(arg_12_0, var_12_6, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end, SFX_PANEL)
		end

		setActive(var_12_6, var_12_11 == 0)
		setActive(var_12_7, var_12_11 == 1)
		setActive(var_12_8, var_12_11 == 2)

		var_12_3:GetComponent(typeof(Image)).material = var_12_10

		local var_12_13 = var_12_3:Find("icon")

		var_12_13:GetComponent(typeof(Image)).material = var_12_10

		local var_12_14 = arg_12_0.medalListItems[var_0_2[iter_12_0]]:Find("icon"):GetComponent(typeof(Image))

		var_12_14.enabled = var_12_9

		if var_12_1 then
			var_12_14.material = arg_12_0.materialGray or nil
			var_12_2 = var_12_2 + (var_12_11 == 2 and 1 or 0)
		end
	end

	setText(arg_12_0.progressText, var_12_2 .. "/9")

	arg_12_0.medalImg.material = not var_12_0 and not var_12_1 and arg_12_0.materialGray

	setActive(arg_12_0.medalGet, var_12_0)
	setActive(arg_12_0.medalGot, var_12_1)

	return
end

function var_0_0.GetFinal(arg_16_0)
	if #arg_16_0.activeIDList == #arg_16_0.allIDList and arg_16_0.actMedal.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = ActivityConst.HOLOLIVE_MEDAL_COLLECTION
		})
	end

	return
end

function var_0_0.PlayStory(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.actMedal:getConfig("config_client").story

	if var_17_0 then
		pg.NewStoryMgr.GetInstance():Play(var_17_0, arg_17_1)
	else
		arg_17_1()
	end

	return
end

function var_0_0.IsTip()
	local var_18_0 = getProxy(TaskProxy)
	local var_18_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.HOLOLIVE_MEDAL_COLLECTION)

	if var_18_1 and not var_18_1:isEnd() then
		for iter_18_0, iter_18_1 in ipairs(pg.activity_template[ActivityConst.HOLOLIVE_MEDAL_COLLECTION_TASK].config_data) do
			local var_18_2 = var_18_0:getTaskVO(pg.activity_template[ActivityConst.HOLOLIVE_MEDAL_COLLECTION_TASK].config_data[iter_18_0])

			if var_18_2 and var_18_2:getTaskStatus() == 1 then
				return true
			end
		end

		for iter_18_2, iter_18_3 in ipairs(var_18_1.data1_list) do
			if not table.contains(var_18_1.data2_list, iter_18_3) then
				return true
			end
		end

		if #var_18_1.data2_list == #var_18_1:getConfig("config_data") and var_18_1.data1 ~= 1 then
			return true
		end
	end

	return
end

return var_0_0
