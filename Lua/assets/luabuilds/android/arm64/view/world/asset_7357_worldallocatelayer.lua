local WorldAllocateLayer = class("WorldAllocateLayer", import("..base.BaseUI"))

WorldAllocateLayer.TeamNum = {
	"FIRST",
	"SECOND",
	"THIRD",
	"FOURTH",
	"FIFTH",
	"SIXTH"
}

function WorldAllocateLayer:getUIName()
	return "WorldAllocateUI"
end

function WorldAllocateLayer:init()
	self._selectedShipList = {}
	self._shipTFList = {}
	self._shipVOList = {}
	self.cancelBtn = self._tf:Find("actions/cancel_button")
	self.confirmBtn = self._tf:Find("actions/compose_button")
	self.itemTF = self._tf:Find("item")
	self.nameTF = self._tf:Find("item/name_container/name")
	self.descTF = self._tf:Find("item/desc")
	self.fleetInfo = self._tf:Find("fleet_info")

	setText(self.fleetInfo:Find("top/Text"), i18n("world_ship_repair"))

	self.shipTpl = self:getTpl("fleet_info/shiptpl")
	self.emptyTpl = self:getTpl("fleet_info/emptytpl")
	self.shipsContainer = self._tf:Find("fleet_info/contain")
	self.descLabel = self._tf:Find("fleet_info/top/Text")

	setText(self.fleetInfo:Find("tip/Text"), i18n("world_battle_damage"))

	self.countLabel = self._tf:Find("count")
	self.quotaTxt = self._tf:Find("count/value")
	self.btnFleet = self._tf:Find("fleets/selected")
	self.fleetToggleMask = self._tf:Find("fleets/list_mask")
	self.fleetToggleList = self.fleetToggleMask:Find("list")

	onButton(self, self.cancelBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if self.itemVO.count == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

			return
		end

		local function var_4_0()
			local var_5_0 = {}

			self._preSelectedList = {}

			for iter_5_0, iter_5_1 in ipairs(self._selectedShipList) do
				var_5_0[#var_5_0 + 1] = iter_5_1.id
				self._preSelectedList[iter_5_1.id] = true
			end

			self.confirmCallback(self.itemVO.configId, var_5_0)

			return
		end

		if #self._selectedShipList > 0 then
			local var_4_1 = false
			local var_4_2 = self.itemVO:getWorldItemType()

			if var_4_2 == WorldItem.UsageBuff then
				local var_4_3 = self.itemVO:getItemBuffID()

				var_4_1 = _.any(self._selectedShipList, function(arg_6_0)
					return arg_6_0:IsBuffMax()
				end)
			elseif var_4_2 == WorldItem.UsageHPRegenerate or var_4_2 == WorldItem.UsageHPRegenerateValue then
				var_4_1 = _.any(self._selectedShipList, function(arg_7_0)
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
	onButton(self, self.fleetToggleMask, function()
		self:showOrHideToggleMask(false)

		return
	end, SFX_CANCEL)
	onButton(self, self.btnFleet, function()
		self:showOrHideToggleMask(true)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("item/reset_btn"), function()
		assert(self.contextData.onResetInfo, "without reset info callback")
		self.contextData.onResetInfo(Drop.New({
			count = 1,
			type = DROP_TYPE_WORLD_ITEM,
			id = self.itemVO.id
		}))

		return
	end)

	return
end

function WorldAllocateLayer:didEnter()
	self:updateToggleList(self.fleetList, self.contextData.fleetIndex or 1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function WorldAllocateLayer:showOrHideToggleMask(arg_12_1)
	setActive(self.fleetToggleMask, arg_12_1)
	self:tweenTabArrow(not arg_12_1)

	return
end

function WorldAllocateLayer:setFleets(arg_13_1, arg_13_2)
	self.fleetList = arg_13_1

	return
end

function WorldAllocateLayer:setConfirmCallback(arg_14_1)
	self.confirmCallback = arg_14_1

	return
end

function WorldAllocateLayer:setItem(arg_15_1)
	self.itemVO = arg_15_1

	updateDrop(self.itemTF, Drop.New({
		type = DROP_TYPE_WORLD_ITEM,
		id = arg_15_1.id,
		count = arg_15_1.count
	}))
	setText(self.nameTF, arg_15_1:getConfig("name"))
	setText(self.descTF, arg_15_1:getConfig("display"))

	self.quota = self.itemVO:getItemQuota()

	self:updateQuota()

	return
end

function WorldAllocateLayer:updateQuota()
	setText(self.quotaTxt, #self._selectedShipList .. "/" .. self.quota)
	setActive(self.countLabel, true)

	return
end

function WorldAllocateLayer:flush(arg_17_1)
	if arg_17_1.id ~= self.itemVO.id then
		return
	end

	self:setItem(self.itemVO)

	local var_17_0 = self.itemVO:getWorldItemType()

	if var_17_0 == WorldItem.UsageBuff then
		self:OnUpdateShipBuff()
	elseif var_17_0 == WorldItem.UsageHPRegenerate or var_17_0 == WorldItem.UsageHPRegenerateValue then
		self:OnUpdateShipHP()
	end

	return
end

function WorldAllocateLayer:updateToggleList(arg_18_1, arg_18_2)
	setActive(self.fleetToggleList, true)

	local var_18_0

	for iter_18_0 = 1, self.fleetToggleList.childCount do
		local var_18_1 = self.fleetToggleList:GetChild(self.fleetToggleList.childCount - iter_18_0)

		setActive(var_18_1, arg_18_1[iter_18_0])

		if arg_18_1[iter_18_0] then
			setActive(var_18_1:Find("lock"), false)
			setText(var_18_1:Find("on/mask/text"), i18n("world_fleetName" .. iter_18_0))
			setText(var_18_1:Find("on/mask/en"), WorldAllocateLayer.TeamNum[iter_18_0] .. " FLEET")
			setText(var_18_1:Find("on/mask/number"), iter_18_0)
			setText(var_18_1:Find("off/mask/text"), i18n("world_fleetName" .. iter_18_0))
			setText(var_18_1:Find("off/mask/en"), WorldAllocateLayer.TeamNum[iter_18_0] .. " FLEET")
			setText(var_18_1:Find("off/mask/number"), iter_18_0)
			onToggle(self, var_18_1, function(arg_19_0)
				if arg_19_0 then
					self:showOrHideToggleMask(false)
					self:setFleet(arg_18_1[iter_18_0].id)
					self:updateQuota()
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

function WorldAllocateLayer:updateFleetButton(arg_20_1)
	setText(self.btnFleet:Find("fleet/CnFleet"), i18n("world_fleetName" .. arg_20_1))
	setText(self.btnFleet:Find("fleet/enFleet"), WorldAllocateLayer.TeamNum[arg_20_1] .. " FLEET")
	setText(self.btnFleet:Find("fleet/num"), arg_20_1)

	return
end

function WorldAllocateLayer:tweenTabArrow(arg_21_1)
	local var_21_0 = self.btnFleet:Find("arr")

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

function WorldAllocateLayer:setFleet(arg_22_1)
	self:updateFleetButton(arg_22_1)

	local var_22_0 = self.itemVO:getWorldItemType()

	for iter_22_0, iter_22_1 in pairs(self._shipTFList) do
		local var_22_1 = iter_22_1:Find("buff/bg/levelup(Clone)")

		if not IsNil(var_22_1) then
			PoolMgr.GetInstance():ReturnUI("levelup", var_22_1)
		end
	end

	removeAllChildren(self.shipsContainer)

	self.currentFleetIndex = arg_22_1
	self._selectedShipList = {}
	self._shipTFList = {}

	local var_22_2 = self.fleetList[self.currentFleetIndex]:GetShips(true)
	local var_22_3 = underscore.map(var_22_2, function(arg_23_0)
		return WorldConst.FetchShipVO(arg_23_0.id)
	end)
	local var_22_4 = self.quota

	for iter_22_2 = 1, 6 do
		if var_22_2[iter_22_2] then
			local var_22_5 = cloneTplTo(self.shipTpl, self.shipsContainer)

			self._shipTFList[var_22_2[iter_22_2].id] = var_22_5
			self._shipVOList[var_22_3[iter_22_2].id] = var_22_3[iter_22_2]

			updateShip(var_22_5, var_22_3[iter_22_2], {
				initStar = true
			})

			local var_22_6 = false

			if var_22_0 == WorldItem.UsageBuff then
				var_22_6 = self:initBuff(var_22_5, var_22_2[iter_22_2])
			elseif var_22_0 == WorldItem.UsageHPRegenerate or var_22_0 == WorldItem.UsageHPRegenerateValue then
				var_22_6 = self:initHP(var_22_5, var_22_2[iter_22_2])
			end

			if var_22_4 > 0 and var_22_6 then
				triggerButton(var_22_5)

				var_22_4 = var_22_4 - 1
			end
		else
			local var_22_7 = cloneTplTo(self.emptyTpl, self.shipsContainer)
		end
	end

	setActive(self.fleetInfo:Find("tip"), underscore.any(var_22_2, function(arg_24_0)
		return arg_24_0:IsBroken()
	end))

	return
end

function WorldAllocateLayer:OnUpdateShipHP()
	local var_25_0 = self.itemVO:getItemBuffID()

	for iter_25_0, iter_25_1 in pairs(self._shipTFList) do
		if self._preSelectedList[iter_25_0] then
			local var_25_1 = self.fleetList[self.currentFleetIndex]:GetShip(iter_25_0)
			local var_25_2 = iter_25_1:Find("hp")
			local var_25_3 = var_25_2:Find("progress_bg/bar")

			setImageColor(var_25_3, var_25_1:IsHpSafe() and Color.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882) or Color.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882))

			local var_25_4 = var_25_3:GetComponent(typeof(Image)).fillAmount

			if var_25_4 < var_25_1.hpRant / 16 then
				LeanTween.value(go(var_25_3), var_25_4, var_25_1.hpRant / 16, var_25_1.hpRant / 16 - var_25_4):setOnUpdate(System.Action_float(function(arg_26_0)
					var_25_3:GetComponent(typeof(Image)).fillAmount = arg_26_0

					return
				end))
			end

			setActive(var_25_2:Find("broken"), var_25_1:IsBroken())

			if var_25_1:IsHpFull() then
				triggerButton(iter_25_1)
			else
				self:updateSelectShipHP(iter_25_1, true, var_25_1)
			end
		end
	end

	self._preSelectedList = nil

	return
end

function WorldAllocateLayer:OnUpdateShipBuff()
	local var_27_0 = self.itemVO:getItemBuffID()

	for iter_27_0, iter_27_1 in pairs(self._shipTFList) do
		if self._preSelectedList[iter_27_0] then
			local var_27_1 = self.fleetList[self.currentFleetIndex]:GetShip(iter_27_0)
			local var_27_2 = var_27_1:GetBuff(var_27_0):GetFloor()
			local var_27_3 = var_27_1:IsBuffMax(var_27_0)

			setText(iter_27_1:Find("buff/value"), var_27_3 and "Lv.MAX" or "Lv." .. var_27_2)

			if var_27_3 then
				triggerButton(iter_27_1)
			else
				self:updateSelectShipBuff(iter_27_1, true)
			end

			local var_27_4 = iter_27_1:Find("buff/bg/levelup(Clone)")

			if IsNil(var_27_4) then
				PoolMgr.GetInstance():GetUI("levelup", true, function(arg_28_0)
					if IsNil(self._tf) then
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

	self._preSelectedList = nil

	return
end

function WorldAllocateLayer:updateSelectShipHP(arg_29_1, arg_29_2, arg_29_3)
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

		local var_29_3 = self.itemVO:getWorldItemType()

		if var_29_3 == WorldItem.UsageHPRegenerate then
			var_29_2:Regenerate(self.itemVO:getItemRegenerate())
		else
			if var_29_3 == WorldItem.UsageHPRegenerateValue then
				var_29_2:RegenerateValue(self.itemVO:getItemRegenerate())
			end

			local var_29_4

			do
				assert(false, "world item type error:" .. self.itemVO.id)

				var_29_4 = var_29_2:IsHpSafe() and Color.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882, 0.6) or Color.New(0.9254901960784314, 0, 0, 0.6)
			end
		end

		setImageColor(var_29_0, var_29_4)

		var_29_0:GetComponent(typeof(Image)).fillAmount = var_29_2.hpRant / 16

		setText(var_29_1, math.floor(arg_29_3.hpRant / 100) .. "%" .. setColorStr("->" .. math.floor(var_29_2.hpRant / 100) .. "%", COLOR_GREEN))
		WPool:Return(var_29_2)
	end

	return
end

function WorldAllocateLayer:updateSelectShipBuff(arg_30_1, arg_30_2)
	setActive(arg_30_1:Find("selected"), arg_30_2)

	return
end

function WorldAllocateLayer:initHP(arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1:Find("hp")

	setActive(var_31_0, true)
	setActive(arg_31_1:Find("buff"), false)
	self:updateSelectShipHP(arg_31_1, false)

	local var_31_1 = var_31_0:Find("progress_bg/bar")

	setImageColor(var_31_1, arg_31_2:IsHpSafe() and Color.New(0.615686274509804, 0.9176470588235294, 0.23529411764705882) or Color.New(0.9254901960784314, 0, 0))

	var_31_1:GetComponent(typeof(Image)).fillAmount = arg_31_2.hpRant / 16

	setActive(var_31_0:Find("broken"), arg_31_2:IsBroken())
	onButton(self, arg_31_1, function()
		if table.contains(self._selectedShipList, arg_31_2) then
			if #self._selectedShipList <= 0 then
				return
			end

			self:updateSelectShipHP(arg_31_1, false)

			for iter_32_0, iter_32_1 in ipairs(self._selectedShipList) do
				if iter_32_1 == arg_31_2 then
					table.remove(self._selectedShipList, iter_32_0)

					break
				end
			end
		else
			while #self._selectedShipList >= self.quota do
				self:updateSelectShipHP(self._shipTFList[self._selectedShipList[1].id], false)
				table.remove(self._selectedShipList, 1)
			end

			self:updateSelectShipHP(arg_31_1, true, arg_31_2)
			table.insert(self._selectedShipList, arg_31_2)
		end

		self:updateQuota()

		return
	end)

	return not arg_31_2:IsHpFull()
end

function WorldAllocateLayer:initBuff(arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1:Find("buff")
	local var_33_1 = var_33_0:Find("value")

	setActive(arg_33_1:Find("hp"), false)
	setActive(var_33_0, true)
	self:updateSelectShipBuff(arg_33_1, false)

	local var_33_2 = self.itemVO:getItemBuffID()
	local var_33_3 = WorldBuff.GetTemplate(var_33_2).buff_attr[1]

	GetImageSpriteFromAtlasAsync("attricon", var_33_3, (var_33_0:Find("icon")))

	local var_33_4 = arg_33_2:GetBuff(var_33_2)
	local var_33_5 = var_33_4:GetFloor()
	local var_33_6 = arg_33_2:IsBuffMax(var_33_2)
	local var_33_7 = self._shipVOList[arg_33_2.id]:getBaseProperties()[var_33_3] > 0

	setText(var_33_1, not var_33_4 and "Lv.-" or var_33_6 and "Lv.MAX" or "Lv." .. var_33_5)
	onButton(self, arg_33_1, function()
		if table.contains(self._selectedShipList, arg_33_2) then
			if #self._selectedShipList <= 0 then
				return
			end

			for iter_34_0, iter_34_1 in ipairs(self._selectedShipList) do
				if iter_34_1 == arg_33_2 then
					table.remove(self._selectedShipList, iter_34_0)

					break
				end
			end

			self:updateSelectShipBuff(arg_33_1, false)
		else
			if #self._selectedShipList >= self.quota then
				return
			end

			self:updateSelectShipBuff(arg_33_1, true)
			table.insert(self._selectedShipList, arg_33_2)
		end

		self:updateQuota()

		return
	end)

	return var_33_7 and not var_33_6
end

function WorldAllocateLayer:willExit()
	setParent(self.shipTpl, self.fleetInfo, false)
	setParent(self.emptyTpl, self.fleetInfo, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return WorldAllocateLayer
