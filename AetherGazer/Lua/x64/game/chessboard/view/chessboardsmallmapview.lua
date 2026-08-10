local var_0_0 = class("ChessBoardSmallMapView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_MapPreviewPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.curSelectType_ = 0
	arg_4_0.curSelectID_ = 0
	arg_4_0.girdImageList_ = {}
	arg_4_0.thingImageList_ = {}
	arg_4_0.NPCImageList_ = {}
	arg_4_0.selectTransList_ = {}
	arg_4_0.selectItemList_ = {}
	arg_4_0.gridTypeList_ = {}
	arg_4_0.playerTypeList_ = {}
	arg_4_0.specialityTypeList_ = {}
	arg_4_0.selectItemClick_ = handler(arg_4_0, arg_4_0.OnSelectItemClick)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.curMapData_ = ChessBoardLuaBridge.GetCurSmallMapData()

	arg_7_0:RefreshSmallMap()
	arg_7_0:RefreshSelectItem()
end

function var_0_0.RefreshSmallMap(arg_8_0)
	arg_8_0.gridTypeList_ = {}
	arg_8_0.playerTypeList_ = {}
	arg_8_0.specialityTypeList_ = {}

	local var_8_0, var_8_1 = ChessBoardData:GetMapWidthAndHeight()
	local var_8_2 = {}

	for iter_8_0 = 0, arg_8_0.curMapData_.typeIDList.Length - 1 do
		local var_8_3 = ChessBoardHexCfg[arg_8_0.curMapData_.typeIDList[iter_8_0]]

		if var_8_3.small_map_icon == "" then
			if arg_8_0.girdImageList_[iter_8_0] then
				SetActive(arg_8_0.girdImageList_[iter_8_0].gameObject, false)
			end

			if arg_8_0.curMapData_.thingTypeIDList[iter_8_0] > 0 then
				local var_8_4 = ChessBoardThingCfg[arg_8_0.curMapData_.thingTypeIDList[iter_8_0]]

				if var_8_4.small_map_icon == "" then
					if arg_8_0.girdImageList_[iter_8_0] then
						SetActive(arg_8_0.girdImageList_[iter_8_0].gameObject, false)
					end
				else
					local var_8_5, var_8_6 = ChessBoardTools.CSharpMapIndexToXZ(iter_8_0, var_8_0)
					local var_8_7 = ChessBoardTools.AxialToCubeCoord(var_8_5, var_8_6)

					var_8_2.x = (var_8_7.z + -var_8_7.x) * 25
					var_8_2.y = -var_8_7.y * 40

					if arg_8_0.thingImageList_[iter_8_0] then
						SetActive(arg_8_0.thingImageList_[iter_8_0].gameObject, true)
					else
						local var_8_8 = Object.Instantiate(arg_8_0.mapPiece_, arg_8_0.mapTrans_)

						arg_8_0.thingImageList_[iter_8_0] = var_8_8:GetComponent("Image")

						SetActive(arg_8_0.thingImageList_[iter_8_0].gameObject, true)
					end

					arg_8_0.thingImageList_[iter_8_0].transform.localPosition = Vector3.New(var_8_2.x, var_8_2.y, 0)
					arg_8_0.thingImageList_[iter_8_0].sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", var_8_4.small_map_icon)
				end
			elseif arg_8_0.thingImageList_[iter_8_0] then
				SetActive(arg_8_0.thingImageList_[iter_8_0].gameObject, false)
			end
		else
			local var_8_9, var_8_10 = ChessBoardTools.CSharpMapIndexToXZ(iter_8_0, var_8_0)
			local var_8_11 = ChessBoardTools.AxialToCubeCoord(var_8_9, var_8_10)

			if arg_8_0.girdImageList_[iter_8_0] then
				SetActive(arg_8_0.girdImageList_[iter_8_0].gameObject, true)
			else
				local var_8_12 = Object.Instantiate(arg_8_0.mapPiece_, arg_8_0.mapTrans_)

				arg_8_0.girdImageList_[iter_8_0] = var_8_12:GetComponent("Image")

				SetActive(arg_8_0.girdImageList_[iter_8_0].gameObject, true)
			end

			var_8_2.x = (var_8_11.z + -var_8_11.x) * 25
			var_8_2.y = -var_8_11.y * 40
			arg_8_0.girdImageList_[iter_8_0].transform.localPosition = Vector3.New(var_8_2.x, var_8_2.y, 0)
			arg_8_0.girdImageList_[iter_8_0].sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", var_8_3.small_map_icon)
			arg_8_0.gridTypeList_[arg_8_0.curMapData_.typeIDList[iter_8_0]] = true

			if arg_8_0.curMapData_.thingTypeIDList[iter_8_0] > 0 then
				local var_8_13 = ChessBoardThingCfg[arg_8_0.curMapData_.thingTypeIDList[iter_8_0]]

				if var_8_13.small_map_icon == "" then
					if arg_8_0.thingImageList_[iter_8_0] then
						SetActive(arg_8_0.thingImageList_[iter_8_0].gameObject, false)
					end
				else
					if arg_8_0.thingImageList_[iter_8_0] then
						SetActive(arg_8_0.thingImageList_[iter_8_0].gameObject, true)
					else
						local var_8_14 = Object.Instantiate(arg_8_0.mapPiece_, arg_8_0.mapTrans_)

						arg_8_0.thingImageList_[iter_8_0] = var_8_14:GetComponent("Image")

						SetActive(arg_8_0.thingImageList_[iter_8_0].gameObject, true)
					end

					arg_8_0.thingImageList_[iter_8_0].transform.localPosition = Vector3.New(var_8_2.x, var_8_2.y, 0)
					arg_8_0.thingImageList_[iter_8_0].sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", var_8_13.small_map_icon)
				end
			elseif arg_8_0.thingImageList_[iter_8_0] then
				SetActive(arg_8_0.thingImageList_[iter_8_0].gameObject, false)
			end
		end
	end

	arg_8_0.playerTypeList_[1] = 0

	local var_8_15 = manager.ChessBoardManager.NPCManager_:GetNPCTypeAndPosList()

	for iter_8_1, iter_8_2 in ipairs(var_8_15) do
		if arg_8_0.NPCImageList_[iter_8_1] then
			SetActive(arg_8_0.NPCImageList_[iter_8_1].gameObject, true)
		else
			local var_8_16 = Object.Instantiate(arg_8_0.NPCPiece_, arg_8_0.mapTrans_)

			arg_8_0.NPCImageList_[iter_8_1] = var_8_16:GetComponent("Image")

			SetActive(arg_8_0.NPCImageList_[iter_8_1].gameObject, true)
		end

		local var_8_17 = ChessBoardTools.AxialToCubeCoord(iter_8_2.Pos.x, iter_8_2.Pos.z)

		var_8_2.x = (var_8_17.z + -var_8_17.x) * 25
		var_8_2.y = -var_8_17.y * 40
		arg_8_0.NPCImageList_[iter_8_1].transform.localPosition = Vector3.New(var_8_2.x, var_8_2.y, 0)
		arg_8_0.NPCImageList_[iter_8_1].sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", ChessBoardNPCPoolCfg[iter_8_2.NPCtype].small_map_icon)

		arg_8_0.NPCImageList_[iter_8_1].transform:SetAsLastSibling()

		if not table.indexof(arg_8_0.playerTypeList_, iter_8_2.NPCtype) then
			table.insert(arg_8_0.playerTypeList_, iter_8_2.NPCtype)
		end
	end

	for iter_8_3 = #var_8_15 + 1, #arg_8_0.NPCImageList_ do
		if arg_8_0.NPCImageList_[iter_8_3] then
			SetActive(arg_8_0.NPCImageList_[iter_8_3].gameObject, false)
		end
	end

	local var_8_18, var_8_19 = manager.ChessBoardManager.heroEntity_:GetPosAndDir()
	local var_8_20 = ChessBoardTools.AxialToCubeCoord(var_8_18.x, var_8_18.z)

	var_8_2.x = (var_8_20.z + -var_8_20.x) * 25
	var_8_2.y = -var_8_20.y * 40
	arg_8_0.heroPieceTrans_.localPosition = Vector3.New(var_8_2.x, var_8_2.y, 0)

	arg_8_0.heroPieceTrans_:SetAsLastSibling()

	local var_8_21 = ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapData().mapId]

	for iter_8_4, iter_8_5 in pairs(var_8_21.small_map_speciality) do
		table.insert(arg_8_0.specialityTypeList_, iter_8_5[1])
	end
end

function var_0_0.RefreshSelectItem(arg_9_0)
	local var_9_0 = 1
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0.gridTypeList_) do
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
		if arg_9_0.selectItemList_[var_9_0] == nil then
			local var_9_2 = Object.Instantiate(arg_9_0.selectItemGo_)

			arg_9_0.selectItemList_[var_9_0] = ChessBoardSmallMapSelectItem.New(var_9_2)
		end

		arg_9_0.selectItemList_[var_9_0]:SetActive(true)
		arg_9_0.selectItemList_[var_9_0]:SetParent(arg_9_0.gridItemTrans_)
		arg_9_0.selectItemList_[var_9_0]:SetData(ChessBoardConst.SMALL_MAP_TYPE.GRID, iter_9_3, arg_9_0.selectItemClick_)

		var_9_0 = var_9_0 + 1
	end

	for iter_9_4, iter_9_5 in ipairs(arg_9_0.playerTypeList_) do
		if arg_9_0.selectItemList_[var_9_0] == nil then
			local var_9_3 = Object.Instantiate(arg_9_0.selectItemGo_)

			arg_9_0.selectItemList_[var_9_0] = ChessBoardSmallMapSelectItem.New(var_9_3)
		end

		arg_9_0.selectItemList_[var_9_0]:SetActive(true)
		arg_9_0.selectItemList_[var_9_0]:SetParent(arg_9_0.playerItemTrans_)
		arg_9_0.selectItemList_[var_9_0]:SetData(ChessBoardConst.SMALL_MAP_TYPE.PLAYER, iter_9_5, arg_9_0.selectItemClick_)

		var_9_0 = var_9_0 + 1
	end

	if #arg_9_0.specialityTypeList_ > 0 then
		SetActive(arg_9_0.specialGo_, true)

		for iter_9_6, iter_9_7 in ipairs(arg_9_0.specialityTypeList_) do
			if arg_9_0.selectItemList_[var_9_0] == nil then
				local var_9_4 = Object.Instantiate(arg_9_0.selectItemGo_)

				arg_9_0.selectItemList_[var_9_0] = ChessBoardSmallMapSelectItem.New(var_9_4)
			end

			arg_9_0.selectItemList_[var_9_0]:SetActive(true)
			arg_9_0.selectItemList_[var_9_0]:SetParent(arg_9_0.specialItemTrans_)
			arg_9_0.selectItemList_[var_9_0]:SetData(ChessBoardConst.SMALL_MAP_TYPE.SPECIAL, iter_9_7, arg_9_0.selectItemClick_)

			var_9_0 = var_9_0 + 1
		end
	else
		SetActive(arg_9_0.specialGo_, false)
	end

	for iter_9_8 = var_9_0, #arg_9_0.selectItemList_ do
		arg_9_0.selectItemList_[iter_9_8]:SetActive(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.contentTrans_)

	for iter_9_9, iter_9_10 in ipairs(arg_9_0.selectItemList_) do
		iter_9_10:FixScaleAndPos()
	end

	arg_9_0:OnSelectItemClick(ChessBoardConst.SMALL_MAP_TYPE.GRID, var_9_1[1])
end

function var_0_0.OnSelectItemClick(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.curSelectType_ == arg_11_1 and arg_11_0.curSelectID_ == arg_11_2 then
		return
	else
		arg_11_0.curSelectType_ = arg_11_1
		arg_11_0.curSelectID_ = arg_11_2

		for iter_11_0, iter_11_1 in pairs(arg_11_0.selectItemList_) do
			iter_11_1:RefreshSelect(arg_11_0.curSelectType_, arg_11_0.curSelectID_)
		end

		if arg_11_0.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.NONE then
			arg_11_0.desText_.text = ""
		elseif arg_11_0.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.GRID then
			local var_11_0 = ChessBoardHexCfg[arg_11_0.curSelectID_]

			arg_11_0.desText_.text = var_11_0.dec
		elseif arg_11_0.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.PLAYER then
			if arg_11_0.curSelectID_ == 0 then
				arg_11_0.desText_.text = ChessBoardTools.GetChessBoardGameSetting("chessboard_small_map_hero_des")
			else
				local var_11_1 = ChessBoardNPCPoolCfg[arg_11_0.curSelectID_]

				arg_11_0.desText_.text = var_11_1.dec
			end
		elseif arg_11_0.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.SPECIAL then
			local var_11_2 = ChessBoardTools.GetChessBoardGameSetting("chessboard_small_map_speciality_icon")

			for iter_11_2, iter_11_3 in pairs(var_11_2) do
				if iter_11_3[1] == arg_11_0.curSelectID_ then
					arg_11_0.desText_.text = GetTips(iter_11_3[4])

					break
				end
			end
		end

		local var_11_3 = {}
		local var_11_4 = {}
		local var_11_5, var_11_6 = ChessBoardData:GetMapWidthAndHeight()
		local var_11_7 = {}

		if arg_11_0.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.NONE then
			for iter_11_4, iter_11_5 in pairs(arg_11_0.selectTransList_) do
				SetActive(iter_11_5.gameObject, false)
			end
		elseif arg_11_0.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.GRID then
			for iter_11_6 = 0, arg_11_0.curMapData_.typeIDList.Length - 1 do
				if arg_11_0.curMapData_.typeIDList[iter_11_6] == arg_11_0.curSelectID_ then
					local var_11_8, var_11_9 = ChessBoardTools.CSharpMapIndexToXZ(iter_11_6, var_11_5)
					local var_11_10 = ChessBoardTools.AxialToCubeCoord(var_11_8, var_11_9)

					var_11_3.x = (var_11_10.z + -var_11_10.x) * 25
					var_11_3.y = -var_11_10.y * 40

					table.insert(var_11_7, {
						var_11_3.x,
						var_11_3.y
					})
				end
			end
		elseif arg_11_0.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.PLAYER then
			if arg_11_0.curSelectID_ == 0 then
				local var_11_11, var_11_12 = manager.ChessBoardManager.heroEntity_:GetPosAndDir()
				local var_11_13 = ChessBoardTools.AxialToCubeCoord(var_11_11.x, var_11_11.z)

				var_11_3.x = (var_11_13.z + -var_11_13.x) * 25
				var_11_3.y = -var_11_13.y * 40

				table.insert(var_11_7, {
					var_11_3.x,
					var_11_3.y
				})
			else
				local var_11_14 = manager.ChessBoardManager.NPCManager_:GetNPCTypeAndPosList()

				for iter_11_7, iter_11_8 in ipairs(var_11_14) do
					if iter_11_8.NPCtype == arg_11_0.curSelectID_ then
						local var_11_15 = ChessBoardTools.AxialToCubeCoord(iter_11_8.Pos.x, iter_11_8.Pos.z)

						var_11_3.x = (var_11_15.z + -var_11_15.x) * 25
						var_11_3.y = -var_11_15.y * 40

						table.insert(var_11_7, {
							var_11_3.x,
							var_11_3.y
						})
					end
				end
			end
		elseif arg_11_0.curSelectType_ == ChessBoardConst.SMALL_MAP_TYPE.SPECIAL then
			local var_11_16 = ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapData().mapId]
			local var_11_17

			for iter_11_9, iter_11_10 in pairs(var_11_16.small_map_speciality) do
				if iter_11_10[1] == arg_11_0.curSelectID_ then
					var_11_17 = iter_11_10[2]

					break
				end
			end

			for iter_11_11, iter_11_12 in pairs(var_11_17) do
				local var_11_18 = iter_11_12[1]
				local var_11_19 = iter_11_12[2]
				local var_11_20 = ChessBoardTools.AxialToCubeCoord(var_11_18, var_11_19)

				var_11_3.x = (var_11_20.z + -var_11_20.x) * 25
				var_11_3.y = -var_11_20.y * 40

				table.insert(var_11_7, {
					var_11_3.x,
					var_11_3.y
				})
			end
		end

		for iter_11_13, iter_11_14 in pairs(arg_11_0.selectTransList_) do
			SetActive(iter_11_14.gameObject, false)
		end

		for iter_11_15, iter_11_16 in pairs(var_11_7) do
			if arg_11_0.selectTransList_[iter_11_15] then
				SetActive(arg_11_0.selectTransList_[iter_11_15].gameObject, true)
			else
				local var_11_21 = Object.Instantiate(arg_11_0.selectPiece_, arg_11_0.mapTrans_)

				arg_11_0.selectTransList_[iter_11_15] = var_11_21.transform

				SetActive(arg_11_0.selectTransList_[iter_11_15].gameObject, true)
			end

			arg_11_0.selectTransList_[iter_11_15].localPosition = Vector3.New(iter_11_16[1], iter_11_16[2], 0)

			arg_11_0.selectTransList_[iter_11_15]:SetAsLastSibling()
		end
	end
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.girdImageList_) do
		Object.Destroy(iter_12_1.gameObject)
	end

	arg_12_0.girdImageList_ = {}

	for iter_12_2, iter_12_3 in pairs(arg_12_0.thingImageList_) do
		Object.Destroy(iter_12_3.gameObject)
	end

	arg_12_0.thingImageList_ = {}

	for iter_12_4, iter_12_5 in pairs(arg_12_0.NPCImageList_) do
		Object.Destroy(iter_12_5.gameObject)
	end

	arg_12_0.NPCImageList_ = {}

	for iter_12_6, iter_12_7 in pairs(arg_12_0.selectTransList_) do
		Object.Destroy(iter_12_7.gameObject)
	end

	arg_12_0.selectTransList_ = {}

	for iter_12_8, iter_12_9 in pairs(arg_12_0.selectItemList_) do
		iter_12_9:Dispose()
	end

	arg_12_0.selectItemList_ = {}
	arg_12_0.selectItemClick_ = nil

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
