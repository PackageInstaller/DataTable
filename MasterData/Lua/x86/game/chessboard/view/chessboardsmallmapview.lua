local ChessBoardSmallMapView = class("ChessBoardSmallMapView", ReduxView)

function ChessBoardSmallMapView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_MapPreviewPopUI"
end

function ChessBoardSmallMapView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardSmallMapView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardSmallMapView:InitUI()
	self:BindCfgUI()

	self.curSelectType_ = 0
	self.curSelectID_ = 0
	self.girdImageList_ = {}
	self.thingImageList_ = {}
	self.NPCImageList_ = {}
	self.selectTransList_ = {}
	self.selectItemList_ = {}
	self.gridTypeList_ = {}
	self.playerTypeList_ = {}
	self.specialityTypeList_ = {}
	self.selectItemClick_ = handler(self, self.OnSelectItemClick)
end

function ChessBoardSmallMapView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function ChessBoardSmallMapView:OnEnter()
	self.curMapData_ = ChessBoardLuaBridge.GetCurSmallMapData()

	self:RefreshSmallMap()
	self:RefreshSelectItem()
end

function ChessBoardSmallMapView:RefreshSmallMap()
	self.gridTypeList_ = {}
	self.playerTypeList_ = {}
	self.specialityTypeList_ = {}

	local var_8_0, var_8_1 = ChessBoardData:GetMapWidthAndHeight()
	local var_8_2 = {}

	for iter_8_0 = 0, self.curMapData_.typeIDList.Length - 1 do
		local var_8_3 = ChessBoardHexCfg[self.curMapData_.typeIDList[iter_8_0]]

		if ChessBoardHexCfg[self.curMapData_.typeIDList[iter_8_0]].small_map_icon == "" then
			if self.girdImageList_[iter_8_0] then
				SetActive(self.girdImageList_[iter_8_0].gameObject, false)
			end

			if self.curMapData_.thingTypeIDList[iter_8_0] > 0 then
				local var_8_4 = ChessBoardThingCfg[self.curMapData_.thingTypeIDList[iter_8_0]]

				if ChessBoardThingCfg[self.curMapData_.thingTypeIDList[iter_8_0]].small_map_icon == "" then
					if self.girdImageList_[iter_8_0] then
						SetActive(self.girdImageList_[iter_8_0].gameObject, false)
					end
				else
					local var_8_5, var_8_6 = ChessBoardTools.CSharpMapIndexToXZ(iter_8_0, var_8_0)
					local var_8_7 = ChessBoardTools.AxialToCubeCoord(var_8_5, var_8_6)

					var_8_2.x = (var_8_7.z + -var_8_7.x) * 25
					var_8_2.y = -var_8_7.y * 40

					if self.thingImageList_[iter_8_0] then
						SetActive(self.thingImageList_[iter_8_0].gameObject, true)
					else
						self.thingImageList_[iter_8_0] = Object.Instantiate(self.mapPiece_, self.mapTrans_):GetComponent("Image")

						SetActive(self.thingImageList_[iter_8_0].gameObject, true)
					end

					self.thingImageList_[iter_8_0].transform.localPosition = Vector3.New(var_8_2.x, var_8_2.y, 0)
					self.thingImageList_[iter_8_0].sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", var_8_4.small_map_icon)
				end
			elseif self.thingImageList_[iter_8_0] then
				SetActive(self.thingImageList_[iter_8_0].gameObject, false)
			end
		else
			local var_8_8, var_8_9 = ChessBoardTools.CSharpMapIndexToXZ(iter_8_0, var_8_0)
			local var_8_10 = ChessBoardTools.AxialToCubeCoord(var_8_8, var_8_9)

			if self.girdImageList_[iter_8_0] then
				SetActive(self.girdImageList_[iter_8_0].gameObject, true)
			else
				self.girdImageList_[iter_8_0] = Object.Instantiate(self.mapPiece_, self.mapTrans_):GetComponent("Image")

				SetActive(self.girdImageList_[iter_8_0].gameObject, true)
			end

			var_8_2.x = (var_8_10.z + -var_8_10.x) * 25
			var_8_2.y = -var_8_10.y * 40
			self.girdImageList_[iter_8_0].transform.localPosition = Vector3.New(var_8_2.x, var_8_2.y, 0)
			self.girdImageList_[iter_8_0].sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", var_8_3.small_map_icon)
			self.gridTypeList_[self.curMapData_.typeIDList[iter_8_0]] = true

			if self.curMapData_.thingTypeIDList[iter_8_0] > 0 then
				local var_8_11 = ChessBoardThingCfg[self.curMapData_.thingTypeIDList[iter_8_0]]

				if ChessBoardThingCfg[self.curMapData_.thingTypeIDList[iter_8_0]].small_map_icon == "" then
					if self.thingImageList_[iter_8_0] then
						SetActive(self.thingImageList_[iter_8_0].gameObject, false)
					end
				else
					if self.thingImageList_[iter_8_0] then
						SetActive(self.thingImageList_[iter_8_0].gameObject, true)
					else
						self.thingImageList_[iter_8_0] = Object.Instantiate(self.mapPiece_, self.mapTrans_):GetComponent("Image")

						SetActive(self.thingImageList_[iter_8_0].gameObject, true)
					end

					self.thingImageList_[iter_8_0].transform.localPosition = Vector3.New(var_8_2.x, var_8_2.y, 0)
					self.thingImageList_[iter_8_0].sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", var_8_11.small_map_icon)
				end
			elseif self.thingImageList_[iter_8_0] then
				SetActive(self.thingImageList_[iter_8_0].gameObject, false)
			end
		end
	end

	self.playerTypeList_[1] = 0

	local var_8_12 = manager.ChessBoardManager.NPCManager_:GetNPCTypeAndPosList()

	for iter_8_1, iter_8_2 in ipairs(var_8_12) do
		if self.NPCImageList_[iter_8_1] then
			SetActive(self.NPCImageList_[iter_8_1].gameObject, true)
		else
			self.NPCImageList_[iter_8_1] = Object.Instantiate(self.NPCPiece_, self.mapTrans_):GetComponent("Image")

			SetActive(self.NPCImageList_[iter_8_1].gameObject, true)
		end

		local var_8_13 = ChessBoardTools.AxialToCubeCoord(iter_8_2.Pos.x, iter_8_2.Pos.z)

		var_8_2.x = (var_8_13.z + -var_8_13.x) * 25
		var_8_2.y = -var_8_13.y * 40
		self.NPCImageList_[iter_8_1].transform.localPosition = Vector3.New(var_8_2.x, var_8_2.y, 0)
		self.NPCImageList_[iter_8_1].sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", ChessBoardNPCPoolCfg[iter_8_2.NPCtype].small_map_icon)

		self.NPCImageList_[iter_8_1].transform:SetAsLastSibling()

		if not table.indexof(self.playerTypeList_, iter_8_2.NPCtype) then
			table.insert(self.playerTypeList_, iter_8_2.NPCtype)
		end
	end

	for iter_8_3 = #var_8_12 + 1, #self.NPCImageList_ do
		if self.NPCImageList_[iter_8_3] then
			SetActive(self.NPCImageList_[iter_8_3].gameObject, false)
		end
	end

	local var_8_14, var_8_15 = manager.ChessBoardManager.heroEntity_:GetPosAndDir()
	local var_8_16 = ChessBoardTools.AxialToCubeCoord(var_8_14.x, var_8_14.z)

	var_8_2.x = (var_8_16.z + -var_8_16.x) * 25
	var_8_2.y = -var_8_16.y * 40
	self.heroPieceTrans_.localPosition = Vector3.New(var_8_2.x, var_8_2.y, 0)

	self.heroPieceTrans_:SetAsLastSibling()

	for iter_8_4, iter_8_5 in pairs(ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapData().mapId].small_map_speciality) do
		table.insert(self.specialityTypeList_, iter_8_5[1])
	end
end

function ChessBoardSmallMapView:RefreshSelectItem()
	local var_9_0 = 1
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in pairs(self.gridTypeList_) do
		table.insert(var_9_1, iter_9_0)
	end

	table.sort(var_9_1, function(arg_10_0, arg_10_1)
		if ChessBoardHexCfg[arg_10_0].weight < ChessBoardHexCfg[arg_10_1].weight then
			return true
		else
			return false
		end
	end)

	for iter_9_2, iter_9_3 in pairs(var_9_1) do
		if self.selectItemList_[var_9_0] == nil then
			self.selectItemList_[var_9_0] = ChessBoardSmallMapSelectItem.New((Object.Instantiate(self.selectItemGo_)))
		end

		self.selectItemList_[var_9_0]:SetActive(true)
		self.selectItemList_[var_9_0]:SetParent(self.gridItemTrans_)
		self.selectItemList_[var_9_0]:SetData(ChessBoardConst.SMALL_MAP_TYPE.GRID, iter_9_3, self.selectItemClick_)

		var_9_0 = var_9_0 + 1
	end

	for iter_9_4, iter_9_5 in ipairs(self.playerTypeList_) do
		if self.selectItemList_[var_9_0] == nil then
			self.selectItemList_[var_9_0] = ChessBoardSmallMapSelectItem.New((Object.Instantiate(self.selectItemGo_)))
		end

		self.selectItemList_[var_9_0]:SetActive(true)
		self.selectItemList_[var_9_0]:SetParent(self.playerItemTrans_)
		self.selectItemList_[var_9_0]:SetData(ChessBoardConst.SMALL_MAP_TYPE.PLAYER, iter_9_5, self.selectItemClick_)

		var_9_0 = var_9_0 + 1
	end

	if #self.specialityTypeList_ > 0 then
		SetActive(self.specialGo_, true)

		for iter_9_6, iter_9_7 in ipairs(self.specialityTypeList_) do
			if self.selectItemList_[var_9_0] == nil then
				self.selectItemList_[var_9_0] = ChessBoardSmallMapSelectItem.New((Object.Instantiate(self.selectItemGo_)))
			end

			self.selectItemList_[var_9_0]:SetActive(true)
			self.selectItemList_[var_9_0]:SetParent(self.specialItemTrans_)
			self.selectItemList_[var_9_0]:SetData(ChessBoardConst.SMALL_MAP_TYPE.SPECIAL, iter_9_7, self.selectItemClick_)

			var_9_0 = var_9_0 + 1
		end
	else
		SetActive(self.specialGo_, false)
	end

	for iter_9_8 = var_9_0, #self.selectItemList_ do
		self.selectItemList_[iter_9_8]:SetActive(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

	for iter_9_9, iter_9_10 in ipairs(self.selectItemList_) do
		iter_9_10:FixScaleAndPos()
	end

	self:OnSelectItemClick(ChessBoardConst.SMALL_MAP_TYPE.GRID, var_9_1[1])
end

function ChessBoardSmallMapView:OnSelectItemClick(arg_11_1, arg_11_2)
	if self.curSelectType_ == arg_11_1 and self.curSelectID_ == arg_11_2 then
		return
	else
		self.curSelectType_ = arg_11_1
		self.curSelectID_ = arg_11_2

		for iter_11_0, iter_11_1 in pairs(self.selectItemList_) do
			iter_11_1:RefreshSelect(self.curSelectType_, self.curSelectID_)
		end

		if self.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.NONE then
			self.desText_.text = ""
		elseif self.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.GRID then
			self.desText_.text = ChessBoardHexCfg[self.curSelectID_].dec
		elseif self.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.PLAYER then
			self.desText_.text = self.curSelectID_ == 0 and ChessBoardTools.GetChessBoardGameSetting("chessboard_small_map_hero_des") or ChessBoardNPCPoolCfg[self.curSelectID_].dec
		elseif self.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.SPECIAL then
			for iter_11_2, iter_11_3 in pairs((ChessBoardTools.GetChessBoardGameSetting("chessboard_small_map_speciality_icon"))) do
				if iter_11_3[1] == self.curSelectID_ then
					self.desText_.text = GetTips(iter_11_3[4])

					break
				end
			end
		end

		local var_11_0 = {}
		local var_11_2, var_11_3 = ChessBoardData:GetMapWidthAndHeight()
		local var_11_4 = {}

		if self.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.NONE then
			for iter_11_4, iter_11_5 in pairs(self.selectTransList_) do
				SetActive(iter_11_5.gameObject, false)
			end
		elseif self.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.GRID then
			for iter_11_6 = 0, self.curMapData_.typeIDList.Length - 1 do
				if self.curMapData_.typeIDList[iter_11_6] == self.curSelectID_ then
					local var_11_5, var_11_6 = ChessBoardTools.CSharpMapIndexToXZ(iter_11_6, var_11_2)
					local var_11_7 = ChessBoardTools.AxialToCubeCoord(var_11_5, var_11_6)

					var_11_0.x = (var_11_7.z + -var_11_7.x) * 25
					var_11_0.y = -var_11_7.y * 40

					table.insert(var_11_4, {
						var_11_0.x,
						var_11_0.y
					})
				end
			end
		elseif self.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.PLAYER then
			if self.curSelectID_ == 0 then
				local var_11_8, var_11_9 = manager.ChessBoardManager.heroEntity_:GetPosAndDir()
				local var_11_10 = ChessBoardTools.AxialToCubeCoord(var_11_8.x, var_11_8.z)

				var_11_0.x = (var_11_10.z + -var_11_10.x) * 25
				var_11_0.y = -var_11_10.y * 40

				table.insert(var_11_4, {
					var_11_0.x,
					var_11_0.y
				})
			else
				for iter_11_7, iter_11_8 in ipairs((manager.ChessBoardManager.NPCManager_:GetNPCTypeAndPosList())) do
					if iter_11_8.NPCtype == self.curSelectID_ then
						local var_11_11 = ChessBoardTools.AxialToCubeCoord(iter_11_8.Pos.x, iter_11_8.Pos.z)

						var_11_0.x = (var_11_11.z + -var_11_11.x) * 25
						var_11_0.y = -var_11_11.y * 40

						table.insert(var_11_4, {
							var_11_0.x,
							var_11_0.y
						})
					end
				end
			end
		elseif self.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.SPECIAL then
			local var_11_12

			for iter_11_9, iter_11_10 in pairs(ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapData().mapId].small_map_speciality) do
				if iter_11_10[1] == self.curSelectID_ then
					var_11_12 = iter_11_10[2]

					break
				end
			end

			for iter_11_11, iter_11_12 in pairs(var_11_12) do
				local var_11_13 = ChessBoardTools.AxialToCubeCoord(iter_11_12[1], iter_11_12[2])

				var_11_0.x = (var_11_13.z + -var_11_13.x) * 25
				var_11_0.y = -var_11_13.y * 40

				table.insert(var_11_4, {
					var_11_0.x,
					var_11_0.y
				})
			end
		end

		for iter_11_13, iter_11_14 in pairs(self.selectTransList_) do
			SetActive(iter_11_14.gameObject, false)
		end

		for iter_11_15, iter_11_16 in pairs(var_11_4) do
			if self.selectTransList_[iter_11_15] then
				SetActive(self.selectTransList_[iter_11_15].gameObject, true)
			else
				self.selectTransList_[iter_11_15] = Object.Instantiate(self.selectPiece_, self.mapTrans_).transform

				SetActive(self.selectTransList_[iter_11_15].gameObject, true)
			end

			self.selectTransList_[iter_11_15].localPosition = Vector3.New(iter_11_16[1], iter_11_16[2], 0)

			self.selectTransList_[iter_11_15]:SetAsLastSibling()
		end
	end
end

function ChessBoardSmallMapView:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.girdImageList_) do
		Object.Destroy(iter_12_1.gameObject)
	end

	self.girdImageList_ = {}

	for iter_12_2, iter_12_3 in pairs(self.thingImageList_) do
		Object.Destroy(iter_12_3.gameObject)
	end

	self.thingImageList_ = {}

	for iter_12_4, iter_12_5 in pairs(self.NPCImageList_) do
		Object.Destroy(iter_12_5.gameObject)
	end

	self.NPCImageList_ = {}

	for iter_12_6, iter_12_7 in pairs(self.selectTransList_) do
		Object.Destroy(iter_12_7.gameObject)
	end

	self.selectTransList_ = {}

	for iter_12_8, iter_12_9 in pairs(self.selectItemList_) do
		iter_12_9:Dispose()
	end

	self.selectItemList_ = {}
	self.selectItemClick_ = nil

	self.super.Dispose(self)
end

return ChessBoardSmallMapView
