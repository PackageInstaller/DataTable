local var_0_0 = class("WorldAllocateLayer", import("..base.BaseUI"))

var_0_0.TeamNum = {
	"FIRST",
	"SECOND",
	"THIRD",
	"FOURTH",
	"FIFTH",
	"SIXTH"
}

function var_0_0.getUIName(arg_1_0)
	return "WorldAllocateUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0._selectedShipList = {}
	arg_2_0._shipTFList = {}
	arg_2_0._shipVOList = {}
	arg_2_0.cancelBtn = arg_2_0._tf:Find("actions/cancel_button")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("actions/compose_button")
	arg_2_0.itemTF = arg_2_0._tf:Find("item")
	arg_2_0.nameTF = arg_2_0._tf:Find("item/name_container/name")
	arg_2_0.descTF = arg_2_0._tf:Find("item/desc")
	arg_2_0.fleetInfo = arg_2_0._tf:Find("fleet_info")

	setText(arg_2_0.fleetInfo:Find("top/Text"), i18n("world_ship_repair"))

	arg_2_0.shipTpl = arg_2_0:getTpl("fleet_info/shiptpl")
	arg_2_0.emptyTpl = arg_2_0:getTpl("fleet_info/emptytpl")
	arg_2_0.shipsContainer = arg_2_0._tf:Find("fleet_info/contain")
	arg_2_0.descLabel = arg_2_0._tf:Find("fleet_info/top/Text")

	setText(arg_2_0.fleetInfo:Find("tip/Text"), i18n("world_battle_damage"))

	arg_2_0.countLabel = arg_2_0._tf:Find("count")
	arg_2_0.quotaTxt = arg_2_0._tf:Find("count/value")
	arg_2_0.btnFleet = arg_2_0._tf:Find("fleets/selected")
	arg_2_0.fleetToggleMask = arg_2_0._tf:Find("fleets/list_mask")
	arg_2_0.fleetToggleList = arg_2_0.fleetToggleMask:Find("list")

	onButton(arg_2_0, arg_2_0.cancelBtn, function()
		arg_2_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.confirmBtn, function()
		if arg_2_0.itemVO.count == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

			return
		end

		local function var_4_0()
			arg_2_0._preSelectedList = {}

			for iter_5_0, iter_5_1 in ipairs(arg_2_0._selectedShipList) do
				({})[#{} + 1] = iter_5_1.id
				arg_2_0._preSelectedList[iter_5_1.id] = true
			end

			arg_2_0.confirmCallback(arg_2_0.itemVO.configId, {})

			return
		end

		if #arg_2_0._selectedShipList > 0 then
			local var_4_1 = false
			local var_4_2 = arg_2_0.itemVO:getWorldItemType()

			if var_4_2 == WorldItem.UsageBuff then
				local var_4_3 = arg_2_0.itemVO:getItemBuffID()

				var_4_1 = _.any(arg_2_0._selectedShipList, function(arg_6_0)
					return arg_6_0:IsBuffMax()
				end)
			elseif var_4_2 == WorldItem.UsageHPRegenerate or var_4_2 == WorldItem.UsageHPRegenerateValue then
				var_4_1 = _.any(arg_2_0._selectedShipList, function(arg_7_0)
					return arg_7_0:IsHpFull()
				end)
			end

			if var_4_1 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("world_ship_healthy"),
					onYes = var_4_0
				})
			else
				var_4_0()
			end
		end

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.fleetToggleMask, function()
		arg_2_0:showOrHideToggleMask(false)

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.btnFleet, function()
		arg_2_0:showOrHideToggleMask(true)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf:Find("item/reset_btn"), function()
		assert(arg_2_0.contextData.onResetInfo, "without reset info callback")
		arg_2_0.contextData.onResetInfo(Drop.New({
			count = 1,
			type = DROP_TYPE_WORLD_ITEM,
			id = arg_2_0.itemVO.id
		}))

		return
	end)

	return
end

function var_0_0.didEnter(arg_11_0)
	local var_11_0 = arg_11_0.contextData.fleetIndex or 1

	arg_11_0:updateToggleList(arg_11_0.fleetList, var_11_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_11_0._tf)

	return
end

function var_0_0.showOrHideToggleMask(arg_12_0, arg_12_1)
	setActive(arg_12_0.fleetToggleMask, arg_12_1)
	arg_12_0:tweenTabArrow(not arg_12_1)

	return
end

function var_0_0.setFleets(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.fleetList = arg_13_1

	return
end

function var_0_0.setConfirmCallback(arg_14_0, arg_14_1)
	arg_14_0.confirmCallback = arg_14_1

	return
end

function var_0_0.setItem(arg_15_0, arg_15_1)
	arg_15_0.itemVO = arg_15_1

	updateDrop(arg_15_0.itemTF, Drop.New({
		type = DROP_TYPE_WORLD_ITEM,
		id = arg_15_1.id,
		count = arg_15_1.count
	}))
	setText(arg_15_0.nameTF, arg_15_1:getConfig("name"))
	setText(arg_15_0.descTF, arg_15_1:getConfig("display"))

	arg_15_0.quota = arg_15_0.itemVO:getItemQuota()

	arg_15_0:updateQuota()

	return
end

function var_0_0.updateQuota(arg_16_0)
	setText(arg_16_0.quotaTxt, #arg_16_0._selectedShipList .. "/" .. arg_16_0.quota)
	setActive(arg_16_0.countLabel, true)

	return
end

function var_0_0.flush(arg_17_0, arg_17_1)
	if arg_17_1.id ~= arg_17_0.itemVO.id then
		return
	end

	arg_17_0:setItem(arg_17_0.itemVO)

	local var_17_0 = arg_17_0.itemVO:getWorldItemType()

	if var_17_0 == WorldItem.UsageBuff then
		arg_17_0:OnUpdateShipBuff()
	elseif var_17_0 == WorldItem.UsageHPRegenerate or var_17_0 == WorldItem.UsageHPRegenerateValue then
		arg_17_0:OnUpdateShipHP()
	end

	return
end

function var_0_0.updateToggleList(arg_18_0, arg_18_1, arg_18_2)
	setActive(arg_18_0.fleetToggleList, true)

	local var_18_0

	for iter_18_0 = 1, arg_18_0.fleetToggleList.childCount do
		local var_18_1 = arg_18_0.fleetToggleList:GetChild(arg_18_0.fleetToggleList.childCount - iter_18_0)

		setActive(var_18_1, arg_18_1[iter_18_0])

		if arg_18_1[iter_18_0] then
			setActive(var_18_1:Find("lock"), false)
			setText(var_18_1:Find("on/mask/text"), i18n("world_fleetName" .. iter_18_0))
			setText(var_18_1:Find("on/mask/en"), var_0_0.TeamNum[iter_18_0] .. " FLEET")
			setText(var_18_1:Find("on/mask/number"), iter_18_0)
			setText(var_18_1:Find("off/mask/text"), i18n("world_fleetName" .. iter_18_0))
			setText(var_18_1:Find("off/mask/en"), var_0_0.TeamNum[iter_18_0] .. " FLEET")
			setText(var_18_1:Find("off/mask/number"), iter_18_0)
			onToggle(arg_18_0, var_18_1, function(arg_19_0)
				if arg_19_0 then
					arg_18_0:showOrHideToggleMask(false)
					arg_18_0:setFleet(arg_18_1[iter_18_0].id)
					arg_18_0:updateQuota()
				end

				return
			end, SFX_UI_TAG)

			if arg_18_1[iter_18_0].id == arg_18_2 then
				var_18_0 = var_18_1
			end
		end
	end

	if var_18_0 then
		triggerToggle(var_18_0, true)
	end

	return
end

function var_0_0.updateFleetButton(arg_20_0, arg_20_1)
	setText(arg_20_0.btnFleet:Find("fleet/CnFleet"), i18n("world_fleetName" .. arg_20_1))
	setText(arg_20_0.btnFleet:Find("fleet/enFleet"), var_0_0.TeamNum[arg_20_1] .. " FLEET")
	setText(arg_20_0.btnFleet:Find("fleet/num"), arg_20_1)

	return
end

function var_0_0.tweenTabArrow(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.btnFleet:Find("arr")

	setActive(var_21_0, arg_21_1)

	if arg_21_1 then
		LeanTween.moveLocalY(go(var_21_0), var_21_0.localPosition.y + 8, 0.8):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(-1)
	else
		LeanTween.cancel(go(var_21_0))

		var_21_0.localPosition.y = 80
		var_21_0.localPosition = var_21_0.localPosition
	end

	return
end

function var_0_0.setFleet(arg_22_0, arg_22_1)
	arg_22_0:updateFleetButton(arg_22_1)

	local var_22_0 = arg_22_0.itemVO:getWorldItemType()

	for iter_22_0, iter_22_1 in pairs(arg_22_0._shipTFList) do
		local var_22_1 = iter_22_1:Find("buff/bg/levelup(Clone)")

		if not IsNil(var_22_1) then
			PoolMgr.GetInstance():ReturnUI("levelup", var_22_1)
		end
	end

	removeAllChildren(arg_22_0.shipsContainer)

	arg_22_0.currentFleetIndex = arg_22_1
	arg_22_0._selectedShipList = {}
	arg_22_0._shipTFList = {}

	local var_22_2 = arg_22_0.fleetList[arg_22_0.currentFleetIndex]:GetShips(true)
	local var_22_3 = underscore.map(var_22_2, function(arg_23_0)
		return WorldConst.FetchShipVO(arg_23_0.id)
	end)
	local var_22_4 = arg_22_0.quota

	for iter_22_2 = 1, 6 do
		if var_22_2[iter_22_2] then
			local var_22_5 = cloneTplTo(arg_22_0.shipTpl, arg_22_0.shipsContainer)

			arg_22_0._shipTFList[var_22_2[iter_22_2].id] = var_22_5
			arg_22_0._shipVOList[var_22_3[iter_22_2].id] = var_22_3[iter_22_2]

			updateShip(var_22_5, var_22_3[iter_22_2], {
				initStar = true
			})

			local var_22_6 = false

			if var_22_0 == WorldItem.UsageBuff then
				var_22_6 = arg_22_0:initBuff(var_22_5, var_22_2[iter_22_2])
			elseif var_22_0 == WorldItem.UsageHPRegenerate or var_22_0 == WorldItem.UsageHPRegenerateValue then
				var_22_6 = arg_22_0:initHP(var_22_5, var_22_2[iter_22_2])
			end

			if var_22_4 > 0 and var_22_6 then
				triggerButton(var_22_5)

				var_22_4 = var_22_4 - 1
			end
		else
			local var_22_7 = cloneTplTo(arg_22_0.emptyTpl, arg_22_0.shipsContainer)
		end
	end

	setActive(arg_22_0.fleetInfo:Find("tip"), underscore.any(var_22_2, function(arg_24_0)
		return arg_24_0:IsBroken()
	end))

	return
end

function var_0_0.OnUpdateShipHP(arg_25_0)
	local var_25_0 = arg_25_0.itemVO:getItemBuffID()

	for iter_25_0, iter_25_1 in pairs(arg_25_0._shipTFList) do
		if arg_25_0._preSelectedList[iter_25_0] then
			local var_25_1 = arg_25_0.fleetList[arg_25_0.currentFleetIndex]:GetShip(iter_25_0)
			local var_25_2 = iter_25_1:Find("hp")
			local var_25_3 = var_25_2:Find("progress_bg/bar")
			local var_25_4 = var_25_1:IsHpSafe() and Color.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882) or Color.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882)

			setImageColor(var_25_3, var_25_4)

			local var_25_5 = var_25_3:GetComponent(typeof(Image)).fillAmount

			if var_25_5 < var_25_1.hpRant / 16 then
				LeanTween.value(go(var_25_3), var_25_5, var_25_1.hpRant / 16, var_25_1.hpRant / 16 - var_25_5):setOnUpdate(System.Action_float(function(arg_26_0)
					var_25_3:GetComponent(typeof(Image)).fillAmount = arg_26_0

					return
				end))
			end

			setActive(var_25_2:Find("broken"), var_25_1:IsBroken())

			if var_25_1:IsHpFull() then
				triggerButton(iter_25_1)
			else
				arg_25_0:updateSelectShipHP(iter_25_1, true, var_25_1)
			end
		end
	end

	arg_25_0._preSelectedList = nil

	return
end

function var_0_0.OnUpdateShipBuff(arg_27_0)
	local var_27_0 = arg_27_0.itemVO:getItemBuffID()

	for iter_27_0, iter_27_1 in pairs(arg_27_0._shipTFList) do
		if arg_27_0._preSelectedList[iter_27_0] then
			local var_27_1 = arg_27_0.fleetList[arg_27_0.currentFleetIndex]:GetShip(iter_27_0)
			local var_27_2 = var_27_1:GetBuff(var_27_0):GetFloor()
			local var_27_3 = var_27_1:IsBuffMax(var_27_0)

			setText(iter_27_1:Find("buff/value"), var_27_3 and "Lv.MAX" or "Lv." .. var_27_2)

			if var_27_3 then
				triggerButton(iter_27_1)
			else
				arg_27_0:updateSelectShipBuff(iter_27_1, true)
			end

			local var_27_4 = iter_27_1:Find("buff/bg/levelup(Clone)")

			if IsNil(var_27_4) then
				PoolMgr.GetInstance():GetUI("levelup", true, function(arg_28_0)
					if IsNil(arg_27_0._tf) then
						PoolMgr.GetInstance():ReturnUI("levelup", arg_28_0)
					else
						setParent(arg_28_0, iter_27_1:Find("buff/bg"))
						setActive(arg_28_0, false)
						setActive(arg_28_0, true)
					end

					return
				end)
			else
				setActive(var_27_4, false)
				setActive(var_27_4, true)
			end
		end
	end

	arg_27_0._preSelectedList = nil

	return
end

function var_0_0.updateSelectShipHP(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	setActive(arg_29_1:Find("selected"), arg_29_2)

	local var_29_0 = arg_29_1:Find("hp/progress_bg/bar_preview")

	setActive(var_29_0, arg_29_2)

	local var_29_1 = arg_29_1:Find("hp/hp_text")

	setActive(var_29_1, arg_29_2)

	if arg_29_2 then
		local var_29_2 = WPool:Get(WorldMapShip)

		var_29_2.id = arg_29_3.id
		var_29_2.hpRant = arg_29_3.hpRant
		var_29_2.buffs = arg_29_3.buffs

		local var_29_3 = arg_29_0.itemVO:getWorldItemType()
		local var_29_4

		if var_29_3 == WorldItem.UsageHPRegenerate then
			var_29_2:Regenerate(arg_29_0.itemVO:getItemRegenerate())
		elseif var_29_3 == WorldItem.UsageHPRegenerateValue then
			var_29_2:RegenerateValue(arg_29_0.itemVO:getItemRegenerate())
		else
			assert(false, "world item type error:" .. arg_29_0.itemVO.id)

			var_29_4 = var_29_2:IsHpSafe() and Color.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882, 0.6) or Color.New(0.9254901960784314, 0, 0, 0.6)
		end

		setImageColor(var_29_0, var_29_4)

		var_29_0:GetComponent(typeof(Image)).fillAmount = var_29_2.hpRant / 16

		setText(var_29_1, math.floor(arg_29_3.hpRant / 100) .. "%" .. setColorStr("->" .. math.floor(var_29_2.hpRant / 100) .. "%", COLOR_GREEN))
		WPool:Return(var_29_2)
	end

	return
end

function var_0_0.updateSelectShipBuff(arg_30_0, arg_30_1, arg_30_2)
	setActive(arg_30_1:Find("selected"), arg_30_2)

	return
end

function var_0_0.initHP(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1:Find("hp")

	setActive(var_31_0, true)
	setActive(arg_31_1:Find("buff"), false)
	arg_31_0:updateSelectShipHP(arg_31_1, false)

	local var_31_1 = var_31_0:Find("progress_bg/bar")
	local var_31_2 = arg_31_2:IsHpSafe() and Color.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882) or Color.New(0.9254901960784314, 0, 0)

	setImageColor(var_31_1, var_31_2)

	var_31_1:GetComponent(typeof(Image)).fillAmount = arg_31_2.hpRant / 16

	setActive(var_31_0:Find("broken"), arg_31_2:IsBroken())
	onButton(arg_31_0, arg_31_1, function()
		if table.contains(arg_31_0._selectedShipList, arg_31_2) then
			if #arg_31_0._selectedShipList <= 0 then
				return
			end

			arg_31_0:updateSelectShipHP(arg_31_1, false)

			for iter_32_0, iter_32_1 in ipairs(arg_31_0._selectedShipList) do
				if iter_32_1 == arg_31_2 then
					table.remove(arg_31_0._selectedShipList, iter_32_0)

					break
				end
			end
		else
			while #arg_31_0._selectedShipList >= arg_31_0.quota do
				arg_31_0:updateSelectShipHP(arg_31_0._shipTFList[arg_31_0._selectedShipList[1].id], false)
				table.remove(arg_31_0._selectedShipList, 1)
			end

			arg_31_0:updateSelectShipHP(arg_31_1, true, arg_31_2)
			table.insert(arg_31_0._selectedShipList, arg_31_2)
		end

		arg_31_0:updateQuota()

		return
	end)

	return not arg_31_2:IsHpFull()
end

function var_0_0.initBuff(arg_33_0, arg_33_1, arg_33_2)
	local var_33_9000
	local var_33_0 = arg_33_1:Find("buff")
	local var_33_1 = var_33_0:Find("value")

	setActive(arg_33_1:Find("hp"), false)
	setActive(var_33_0, true)
	arg_33_0:updateSelectShipBuff(arg_33_1, false)

	local var_33_2 = arg_33_0.itemVO:getItemBuffID()
	local var_33_3 = WorldBuff.GetTemplate(var_33_2).buff_attr[1]

	GetImageSpriteFromAtlasAsync("attricon", var_33_3, (var_33_0:Find("icon")))

	local var_33_4 = arg_33_2:GetBuff(var_33_2)
	local var_33_5 = var_33_4.GetFloor(var_33_9000)
	local var_33_6 = arg_33_2:IsBuffMax(var_33_2)
	local var_33_7 = arg_33_0._shipVOList[arg_33_2.id]:getBaseProperties()[var_33_3] > 0

	setText(var_33_1, not var_33_4 and "Lv.-" or var_33_6 and "Lv.MAX" or "Lv." .. var_33_5)
	onButton(arg_33_0, arg_33_1, function()
		if table.contains(arg_33_0._selectedShipList, arg_33_2) then
			if #arg_33_0._selectedShipList <= 0 then
				return
			end

			for iter_34_0, iter_34_1 in ipairs(arg_33_0._selectedShipList) do
				if iter_34_1 == arg_33_2 then
					table.remove(arg_33_0._selectedShipList, iter_34_0)

					break
				end
			end

			arg_33_0:updateSelectShipBuff(arg_33_1, false)
		else
			if #arg_33_0._selectedShipList >= arg_33_0.quota then
				return
			end

			arg_33_0:updateSelectShipBuff(arg_33_1, true)
			table.insert(arg_33_0._selectedShipList, arg_33_2)
		end

		arg_33_0:updateQuota()

		return
	end)

	return var_33_7 and not var_33_6
end

function var_0_0.willExit(arg_35_0)
	setParent(arg_35_0.shipTpl, arg_35_0.fleetInfo, false)
	setParent(arg_35_0.emptyTpl, arg_35_0.fleetInfo, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_35_0._tf)

	return
end

return var_0_0
