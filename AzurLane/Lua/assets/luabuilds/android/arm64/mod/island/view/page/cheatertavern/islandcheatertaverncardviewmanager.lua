class = var_0_10000

local var_0_0 = var_0_10000("IslandCheaterTavernCardViewManager")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.uiContainer = arg_1_1

	arg_1_0:CreateCardMainRoot()
	arg_1_0:CreateOtherCardRoot()

	if not arg_1_0.luHandle then
		UpdateBeat = var_2
		arg_1_0.luHandle = var_2:CreateListener(arg_1_0.UpDateHandler, arg_1_0)
		UpdateBeat = var_2

		var_2:AddListener(arg_1_0.luHandle)
	end

	LayerMask = var_2
	arg_1_0.layerMask = var_2.GetMask("Island")
	CardPoolMgr = var_2
	arg_1_0.cardPoolMgr = var_2.New()
	LoadAny = var_2

	local var_1_0 = "island/jumpcurve/CardCurveX"
	local var_1_1 = ""

	typeof = var_1_10006
	JumpCurve = var_1_10008
	arg_1_0.curveX = var_2(var_1_0, var_1_1, var_1_10006(var_1_10008)).curve
	LoadAny = var_2

	local var_1_2 = "island/jumpcurve/CardCurveY"
	local var_1_3 = ""

	typeof = var_6
	JumpCurve = var_1_10008
	arg_1_0.curveY = var_2(var_1_2, var_1_3, var_6(var_1_10008)).curve
	LoadAny = var_2

	local var_1_4 = "island/jumpcurve/CardCurveZ"
	local var_1_5 = ""

	typeof = var_6
	JumpCurve = var_1_10008
	arg_1_0.curveZ = var_2(var_1_4, var_1_5, var_6(var_1_10008)).curve

	return
end

function var_0_0.SetMainPlayerSeat(arg_2_0, arg_2_1)
	arg_2_0.mainPlayerSeat = arg_2_1

	return
end

function var_0_0.UpDateHandler(arg_3_0)
	pairs = var_1_10001

	local var_3_0

	if not arg_3_0.cardKeyDic then
		var_3_0 = {}
	end

	for iter_3_0, iter_3_1 in var_1_10001(var_3_0) do
		iter_3_1:Update()
	end

	pairs = var_1

	local var_3_1

	if not arg_3_0.otherPlayerCardDic then
		var_3_1 = {}
	end

	for iter_3_2, iter_3_3 in var_1(var_3_1) do
		pairs = var_1_10006

		for iter_3_4, iter_3_5 in var_1_10006(iter_3_3) do
			iter_3_5:Update()
		end
	end

	ipairs = var_1

	local var_3_2

	if not arg_3_0.tableCardList then
		var_3_2 = {}
	end

	for iter_3_6, iter_3_7 in var_1(var_3_2) do
		iter_3_7:Update()
	end

	arg_3_0:UpdateCardMainRootPos()

	Input = var_1

	if not var_1.GetMouseButtonDown(0) then
		return
	end

	IsNil = var_1
	UnityEngine = var_3

	local var_3_3

	if not var_1(var_3.EventSystems.EventSystem.current.currentSelectedGameObject) then
		UnityEngine = var_1
		var_3_3 = var_1.EventSystems.EventSystem.current

		if var_1.IsPointerOverGameObject(var_3_3) then
			return
		end
	end

	Input = var_1

	local var_3_4 = var_1.mousePosition

	CheatTavernCameraMgr = var_2

	local var_3_5 = var_2.instance._mainCamera
	local var_3_6 = var_2.ScreenPointToRay(var_3_5, var_3_4)

	Physics = var_3_3

	local var_3_7 = var_3_3.Raycast
	local var_3_8 = var_3_6

	hit = var_1_10006

	local var_3_9, var_3_10 = var_3_7(var_3_8, var_1_10006, 1000, arg_3_0.layerMask)

	if var_3_9 then
		local var_3_11 = var_3_10.collider.gameObject
		local var_3_12 = var_5.GetComponent

		typeof = var_8
		CheaterTavernCard = iter_3_5

		if var_3_12(var_3_11, var_8(iter_3_5)) == nil then
			return
		end

		local var_3_13 = var_5.key

		if var_5.parm == 0 then
			return
		end

		local var_3_14

		if not arg_3_0.selectCardKey[var_3_13] then
			var_3_14 = false
		end

		if not var_3_14 then
			local var_3_15 = 0

			pairs = iter_3_5

			for iter_3_8, iter_3_9 in iter_3_5(arg_3_0.selectCardKey) do
				if iter_3_9 then
					var_3_15 = var_3_15 + 1
				end
			end

			IslandCheaterTavernConst = var_10

			if var_3_15 >= var_10.putCountMax then
				return
			end
		end

		arg_3_0:UpdateSelectCard(var_3_13, not var_3_14)
	end

	return
end

function var_0_0.UpdateSelectCard(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.cardKeyDic[arg_4_1] == nil then
		return
	end

	arg_4_0.selectCardKey[arg_4_1] = arg_4_2

	var_3:SetSelected(arg_4_2)

	return
end

function var_0_0.GetSelectCardKeyList(arg_5_0)
	local var_5_0 = {}

	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.selectCardKey) do
		if iter_5_1 and arg_5_0.cardKeyDic[iter_5_0] then
			table = var_7

			var_7.insert(var_5_0, iter_5_0)
		end
	end

	arg_5_0.selectCardKey = {}

	return var_5_0
end

function var_0_0.InitMainCard(arg_6_0, arg_6_1)
	arg_6_0.tableCardList = {}
	arg_6_0.selectCardKey = {}
	arg_6_0.cardDataList = arg_6_1
	arg_6_0.cardKeyDic = {}

	local var_6_0 = #arg_6_1

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_1) do
		local var_6_1 = iter_6_1.id
		local var_6_2 = iter_6_1.key

		MainCardItem = var_1_10010
		var_1_10010 = var_1_10010.New({
			id = var_6_1,
			key = var_6_2,
			index = iter_6_0,
			mainPlayerSeat = arg_6_0.mainPlayerSeat,
			allCount = var_6_0
		}, arg_6_0.cardPoolMgr, arg_6_0.CardMainRoot.transform)
		arg_6_0.cardKeyDic[var_6_2] = var_1_10010

		var_1_10010:SetCurveOffsetY(arg_6_0.curveX, arg_6_0.curveY, arg_6_0.curveZ)
	end

	return
end

function var_0_0.InitOtherPlayerCard(arg_7_0, arg_7_1)
	pairs = var_1_10002

	local var_7_0

	if not arg_7_0.otherPlayerCardDic then
		var_7_0 = {}
	end

	for iter_7_0, iter_7_1 in var_1_10002(var_7_0) do
		pairs = var_1_10007

		for iter_7_2, iter_7_3 in var_1_10007(iter_7_1 or {}) do
			var_1_10014 = iter_7_3

			iter_7_3.Destroy(var_1_10014)
		end
	end

	arg_7_0.otherPlayerCardDic = {}
	ipairs = var_2

	for iter_7_4, iter_7_5 in var_2(arg_7_1) do
		if not iter_7_5:IsOut() then
			local var_7_1 = iter_7_5.seat

			arg_7_0.otherPlayerCardDic[iter_7_5.user_id] = {}

			local var_7_2 = iter_7_5:GetCardNum()

			for iter_7_6 = 1, var_7_2 do
				local var_7_3 = arg_7_0.seatOherRootDic[var_7_1]

				MainCardItem = var_1_10014

				local var_7_4 = var_1_10014.New({
					id = 0,
					key = 0,
					index = iter_7_6,
					mainPlayerSeat = arg_7_0.mainPlayerSeat,
					allCount = var_7_2
				}, arg_7_0.cardPoolMgr, var_7_3)

				var_1_10014.SetCurveOffsetY(var_7_4, arg_7_0.curveX, arg_7_0.curveY, arg_7_0.curveZ)

				arg_7_0.otherPlayerCardDic[iter_7_5.user_id][iter_7_6] = var_1_10014
			end
		end
	end

	return
end

function var_0_0.RefreshMainCard(arg_8_0, arg_8_1)
	local var_8_0 = #arg_8_1

	arg_8_0.cardDataList = arg_8_1
	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_1) do
		local var_8_1 = iter_8_1.key
		local var_8_2 = arg_8_0.cardKeyDic[var_8_1]

		var_9.SetIndex(var_8_2, iter_8_0)
		var_9:SetAllCount(var_8_0)
		var_9:InitCardView()
	end

	return
end

function var_0_0.PutDownMainCard(arg_9_0, arg_9_1)
	ipairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_1) do
		if arg_9_0.cardKeyDic[iter_9_1] then
			var_7:MoveToTable(iter_9_0, #arg_9_1)

			IslandCheaterTavernConst = var_8

			if not var_8.putCardTest then
				local var_9_0 = arg_9_0.cardKeyDic

				var_9_0[iter_9_1] = nil
				table = var_9_0

				var_9_0.insert(arg_9_0.tableCardList, var_7)
			end
		end
	end

	return
end

function var_0_0.OtherPlayerPutCard(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if not arg_10_0.otherPlayerCardDic[arg_10_1] then
		var_10_0 = {}
	end

	local var_10_1 = #var_10_0 - arg_10_2 + 1
	local var_10_2 = 1

	for iter_10_0 = var_10_1, var_4 do
		if var_10_0[iter_10_0] then
			var_11:MoveToTable(var_10_2, arg_10_2)

			var_10_2 = var_10_2 + 1
			var_10_0[iter_10_0] = nil
			table = var_12

			var_12.insert(arg_10_0.tableCardList, var_11)
		end
	end

	return
end

function var_0_0.OtherPlayerCardDestroy(arg_11_0, arg_11_1)
	local var_11_0

	if not arg_11_0.otherPlayerCardDic[arg_11_1] then
		var_11_0 = {}
	end

	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(var_11_0) do
		iter_11_1:Destroy()
	end

	arg_11_0.otherPlayerCardDic[arg_11_1] = {}

	return
end

function var_0_0.PlayerCardSetActive(arg_12_0, arg_12_1, arg_12_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_12_0 = var_1_10003(var_1_10005)

	if var_3.getRawData(var_12_0).id == arg_12_1 then
		pairs = var_3

		local var_12_1

		if not arg_12_0.cardKeyDic then
			var_12_1 = {}
		end

		for iter_12_0, iter_12_1 in var_3(var_12_1) do
			iter_12_1:SetActive(arg_12_2)
		end
	else
		local var_12_2

		if not arg_12_0.otherPlayerCardDic[arg_12_1] then
			var_12_2 = {}
		end

		pairs = var_1_10004

		for iter_12_2, iter_12_3 in var_1_10004(var_12_2) do
			iter_12_3:SetActive(arg_12_2)
		end
	end

	return
end

function var_0_0.FlipTableCard(arg_13_0, arg_13_1)
	local var_13_0 = #arg_13_0.tableCardList

	ipairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(arg_13_0.tableCardList) do
		local var_13_1 = arg_13_1[iter_13_0]

		iter_13_1:FlipTableCard(var_13_1, iter_13_0, var_13_0)
	end

	return
end

function var_0_0.ClearTableCard(arg_14_0)
	if arg_14_0.tableCardList == nil then
		return
	end

	ipairs = var_1

	for iter_14_0, iter_14_1 in var_1(arg_14_0.tableCardList) do
		iter_14_1:Destroy()
	end

	table = var_1

	var_1.clear(arg_14_0.tableCardList)

	return
end

function var_0_0.DestroyMainCard(arg_15_0)
	pairs = var_1_10001

	local var_15_0

	if not arg_15_0.cardKeyDic then
		var_15_0 = {}
	end

	for iter_15_0, iter_15_1 in var_1_10001(var_15_0) do
		iter_15_1:Destroy()
	end

	arg_15_0.cardKeyDic = {}
	arg_15_0.selectCardKey = {}
	arg_15_0.cardDataList = {}

	return
end

function var_0_0.CreateCardMainRoot(arg_16_0)
	GameObject = var_1_10001
	arg_16_0.CardMainRoot = var_1_10001.New("CardMainRoot")

	arg_16_0:UpdateCardMainRootPos()

	return
end

function var_0_0.CreateOtherCardRoot(arg_17_0)
	arg_17_0.seatOherRootDic = {}

	for iter_17_0 = 1, 4 do
		local var_17_0 = iter_17_0
		local var_17_1 = arg_17_0.seatOherRootDic

		GameObject = var_1_10007
		var_1_10007 = var_1_10007.New
		tostring = var_1_10009
		var_17_1[iter_17_0] = var_1_10007(var_1_10009(iter_17_0)).transform

		local var_17_2 = 10110000 + iter_17_0

		pg = var_1_10007

		local var_17_3 = var_1_10007.island_world_objects[var_17_2].param.position[1]

		var_1_10009 = var_1_10007.param.position[3]

		local var_17_4 = {
			1,
			0,
			-1,
			0
		}
		local var_17_5 = {
			0,
			-1,
			0,
			1
		}
		local var_17_6 = var_17_4[var_17_0]

		IslandCheaterTavernConst = var_1_10013

		local var_17_7 = var_17_3 + var_17_6 * var_1_10013.horOffset
		local var_17_8 = var_17_5[var_17_0]

		IslandCheaterTavernConst = var_1_10013
		var_1_10009 = var_1_10009 + var_17_8 * var_1_10013.horOffset

		local var_17_9 = {
			-90,
			0,
			90,
			180
		}

		Vector3 = var_1_10013

		local var_17_10 = var_17_7

		IslandCheaterTavernConst = var_1_10016
		var_1_10013 = var_1_10013(var_17_10, var_1_10016.verOffset, var_1_10009)
		arg_17_0.seatOherRootDic[iter_17_0].position = var_1_10013

		local var_17_11 = arg_17_0.seatOherRootDic[iter_17_0]

		Quaternion = var_17_10
		var_17_11.rotation = var_17_10.Euler(var_1_10007.param.rotation[1], var_17_9[var_17_0], var_1_10007.param.rotation[3])
	end

	return
end

function var_0_0.UpdateCardMainRootPos(arg_18_0)
	GameObject = var_1_10001

	local var_18_0 = var_1_10001.Find("UICamera")
	local var_18_1 = var_1.GetComponent

	typeof = var_1_10004
	Camera = var_1_10006

	local var_18_2 = var_18_1(var_18_0, var_1_10004(var_1_10006))
	local var_18_3 = var_1.WorldToScreenPoint(var_18_2, arg_18_0.uiContainer.position)

	IslandCheaterTavernConst = var_18_0

	local var_18_4 = var_18_0.cardOffsetToCamara

	CheatTavernCameraMgr = var_18_2

	local var_18_5 = var_18_2.instance._mainCamera
	local var_18_6 = var_4.ScreenToWorldPoint

	Vector3 = var_1_10007

	local var_18_7 = var_18_6(var_18_5, var_1_10007(var_18_3.x, var_18_3.y, var_18_4))
	local var_18_8 = arg_18_0.CardMainRoot.transform

	Vector3 = var_18_5
	var_18_8.localPosition = var_18_5(var_18_7.x, var_18_7.y, var_18_7.z)

	local var_18_9 = arg_18_0.CardMainRoot.transform

	CheatTavernCameraMgr = var_6
	var_18_9.rotation = var_6.instance._mainCamera.transform.rotation

	return
end

function var_0_0.Destroy(arg_19_0)
	UpdateBeat = var_1_10001

	var_1_10001:RemoveListener(arg_19_0.luHandle)

	if arg_19_0.CardMainRoot then
		GameObject = var_1

		var_1.Destroy(arg_19_0.CardMainRoot)

		arg_19_0.CardMainRoot = nil
	end

	pairs = var_1

	for iter_19_0, iter_19_1 in var_1(arg_19_0.seatOherRootDic) do
		if iter_19_1 then
			GameObject = var_1_10006

			var_1_10006.Destroy(iter_19_1.gameObject)
		end
	end

	arg_19_0.seatOherRootDic = {}
	pairs = var_1

	local var_19_0

	if not arg_19_0.otherPlayerCardDic then
		var_19_0 = {}
	end

	for iter_19_2, iter_19_3 in var_1(var_19_0) do
		pairs = var_1_10006

		for iter_19_4, iter_19_5 in var_1_10006(iter_19_3) do
			iter_19_5:Destroy()
		end
	end

	pairs = var_1

	local var_19_1

	if not arg_19_0.cardKeyDic then
		var_19_1 = {}
	end

	for iter_19_6, iter_19_7 in var_1(var_19_1) do
		iter_19_7:Destroy()
	end

	ipairs = var_1

	local var_19_2

	if not arg_19_0.tableCardList then
		var_19_2 = {}
	end

	for iter_19_8, iter_19_9 in var_1(var_19_2) do
		iter_19_9:Destroy()
	end

	local var_19_3 = arg_19_0.cardPoolMgr

	var_1.Destroy(var_19_3)

	return
end

return var_0_0
