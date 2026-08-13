class = var_0_10000

local var_0_0 = "WorldAllocateLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.TeamNum = {
	"FIRST",
	"SECOND",
	"THIRD",
	"FOURTH",
	"FIFTH",
	"SIXTH"
}

function var_0_1.getUIName(arg_1_0)
	return "WorldAllocateUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0._selectedShipList = {}
	arg_2_0._shipTFList = {}
	arg_2_0._shipVOList = {}

	local var_2_0 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_0, "actions/cancel_button")

	local var_2_1 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_1, "actions/compose_button")

	local var_2_2 = arg_2_0._tf

	arg_2_0.itemTF = var_1.Find(var_2_2, "item")

	local var_2_3 = arg_2_0._tf

	arg_2_0.nameTF = var_1.Find(var_2_3, "item/name_container/name")

	local var_2_4 = arg_2_0._tf

	arg_2_0.descTF = var_1.Find(var_2_4, "item/desc")

	local var_2_5 = arg_2_0._tf

	arg_2_0.fleetInfo = var_1.Find(var_2_5, "fleet_info")
	setText = var_1

	local var_2_6 = arg_2_0.fleetInfo
	local var_2_7 = var_3.Find(var_2_6, "top/Text")

	i18n = var_4

	var_1(var_2_7, var_4("world_ship_repair"))

	arg_2_0.shipTpl = arg_2_0:getTpl("fleet_info/shiptpl")
	arg_2_0.emptyTpl = arg_2_0:getTpl("fleet_info/emptytpl")

	local var_2_8 = arg_2_0._tf

	arg_2_0.shipsContainer = var_1.Find(var_2_8, "fleet_info/contain")

	local var_2_9 = arg_2_0._tf

	arg_2_0.descLabel = var_1.Find(var_2_9, "fleet_info/top/Text")
	setText = var_1

	local var_2_10 = arg_2_0.fleetInfo
	local var_2_11 = var_3.Find(var_2_10, "tip/Text")

	i18n = var_4

	var_1(var_2_11, var_4("world_battle_damage"))

	local var_2_12 = arg_2_0._tf

	arg_2_0.countLabel = var_1.Find(var_2_12, "count")

	local var_2_13 = arg_2_0._tf

	arg_2_0.quotaTxt = var_1.Find(var_2_13, "count/value")

	local var_2_14 = arg_2_0._tf

	arg_2_0.btnFleet = var_1.Find(var_2_14, "fleets/selected")

	local var_2_15 = arg_2_0._tf

	arg_2_0.fleetToggleMask = var_1.Find(var_2_15, "fleets/list_mask")

	local var_2_16 = arg_2_0.fleetToggleMask

	arg_2_0.fleetToggleList = var_1.Find(var_2_16, "list")
	onButton = var_1

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.cancelBtn

	local function var_2_19()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_17, var_2_18, var_2_19, var_6)

	onButton = var_1

	local var_2_20 = arg_2_0
	local var_2_21 = arg_2_0.confirmBtn

	local function var_2_22()
		if arg_2_0.itemVO.count == 0 then
			pg = var_0

			local var_4_0 = var_0.TipsMgr.GetInstance()
			local var_4_1 = var_0.ShowTips

			i18n = var_2_10003

			var_4_1(var_4_0, var_2_10003("common_no_item_1"))

			return
		end

		local function var_4_2()
			local var_5_0 = {}
			local var_5_1 = arg_2_0

			var_5_1._preSelectedList = {}
			ipairs = var_5_1

			for iter_5_0, iter_5_1 in var_5_1(arg_2_0._selectedShipList) do
				var_5_0[#var_5_0 + 1] = iter_5_1.id
				arg_2_0._preSelectedList[iter_5_1.id] = true
			end

			arg_2_0.confirmCallback(arg_2_0.itemVO.configId, var_5_0)

			return
		end

		if #arg_2_0._selectedShipList > 0 then
			local var_4_3 = false
			local var_4_4 = arg_2_0.itemVO
			local var_4_5 = var_2.getWorldItemType(var_4_4)

			WorldItem = var_2_10003

			local var_4_7

			if var_4_5 == var_2_10003.UsageBuff then
				local var_4_6 = arg_2_0.itemVO

				var_4_7 = var_4_7.getItemBuffID(var_4_6)
				_ = var_4_4
				var_4_3 = var_4_4.any(arg_2_0._selectedShipList, function(arg_6_0)
					return arg_6_0:IsBuffMax()
				end)

				goto label_4_0
			end

			WorldItem = var_4_7

			if var_4_5 ~= var_4_7.UsageHPRegenerate then
				WorldItem = var_4_7

				if var_4_5 == var_4_7.UsageHPRegenerateValue then
					_ = var_4_7
					var_4_3 = var_4_7.any(arg_2_0._selectedShipList, function(arg_7_0)
						return arg_7_0:IsHpFull()
					end)
				end

				::label_4_0::

				if var_4_3 then
					pg = var_4_7

					local var_4_8 = var_4_7.MsgboxMgr.GetInstance()
					local var_4_9 = var_3.ShowMsgBox
					local var_4_10 = {}

					i18n = var_2_10007
					var_4_10.content = var_2_10007("world_ship_healthy")
					var_4_10.onYes = var_4_2

					var_4_9(var_4_8, var_4_10)
				else
					var_4_2()
				end

				return
			end
		end
	end

	SFX_PANEL = var_6

	var_1(var_2_20, var_2_21, var_2_22, var_6)

	onButton = var_1

	local var_2_23 = arg_2_0
	local var_2_24 = arg_2_0.fleetToggleMask

	local function var_2_25()
		local var_8_0 = arg_2_0

		var_0.showOrHideToggleMask(var_8_0, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_2_23, var_2_24, var_2_25, var_6)

	onButton = var_1

	local var_2_26 = arg_2_0
	local var_2_27 = arg_2_0.btnFleet

	local function var_2_28()
		local var_9_0 = arg_2_0

		var_0.showOrHideToggleMask(var_9_0, true)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_26, var_2_27, var_2_28, var_6)

	onButton = var_1

	local var_2_29 = arg_2_0
	local var_2_30 = arg_2_0._tf

	var_1(var_2_29, var_4.Find(var_2_30, "item/reset_btn"), function()
		assert = var_2_10000

		var_2_10000(arg_2_0.contextData.onResetInfo, "without reset info callback")

		local var_10_0 = arg_2_0.contextData.onResetInfo

		Drop = var_2

		local var_10_1 = var_2.New
		local var_10_2 = {
			count = 1
		}

		DROP_TYPE_WORLD_ITEM = var_2_10005
		var_10_2.type = var_2_10005
		var_10_2.id = arg_2_0.itemVO.id

		var_10_0(var_10_1(var_10_2))

		return
	end)

	return
end

function var_0_1.didEnter(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.updateToggleList
	local var_11_2 = arg_11_0.fleetList
	local var_11_3

	if not arg_11_0.contextData.fleetIndex then
		var_11_3 = 1
	end

	var_11_1(var_11_0, var_11_2, var_11_3)

	pg = var_11_1

	local var_11_4 = var_11_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_11_4, arg_11_0._tf)

	return
end

function var_0_1.showOrHideToggleMask(arg_12_0, arg_12_1)
	setActive = var_1_10002

	var_1_10002(arg_12_0.fleetToggleMask, arg_12_1)
	arg_12_0:tweenTabArrow(not arg_12_1)

	return
end

function var_0_1.setFleets(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.fleetList = arg_13_1

	return
end

function var_0_1.setConfirmCallback(arg_14_0, arg_14_1)
	arg_14_0.confirmCallback = arg_14_1

	return
end

function var_0_1.setItem(arg_15_0, arg_15_1)
	arg_15_0.itemVO = arg_15_1
	updateDrop = var_1_10002

	local var_15_0 = arg_15_0.itemTF

	Drop = var_1_10005

	local var_15_1 = var_1_10005.New
	local var_15_2 = {}

	DROP_TYPE_WORLD_ITEM = var_1_10008
	var_15_2.type = var_1_10008
	var_15_2.id = arg_15_1.id
	var_15_2.count = arg_15_1.count

	var_1_10002(var_15_0, var_15_1(var_15_2))

	setText = var_1_10002

	var_1_10002(arg_15_0.nameTF, arg_15_1:getConfig("name"))

	setText = var_1_10002

	var_1_10002(arg_15_0.descTF, arg_15_1:getConfig("display"))

	local var_15_3 = arg_15_0.itemVO

	arg_15_0.quota = var_2.getItemQuota(var_15_3)

	arg_15_0:updateQuota()

	return
end

function var_0_1.updateQuota(arg_16_0)
	setText = var_1_10001

	var_1_10001(arg_16_0.quotaTxt, #arg_16_0._selectedShipList .. "/" .. arg_16_0.quota)

	setActive = var_1_10001

	var_1_10001(arg_16_0.countLabel, true)

	return
end

function var_0_1.flush(arg_17_0, arg_17_1)
	if arg_17_1.id ~= arg_17_0.itemVO.id then
		return
	end

	arg_17_0:setItem(arg_17_0.itemVO)

	local var_17_0 = arg_17_0.itemVO
	local var_17_1 = var_2.getWorldItemType(var_17_0)

	WorldItem = var_3

	if var_17_1 == var_3.UsageBuff then
		arg_17_0:OnUpdateShipBuff()

		goto label_17_0
	end

	WorldItem = var_3

	if var_17_1 ~= var_3.UsageHPRegenerate then
		WorldItem = var_3

		if var_17_1 == var_3.UsageHPRegenerateValue then
			arg_17_0:OnUpdateShipHP()
		end

		::label_17_0::

		return
	end
end

function var_0_1.updateToggleList(arg_18_0, arg_18_1, arg_18_2)
	setActive = var_1_10003

	var_1_10003(arg_18_0.fleetToggleList, true)

	local var_18_0

	for iter_18_0 = 1, arg_18_0.fleetToggleList.childCount do
		local var_18_1 = arg_18_0.fleetToggleList
		local var_18_2 = var_8.GetChild(var_18_1, arg_18_0.fleetToggleList.childCount - iter_18_0)

		setActive = var_1_10009

		var_1_10009(var_18_2, arg_18_1[iter_18_0])

		if arg_18_1[iter_18_0] then
			setActive = var_1_10009

			var_1_10009(var_18_2:Find("lock"), false)

			setText = var_1_10009

			local var_18_3 = var_18_2:Find("on/mask/text")

			i18n = var_12

			var_1_10009(var_18_3, var_12("world_fleetName" .. iter_18_0))

			setText = var_1_10009

			var_1_10009(var_18_2:Find("on/mask/en"), var_0_1.TeamNum[iter_18_0] .. " FLEET")

			setText = var_1_10009

			var_1_10009(var_18_2:Find("on/mask/number"), iter_18_0)

			setText = var_1_10009

			local var_18_4 = var_18_2:Find("off/mask/text")

			i18n = var_12

			var_1_10009(var_18_4, var_12("world_fleetName" .. iter_18_0))

			setText = var_1_10009

			var_1_10009(var_18_2:Find("off/mask/en"), var_0_1.TeamNum[iter_18_0] .. " FLEET")

			setText = var_1_10009

			var_1_10009(var_18_2:Find("off/mask/number"), iter_18_0)

			onToggle = var_1_10009

			local var_18_5 = arg_18_0
			local var_18_6 = var_18_2

			local function var_18_7(arg_19_0)
				if arg_19_0 then
					local var_19_0 = arg_18_0

					var_1.showOrHideToggleMask(var_19_0, false)

					local var_19_1 = arg_18_0

					var_1.setFleet(var_19_1, arg_18_1[iter_18_0].id)

					local var_19_2 = arg_18_0

					var_1.updateQuota(var_19_2)
				end

				return
			end

			SFX_UI_TAG = var_14

			var_1_10009(var_18_5, var_18_6, var_18_7, var_14)

			if arg_18_1[iter_18_0].id == arg_18_2 then
				var_18_0 = var_18_2
			end
		end
	end

	if var_18_0 then
		triggerToggle = var_4

		var_4(var_18_0, true)
	end

	return
end

function var_0_1.updateFleetButton(arg_20_0, arg_20_1)
	setText = var_1_10002

	local var_20_0 = arg_20_0.btnFleet
	local var_20_1 = var_4.Find(var_20_0, "fleet/CnFleet")

	i18n = var_1_10005

	var_1_10002(var_20_1, var_1_10005("world_fleetName" .. arg_20_1))

	setText = var_1_10002

	local var_20_2 = arg_20_0.btnFleet

	var_1_10002(var_4.Find(var_20_2, "fleet/enFleet"), var_0_1.TeamNum[arg_20_1] .. " FLEET")

	setText = var_1_10002

	local var_20_3 = arg_20_0.btnFleet

	var_1_10002(var_4.Find(var_20_3, "fleet/num"), arg_20_1)

	return
end

function var_0_1.tweenTabArrow(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.btnFleet
	local var_21_1 = var_2.Find(var_21_0, "arr")

	setActive = var_1_10003

	var_1_10003(var_21_1, arg_21_1)

	local var_21_2

	if arg_21_1 then
		LeanTween = var_1_10003
		var_1_10003 = var_1_10003.moveLocalY
		go = var_21_2
		var_21_2 = var_1_10003(var_21_2(var_21_1), var_21_1.localPosition.y + 8, 0.8)
		var_1_10003 = var_1_10003.setEase
		LeanTweenType = var_6
		var_21_2 = var_1_10003(var_21_2, var_6.easeInOutSine)

		var_1_10003.setLoopPingPong(var_21_2, -1)
	else
		LeanTween = var_1_10003

		local var_21_3 = var_1_10003.cancel

		go = var_21_2

		var_21_3(var_21_2(var_21_1))

		local var_21_4 = var_21_1.localPosition

		var_21_4.y = 80
		var_21_1.localPosition = var_21_4
	end

	return
end

function var_0_1.setFleet(arg_22_0, arg_22_1)
	arg_22_0:updateFleetButton(arg_22_1)

	local var_22_0 = arg_22_0.itemVO
	local var_22_1 = var_2.getWorldItemType(var_22_0)

	pairs = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10003(arg_22_0._shipTFList) do
		local var_22_2 = iter_22_1:Find("buff/bg/levelup(Clone)")

		IsNil = var_1_10009

		if not var_1_10009(var_22_2) then
			PoolMgr = var_1_10009

			local var_22_3 = var_1_10009.GetInstance()

			var_1_10009.ReturnUI(var_22_3, "levelup", var_22_2)
		end
	end

	removeAllChildren = var_3

	var_3(arg_22_0.shipsContainer)

	arg_22_0.currentFleetIndex = arg_22_1
	arg_22_0._selectedShipList = {}
	arg_22_0._shipTFList = {}

	local var_22_4 = arg_22_0.fleetList[arg_22_0.currentFleetIndex]
	local var_22_5 = var_3.GetShips(var_22_4, true)

	underscore = var_5

	local var_22_6 = var_5.map(var_22_5, function(arg_23_0)
		WorldConst = var_2_10001

		return var_2_10001.FetchShipVO(arg_23_0.id)
	end)
	local var_22_7 = arg_22_0.quota

	for iter_22_2 = 1, 6 do
		local var_22_8 = var_22_5[iter_22_2]
		local var_22_9 = var_22_6[iter_22_2]

		if var_22_5[iter_22_2] then
			cloneTplTo = var_22_10

			local var_22_10 = var_22_10(arg_22_0.shipTpl, arg_22_0.shipsContainer)

			arg_22_0._shipTFList[var_22_8.id] = var_22_10

			local var_22_11 = arg_22_0._shipVOList

			var_22_11[var_22_9.id] = var_22_9
			updateShip = var_22_11

			var_22_11(var_22_10, var_22_9, {
				initStar = true
			})

			local var_22_12 = false

			WorldItem = var_15

			if var_22_1 == var_15.UsageBuff then
				var_22_12 = arg_22_0:initBuff(var_22_10, var_22_8)

				goto label_22_0
			end

			WorldItem = var_15

			if var_22_1 ~= var_15.UsageHPRegenerate then
				WorldItem = var_15

				if var_22_1 == var_15.UsageHPRegenerateValue then
					var_22_12 = arg_22_0:initHP(var_22_10, var_22_8)
				end

				::label_22_0::

				if 0 < var_22_7 and var_22_12 then
					triggerButton = var_15

					var_15(var_22_10)

					var_22_7 = var_22_7 - 1
				end

				if false then
					cloneTplTo = var_22_10

					local var_22_13 = var_22_10(arg_22_0.emptyTpl, arg_22_0.shipsContainer)
				end
			end
		end
	end

	setActive = var_7

	local var_22_14 = arg_22_0.fleetInfo
	local var_22_15 = var_9.Find(var_22_14, "tip")

	underscore = iter_22_2

	var_7(var_22_15, iter_22_2.any(var_22_5, function(arg_24_0)
		return arg_24_0:IsBroken()
	end))

	return
end

function var_0_1.OnUpdateShipHP(arg_25_0)
	local var_25_0 = arg_25_0.fleetList[arg_25_0.currentFleetIndex]
	local var_25_1 = arg_25_0.itemVO
	local var_25_2 = var_2.getItemBuffID(var_25_1)

	pairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(arg_25_0._shipTFList) do
		if arg_25_0._preSelectedList[iter_25_0] then
			local var_25_3 = var_25_0:GetShip(iter_25_0)
			local var_25_4 = iter_25_1
			local var_25_5 = iter_25_1.Find(var_25_4, "hp")
			local var_25_6 = var_9.Find(var_25_5, "progress_bg/bar")

			setImageColor = var_25_4

			local var_25_7 = var_25_6
			local var_25_8 = var_25_3

			if var_25_3.IsHpSafe(var_25_8) then
				Color = var_25_9

				local var_25_9

				if not var_25_9.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882) then
					Color = var_25_9
					var_25_9 = var_25_9.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882)
				end

				var_25_4(var_25_7, var_25_9)

				local var_25_10 = var_25_6
				local var_25_11 = var_25_6.GetComponent

				typeof = var_25_9
				Image = var_25_8

				if var_25_11(var_25_10, var_25_9(var_25_8)).fillAmount < var_25_3.hpRant / 16 then
					LeanTween = var_25_10
					var_25_10 = var_25_10.value
					go = var_1_10015
					var_1_10015 = var_25_10(var_1_10015(var_25_6), var_11, var_12, var_12 - var_11)
					var_25_10 = var_25_10.setOnUpdate
					System = var_16

					var_25_10(var_1_10015, var_16.Action_float(function(arg_26_0)
						local var_26_0 = var_25_6
						local var_26_1 = var_1.GetComponent

						typeof = var_2_10004
						Image = var_2_10006
						var_26_1(var_26_0, var_2_10004(var_2_10006)).fillAmount = arg_26_0

						return
					end))
				end

				setActive = var_25_10

				var_25_10(var_9:Find("broken"), var_25_3:IsBroken())

				var_1_10015 = var_25_3

				if var_25_3.IsHpFull(var_1_10015) then
					triggerButton = var_13

					var_13(iter_25_1)
				else
					var_1_10015 = arg_25_0

					arg_25_0.updateSelectShipHP(var_1_10015, iter_25_1, true, var_25_3)
				end
			end
		end
	end

	arg_25_0._preSelectedList = nil

	return
end

function var_0_1.OnUpdateShipBuff(arg_27_0)
	local var_27_0 = arg_27_0.fleetList[arg_27_0.currentFleetIndex]
	local var_27_1 = arg_27_0.itemVO
	local var_27_2 = var_2.getItemBuffID(var_27_1)

	pairs = var_1_10003

	for iter_27_0, iter_27_1 in var_1_10003(arg_27_0._shipTFList) do
		if arg_27_0._preSelectedList[iter_27_0] then
			local var_27_3 = iter_27_1:Find("buff/value")
			local var_27_4 = var_27_0:GetShip(iter_27_0)
			local var_27_5 = var_9.GetBuff(var_27_4, var_27_2)
			local var_27_6 = var_10.GetFloor(var_27_5)
			local var_27_7 = var_9
			local var_27_8 = var_9.IsBuffMax(var_27_7, var_27_2)

			setText = var_27_5

			var_27_5(var_27_3, var_27_8 and "Lv.MAX" or "Lv." .. var_27_6)

			if var_27_8 then
				triggerButton = var_27_5

				var_27_5(iter_27_1)
			else
				arg_27_0:updateSelectShipBuff(iter_27_1, true)
			end

			local var_27_9 = iter_27_1:Find("buff/bg/levelup(Clone)")

			IsNil = var_27_7

			if var_27_7(var_27_9) then
				PoolMgr = var_13

				local var_27_10 = var_13.GetInstance()

				var_13.GetUI(var_27_10, "levelup", true, function(arg_28_0)
					IsNil = var_2_10001

					if var_2_10001(arg_27_0._tf) then
						PoolMgr = var_1

						local var_28_0 = var_1.GetInstance()

						var_1.ReturnUI(var_28_0, "levelup", arg_28_0)
					else
						setParent = var_1

						local var_28_1 = arg_28_0
						local var_28_2 = iter_27_1

						var_1(var_28_1, var_4.Find(var_28_2, "buff/bg"))

						setActive = var_1

						var_1(arg_28_0, false)

						setActive = var_1

						var_1(arg_28_0, true)
					end

					return
				end)
			else
				setActive = var_13

				var_13(var_27_9, false)

				setActive = var_13

				var_13(var_27_9, true)
			end
		end
	end

	arg_27_0._preSelectedList = nil

	return
end

function var_0_1.updateSelectShipHP(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	setActive = var_1_10004

	var_1_10004(arg_29_1:Find("selected"), arg_29_2)

	local var_29_0 = arg_29_1
	local var_29_1 = arg_29_1.Find(var_29_0, "hp/progress_bg/bar_preview")

	setActive = var_1_10005

	var_1_10005(var_29_1, arg_29_2)

	local var_29_2 = arg_29_1:Find("hp/hp_text")

	setActive = var_29_0

	var_29_0(var_29_2, arg_29_2)

	if arg_29_2 then
		WPool = var_29_0

		local var_29_3 = var_29_0
		local var_29_4 = var_29_0.Get

		WorldMapShip = var_9

		local var_29_5 = var_29_4(var_29_3, var_9)

		var_29_5.id = arg_29_3.id
		var_29_5.hpRant = arg_29_3.hpRant
		var_29_5.buffs = arg_29_3.buffs

		local var_29_6 = arg_29_0.itemVO
		local var_29_7 = var_7.getWorldItemType(var_29_6)

		WorldItem = var_29_3

		local var_29_9

		if var_29_7 == var_29_3.UsageHPRegenerate then
			local var_29_8 = var_29_5

			var_29_9 = var_29_5.Regenerate

			local var_29_10 = arg_29_0.itemVO

			var_29_9(var_29_8, var_11.getItemRegenerate(var_29_10))
		else
			WorldItem = var_29_9

			if var_29_7 == var_29_9.UsageHPRegenerateValue then
				local var_29_11 = var_29_5

				var_29_9 = var_29_5.RegenerateValue

				local var_29_12 = arg_29_0.itemVO

				var_29_9(var_29_11, var_11.getItemRegenerate(var_29_12))
			else
				assert = var_29_9

				var_29_9(false, "world item type error:" .. arg_29_0.itemVO.id)
			end
		end

		setImageColor = var_29_9

		local var_29_13 = var_29_1
		local var_29_14 = var_29_5

		if var_29_5.IsHpSafe(var_29_14) then
			Color = var_29_15

			local var_29_15

			if not var_29_15.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882, 0.6) then
				Color = var_29_15
				var_29_15 = var_29_15.New(0.9254901960784314, 0, 0, 0.6)
			end

			var_29_9(var_29_13, var_29_15)

			local var_29_16 = var_29_1
			local var_29_17 = var_29_1.GetComponent

			typeof = var_29_15
			Image = var_29_14

			local var_29_18 = var_29_17(var_29_16, var_29_15(var_29_14))

			var_29_18.fillAmount = var_29_5.hpRant / 16
			setText = var_29_18

			local var_29_19 = var_29_2

			math = var_11

			local var_29_20 = var_11.floor(arg_29_3.hpRant / 100)
			local var_29_21 = "%"

			setColorStr = var_13

			local var_29_22 = "->"

			math = var_1_10016

			local var_29_23 = var_29_22 .. var_1_10016.floor(var_29_5.hpRant / 100) .. "%"

			COLOR_GREEN = var_16

			var_29_18(var_29_19, var_29_20 .. var_29_21 .. var_13(var_29_23, var_16))

			WPool = var_29_18

			var_29_18:Return(var_29_5)

			return
		end
	end
end

function var_0_1.updateSelectShipBuff(arg_30_0, arg_30_1, arg_30_2)
	setActive = var_1_10003

	var_1_10003(arg_30_1:Find("selected"), arg_30_2)

	return
end

function var_0_1.initHP(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1
	local var_31_1 = arg_31_1.Find(var_31_0, "buff")
	local var_31_2 = arg_31_1
	local var_31_3 = arg_31_1.Find(var_31_2, "hp")

	setActive = var_31_0

	var_31_0(var_31_3, true)

	setActive = var_31_0

	var_31_0(var_31_1, false)
	arg_31_0:updateSelectShipHP(arg_31_1, false)

	local var_31_4 = var_31_3:Find("progress_bg/bar")

	setImageColor = var_31_2

	local var_31_5 = var_31_4
	local var_31_6 = arg_31_2

	if arg_31_2.IsHpSafe(var_31_6) then
		Color = var_31_7

		local var_31_7

		if not var_31_7.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882) then
			Color = var_31_7
			var_31_7 = var_31_7.New(0.9254901960784314, 0, 0)
		end

		var_31_2(var_31_5, var_31_7)

		local var_31_8 = var_31_4
		local var_31_9 = var_31_4.GetComponent

		typeof = var_31_7
		Image = var_31_6

		local var_31_10 = var_31_9(var_31_8, var_31_7(var_31_6))

		var_31_10.fillAmount = arg_31_2.hpRant / 16
		setActive = var_31_10

		var_31_10(var_31_3:Find("broken"), arg_31_2:IsBroken())

		onButton = var_31_10

		var_31_10(arg_31_0, arg_31_1, function()
			table = var_2_10000

			if var_2_10000.contains(arg_31_0._selectedShipList, arg_31_2) then
				if #arg_31_0._selectedShipList <= 0 then
					return
				end

				local var_32_0 = arg_31_0

				var_1.updateSelectShipHP(var_32_0, arg_31_1, false)

				ipairs = var_1

				for iter_32_0, iter_32_1 in var_1(arg_31_0._selectedShipList) do
					if iter_32_1 == arg_31_2 then
						table = var_6

						var_6.remove(arg_31_0._selectedShipList, iter_32_0)

						break
					end
				end
			else
				while #arg_31_0._selectedShipList >= arg_31_0.quota do
					local var_32_1 = arg_31_0._shipTFList[arg_31_0._selectedShipList[1].id]
					local var_32_2 = arg_31_0

					var_2.updateSelectShipHP(var_32_2, var_32_1, false)

					table = var_2

					var_2.remove(arg_31_0._selectedShipList, 1)
				end

				local var_32_3 = arg_31_0

				var_1.updateSelectShipHP(var_32_3, arg_31_1, true, arg_31_2)

				table = var_1

				var_1.insert(arg_31_0._selectedShipList, arg_31_2)
			end

			local var_32_4 = arg_31_0

			var_1.updateQuota(var_32_4)

			return
		end)

		return not arg_31_2:IsHpFull()
	end
end

function var_0_1.initBuff(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1:Find("hp")
	local var_33_1 = arg_33_1:Find("buff")
	local var_33_2 = var_4.Find(var_33_1, "icon")
	local var_33_3 = var_4
	local var_33_4 = var_4.Find(var_33_3, "value")

	setActive = var_33_1

	var_33_1(var_33_0, false)

	setActive = var_33_1

	var_33_1(var_4, true)
	arg_33_0:updateSelectShipBuff(arg_33_1, false)

	local var_33_5 = arg_33_0.itemVO
	local var_33_6 = var_7.getItemBuffID(var_33_5)

	WorldBuff = var_33_3

	local var_33_7 = var_33_3.GetTemplate(var_33_6).buff_attr[1]

	GetImageSpriteFromAtlasAsync = var_10

	var_10("attricon", var_33_7, var_33_2)

	local var_33_8 = arg_33_2:GetBuff(var_33_6)
	local var_33_9 = var_10.GetFloor(var_33_8)
	local var_33_10 = arg_33_2:IsBuffMax(var_33_6)
	local var_33_11 = arg_33_0._shipVOList[arg_33_2.id]
	local var_33_12 = var_12.getBaseProperties(var_33_11)[var_33_7]
	local var_33_13 = 0 < var_33_12

	setText = var_13

	var_13(var_33_4, not var_33_13 and "Lv.-" or var_33_10 and "Lv.MAX" or "Lv." .. var_33_9)

	onButton = var_13

	var_13(arg_33_0, arg_33_1, function()
		table = var_2_10000

		if var_2_10000.contains(arg_33_0._selectedShipList, arg_33_2) then
			if #arg_33_0._selectedShipList <= 0 then
				return
			end

			ipairs = var_1

			for iter_34_0, iter_34_1 in var_1(arg_33_0._selectedShipList) do
				if iter_34_1 == arg_33_2 then
					table = var_6

					var_6.remove(arg_33_0._selectedShipList, iter_34_0)

					break
				end
			end

			local var_34_0 = arg_33_0

			var_1.updateSelectShipBuff(var_34_0, arg_33_1, false)
		else
			if #arg_33_0._selectedShipList >= arg_33_0.quota then
				return
			end

			local var_34_1 = arg_33_0

			var_1.updateSelectShipBuff(var_34_1, arg_33_1, true)

			table = var_1

			var_1.insert(arg_33_0._selectedShipList, arg_33_2)
		end

		local var_34_2 = arg_33_0

		var_1.updateQuota(var_34_2)

		return
	end)

	return var_33_13 and not var_33_10
end

function var_0_1.willExit(arg_35_0)
	setParent = var_1_10001

	var_1_10001(arg_35_0.shipTpl, arg_35_0.fleetInfo, false)

	setParent = var_1_10001

	var_1_10001(arg_35_0.emptyTpl, arg_35_0.fleetInfo, false)

	pg = var_1_10001

	local var_35_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_35_0, arg_35_0._tf)

	return
end

return var_0_1
