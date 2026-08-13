class = var_0_10000

local var_0_0 = "AuctionGameMainNoticeBoardPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0.itemViewList = {}

	return
end

function var_0_1.didEnter(arg_3_0, arg_3_1)
	arg_3_0.index = arg_3_1
	getProxy = var_1_10002
	AuctionGameProxy = var_1_10003

	local var_3_0 = var_1_10002(var_1_10003)
	local var_3_1 = var_2.GetPlayerList(var_3_0)[arg_3_1]

	setScrollText = var_1_10005

	var_1_10005(arg_3_0.uiNameText, var_3_1.name)

	Ship = var_1_10005

	local var_3_2 = var_1_10005.New({
		configId = var_3_1.icon,
		skin_id = var_3_1.skinId
	})

	LoadSpriteAsync = var_6

	local var_3_3 = "qicon/"
	local var_3_4 = var_3_2

	var_6(var_3_3 .. var_3_2.getPrefab(var_3_4), function(arg_4_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_3_0.uiIconImage) then
			arg_3_0.uiIconImage.sprite = arg_4_0
		end

		return
	end)

	AttireFrame = var_6

	local var_3_5 = var_6.attireFrameRes
	local var_3_6 = var_3_1
	local var_3_7 = false

	AttireConst = var_3_4

	local var_3_8 = var_3_5(var_3_6, var_3_7, var_3_4.TYPE_ICON_FRAME, var_3_1.propose)

	PoolMgr = var_3_6

	local var_3_9 = var_3_6.GetInstance()

	var_7.GetPrefab(var_3_9, "IconFrame/" .. var_3_8, var_3_8, true, function(arg_5_0)
		IsNil = var_2_10001

		if var_2_10001(arg_3_0.uiFrameGo) then
			return
		end

		if arg_3_0.uiFrameGo then
			arg_5_0.name = var_3_8
			findTF = var_1

			local var_5_0 = var_1(arg_5_0.transform, "icon")
			local var_5_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10005
			var_5_1(var_5_0, var_2_10004(var_2_10005)).raycastTarget = false
			setParent = var_3

			local var_5_2 = arg_5_0

			tf = var_2_10005

			var_3(var_5_2, var_2_10005(arg_3_0.uiFrameGo), false)
		else
			PoolMgr = var_1

			local var_5_3 = var_1.GetInstance()

			var_1.ReturnPrefab(var_5_3, "IconFrame/" .. var_3_8, var_3_8, arg_5_0)
		end

		return
	end)

	local var_3_10 = var_2:GetRoundEventAndBidInfoList()

	for iter_3_0 = 1, var_2:GetRound() - 1 do
		local var_3_11 = var_3_10[iter_3_0][var_3_1.id]
		local var_3_12 = arg_3_0.itemViewList

		AuctionGameMainNoticeBoardItem = var_1_10014
		var_1_10014 = var_1_10014.New
		Instantiate = var_1_10015
		var_3_12[iter_3_0] = var_1_10014(var_1_10015(arg_3_0.uiItemTf, arg_3_0._tf), arg_3_0._parentClass)
		var_1_10014 = arg_3_0.itemViewList[iter_3_0]

		var_13.didEnter(var_1_10014, var_3_11)
	end

	return
end

function var_0_1.willExit(arg_6_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_6_0.uiFrameGo) then
		tf = var_1

		if var_1(arg_6_0.uiFrameGo).childCount > 0 then
			local var_6_0 = var_1:GetChild(0).gameObject.name

			PoolMgr = var_4

			local var_6_1 = var_4.GetInstance()

			var_4.ReturnPrefab(var_6_1, "IconFrame/" .. var_6_0, var_6_0, var_2.gameObject)
		end
	end

	ipairs = var_1

	for iter_6_0, iter_6_1 in var_1(arg_6_0.itemViewList) do
		iter_6_1:willExit()
	end

	arg_6_0.itemViewList = nil

	arg_6_0:detach()

	return
end

return var_0_1
