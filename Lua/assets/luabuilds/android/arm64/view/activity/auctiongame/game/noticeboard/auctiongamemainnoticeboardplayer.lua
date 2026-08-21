local var_0_0 = class("AuctionGameMainNoticeBoardPlayer", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.itemViewList = {}

	return
end

function var_0_0.didEnter(arg_3_0, arg_3_1)
	arg_3_0.index = arg_3_1

	local var_3_0 = getProxy(AuctionGameProxy)
	local var_3_1 = var_3_0:GetPlayerList()[arg_3_1]

	setScrollText(arg_3_0.uiNameText, var_3_1.name)
	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = var_3_1.icon,
		skin_id = var_3_1.skinId
	}):getPrefab(), function(arg_4_0)
		if not IsNil(arg_3_0.uiIconImage) then
			arg_3_0.uiIconImage.sprite = arg_4_0
		end

		return
	end)

	local var_3_2 = AttireFrame.attireFrameRes(var_3_1, false, AttireConst.TYPE_ICON_FRAME, var_3_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_3_2, var_3_2, true, function(arg_5_0)
		if IsNil(arg_3_0.uiFrameGo) then
			return
		end

		if arg_3_0.uiFrameGo then
			arg_5_0.name = var_3_2
			findTF(arg_5_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_5_0, tf(arg_3_0.uiFrameGo), false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_3_2, var_3_2, arg_5_0)
		end

		return
	end)

	local var_3_3 = var_3_0:GetRoundEventAndBidInfoList()

	for iter_3_0 = 1, var_3_0:GetRound() - 1 do
		arg_3_0.itemViewList[iter_3_0] = AuctionGameMainNoticeBoardItem.New(Instantiate(arg_3_0.uiItemTf, arg_3_0._tf), arg_3_0._parentClass)

		arg_3_0.itemViewList[iter_3_0]:didEnter(var_3_3[iter_3_0][var_3_1.id])
	end

	return
end

function var_0_0.willExit(arg_6_0)
	if not IsNil(arg_6_0.uiFrameGo) then
		local var_6_0 = tf(arg_6_0.uiFrameGo)

		if var_6_0.childCount > 0 then
			local var_6_1 = var_6_0:GetChild(0)

			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_6_1.gameObject.name, var_6_1.gameObject.name, var_6_1.gameObject)
		end
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemViewList) do
		iter_6_1:willExit()
	end

	arg_6_0.itemViewList = nil

	arg_6_0:detach()

	return
end

return var_0_0
