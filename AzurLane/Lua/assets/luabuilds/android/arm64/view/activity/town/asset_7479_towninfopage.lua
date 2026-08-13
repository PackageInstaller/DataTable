class = var_0_10000

local var_0_0 = "TownInfoPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.SLOT_CNT = 9

function var_0_1.getUIName(arg_1_0)
	return "TownInfoPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.togglesTF = var_1.Find(var_2_0, "frame/toggles")
	eachChild = var_1

	var_1(arg_2_0.togglesTF, function(arg_3_0)
		onToggle = var_2_10001

		local var_3_0 = arg_2_0
		local var_3_1 = arg_3_0

		local function var_3_2(arg_4_0)
			setImageColor = var_3_10001

			local var_4_0 = arg_3_0
			local var_4_1 = var_3.Find(var_4_0, "name")

			Color = var_3_10004

			var_3_10001(var_4_1, var_3_10004.NewHex(arg_4_0 and "F5ECDD" or "796464"))

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10001(var_3_0, var_3_1, var_3_2, var_2_10006)

		return
	end)

	local var_2_1 = arg_2_0.togglesTF

	arg_2_0.townTip = var_1.Find(var_2_1, "town/tip")

	local var_2_2 = arg_2_0.togglesTF

	arg_2_0.placeTip = var_1.Find(var_2_2, "place/tip")

	local var_2_3 = arg_2_0.togglesTF

	arg_2_0.shipTip = var_1.Find(var_2_3, "ship/tip")

	local var_2_4 = arg_2_0._tf

	arg_2_0.townPanel = var_1.Find(var_2_4, "frame/panels/town_panel")

	local var_2_5 = arg_2_0.townPanel

	arg_2_0.townLevelNow = var_1.Find(var_2_5, "lvmask/level_now")

	local var_2_6 = arg_2_0.townPanel

	arg_2_0.townLevelNext = var_1.Find(var_2_6, "lvmask/level_next")

	local var_2_7 = arg_2_0.townPanel

	arg_2_0.curExp = var_1.Find(var_2_7, "infos/exp/value/cur")

	local var_2_8 = arg_2_0.townPanel

	arg_2_0.needExp = var_1.Find(var_2_8, "infos/exp/value/need")

	local var_2_9 = arg_2_0.townPanel

	arg_2_0.goldOutput = var_1.Find(var_2_9, "infos/output/value")

	local var_2_10 = arg_2_0.townPanel

	arg_2_0.goldLimit = var_1.Find(var_2_10, "infos/limit/value")

	local var_2_11 = arg_2_0.townPanel

	arg_2_0.townUpgradeTF = var_1.Find(var_2_11, "upgrade_status")

	local var_2_12 = arg_2_0._tf

	arg_2_0.shipPanel = var_1.Find(var_2_12, "frame/panels/ship_panel")
	UIItemList = var_1

	local var_2_13 = var_1.New
	local var_2_14 = arg_2_0.shipPanel
	local var_2_15 = var_3.Find(var_2_14, "content")
	local var_2_16 = arg_2_0.shipPanel

	arg_2_0.shipUIList = var_2_13(var_2_15, var_4.Find(var_2_16, "content/tpl"))

	local var_2_17 = arg_2_0.shipUIList

	var_1.make(var_2_17, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_2_0

			var_3.UpdateShip(var_5_0, arg_5_1, arg_5_2)
		end

		return
	end)

	local var_2_18 = arg_2_0._tf

	arg_2_0.placePanel = var_1.Find(var_2_18, "frame/panels/place_panel")
	setText = var_1

	local var_2_19 = arg_2_0.placePanel
	local var_2_20 = var_3.Find(var_2_19, "view/content/tpl/next/title")

	i18n = var_4

	var_1(var_2_20, var_4("town_place_next_title"))

	UIItemList = var_1

	local var_2_21 = var_1.New
	local var_2_22 = arg_2_0.placePanel
	local var_2_23 = var_3.Find(var_2_22, "view/content")
	local var_2_24 = arg_2_0.placePanel

	arg_2_0.placeUIList = var_2_21(var_2_23, var_4.Find(var_2_24, "view/content/tpl"))

	local var_2_25 = arg_2_0.placeUIList

	var_1.make(var_2_25, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_2_0

			var_3.UpdatePlace(var_6_0, arg_6_1, arg_6_2)
		end

		return
	end)

	pg = var_1
	arg_2_0.specialWorkGroup = var_1.gameset.activity_town_special_work.key_value

	return
end

function var_0_1.SetActivity(arg_7_0, arg_7_1)
	local var_7_1

	if not arg_7_1 then
		::label_7_0::

		getProxy = var_7_1
		ActivityProxy = var_1_10004

		local var_7_0 = var_7_1(var_1_10004)

		var_7_1 = var_7_1.getActivityByType
		ActivityConst = var_1_10005
		var_7_1 = var_7_1(var_7_0, var_1_10005.ACTIVITY_TYPE_TOWN)
	end

	arg_7_0.activity = var_7_1
	assert = var_7_1

	local var_7_2

	if arg_7_0.activity then
		var_1_10006 = arg_7_0.activity
		var_7_2 = not var_4.isEnd(var_1_10006)
	end

	local var_7_3 = "not exist town act, type: "

	ActivityConst = var_1_10006

	var_7_1(var_7_2, var_7_3 .. var_1_10006.ACTIVITY_TYPE_TOWN)

	return
end

function var_0_1.OnInit(arg_8_0)
	arg_8_0:SetActivity()

	arg_8_0.slotUnlockLv = {}

	;(function()
		ipairs = var_2_10000
		pg = var_2_10002

		for iter_9_0, iter_9_1 in var_2_10000(var_2_10002.activity_town_level.all) do
			pg = var_2_10005
			var_2_10005 = var_2_10005.activity_town_level[iter_9_1].unlock_chara

			for iter_9_2 = 1, var_2_10005 do
				if not arg_8_0.slotUnlockLv[iter_9_2] then
					arg_8_0.slotUnlockLv[iter_9_2] = iter_9_1
				end

				if arg_8_0.slotUnlockLv[var_0_1.SLOT_CNT] then
					return
				end
			end
		end

		return
	end)()

	triggerToggle = var_2

	local var_8_0 = arg_8_0.togglesTF

	var_2(var_4.Find(var_8_0, "town"), true)

	return
end

function var_0_1.Flush(arg_10_0)
	arg_10_0:FlushTownPanel()
	arg_10_0:FlushShipPanel()
	arg_10_0:FlushPlacePanel()
	arg_10_0:Show()

	return
end

function var_0_1.OnExpUpdate(arg_11_0)
	local var_11_0 = arg_11_0.activity
	local var_11_1 = var_1.GetExp(var_11_0)

	pg = var_1_10002

	local var_11_2 = var_1_10002.activity_town_level[arg_11_0.townLv].exp

	setText = var_3

	var_3(arg_11_0.curExp, var_11_1)

	setTextColor = var_3

	local var_11_3 = arg_11_0.curExp

	Color = var_6

	local var_11_4 = var_6.NewHex

	isMaxLv = var_1_10008

	var_3(var_11_3, var_11_4(not var_1_10008 and var_11_1 < var_11_2 and "CC3A33" or "63423E"))

	setText = var_3

	local var_11_5 = arg_11_0.needExp
	local var_11_6 = "/"

	isMaxLv = var_1_10007

	var_3(var_11_5, var_11_6 .. (var_1_10007 and 0 or var_11_2))

	return
end

function var_0_1.OnTownUpgrade(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.townPanel
	local var_12_1 = var_2.GetComponent

	typeof = var_1_10005
	DftAniEvent = var_1_10007

	local var_12_2 = var_12_1(var_12_0, var_1_10005(var_1_10007))

	var_2.SetEndEvent(var_12_2, function()
		if arg_12_1 then
			arg_12_1()
		end

		arg_12_0.inTownAnim = false

		local var_13_0 = var_0

		var_0.SetEndEvent(var_13_0, nil)

		return
	end)
	var_2:SetTriggerEvent(function()
		local var_14_0 = arg_12_0

		var_0.Flush(var_14_0)

		local var_14_1 = var_0

		var_0.SetTriggerEvent(var_14_1, nil)

		return
	end)

	local var_12_3 = arg_12_0.townPanel
	local var_12_4 = var_3.GetComponent

	typeof = var_6
	Animation = var_1_10008

	local var_12_5 = var_12_4(var_12_3, var_6(var_1_10008))

	var_3.Play(var_12_5, "anim_cowboy_info_town_lvup")

	arg_12_0.inTownAnim = true

	local var_12_6 = arg_12_0
	local var_12_7 = arg_12_0.managedTween

	LeanTween = var_6

	var_12_7(var_12_6, var_6.delayedCall, function()
		local var_15_0 = arg_12_0

		var_0.FlushTownWithoutLv(var_15_0)

		return
	end, 0.265, nil)

	return
end

function var_0_1.OnPlaceUpgrade(arg_16_0, arg_16_1)
	arg_16_0.townUpgradeCb = arg_16_1

	arg_16_0:Flush()

	return
end

function var_0_1.UpdateTownStatus(arg_17_0)
	local var_17_0 = arg_17_0.activity
	local var_17_1, var_17_2, var_17_3 = var_1.CanUpgradeTown(var_17_0)

	setActive = var_1_10004

	var_1_10004(arg_17_0.townTip, var_17_1)

	eachChild = var_1_10004

	var_1_10004(arg_17_0.townUpgradeTF, function(arg_18_0)
		setActive = var_2_10001

		var_2_10001(arg_18_0, arg_18_0.name == var_17_2)

		return
	end)

	onButton = var_1_10004

	local var_17_4 = arg_17_0
	local var_17_5 = arg_17_0.townUpgradeTF
	local var_17_6 = var_7.Find(var_17_5, "normal")

	local function var_17_7()
		if not var_17_1 or arg_17_0.inTownAnim then
			return
		end

		local var_19_0 = arg_17_0
		local var_19_1 = var_0.emit

		TownMediator = var_2_10003

		var_19_1(var_19_0, var_2_10003.UPGRADE_TOWN)

		return
	end

	SFX_PANEL = var_17_5

	var_1_10004(var_17_4, var_17_6, var_17_7, var_17_5)

	if var_17_2 == "no_story" then
		setText = var_1_10004

		local var_17_8 = arg_17_0.townUpgradeTF

		var_1_10004(var_6.Find(var_17_8, "no_story/content/value/cur"), var_17_3[1])

		setText = var_1_10004

		local var_17_9 = arg_17_0.townUpgradeTF

		var_1_10004(var_6.Find(var_17_9, "no_story/content/value/need"), "/" .. var_17_3[2])
	elseif var_17_2 == "no_exp_or_gold" then
		setTextColor = var_1_10004

		local var_17_10 = arg_17_0.townUpgradeTF
		local var_17_11 = var_6.Find(var_17_10, "no_exp_or_gold/cost/Text")

		Color = var_17_6

		var_1_10004(var_17_11, var_17_6.NewHex(var_17_3 == "no_gold" and "FF756E" or "FFEBC9"))
	end

	return
end

function var_0_1.FlushTownWithoutLv(arg_20_0)
	arg_20_0:OnExpUpdate()

	local var_20_0 = arg_20_0.activity
	local var_20_1 = var_1.GetGoldOutput(var_20_0)

	setText = var_1_10002

	local var_20_2 = arg_20_0.goldOutput

	string = var_1_10005

	local var_20_3 = var_1_10005.format
	local var_20_4 = "+%s/H"

	TownActivity = var_1_10008

	var_1_10002(var_20_2, var_20_3(var_20_4, var_1_10008.GoldToShow(var_20_1)))

	local var_20_5 = arg_20_0.activity
	local var_20_6 = var_2.GetLimitGold(var_20_5)

	setText = var_20_0

	local var_20_7 = arg_20_0.goldLimit

	TownActivity = var_1_10006

	var_20_0(var_20_7, var_1_10006.GoldToShow(var_20_6))

	TownActivity = var_20_0

	local var_20_8 = var_20_0.GoldToShow

	pg = var_20_7

	local var_20_9 = var_20_8(var_20_7.activity_town_level[arg_20_0.townLv].gold)

	setText = var_20_5

	local var_20_10 = arg_20_0.townUpgradeTF

	var_20_5(var_6.Find(var_20_10, "normal/cost/Text"), var_20_9)

	setText = var_20_5

	local var_20_11 = arg_20_0.townUpgradeTF

	var_20_5(var_6.Find(var_20_11, "no_exp_or_gold/cost/Text"), var_20_9)
	arg_20_0:UpdateTownStatus()

	return
end

function var_0_1.FlushTownPanel(arg_21_0)
	local var_21_0 = arg_21_0.activity

	arg_21_0.townLv = var_1.GetTownLevel(var_21_0)

	local var_21_1 = arg_21_0.activity
	local var_21_2 = var_1.IsMaxTownLevel(var_21_1)

	setText = var_1_10002

	var_1_10002(arg_21_0.townLevelNow, "LV." .. (var_21_2 and "MAX" or arg_21_0.townLv))

	setText = var_1_10002

	var_1_10002(arg_21_0.townLevelNext, "LV." .. (var_21_2 and "MAX" or arg_21_0.townLv + 1))
	arg_21_0:FlushTownWithoutLv()

	return
end

function var_0_1.FlushShipPanel(arg_22_0)
	local var_22_0 = arg_22_0.activity

	arg_22_0.shipIds = var_1.GetShipIds(var_22_0)

	local var_22_1 = arg_22_0.activity

	arg_22_0.unlockCnt = var_1.GetUnlockSlotCnt(var_22_1)

	local var_22_2 = arg_22_0.shipUIList

	var_1.align(var_22_2, var_0_1.SLOT_CNT)

	setActive = var_1

	local var_22_3 = arg_22_0.shipTip
	local var_22_4 = arg_22_0.activity

	var_1(var_22_3, var_4.HasEmptySlot(var_22_4))

	return
end

function var_0_1.UpdateShip(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1 + 1 > arg_23_0.unlockCnt

	setActive = var_1_10005

	var_1_10005(arg_23_2:Find("lock"), var_23_0)

	local var_23_1

	if var_23_0 then
		setText = var_1_10005
		var_23_1 = arg_23_2:Find("lock/Text")
		i18n = var_8

		var_1_10005(var_23_1, var_8("town_lock_level", "LV" .. arg_23_0.slotUnlockLv[var_3]))
	end

	local var_23_2 = not arg_23_0.shipIds[var_3] or var_5 == 0

	setActive = var_23_1

	var_23_1(arg_23_2:Find("empty"), var_23_2)

	setActive = var_23_1

	var_23_1(arg_23_2:Find("mask"), not var_23_2)

	local var_23_3

	if not var_23_2 then
		getProxy = var_8
		BayProxy = var_10

		local var_23_4 = var_8(var_10)
		local var_23_5

		if var_8.RawGetShipById(var_23_4, var_5) then
			LoadSprite = var_23_5
			var_23_5 = var_23_5("qicon/" .. var_8:getPainting())
			setImageSprite = var_23_4

			var_23_4(arg_23_2:Find("mask/icon"), var_23_5, true)
		else
			setActive = var_23_5
			var_1_10013 = arg_23_2

			var_23_5(arg_23_2.Find(var_1_10013, "empty"), true)

			setActive = var_23_5
			var_1_10013 = arg_23_2

			var_23_5(arg_23_2.Find(var_1_10013, "mask"), false)
		end
	end

	onButton = var_8

	local var_23_6 = arg_23_0
	local var_23_7 = arg_23_2

	local function var_23_8()
		if var_23_0 then
			return
		end

		local var_24_0 = arg_23_0
		local var_24_1 = var_0.emit

		TownMediator = var_2_10003

		var_24_1(var_24_0, var_2_10003.OPEN_CHUANWU, var_0, var_23_3)

		return
	end

	SFX_PANEL = var_1_10013

	var_8(var_23_6, var_23_7, var_23_8, var_1_10013)

	return
end

function var_0_1.FlushPlacePanel(arg_25_0)
	local var_25_0 = arg_25_0.activity

	arg_25_0.placeList = var_1.GetPlaceList(var_25_0)
	table = var_1

	local var_25_1 = var_1.sort
	local var_25_2 = arg_25_0.placeList

	CompareFuncs = var_1_10004

	var_25_1(var_25_2, var_1_10004({
		function(arg_26_0)
			return arg_26_0:GetNextId() and 0 or 1
		end,
		function(arg_27_0)
			return arg_27_0.id
		end
	}))

	local var_25_3 = arg_25_0.placeUIList

	var_1.align(var_25_3, #arg_25_0.placeList)

	return
end

function var_0_1.UpdatePlaceStatus(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2
	local var_28_1 = arg_28_2.Find(var_28_0, "upgrade_status")

	TownActivity = var_1_10004

	local var_28_2 = var_1_10004.GoldToShow(arg_28_1:GetCostGold())

	setText = var_28_0

	var_28_0(var_28_1:Find("normal/cost/Text"), var_28_2)

	setText = var_28_0

	var_28_0(var_28_1:Find("no_gold/cost/Text"), var_28_2)

	local var_28_3 = arg_28_0.activity
	local var_28_4, var_28_5 = var_5.CanUpgradePlace(var_28_3, arg_28_1.id)

	if var_28_4 then
		arg_28_0.isShowPlaceTip = true
	end

	eachChild = var_28_3

	var_28_3(var_28_1, function(arg_29_0)
		setActive = var_2_10001

		var_2_10001(arg_29_0, arg_29_0.name == var_28_5)

		return
	end)

	onButton = var_28_3

	local var_28_6 = arg_28_0
	local var_28_7 = var_28_1
	local var_28_8 = var_28_1.Find(var_28_7, "normal")

	local function var_28_9()
		if not var_28_4 or arg_28_0.inPlaceAnim then
			return
		end

		arg_28_0.upgradePlaceName = arg_28_2.name

		local var_30_0 = arg_28_0
		local var_30_1 = var_0.emit

		TownMediator = var_2_10003

		var_30_1(var_30_0, var_2_10003.UPGRADE_WORKPLACE, arg_28_1.id)

		return
	end

	SFX_PANEL = var_28_7

	var_28_3(var_28_6, var_28_8, var_28_9, var_28_7)

	if var_28_5 == "no_level" then
		setText = var_28_3

		local var_28_10 = var_28_1:Find("no_level/Text")

		i18n = var_28_8

		var_28_3(var_28_10, var_28_8("town_lock_level", "LV" .. arg_28_1:GetNeedTownLv()))
	end

	return
end

function var_0_1.UpdatePlace(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.placeList[arg_31_1 + 1]

	arg_31_2.name = arg_31_1 + 1
	setImageSprite = var_4

	local var_31_1 = arg_31_2:Find("info/icon")

	GetSpriteFromAtlas = var_1_10007

	var_4(var_31_1, var_1_10007("ui/townui_atlas", var_31_0:GetIcon()), true)

	setText = var_4

	var_4(arg_31_2:Find("info/name"), var_31_0:GetName())

	setText = var_4

	var_4(arg_31_2:Find("info/gold/Text"), var_31_0:GetEffectStr())

	seriesAsync = var_4

	var_4({
		function(arg_32_0)
			if arg_31_0.upgradePlaceName and arg_31_2.name == arg_31_0.upgradePlaceName then
				local var_32_0 = arg_31_2
				local var_32_1 = var_1.GetComponent

				typeof = var_2_10004
				DftAniEvent = var_2_10006

				local var_32_2 = var_32_1(var_32_0, var_2_10004(var_2_10006))

				var_1.SetEndEvent(var_32_2, function()
					if arg_31_0.townUpgradeCb then
						arg_31_0.townUpgradeCb()

						arg_31_0.townUpgradeCb = nil
					end

					arg_31_0.inPlaceAnim = false

					local var_33_0 = var_0

					var_0.SetEndEvent(var_33_0, nil)

					return
				end)

				local var_32_3 = arg_31_2
				local var_32_4 = var_2.GetComponent

				typeof = var_5
				Animation = var_2_10007

				local var_32_5 = var_32_4(var_32_3, var_5(var_2_10007))

				var_2.Play(var_32_5, "anim_cowboy_info_place_lvup")

				arg_31_0.inPlaceAnim = true

				local var_32_6 = arg_31_0
				local var_32_7 = var_2.managedTween

				LeanTween = var_5

				var_32_7(var_32_6, var_5.delayedCall, function()
					arg_32_0()

					return
				end, 0.2, nil)

				arg_31_0.upgradePlaceName = nil
			else
				arg_32_0()
			end

			return
		end,
		function(arg_35_0)
			local var_35_0 = var_31_0
			local var_35_1 = not var_1.GetNextId(var_35_0)

			setActive = var_35_0

			local var_35_2 = arg_31_2

			var_35_0(var_5.Find(var_35_2, "next"), not var_35_1)

			if not var_35_1 then
				setText = var_35_0

				local var_35_3 = arg_31_2
				local var_35_4 = var_5.Find(var_35_3, "next/infos/exp/value")
				local var_35_5 = "+"
				local var_35_6 = var_31_0

				var_35_0(var_35_4, var_35_5 .. var_7.GetAddExp(var_35_6))

				TownWorkplace = var_35_0

				local var_35_7 = var_35_0.New(var_1)

				setText = var_2_10004

				local var_35_8 = arg_31_2

				var_2_10004(var_6.Find(var_35_8, "next/infos/gold/value"), var_35_7:GetEffectStr())
			end

			return
		end
	}, function()
		return
	end)

	setActive = var_4

	var_4(arg_31_2:Find("info/gold"), var_31_0:GetGroup() ~= arg_31_0.specialWorkGroup)

	setActive = var_4

	var_4(arg_31_2:Find("next/infos/gold"), var_31_0:GetGroup() ~= arg_31_0.specialWorkGroup)
	arg_31_0:UpdatePlaceStatus(var_31_0, arg_31_2)

	return
end

function var_0_1.OnUpdateTime(arg_37_0)
	arg_37_0:UpdateTownStatus()

	arg_37_0.isShowPlaceTip = false
	ipairs = var_1

	for iter_37_0, iter_37_1 in var_1(arg_37_0.placeList) do
		local var_37_0 = arg_37_0
		local var_37_1 = arg_37_0.UpdatePlaceStatus
		local var_37_2 = iter_37_1
		local var_37_3 = arg_37_0.placeUIList.container

		var_37_1(var_37_0, var_37_2, var_10.Find(var_37_3, iter_37_0))
	end

	setActive = var_1

	var_1(arg_37_0.placeTip, arg_37_0.isShowPlaceTip)

	return
end

function var_0_1.OnDestroy(arg_38_0)
	return
end

return var_0_1
