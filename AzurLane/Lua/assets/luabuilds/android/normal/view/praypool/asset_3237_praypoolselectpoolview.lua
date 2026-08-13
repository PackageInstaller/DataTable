class = var_0_10000

local var_0_0 = "PrayPoolSelectPoolView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PrayPoolSelectPoolView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	return
end

function var_0_1.OnBackPress(arg_4_0)
	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	PrayProxy = var_1_10002
	arg_5_0.prayProxy = var_1_10001(var_1_10002)
	arg_5_0.poolToggleList = {}
	arg_5_0.selectedPoolType = nil

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.poolListContainer = var_1.Find(var_6_0, "PoolList")

	local var_6_1 = arg_6_0._tf

	arg_6_0.poolTpl = var_1.Find(var_6_1, "PoolTpl")

	local var_6_2 = arg_6_0._tf

	arg_6_0.preBtn = var_1.Find(var_6_2, "PreBtn")

	local var_6_3 = arg_6_0._tf

	arg_6_0.nextBtn = var_1.Find(var_6_3, "NextBtn")
	GetComponent = var_1
	arg_6_0.nextBtnCom = var_1(arg_6_0.nextBtn, "Button")
	UIItemList = var_1
	arg_6_0.poolList = var_1.New(arg_6_0.poolListContainer, arg_6_0.poolTpl)

	local var_6_4 = arg_6_0.poolList

	var_1.make(var_6_4, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_7_1 + 1
			local var_7_1 = arg_7_2
			local var_7_2

			var_7_2, setImageSprite = arg_7_2.Find(var_7_1, "PoolImg"), var_7_1
			GetSpriteFromAtlas = var_2_10007

			var_7_1(var_7_2, var_2_10007("ui/prayselectpoolpage_atlas", "pool" .. var_7_0))

			onToggle = var_7_1

			local var_7_3 = arg_6_0
			local var_7_4 = arg_7_2

			local function var_7_5(arg_8_0)
				if arg_8_0 then
					arg_6_0.nextBtnCom.interactable = true
					arg_6_0.selectedPoolType = var_7_0

					local var_8_0 = arg_6_0.prayProxy

					var_1.setSelectedPoolNum(var_8_0, var_7_0)
				else
					arg_6_0.nextBtnCom.interactable = false
					arg_6_0.selectedPoolType = nil

					local var_8_1 = arg_6_0.prayProxy

					var_1.setSelectedPoolNum(var_8_1, nil)
				end

				return
			end

			SFX_PANEL = var_9

			var_7_1(var_7_3, var_7_4, var_7_5, var_9)

			arg_6_0.poolToggleList[var_7_0] = arg_7_2
		end

		return
	end)

	local var_6_5 = arg_6_0.poolList
	local var_6_6 = var_1.align

	pg = var_3

	var_6_6(var_6_5, #var_3.activity_ship_create.all)

	local var_6_7 = arg_6_0.nextBtnCom

	var_6_7.interactable = false
	onButton = var_6_7

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.preBtn

	local function var_6_10()
		local var_9_0 = arg_6_0.prayProxy
		local var_9_1 = var_0.updatePageState

		PrayProxy = var_2_10002

		var_9_1(var_9_0, var_2_10002.STATE_HOME)

		local var_9_2 = arg_6_0
		local var_9_3 = var_0.emit

		PrayPoolConst = var_2

		local var_9_4 = var_2.SWITCH_TO_HOME_PAGE

		PrayProxy = var_2_10003

		var_9_3(var_9_2, var_9_4, var_2_10003.STATE_HOME)

		return
	end

	SFX_PANEL = var_1_10005

	var_6_7(var_6_8, var_6_9, var_6_10, var_1_10005)

	onButton = var_6_7

	local var_6_11 = arg_6_0
	local var_6_12 = arg_6_0.nextBtn

	local function var_6_13()
		local var_10_0 = arg_6_0.prayProxy

		var_0.updateSelectedPool(var_10_0, arg_6_0.selectedPoolType)

		local var_10_1 = arg_6_0.prayProxy
		local var_10_2 = var_0.updatePageState

		PrayProxy = var_2

		var_10_2(var_10_1, var_2.STAGE_SELECT_SHIP)

		local var_10_3 = arg_6_0
		local var_10_4 = var_0.emit

		PrayPoolConst = var_2

		local var_10_5 = var_2.SWITCH_TO_SELECT_SHIP_PAGE

		PrayProxy = var_2_10003

		var_10_4(var_10_3, var_10_5, var_2_10003.STAGE_SELECT_SHIP)

		return
	end

	SFX_PANEL = var_1_10005

	var_6_7(var_6_11, var_6_12, var_6_13, var_1_10005)
	arg_6_0:Show()

	return
end

function var_0_1.updateUI(arg_11_0)
	local var_11_0 = arg_11_0.prayProxy

	if var_1.getSelectedPoolType(var_11_0) then
		triggerToggle = var_11_0

		var_11_0(arg_11_0.poolToggleList[var_1], true)
	else
		return
	end

	return
end

return var_0_1
