class = var_0_10000

local var_0_0 = "FireworksPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.fireworkNameText = var_1.Find(var_1_0, "firework_text")

	local var_1_1 = arg_1_0.bg

	arg_1_0.fireworkNumText = var_1.Find(var_1_1, "firework_text/num_text")

	local var_1_2 = arg_1_0.bg

	arg_1_0.ptText = var_1.Find(var_1_2, "pt_text")

	local var_1_3 = arg_1_0.bg

	arg_1_0.fireBtn = var_1.Find(var_1_3, "fire_btn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.fireworkPanel = var_1.Find(var_1_4, "frame")

	local var_1_5 = {}
	local var_1_6 = arg_1_0.fireworkPanel

	var_1_5[1] = var_2.Find(var_1_6, "dots/1")

	local var_1_7 = arg_1_0.fireworkPanel

	var_1_5[2] = var_2.Find(var_1_7, "dots/2")

	local var_1_8 = arg_1_0.fireworkPanel

	var_1_5[3] = var_2.Find(var_1_8, "dots/3")
	arg_1_0.dots = var_1_5

	local var_1_9 = {}
	local var_1_10 = arg_1_0.fireworkPanel

	var_1_9[1] = var_2.Find(var_1_10, "content/1")

	local var_1_11 = arg_1_0.fireworkPanel

	var_1_9[2] = var_2.Find(var_1_11, "content/2")

	local var_1_12 = arg_1_0.fireworkPanel

	var_1_9[3] = var_2.Find(var_1_12, "content/3")
	arg_1_0.fireworkPages = var_1_9

	local var_1_13 = arg_1_0.fireworkPanel

	arg_1_0.nextPageBtn = var_1.Find(var_1_13, "right_btn")

	local var_1_14 = arg_1_0.fireworkPanel

	arg_1_0.lastPageBtn = var_1.Find(var_1_14, "left_btn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	var_0_1.super.OnDataSetting(arg_2_0)

	local var_2_0 = arg_2_0.activity

	arg_2_0.fireworkActID = var_1.getConfig(var_2_0, "config_client").fireworkActID
	pg = var_1
	arg_2_0.ptID = var_1.activity_template[arg_2_0.fireworkActID].config_data[2][1]
	arg_2_0.ptConsume = var_1[2][2]
	arg_2_0.fireworkIds = var_1[3]

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	var_0_1.super.OnFirstFlush(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.fireBtn

	local function var_3_2()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_4_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.SPRING_FESTIVAL_BACKHILL_2023, {
			openFireworkLayer = true
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.nextPageBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.UpdateFrieworkPanel(var_5_0, arg_3_0.pageIndex + 1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.lastPageBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.UpdateFrieworkPanel(var_6_0, arg_3_0.pageIndex - 1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.battleBtn

	local function var_3_11()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_9, var_3_10, var_3_11, var_1_10005)

	setText = var_1

	local var_3_12 = arg_3_0.fireworkNameText

	i18n = var_3_10

	var_1(var_3_12, var_3_10("activity_yanhua_tip1"))
	arg_3_0:UpdataPageIndex()

	return
end

function var_0_1.UpdataPageIndex(arg_8_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)

	arg_8_0.fireworkAct = var_1.getActivityById(var_8_0, arg_8_0.fireworkActID)
	assert = var_1

	local var_8_2

	if arg_8_0.fireworkAct then
		local var_8_1 = arg_8_0.fireworkAct

		var_8_2 = not var_2.isEnd(var_8_1)
	end

	var_1(var_8_2, "烟花活动(type92)已结束")

	local var_8_3 = arg_8_0.fireworkAct

	arg_8_0.unlockCount = var_1.getData1(var_8_3)

	local var_8_4 = arg_8_0.fireworkAct

	arg_8_0.unlockIds = var_1.getData1List(var_8_4)

	for iter_8_0 = #arg_8_0.fireworkPages, 1, -1 do
		local var_8_5 = 0

		eachChild = var_1_10006

		var_1_10006(arg_8_0.fireworkPages[iter_8_0], function(arg_9_0)
			tonumber = var_2_10001

			local var_9_0 = var_2_10001(arg_9_0.name)

			table = var_2

			if var_2.contains(arg_8_0.unlockIds, var_9_0) then
				var_8_5 = var_8_5 + 1
			end

			return
		end)

		if var_8_5 ~= arg_8_0.fireworkPages[iter_8_0].childCount then
			arg_8_0.pageIndex = iter_8_0
		end
	end

	if #arg_8_0.unlockIds == #arg_8_0.fireworkIds then
		arg_8_0.pageIndex = 1
	end

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	var_0_1.super.OnUpdateFlush(arg_10_0)
	arg_10_0:UpdateFrieworkPanel(arg_10_0.pageIndex)

	if #arg_10_0.unlockIds == 0 then
		pg = var_1

		if var_1.activity_template[arg_10_0.fireworkActID].config_client.story then
			type = var_2

			if var_2(var_1) == "table" then
				ipairs = var_2

				for iter_10_0, iter_10_1 in var_2(var_1) do
					if iter_10_1[1] == 0 then
						pg = var_7

						local var_10_0 = var_7.NewStoryMgr.GetInstance()

						var_7.Play(var_10_0, iter_10_1[2])
					end
				end
			end
		end
	end

	return
end

function var_0_1.UpdateFrieworkPanel(arg_11_0, arg_11_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_11_0 = var_1_10002(var_1_10003)

	arg_11_0.fireworkAct = var_2.getActivityById(var_11_0, arg_11_0.fireworkActID)
	assert = var_2

	local var_11_2

	if arg_11_0.fireworkAct then
		local var_11_1 = arg_11_0.fireworkAct

		var_11_2 = not var_3.isEnd(var_11_1)
	end

	var_2(var_11_2, "烟花活动(type92)已结束")

	local var_11_3 = arg_11_0.fireworkAct

	arg_11_0.unlockCount = var_2.getData1(var_11_3)

	local var_11_4 = arg_11_0.fireworkAct

	arg_11_0.unlockIds = var_2.getData1List(var_11_4)

	for iter_11_0 = #arg_11_0.fireworkPages, 1, -1 do
		eachChild = var_1_10006

		var_1_10006(arg_11_0.fireworkPages[iter_11_0], function(arg_12_0)
			tonumber = var_2_10001

			local var_12_0 = var_2_10001(arg_12_0.name)

			table = var_2

			if var_2.contains(arg_11_0.unlockIds, var_12_0) then
				setActive = var_2

				var_2(arg_12_0, false)
			else
				setActive = var_2

				var_2(arg_12_0, true)

				onButton = var_2

				local var_12_1 = arg_11_0
				local var_12_2 = arg_12_0

				local function var_12_3()
					local var_13_0 = arg_11_0

					var_0.OnUnlockClick(var_13_0, var_12_0)

					return
				end

				SFX_PANEL = var_2_10006

				var_2(var_12_1, var_12_2, var_12_3, var_2_10006)
			end

			return
		end)
	end

	if #arg_11_0.fireworkPages < arg_11_1 or arg_11_1 < 1 then
		return
	end

	arg_11_0.pageIndex = arg_11_1
	ipairs = var_3

	for iter_11_1, iter_11_2 in var_3(arg_11_0.fireworkPages) do
		setActive = var_1_10008

		local var_11_5 = iter_11_2

		tonumber = var_1_10010
		var_1_10010 = var_1_10010(iter_11_2.name) == arg_11_1

		var_1_10008(var_11_5, var_1_10010)
	end

	ipairs = var_3

	for iter_11_3, iter_11_4 in var_3(arg_11_0.dots) do
		setActive = var_1_10008

		local var_11_6 = iter_11_4

		tonumber = var_1_10010
		var_1_10010 = var_1_10010(iter_11_4.name) == arg_11_1

		var_1_10008(var_11_6, var_1_10010)
	end

	setButtonEnabled = var_3

	var_3(arg_11_0.nextPageBtn, arg_11_1 ~= var_2)

	setButtonEnabled = var_3

	var_3(arg_11_0.lastPageBtn, arg_11_1 ~= 1)

	setText = var_3

	var_3(arg_11_0.fireworkNumText, #arg_11_0.unlockIds .. "/" .. #arg_11_0.fireworkIds)

	getProxy = var_3
	PlayerProxy = var_4

	local var_11_7 = var_3(var_4)
	local var_11_8 = var_3.getRawData(var_11_7)

	arg_11_0.ptNum = var_3.getResource(var_11_8, arg_11_0.ptID)
	setText = var_4

	var_4(arg_11_0.ptText, arg_11_0.ptNum)

	return
end

function var_0_1.OnUnlockClick(arg_14_0, arg_14_1)
	local var_14_1

	if arg_14_0.unlockCount <= 0 then
		pg = var_14_1

		local var_14_0 = var_14_1.TipsMgr.GetInstance()

		var_14_1 = var_14_1.ShowTips
		i18n = var_1_10004

		var_14_1(var_14_0, var_1_10004("activity_yanhua_tip6"))

		return
	end

	pg = var_14_1

	local var_14_2 = var_14_1.MsgboxMgr.GetInstance()
	local var_14_3 = var_2.ShowMsgBox
	local var_14_4 = {}

	i18n = var_1_10005
	var_14_4.content = var_1_10005("activity_yanhua_tip4", arg_14_0.ptConsume)

	function var_14_4.onYes()
		if arg_14_0.ptNum < arg_14_0.ptConsume then
			pg = var_0

			local var_15_0 = var_0.TipsMgr.GetInstance()
			local var_15_1 = var_0.ShowTips

			i18n = var_2_10002

			var_15_1(var_15_0, var_2_10002("activity_yanhua_tip5"))
		else
			local var_15_2 = arg_14_0
			local var_15_3 = var_0.emit

			ActivityMediator = var_2_10002

			var_15_3(var_15_2, var_2_10002.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_14_0.fireworkActID,
				arg1 = arg_14_1
			})
		end

		return
	end

	var_14_3(var_14_2, var_14_4)

	return
end

return var_0_1
