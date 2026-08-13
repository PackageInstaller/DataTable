class = var_0_10000

local var_0_0 = "AnniversaryNineMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.AD

	arg_1_0.btnGo = var_1.Find(var_1_1, "title/btn_act")

	local var_1_2 = arg_1_0.AD

	arg_1_0.btnManual = var_1.Find(var_1_2, "TopPage/top/manual")

	local var_1_3 = arg_1_0.btnManual

	arg_1_0.Txtmanual = var_1.Find(var_1_3, "Text")

	local var_1_4 = arg_1_0.btnGo

	arg_1_0.redPoint = var_1.Find(var_1_4, "red_point")

	local var_1_5 = arg_1_0.btnManual

	arg_1_0.redMalPoint = var_1.Find(var_1_5, "tip")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	if arg_2_0:GetMallActOpen() then
		onButton = var_1

		local var_2_0 = arg_2_0
		local var_2_1 = arg_2_0.btnGo

		local function var_2_2()
			pg = var_2_10000

			local var_3_0 = var_2_10000.m02
			local var_3_1 = var_0.sendNotification

			GAME = var_2_10003

			local var_3_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_3_1(var_3_0, var_3_2, var_2_10004.MALL_MAP)

			return
		end

		SFX_PANEL = var_1_10006

		var_1(var_2_0, var_2_1, var_2_2, var_1_10006)
	else
		onButton = var_1

		local var_2_3 = arg_2_0
		local var_2_4 = arg_2_0.btnGo

		local function var_2_5()
			local var_4_0 = arg_2_0
			local var_4_1 = var_0.emit

			ActivityMediator = var_2_10003

			local var_4_2 = var_2_10003.ON_ADD_SUBLAYER

			Context = var_2_10004

			local var_4_3 = var_2_10004.New
			local var_4_4 = {}

			MallAwardMediator = var_2_10007
			var_4_4.mediator = var_2_10007
			MallAwardLayer = var_2_10007
			var_4_4.viewComponent = var_2_10007
			var_4_4.data = {
				awardHandledByParent = true,
				onExit = function()
					local var_5_0 = arg_2_0

					var_0.refreshRed(var_5_0)

					return
				end
			}

			var_4_1(var_4_0, var_4_2, var_4_3(var_4_4))

			return
		end

		SFX_PANEL = var_1_10006

		var_1(var_2_3, var_2_4, var_2_5, var_1_10006)
	end

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.btnManual

	local function var_2_8()
		Context = var_2_10000

		local var_6_0 = var_2_10000.New
		local var_6_1 = {}

		MedalAlbumTemplateMediator = var_2_10003
		var_6_1.mediator = var_2_10003
		FujinBayMedalAlbumView = var_2_10003
		var_6_1.viewComponent = var_2_10003

		local var_6_2 = var_6_0(var_6_1)
		local var_6_3 = arg_2_0
		local var_6_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_6_4(var_6_3, var_2_10004.ON_ADD_SUBLAYER, var_6_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_6, var_2_7, var_2_8, var_1_10006)

	setText = var_1

	local var_2_9 = arg_2_0.Txtmanual

	i18n = var_2_7

	var_1(var_2_9, var_2_7("anniversary_nine_main_page"))
	arg_2_0:refreshRed()

	return
end

function var_0_1.GetMallActOpen(arg_7_0)
	local var_7_0 = arg_7_0.coreActivityUI

	if var_1.GetActivityIdByPageClass(var_7_0, "AnniversaryNineGamePage") then
		::label_7_0::

		getProxy = var_1_10002
		ActivityProxy = var_4

		local var_7_1 = var_1_10002(var_4)

		var_1_10002 = var_1_10002.getActivityById(var_7_1, var_1)
	end

	return var_1_10002 ~= nil and not var_1_10002:isEnd()
end

function var_0_1.OnUpdateFlush(arg_8_0)
	arg_8_0:refreshRed()

	return
end

function var_0_1.refreshRed(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.redPoint, var_0_1.IsMallAwardTip())

	local var_9_0, var_9_1 = var_0_1.GetFujinBayMedalTaskCount()

	setActive = var_3

	var_3(arg_9_0.redMalPoint, var_9_1 > 0)

	return
end

function var_0_1.IsShowReminder(arg_10_0)
	return var_0_1.IsTip()
end

function var_0_1.IsMallAwardTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_11_0 = var_1_10000(var_1_10002)
	local var_11_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	if not var_11_1(var_11_0, var_1_10003.ACTIVITY_TYPE_MALL) or var_0:isEnd() then
		return false
	end

	MallAwardLayer = var_1_10001

	local var_11_2

	if not var_1_10001.IsAwardTip() then
		MallAwardLayer = var_11_2

		if not var_11_2.IsInputTip() then
			MallAwardLayer = var_11_2
			var_11_2 = var_11_2.IsTaskTip()
		end
	end

	return var_11_2
end

function var_0_1.IsTip()
	local var_12_0

	if not var_0_1.IsMallAwardTip() then
		var_12_0 = var_0_1.IsFujinBayMedalTaskTip()
	end

	return var_12_0
end

function var_0_1.IsFujinBayMedalTaskTip()
	local var_13_0, var_13_1 = var_0_1.GetFujinBayMedalTaskCount()

	return var_13_1 > 0
end

function var_0_1.GetFujinBayMedalTaskCount()
	FujinBayMedalAlbumView = var_1_10000

	local var_14_0 = var_1_10000.GROUP_ID

	pg = var_1_10001

	local var_14_1

	if not var_1_10001.activity_medal_group[var_14_0] or not var_1.activity_link then
		var_14_1 = {}
	end

	local var_14_2

	ipairs = var_1_10004

	for iter_14_0, iter_14_1 in var_1_10004(var_14_1) do
		local var_14_3 = iter_14_1[2]

		getProxy = var_1_10010
		ActivityProxy = var_1_10012
		var_1_10012 = var_1_10010(var_1_10012)

		if var_1_10010.getActivityById(var_1_10012, var_14_3) and not var_1_10010:isEnd() then
			var_14_2 = iter_14_1[3]

			break
		end
	end

	if not var_14_2 then
		return 0, 0, 0
	end

	getProxy = var_4
	TaskProxy = var_6

	local var_14_4 = var_4(var_6)
	local var_14_5 = 0
	local var_14_6 = 0
	local var_14_7 = #var_14_2

	ipairs = iter_14_1

	for iter_14_2, iter_14_3 in iter_14_1(var_14_2) do
		local var_14_8

		if not var_14_4:getTaskById(iter_14_3) then
			var_14_8 = var_14_4:getFinishTaskById(iter_14_3)
		end

		if var_14_8 then
			if var_14_8:getTaskStatus() == 1 then
				var_14_6 = var_14_6 + 1
				var_14_5 = var_14_5 + 1
			elseif var_14 == 2 then
				var_14_5 = var_14_5 + 1
			end
		end
	end

	return var_14_5, var_14_6, var_14_7
end

return var_0_1
