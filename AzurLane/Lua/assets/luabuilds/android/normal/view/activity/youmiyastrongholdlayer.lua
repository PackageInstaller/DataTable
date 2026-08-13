class = var_0_10000

local var_0_0 = "YoumiyaStrongholdLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.activity_ryza_furniture

pg = var_2

local var_0_3 = var_2.furniture_data_template

function var_0_1.getUIName(arg_1_0)
	return "YoumiyaStrongholdUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.adapt = var_1.Find(var_2_0, "adapt")

	local var_2_1 = arg_2_0.adapt

	arg_2_0.backBtn = var_1.Find(var_2_1, "backBtn")

	local var_2_2 = arg_2_0.adapt

	arg_2_0.homeBtn = var_1.Find(var_2_2, "homeBtn")

	local var_2_3 = arg_2_0.adapt

	arg_2_0.desc = var_1.Find(var_2_3, "desc/text")

	local var_2_4 = arg_2_0.adapt

	arg_2_0.res = var_1.Find(var_2_4, "res")

	local var_2_5 = arg_2_0._tf

	arg_2_0.strongholdPage = var_1.Find(var_2_5, "pages/strongholdPage")

	local var_2_6 = arg_2_0._tf

	arg_2_0.detailPage = var_1.Find(var_2_6, "pages/detailPage")

	local var_2_7 = arg_2_0._tf

	arg_2_0.makeFurniturePanel = var_1.Find(var_2_7, "pages/makeFurniturePanel")
	UIItemList = var_1

	local var_2_8 = var_1.New
	local var_2_9 = arg_2_0.detailPage
	local var_2_10 = var_2.Find(var_2_9, "detail/awardList")
	local var_2_11 = arg_2_0.detailPage

	arg_2_0.awardList = var_2_8(var_2_10, var_3.Find(var_2_11, "detail/awardList/stage"))
	arg_2_0.isOnMake = false
	setText = var_1

	local var_2_12 = arg_2_0.desc

	i18n = var_3

	var_1(var_2_12, var_3("yumia_stronghold_2"))

	for iter_2_0 = 1, 3 do
		setText = var_2_14

		local var_2_13 = arg_2_0.strongholdPage

		var_1_10006 = var_1_10006.Find(var_2_13, iter_2_0 .. "/comfort/text")
		i18n = var_2_13

		var_2_14(var_1_10006, var_2_13("yumia_stronghold_3"))

		var_1_10006 = arg_2_0.detailPage

		local var_2_14 = var_2_14.Find(var_1_10006, "detail/stronghold/furnitures/" .. iter_2_0)

		for iter_2_1 = 1, var_2_14.childCount do
			local var_2_15 = var_2_14:Find(iter_2_1)

			for iter_2_2 = 0, var_2_15.childCount - 1 do
				local var_2_16 = var_2_15
				local var_2_17 = var_2_15.GetChild(var_2_16, iter_2_2)

				setText = var_2_16

				local var_2_18 = var_2_17
				local var_2_19 = var_2_17.Find(var_2_18, "comfort/comf/text")

				i18n = var_2_18

				var_2_16(var_2_19, var_2_18("yumia_stronghold_3"))
			end
		end

		setText = var_1_10006

		local var_2_20 = arg_2_0.detailPage
		local var_2_21 = var_7.Find(var_2_20, "info/" .. iter_2_0 .. "/comfort/text")

		i18n = var_2_20

		var_1_10006(var_2_21, var_2_20("yumia_stronghold_3"))
	end

	setText = var_1

	local var_2_22 = arg_2_0.detailPage
	local var_2_23 = var_2.Find(var_2_22, "detail/progress/Root/text")

	i18n = var_2_22

	var_1(var_2_23, var_2_22("yumia_stronghold_4"))

	setText = var_1

	local var_2_24 = arg_2_0.detailPage
	local var_2_25 = var_2.Find(var_2_24, "detail/awardTitle/text")

	i18n = var_2_24

	var_1(var_2_25, var_2_24("yumia_stronghold_5"))

	setText = var_1

	local var_2_26 = arg_2_0.detailPage
	local var_2_27 = var_2.Find(var_2_26, "detail/awardList/stage/got/text")

	i18n = var_2_26

	var_1(var_2_27, var_2_26("yumia_stronghold_6"))

	setText = var_1

	local var_2_28 = arg_2_0.makeFurniturePanel
	local var_2_29 = var_2.Find(var_2_28, "panel/complete/root/text")

	i18n = var_2_28

	var_1(var_2_29, var_2_28("yumia_stronghold_7"))

	setText = var_1

	local var_2_30 = arg_2_0.makeFurniturePanel
	local var_2_31 = var_2.Find(var_2_30, "panel/comfort/title")

	i18n = var_2_30

	var_1(var_2_31, var_2_30("yumia_stronghold_3"))

	setText = var_1

	local var_2_32 = arg_2_0.makeFurniturePanel
	local var_2_33 = var_2.Find(var_2_32, "panel/consume/title")

	i18n = var_2_32

	var_1(var_2_33, var_2_32("yumia_stronghold_8"))

	setText = var_1

	local var_2_34 = arg_2_0.makeFurniturePanel
	local var_2_35 = var_2.Find(var_2_34, "panel/consume/text")

	i18n = var_2_34

	var_1(var_2_35, var_2_34("yumia_stronghold_9"))

	setText = var_1

	local var_2_36 = arg_2_0.makeFurniturePanel
	local var_2_37 = var_2.Find(var_2_36, "panel/makeBtn/text")

	i18n = var_2_36

	var_1(var_2_37, var_2_36("yumia_stronghold_10"))

	pg = var_1

	local var_2_38 = var_1.CameraFixMgr.GetInstance()
	local var_2_39 = var_1.bind

	pg = var_3
	arg_2_0.camEventId = var_2_39(var_2_38, var_3.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.UpdateAdapt(var_3_0)

		return
	end)

	local var_2_40 = arg_2_0._tf.rect.height
	local var_2_42

	if 1440 < var_2_40 then
		local var_2_41 = arg_2_0.adapt

		var_2_42 = var_2_42.GetComponent
		typeof = var_4
		RectTransform = var_2_14
		var_2_42 = var_2_42(var_2_41, var_4(var_2_14))
		Vector2 = var_2_41
		var_2_42.sizeDelta = var_2_41(0, 1440 - var_2_40)

		local var_2_43 = arg_2_0.makeFurniturePanel

		var_2_42 = var_2_42.GetComponent
		typeof = var_4
		RectTransform = var_5
		var_2_42 = var_2_42(var_2_43, var_4(var_5))
		Vector2 = var_2_43
		var_2_42.sizeDelta = var_2_43(0, 1440 - var_2_40)
	end

	pg = var_2_42

	local var_2_44 = var_2_42.UIMgr.GetInstance()

	var_2.BlurPanel(var_2_44, arg_2_0._tf, false)

	local var_2_45 = arg_2_0._tf
	local var_2_46 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_5

	local var_2_47 = var_2_46(var_2_45, var_4(var_5))

	var_2.SetTriggerEvent(var_2_47, function()
		for iter_4_0 = 0, 2 do
			local var_4_0 = arg_2_0.strongholdPage
			local var_4_1 = var_4.GetChild(var_4_0, iter_4_0)
			local var_4_2 = var_4.GetComponent

			typeof = var_6
			Animation = var_2_10007

			local var_4_3 = var_4_2(var_4_1, var_6(var_2_10007))

			var_4.Play(var_4_3, "Anim_YoumiyaStrongholdUI_Strongholdpage01_In")
		end

		return
	end)

	local var_2_48 = arg_2_0.detailPage
	local var_2_49 = var_3.GetComponent

	typeof = var_5
	DftAniEvent = var_1_10006

	local var_2_50 = var_2_49(var_2_48, var_5(var_1_10006))

	var_3.SetTriggerEvent(var_2_50, function()
		for iter_5_0 = 0, 2 do
			local var_5_0 = arg_2_0.detailPage
			local var_5_1 = var_4.Find(var_5_0, "info")
			local var_5_2 = var_4.GetChild(var_5_1, iter_5_0)
			local var_5_3 = var_4.GetComponent

			typeof = var_2_10007
			Animation = var_2_10008

			local var_5_4 = var_5_3(var_5_2, var_2_10007(var_2_10008))

			isActive = var_5_2

			if var_5_2(var_4) then
				var_2_10007 = var_5_4

				var_5_4.Play(var_2_10007, "Anim_YoumiyaStrongholdUI_Strongholdpage01_In")
			end
		end

		return
	end)
	var_3:SetEndEvent(function()
		for iter_6_0 = 1, 3 do
			local var_6_0 = arg_2_0.detailPage
			local var_6_1 = var_4.Find(var_6_0, "detail/stronghold/furnitures/" .. iter_6_0)

			for iter_6_1 = 1, var_6_1.childCount do
				local var_6_2 = var_6_1:Find(iter_6_1)

				for iter_6_2 = 0, var_6_2.childCount - 1 do
					local var_6_3 = var_6_2
					local var_6_4 = var_6_2.GetChild(var_6_3, iter_6_2)

					setActive = var_6_3

					var_6_3(var_6_4:Find("comfort/icon/VX"), true)
				end
			end
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:InitData()
	arg_7_0:UpdateAdapt()

	onButton = var_1

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.backBtn

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.GoBack(var_8_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_7_0, var_7_1, var_7_2, var_1_10005)

	onButton = var_1

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.homeBtn

	local function var_7_5()
		local var_9_0 = arg_7_0

		var_0.emit(var_9_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_7_3, var_7_4, var_7_5, var_1_10005)

	setActive = var_1

	var_1(arg_7_0.strongholdPage, true)

	setActive = var_1

	var_1(arg_7_0.detailPage, false)

	setActive = var_1

	var_1(arg_7_0.makeFurniturePanel, false)
	arg_7_0:RefreshView()

	return
end

function var_0_1.UpdateAdapt(arg_10_0)
	local var_10_0 = 1.3333333333333333
	local var_10_1 = 2.1666666666666665

	pg = var_1_10003

	local var_10_2 = var_1_10003.CameraFixMgr.GetInstance().currentWidth / var_3.currentHeight

	math = var_5

	local var_10_3 = var_5.clamp(var_10_2, var_10_0, var_10_1)
	local var_10_4 = arg_10_0._tf
	local var_10_5 = var_5.GetComponent

	typeof = var_7
	AspectRatioFitter = var_8

	local var_10_6 = var_10_5(var_10_4, var_7(var_8))

	var_10_6.aspectRatio = var_10_3
	setSizeDelta = var_10_6

	local var_10_7 = arg_10_0._tf

	var_10_6(var_6.Find(var_10_7, "adapt"), {
		x = 0,
		y = 0
	})

	return
end

function var_0_1.InitData(arg_11_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002
	arg_11_0.activityProxy = var_1_10001(var_1_10002)
	arg_11_0.allFurnitureCount = {
		0,
		0,
		0
	}
	arg_11_0.allComfortCount = {
		0,
		0,
		0
	}

	for iter_11_0 = 1, 3 do
		local var_11_0 = var_0_2.get_id_list_by_type[iter_11_0]
		local var_11_1 = arg_11_0.allFurnitureCount

		var_11_1[iter_11_0] = #var_11_0
		ipairs = var_11_1

		for iter_11_1, iter_11_2 in var_11_1(var_11_0) do
			local var_11_2 = var_0_2[iter_11_2]

			arg_11_0.allComfortCount[iter_11_0] = arg_11_0.allComfortCount[iter_11_0] + var_11_2.com_add
		end
	end

	pg = var_1

	local var_11_3 = var_1.activity_template

	ActivityConst = var_2
	arg_11_0.awardInfos = var_11_3[var_2.YUMIA_BASE_ACT_ID].config_client.rewards

	return
end

function var_0_1.RefreshData(arg_12_0)
	local var_12_0 = arg_12_0.activityProxy
	local var_12_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_12_2 = var_12_1(var_12_0, var_1_10003.ACTIVITY_TYPE_ATELIER_LINK)

	arg_12_0.items = var_1.GetItems(var_12_2)

	local var_12_3 = arg_12_0.activityProxy
	local var_12_4 = var_2.getActivityById

	ActivityConst = var_1_10004
	arg_12_0.activity = var_12_4(var_12_3, var_1_10004.YUMIA_BASE_ACT_ID)

	local var_12_5 = arg_12_0.activity

	arg_12_0.okFurnitureIds = var_2.getData1List(var_12_5)
	arg_12_0.gotAwardIndex = {
		0,
		0,
		0
	}

	for iter_12_0 = 1, 3 do
		local var_12_6 = arg_12_0.gotAwardIndex
		local var_12_7 = arg_12_0.activity

		var_12_6[iter_12_0] = var_1_10007.getKVPList(var_12_7, 1, iter_12_0)
	end

	arg_12_0.furnitureCount = {
		0,
		0,
		0
	}
	arg_12_0.comfortCount = {
		0,
		0,
		0
	}

	for iter_12_1 = 1, 3 do
		local var_12_8 = var_0_2.get_id_list_by_type[iter_12_1]

		ipairs = var_1_10007

		for iter_12_2, iter_12_3 in var_1_10007(var_12_8) do
			table = var_1_10012

			if var_1_10012.contains(arg_12_0.okFurnitureIds, iter_12_3) then
				var_1_10012 = var_0_2[iter_12_3]
				arg_12_0.furnitureCount[iter_12_1] = arg_12_0.furnitureCount[iter_12_1] + 1
				arg_12_0.comfortCount[iter_12_1] = arg_12_0.comfortCount[iter_12_1] + var_1_10012.com_add
			end
		end
	end

	return
end

function var_0_1.SetRes(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_13_0 = var_1_10002(var_1_10003)
	local var_13_1 = var_2.getRawData(var_13_0)
	local var_13_2 = {
		{
			138,
			arg_13_0:GetItemCount(138)
		},
		{
			139,
			arg_13_0:GetItemCount(139)
		},
		{
			140,
			arg_13_0:GetItemCount(140)
		},
		{
			141,
			arg_13_0:GetItemCount(141)
		},
		{
			6,
			arg_13_0:GetItemCount(6)
		}
	}

	for iter_13_0 = 0, arg_13_1.childCount - 1 do
		setActive = var_1_10008

		var_1_10008(arg_13_1:GetChild(iter_13_0), false)
	end

	ipairs = var_4

	for iter_13_1, iter_13_2 in var_4(var_13_2) do
		local var_13_3 = iter_13_2[1]
		local var_13_4 = iter_13_2[2]

		for iter_13_3 = 0, arg_13_1.childCount - 1 do
			local var_13_5 = arg_13_1:GetChild(iter_13_3).name

			tostring = var_17

			if var_13_5 == var_17(var_13_3) then
				setActive = var_13_5

				var_13_5(var_15, true)

				setText = var_13_5

				var_13_5(var_15:Find("Text"), var_13_4)

				break
			end
		end
	end

	return
end

function var_0_1.RefreshView(arg_14_0)
	arg_14_0:RefreshData()
	arg_14_0:SetRes(arg_14_0.res)
	arg_14_0:SetDetailPage()

	for iter_14_0 = 1, 3 do
		local var_14_0 = arg_14_0.strongholdPage
		local var_14_1 = var_5.GetChild(var_14_0, iter_14_0 - 1)

		setText = var_14_0

		local var_14_2 = var_14_1
		local var_14_3 = var_14_1.Find(var_14_2, "root/name")

		i18n = var_14_2

		var_14_0(var_14_3, var_14_2("yumia_base_name_" .. iter_14_0))

		setText = var_14_0

		var_14_0(var_14_1:Find("comfort/count2/count1"), arg_14_0.comfortCount[iter_14_0])

		setText = var_14_0

		var_14_0(var_14_1:Find("comfort/count2"), "/" .. arg_14_0.allComfortCount[iter_14_0])

		GetImageSpriteFromAtlasAsync = var_14_0

		local var_14_4 = "ui/CourtyardUI_atlas"
		local var_14_5 = "express_" .. arg_14_0:GetComfortableLevel(arg_14_0.comfortCount[iter_14_0])
		local var_14_6 = var_14_1

		var_14_0(var_14_4, var_14_5, var_14_1.Find(var_14_6, "comfort/icon"))

		onButton = var_14_0

		local var_14_7 = arg_14_0
		local var_14_8 = var_14_1

		local function var_14_9()
			local var_15_0 = arg_14_0

			var_0.EnterDetailPage(var_15_0, iter_14_0)

			return
		end

		SFX_PANEL = var_14_6

		var_14_0(var_14_7, var_14_8, var_14_9, var_14_6)

		local var_14_10 = false
		local var_14_11 = arg_14_0.awardInfos[iter_14_0]

		for iter_14_1 = 1, #var_14_11 do
			local var_14_12 = var_14_11[iter_14_1][1]
			local var_14_13 = var_14_11[iter_14_1][2]

			if var_14_12 <= arg_14_0.comfortCount[iter_14_0] and iter_14_1 > arg_14_0.gotAwardIndex[iter_14_0] then
				var_14_10 = true

				break
			end
		end

		setActive = var_8

		var_8(var_14_1:Find("tip"), var_14_10)
	end

	if arg_14_0.strongholdIndex then
		arg_14_0:EnterDetailPage(arg_14_0.strongholdIndex)
	end

	return
end

function var_0_1.SetDetailPage(arg_16_0)
	for iter_16_0 = 1, 3 do
		setText = var_1_10005

		local var_16_0 = arg_16_0.detailPage
		local var_16_1 = var_6.Find(var_16_0, "info/" .. iter_16_0 .. "/root/name")

		i18n = var_16_0

		var_1_10005(var_16_1, var_16_0("yumia_base_name_" .. iter_16_0))

		setText = var_1_10005

		local var_16_2 = arg_16_0.detailPage

		var_1_10005(var_6.Find(var_16_2, "info/" .. iter_16_0 .. "/comfort/count2/count1"), arg_16_0.comfortCount[iter_16_0])

		setText = var_1_10005

		local var_16_3 = arg_16_0.detailPage

		var_1_10005(var_6.Find(var_16_3, "info/" .. iter_16_0 .. "/comfort/count2"), "/" .. arg_16_0.allComfortCount[iter_16_0])

		GetImageSpriteFromAtlasAsync = var_1_10005

		local var_16_4 = "ui/CourtyardUI_atlas"
		local var_16_5 = "express_" .. arg_16_0:GetComfortableLevel(arg_16_0.comfortCount[iter_16_0])
		local var_16_6 = arg_16_0.detailPage

		var_1_10005(var_16_4, var_16_5, var_8.Find(var_16_6, "info/" .. iter_16_0 .. "/comfort/icon"))

		local var_16_7 = arg_16_0.detailPage

		var_1_10005 = var_1_10005.Find(var_16_7, "detail/stronghold/furnitures/" .. iter_16_0)

		local var_16_8 = false

		for iter_16_1 = 0, var_1_10005.childCount - 1 do
			local var_16_9 = var_1_10005:GetChild(iter_16_1)
			local var_16_10 = true

			for iter_16_2 = 0, var_16_9.childCount - 1 do
				local var_16_11 = var_16_9
				local var_16_12 = var_16_9.GetChild(var_16_11, iter_16_2)

				tonumber = var_16_11

				local var_16_13 = var_16_11(var_16_12.name)

				table = var_19

				local var_16_14 = var_19.contains(arg_16_0.okFurnitureIds, var_16_13)

				setActive = var_20

				var_20(var_16_12:Find("fur"), var_16_14)

				setActive = var_20

				var_20(var_16_12:Find("lockFur"), not var_16_14)

				setActive = var_20

				var_20(var_16_12:Find("comfort"), not var_16_14)

				setText = var_20

				var_20(var_16_12:Find("comfort/comf/count"), var_0_2[var_16_13].com_add)

				if not var_16_14 then
					var_16_10 = false
					onButton = var_20

					local var_16_15 = arg_16_0
					local var_16_16 = var_16_12

					local function var_16_17()
						local var_17_0 = arg_16_0

						var_0.ShowMakePanel(var_17_0, var_16_13)

						return
					end

					SFX_PANEL = var_1_10024

					var_20(var_16_15, var_16_16, var_16_17, var_1_10024)
				else
					removeOnButton = var_20

					var_20(var_16_12)
				end
			end

			setActive = var_13

			var_13(var_16_9, not var_16_8)

			if not var_16_8 and not var_16_10 then
				var_16_8 = true
			end
		end
	end

	onButton = var_1

	local var_16_18 = arg_16_0
	local var_16_19 = arg_16_0.detailPage
	local var_16_20 = var_3.Find(var_16_19, "leftChange")

	local function var_16_21()
		local var_18_0 = arg_16_0

		var_0.EnterDetailPage(var_18_0, arg_16_0.strongholdIndex - 1 == 0 and 3 or arg_16_0.strongholdIndex - 1)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_18, var_16_20, var_16_21, var_5)

	onButton = var_1

	local var_16_22 = arg_16_0
	local var_16_23 = arg_16_0.detailPage
	local var_16_24 = var_3.Find(var_16_23, "rightChange")

	local function var_16_25()
		local var_19_0 = arg_16_0

		var_0.EnterDetailPage(var_19_0, arg_16_0.strongholdIndex + 1 == 4 and 1 or arg_16_0.strongholdIndex + 1)

		return
	end

	SFX_PANEL = var_5

	var_1(var_16_22, var_16_24, var_16_25, var_5)

	return
end

function var_0_1.EnterDetailPage(arg_20_0, arg_20_1)
	arg_20_0.strongholdIndex = arg_20_1
	setActive = var_1_10002

	var_1_10002(arg_20_0.strongholdPage, false)

	setActive = var_1_10002

	var_1_10002(arg_20_0.detailPage, true)

	for iter_20_0 = 1, 3 do
		setActive = var_1_10006

		local var_20_0 = arg_20_0.detailPage

		var_1_10006(var_7.Find(var_20_0, "info/" .. iter_20_0), iter_20_0 == arg_20_1)
	end

	setText = var_2

	local var_20_1 = arg_20_0.detailPage

	var_2(var_3.Find(var_20_1, "detail/progress/countBg/furnitureCount"), arg_20_0.furnitureCount[arg_20_1] .. "/" .. arg_20_0.allFurnitureCount[arg_20_1])

	for iter_20_1 = 1, 3 do
		setActive = var_6

		local var_20_2 = arg_20_0.detailPage

		var_6(var_7.Find(var_20_2, "detail/stronghold/furnitures/" .. iter_20_1), iter_20_1 == arg_20_1)
	end

	local var_20_3 = false
	local var_20_4 = 0
	local var_20_5 = arg_20_0.awardInfos[arg_20_1]
	local var_20_6 = arg_20_0.awardList

	var_5.make(var_20_6, function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventUpdate then
			local var_21_0 = var_20_5[arg_21_1 + 1][1]
			local var_21_1 = var_20_5[arg_21_1 + 1][2]
			local var_21_2 = {
				type = var_21_1[1],
				id = var_21_1[2],
				count = var_21_1[3]
			}

			updateDrop = var_6

			var_6(arg_21_2:Find("award"), var_21_2)

			onButton = var_6

			local var_21_3 = arg_20_0
			local var_21_4 = arg_21_2:Find("award")

			local function var_21_5()
				local var_22_0 = arg_20_0
				local var_22_1 = var_0.emit

				BaseUI = var_3_10002

				var_22_1(var_22_0, var_3_10002.ON_DROP, var_21_2)

				return
			end

			SFX_PANEL = var_10

			var_6(var_21_3, var_21_4, var_21_5, var_10)

			setText = var_6

			var_6(arg_21_2:Find("comfort"), var_21_0)

			setActive = var_6

			var_6(arg_21_2:Find("got"), arg_21_1 < arg_20_0.gotAwardIndex[arg_20_1])

			setActive = var_6

			var_6(arg_21_2:Find("canGet"), var_21_0 <= arg_20_0.comfortCount[arg_20_1] and arg_21_1 >= arg_20_0.gotAwardIndex[arg_20_1])

			if var_21_0 <= arg_20_0.comfortCount[arg_20_1] and arg_21_1 >= arg_20_0.gotAwardIndex[arg_20_1] then
				var_20_3 = true
				var_20_4 = arg_21_1 + 1
			end
		end

		return
	end)

	local var_20_7 = arg_20_0.awardList

	var_5.align(var_20_7, #var_20_5)

	setActive = var_5

	local var_20_8 = arg_20_0.detailPage

	var_5(var_6.Find(var_20_8, "detail/allGetBtn/VX"), var_20_3)

	if var_20_3 then
		setGray = var_5

		local var_20_9 = arg_20_0.detailPage

		var_5(var_6.Find(var_20_9, "detail/allGetBtn"), false, false)

		onButton = var_5

		local var_20_10 = arg_20_0
		local var_20_11 = arg_20_0.detailPage
		local var_20_12 = var_7.Find(var_20_11, "detail/allGetBtn")

		local function var_20_13()
			local var_23_0 = arg_20_0
			local var_23_1 = var_0.emit

			YoumiyaStrongholdMediator = var_2_10002

			var_23_1(var_23_0, var_2_10002.GET_AWARD, arg_20_1, var_20_4)

			return
		end

		SFX_PANEL = var_9

		var_5(var_20_10, var_20_12, var_20_13, var_9)
	else
		setGray = var_5

		local var_20_14 = arg_20_0.detailPage

		var_5(var_6.Find(var_20_14, "detail/allGetBtn"), true, false)

		removeOnButton = var_5

		local var_20_15 = arg_20_0.detailPage

		var_5(var_6.Find(var_20_15, "detail/allGetBtn"))
	end

	isActive = var_5

	if var_5(arg_20_0.makeFurniturePanel) then
		triggerButton = var_5

		local var_20_16 = arg_20_0.makeFurniturePanel

		var_5(var_6.Find(var_20_16, "panel/closeBtn"))
	end

	return
end

function var_0_1.ShowMakePanel(arg_24_0, arg_24_1)
	setActive = var_1_10002

	var_1_10002(arg_24_0.makeFurniturePanel, true)

	local var_24_0 = var_0_2[arg_24_1]
	local var_24_1 = var_0_3[var_24_0.fur_id]
	local var_24_2 = arg_24_0.makeFurniturePanel
	local var_24_3 = var_4.GetComponent

	typeof = var_1_10006
	Animation = var_1_10007

	local var_24_4 = var_24_3(var_24_2, var_1_10006(var_1_10007))
	local var_24_5 = arg_24_0.makeFurniturePanel
	local var_24_6 = var_5.GetComponent

	typeof = var_1_10007
	DftAniEvent = var_1_10008

	local var_24_7 = var_24_6(var_24_5, var_1_10007(var_1_10008))

	onButton = var_24_5

	local var_24_8 = arg_24_0
	local var_24_9 = arg_24_0.makeFurniturePanel
	local var_24_10 = var_8.Find(var_24_9, "panel/closeBtn")

	local function var_24_11()
		if arg_24_0.isOnMake then
			return
		end

		local var_25_0 = var_24_7

		var_0.SetEndEvent(var_25_0, function()
			setActive = var_3_10000

			var_3_10000(arg_24_0.makeFurniturePanel, false)

			return
		end)

		local var_25_1 = var_24_4

		var_0.Play(var_25_1, "Anim_YoumiyaStrongholdUI_makeFurniture_Out")

		return
	end

	SFX_PANEL = var_10

	var_24_5(var_24_8, var_24_10, var_24_11, var_10)

	onButton = var_24_5

	local var_24_12 = arg_24_0
	local var_24_13 = arg_24_0._tf
	local var_24_14 = var_8.Find(var_24_13, "bg")

	local function var_24_15()
		triggerButton = var_2_10000

		local var_27_0 = arg_24_0.makeFurniturePanel

		var_2_10000(var_1.Find(var_27_0, "panel/closeBtn"))

		return
	end

	SFX_PANEL = var_10

	var_24_5(var_24_12, var_24_14, var_24_15, var_10)

	setText = var_24_5

	local var_24_16 = arg_24_0.makeFurniturePanel

	var_24_5(var_7.Find(var_24_16, "panel/name"), var_24_1.name)

	HXSet = var_24_5

	local var_24_17, var_24_18 = var_24_5.autoHxShiftPath("furnitures/" .. var_24_1.picture, "")
	local var_24_19 = arg_24_0.makeFurniturePanel
	local var_24_20 = var_8.Find(var_24_19, "panel/icon")
	local var_24_21 = var_8.GetComponent

	typeof = var_10
	Image = var_1_10011

	local var_24_22 = var_24_21(var_24_20, var_10(var_1_10011))

	GetSpriteFromAtlasAsync = var_24_20

	var_24_20(var_24_17, var_24_18, function(arg_28_0)
		var_24_22.sprite = arg_28_0

		local var_28_0 = var_24_22

		var_1.SetNativeSize(var_28_0)

		local var_28_1 = var_24_22.sprite.rect.width
		local var_28_2

		if not (var_24_22.sprite.rect.height <= var_28_1) or not (300 / var_28_1) then
			var_28_2 = 300 / var_2
		end

		local var_28_3 = arg_24_0.makeFurniturePanel
		local var_28_4 = var_4.Find(var_28_3, "panel/icon")

		Vector3 = var_28_3
		var_28_4.localScale = var_28_3(var_28_2, var_28_2, 1)

		return
	end)

	setText = var_24_20

	local var_24_23 = arg_24_0.makeFurniturePanel

	var_24_20(var_10.Find(var_24_23, "panel/comfort/count"), var_24_0.com_add)

	setText = var_24_20

	local var_24_24 = arg_24_0.makeFurniturePanel

	var_24_20(var_10.Find(var_24_24, "panel/desc"), var_24_1.describe)

	setActive = var_24_20

	local var_24_25 = arg_24_0.makeFurniturePanel

	var_24_20(var_10.Find(var_24_25, "panel/complete"), false)

	onButton = var_24_20

	local var_24_26 = arg_24_0
	local var_24_27 = arg_24_0.makeFurniturePanel
	local var_24_28 = var_11.Find(var_24_27, "panel/consume/goBtn")

	local function var_24_29()
		local var_29_0 = arg_24_0
		local var_29_1 = var_0.emit

		YoumiyaStrongholdMediator = var_2_10002

		local var_29_2 = var_2_10002.YOUMIA_GO_SCENE

		SCENE = var_2_10003

		var_29_1(var_29_0, var_29_2, var_2_10003.ATELIER_COMPOSITE, {
			activityID = 50043,
			versionIndex = 2
		})

		return
	end

	SFX_PANEL = var_13

	var_24_20(var_24_26, var_24_28, var_24_29, var_13)

	local var_24_30 = arg_24_0

	arg_24_0.SetConsumeList(var_24_30, var_24_0.material)

	local var_24_31 = true

	ipairs = var_24_30

	for iter_24_0, iter_24_1 in var_24_30(var_24_0.material) do
		local var_24_32 = iter_24_1[2]

		if iter_24_1[3] > arg_24_0:GetItemCount(var_24_32) then
			var_24_31 = false
		end
	end

	if var_24_31 then
		setGray = var_10

		local var_24_33 = arg_24_0.makeFurniturePanel

		var_10(var_11.Find(var_24_33, "panel/makeBtn"), false, true)

		onButton = var_10

		local var_24_34 = arg_24_0
		local var_24_35 = arg_24_0.makeFurniturePanel
		local var_24_36 = var_12.Find(var_24_35, "panel/makeBtn")

		local function var_24_37()
			arg_24_0.isOnMake = true

			local var_30_0 = var_24_7

			var_0.SetTriggerEvent(var_30_0, function()
				local var_31_0 = arg_24_0
				local var_31_1 = var_0.emit

				YoumiyaStrongholdMediator = var_3_10002

				var_31_1(var_31_0, var_3_10002.MAKE_FURNITURE, arg_24_1, var_24_0.material)

				local var_31_2 = arg_24_0

				var_31_2.isOnMake = false
				triggerButton = var_31_2

				local var_31_3 = arg_24_0.makeFurniturePanel

				var_31_2(var_1.Find(var_31_3, "panel/closeBtn"))

				return
			end)

			setActive = var_0

			local var_30_1 = arg_24_0.makeFurniturePanel

			var_0(var_1.Find(var_30_1, "panel/complete"), true)

			local var_30_2 = arg_24_0.makeFurniturePanel
			local var_30_3 = var_0.GetComponent

			typeof = var_2
			Animation = var_3

			local var_30_4 = var_30_3(var_30_2, var_2(var_3))

			var_0.Play(var_30_4, "Anim_YoumiyaStrongholdUI_makeFurniture_Complete")

			removeOnButton = var_0

			local var_30_5 = arg_24_0.makeFurniturePanel

			var_0(var_1.Find(var_30_5, "panel/makeBtn"))

			return
		end

		SFX_PANEL = var_14

		var_10(var_24_34, var_24_36, var_24_37, var_14)
	else
		setGray = var_10

		local var_24_38 = arg_24_0.makeFurniturePanel

		var_10(var_11.Find(var_24_38, "panel/makeBtn"), true, true)

		removeOnButton = var_10

		local var_24_39 = arg_24_0.makeFurniturePanel

		var_10(var_11.Find(var_24_39, "panel/makeBtn"))
	end

	return
end

function var_0_1.SetConsumeList(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.makeFurniturePanel
	local var_32_1 = var_2.Find(var_32_0, "panel/consume/consumeList")
	local var_32_2 = {}

	ipairs = var_4

	for iter_32_0, iter_32_1 in var_4(arg_32_1) do
		table = var_1_10009

		var_1_10009.insert(var_32_2, {
			iter_32_1[2],
			iter_32_1[3]
		})
	end

	for iter_32_2 = 0, var_32_1.childCount - 1 do
		setActive = iter_32_1

		iter_32_1(var_32_1:GetChild(iter_32_2), false)
	end

	ipairs = var_4

	for iter_32_3, iter_32_4 in var_4(var_32_2) do
		local var_32_3 = iter_32_4[1]
		local var_32_4 = iter_32_4[2]

		for iter_32_5 = 0, var_32_1.childCount - 1 do
			local var_32_5 = var_32_1:GetChild(iter_32_5).name

			tostring = var_17

			if var_32_5 == var_17(var_32_3) then
				setActive = var_32_5

				var_32_5(var_15, true)

				setText = var_32_5

				var_32_5(var_15:Find("count1"), arg_32_0:GetItemCount(var_32_3))

				setText = var_32_5

				var_32_5(var_15:Find("count2"), "/" .. var_32_4)

				break
			end
		end
	end

	return
end

function var_0_1.GetComfortableLevel(arg_33_0, arg_33_1)
	if arg_33_1 < 30 then
		return 1
	elseif arg_33_1 >= 30 and arg_33_1 < 68 then
		return 2
	else
		return 3
	end

	return
end

function var_0_1.GetItemCount(arg_34_0, arg_34_1)
	local var_34_0 = 0

	if arg_34_1 == 6 then
		getProxy = var_1_10003
		PlayerProxy = var_1_10004

		local var_34_1 = var_1_10003(var_1_10004)
		local var_34_2 = var_3.getRawData(var_34_1)
		local var_34_3 = var_3.getResource

		PlayerConst = var_1_10006
		var_34_0 = var_34_3(var_34_2, var_1_10006.ResDormMoney)
	elseif arg_34_0.items[arg_34_1] then
		var_34_0 = arg_34_0.items[arg_34_1].count
	end

	return var_34_0
end

function var_0_1.GoBack(arg_35_0)
	isActive = var_1_10001

	if var_1_10001(arg_35_0.detailPage) then
		setActive = var_1

		var_1(arg_35_0.strongholdPage, true)

		setActive = var_1

		var_1(arg_35_0.detailPage, false)

		arg_35_0.strongholdIndex = nil
		isActive = var_1

		if var_1(arg_35_0.makeFurniturePanel) then
			triggerButton = var_1

			local var_35_0 = arg_35_0.makeFurniturePanel

			var_1(var_2.Find(var_35_0, "panel/closeBtn"))
		end

		for iter_35_0 = 1, 3 do
			local var_35_1 = arg_35_0.detailPage
			local var_35_2 = var_5.Find(var_35_1, "detail/stronghold/furnitures/" .. iter_35_0)

			for iter_35_1 = 1, var_35_2.childCount do
				local var_35_3 = var_35_2:Find(iter_35_1)

				for iter_35_2 = 0, var_35_3.childCount - 1 do
					local var_35_4 = var_35_3
					local var_35_5 = var_35_3.GetChild(var_35_4, iter_35_2)

					setActive = var_35_4

					var_35_4(var_35_5:Find("comfort/icon/VX"), false)
				end
			end
		end

		return
	end

	arg_35_0:closeView()

	return
end

function var_0_1.willExit(arg_36_0)
	pg = var_1_10001

	local var_36_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_36_0, arg_36_0._tf)

	if arg_36_0.camEventId then
		pg = var_1

		local var_36_1 = var_1.CameraFixMgr.GetInstance()

		var_1.disconnect(var_36_1, arg_36_0.camEventId)

		arg_36_0.camEventId = nil
	end

	return
end

function var_0_1.onBackPressed(arg_37_0)
	arg_37_0:GoBack()

	return
end

function var_0_1.ShouldShowTip()
	pg = var_1_10000

	local var_38_0 = var_1_10000.activity_template

	ActivityConst = var_1_10001

	local var_38_1 = var_38_0[var_1_10001.YUMIA_BASE_ACT_ID].config_client.rewards

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_38_2 = var_1_10002(var_1_10003)
	local var_38_3 = var_2.getActivityById

	ActivityConst = var_1_10004

	local var_38_4 = var_38_3(var_38_2, var_1_10004.YUMIA_BASE_ACT_ID)
	local var_38_5 = var_2.getData1List(var_38_4)
	local var_38_6 = {
		0,
		0,
		0
	}

	for iter_38_0 = 1, 3 do
		var_38_6[iter_38_0] = var_2:getKVPList(1, iter_38_0)
	end

	local var_38_7 = {
		0,
		0,
		0
	}

	for iter_38_1 = 1, 3 do
		local var_38_8 = var_0_2.get_id_list_by_type[iter_38_1]

		ipairs = var_1_10011

		for iter_38_2, iter_38_3 in var_1_10011(var_38_8) do
			table = var_1_10016

			if var_1_10016.contains(var_38_5, iter_38_3) then
				var_1_10016 = var_0_2[iter_38_3]
				var_38_7[iter_38_1] = var_38_7[iter_38_1] + var_1_10016.com_add
			end
		end
	end

	local var_38_9 = false

	for iter_38_4 = 1, 3 do
		local var_38_10 = false
		local var_38_11 = var_38_1[iter_38_4]

		for iter_38_5 = 1, #var_38_11 do
			local var_38_12 = var_38_11[iter_38_5][1]
			local var_38_13 = var_38_11[iter_38_5][2]

			if var_38_12 <= var_38_7[iter_38_4] and iter_38_5 > var_38_6[iter_38_4] then
				var_38_10 = true

				break
			end
		end

		if var_38_10 then
			var_38_9 = true

			break
		end
	end

	return var_38_9
end

return var_0_1
