local WSMap = class("WSMap", import("...BaseEntity"))

WSMap.Fields = {
	map = "table",
	rtTargetArrow = "userdata",
	transform = "userdata",
	wsMapArtifactsFA = "table",
	wsMapFleets = "table",
	wsMapCells = "table",
	wsMapAttachments = "table",
	wsTerrainEffects = "table",
	rtTop = "userdata",
	rtQuads = "userdata",
	wsCarryItems = "table",
	rtEffectA = "userdata",
	wsMapQuads = "table",
	wsMapPath = "table",
	wsMapResource = "table",
	twTimerId = "number",
	wsMapArtifacts = "table",
	twTimer = "userdata",
	world = "table",
	rtItems = "userdata",
	wsPool = "table",
	rtEffectB = "userdata",
	rtCells = "userdata",
	displayRangeLines = "table",
	wsTimer = "table",
	displayRangeTimer = "table",
	transportDisplay = "number",
	wsMapItems = "table",
	rangeVisible = "boolean",
	wsMapTransports = "table",
	rtEffectC = "userdata"
}
WSMap.Listeners = {
	onRemoveCarry = "OnRemoveCarry",
	onUpdateTerrain = "OnUpdateTerrain",
	onUpdateAttachment = "OnUpdateAttachment",
	onUpdateFleetFOV = "OnUpdateFleetFOV",
	onAddAttachment = "OnAddAttachment",
	onRemoveAttachment = "OnRemoveAttachment",
	onAddCarry = "OnAddCarry"
}
WSMap.EventUpdateEventTips = "WSMap.EventUpdateEventTips"

function WSMap:Setup(arg_1_1)
	self.map = arg_1_1
	self.wsMapQuads = {}
	self.wsMapItems = {}
	self.wsMapCells = {}
	self.wsMapFleets = {}
	self.wsMapArtifacts = {}
	self.wsMapArtifactsFA = {}
	self.wsMapTransports = {}
	self.wsMapAttachments = {}
	self.wsTerrainEffects = {}
	self.wsCarryItems = {}
	self.wsMapPath = WSMapPath.New()

	self.wsMapPath:Setup(self.map.theme)

	self.wsMapResource = WSMapResource.New()

	self.wsMapResource:Setup(self.map)

	self.transportDisplay = WorldConst.TransportDisplayNormal

	pg.DelegateInfo.New(self)

	return
end

function WSMap:Dispose()
	pg.DelegateInfo.Dispose(self)
	self.wsMapPath:Dispose()
	self:ClearTargetArrow()
	self:Unload()
	self:Clear()

	return
end

function WSMap:Load(arg_3_1)
	local var_3_0 = {}

	table.insert(var_3_0, function(arg_4_0)
		self:InitPlane(arg_4_0)

		return
	end)
	table.insert(var_3_0, function(arg_5_0)
		self.wsMapResource:Load(arg_5_0)

		return
	end)
	table.insert(var_3_0, function(arg_6_0)
		self:InitClutter()
		self:InitMap()
		arg_6_0()

		return
	end)
	seriesAsync(var_3_0, arg_3_1)

	return
end

function WSMap:Unload()
	self:DisposeMap()
	self.wsMapResource:Unload()

	if self.transform then
		PoolMgr.GetInstance():ReturnPrefab("world/object/world_plane", "world_plane", self.transform.gameObject, true)

		self.transform = nil
	end

	return
end

function WSMap:InitPlane(arg_8_1)
	PoolMgr.GetInstance():GetPrefab("world/object/world_plane", "world_plane", true, function(arg_9_0)
		self.transform = arg_9_0.transform

		setActive(self.transform, false)

		self.rtQuads = self.transform:Find("quads")
		self.rtItems = self.transform:Find("items")
		self.rtCells = self.transform:Find("cells")
		self.rtTop = self.transform:Find("top")
		self.rtEffectA = self.transform:Find("effect-a-1-999")
		self.rtEffectB = self.transform:Find("effect-b-1001-1999")
		self.rtEffectC = self.transform:Find("effect-c-2001-2999")

		assert(self.map and self.map.active, "map not exist or map not active.")

		self.transform.name = "plane"
		self.transform.anchoredPosition3D = Vector3(self.map.theme.offsetx, self.map.theme.offsety, self.map.theme.offsetz) + WorldConst.DefaultMapOffset

		local var_9_0 = self.transform:Find("display")
		local var_9_1 = var_9_0:Find("mask/sea")

		setImageAlpha(var_9_1, 0)
		GetSpriteFromAtlasAsync("chapter/pic/" .. self.map.theme.assetSea, self.map.theme.assetSea, function(arg_10_0)
			if var_9_1 then
				setImageSprite(var_9_1, arg_10_0, false)
				setImageAlpha(var_9_1, 1)
			end

			return
		end)

		local var_9_2 = Vector2(10000, 10000)
		local var_9_3 = Vector2(WorldConst.MaxColumn, WorldConst.MaxRow)
		local var_9_4 = Vector2(-WorldConst.MaxColumn, -WorldConst.MaxRow)

		for iter_9_0 = 0, WorldConst.MaxRow - 1 do
			for iter_9_1 = 0, WorldConst.MaxColumn - 1 do
				if self.map:GetCell(iter_9_0, iter_9_1) then
					var_9_2.x = math.min(var_9_2.x, iter_9_1)
					var_9_2.y = math.min(var_9_2.y, WorldConst.MaxRow * 0.5 - iter_9_0 - 1)
					var_9_3.x = math.min(var_9_3.x, iter_9_1)
					var_9_3.y = math.min(var_9_3.y, iter_9_0)
					var_9_4.x = math.max(var_9_4.x, iter_9_1)
					var_9_4.y = math.max(var_9_4.y, iter_9_0)
				end
			end
		end

		local var_9_5 = self.map.theme.cellSize + self.map.theme.cellSpace

		var_9_2.x = var_9_2.x * (self.map.theme.cellSize + self.map.theme.cellSpace).x
		var_9_2.y = var_9_2.y * var_9_5.y
		Vector2.zero.x = (var_9_4.x - var_9_3.x + 1) * var_9_5.x
		Vector2.zero.y = (var_9_4.y - var_9_3.y + 1) * var_9_5.y
		var_9_0.anchoredPosition = var_9_2 + Vector2.zero * 0.5
		var_9_0.sizeDelta = Vector2.zero

		local var_9_6 = Vector2(math.floor(var_9_0.sizeDelta.x / var_9_5.x), math.floor(var_9_0.sizeDelta.y / var_9_5.y))
		local var_9_7 = var_9_0:Find("linev")
		local var_9_8 = var_9_7:GetChild(0)
		local var_9_9 = var_9_7:GetComponent(typeof(GridLayoutGroup))

		var_9_9.cellSize = Vector2(WorldConst.LineCross, var_9_0.sizeDelta.y)
		var_9_9.spacing = Vector2(var_9_5.x - WorldConst.LineCross, 0)
		var_9_9.padding.left = math.floor(var_9_9.spacing.x)

		for iter_9_2 = var_9_7.childCount - 1, math.max(var_9_6.x - 1, 0), -1 do
			if iter_9_2 > 0 then
				Destroy(var_9_7:GetChild(iter_9_2))
			end
		end

		for iter_9_3 = var_9_7.childCount, var_9_6.x - 2 do
			Instantiate(var_9_8).transform:SetParent(var_9_7, false)
		end

		local var_9_10 = var_9_0:Find("lineh")
		local var_9_11 = var_9_10:GetChild(0)
		local var_9_12 = var_9_10:GetComponent(typeof(GridLayoutGroup))

		var_9_12.cellSize = Vector2(var_9_0.sizeDelta.x, WorldConst.LineCross)
		var_9_12.spacing = Vector2(0, var_9_5.y - WorldConst.LineCross)
		var_9_12.padding.top = math.floor(var_9_12.spacing.y)

		for iter_9_4 = var_9_10.childCount - 1, math.max(var_9_6.y - 1, 0), -1 do
			if iter_9_4 > 0 then
				Destroy(var_9_10:GetChild(iter_9_4))
			end
		end

		for iter_9_5 = var_9_10.childCount, var_9_6.y - 2 do
			Instantiate(var_9_11).transform:SetParent(var_9_10, false)
		end

		arg_8_1()

		return
	end)

	return
end

function WSMap:InitClutter()
	self.twTimer = LeanTween.value(self.transform.gameObject, 1, 0, WorldConst.QuadBlinkDuration):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

	self.wsTimer:AddInMapTween(self.twTimer.uniqueId)
	self:NewTargetArrow()

	return
end

function WSMap:InitMap()
	local var_12_1 = _.values(self.map.cells)

	table.sort(var_12_1, function(arg_13_0, arg_13_1)
		return arg_13_0.row < arg_13_1.row or arg_13_0.row == arg_13_1.row and arg_13_0.column < arg_13_1.column
	end)

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		self.wsMapQuads[WSMapQuad.GetName(iter_12_1.row, iter_12_1.column)] = self:NewQuad(iter_12_1)
		self.wsMapCells[WSMapCell.GetName(iter_12_1.row, iter_12_1.column)] = self:NewCell(iter_12_1)
	end

	for iter_12_2, iter_12_3 in ipairs(self.map.config.float_items) do
		local var_12_2 = self.map:GetCell(iter_12_3[1], iter_12_3[2])

		if var_12_2 then
			local var_12_3 = self:GetItem(iter_12_3[1], iter_12_3[2])

			if not var_12_3 then
				var_12_3 = self:NewItem(var_12_2)
				self.wsMapItems[WSMapItem.GetName(var_12_2.row, var_12_2.column)] = var_12_3
			end

			table.insert(self.wsMapArtifacts, (self:NewArtifact(var_12_3, iter_12_3)))
		end
	end

	for iter_12_4, iter_12_5 in ipairs(var_12_1) do
		for iter_12_6, iter_12_7 in ipairs(iter_12_5.attachments) do
			local var_12_4 = self:GetCell(iter_12_7.row, iter_12_7.column)

			if iter_12_7.type == WorldMapAttachment.TypeArtifact then
				local var_12_5 = self:GetItem(iter_12_5.row, iter_12_5.column)

				if not var_12_5 then
					var_12_5 = self:NewItem(iter_12_5)
					self.wsMapItems[WSMapItem.GetName(iter_12_5.row, iter_12_5.column)] = var_12_5
				end

				table.insert(self.wsMapArtifactsFA, (self:NewArtifact(var_12_5, iter_12_7:GetArtifaceInfo(), iter_12_7)))
			else
				table.insert(self.wsMapAttachments, (self:NewAttachment(var_12_4, iter_12_7)))
			end
		end
	end

	for iter_12_8, iter_12_9 in ipairs(self.map:GetNormalFleets()) do
		table.insert(self.wsMapFleets, (self:NewFleet(iter_12_9)))

		for iter_12_10, iter_12_11 in ipairs(iter_12_9:GetCarries()) do
			table.insert(self.wsCarryItems, (self:NewCarryItem(iter_12_9, iter_12_11)))
		end
	end

	self:FlushFleets()
	self.map:AddListener(WorldMap.EventUpdateFleetFOV, self.onUpdateFleetFOV)

	return
end

function WSMap:DisposeMap()
	self.map:RemoveListener(WorldMap.EventUpdateFleetFOV, self.onUpdateFleetFOV)
	_.each(self.wsCarryItems, function(arg_15_0)
		self:DisposeCarryItem(arg_15_0)

		return
	end)

	self.wsCarryItems = {}

	_.each(self.wsMapFleets, function(arg_16_0)
		self:DisposeFleet(arg_16_0)

		return
	end)

	self.wsMapFleets = {}

	_.each(self.wsMapAttachments, function(arg_17_0)
		self:DisposeAttachment(arg_17_0)

		return
	end)

	self.wsMapAttachments = {}

	_.each(self.wsMapArtifacts, function(arg_18_0)
		self:DisposeArtifact(arg_18_0)

		return
	end)

	self.wsMapArtifacts = {}

	for iter_14_0, iter_14_1 in pairs(self.wsMapTransports) do
		self:DisposeTransport(iter_14_1)
	end

	self.wsMapTransports = {}

	_.each(self.wsMapArtifactsFA, function(arg_19_0)
		self:DisposeArtifact(arg_19_0)

		return
	end)

	self.wsMapArtifactsFA = {}

	for iter_14_2, iter_14_3 in pairs(self.wsMapCells) do
		self:DisposeCell(iter_14_3)
	end

	self.wsMapCells = {}

	for iter_14_4, iter_14_5 in pairs(self.wsMapItems) do
		self:DisposeItem(iter_14_5)
	end

	self.wsMapItems = {}

	for iter_14_6, iter_14_7 in pairs(self.wsMapQuads) do
		self:DisposeQuad(iter_14_7)
	end

	self.wsMapQuads = {}

	for iter_14_8, iter_14_9 in ipairs(self.wsTerrainEffects) do
		self:DisposeTerrainEffect(iter_14_9)
	end

	self.wsTerrainEffects = {}

	return
end

function WSMap:OnAddAttachment(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = self:GetCell(arg_20_2.row, arg_20_2.column)

	assert(var_20_0, "cell not exist: " .. arg_20_2.row .. ", " .. arg_20_2.column)

	if arg_20_3.type == WorldMapAttachment.TypeArtifact then
		local var_20_1 = self:GetItem(arg_20_2.row, arg_20_2.column)

		if not var_20_1 then
			var_20_1 = self:NewItem(arg_20_2)
			self.wsMapItems[WSMapItem.GetName(arg_20_2.row, arg_20_2.column)] = var_20_1
		end

		table.insert(self.wsMapArtifactsFA, (self:NewArtifact(var_20_1, arg_20_3:GetArtifaceInfo(), arg_20_3)))
	else
		table.insert(self.wsMapAttachments, (self:NewAttachment(var_20_0, arg_20_3)))
		self:OnUpdateAttachment(nil, arg_20_3)
	end

	return
end

function WSMap:OnRemoveAttachment(arg_21_1, arg_21_2, arg_21_3)
	if arg_21_3.type == WorldMapAttachment.TypeArtifact then
		for iter_21_0 = #self.wsMapArtifactsFA, 1, -1 do
			if self.wsMapArtifactsFA[iter_21_0].attachment == arg_21_3 then
				self:DisposeArtifact(self.wsMapArtifactsFA[iter_21_0])
				table.remove(self.wsMapArtifactsFA, iter_21_0)

				break
			end
		end
	else
		for iter_21_1 = #self.wsMapAttachments, 1, -1 do
			if self.wsMapAttachments[iter_21_1].attachment == arg_21_3 then
				self:DisposeAttachment(self.wsMapAttachments[iter_21_1])
				table.remove(self.wsMapAttachments, iter_21_1)
				self:OnUpdateAttachment(nil, arg_21_3)

				break
			end
		end
	end

	return
end

function WSMap:OnUpdateAttachment(arg_22_1, arg_22_2)
	_.each(self:FindAttachments(arg_22_2.row, arg_22_2.column), function(arg_23_0)
		arg_23_0:Update(arg_22_1)

		return
	end)

	if self:FindFleet(arg_22_2.row, arg_22_2.column) then
		self:FlushFleets()
	end

	self:DispatchEvent(WSMap.EventUpdateEventTips)

	return
end

function WSMap:OnUpdateTerrain(arg_24_1, arg_24_2)
	local var_24_0, var_24_1 = self:GetTerrainEffect(arg_24_2.row, arg_24_2.column)

	if var_24_0 then
		self:DisposeTerrainEffect(var_24_0)
		table.remove(self.wsTerrainEffects, var_24_1)
	end

	local var_24_2 = arg_24_2:GetTerrain()

	if var_24_2 ~= WorldMapCell.TerrainStream and var_24_2 ~= WorldMapCell.TerrainWind and var_24_2 ~= WorldMapCell.TerrainIce then
		if var_24_2 == WorldMapCell.TerrainPoison then
			table.insert(self.wsTerrainEffects, (self:NewTerrainEffect(arg_24_2)))
		end
	end

	return
end

function WSMap:OnAddCarry(arg_25_1, arg_25_2, arg_25_3)
	table.insert(self.wsCarryItems, (self:NewCarryItem(arg_25_2, arg_25_3)))

	return
end

function WSMap:OnRemoveCarry(arg_26_1, arg_26_2, arg_26_3)
	for iter_26_0 = #self.wsCarryItems, 1, -1 do
		if self.wsCarryItems[iter_26_0].carryItem == arg_26_3 then
			self:DisposeCarryItem(self.wsCarryItems[iter_26_0])
			table.remove(self.wsCarryItems, iter_26_0)

			break
		end
	end

	return
end

function WSMap:OnUpdateFleetFOV()
	self:FlushFleets()

	return
end

function WSMap:NewQuad(arg_28_1)
	local var_28_0 = WPool:Get(WSMapQuad)

	var_28_0.transform = self.wsPool:Get((WSMapQuad.GetResName())).transform

	var_28_0.transform:SetParent(self.rtQuads, false)

	var_28_0.twTimer = self.twTimer

	var_28_0:Setup(arg_28_1, self.map.theme)

	return var_28_0
end

function WSMap:DisposeQuad(arg_29_1)
	self.wsPool:Return(WSMapQuad.GetResName(), arg_29_1.transform.gameObject)
	WPool:Return(arg_29_1)

	return
end

function WSMap:NewItem(arg_30_1)
	local var_30_0 = WPool:Get(WSMapItem)

	var_30_0.transform = self.wsPool:Get((WSMapItem.GetResName())).transform

	var_30_0.transform:SetParent(self.rtItems, false)
	var_30_0:Setup(arg_30_1, self.map.theme)

	return var_30_0
end

function WSMap:DisposeItem(arg_31_1)
	self.wsPool:Return(WSMapItem.GetResName(), arg_31_1.transform.gameObject)
	WPool:Return(arg_31_1)

	return
end

function WSMap:NewCell(arg_32_1)
	local var_32_0 = WPool:Get(WSMapCell)

	var_32_0.transform = self.wsPool:Get((WSMapCell.GetResName())).transform

	var_32_0.transform:SetParent(self.rtCells, false)

	var_32_0.wsMapResource = self.wsMapResource
	var_32_0.wsTimer = self.wsTimer

	var_32_0:Setup(self.map, arg_32_1)
	var_32_0.rtFog:SetParent(self.rtCells:Find("fogs"), true)
	arg_32_1:AddListener(WorldMapCell.EventAddAttachment, self.onAddAttachment)
	arg_32_1:AddListener(WorldMapCell.EventRemoveAttachment, self.onRemoveAttachment)
	arg_32_1:AddListener(WorldMapCell.EventUpdateTerrain, self.onUpdateTerrain)
	self:OnUpdateTerrain(nil, arg_32_1)

	return var_32_0
end

function WSMap:DisposeCell(arg_33_1)
	arg_33_1.rtFog:SetParent(arg_33_1.transform, true)
	arg_33_1.cell:RemoveListener(WorldMapCell.EventAddAttachment, self.onAddAttachment)
	arg_33_1.cell:RemoveListener(WorldMapCell.EventRemoveAttachment, self.onRemoveAttachment)
	arg_33_1.cell:RemoveListener(WorldMapCell.EventUpdateTerrain, self.onUpdateTerrain)
	self.wsPool:Return(WSMapCell.GetResName(), arg_33_1.transform.gameObject)
	WPool:Return(arg_33_1)

	return
end

function WSMap:NewTransport(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = WPool:Get(WSMapTransport)

	var_34_0.transform = self.wsPool:Get((WSMapTransport.GetResName())).transform

	var_34_0.transform:SetParent(self.rtQuads, false)

	var_34_0.wsMapPath = self.wsMapPath

	var_34_0:Setup(arg_34_1, arg_34_2, arg_34_3, self.map)

	return var_34_0
end

function WSMap:DisposeTransport(arg_35_1)
	self.wsPool:Return(WSMapTransport.GetResName(), arg_35_1.transform.gameObject)
	WPool:Return(arg_35_1)

	return
end

function WSMap:NewAttachment(arg_36_1, arg_36_2)
	local var_36_0 = WPool:Get(WSMapAttachment)

	var_36_0.transform = self.wsPool:Get((WSMapAttachment.GetResName(arg_36_2))).transform

	var_36_0.transform:SetParent(arg_36_1.rtAttachments, false)

	var_36_0.twTimer = self.twTimer

	var_36_0:Setup(self.map, arg_36_1.cell, arg_36_2)
	arg_36_2:AddListener(WorldMapAttachment.EventUpdateFlag, self.onUpdateAttachment)
	arg_36_2:AddListener(WorldMapAttachment.EventUpdateData, self.onUpdateAttachment)
	arg_36_2:AddListener(WorldMapAttachment.EventUpdateLurk, self.onUpdateAttachment)

	return var_36_0
end

function WSMap:DisposeAttachment(arg_37_1)
	arg_37_1.attachment:RemoveListener(WorldMapAttachment.EventUpdateFlag, self.onUpdateAttachment)
	arg_37_1.attachment:RemoveListener(WorldMapAttachment.EventUpdateData, self.onUpdateAttachment)
	arg_37_1.attachment:RemoveListener(WorldMapAttachment.EventUpdateLurk, self.onUpdateAttachment)
	self.wsPool:Return(WSMapAttachment.GetResName(arg_37_1.attachment), arg_37_1.transform.gameObject)
	WPool:Return(arg_37_1)

	return
end

function WSMap:NewArtifact(arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = WPool:Get(WSMapArtifact)

	var_38_0.transform:SetParent(arg_38_1.rtArtifacts, false)
	var_38_0:Setup(arg_38_2, self.map.theme, arg_38_3)

	return var_38_0
end

function WSMap:DisposeArtifact(arg_39_1)
	WPool:Return(arg_39_1)

	return
end

function WSMap:GetTerrainEffectParent(arg_40_1)
	if arg_40_1 == WorldMapCell.TerrainStream then
		return self.rtEffectB
	elseif arg_40_1 == WorldMapCell.TerrainWind then
		return self.rtEffectC
	elseif arg_40_1 == WorldMapCell.TerrainIce then
		return self.rtEffectA
	elseif arg_40_1 == WorldMapCell.TerrainPoison then
		return self.rtEffectA
	else
		assert(false, "terrain type error: " .. arg_40_1)
	end

	return
end

function WSMap:NewTerrainEffect(arg_41_1)
	local var_41_0 = WPool:Get(WSMapCellEffect)

	var_41_0.transform = createNewGameObject("mapCellEffect")

	var_41_0.transform:SetParent(self:GetTerrainEffectParent(arg_41_1:GetTerrain()), false)
	var_41_0:Setup(arg_41_1, self.map.theme)

	return var_41_0
end

function WSMap:DisposeTerrainEffect(arg_42_1)
	WPool:Return(arg_42_1)
	Destroy(arg_42_1.transform)

	return
end

function WSMap:GetTerrainEffect(arg_43_1, arg_43_2)
	for iter_43_0, iter_43_1 in ipairs(self.wsTerrainEffects) do
		if iter_43_1.cell.row == arg_43_1 and iter_43_1.cell.column == arg_43_2 then
			return iter_43_1, iter_43_0
		end
	end

	return
end

function WSMap:NewFleet(arg_44_1)
	local var_44_0 = WPool:Get(WSMapFleet)

	var_44_0.transform = self.wsPool:Get((WSMapFleet.GetResName())).transform

	var_44_0.transform:SetParent(self.rtCells, false)
	var_44_0:Setup(arg_44_1, self.map.theme)
	var_44_0.rtRetreat:SetParent(self.rtTop, false)
	arg_44_1:AddListener(WorldMapFleet.EventAddCarry, self.onAddCarry)
	arg_44_1:AddListener(WorldMapFleet.EventRemoveCarry, self.onRemoveCarry)

	return var_44_0
end

function WSMap:DisposeFleet(arg_45_1)
	arg_45_1.fleet:RemoveListener(WorldMapFleet.EventAddCarry, self.onAddCarry)
	arg_45_1.fleet:RemoveListener(WorldMapFleet.EventRemoveCarry, self.onRemoveCarry)
	arg_45_1.rtRetreat:SetParent(arg_45_1.transform, false)
	self.wsPool:Return(WSMapFleet.GetResName(), arg_45_1.transform.gameObject)
	WPool:Return(arg_45_1)

	return
end

function WSMap:NewCarryItem(arg_46_1, arg_46_2)
	local var_46_0 = WPool:Get(WSCarryItem)

	var_46_0.transform = self.wsPool:Get((WSCarryItem.GetResName())).transform

	var_46_0.transform:SetParent(self.rtCells, false)
	var_46_0:Setup(arg_46_1, arg_46_2, self.map.theme)

	return var_46_0
end

function WSMap:DisposeCarryItem(arg_47_1)
	self.wsPool:Return(WSCarryItem.GetResName(), arg_47_1.transform.gameObject)
	WPool:Return(arg_47_1)

	return
end

function WSMap:GetCarryItem(arg_48_1)
	return _.detect(self.wsCarryItems, function(arg_49_0)
		return arg_49_0.carryItem == arg_48_1
	end)
end

function WSMap:FindCarryItems(arg_50_1)
	return _.filter(self.wsCarryItems, function(arg_51_0)
		return arg_51_0.fleet == arg_50_1
	end)
end

function WSMap:GetFleet(arg_52_1)
	arg_52_1 = arg_52_1 or self.map:GetFleet()

	return _.detect(self.wsMapFleets, function(arg_53_0)
		return arg_53_0.fleet == arg_52_1
	end)
end

function WSMap:FindFleet(arg_54_1, arg_54_2)
	return _.detect(self.wsMapFleets, function(arg_55_0)
		return arg_55_0.fleet.row == arg_54_1 and arg_55_0.fleet.column == arg_54_2
	end)
end

function WSMap:GetCell(arg_56_1, arg_56_2)
	return self.wsMapCells[WSMapCell.GetName(arg_56_1, arg_56_2)]
end

function WSMap:GetAttachment(arg_57_1, arg_57_2, arg_57_3)
	return _.detect(self.wsMapAttachments, function(arg_58_0)
		return arg_58_0.attachment.row == arg_57_1 and arg_58_0.attachment.column == arg_57_2 and arg_58_0.attachment.type == arg_57_3
	end)
end

function WSMap:FindAttachments(arg_59_1, arg_59_2)
	return _.filter(self.wsMapAttachments, function(arg_60_0)
		return arg_60_0.attachment.row == arg_59_1 and arg_60_0.attachment.column == arg_59_2
	end)
end

function WSMap:GetQuad(arg_61_1, arg_61_2)
	return self.wsMapQuads[WSMapQuad.GetName(arg_61_1, arg_61_2)]
end

function WSMap:GetItem(arg_62_1, arg_62_2)
	return self.wsMapItems[WSMapItem.GetName(arg_62_1, arg_62_2)]
end

function WSMap:GetTransport(arg_63_1, arg_63_2, arg_63_3)
	return self.wsMapTransports[WSMapTransport.GetName(arg_63_1, arg_63_2, arg_63_3)]
end

function WSMap:UpdateRangeVisible(arg_64_1)
	if self.rangeVisible ~= arg_64_1 then
		self.rangeVisible = arg_64_1

		if arg_64_1 then
			self:DisplayMoveRange()
		else
			self:HideMoveRange()
		end
	end

	return
end

function WSMap:DisplayMoveRange()
	self.displayRangeLines = {}

	local var_65_0 = self.map:GetFleet()
	local var_65_1 = 0

	for iter_65_0, iter_65_1 in ipairs((nowWorld():GetMoveRange(var_65_0))) do
		local var_65_2 = self:GetQuad(iter_65_1.row, iter_65_1.column)

		setImageAlpha(var_65_2.rtWalkQuad, math.pow(0.75, (iter_65_1.stay or nil) and (iter_65_1.stay - 1 or 0)))
		setLocalScale(var_65_2.rtWalkQuad, Vector3.zero)

		local var_65_3 = ManhattonDist(var_65_0, iter_65_1)

		var_65_1 = math.max(var_65_1, var_65_3)

		local var_65_4 = {
			line = iter_65_1
		}

		function var_65_4.func()
			var_65_4.uid = LeanTween.scale(var_65_2.rtWalkQuad, Vector3.one, 0.2):setEase(LeanTweenType.easeInOutSine).uniqueId

			self.wsTimer:AddInMapTween(var_65_4.uid)

			return
		end

		self.displayRangeLines[var_65_3] = self.displayRangeLines[var_65_3] or {}

		table.insert(self.displayRangeLines[var_65_3], var_65_4)
	end

	if var_65_1 > 0 then
		local var_65_5 = 0

		self.displayRangeTimer = self.wsTimer:AddInMapTimer(function()
			var_65_5 = var_65_5 + 1

			if self.displayRangeLines[var_65_5] then
				for iter_67_0, iter_67_1 in ipairs(self.displayRangeLines[var_65_5]) do
					iter_67_1.func()
				end
			end

			return
		end, 0.1, var_65_1)

		self.displayRangeTimer:Start()
	end

	return
end

function WSMap:HideMoveRange()
	if self.displayRangeTimer then
		self.wsTimer:RemoveInMapTimer(self.displayRangeTimer)

		self.displayRangeTimer = nil
	end

	if self.displayRangeLines then
		for iter_68_0, iter_68_1 in pairs(self.displayRangeLines) do
			for iter_68_2, iter_68_3 in ipairs(iter_68_1) do
				if iter_68_3.uid then
					self.wsTimer:RemoveInMapTween(iter_68_3.uid)
				end

				local var_68_0 = self:GetQuad(iter_68_3.line.row, iter_68_3.line.column)

				setImageAlpha(var_68_0.rtWalkQuad, 0)
				setLocalScale(var_68_0.rtWalkQuad, Vector3.one)
			end
		end

		self.displayRangeLines = nil
	end

	return
end

function WSMap:MovePath(arg_69_1, arg_69_2, arg_69_3, arg_69_4, arg_69_5)
	local var_69_1 = _.map(arg_69_2, function(arg_70_0)
		return self:GetQuad(arg_70_0.row, arg_70_0.column)
	end)
	local var_69_2

	if arg_69_5 then
		var_69_2 = WPool:Get(WSMapEffect)
		var_69_2.transform = createNewGameObject("mapEffect")

		var_69_2.transform:SetParent(arg_69_1.transform, false)

		var_69_2.transform.anchoredPosition3D = Vector3.zero
		var_69_2.transform.localEulerAngles = Vector3(self.map.theme.angle, 0, 0)
		var_69_2.modelOrder = arg_69_1.modelOrder

		var_69_2:Setup(WorldConst.GetWindEffect())
		var_69_2:Load()
	end

	local var_69_3 = 0

	for iter_69_0, iter_69_1 in ipairs(var_69_1) do
		LeanTween.cancel(iter_69_1.rtWalkQuad)
		setLocalScale(iter_69_1.rtWalkQuad, Vector3.one)
		setImageAlpha(iter_69_1.rtWalkQuad, 0)
		LeanTween.alpha(iter_69_1.rtWalkQuad, 1, arg_69_2[iter_69_0].duration / 2):setDelay(var_69_3)

		var_69_3 = var_69_3 + arg_69_2[iter_69_0].duration / 2
	end

	local var_69_4 = 0

	local function var_69_8()
		self.wsMapPath:RemoveListener(WSMapPath.EventArrivedStep, var_69_5)
		self.wsMapPath:RemoveListener(WSMapPath.EventArrived, var_69_8)
		_.each(var_69_1, function(arg_73_0)
			LeanTween.cancel(arg_73_0.rtWalkQuad)
			setImageAlpha(arg_73_0.rtWalkQuad, 0)

			return
		end)

		if arg_69_5 then
			WPool:Return(var_69_2)
			Destroy(var_69_2.transform)
		end

		return
	end

	self.wsMapPath:AddListener(WSMapPath.EventArrivedStep, nil)
	self.wsMapPath:AddListener(WSMapPath.EventArrived, var_69_8)
	self.wsMapPath:UpdateObject(arg_69_1)
	self.wsMapPath:UpdateAction((arg_69_5 or nil) and (WorldConst.ActionDrag or WorldConst.ActionMove))
	self.wsMapPath:UpdateDirType(arg_69_4)
	self.wsMapPath:StartMove(arg_69_3, arg_69_2, arg_69_5 and 100 or 0)

	return self.wsMapPath
end

function WSMap:FlushFleets()
	self:FlushFleetVisibility()
	self:FlushFleetRetreatBtn()
	self:FlushEnemyFightingMark()
	self:FlushTransportDisplay()

	local var_74_0 = self.map:GetFleet()

	_.each(self.wsMapFleets, function(arg_75_0)
		arg_75_0:UpdateSelected(arg_75_0.fleet == var_74_0)

		return
	end)

	return
end

function WSMap:FlushFleetRetreatBtn()
	local var_76_0 = self.map:GetFleet()

	_.each(self.wsMapFleets, function(arg_77_0)
		local var_77_0 = arg_77_0.fleet
		local var_77_1 = self.map:GetCell(arg_77_0.fleet.row, arg_77_0.fleet.column)
		local var_77_2 = var_77_1:ExistEnemy() and var_77_0 == var_76_0 and not WorldConst.IsWorldGuideEnemyId(var_77_1:GetStageEnemy().id)

		setActive(arg_77_0.rtRetreat, var_77_2)

		if var_77_2 then
			arg_77_0.rtRetreat.localPosition = self.rtTop:InverseTransformPoint(arg_77_0.transform.position) + Vector3(89, 0, 0)
			arg_77_0.rtRetreat.localEulerAngles = Vector3(-self.map.theme.angle, 0, 0)

			arg_77_0.rtRetreat:SetAsLastSibling()
		end

		return
	end)

	return
end

function WSMap:FlushEnemyFightingMark()
	_.each(self.wsMapAttachments, function(arg_79_0)
		if WorldMapAttachment.IsEnemyType(arg_79_0.attachment.type) then
			arg_79_0:UpdateIsFighting(self.map:ExistFleet(arg_79_0.attachment.row, arg_79_0.attachment.column))
		end

		return
	end)

	return
end

function WSMap:FlushTransportVisibleByFleet()
	for iter_80_0, iter_80_1 in pairs(self.wsMapTransports) do
		if not _.any(self.wsMapFleets, function(arg_81_0)
			return ManhattonDist({
				row = arg_81_0.fleet.row,
				column = arg_81_0.fleet.column
			}, {
				row = iter_80_1.row,
				column = iter_80_1.column
			}) <= 1
		end) then
			self:DisposeTransport(iter_80_1)

			self.wsMapTransports[iter_80_0] = nil
		end
	end

	_.each(self.wsMapFleets, function(arg_82_0)
		for iter_82_0 = WorldConst.DirNone, WorldConst.DirLeft do
			local var_82_0 = WorldConst.DirToLine(iter_82_0)
			local var_82_1 = self.map:GetCell(arg_82_0.fleet.row + var_82_0.row, arg_82_0.fleet.column + var_82_0.column)

			if var_82_1 then
				for iter_82_1 = WorldConst.DirUp, WorldConst.DirLeft do
					if bit.band(var_82_1.dir, bit.lshift(1, iter_82_1)) > 0 then
						local var_82_2 = WSMapTransport.GetName(var_82_1.row, var_82_1.column, iter_82_1)
						local var_82_3 = self.wsMapTransports[var_82_2]

						if not self.wsMapTransports[var_82_2] then
							var_82_3 = self:NewTransport(var_82_1.row, var_82_1.column, iter_82_1)
							self.wsMapTransports[var_82_2] = var_82_3

							setActive(var_82_3.rtClick, false)
						end

						var_82_3:UpdateAlpha(_.any(self.wsMapFleets, function(arg_83_0)
							return arg_83_0.fleet.row == var_82_1.row and arg_83_0.fleet.column == var_82_1.column
						end) and 1 or 0)
						setActive(var_82_3.rtForbid, self.map.config.is_transfer == 0)
					end
				end
			end
		end

		return
	end)

	return
end

function WSMap:FlushFleetVisibility()
	underscore.each(self.wsMapFleets, function(arg_85_0)
		local var_85_0 = self.map:GetCell(arg_85_0.fleet.row, arg_85_0.fleet.column)
		local var_85_1 = not var_85_0:ExistEnemy() and not var_85_0:InFog()

		arg_85_0:UpdateActive(var_85_1)
		_.each(self:FindCarryItems(arg_85_0.fleet), function(arg_86_0)
			arg_86_0:UpdateActive(var_85_1)

			return
		end)

		return
	end)

	return
end

function WSMap:UpdateSubmarineSupport()
	_.each(self.wsMapFleets, function(arg_88_0)
		arg_88_0:UpdateSubmarineSupport()

		return
	end)

	return
end

function WSMap:FlushMovingAttachment(arg_89_1)
	if arg_89_1.transform.parent ~= self.rtCells then
		arg_89_1.transform:SetParent(self.rtCells, true)
	end

	local var_89_0 = {
		row = arg_89_1.attachment.row,
		column = arg_89_1.attachment.column
	}

	if WorldMapAttachment.IsEnemyType(arg_89_1.attachment.type) then
		local var_89_1 = self:FindFleet(var_89_0.row, var_89_0.column)

		if var_89_1 then
			var_89_1:UpdateActive(true)
			setActive(var_89_1.rtRetreat, false)
			arg_89_1:UpdateIsFighting(false)
		end
	end

	self:FlushMovingAttachmentOrder(arg_89_1, var_89_0)

	return
end

function WSMap:FlushMovingAttachmentOrder(arg_90_1, arg_90_2)
	local var_90_0 = self:GetCell(arg_90_2.row, arg_90_2.column).cell

	setActive(arg_90_1.transform, var_90_0:GetInFOV() and not var_90_0:InFog())
	arg_90_1:SetModelOrder(arg_90_1.attachment:GetModelOrder(), arg_90_2.row)

	return
end

function WSMap:UpdateTransportDisplay(arg_91_1)
	if self.transportDisplay ~= arg_91_1 then
		self.transportDisplay = arg_91_1

		self:FlushTransportDisplay()
	end

	return
end

function WSMap:FlushTransportDisplay()
	if self.transportDisplay == WorldConst.TransportDisplayNormal then
		self:FlushTransportVisibleByFleet()
	else
		self:FlushTransportVisibleByState()
	end

	return
end

function WSMap:FlushTransportVisibleByState()
	local var_93_0 = self.map:GetCellsInFOV()

	for iter_93_0, iter_93_1 in pairs(self.wsMapTransports) do
		if not _.any(var_93_0, function(arg_94_0)
			return arg_94_0.row == iter_93_1.row and arg_94_0.column == iter_93_1.column
		end) then
			self:DisposeTransport(iter_93_1)

			self.wsMapTransports[iter_93_0] = nil
		end
	end

	local var_93_1 = WorldConst.DirUp

	_.each(var_93_0, function(arg_95_0)
		for iter_95_0 = var_93_1, WorldConst.DirLeft do
			if bit.band(arg_95_0.dir, bit.lshift(1, iter_95_0)) > 0 then
				local var_95_0 = WSMapTransport.GetName(arg_95_0.row, arg_95_0.column, iter_95_0)
				local var_95_1 = self.wsMapTransports[var_95_0]

				if not self.wsMapTransports[var_95_0] then
					var_95_1 = self:NewTransport(arg_95_0.row, arg_95_0.column, iter_95_0)
					self.wsMapTransports[var_95_0] = var_95_1
				end

				setActive(var_95_1.rtForbid, self.transportDisplay == WorldConst.TransportDisplayGuideForbid)
				setActive(var_95_1.rtDanger, self.transportDisplay == WorldConst.TransportDisplayGuideDanger)
				var_95_1:UpdateAlpha(1)
			end
		end

		return
	end)

	return
end

function WSMap:NewTargetArrow()
	self.rtTargetArrow = self.wsPool:Get("arrow_tpl").transform

	setActive(self.rtTargetArrow, false)

	return
end

function WSMap:DisplayTargetArrow(arg_97_1, arg_97_2)
	self.rtTargetArrow:SetParent(self:GetCell(arg_97_1, arg_97_2).transform, false)

	self.rtTargetArrow.anchoredPosition = Vector2.zero
	self.rtTargetArrow.localEulerAngles = Vector3(-self.map.theme.angle, 0, 0)
	self.rtTargetArrow:GetComponent(typeof(Canvas)).sortingOrder = WorldConst.LOFleet + defaultValue(arg_97_1, 0) * 10

	setActive(self.rtTargetArrow, true)

	return
end

function WSMap:HideTargetArrow()
	self.rtTargetArrow:SetParent(self.transform, false)
	setActive(self.rtTargetArrow, false)

	return
end

function WSMap:ClearTargetArrow()
	self.wsPool:Return("arrow_tpl", self.rtTargetArrow)

	return
end

function WSMap:ShowScannerMap(arg_100_1)
	for iter_100_0, iter_100_1 in pairs(self.wsMapQuads) do
		if arg_100_1 then
			iter_100_1:UpdateStatic(true, true)
		else
			iter_100_1:UpdateStatic(false)
		end
	end

	return
end

return WSMap
