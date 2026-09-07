local IslandCheaterTavernCardViewManager = class("IslandCheaterTavernCardViewManager")

function IslandCheaterTavernCardViewManager:Ctor(arg_1_1)
	self.uiContainer = arg_1_1

	self:CreateCardMainRoot()
	self:CreateOtherCardRoot()

	if not self.luHandle then
		self.luHandle = UpdateBeat:CreateListener(self.UpDateHandler, self)

		UpdateBeat:AddListener(self.luHandle)
	end

	self.layerMask = LayerMask.GetMask("Island")
	self.cardPoolMgr = CardPoolMgr.New()
	self.curveX = LoadAny("island/jumpcurve/CardCurveX", "", typeof(JumpCurve)).curve
	self.curveY = LoadAny("island/jumpcurve/CardCurveY", "", typeof(JumpCurve)).curve
	self.curveZ = LoadAny("island/jumpcurve/CardCurveZ", "", typeof(JumpCurve)).curve

	return
end

function IslandCheaterTavernCardViewManager:SetMainPlayerSeat(arg_2_1)
	self.mainPlayerSeat = arg_2_1

	return
end

function IslandCheaterTavernCardViewManager:UpDateHandler()
	for iter_3_0, iter_3_1 in pairs(self.cardKeyDic or {}) do
		iter_3_1:Update()
	end

	for iter_3_2, iter_3_3 in pairs(self.otherPlayerCardDic or {}) do
		for iter_3_4, iter_3_5 in pairs(iter_3_3) do
			iter_3_5:Update()
		end
	end

	for iter_3_6, iter_3_7 in ipairs(self.tableCardList or {}) do
		iter_3_7:Update()
	end

	self:UpdateCardMainRootPos()

	if not Input.GetMouseButtonDown(0) then
		return
	end

	if not IsNil(UnityEngine.EventSystems.EventSystem.current.currentSelectedGameObject) and UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
		return
	end

	local var_3_1, var_3_2 = Physics.Raycast(CheatTavernCameraMgr.instance._mainCamera:ScreenPointToRay(Input.mousePosition), hit, 1000, self.layerMask)

	if var_3_1 then
		local var_3_3 = var_3_2.collider.gameObject:GetComponent(typeof(CheaterTavernCard))

		if var_3_3 == nil then
			return
		end

		local var_3_4 = var_3_3.key

		if var_3_3.parm == 0 then
			return
		end

		local var_3_5 = self.selectCardKey[var_3_4] or false

		if not var_3_5 then
			local var_3_6 = 0

			for iter_3_8, iter_3_9 in pairs(self.selectCardKey) do
				if iter_3_9 then
					var_3_6 = var_3_6 + 1
				end
			end

			if var_3_6 >= IslandCheaterTavernConst.putCountMax then
				return
			end
		end

		self:UpdateSelectCard(var_3_4, not var_3_5)
	end

	return
end

function IslandCheaterTavernCardViewManager:UpdateSelectCard(arg_4_1, arg_4_2)
	if self.cardKeyDic[arg_4_1] == nil then
		return
	end

	self.selectCardKey[arg_4_1] = arg_4_2

	self.cardKeyDic[arg_4_1]:SetSelected(arg_4_2)

	return
end

function IslandCheaterTavernCardViewManager:GetSelectCardKeyList()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.selectCardKey) do
		if iter_5_1 and self.cardKeyDic[iter_5_0] then
			table.insert(var_5_0, iter_5_0)
		end
	end

	self.selectCardKey = {}

	return var_5_0
end

function IslandCheaterTavernCardViewManager:InitMainCard(arg_6_1)
	self.tableCardList = {}
	self.selectCardKey = {}
	self.cardDataList = arg_6_1
	self.cardKeyDic = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = MainCardItem.New({
			id = iter_6_1.id,
			key = iter_6_1.key,
			index = iter_6_0,
			mainPlayerSeat = self.mainPlayerSeat,
			allCount = #arg_6_1
		}, self.cardPoolMgr, self.CardMainRoot.transform)

		self.cardKeyDic[iter_6_1.key] = var_6_0

		var_6_0:SetCurveOffsetY(self.curveX, self.curveY, self.curveZ)
	end

	return
end

function IslandCheaterTavernCardViewManager:InitOtherPlayerCard(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(self.otherPlayerCardDic or {}) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1 or {}) do
			iter_7_3:Destroy()
		end
	end

	self.otherPlayerCardDic = {}

	for iter_7_4, iter_7_5 in ipairs(arg_7_1) do
		if not iter_7_5:IsOut() then
			self.otherPlayerCardDic[iter_7_5.user_id] = {}

			local var_7_1 = iter_7_5:GetCardNum()

			for iter_7_6 = 1, var_7_1 do
				local var_7_2 = MainCardItem.New({
					id = 0,
					key = 0,
					index = iter_7_6,
					mainPlayerSeat = self.mainPlayerSeat,
					allCount = var_7_1
				}, self.cardPoolMgr, self.seatOherRootDic[iter_7_5.seat])

				var_7_2:SetCurveOffsetY(self.curveX, self.curveY, self.curveZ)

				self.otherPlayerCardDic[iter_7_5.user_id][iter_7_6] = var_7_2
			end
		end
	end

	return
end

function IslandCheaterTavernCardViewManager:RefreshMainCard(arg_8_1)
	self.cardDataList = arg_8_1

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		self.cardKeyDic[iter_8_1.key]:SetIndex(iter_8_0)
		self.cardKeyDic[iter_8_1.key]:SetAllCount(#arg_8_1)
		self.cardKeyDic[iter_8_1.key]:InitCardView()
	end

	return
end

function IslandCheaterTavernCardViewManager:PutDownMainCard(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if self.cardKeyDic[iter_9_1] then
			self.cardKeyDic[iter_9_1]:MoveToTable(iter_9_0, #arg_9_1)

			if not IslandCheaterTavernConst.putCardTest then
				self.cardKeyDic[iter_9_1] = nil

				table.insert(self.tableCardList, self.cardKeyDic[iter_9_1])
			end
		end
	end

	return
end

function IslandCheaterTavernCardViewManager:OtherPlayerPutCard(arg_10_1, arg_10_2)
	local var_10_0 = self.otherPlayerCardDic[arg_10_1] or {}

	for iter_10_0 = #var_10_0 - arg_10_2 + 1, #var_10_0 do
		if var_10_0[iter_10_0] then
			var_10_0[iter_10_0]:MoveToTable(1, arg_10_2)

			var_10_0[iter_10_0] = nil

			table.insert(self.tableCardList, var_10_0[iter_10_0])
		end
	end

	return
end

function IslandCheaterTavernCardViewManager:OtherPlayerCardDestroy(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(self.otherPlayerCardDic[arg_11_1] or {}) do
		iter_11_1:Destroy()
	end

	self.otherPlayerCardDic[arg_11_1] = {}

	return
end

function IslandCheaterTavernCardViewManager:PlayerCardSetActive(arg_12_1, arg_12_2)
	if getProxy(PlayerProxy):getRawData().id == arg_12_1 then
		for iter_12_0, iter_12_1 in pairs(self.cardKeyDic or {}) do
			iter_12_1:SetActive(arg_12_2)
		end
	else
		for iter_12_2, iter_12_3 in pairs(self.otherPlayerCardDic[arg_12_1] or {}) do
			iter_12_3:SetActive(arg_12_2)
		end
	end

	return
end

function IslandCheaterTavernCardViewManager:FlipTableCard(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self.tableCardList) do
		iter_13_1:FlipTableCard(arg_13_1[iter_13_0], iter_13_0, #self.tableCardList)
	end

	return
end

function IslandCheaterTavernCardViewManager:ClearTableCard()
	if self.tableCardList == nil then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(self.tableCardList) do
		iter_14_1:Destroy()
	end

	table.clear(self.tableCardList)

	return
end

function IslandCheaterTavernCardViewManager:DestroyMainCard()
	for iter_15_0, iter_15_1 in pairs(self.cardKeyDic or {}) do
		iter_15_1:Destroy()
	end

	self.cardKeyDic = {}
	self.selectCardKey = {}
	self.cardDataList = {}

	return
end

function IslandCheaterTavernCardViewManager:CreateCardMainRoot()
	self.CardMainRoot = GameObject.New("CardMainRoot")

	self:UpdateCardMainRootPos()

	return
end

function IslandCheaterTavernCardViewManager:CreateOtherCardRoot()
	self.seatOherRootDic = {}

	for iter_17_0 = 1, 4 do
		self.seatOherRootDic[iter_17_0] = GameObject.New(tostring(iter_17_0)).transform

		local var_17_1 = {
			-90,
			0,
			90,
			180
		}

		self.seatOherRootDic[iter_17_0].position = Vector3(pg.island_world_objects[10110000 + iter_17_0].param.position[1] + ({
			1,
			0,
			-1,
			0
		})[iter_17_0] * IslandCheaterTavernConst.horOffset, IslandCheaterTavernConst.verOffset, pg.island_world_objects[10110000 + iter_17_0].param.position[3] + ({
			0,
			-1,
			0,
			1
		})[iter_17_0] * IslandCheaterTavernConst.horOffset)
		self.seatOherRootDic[iter_17_0].rotation = Quaternion.Euler(pg.island_world_objects[10110000 + iter_17_0].param.rotation[1], var_17_1[iter_17_0], pg.island_world_objects[10110000 + iter_17_0].param.rotation[3])
	end

	return
end

function IslandCheaterTavernCardViewManager:UpdateCardMainRootPos()
	local var_18_0 = GameObject.Find("UICamera"):GetComponent(typeof(Camera)):WorldToScreenPoint(self.uiContainer.position)
	local var_18_1 = CheatTavernCameraMgr.instance._mainCamera:ScreenToWorldPoint(Vector3(var_18_0.x, var_18_0.y, IslandCheaterTavernConst.cardOffsetToCamara))

	self.CardMainRoot.transform.localPosition = Vector3(var_18_1.x, var_18_1.y, var_18_1.z)
	self.CardMainRoot.transform.rotation = CheatTavernCameraMgr.instance._mainCamera.transform.rotation

	return
end

function IslandCheaterTavernCardViewManager:Destroy()
	UpdateBeat:RemoveListener(self.luHandle)

	if self.CardMainRoot then
		GameObject.Destroy(self.CardMainRoot)

		self.CardMainRoot = nil
	end

	for iter_19_0, iter_19_1 in pairs(self.seatOherRootDic) do
		if iter_19_1 then
			GameObject.Destroy(iter_19_1.gameObject)
		end
	end

	self.seatOherRootDic = {}

	for iter_19_2, iter_19_3 in pairs(self.otherPlayerCardDic or {}) do
		for iter_19_4, iter_19_5 in pairs(iter_19_3) do
			iter_19_5:Destroy()
		end
	end

	for iter_19_6, iter_19_7 in pairs(self.cardKeyDic or {}) do
		iter_19_7:Destroy()
	end

	for iter_19_8, iter_19_9 in ipairs(self.tableCardList or {}) do
		iter_19_9:Destroy()
	end

	self.cardPoolMgr:Destroy()

	return
end

return IslandCheaterTavernCardViewManager
