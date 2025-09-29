-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonBuyVipView.lua

module("logic.extensions.season.view.SeasonBuyVipView", package.seeall)

local M = class("SeasonBuyVipView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	self._txtCostVip1 = self:getText("secret_time_unlock_rewards_tips_1018040335")
	self._imgCostVip1 = self:getImage("secret_time_unlock_rewards_tips_-668963578")
	self._btnBuyVip1 = self:getBtn("1&btn_middle_-31477526")
	self._goUnlockVip1 = self:getGo("secret_time_unlock_rewards_tips_1688891915")
	self._txtCostVip2 = self:getText("secret_time_unlock_rewards_tips_-1736474049")
	self._txtVip2GiveLv = self:getText("secret_time_unlock_rewards_tips_557579101")
	self._imgCostVip2 = self:getImage("secret_time_unlock_rewards_tips_110860701")
	self._btnBuyVip2 = self:getBtn("2&btn_middle_-31477526")
	self._goUnlockVip2 = self:getGo("secret_time_unlock_rewards_tips_-721872428")
	self._goVip2Rewards = self:getGo("secret_time_unlock_rewards_tips_1824708864")
	self.btn_btnClose = self:getBtn("secret_time_unlock_rewards_tips_-1812944854")
	self.go_item_vip2_template = self:getGo("3&rewards_detail_item_2141037416")
	self._goVip1Rewards = self:getGo("secret_time_unlock_rewards_tips_1266540765")
	self.go_item_vip1_template = self:getGo("6&rewards_detail_item_2141037416")
	self.text_txtContent = self:getText("secret_time_unlock_rewards_tips_-713471539")
	self._btnCheck = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "objGiftBag/txtName/btnCheck"))
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnBuyVip1:AddClickListener(self._onClickBtnBuyVip1, self)
	self._btnBuyVip2:AddClickListener(self._onClickBtnBuyVip2, self)
	self.btn_btnClose:AddClickListener(self._onClickClose, self)
	self._btnCheck:AddClickListener(self._onClickItem, self)
end

function M:unbindEvents()
	self._btnBuyVip1:RemoveClickListener()
	self._btnBuyVip2:RemoveClickListener()
	self.btn_btnClose:RemoveClickListener()
	self._btnCheck:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.SEASON_INFO_UPDATE, self._onSeasonInfoUpdate, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._vipBuySucc, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SEASON_INFO_UPDATE, self._onSeasonInfoUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._vipBuySucc, self)
	end
end

function M:onEnter()
	self:initView()
	self:refreshVipView()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
end

function M:initView()
	local lv = SeasonConfig.instance:getVip2GiveLv()

	self._txtVip2GiveLv.text = "+" .. lv

	local costCode = SeasonConfig.instance:getVipCostCode()
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(costCode)
	local seasonId = SeasonModel.instance:getSeasonId()

	IconLoader.setSprite(self._imgCostVip1, IconType.ItemIcon, itemCo.icon)
	IconLoader.setSprite(self._imgCostVip2, IconType.ItemIcon, itemCo.icon)

	self.text_txtContent.text = SeasonConfig.instance:getFinalRewardContent(seasonId)

	goutil.setActive(self.go_item_vip1_template, false)
	goutil.setActive(self.go_item_vip2_template, false)

	local vip1RewardId = SeasonModel.instance:getVip1ExtraRewardId()
	local vip1RewardCO = RewardConfig.instance:getRewardCfgByCode(vip1RewardId)

	if vip1RewardCO then
		self:_generateRewardItem(self._goVip1Rewards.transform, self.go_item_vip1_template, vip1RewardCO.reward)
	end

	local vip2RewardId = SeasonModel.instance:getVip2ExtraRewardId()
	local vip2RewardCO = RewardConfig.instance:getRewardCfgByCode(vip2RewardId)

	if vip2RewardCO then
		self:_generateRewardItem(self._goVip2Rewards.transform, self.go_item_vip2_template, vip2RewardCO.reward)
	end
end

function M:_generateRewardItem(contentPrent, itemTemplate, dataList)
	goutil.setActive(itemTemplate, false)

	if not dataList then
		return
	end

	local itemChildCount = contentPrent.childCount

	for i = 1, #dataList - itemChildCount + 1 do
		local itemGo = goutil.cloneAndSetParent(itemTemplate, contentPrent)

		goutil.setActive(itemGo, true)
	end

	for i = 1, contentPrent.childCount - 1 do
		local itemGo = contentPrent:GetChild(i).gameObject
		local data = dataList[i]

		if data then
			local cell = Astral.LuaComponentContainer.Add(itemGo, ItemCell)
			local itemData = ItemUtil.createItemData({
				itemId = data.code,
				count = data.num
			})

			cell:updateData(itemData)
			cell:setShowSelectedEffect(false)
		end

		goutil.setActive(itemGo, data)
	end
end

function M:refreshVipView()
	local vipStatus = SeasonModel.instance:getVipStatus()

	goutil.setActive(self._txtCostVip1.gameObject, vipStatus == SeasonEnum.VipStatus.None)
	goutil.setActive(self._btnBuyVip1.gameObject, vipStatus == SeasonEnum.VipStatus.None)
	goutil.setActive(self._goUnlockVip1, vipStatus ~= SeasonEnum.VipStatus.None)
	goutil.setActive(self._txtCostVip2.gameObject, vipStatus ~= SeasonEnum.VipStatus.Vip2)
	goutil.setActive(self._btnBuyVip2.gameObject, vipStatus ~= SeasonEnum.VipStatus.Vip2)
	goutil.setActive(self._goUnlockVip2, vipStatus == SeasonEnum.VipStatus.Vip2)

	self._txtCostVip1.text = string.format(lang("tip_store_price"), self:_getVip1Price())
	self._txtCostVip2.text = string.format(lang("tip_store_price"), self:_getVip2Price())
end

function M:_getVip1Price()
	local vip1GoodsId = SeasonConfig.instance:getVip1GoodsId()
	local bugVip1Price = StoreConfig.instance:getGoodsPrice(vip1GoodsId)

	return bugVip1Price and bugVip1Price / 100
end

function M:_getVip2Price()
	local vipStatus = SeasonModel.instance:getVipStatus()
	local vip2GoodsId = SeasonConfig.instance:getVip2GoodsId()
	local upgradeVip2GoodsId = SeasonConfig.instance:getUpgradeVip2GoodsId()
	local upgradeVip2Price = StoreConfig.instance:getGoodsPrice(upgradeVip2GoodsId)
	local bugVip2Price = StoreConfig.instance:getGoodsPrice(vip2GoodsId)
	local bugVip2Price = vipStatus == SeasonEnum.VipStatus.None and bugVip2Price or upgradeVip2Price

	return bugVip2Price and bugVip2Price / 100
end

function M:_onClickBtnBuyVip1()
	local vipStatus = SeasonModel.instance:getVipStatus()

	if vipStatus ~= SeasonEnum.VipStatus.None then
		return
	end

	local vip1GoodsId = SeasonConfig.instance:getVip1GoodsId()
	local costItems = StoreUtil.createCostItems(0, 0)

	StoreAgent.instance:sendBuyGoodsRequest(vip1GoodsId, 1, costItems)
end

function M:_onClickBtnBuyVip2()
	local vipStatus = SeasonModel.instance:getVipStatus()

	if vipStatus == SeasonEnum.VipStatus.None then
		local vip2GoodsId = SeasonConfig.instance:vip2GoodsId()
		local costItems = StoreUtil.createCostItems(0, 0)

		StoreAgent.instance:sendBuyGoodsRequest(vip2GoodsId, 1, costItems)
	elseif vipStatus == SeasonEnum.VipStatus.Vip1 then
		local upgradeVip2GoodsId = SeasonConfig.instance:getUpgradeVip2GoodsId()
		local costItems = StoreUtil.createCostItems(0, 0)

		StoreAgent.instance:sendBuyGoodsRequest(upgradeVip2GoodsId, 1, costItems)
	end
end

function M:_onClickClose()
	self:back()
end

function M:_onClickItem()
	local data = ItemUtil.createItemData({
		itemId = 1004101
	})

	GlobalDispatcher:dispatchEvent(data:getItemMarkType(), data, self._btnCheck.gameObject, nil, true, true, false, false)
end

function M:_onSeasonInfoUpdate()
	self:refreshVipView()
end

function M:_vipBuySucc()
	SeasonAgent.instance:sendSeasonInfoRequest()
end

return M
