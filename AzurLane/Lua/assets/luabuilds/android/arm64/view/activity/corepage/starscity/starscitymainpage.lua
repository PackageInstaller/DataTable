class = var_0_10000

local var_0_0 = "StarsCityMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.AD

	arg_1_0.btnManual = var_1.Find(var_1_1, "TopPage/top/manual")

	local var_1_2 = arg_1_0.btnManual

	arg_1_0.Txtmanual = var_1.Find(var_1_2, "Text")

	local var_1_3 = arg_1_0.btnManual

	arg_1_0.redMalPoint = var_1.Find(var_1_3, "tip")

	local var_1_4 = arg_1_0.AD

	arg_1_0.btnGroup = var_1.Find(var_1_4, "btn_list")

	local var_1_5 = arg_1_0.btnGroup

	arg_1_0.btnBuild = var_1.Find(var_1_5, "build")

	local var_1_6 = arg_1_0.btnGroup

	arg_1_0.btnFight = var_1.Find(var_1_6, "fight")

	local var_1_7 = arg_1_0.btnGroup

	arg_1_0.btnShop = var_1.Find(var_1_7, "shop")

	local var_1_8 = arg_1_0.btnBuild

	arg_1_0.resTimeBuild = var_1.Find(var_1_8, "resTime/Text")

	local var_1_9 = arg_1_0.btnShop

	arg_1_0.resTimeShop = var_1.Find(var_1_9, "resTime/Text")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client")

	type = var_1_10002
	var_2_1 = var_1_10002(var_2_1) == "table" and var_2_1 or {}

	local function var_2_2(arg_3_0)
		if not arg_3_0 then
			return false
		end

		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_3_0 = var_2_10001(var_2_10003)

		return not var_1.getActivityById(var_3_0, arg_3_0) or var_1:isEnd()
	end

	onButton = var_2_0

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.btnBuild

	local function var_2_5()
		if var_2_2(var_2_1.buildLinkActID) then
			pg = var_0

			local var_4_0 = var_0.TipsMgr.GetInstance()
			local var_4_1 = var_0.ShowTips

			i18n = var_2_10003

			var_4_1(var_4_0, var_2_10003("common_activity_end"))

			return
		end

		local var_4_2 = arg_2_0
		local var_4_3 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_4 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_4_5 = var_2_10004.GETBOAT
		local var_4_6 = {}

		BuildShipScene = var_2_10006
		var_4_6.page = var_2_10006.PAGE_BUILD
		BuildShipScene = var_6
		var_4_6.projectName = var_6.PROJECTS.ACTIVITY

		var_4_3(var_4_2, var_4_4, var_4_5, var_4_6)

		return
	end

	SFX_PANEL = var_1_10008

	var_2_0(var_2_3, var_2_4, var_2_5, var_1_10008)

	onButton = var_2_0

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.btnFight

	local function var_2_8()
		if var_2_1.fightLinkActID and var_2_2(var_0) then
			pg = var_1

			local var_5_0 = var_1.TipsMgr.GetInstance()
			local var_5_1 = var_1.ShowTips

			i18n = var_2_10004

			var_5_1(var_5_0, var_2_10004("common_activity_end"))

			return
		end

		if var_0 then
			local var_5_2 = arg_2_0
			local var_5_3 = var_1.emit

			ActivityMediator = var_2_10004

			var_5_3(var_5_2, var_2_10004.SKIP_ACTIVITY_MAP, var_0)
		else
			local var_5_4 = arg_2_0
			local var_5_5 = var_1.emit

			ActivityMediator = var_2_10004

			var_5_5(var_5_4, var_2_10004.BATTLE_OPERA)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_2_0(var_2_6, var_2_7, var_2_8, var_1_10008)

	onButton = var_2_0

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.btnShop

	local function var_2_11()
		if var_2_1.shopLinkActID and var_2_2(var_0) then
			pg = var_1

			local var_6_0 = var_1.TipsMgr.GetInstance()
			local var_6_1 = var_1.ShowTips

			i18n = var_2_10004

			var_6_1(var_6_0, var_2_10004("common_activity_end"))

			return
		end

		if var_0 then
			local var_6_2 = arg_2_0
			local var_6_3 = var_1.emit

			ActivityMediator = var_2_10004
			var_2_10004 = var_2_10004.GO_SHOPS_LAYER

			local var_6_4 = {}

			NewShopsScene = var_2_10006
			var_6_4.warp = var_2_10006.TYPE_ACTIVITY
			var_6_4.actId = var_0

			var_6_3(var_6_2, var_2_10004, var_6_4)
		else
			local var_6_5 = arg_2_0
			local var_6_6 = var_1.emit

			ActivityMediator = var_2_10004

			var_6_6(var_6_5, var_2_10004.GO_CHANGE_SHOP)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_2_0(var_2_9, var_2_10, var_2_11, var_1_10008)

	onButton = var_2_0

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.btnManual

	local function var_2_14()
		Context = var_2_10000

		local var_7_0 = var_2_10000.New
		local var_7_1 = {}

		MedalAlbumTemplateMediator = var_2_10003
		var_7_1.mediator = var_2_10003
		StarsCityMedalAlbumView = var_2_10003
		var_7_1.viewComponent = var_2_10003

		local var_7_2 = var_7_0(var_7_1)
		local var_7_3 = arg_2_0
		local var_7_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_7_4(var_7_3, var_2_10004.ON_ADD_SUBLAYER, var_7_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_2_0(var_2_12, var_2_13, var_2_14, var_1_10008)

	setText = var_2_0

	local var_2_15 = arg_2_0.Txtmanual

	i18n = var_2_13

	var_2_0(var_2_15, var_2_13("anniversary_nine_main_page"))
	arg_2_0:refreshBtnResTime()
	arg_2_0:refreshRed()

	return
end

function var_0_1.refreshBtnResTime(arg_8_0)
	local var_8_0 = arg_8_0.activity
	local var_8_1 = var_1.getConfig(var_8_0, "config_client")

	type = var_1_10002
	var_8_1 = var_1_10002(var_8_1) == "table" and var_8_1 or {}
	pg = var_2

	local var_8_2 = var_2.TimeMgr.GetInstance()
	local var_8_3 = var_2.GetServerTime(var_8_2)

	;(function(arg_9_0, arg_9_1)
		if not arg_9_0 then
			return
		end

		if arg_9_1 then
			getProxy = var_2_10002
			ActivityProxy = var_2_10004
			var_2_10004 = var_2_10002(var_2_10004)

			local var_9_0

			if not var_2.getActivityById(var_2_10004, arg_9_1) then
				var_9_0 = nil
			end

			if var_9_0 then
				::label_9_0::

				if not var_9_0:isEnd() then
					local var_9_2

					if var_9_0.stopTime then
						local var_9_1 = var_9_0.stopTime

						if not (var_8_3 < var_9_1) then
							var_9_2 = false
						else
							var_9_2 = true
						end
					end

					if var_9_2 then
						var_2_10004 = var_9_0.stopTime - var_8_3
						math = var_5

						local var_9_3 = var_5.floor(var_2_10004 / 0)

						math = var_2_10006

						local var_9_4 = var_2_10006.floor(var_2_10004 % 0 / 16)

						setActive = var_7

						var_7(arg_9_0.parent, true)

						if 2 <= var_9_4 then
							setText = var_7

							local var_9_5 = arg_9_0

							i18n = var_10

							var_7(var_9_5, var_10("StarsCityMainPage_res_day_time", var_9_3, var_9_4))
						else
							setText = var_7

							local var_9_6 = arg_9_0

							i18n = var_10

							var_7(var_9_6, var_10("StarsCityMainPage_no_time"))
						end
					else
						setActive = var_2_10004

						var_2_10004(arg_9_0.parent, false)

						setText = var_2_10004

						var_2_10004(arg_9_0, "")
					end

					return
				end
			end
		end
	end)(arg_8_0.resTimeBuild, var_8_1.buildLinkActID)
	var_4(arg_8_0.resTimeShop, var_8_1.shopLinkActID)

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	arg_10_0:refreshRed()
	arg_10_0:refreshBtnResTime()

	return
end

function var_0_1.refreshRed(arg_11_0)
	local var_11_0, var_11_1 = var_0_1.GetFujinBayMedalTaskCount()

	setActive = var_1_10003

	var_1_10003(arg_11_0.redMalPoint, var_11_1 > 0)

	return
end

function var_0_1.IsShowReminder(arg_12_0)
	return var_0_1.IsTip()
end

function var_0_1.IsTip()
	return var_0_1.IsFujinBayMedalTaskTip()
end

function var_0_1.IsFujinBayMedalTaskTip()
	local var_14_0, var_14_1 = var_0_1.GetFujinBayMedalTaskCount()

	return var_14_1 > 0
end

function var_0_1.GetFujinBayMedalTaskCount()
	StarsCityMedalAlbumView = var_1_10000

	local var_15_0 = var_1_10000.GROUP_ID

	pg = var_1_10001

	local var_15_1

	if not var_1_10001.activity_medal_group[var_15_0] or not var_1.activity_link then
		var_15_1 = {}
	end

	local var_15_2

	ipairs = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10004(var_15_1) do
		local var_15_3 = iter_15_1[2]

		getProxy = var_1_10010
		ActivityProxy = var_1_10012
		var_1_10012 = var_1_10010(var_1_10012)

		if var_1_10010.getActivityById(var_1_10012, var_15_3) and not var_1_10010:isEnd() then
			var_15_2 = iter_15_1[3]

			break
		end
	end

	if not var_15_2 then
		return 0, 0, 0
	end

	getProxy = var_4
	TaskProxy = var_6

	local var_15_4 = var_4(var_6)
	local var_15_5 = 0
	local var_15_6 = 0
	local var_15_7 = #var_15_2

	ipairs = iter_15_1

	for iter_15_2, iter_15_3 in iter_15_1(var_15_2) do
		local var_15_8

		if not var_15_4:getTaskById(iter_15_3) then
			var_15_8 = var_15_4:getFinishTaskById(iter_15_3)
		end

		if var_15_8 then
			if var_15_8:getTaskStatus() == 1 then
				var_15_6 = var_15_6 + 1
				var_15_5 = var_15_5 + 1
			elseif var_14 == 2 then
				var_15_5 = var_15_5 + 1
			end
		end
	end

	return var_15_5, var_15_6, var_15_7
end

return var_0_1
