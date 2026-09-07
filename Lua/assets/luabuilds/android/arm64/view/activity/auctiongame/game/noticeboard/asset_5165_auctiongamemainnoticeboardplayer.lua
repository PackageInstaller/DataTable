local AuctionGameMainNoticeBoardPlayer = class("AuctionGameMainNoticeBoardPlayer", import("view.base.BasePanel"))

function AuctionGameMainNoticeBoardPlayer:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainNoticeBoardPlayer.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainNoticeBoardPlayer:Init()
	self.itemViewList = {}

	return
end

function AuctionGameMainNoticeBoardPlayer:didEnter(arg_3_1)
	self.index = arg_3_1

	local var_3_0 = getProxy(AuctionGameProxy)
	local var_3_1 = var_3_0:GetPlayerList()[arg_3_1]

	setScrollText(self.uiNameText, var_3_1.name)
	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = var_3_1.icon,
		skin_id = var_3_1.skinId
	}):getPrefab(), function(arg_4_0)
		if not IsNil(self.uiIconImage) then
			self.uiIconImage.sprite = arg_4_0
		end

		return
	end)

	local var_3_2 = AttireFrame.attireFrameRes(var_3_1, false, AttireConst.TYPE_ICON_FRAME, var_3_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_3_2, var_3_2, true, function(arg_5_0)
		if IsNil(self.uiFrameGo) then
			return
		end

		if self.uiFrameGo then
			arg_5_0.name = var_3_2
			findTF(arg_5_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_5_0, tf(self.uiFrameGo), false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_3_2, var_3_2, arg_5_0)
		end

		return
	end)

	local var_3_3 = var_3_0:GetRoundEventAndBidInfoList()

	for iter_3_0 = 1, var_3_0:GetRound() - 1 do
		self.itemViewList[iter_3_0] = AuctionGameMainNoticeBoardItem.New(Instantiate(self.uiItemTf, self._tf), self._parentClass)

		self.itemViewList[iter_3_0]:didEnter(var_3_3[iter_3_0][var_3_1.id])
	end

	return
end

function AuctionGameMainNoticeBoardPlayer:willExit()
	if not IsNil(self.uiFrameGo) then
		local var_6_0 = tf(self.uiFrameGo)

		if var_6_0.childCount > 0 then
			local var_6_1 = var_6_0:GetChild(0)

			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_6_1.gameObject.name, var_6_1.gameObject.name, var_6_1.gameObject)
		end
	end

	for iter_6_0, iter_6_1 in ipairs(self.itemViewList) do
		iter_6_1:willExit()
	end

	self.itemViewList = nil

	self:detach()

	return
end

return AuctionGameMainNoticeBoardPlayer
