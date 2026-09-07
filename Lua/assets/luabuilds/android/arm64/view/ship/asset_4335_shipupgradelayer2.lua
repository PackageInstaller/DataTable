local ShipUpgradeLayer2 = class("ShipUpgradeLayer2", import("..base.BaseUI"))
local var_0_1 = 3

function ShipUpgradeLayer2:getUIName()
	return "ShipBreakOutUI"
end

function ShipUpgradeLayer2:getGroupName()
	return "ShipMainScene"
end

function ShipUpgradeLayer2:setItems(arg_3_1)
	self.items = arg_3_1

	return
end

function ShipUpgradeLayer2:setPlayer(arg_4_1)
	self.player = arg_4_1

	return
end

function ShipUpgradeLayer2:init()
	self.leftPanel = self._tf:Find("blur_panel/left_panel")
	self.stages = self.leftPanel:Find("stageScrollRect/stages")

	setText(self.leftPanel:Find("bg/title/Image"), i18n("word_preview"))

	self.stagesSnap = self.leftPanel:Find("stageScrollRect"):GetComponent("HorizontalScrollSnap")
	self.breakView = self.leftPanel:Find("content/Text")
	self.rightPanel = self._tf:Find("blur_panel/right_panel")
	self.attrs = self.rightPanel:Find("top/attrs")
	self.starTpl = self.rightPanel:Find("top/rare/startpl")

	setActive(self.starTpl, false)

	self.starsFrom = self.rightPanel:Find("top/rare/stars_from")
	self.starsTo = self.rightPanel:Find("top/rare/stars_to")
	self.starOpera = self.rightPanel:Find("top/rare/opera")
	self.materials = self.rightPanel:Find("bottom/materials")
	self.breakOutBtn = self.rightPanel:Find("bottom/break_btn/tip_active/image")
	self.appendStarTips = self.rightPanel:Find("bottom/panel_title/tip")
	self.tipActive = self.rightPanel:Find("bottom/break_btn/tip_active")
	self.tipDeactive = self.rightPanel:Find("bottom/break_btn/tip_deactive")

	setText(self.rightPanel:Find("bottom/panel_title/tip"), i18n("breakout_tip"))
	setText(self.rightPanel:Find("bottom/break_btn/tip_deactive/values/ok"), i18n("text_confirm"))
	setText(self.rightPanel:Find("bottom/break_btn/tip_active/image/ok"), i18n("text_confirm"))

	self.recommandBtn = self.rightPanel:Find("bottom/auto_btn")
	self.isEnoughItems = true
	self.sea = self.leftPanel:Find("sea")
	self.rawImage = self.sea:GetComponent("RawImage")

	setActive(self.rawImage, false)

	self.healTF = self._tf:Find("resources/heal")
	self.healTF.transform.localPosition = Vector3(-360, 50, 40)

	setActive(self.healTF, false)

	self.qCharaContain = self.rightPanel:Find("top/panel_bg/q_chara")
	self.seaLoading = self.leftPanel:Find("bg/loading")

	self:playLoadingAni()

	self.destroyConfirmWindow = ShipDestoryConfirmWindow.New(self._tf, self.event)

	return
end

function ShipUpgradeLayer2:loadChar()
	if not self.shipPrefab then
		local var_6_0 = self.shipVO:getPrefab()

		pg.UIMgr.GetInstance():LoadingOn()

		local var_6_1 = SpineAnimChar.New()

		var_6_1:SetPaint(var_6_0)
		var_6_1:Load(true, function(arg_7_0)
			pg.UIMgr.GetInstance():LoadingOff()

			self.shipPrefab = var_6_0
			self.shipModel = arg_7_0

			arg_7_0:SetLocalScale(Vector3(0.8, 0.8, 1))
			arg_7_0:SetParent(self.qCharaContain)
			arg_7_0:SetAction("stand", 0)

			return
		end)
	end

	return
end

function ShipUpgradeLayer2:recycleSpineChar()
	if self.shipPrefab and self.shipModel then
		self.shipModel:Dispose()

		self.shipPrefab = nil
		self.shipModel = nil
	end

	return
end

function ShipUpgradeLayer2:enabledToggles(arg_9_1)
	eachChild(self.toggles, function(arg_10_0)
		arg_10_0:GetComponent("Toggle").enabled = arg_9_1

		return
	end)

	return
end

function ShipUpgradeLayer2:addDragListenter()
	local var_11_0 = GetOrAddComponent(self._tf, "EventTriggerListener")

	self.dragTrigger = var_11_0

	local var_11_1
	local var_11_2 = 0

	var_11_0:AddBeginDragFunc(function()
		var_11_1 = nil
		var_11_2 = 0

		return
	end)
	var_11_0:AddDragFunc(function(arg_13_0, arg_13_1)
		var_11_1 = var_11_1 or arg_13_1.position
		var_11_2 = arg_13_1.position.x - var_11_1.x

		return
	end)
	var_11_0:AddDragEndFunc(function(arg_14_0, arg_14_1)
		if var_11_2 < -50 then
			self:emit(ShipUpgradeMediator2.NEXTSHIP, -1)
		elseif var_11_2 > 50 then
			self:emit(ShipUpgradeMediator2.NEXTSHIP)
		end

		return
	end)

	return
end

function ShipUpgradeLayer2:didEnter()
	self:BlurPanel(self._tf, {
		groupDelta = -1
	})
	self:addDragListenter()
	onButton(self, self.seaLoading, function()
		if not self.previewer then
			self:showBarrage()
		end

		return
	end)
	onButton(self, self.breakOutBtn, function()
		local var_17_0 = {}

		if self.shipVO:isActivityNpc() then
			table.insert(var_17_0, function(arg_18_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("npc_breakout_tip"),
					onYes = arg_18_0
				})

				return
			end)
		end

		seriesAsync(var_17_0, function()
			local var_19_0, var_19_1 = ShipStatus.ShipStatusCheck("onModify", self.shipVO)

			if not var_19_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_19_1)

				return
			end

			if self.breakCfg.breakout_id == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_upgradeStar_maxLevel"))

				return
			end

			if self.shipVO.level < self.breakCfg.level then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_upgradeStar_error_lvLimit"))

				return
			end

			if not self.isEnoughItems then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_upgradeStar_error_noEnoughMatrail"))

				return
			end

			if self.player.gold < self.breakCfg.use_gold then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
					{
						59001,
						self.breakCfg.use_gold - self.player.gold,
						self.breakCfg.use_gold
					}
				})

				return
			end

			if not self.contextData.materialShipIds or #self.contextData.materialShipIds < self.breakCfg.use_char_num then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_upgradeStar_select_material_tip"))

				return
			end

			self:emit(ShipUpgradeMediator2.UPGRADE_SHIP, self.contextData.materialShipIds)

			return
		end)

		return
	end, SFX_CONFIRM)
	onButton(self, self.recommandBtn, function()
		local var_20_0 = getProxy(BayProxy)

		if self.contextData.materialShipIds and #self.contextData.materialShipIds == self.breakCfg.use_char_num then
			return
		end

		local var_20_1 = var_20_0:getUpgradeRecommendShip(self.shipVO, self.contextData.materialShipIds or {}, self.breakCfg.use_char_num)

		if #var_20_1 > 0 then
			local var_20_2 = {}

			table.insert(var_20_2, function(arg_21_0)
				local var_21_0, var_21_1 = ShipCalcHelper.GetEliteAndHightLevelShips(underscore.map(var_20_1, function(arg_22_0)
					return var_20_0:getShipById(arg_22_0)
				end))

				if #var_21_0 > 0 or #var_21_1 > 0 then
					self.destroyConfirmWindow:ExecuteAction("Show", var_21_0, var_21_1, false, arg_21_0)
				else
					arg_21_0()
				end

				return
			end)
			seriesAsync(var_20_2, function()
				self.contextData.materialShipIds = var_20_1

				self:updateBreakOutView(self.shipVO)

				return
			end)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("without_selected_ship"))
		end

		return
	end, SFX_CONFIRM)
	self:initMaterialShips()

	return
end

function ShipUpgradeLayer2:getMaterialShip(arg_24_1)
	local var_24_0

	for iter_24_0 = #arg_24_1, 1, -1 do
		if not arg_24_1[iter_24_0]:isTestShip() then
			var_24_0 = iter_24_0

			break
		end
	end

	var_24_0 = var_24_0 or #arg_24_1

	return var_24_0
end

function ShipUpgradeLayer2:setShip(arg_25_1)
	self.shipVO = arg_25_1
	self.shipTempCfg = pg.ship_data_template
	self.shipBreakOutCfg = pg.ship_data_breakout
	self.breakIds = self:getStages()
	self.itemTFs = {}

	for iter_25_0 = 1, 3 do
		self.itemTFs[iter_25_0] = self.materials:Find("item_" .. iter_25_0)
	end

	self:updateBattleView()
	self:updateBreakOutView(self.shipVO)

	local var_25_0 = self.shipVO.level < self.breakCfg.level or self.breakCfg.breakout_id == 0

	setActive(self.tipActive, not (self.shipVO.level < self.breakCfg.level or self.breakCfg.breakout_id == 0))
	setActive(self.tipDeactive, var_25_0)
	setButtonEnabled(self.breakOutBtn, not var_25_0)
	setActive(self.recommandBtn, self.breakCfg.breakout_id ~= 0)
	self:loadChar()

	return
end

function ShipUpgradeLayer2:getStages()
	local var_26_0 = {}
	local var_26_1 = math.floor(self.shipVO.configId / 10)

	for iter_26_0 = 1, 4 do
		local var_26_2 = tonumber(var_26_1 .. iter_26_0)

		assert(self.shipBreakOutCfg[var_26_2], "必须存在配置" .. var_26_2)
		table.insert(var_26_0, var_26_2)
	end

	return var_26_0
end

function ShipUpgradeLayer2:updateStagesScrollView()
	local var_27_0 = table.indexof(self.breakIds, self.shipVO.configId)

	if var_27_0 and var_27_0 >= 1 and var_27_0 <= var_0_1 then
		self.stages:Find("stage" .. var_27_0):GetComponent(typeof(Toggle)).isOn = true
	end

	return
end

function ShipUpgradeLayer2:updateBattleView()
	if #self.breakIds < var_0_1 then
		return
	end

	for iter_28_0 = 1, var_0_1 do
		local var_28_0 = self.breakIds[iter_28_0]
		local var_28_1 = self.shipBreakOutCfg[self.breakIds[iter_28_0]]

		assert(self.shipBreakOutCfg[self.breakIds[iter_28_0]], "不存在配置" .. self.breakIds[iter_28_0])
		onToggle(self, self.stages:Find("stage" .. iter_28_0), function(arg_29_0)
			if arg_29_0 then
				local var_29_0 = var_28_1.breakout_view

				for iter_29_0, iter_29_1 in ipairs(checkExist(pg.ship_data_template[var_28_1.breakout_id], {
					"specific_type"
				}) or {}) do
					var_29_0 = var_29_0 .. "/" .. i18n(ShipType.SpecificTableTips[iter_29_1])
				end

				changeToScrollText(self.breakView, var_29_0)
				self:switchStage(var_28_0)
			end

			return
		end, SFX_PANEL)
	end

	self.stages:Find("stage1"):GetComponent(typeof(Toggle)).group:SetAllTogglesOff()

	local var_28_2 = math.clamp(table.indexof(self.breakIds, self.shipVO.configId), 1, var_0_1)

	if var_28_2 and var_28_2 >= 1 and var_28_2 <= var_0_1 then
		triggerToggle(self.stages:Find("stage" .. var_28_2), true)
	end

	return
end

local var_0_2 = {
	"durability",
	"cannon",
	"torpedo",
	"antiaircraft",
	"air",
	"antisub"
}

function ShipUpgradeLayer2:showBarrage()
	self.previewer = WeaponPreviewer.New(self.rawImage)

	self.previewer:configUI(self.healTF)
	self.previewer:setDisplayWeapon(self:getWaponIdsById(self.breakOutId))
	self.previewer:load(40000, self.shipVO, self:getAllWeaponIds(), function()
		self:stopLoadingAni()

		return
	end)

	return
end

function ShipUpgradeLayer2:getWaponIdsById(arg_32_1)
	return self.shipBreakOutCfg[arg_32_1].weapon_ids
end

function ShipUpgradeLayer2:switchStage(arg_33_1)
	if self.breakOutId == arg_33_1 then
		return
	end

	self.breakOutId = arg_33_1

	if self.previewer then
		self.previewer:setDisplayWeapon(self:getWaponIdsById(self.breakOutId))
	end

	return
end

function ShipUpgradeLayer2:getAllWeaponIds()
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in ipairs(self.breakIds) do
		local var_34_1 = Clone(self.shipBreakOutCfg[iter_34_1].weapon_ids)

		setmetatable(var_34_0, {
			__add = function(arg_35_0, arg_35_1)
				for iter_35_0, iter_35_1 in ipairs(arg_35_0) do
					if not table.contains(arg_35_1, iter_35_1) then
						table.insert(arg_35_1, iter_35_1)
					end
				end

				return arg_35_1
			end
		})

		var_34_0 = var_34_0 + var_34_1
	end

	return var_34_0
end

function ShipUpgradeLayer2:updateBreakOutView(arg_36_1)
	self.breakCfg = self.shipBreakOutCfg[arg_36_1.configId]

	for iter_36_0, iter_36_1 in ipairs(self.itemTFs) do
		setActive(iter_36_1, false)
	end

	local var_36_0 = arg_36_1:getShipProperties()
	local var_36_1 = Clone(arg_36_1)

	var_36_1.configId = self.breakCfg.breakout_id

	local var_36_2 = {}
	local var_36_3 = self.breakCfg.breakout_id == 0
	local var_36_4 = arg_36_1:getBattleTotalExpend()
	local var_36_5
	local var_36_6
	local var_36_7 = self.tipDeactive:Find("values/label")
	local var_36_8 = self.tipDeactive:Find("values/value")

	setText(var_36_7, "")
	setText(var_36_8, "")

	if var_36_3 then
		var_36_2 = var_36_0
		var_36_5 = var_36_4

		setText(var_36_7, i18n("word_level_upperLimit"))
	else
		var_36_6 = self.shipTempCfg[self.breakCfg.breakout_id].max_level
		var_36_2 = var_36_1:getShipProperties()
		var_36_2.level = self.shipTempCfg[self.breakCfg.breakout_id].max_level >= arg_36_1:getMaxLevel() and var_36_6 or arg_36_1:getMaxLevel()
		var_36_5 = var_36_1:getBattleTotalExpend()

		setColorCount(var_36_8, self.shipVO.level, self.breakCfg.level)
		setText(var_36_7, i18n("word_level_require"))
	end

	local function var_36_9(arg_37_0, arg_37_1)
		setText(arg_37_0:Find("name"), arg_37_1.name)
		setText(arg_37_0:Find("value"), arg_37_1.preAttr)

		local var_37_0 = arg_37_0:Find("value1")
		local var_37_1 = arg_37_0:Find("addition")

		setText(var_37_0, arg_37_1.afterAttr == 0 and setColorStr(arg_37_1.afterAttr, "#FFFFFFFF") or setColorStr(arg_37_1.afterAttr, COLOR_GREEN))
		setActive(var_37_1, arg_37_1.afterAttr - arg_37_1.preAttr ~= 0)
		setText(var_37_1, "(+" .. arg_37_1.afterAttr - arg_37_1.preAttr .. ")")

		return
	end

	local var_36_10 = 0

	if var_36_6 and var_36_6 ~= self.shipTempCfg[arg_36_1.configId].max_level then
		var_36_9(self.attrs:Find("attr_1"), {
			preAttr = self.shipTempCfg[arg_36_1.configId].max_level,
			afterAttr = var_36_6,
			name = i18n("word_level_upperLimit")
		})

		var_36_10 = 1
	end

	for iter_36_2 = 1, #var_0_2 do
		local var_36_11 = self.attrs:Find("attr_" .. var_36_10 + iter_36_2)

		setActive(var_36_11, true)
		var_36_9(var_36_11, {
			preAttr = math.floor(var_36_0[var_0_2[iter_36_2]]),
			afterAttr = math.floor(var_36_2[var_0_2[iter_36_2]]),
			name = i18n("word_attr_" .. var_0_2[iter_36_2])
		})
	end

	local var_36_12 = self.attrs:Find("attr_" .. var_36_10 + #var_0_2 + 1)

	setActive(var_36_12, true)
	var_36_9(var_36_12, {
		preAttr = var_36_4,
		afterAttr = var_36_5,
		name = i18n("word_attr_luck")
	})

	for iter_36_3 = var_36_10 + #var_0_2 + 1 + 1, 8 do
		setActive(self.attrs:Find("attr_" .. iter_36_3), false)
	end

	removeAllChildren(self.starsFrom)

	for iter_36_4 = 1, arg_36_1:getStar() do
		cloneTplTo(self.starTpl, self.starsFrom)
	end

	if var_36_3 then
		return
	end

	removeAllChildren(self.starsTo)

	if var_36_1:getStar() > arg_36_1:getStar() and not var_36_3 then
		for iter_36_5 = 1, var_36_1:getStar() do
			cloneTplTo(self.starTpl, self.starsTo)
		end
	end

	setActive(self.appendStarTips, var_36_1:getStar() ~= arg_36_1:getStar())
	setActive(self.starOpera, var_36_1:getStar() ~= arg_36_1:getStar())

	local var_36_13 = self.breakCfg.use_gold

	if self.breakCfg.use_gold > self.player.gold then
		var_36_13 = "<color=#FB4A2C>" .. var_36_13 .. "</color>"
	end

	setText(self.tipActive:Find("text"), var_36_13)
	self:initMaterialShips()

	return
end

function ShipUpgradeLayer2:initMaterialShips()
	local var_38_0 = self.breakCfg.use_char_num
	local var_38_1 = getProxy(BayProxy)

	for iter_38_0 = 1, 3 do
		SetActive(self.itemTFs[iter_38_0], iter_38_0 <= var_38_0)

		local var_38_2 = self.itemTFs[iter_38_0]:Find("IconTpl")

		if iter_38_0 <= var_38_0 and self.contextData.materialShipIds and self.contextData.materialShipIds[iter_38_0] then
			updateShip(var_38_2, var_38_1:getShipById(self.contextData.materialShipIds[iter_38_0]), {
				initStar = true
			})
			SetActive(var_38_2, true)
		else
			SetActive(var_38_2, false)
		end

		onButton(self, self.itemTFs[iter_38_0], function()
			self:emit(ShipUpgradeMediator2.ON_SELECT_SHIP, self.shipVO, var_38_0)

			return
		end)
	end

	return
end

function ShipUpgradeLayer2:willExit()
	self:UnOverlayPanel(self._tf)
	self:recycleSpineChar()

	if self.previewer then
		self.previewer:clear()

		self.previewer = nil
	end

	if self.dragTrigger then
		ClearEventTrigger(self.dragTrigger)

		self.dragTrigger = nil
	end

	self.destroyConfirmWindow:Destroy()

	return
end

function ShipUpgradeLayer2:playLoadingAni()
	setActive(self.seaLoading, true)

	return
end

function ShipUpgradeLayer2:stopLoadingAni()
	setActive(self.seaLoading, false)

	return
end

function ShipUpgradeLayer2:onBackPressed()
	if self.destroyConfirmWindow:isShowing() then
		self.destroyConfirmWindow:ActionInvoke("Hide")

		return
	end

	self:emit(BaseUI.ON_BACK_PRESSED, true)

	return
end

return ShipUpgradeLayer2
