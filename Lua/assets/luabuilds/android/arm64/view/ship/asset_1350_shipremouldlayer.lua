local ShipRemouldLayer = class("ShipRemouldLayer", import("..base.BaseUI"))
local var_0_1 = 5
local var_0_2 = 6
local var_0_3 = 1
local var_0_4 = 9
local var_0_5 = 55
local var_0_6 = Vector2(-5, 25)

function ShipRemouldLayer:getUIName()
	return "ShipRemouldUI"
end

function ShipRemouldLayer:getGroupName()
	return "ShipMainScene"
end

function ShipRemouldLayer:init()
	self.container = self._tf:Find("main/bg/container")
	self.gridContainer = self.container:Find("grids")
	self.gridTF = self.gridContainer:Find("grid_tpl")
	self.height = self.gridTF.sizeDelta.y + var_0_5
	self.width = self.gridTF.sizeDelta.x + var_0_4
	self.startPos = Vector2(-1 * ((var_0_2 / 2 - 0.5) * self.width) + var_0_6.x, (var_0_1 / 2 - 0.5) * self.height + var_0_6.y)
	self.containerWidth = var_0_2 * self.gridTF.sizeDelta.x + (var_0_2 - 1) * var_0_4
	self.containerHeight = var_0_1 * self.gridTF.sizeDelta.y + (var_0_1 - 1) * var_0_5
	self.container.sizeDelta = Vector2(self.containerWidth, self.containerHeight)

	setActive(self.gridTF, false)

	self.infoPanel = self._tf:Find("main/info_panel")
	self.itemContainer = self.infoPanel:Find("usages/items")
	self.itemTF = self.itemContainer:Find("itemTF")
	self.infoName = self.infoPanel:Find("name_container/Text"):GetComponent(typeof(Text))
	self.attrContainer = self.infoPanel:Find("align/attrs")
	self.attrTpl = self:getTpl("attr", self.attrContainer)
	self.attrTplD = self:getTpl("attrd", self.attrContainer)
	self.confirmBtn = self.infoPanel:Find("confirm_btn/activity")
	self.inactiveBtn = self.infoPanel:Find("confirm_btn/inactivity")
	self.completedteBtn = self.infoPanel:Find("confirm_btn/complete")
	self.shipTF = self._tf:Find("main/info_panel/usages/shipTF")
	self.skillDesc = self.infoPanel:Find("align/skill_desc/text")
	self.shipContainer = self.infoPanel:Find("char_container")
	self.lineTpl = self._tf:Find("resources/line")
	self.lineContainer = self.container:Find("grids/lines")
	self.helpBtn = GameObject.Find("/OverlayCamera/Overlay/UIMain/common/help_btn")

	if not IsNil(self.helpBtn) then
		setActive(self.helpBtn, false)
	end

	self.tooltip = self._tf:Find("tooltip")

	setActive(self.tooltip, false)

	return
end

function ShipRemouldLayer:setPlayer(arg_4_1)
	self.playerVO = arg_4_1

	if self.curtransformId then
		self:updateInfo(self.curtransformId)
	end

	return
end

function ShipRemouldLayer:setItems(arg_5_1)
	self.itemsVO = arg_5_1

	return
end

function ShipRemouldLayer:getItemCount(arg_6_1)
	return (self.itemsVO[arg_6_1] or Item.New({
		count = 0,
		id = arg_6_1
	})).count
end

function ShipRemouldLayer:setShipVO(arg_7_1)
	self.shipVO = arg_7_1
	self.shipGroupId = math.floor(self.shipVO:getGroupId())

	return
end

function ShipRemouldLayer:getShipTranformData()
	assert(pg.ship_data_trans[self.shipGroupId], "config missed [pg.ship_data_trans] shipGroup>>>." .. self.shipGroupId)

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(pg.ship_data_trans[self.shipGroupId].transform_list) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1) do
			var_8_0[iter_8_3[2]] = Vector2(iter_8_0, iter_8_3[1])
		end
	end

	return var_8_0
end

function ShipRemouldLayer:didEnter()
	self:initTranformInfo()
	self:initShipModel()

	return
end

function ShipRemouldLayer:initTranformInfo()
	self.transformIds = self:getShipTranformData()
	self.grids = {}

	for iter_10_0, iter_10_1 in pairs(self.transformIds) do
		local var_10_0 = cloneTplTo(self.gridTF, self.gridContainer)

		go(var_10_0).name = iter_10_0
		var_10_0.localPosition = Vector2(self.startPos.x + self.width * (iter_10_1.x - 1), self.startPos.y - self.height * (iter_10_1.y - 1))

		onToggle(self, var_10_0, function(arg_11_0)
			if arg_11_0 and self.curtransformId ~= iter_10_0 then
				self:updateInfo(iter_10_0)
			end

			return
		end, SFX_PANEL)

		self.grids[iter_10_0] = var_10_0
	end

	self.lineTFs = {}

	for iter_10_2, iter_10_3 in pairs(self.transformIds) do
		self:initLines(iter_10_2)
	end

	self.posTransId = {}

	self:updateLines()

	if self.contextData.transformId then
		assert(self.grids[self.contextData.transformId], "without this transform id:" .. self.contextData.transformId)
		triggerToggle(self.grids[self.contextData.transformId], true)
	end

	return
end

function ShipRemouldLayer:initLines(arg_12_1)
	local var_12_0 = 75

	self.lineTFs[arg_12_1] = {}

	local var_12_1 = self.transformIds[arg_12_1].y
	local var_12_2 = self.grids[arg_12_1].sizeDelta
	local var_12_3 = self.grids[arg_12_1].localPosition

	for iter_12_0, iter_12_1 in pairs(pg.transform_data_template[arg_12_1].condition_id) do
		local var_12_4 = self.transformIds[iter_12_1].y
		local var_12_5 = Vector2(self.transformIds[iter_12_1].x - self.transformIds[arg_12_1].x, self.transformIds[iter_12_1].y - var_12_1)

		if var_12_5 ~= Vector2.zero then
			local var_12_6 = cloneTplTo(self.lineTpl, self.lineContainer, self.transformIds[arg_12_1].x .. "-" .. var_12_1 .. "-v")
			local var_12_7 = cloneTplTo(self.lineTpl, self.lineContainer, self.transformIds[arg_12_1].x .. "-" .. var_12_1 .. "-h")
			local var_12_8 = var_12_5.y < 0 and 90 or -90

			var_12_6.eulerAngles = Vector3(0, 0, var_12_5.y < 0 and 90 or -90)
			var_12_7.eulerAngles = Vector3(0, 0, var_12_5.x < 0 and 180 or 0)

			local var_12_9 = math.abs(var_12_5.y) > 0 and math.abs(var_12_5.x) > 0

			if var_12_9 then
				var_12_7.localPosition = Vector2(var_12_3.x, var_12_3.y + (var_12_1 - var_12_4) * 270, 0)
				var_12_6.localPosition = Vector2(var_12_3.x, (var_12_5.y < 0 or nil) and (var_12_3.y + var_12_2.y / 2 or var_12_3.y - var_12_2.y / 2))
				var_12_7.sizeDelta = Vector2(math.abs(var_12_5.x) * 270, var_12_7.sizeDelta.y)
				var_12_6.sizeDelta = Vector2(math.abs(var_12_5.y) * 270 - var_12_2.y / 2, var_12_6.sizeDelta.y)
				var_12_6:Find("corner").localScale = Vector3(1, var_12_5.x < 0 and var_12_8 < 0 and -1 or 1, 1)
			else
				var_12_7.sizeDelta = Vector2(math.abs(var_12_5.x) * 270, var_12_7.sizeDelta.y)
				var_12_6.sizeDelta = Vector2(math.abs(var_12_5.y) * var_12_0, var_12_6.sizeDelta.y)
				var_12_7.localPosition = var_12_3
				var_12_6.localPosition = Vector3(var_12_3.x, (var_12_5.y < 0 or nil) and (var_12_3.y + var_12_2.y / 2 or var_12_3.y - var_12_2.y / 2), 0)
			end

			setActive(var_12_6:Find("arr"), var_12_9 or math.abs(var_12_5.y) > 0)
			setActive(var_12_6:Find("corner"), var_12_9)
			setActive(var_12_7:Find("arr"), false)
			setActive(var_12_7:Find("corner"), false)
			table.insert(self.lineTFs[arg_12_1], {
				id = iter_12_1,
				hrz = var_12_7,
				vec = var_12_6
			})
		end
	end

	return
end

function ShipRemouldLayer:updateLines()
	for iter_13_0, iter_13_1 in pairs(self.transformIds) do
		self:updateGridTF(iter_13_0)

		if self:canRemould(iter_13_0) or self:isFinished(iter_13_0) then
			for iter_13_2, iter_13_3 in ipairs((not self.lineTFs[iter_13_0] or nil) and {}) do
				iter_13_3.hrz:GetComponent("UIGrayScale").enabled = false
				iter_13_3.vec:GetComponent("UIGrayScale").enabled = false
			end
		end
	end

	return
end

function ShipRemouldLayer:getLevelById(arg_14_1)
	return pg.transform_data_template[arg_14_1].level_limit
end

function ShipRemouldLayer:getTransformLevel(arg_15_1)
	if not self.shipVO.transforms[arg_15_1] then
		return 0
	else
		return self.shipVO.transforms[arg_15_1].level
	end

	return
end

ShipRemouldLayer.STATE_FINISHED = 1
ShipRemouldLayer.STATE_ACTIVE = 2
ShipRemouldLayer.STATE_LOCK = 3

function ShipRemouldLayer:getTransformState(arg_16_1)
	if self:getTransformLevel(arg_16_1) == pg.transform_data_template[arg_16_1].max_level then
		return ShipRemouldLayer.STATE_FINISHED
	elseif self:canRemould(arg_16_1) then
		return ShipRemouldLayer.STATE_ACTIVE
	else
		return ShipRemouldLayer.STATE_LOCK
	end

	return
end

function ShipRemouldLayer:updateGridTF(arg_17_1)
	local var_17_0 = self.grids[arg_17_1]
	local var_17_1 = pg.transform_data_template[arg_17_1]

	setText(self.grids[arg_17_1]:Find("name"), pg.transform_data_template[arg_17_1].name)

	local var_17_2 = var_17_0:Find("icon"):GetComponent(typeof(Image))

	GetSpriteFromAtlasAsync("modicon", var_17_1.icon, function(arg_18_0)
		if not IsNil(var_17_2) then
			var_17_2.sprite = arg_18_0
		end

		return
	end)

	local var_17_3 = self:getTransformState(arg_17_1)

	setActive(var_17_0:Find("bgs/finished"), var_17_3 == ShipRemouldLayer.STATE_FINISHED)
	setActive(var_17_0:Find("bgs/ongoing"), var_17_3 == ShipRemouldLayer.STATE_ACTIVE)
	setActive(var_17_0:Find("bgs/lock"), var_17_3 == ShipRemouldLayer.STATE_LOCK)
	setActive(var_17_0:Find("tags/finished"), var_17_3 == ShipRemouldLayer.STATE_FINISHED)
	setActive(var_17_0:Find("tags/ongoing"), var_17_3 == ShipRemouldLayer.STATE_ACTIVE)
	setActive(var_17_0:Find("tags/lock"), var_17_3 == ShipRemouldLayer.STATE_LOCK)

	local var_17_4 = self:getTransformLevel(arg_17_1)
	local var_17_5 = var_17_0:Find("icon/progress")

	if var_17_3 == ShipRemouldLayer.STATE_FINISHED then
		setText(var_17_5, var_17_4 .. "/" .. var_17_1.max_level)
	elseif var_17_3 == ShipRemouldLayer.STATE_ACTIVE then
		setText(var_17_5, var_17_4 .. "/" .. var_17_1.max_level)
	elseif var_17_3 == ShipRemouldLayer.STATE_LOCK then
		local var_17_6, var_17_7, var_17_8 = self:canRemould(arg_17_1)

		setText(var_17_5, "")
		setActive(var_17_0:Find("tags/lock/lock_prev"), var_17_8 and var_17_8[1] == 1)
		setActive(var_17_0:Find("tags/lock/lock_level"), var_17_8 and var_17_8[1] == 2)
		setActive(var_17_0:Find("tags/lock/lock_star"), var_17_8 and var_17_8[1] == 3)

		if var_17_8 and var_17_8[1] == 2 then
			setText(var_17_0:Find("tags/lock/lock_level/Text"), var_17_8[2])
		elseif var_17_8 and var_17_8[1] == 3 then
			setText(var_17_0:Find("tags/lock/lock_star/Text"), var_17_8[2])
		end
	end

	local var_17_9 = self.transformIds[arg_17_1].x .. "_" .. self.transformIds[arg_17_1].y

	if not self.posTransId[self.transformIds[arg_17_1].x .. "_" .. self.transformIds[arg_17_1].y] then
		self.posTransId[var_17_9] = arg_17_1
	elseif self.posTransId[var_17_9] == arg_17_1 then
		-- block empty
	elseif var_17_3 == ShipRemouldLayer.STATE_ACTIVE or self:getTransformState(self.posTransId[var_17_9]) ~= ShipRemouldLayer.STATE_ACTIVE and arg_17_1 < self.posTransId[var_17_9] then
		if self.posTransId[var_17_9] == self.curtransformId then
			self.curtransformId = arg_17_1
		end

		setActive(self.grids[self.posTransId[var_17_9]], false)

		self.posTransId[var_17_9] = arg_17_1
	end

	setActive(var_17_0, arg_17_1 == self.posTransId[var_17_9])

	if self.curtransformId == arg_17_1 then
		self:updateInfo(arg_17_1)
	end

	return
end

function ShipRemouldLayer:initShipModel()
	if self.shipContainer.childCount ~= 0 then
		self.shipModel:Dispose()
	end

	local function var_19_0(arg_20_0)
		if not IsNil(self._tf) then
			self.shipModel = arg_20_0

			arg_20_0:SetLayer(Layer.UI)
			arg_20_0:SetLocalScale(Vector3(var_0_3, var_0_3, 1))
			arg_20_0:SetParent(self.shipContainer)
			arg_20_0:SetLocalPosition(Vector2(0, 10))
			arg_20_0:SetAction("stand2", 0)
		end

		return
	end

	local var_19_1 = SpineAnimChar.New()

	var_19_1:SetPaint((self.shipVO:getPrefab()))
	var_19_1:Load(true, function(arg_21_0)
		var_19_0(arg_21_0)

		return
	end)

	return
end

function ShipRemouldLayer:updateInfo(arg_22_1)
	if self:isFinished(arg_22_1) then
		self:updateFinished(arg_22_1)
	else
		self:updateProgress(arg_22_1)
	end

	return
end

function ShipRemouldLayer:updateFinished(arg_23_1)
	self.curtransformId = arg_23_1

	local var_23_0 = pg.transform_data_template[arg_23_1]

	self.infoName.text = pg.transform_data_template[arg_23_1].name

	local var_23_1 = {}

	for iter_23_0 = 1, self.shipVO.transforms[arg_23_1].level do
		_.each(var_23_0.use_item[iter_23_0], function(arg_24_0)
			local var_24_0 = _.detect(var_23_1, function(arg_25_0)
				return arg_25_0.type == DROP_TYPE_ITEM and arg_25_0.id == arg_24_0[1]
			end)

			if not var_24_0 then
				table.insert(var_23_1, {
					type = DROP_TYPE_ITEM,
					id = arg_24_0[1],
					count = arg_24_0[2]
				})
			else
				var_24_0.count = var_24_0.count + arg_24_0[2]
			end

			return
		end)
	end

	table.insert(var_23_1, {
		type = DROP_TYPE_ITEM,
		id = id2ItemId(PlayerConst.ResGold),
		count = var_23_0.use_gold * self.shipVO.transforms[arg_23_1].level
	})

	for iter_23_1 = self.itemContainer.childCount, #var_23_1 - 1 do
		cloneTplTo(self.itemTF, self.itemContainer)
	end

	for iter_23_2 = 1, self.itemContainer.childCount do
		local var_23_2 = self.itemContainer:GetChild(iter_23_2 - 1)

		setActive(var_23_2, iter_23_2 <= #var_23_1)

		if iter_23_2 <= #var_23_1 then
			updateDrop(var_23_2:Find("IconTpl"), var_23_1[iter_23_2])
			RemoveComponent(var_23_2, typeof(Button))
		end
	end

	setActive(self.shipTF, var_23_0.use_ship > 0)

	if var_23_0.use_ship > 0 then
		setActive(self.shipTF:Find("addTF"), false)
		setActive(self.shipTF:Find("IconTpl"), true)
		updateDrop(self.shipTF:Find("IconTpl"), {
			type = DROP_TYPE_SHIP,
			id = self.shipVO.configId
		})
		removeOnButton(self.shipTF)
	end

	setActive(self.skillDesc.parent, var_23_0.skill_id ~= 0)

	if var_23_0.skill_id ~= 0 then
		setText(self.skillDesc, i18n("ship_remould_material_unlock_skill", pg.skill_data_template[var_23_0.skill_id].name))
	end

	removeAllChildren(self.attrContainer)

	local var_23_3
	local var_23_4

	_.each(var_23_0.ship_id, function(arg_26_0)
		if arg_26_0[1] == self.shipVO.configId then
			var_23_3 = arg_26_0[2]
		end

		if pg.ship_data_template[arg_26_0[1]].group_type == self.shipVO.groupId then
			var_23_4 = pg.ship_data_statistics[arg_26_0[2]].type
		end

		return
	end)

	if nil then
		local var_23_5 = cloneTplTo(self.attrTplD, self.attrContainer)

		setText(var_23_5:Find("name"), i18n("common_ship_type"))
		setText(var_23_5:Find("value"), ShipType.Type2Name(nil))
		setActive(var_23_5:Find("quest"), true)
		onButton(self, var_23_5, function()
			self:showToolTip(arg_23_1)

			return
		end)
	else
		local var_23_6 = _.reduce(var_23_0.effect, {}, function(arg_28_0, arg_28_1)
			for iter_28_0, iter_28_1 in pairs(arg_28_1) do
				arg_28_0[iter_28_0] = (arg_28_0[iter_28_0] or 0) + iter_28_1
			end

			return arg_28_0
		end)

		for iter_23_3, iter_23_4 in pairs((self.shipVO:getShipProperties())) do
			if var_23_6[iter_23_3] then
				self:updateAttrTF_D(cloneTplTo(self.attrTplD, self.attrContainer), {
					attrName = AttributeType.Type2Name(iter_23_3),
					value = math.floor(iter_23_4),
					addition = var_23_6[iter_23_3]
				})
			end
		end

		for iter_23_5 = 1, 3 do
			if var_23_6["equipment_proficiency_" .. iter_23_5] then
				self:updateAttrTF_D(cloneTplTo(self.attrTplD, self.attrContainer), {
					attrName = EquipType.LabelToName((EquipType.Types2Title(iter_23_5, self.shipVO.configId))) .. i18n("common_proficiency"),
					value = self.shipVO:getEquipProficiencyByPos(iter_23_5) * 100,
					addition = var_23_6["equipment_proficiency_" .. iter_23_5] * 100
				}, true)
			end
		end
	end

	setActive(self.confirmBtn, false)
	setActive(self.inactiveBtn, false)
	setActive(self.completedteBtn, self:isFinished(arg_23_1))

	self.contextData.transformId = arg_23_1

	return
end

function ShipRemouldLayer:updateProgress(arg_29_1)
	local var_29_0 = self:getTransformLevel(arg_29_1) + 1

	self.curtransformId = arg_29_1

	local var_29_1 = pg.transform_data_template[arg_29_1]

	self.infoName.text = pg.transform_data_template[arg_29_1].name

	local var_29_2, var_29_3 = self:canRemould(arg_29_1)
	local var_29_4 = var_29_1.effect[var_29_0] or {}

	setActive(self.shipTF, false)
	setText(self.skillDesc, "")

	local var_29_5 = var_29_1.use_item[var_29_0] and Clone(var_29_1.use_item[var_29_0]) or {}

	if var_29_1.use_gold > 0 then
		table.insert(var_29_5, {
			id2ItemId(PlayerConst.ResGold),
			var_29_1.use_gold
		})
	end

	setActive(self.shipTF, var_29_1.use_ship ~= 0)

	if var_29_1.use_ship ~= 0 then
		local var_29_6 = self.contextData.materialShipIds and table.getCount(self.contextData.materialShipIds) ~= 0

		setActive(self.shipTF:Find("IconTpl"), var_29_6)
		setActive(self.shipTF:Find("addTF"), not var_29_6)

		if var_29_6 then
			local var_29_7 = {}

			var_29_7.id = getProxy(BayProxy):getShipById(self.contextData.materialShipIds[1]).configId
			var_29_7.type = DROP_TYPE_SHIP

			updateDrop(self.shipTF:Find("IconTpl"), var_29_7)
		end

		onButton(self, self.shipTF, function()
			if var_29_2 then
				self:emit(ShipRemouldMediator.ON_SELECTE_SHIP, self.shipVO)
			else
				pg.TipsMgr.GetInstance():ShowTips(var_29_3)
			end

			return
		end, SFX_PANEL)
	else
		self.contextData.materialShipIds = nil
	end

	setActive(self.skillDesc.parent, var_29_1.skill_id ~= 0)

	if var_29_1.skill_id ~= 0 then
		setText(self.skillDesc, i18n("ship_remould_material_unlock_skill", pg.skill_data_template[var_29_1.skill_id].name))
	end

	for iter_29_0 = self.itemContainer.childCount, #var_29_5 - 1 do
		cloneTplTo(self.itemTF, self.itemContainer)
	end

	for iter_29_1 = 1, self.itemContainer.childCount do
		local var_29_8 = self.itemContainer:GetChild(iter_29_1 - 1)

		setActive(var_29_8, iter_29_1 <= #var_29_5)

		if iter_29_1 <= #var_29_5 then
			local var_29_9 = var_29_5[iter_29_1]
			local var_29_10 = ""

			if var_29_5[iter_29_1][1] == id2ItemId(PlayerConst.ResGold) then
				local var_29_11 = self.playerVO.gold >= var_29_9[2]

				var_29_10 = setColorStr(var_29_9[2], (self.playerVO.gold >= var_29_9[2] or nil) and (COLOR_WHITE or COLOR_RED))

				if var_29_11 then
					RemoveComponent(var_29_8, typeof(Button))
				else
					onButton(self, var_29_8, function()
						ItemTipPanel.ShowGoldBuyTip(var_29_9[2])

						return
					end)

					var_29_8:GetComponent(typeof(Button)).targetGraphic = var_29_8:Find("IconTpl/icon_bg/icon"):GetComponent(typeof(Image))
				end
			else
				local var_29_12 = self:getItemCount(var_29_9[1]) >= var_29_9[2]

				var_29_10 = setColorStr(self:getItemCount(var_29_9[1]), (var_29_12 or nil) and (COLOR_WHITE or COLOR_RED))
				var_29_10 = var_29_10 .. "/" .. var_29_9[2]

				if var_29_12 or not ItemTipPanel.CanShowTip(var_29_9[1]) then
					RemoveComponent(var_29_8, typeof(Button))
				else
					onButton(self, var_29_8, function()
						ItemTipPanel.ShowItemTipbyID(var_29_9[1])

						return
					end)

					var_29_8:GetComponent(typeof(Button)).targetGraphic = var_29_8:Find("IconTpl/icon_bg/icon"):GetComponent(typeof(Image))
				end
			end

			updateDrop(var_29_8:Find("IconTpl"), {
				id = var_29_9[1],
				type = DROP_TYPE_ITEM,
				count = var_29_10
			})
		end
	end

	removeAllChildren(self.attrContainer)

	local var_29_14
	local var_29_15

	_.each(var_29_1.ship_id, function(arg_33_0)
		if arg_33_0[1] == self.shipVO.configId then
			var_29_14 = arg_33_0[2]
		end

		if pg.ship_data_template[arg_33_0[1]].group_type == self.shipVO.groupId then
			var_29_15 = pg.ship_data_statistics[arg_33_0[2]].type
		end

		return
	end)

	if nil then
		local var_29_16 = cloneTplTo(self.attrTpl, self.attrContainer)

		setText(var_29_16:Find("name"), i18n("common_ship_type"))
		setText(var_29_16:Find("pre_value"), ShipType.Type2Name(self.shipVO:getShipType()))
		setText(var_29_16:Find("value"), ShipType.Type2Name(nil))
		setActive(var_29_16:Find("addtion"), false)

		local var_29_17 = var_29_16:Find("quest")

		if nil then
			setActive(var_29_17, true)
			onButton(self, var_29_16, function()
				self:showToolTip(arg_29_1)

				return
			end)
		else
			setActive(var_29_17, false)
		end
	else
		for iter_29_2, iter_29_3 in pairs((self.shipVO:getShipProperties())) do
			if var_29_4[iter_29_2] then
				self:updateAttrTF(cloneTplTo(self.attrTpl, self.attrContainer), {
					attrName = AttributeType.Type2Name(iter_29_2),
					value = math.floor(iter_29_3),
					addition = var_29_4[iter_29_2]
				})
			end
		end

		for iter_29_4 = 1, 3 do
			if var_29_4["equipment_proficiency_" .. iter_29_4] then
				self:updateAttrTF(cloneTplTo(self.attrTpl, self.attrContainer), {
					attrName = EquipType.LabelToName((EquipType.Types2Title(iter_29_4, self.shipVO.configId))) .. i18n("common_proficiency"),
					value = self.shipVO:getEquipProficiencyByPos(iter_29_4) * 100,
					addition = var_29_4["equipment_proficiency_" .. iter_29_4] * 100
				}, true)
			end
		end
	end

	local var_29_19 = self:isEnoughResource(arg_29_1)

	setActive(self.confirmBtn, var_29_2 and var_29_19)
	setActive(self.inactiveBtn, not var_29_2 or not var_29_19)
	setActive(self.completedteBtn, false)
	onButton(self, self.confirmBtn, function()
		local var_35_0, var_35_1 = ShipStatus.ShipStatusCheck("onModify", self.shipVO)

		if not var_35_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_35_1)

			return
		end

		local var_35_2, var_35_3 = self:canRemould(arg_29_1)

		if not var_35_2 then
			pg.TipsMgr.GetInstance():ShowTips(var_35_3)

			return
		end

		local var_35_4, var_35_5 = self:isEnoughResource(arg_29_1)

		if not var_35_4 then
			pg.TipsMgr.GetInstance():ShowTips(var_35_5)

			return
		end

		if var_29_14 then
			local var_35_6 = pg.MsgboxMgr.GetInstance()

			var_35_6:ShowMsgBox({
				modal = true,
				content = i18n("ship_remould_warning_" .. var_29_14, self.shipVO:getName()),
				onYes = function()
					self:emit(ShipRemouldMediator.REMOULD_SHIP, self.shipVO.id, arg_29_1)

					return
				end
			})
			var_35_6.contentText:AddListener(function(arg_37_0, arg_37_1)
				if arg_37_0 == "clickDetail" then
					self:showToolTip(arg_29_1)
				end

				return
			end)
		else
			self:emit(ShipRemouldMediator.REMOULD_SHIP, self.shipVO.id, arg_29_1)
		end

		return
	end, SFX_CONFIRM)

	self.contextData.transformId = arg_29_1

	return
end

function ShipRemouldLayer:isUnlock(arg_38_1)
	if not self:isUnLockPrev(arg_38_1) then
		return false
	end

	if self:getLevelById(arg_38_1) > self.shipVO.level then
		return false
	end

	if not self:isReachStar(arg_38_1) then
		return false
	end

	return true
end

function ShipRemouldLayer:isFinished(arg_39_1)
	if pg.transform_data_template[arg_39_1].max_level == self:getTransformLevel(arg_39_1) then
		return true
	end

	return false
end

function ShipRemouldLayer:isReachStar(arg_40_1)
	return self.shipVO:getStar() >= pg.transform_data_template[arg_40_1].star_limit
end

function ShipRemouldLayer:canRemould(arg_41_1)
	if not self:isUnLockPrev(arg_41_1) then
		return false, i18n("ship_remould_prev_lock"), {
			1
		}
	end

	local var_41_0 = pg.transform_data_template[arg_41_1]

	if self:getLevelById(arg_41_1) > self.shipVO.level then
		return false, i18n("ship_remould_need_level", var_41_0.level_limit), {
			2,
			var_41_0.level_limit
		}
	end

	if not self:isReachStar(arg_41_1) then
		return false, i18n("ship_remould_need_star", var_41_0.star_limit), {
			3,
			var_41_0.star_limit
		}
	end

	if self:isFinished(arg_41_1) then
		return false, i18n("ship_remould_finished"), {
			4
		}
	end

	return true
end

function ShipRemouldLayer:isUnLockPrev(arg_42_1)
	for iter_42_0, iter_42_1 in pairs(pg.transform_data_template[arg_42_1].condition_id) do
		if not self.shipVO.transforms[iter_42_1] or self.shipVO.transforms[iter_42_1].level ~= pg.transform_data_template[iter_42_1].max_level then
			return false
		end
	end

	return true
end

function ShipRemouldLayer:isEnoughResource(arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(pg.transform_data_template[arg_43_1].use_item[self:getTransformLevel(arg_43_1) + 1] or {}) do
		if not self.itemsVO[iter_43_1[1]] or self.itemsVO[iter_43_1[1]].count < iter_43_1[2] then
			local var_43_1 = i18n("ship_remould_no_item")

			return
		end
	end

	if self.playerVO.gold < pg.transform_data_template[arg_43_1].use_gold then
		local var_43_3 = i18n("ship_remould_no_gold")

		return
	end

	if pg.transform_data_template[arg_43_1].use_ship ~= 0 and (not self.contextData.materialShipIds or #self.contextData.materialShipIds ~= pg.transform_data_template[arg_43_1].use_ship) then
		local var_43_5 = i18n("ship_remould_no_material")

		return
	end

	return true
end

function ShipRemouldLayer:updateAttrTF(arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = arg_44_3 and "%" or ""

	setText(arg_44_1:Find("name"), arg_44_2.attrName)
	setText(arg_44_1:Find("pre_value"), arg_44_2.value .. var_44_0)
	setText(arg_44_1:Find("value"), arg_44_2.addition + arg_44_2.value .. var_44_0)
	setText(arg_44_1:Find("addtion"), ((arg_44_2.addition > 0 or nil) and ("+" .. arg_44_2.addition or arg_44_2.addition)) .. var_44_0)

	return
end

function ShipRemouldLayer:updateAttrTF_D(arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = arg_45_3 and "%" or ""

	setText(arg_45_1:Find("name"), arg_45_2.attrName)
	setText(arg_45_1:Find("value"), ((arg_45_2.addition > 0 or nil) and ("+" .. arg_45_2.addition or arg_45_2.addition)) .. var_45_0)

	return
end

function ShipRemouldLayer:showToolTip(arg_46_1)
	if not self.shipVO then
		return
	end

	local var_46_0 = pg.transform_data_template[arg_46_1]
	local var_46_1 = self:isFinished(arg_46_1)

	setActive(findTF(self.tooltip, "window/scrollview/list/attrs"), not var_46_1)

	if not var_46_1 then
		local var_46_2 = Clone(self.shipVO)

		_.each(var_46_0.ship_id, function(arg_47_0)
			if arg_47_0[1] == self.shipVO.configId then
				var_46_2.configId = arg_47_0[2]
			end

			return
		end)

		var_46_2.transforms[arg_46_1] = {
			level = 1,
			id = arg_46_1
		}

		local var_46_3 = {}

		table.insert(var_46_3, {
			name = i18n("common_ship_type"),
			from = ShipType.Type2Name(self.shipVO:getShipType()),
			to = ShipType.Type2Name(var_46_2:getShipType())
		})
		table.insert(var_46_3, {
			name = i18n("attribute_armor_type"),
			from = self.shipVO:getShipArmorName(),
			to = var_46_2:getShipArmorName()
		})

		local var_46_4 = self.shipVO:getShipProperties()
		local var_46_5 = var_46_2:getShipProperties()

		for iter_46_0, iter_46_1 in ipairs({
			AttributeType.Durability,
			AttributeType.Cannon,
			AttributeType.Torpedo,
			AttributeType.AntiAircraft,
			AttributeType.Air,
			AttributeType.Reload,
			AttributeType.Hit,
			AttributeType.Expend,
			AttributeType.Dodge,
			AttributeType.AntiSub
		}) do
			local var_46_6 = {}

			if iter_46_1 == AttributeType.Expend then
				var_46_6.name = AttributeType.Type2Name(iter_46_1)
				var_46_6.from = self.shipVO:getBattleTotalExpend()
				var_46_6.to = var_46_2:getBattleTotalExpend()
			else
				var_46_6.name = AttributeType.Type2Name(iter_46_1)
				var_46_6.from = math.floor(var_46_4[iter_46_1])
				var_46_6.to = math.floor(var_46_5[iter_46_1])
			end

			var_46_6.add = var_46_6.to - var_46_6.from

			table.insert(var_46_3, var_46_6)
		end

		local var_46_7 = UIItemList.New(findTF(self.tooltip, "window/scrollview/list/attrs"), findTF(self.tooltip, "window/scrollview/list/attrs/attr"))

		var_46_7:make(function(arg_48_0, arg_48_1, arg_48_2)
			if arg_48_0 == UIItemList.EventUpdate then
				local var_48_0 = var_46_3[arg_48_1 + 1]

				setText(arg_48_2:Find("name"), var_46_3[arg_48_1 + 1].name)
				setText(arg_48_2:Find("pre_value"), var_48_0.from)

				local var_48_1 = arg_48_2:Find("addtion")
				local var_48_2 = "#A9F548"

				if var_48_0.add and var_48_0.from ~= var_48_0.to then
					setActive(var_48_1, true)

					local var_48_3

					if var_48_0.from > var_48_0.to then
						var_48_2 = "#FF3333"
						var_48_3 = setText
					end

					var_48_3(var_48_1, string.format("<color=%s>[%s%s]</color>", var_48_2, var_48_0.from < var_48_0.to and "+" or "", var_48_0.add))
					setText(arg_48_2:Find("value"), string.format("<color=%s>%s</color>", var_48_2, var_48_0.to))
				else
					setActive(var_48_1, false)
					setText(arg_48_2:Find("value"), string.format("<color=%s>%s</color>", var_48_2, var_48_0.to))
				end
			end

			return
		end)
		var_46_7:align(#var_46_3)
	end

	setText(findTF(self.tooltip, "window/scrollview/list/content/"), var_46_0.descrip)
	onButton(self, findTF(self.tooltip, "window/top/btnBack"), function()
		self:closeTip()

		return
	end, SFX_CANCEL)
	onButton(self, self.tooltip, function()
		self:closeTip()

		return
	end, SFX_CANCEL)
	setActive(self.tooltip, true)
	self:OverlayPanel(self.tooltip)

	return
end

function ShipRemouldLayer:closeTip()
	setActive(self.tooltip, false)
	self:UnOverlayPanel(self.tooltip, self._tf)

	return
end

function ShipRemouldLayer:willExit()
	if self.helpBtn then
		setActive(self.helpBtn, true)
	end

	self:UnOverlayPanel(self.tooltip, self._tf)

	return
end

function ShipRemouldLayer:onBackPressed()
	if isActive(self.tooltip) then
		self:closeTip()

		return
	end

	self:emit(BaseUI.ON_BACK_PRESSED, true)

	return
end

return ShipRemouldLayer
