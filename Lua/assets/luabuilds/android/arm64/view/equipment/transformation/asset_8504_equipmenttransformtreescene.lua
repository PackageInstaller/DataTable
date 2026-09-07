local EquipmentTransformTreeScene = class("EquipmentTransformTreeScene", import("view.base.BaseUI"))
local PoolPlural = require("Mgr/Pool/PoolPlural")
local var_0_2 = "ui/EquipmentTransformTreeUI_atlas"

function EquipmentTransformTreeScene:getUIName()
	return "EquipmentTransformTreeUI"
end

EquipmentTransformTreeScene.optionsPath = {
	"blur_panel/adapt/top/option"
}
EquipmentTransformTreeScene.MODE_NORMAL = 1
EquipmentTransformTreeScene.MODE_HIDESIDE = 2

function EquipmentTransformTreeScene:init()
	self.leftPanel = self._tf:Find("Adapt/Left")
	self.rightPanel = self._tf:Find("Adapt/Right")
	self.nationToggleGroup = self.leftPanel:Find("Nations"):Find("ViewPort/Content")

	setActive(self.nationToggleGroup:GetChild(0), false)
	self.nationToggleGroup:GetChild(0):Find("selectedCursor").gameObject:SetActive(false)

	self.equipmentTypeToggleGroup = self.leftPanel:Find("EquipmentTypes"):Find("ViewPort/Content")

	setActive(self.equipmentTypeToggleGroup:GetChild(0), false)
	self.equipmentTypeToggleGroup:GetChild(0):Find("selectedframe").gameObject:SetActive(false)

	self.TreeCanvas = self.rightPanel:Find("ViewPort/Content")

	setActive(self.rightPanel:Find("EquipNode"), false)
	setActive(self.rightPanel:Find("Link"), false)

	self.nodes = {}
	self.links = {}
	self.plurals = {
		EquipNode = PoolPlural.New(self.rightPanel:Find("EquipNode").gameObject, 5),
		Link = PoolPlural.New(self.rightPanel:Find("Link").gameObject, 8)
	}
	self.pluralRoot = pg.PoolMgr.GetInstance().root
	self.top = self._tf:Find("blur_panel")
	self.loader = AutoLoader.New()

	return
end

function EquipmentTransformTreeScene:GetEnv()
	self.env = self.env or {}

	return self.env
end

function EquipmentTransformTreeScene:SetEnv(arg_4_1)
	self.env = arg_4_1

	return
end

function EquipmentTransformTreeScene:didEnter()
	pg.UIMgr.GetInstance():OverlayPanel(self.top)
	onButton(self, self.top:Find("adapt/top/back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	if self.contextData.targetEquipId then
		local var_5_0
		local var_5_1
		local var_5_2 = false

		for iter_5_0, iter_5_1 in pairs(self.env.nationsTree) do
			for iter_5_2, iter_5_3 in pairs(iter_5_1) do
				for iter_5_4, iter_5_5 in ipairs(iter_5_3.equipments) do
					if iter_5_5[3] == self.contextData.targetEquipId then
						var_5_1 = iter_5_2
						var_5_0 = iter_5_0
						var_5_2 = true

						break
					end
				end
			end

			if var_5_2 then
				break
			end
		end

		if var_5_2 then
			self.contextData.nation = var_5_0
			self.contextData.equipmentTypeIndex = var_5_1
		end

		self.contextData.targetEquipId = nil
	end

	self:InitPage()

	if self.contextData.mode == EquipmentTransformTreeScene.MODE_HIDESIDE then
		setActive(self.leftPanel, false)

		self.rightPanel.sizeDelta.x = 0
		self.rightPanel.sizeDelta = self.rightPanel.sizeDelta

		setAnchoredPosition(self.rightPanel, {
			x = 0
		})
	end

	return
end

function EquipmentTransformTreeScene:GetSortKeys()
	local var_7_0 = _.keys(self)

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0 < arg_8_1
	end)

	return var_7_0
end

function EquipmentTransformTreeScene:GetSortTypes()
	local var_9_0 = _.values(self)

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0.id < arg_10_1.id
	end)

	return _.map(var_9_0, function(arg_11_0)
		return arg_11_0.category2
	end)
end

function EquipmentTransformTreeScene:InitPage()
	self.firstInit = true

	local var_12_0 = self.contextData
	local var_12_1 = self.env

	var_12_0.mode = self.contextData.mode or EquipmentTransformTreeScene.MODE_NORMAL

	local var_12_2 = var_12_0.nation
	local var_12_3 = EquipmentTransformTreeScene.GetSortKeys(var_12_1.nationsTree)

	if not var_12_0.nation or not table.contains(var_12_3, var_12_2) then
		var_12_2 = var_12_3[1]
	end

	if next(var_12_1.nationsTree[var_12_2]) == nil then
		for iter_12_0 = 2, #var_12_3 do
			if next(var_12_1.nationsTree[var_12_3[iter_12_0]]) ~= nil then
				var_12_2 = var_12_3[iter_12_0]

				break
			end
		end
	end

	var_12_0.nation = nil

	self:UpdateNations()
	triggerButton(self.nationToggles[table.indexof(var_12_3, var_12_2) or 1])

	self.firstInit = nil

	return
end

function EquipmentTransformTreeScene:UpdateNations()
	local var_13_0 = EquipmentTransformTreeScene.GetSortKeys(self.env.nationsTree)

	self.nationToggles = CustomIndexLayer.Clone2Full(self.nationToggleGroup, #var_13_0)

	for iter_13_0 = 1, #self.nationToggles do
		local var_13_1 = self.nationToggles[iter_13_0]
		local var_13_2 = var_13_0[iter_13_0]

		self.loader:GetSprite(var_0_2, "nation" .. var_13_0[iter_13_0] .. "_disable", self.nationToggles[iter_13_0]:Find("selectedIcon"))
		setActive(self.nationToggles[iter_13_0]:Find("selectedCursor"), false)
		onButton(self, self.nationToggles[iter_13_0], function()
			if self.contextData.nation ~= var_13_2 then
				if next(self.env.nationsTree[var_13_2]) == nil then
					pg.TipsMgr.GetInstance():ShowTips(i18n("word_comingSoon"))

					return
				end

				self.loader:GetSprite(var_0_2, "nation" .. var_13_2, var_13_1:Find("selectedIcon"))

				if self.contextData.nation then
					local var_14_0 = table.indexof(var_13_0, self.contextData.nation)

					setActive(self.nationToggles[var_14_0]:Find("selectedCursor"), false)
					self.loader:GetSprite(var_0_2, "nation" .. self.contextData.nation .. "_disable", self.nationToggles[var_14_0]:Find("selectedIcon"))
				end

				self.contextData.nation = var_13_2

				self:UpdateEquipmentTypes()

				local var_14_1 = EquipmentTransformTreeScene.GetSortTypes(self.env.nationsTree[var_13_2])
				local var_14_2 = var_14_1[1]

				if self.firstInit then
					if self.contextData.equipmentTypeIndex and table.contains(var_14_1, self.contextData.equipmentTypeIndex) then
						var_14_2 = self.contextData.equipmentTypeIndex
					end
				end

				self.contextData.equipmentTypeIndex = nil

				triggerToggle(self.equipmentTypeToggles[table.indexof(var_14_1, var_14_2) or 1], true)
			end

			return
		end, SFX_UI_TAG)
	end

	return
end

function EquipmentTransformTreeScene:UpdateEquipmentTypes()
	local var_15_0 = EquipmentTransformTreeScene.GetSortTypes(self.env.nationsTree[self.contextData.nation])

	self.equipmentTypeToggles = CustomIndexLayer.Clone2Full(self.equipmentTypeToggleGroup, #var_15_0)

	for iter_15_0 = 1, #self.equipmentTypeToggles do
		local var_15_1 = self.equipmentTypeToggles[iter_15_0]

		self.equipmentTypeToggles[iter_15_0]:GetComponent(typeof(Toggle)).isOn = false

		local var_15_2 = var_15_0[iter_15_0]

		self.loader:GetSprite(var_0_2, "equipmentType" .. var_15_0[iter_15_0], self.equipmentTypeToggles[iter_15_0]:Find("itemName"), true)
		setActive(self.equipmentTypeToggles[iter_15_0]:Find("selectedframe"), false)
		onToggle(self, self.equipmentTypeToggles[iter_15_0], function(arg_16_0)
			if arg_16_0 and self.contextData.equipmentTypeIndex ~= var_15_2 then
				self.contextData.equipmentTypeIndex = var_15_2

				self:ResetCanvas()
			end

			setActive(var_15_1:Find("selectedframe"), arg_16_0)

			return
		end, SFX_UI_TAG)
	end

	self.equipmentTypeToggleGroup.anchoredPosition = Vector2.zero
	self.leftPanel:Find("EquipmentTypes"):GetComponent(typeof(ScrollRect)).velocity = Vector2.zero

	return
end

local var_0_3 = {
	15,
	-4,
	15,
	6
}

function EquipmentTransformTreeScene:ResetCanvas()
	assert(EquipmentProxy.EquipmentTransformTreeTemplate[self.contextData.nation][self.contextData.equipmentTypeIndex], "can't find Equip_upgrade_template Nation: " .. self.contextData.nation .. " Type: " .. self.contextData.equipmentTypeIndex)

	self.TreeCanvas.sizeDelta = Vector2(unpack(EquipmentProxy.EquipmentTransformTreeTemplate[self.contextData.nation][self.contextData.equipmentTypeIndex].canvasSize))
	self.TreeCanvas.anchoredPosition = Vector2.zero
	self.rightPanel:GetComponent(typeof(ScrollRect)).velocity = Vector2.zero

	self:ReturnCanvasItems()

	for iter_17_0, iter_17_1 in ipairs(EquipmentProxy.EquipmentTransformTreeTemplate[self.contextData.nation][self.contextData.equipmentTypeIndex].equipments) do
		local var_17_0 = self.plurals.EquipNode:Dequeue()

		setActive(var_17_0, true)
		setParent(var_17_0, self.TreeCanvas)
		table.insert(self.nodes, {
			id = iter_17_1[3],
			cfg = iter_17_1,
			go = var_17_0
		})

		var_17_0.name = iter_17_1[3]

		self:UpdateItemNode(tf(var_17_0), iter_17_1)
	end

	for iter_17_2, iter_17_3 in ipairs(EquipmentProxy.EquipmentTransformTreeTemplate[self.contextData.nation][self.contextData.equipmentTypeIndex].links) do
		for iter_17_4 = 1, #iter_17_3 - 1 do
			local var_17_1 = iter_17_3[iter_17_4]
			local var_17_2 = iter_17_3[iter_17_4 + 1]
			local var_17_3 = {
				iter_17_3[iter_17_4 + 1][1] - iter_17_3[iter_17_4][1],
				iter_17_3[iter_17_4][2] - iter_17_3[iter_17_4 + 1][2]
			}
			local var_17_4 = math.abs(var_17_3[1]) > math.abs(var_17_3[2])
			local var_17_5 = var_17_4 and math.abs(var_17_3[1]) or math.abs(var_17_3[2])

			if var_17_4 then
				var_17_3[2] = 0
			else
				var_17_3[1] = 0
			end

			local var_17_6 = 1 - math.sign(var_17_3[1])

			var_17_6 = var_17_6 ~= 1 and var_17_6 or 2 - math.sign(var_17_3[2])

			local var_17_7 = math.deg2Rad * 90 * var_17_6

			if #iter_17_3 == 2 then
				local var_17_8 = self.plurals.Link:Dequeue()

				table.insert(self.links, go(var_17_8))
				setActive(var_17_8, true)
				setParent(var_17_8, self.TreeCanvas)
				self.loader:GetSprite(var_0_2, var_17_3[2] == 0 and "wirehead" or "wireline", var_17_8)

				tf(var_17_8).sizeDelta = Vector2(28, 26)
				tf(var_17_8).pivot = Vector2(0.5, 0.5)
				tf(var_17_8).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)

				local var_17_9 = Vector2(math.cos(var_17_7), math.sin(var_17_7)) * var_0_3[(var_17_6 - 1) % 4 + 1]

				tf(var_17_8).anchoredPosition = Vector2(var_17_1[1] + var_17_9.x, -var_17_1[2] + var_17_9.y)

				local var_17_10 = self.plurals.Link:Dequeue()

				table.insert(self.links, go(var_17_10))
				setActive(var_17_10, true)
				setParent(var_17_10, self.TreeCanvas)
				self.loader:GetSprite(var_0_2, "wiretail", var_17_10)

				tf(var_17_10).sizeDelta = Vector2(28, 26)
				tf(var_17_10).pivot = Vector2(0.5, 0.5)
				tf(var_17_10).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)

				local var_17_11 = Vector2(math.cos(var_17_7), math.sin(var_17_7)) * -var_0_3[(var_17_6 + 1) % 4 + 1]

				tf(var_17_10).anchoredPosition = Vector2(var_17_2[1] + var_17_11.x, -var_17_2[2] + var_17_11.y)

				local var_17_12 = self.plurals.Link:Dequeue()

				table.insert(self.links, go(var_17_12))
				setActive(var_17_12, true)
				setParent(var_17_12, self.TreeCanvas)
				self.loader:GetSprite(var_0_2, "wireline", var_17_12)

				tf(var_17_12).sizeDelta = Vector2(math.max(0, var_17_5 - var_0_3[(var_17_6 - 1) % 4 + 1] - var_0_3[(var_17_6 + 1) % 4 + 1] - 28), 16)
				tf(var_17_12).pivot = Vector2(0, 0.5)
				tf(var_17_12).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)
				tf(var_17_12).anchoredPosition = Vector2(var_17_1[1] + var_17_9.x, -var_17_1[2] + var_17_9.y) + Vector2(math.cos(var_17_7), math.sin(var_17_7)) * 14

				break
			end

			local var_17_13 = self.plurals.Link:Dequeue()

			table.insert(self.links, go(var_17_13))
			setActive(var_17_13, true)
			setParent(var_17_13, self.TreeCanvas)

			local var_17_14 = 1

			if iter_17_4 == 1 then
				self.loader:GetSprite(var_0_2, var_17_3[2] == 0 and "wirehead" or "wireline", var_17_13)

				tf(var_17_13).sizeDelta = Vector2(var_17_5 + 14 + var_17_14 - var_0_3[(var_17_6 - 1) % 4 + 1], 26)
				tf(var_17_13).pivot = Vector2((var_17_5 + 14 + var_17_14 - var_0_3[(var_17_6 - 1) % 4 + 1] - var_17_14) / (var_17_5 + 14 + var_17_14 - var_0_3[(var_17_6 - 1) % 4 + 1]), 0.5)
				tf(var_17_13).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)
				tf(var_17_13).anchoredPosition = Vector2(var_17_2[1], -var_17_2[2])
			elseif iter_17_4 + 1 == #iter_17_3 then
				self.loader:GetSprite(var_0_2, "wiretail", var_17_13)

				tf(var_17_13).sizeDelta = Vector2(var_17_5 + 14 + var_17_14 - var_0_3[(var_17_6 + 1) % 4 + 1], 26)
				tf(var_17_13).pivot = Vector2(var_17_14 / (var_17_5 + 14 + var_17_14 - var_0_3[(var_17_6 + 1) % 4 + 1]), 0.5)
				tf(var_17_13).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)
				tf(var_17_13).anchoredPosition = Vector2(var_17_1[1], -var_17_1[2])
			else
				self.loader:GetSprite(var_0_2, "wireline", var_17_13)

				tf(var_17_13).sizeDelta = Vector2(var_17_5 + var_17_14 * 2, 16)
				tf(var_17_13).pivot = Vector2(var_17_14 / (var_17_5 + var_17_14 * 2), 0.5)
				tf(var_17_13).localRotation = Quaternion.Euler(0, 0, var_17_6 * 90)
				tf(var_17_13).anchoredPosition = Vector2(var_17_1[1], -var_17_1[2])
			end
		end
	end

	return
end

function EquipmentTransformTreeScene:UpdateItemNode(arg_18_1, arg_18_2)
	arg_18_1 = tf(arg_18_1)
	arg_18_1.anchoredPosition = Vector2(arg_18_2[1], -arg_18_2[2])

	updateDrop(arg_18_1:Find("Item"), {
		id = arg_18_2[3],
		type = DROP_TYPE_EQUIP
	})
	onButton(self, arg_18_1:Find("Item"), function()
		local var_19_0 = EquipmentProxy.GetTransformSources(arg_18_2[3])[1]

		if not var_19_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_initial_node"))

			return
		end

		self:emit(EquipmentTransformTreeMediator.OPEN_LAYER, Context.New({
			mediator = EquipmentTransformMediator,
			viewComponent = EquipmentTransformLayer,
			data = {
				formulaId = var_19_0
			}
		}))

		return
	end, SFX_PANEL)
	arg_18_1:Find("Mask/NameText"):GetComponent("ScrollText"):SetText(Equipment.getConfigData(arg_18_2[3]).name)
	setActive(arg_18_1:Find("cratfable"), (_.any(self.env.tracebackHelper:GetSortedEquipTraceBack(arg_18_2[3]), function(arg_20_0)
		return arg_20_0.candicates and #arg_20_0.candicates > 0 and EquipmentTransformUtil.CheckTransformFormulasSucceed(arg_20_0.formulas, arg_20_0.candicates[#arg_20_0.candicates])
	end)))
	onButton(self, arg_18_1:Find("cratfable"), function()
		self:emit(EquipmentTransformTreeMediator.OPEN_LAYER, Context.New({
			mediator = EquipmentTraceBackMediator,
			viewComponent = EquipmentTraceBackLayer,
			data = {
				TargetEquipmentId = arg_18_2[3]
			}
		}))

		return
	end)
	setActive(arg_18_1:Find("Item/new"), arg_18_2[4] and PlayerPrefs.GetInt("ShowTransformTip_" .. arg_18_2[3], 0) == 0)

	return
end

function EquipmentTransformTreeScene:UpdateItemNodes()
	for iter_22_0, iter_22_1 in ipairs(self.nodes) do
		self:UpdateItemNode(iter_22_1.go, iter_22_1.cfg)
	end

	return
end

function EquipmentTransformTreeScene:UpdateItemNodeByID(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(self.nodes) do
		if arg_23_1 == iter_23_1.id then
			self:UpdateItemNode(iter_23_1.go, iter_23_1.cfg)

			break
		end
	end

	return
end

function EquipmentTransformTreeScene:ReturnCanvasItems(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(self.nodes) do
		if not self.plurals.EquipNode:Enqueue(iter_24_1.go, arg_24_1) then
			setParent(iter_24_1.go, self.pluralRoot)
		end
	end

	table.clean(self.nodes)

	for iter_24_2, iter_24_3 in ipairs(self.links) do
		if not self.plurals.Link:Enqueue(iter_24_3, arg_24_1) then
			setParent(iter_24_3, self.pluralRoot)
		end
	end

	table.clean(self.links)

	return
end

function EquipmentTransformTreeScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.top, self._tf)
	self:ReturnCanvasItems(true)

	for iter_25_0, iter_25_1 in pairs(self.plurals) do
		iter_25_1:Clear()
	end

	self.loader:Clear()

	return
end

return EquipmentTransformTreeScene
