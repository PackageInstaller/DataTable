-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketMainView.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketMainView", package.seeall)

local AnniversaryMarketMainView = class("AnniversaryMarketMainView", ViewComponent)
local MID_CELL_NUM = 2

function AnniversaryMarketMainView:ctor()
	AnniversaryMarketMainView.super.ctor(self)
end

function AnniversaryMarketMainView:unbindEvents()
	AnniversaryMarketMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._goldBar1)
	GameUtil.rmClickHandler(self._goldBar2)
	GameUtil.rmClickHandler(self._btnRewardLevel)
	GameUtil.rmClickHandler(self._btnShare)
	GameUtil.rmClickHandler(self._btnRewardPool)
	GameUtil.rmClickHandler(self._btnTask)

	for idx, cell in ipairs(self._bigCellList) do
		GameUtil.rmClickHandler(cell.btnReset)
		GameUtil.rmClickHandler(cell.btnGet)
		GameUtil.rmClickHandler(cell.btnDetail)
	end

	for idx, cell in ipairs(self._midCellList) do
		GameUtil.rmClickHandler(cell.btnReset)
		GameUtil.rmClickHandler(cell.btnGet)
		GameUtil.rmClickHandler(cell.btnDetail)
	end
end

function AnniversaryMarketMainView:bindEvents()
	AnniversaryMarketMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSold, self._onClickBtnSold, self)
	GameUtil.addClickHandler(self._btnFriendSold, self._onClickBtnFriendSold, self)
	GameUtil.addClickHandler(self._goldBar1, self._onClickBtnGoldBar1, self)
	GameUtil.addClickHandler(self._goldBar2, self._onClickBtnGoldBar2, self)
	GameUtil.addClickHandler(self._btnRewardLevel, self._onClickBtnRewardLevel, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickBtnShare, self)
	GameUtil.addClickHandler(self._btnRewardPool, self._onClickBtnRewardPool, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)

	for idx, cell in ipairs(self._bigCellList) do
		GameUtil.addClickHandler(cell.btnReset, GameUtil.handler(self._onClickBtnReset, self, idx))
		GameUtil.addClickHandler(cell.btnGet, GameUtil.handler(self._onClickBtnGet, self, idx))
	end

	for idx, cell in ipairs(self._midCellList) do
		GameUtil.addClickHandler(cell.btnReset, GameUtil.handler(self._onClickBtnReset, self, idx + AnniversaryMarketModel.BIG_CELL_NUM))
		GameUtil.addClickHandler(cell.btnGet, GameUtil.handler(self._onClickBtnGet, self, idx + AnniversaryMarketModel.BIG_CELL_NUM))
	end
end

function AnniversaryMarketMainView:buildUI()
	AnniversaryMarketMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._goldBar1 = self:getGo("goldBar1")
	self._goldBar2 = self:getGo("goldBar2")
	self._bigCellList = {}

	for i = 1, AnniversaryMarketModel.BIG_CELL_NUM do
		local cell = {}
		local txtTitle = self:getTxt("left/bigCell/cell" .. i .. "/title/txt")
		local txtMatNum = self:getTxt("left/bigCell/cell" .. i .. "/btnReset/txtNum")
		local imgItem = self:getGo("left/bigCell/cell" .. i .. "/btnReset/item")
		local tipHave = self:getGo("left/bigCell/cell" .. i .. "/tipHave")
		local btnReset = self:getGo("left/bigCell/cell" .. i .. "/btnReset")
		local btnGet = self:getGo("left/bigCell/cell" .. i .. "/btnGet")
		local btnDetail = self:getGo("left/bigCell/cell" .. i .. "/btnDetail")
		local txtBtnGet = self:getTxt("left/bigCell/cell" .. i .. "/btnGet/txt")
		local imgReward = self:getGo("left/bigCell/cell" .. i .. "/mask/imgReward")
		local imgPetReward = self:getGo("left/bigCell/cell" .. i .. "/mask/imgPetReward")
		local tipHave = self:getGo("left/bigCell/cell" .. i .. "/tipHave")
		local btnGetChangeGroup = btnGet:GetComponent(ComponentType.UIChangeGroup)
		local changeGroup = self:getGo("left/bigCell/cell" .. i .. "/tipHave"):GetComponent(ComponentType.UIChangeGroup)

		cell.txtTitle = txtTitle
		cell.tipHave = tipHave
		cell.btnReset = btnReset
		cell.txtCostMatNum = txtMatNum
		cell.imgCostItem = imgItem
		cell.btnGet = btnGet
		cell.txtBtnGet = txtBtnGet
		cell.imgPetReward = imgPetReward
		cell.imgReward = imgReward
		cell.imgBtnComp = btnGet:GetComponent(goutil.Type_UIImage)
		cell.tipHave = tipHave
		cell.btnGetChangeGroup = btnGetChangeGroup
		cell.changeGroup = changeGroup
		cell.btnDetail = btnDetail
		cell.bigPrizeTag = self:getGo("left/bigCell/cell" .. i .. "/bigPrizeTag")

		table.insert(self._bigCellList, cell)
	end

	self._midCellList = {}

	for i = 1, MID_CELL_NUM do
		local cell = {}
		local txtTitle = self:getTxt("left/midCell/cell" .. i .. "/title/txt")
		local txtNum = self:getTxt("left/midCell/cell" .. i .. "/txtNum")
		local txtCostMatNum = self:getTxt("left/midCell/cell" .. i .. "/btnReset/txtNum")
		local imgCostItem = self:getGo("left/midCell/cell" .. i .. "/btnReset/item")
		local imgReward = self:getGo("left/midCell/cell" .. i .. "/imgReward")
		local btnGet = self:getGo("left/midCell/cell" .. i .. "/btnGet")
		local btnDetail = self:getGo("left/midCell/cell" .. i .. "/btnDetail")
		local txtBtnGet = self:getTxt("left/midCell/cell" .. i .. "/btnGet/txt")
		local btnReset = self:getGo("left/midCell/cell" .. i .. "/btnReset")
		local changeGroup = btnGet:GetComponent(ComponentType.UIChangeGroup)

		cell.txtTitle = txtTitle
		cell.txtNum = txtNum
		cell.txtCostMatNum = txtCostMatNum
		cell.imgCostItem = imgCostItem
		cell.imgReward = imgReward
		cell.btnGet = btnGet
		cell.imgBtnComp = btnGet:GetComponent(goutil.Type_UIImage)
		cell.txtBtnGet = txtBtnGet
		cell.btnReset = btnReset
		cell.changeGroup = changeGroup
		cell.btnDetail = btnDetail
		cell.bigPrizeTag = self:getGo("left/midCell/cell" .. i .. "/bigPrizeTag")
		cell.imgState = self:getGo("left/midCell/cell" .. i .. "/imgState")

		table.insert(self._midCellList, cell)
	end

	self._txtNum = self:getTxt("goldBar1/txtNum")
	self._goldBarItem = self:getGo("goldBar1/item")
	self._txtNum2 = self:getTxt("goldBar2/txtNum")
	self._goldBarItem2 = self:getGo("goldBar2/item")
	self._imgSold = self:getGo("right/soldBar/imgSold")
	self._txtPrice = self:getTxt("right/soldBar/txtPrice")
	self._highPrizeTag = self:getGo("right/soldBar/highPrizeTag")
	self._lowPrizeTag = self:getGo("right/soldBar/lowPrizeTag")
	self._txtSoldFriendNum = self:getTxt("right/tip/txtLeftNum")
	self._btnSold = self:getGo("right/btnSold")
	self._btnFriendSold = self:getGo("right/btnFriendSold")
	self._btnRewardLevel = self:getGo("jumpBtnCol/btnRewardLevel")
	self._btnShare = self:getGo("jumpBtnCol/btnShare")
	self._btnRewardPool = self:getGo("jumpBtnCol/btnRewardPool")
	self._btnTask = self:getGo("jumpBtnCol/btnTask")
	self._btnTaskRedPoint = self:getGo("jumpBtnCol/btnTask/redPoint")
	self._sloganEffRoot = self:getGo("sloganEffRoot")
	self._txtTime = self:getTxt("time/txt")
end

function AnniversaryMarketMainView:onExit()
	AnniversaryMarketMainView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgSold)
	MaterialMgr.clearIcon(self._goldBarItem)
	MaterialMgr.clearIcon(self._goldBarItem2)

	for i, cell in ipairs(self._bigCellList) do
		MaterialMgr.resetAll(cell.imgReward)
		MaterialMgr.clearIcon(cell.imgCostItem)
	end

	for i, cell in ipairs(self._midCellList) do
		MaterialMgr.resetAll(cell.imgReward)
		MaterialMgr.clearIcon(cell.imgCostItem)
	end

	if self._sloganEffect then
		UIEffectManager.instance:stopEffect(self._sloganEffect)

		self._sloganEffect = nil
	end
end

function AnniversaryMarketMainView:onEnter()
	AnniversaryMarketMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketConfirmRefreshRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketRefreshPrizePoolRes, self._onRefreshPrizePoolRes, self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketGainPrizePoolRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketGetMyShareCodeRes, self._onGetMyShareCodeRes, self)
	self.addGEvent(self, GlobalNotify.OnMaterialItemChange, self._onItemCountChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = 467

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)
	end

	self._info = AnniversaryMarketModel.instance:getInfo(self._activityId)
	self._poolInfos = self._info and self._info.prizePools
	self._actCfg = AnniversaryMarketConfig.instance:getActCfg(self._activityId)

	RedPointController.instance:regRedPoint(self._btnTaskRedPoint, 506)
	AnniversaryMarketController.instance:sendPM_AnniversaryMarketGetInfoReq(self._activityId)

	self._txtTime.text = ActivityDefineController.instance:getActTimeDesc(self._activityType, self._activityId)
end

function AnniversaryMarketMainView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function AnniversaryMarketMainView:_updateData()
	self._info = AnniversaryMarketModel.instance:getInfo(self._activityId)
	self._poolInfos = self._info and self._info.prizePools
end

function AnniversaryMarketMainView:_updateUI()
	for i, cell in ipairs(self._bigCellList) do
		local poolInfo = self._poolInfos[i]
		local poolCfg = AnniversaryMarketConfig.instance:getPrizePoolCfgById(self._activityId, i)
		local prizeId = poolInfo and poolInfo.prizeId
		local refreshPrice = poolCfg and poolCfg.refreshPrice
		local matRefreshType, matRefreshId, matRefreshNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)
		local rewardStr = AnniversaryMarketConfig.instance:getPrizeContent(prizeId)
		local matType, matId, matNum = MaterialMgr.getMatParams(rewardStr)
		local rewardArr = string.split(rewardStr, "#")
		local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
		local hasGainPrize = poolInfo and poolInfo.hasGainPrize
		local alreadyReward = hasNum >= 1
		local inGetPrizeTime = self:_inGetPrizeTime(i)
		local prizeCfg = AnniversaryMarketConfig.instance:getMarketPrizeCfg(prizeId)

		cell.txtTitle.text = poolCfg.prizePoolName
		cell.txtCostMatNum.text = refreshPrice
		cell.txtBtnGet.text = hasGainPrize and "已领取" or "领取"

		local modelCo = CharacterConfig.instance:getModelCo(matId)
		local isPet = matType == MatType.PET_SKIN or matType == MatType.Pet

		if isPet then
			uGuiUtil.setSpriteToImage(cell.imgPetReward, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
		else
			local proxy = MaterialMgr.setCell(matType, matId, cell.imgReward)

			proxy.binder:setBgActive(false)
			proxy.binder:setEffStatus(false)
		end

		GameUtil.SetActive(cell.tipHave, hasNum <= 0)
		GameUtil.SetActive(cell.imgPetReward, isPet)
		GameUtil.SetActive(cell.imgReward, not isPet)
		GameUtil.SetActive(cell.bigPrizeTag, prizeCfg.bigPrize)
		MaterialMgr.setIcon(cell.imgCostItem, matRefreshType, matRefreshId, nil, nil)

		if hasGainPrize then
			cell.btnGetChangeGroup:SetState(1)
		else
			cell.btnGetChangeGroup:SetState(0)
			GameUtil.SetGray(cell.imgBtnComp, not inGetPrizeTime)
		end

		cell.changeGroup:SetState(alreadyReward and 1 or 0)
		GameUtil.addClickHandler(cell.btnDetail, function()
			CommonTipsMgr.instance:openMaterialTips(self._prizeCol, matType, matId, rewardArr[3])
		end, self)
	end

	for i, cell in ipairs(self._midCellList) do
		local poolInfo = self._poolInfos[i + AnniversaryMarketModel.BIG_CELL_NUM]
		local poolCfg = AnniversaryMarketConfig.instance:getPrizePoolCfgById(self._activityId, i + AnniversaryMarketModel.BIG_CELL_NUM)

		if poolCfg then
			local prizeId = poolInfo.prizeId
			local refreshPrice = poolCfg and poolCfg.refreshPrice
			local rewardStr = AnniversaryMarketConfig.instance:getPrizeContent(prizeId)
			local matType, matId, matNum = MaterialMgr.getMatParams(rewardStr)
			local matRefreshType, matRefreshId, matRefreshNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)
			local inGetPrizeTime = self:_inGetPrizeTime(i)
			local prizeCfg = AnniversaryMarketConfig.instance:getMarketPrizeCfg(prizeId)
			local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
			local hasGainPrize = poolInfo.hasGainPrize

			cell.txtTitle.text = poolCfg.prizePoolName
			cell.txtCostMatNum.text = refreshPrice
			cell.txtBtnGet.text = hasGainPrize and "已领取" or "领取"
			cell.txtNum.text = string.format("× %d", matNum)

			local proxy = MaterialMgr.setCell(matType, matId, cell.imgReward)

			proxy.binder:setBgActive(false)
			proxy.binder:setEffStatus(false)
			MaterialMgr.setIcon(cell.imgCostItem, matRefreshType, matRefreshId, nil, nil)
			GameUtil.SetActive(cell.tipHave, hasNum <= 0)
			GameUtil.SetActive(cell.bigPrizeTag, prizeCfg.bigPrize)

			if hasGainPrize then
				cell.changeGroup:SetState(1)
			else
				cell.changeGroup:SetState(0)
				GameUtil.SetGray(cell.imgBtnComp, not inGetPrizeTime)
			end

			GameUtil.addClickHandler(cell.btnDetail, function()
				CommonTipsMgr.instance:openMaterialTips(self._prizeCol, matType, matId, matNum)
			end, self)

			if self._activityId == 467003 and i == 1 then
				GameUtil.SetActive(cell.btnGet, false)
				GameUtil.SetActive(cell.btnReset, false)
				GameUtil.SetActive(cell.imgState, true)
			end
		end
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)
	local refreshMatType, refreshMatId, refreshMatNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)

	self._txtNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)

	MaterialMgr.setIcon(self._goldBarItem, matType, matId)
	MaterialMgr.setIcon(self._imgSold, refreshMatType, refreshMatId)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)
	local hasRefreshCoinNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	MaterialMgr.setIcon(self._goldBarItem2, matType, matId)

	self._txtNum2.text = hasRefreshCoinNum

	local sellForOtherDailyLimit = self._actCfg.sellForOtherDailyLimit

	if sellForOtherDailyLimit - self._info.otherSellCount >= 0 then
		if not (sellForOtherDailyLimit - self._info.otherSellCount) then
			local leftNum = 0

			self._txtSoldFriendNum.text = string.format("<color=#20B376>%s</color>/%s", leftNum, sellForOtherDailyLimit)
			self._txtPrice.text = self._info.todayPrice

			local curPriceCfgs = AnniversaryMarketConfig.instance:getPriceRangesCfg(self._actCfg.commonPricePlanId)
			local curPriceCfg = curPriceCfgs[#curPriceCfgs]
			local maxRange = curPriceCfg.priceRange
			local isHighPrize = self._info.todayPrice >= maxRange[1]

			GameUtil.SetActive(self._highPrizeTag, isHighPrize)
			GameUtil.SetActive(self._lowPrizeTag, not isHighPrize)
		end
	end
end

function AnniversaryMarketMainView:_onClickBtnReset(idx)
	local prizePoolInfo = self._poolInfos[idx]
	local hasGet = prizePoolInfo.hasGainPrize

	if hasGet then
		FloatWordMgr.instance:show("该奖池已领取,无需刷新")

		return
	end

	local poolCfg = AnniversaryMarketConfig.instance:getPrizePoolCfgById(self._activityId, idx)
	local poolName = poolCfg and poolCfg.prizePoolName
	local refreshPrice = poolCfg and poolCfg.refreshPrice
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local tip = string.format("是否消耗%s×%d,刷新一次%s奖池", matName, refreshPrice, poolName)

	local function succesFunc()
		AnniversaryMarketController.instance:sendPM_AnniversaryMarketRefreshPrizePoolReq(self._activityId, idx)
	end

	local toggleKey = "AnniversaryMarketMainView_" .. self._activityId

	TipsFacade.instance:openPopupCostMatViewWithToggleKey(matType, matId, refreshPrice, tip, succesFunc, toggleKey, "今日不再提示刷新消耗")
end

function AnniversaryMarketMainView:_onClickBtnGet(idx)
	local prizePoolInfo = self._poolInfos[idx]
	local hasGet = prizePoolInfo.hasGainPrize
	local inGetPrizeTime = self:_inGetPrizeTime(idx)

	if not inGetPrizeTime then
		local prizePoolCfg = AnniversaryMarketConfig.instance:getPrizePoolCfgById(self._activityId, idx)
		local timeStamp = GameUtil.string2time(prizePoolCfg.startTime)
		local duration = timeStamp - ServerTime.now()

		FloatWordMgr.instance:show(duration >= 31536000 and GameUtil.formatTimeStamp("奖励在%Y年%m月%d日%H:%M后才可领取，请耐心等待~", timeStamp) or GameUtil.formatTimeStamp("奖励在%m月%d日%H:%M后才可领取，请耐心等待~", timeStamp))

		return
	end

	if hasGet then
		FloatWordMgr.instance:show("该奖池已领取")

		return
	end

	local prizeId = prizePoolInfo.prizeId
	local prizeContent = AnniversaryMarketConfig.instance:getPrizeContent(prizeId)
	local matType, matId, matNum = MaterialMgr.getMatParams(prizeContent)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local tip = string.format("是否领取奖励%s?\n<color=#FF0000FF>该奖励仅可领取一次,领取后无法刷新,请慎重选择!</color>", matName)

	local function okFunc()
		AnniversaryMarketController.instance:sendPM_AnniversaryMarketGainPrizePoolReq(self._activityId, idx)
	end

	TipsFacade.instance:openPopupWindow("提示", tip, okFunc, nil, "确定", nil)
end

function AnniversaryMarketMainView:_onClickBtnGoldBar1()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)

	CommonTipsMgr.instance:openMaterialTips(self._goldBar1, checknumber(matType), checknumber(matId))
end

function AnniversaryMarketMainView:_onClickBtnGoldBar2()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)

	CommonTipsMgr.instance:openMaterialTips(self._goldBar2, checknumber(matType), checknumber(matId))
end

function AnniversaryMarketMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function AnniversaryMarketMainView:_onClickBtnSold()
	local userName = RoleModel.instance:getUserName()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)
	local hasSellMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if hasSellMatNum <= 0 then
		local name = MaterialMgr.getMaterialsName(matType, matId)

		FloatWordMgr.instance:show(string.format("%s数量不足", name))

		return
	end

	local isFriend = false

	UIStateManager.instance:push(ViewName.AnniversaryMarketSoldView, self._activityId, isFriend)
end

function AnniversaryMarketMainView:_onClickBtnFriendSold()
	local userName = RoleModel.instance:getUserName()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)
	local hasSellMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if hasSellMatNum <= 0 then
		local name = MaterialMgr.getMaterialsName(matType, matId)

		FloatWordMgr.instance:show(string.format("%s数量不足", name))

		return
	end

	UIStateManager.instance:push(ViewName.AnniversaryMarketFriendView, self._activityId)
end

function AnniversaryMarketMainView:_onClickBtnRewardLevel()
	UIStateManager.instance:push(ViewName.AnniversaryMarketRewardLevelView, self._activityId)
end

function AnniversaryMarketMainView:_onClickBtnShare()
	self._isFromShare = true

	AnniversaryMarketController.instance:sendPM_AnniversaryMarketGetMyShareCodeReq(self._activityId)
end

function AnniversaryMarketMainView:_onClickBtnRewardPool()
	UIStateManager.instance:push(ViewName.AnniversaryMarketRewardPoolView, self._activityId)
end

function AnniversaryMarketMainView:_onClickBtnTask()
	local btnStr = self._actCfg.jumpTask

	GotoMgr.gotoByString(btnStr)
end

function AnniversaryMarketMainView:_onRefreshPrizePoolRes(poolId, prePrizeId, newPrizeId)
	UIStateManager.instance:push(ViewName.AnniversaryMarketRefreshView, self._activityId, poolId, prePrizeId, newPrizeId)
end

function AnniversaryMarketMainView:_onGetMyShareCodeRes(shareCode, otherSellCount)
	if self._isFromShare then
		UIStateManager.instance:push(ViewName.AnniversaryMarketShareFriendView, self._activityId, shareCode, otherSellCount)
	end

	self._isFromShare = false
end

function AnniversaryMarketMainView:_onItemCountChange()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.sellScoreMpKey)
	local hasSellMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	MaterialMgr.setIcon(self._goldBarItem, matType, matId)

	self._txtNum.text = hasSellMatNum

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)
	local hasRefreshCoinNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	MaterialMgr.setIcon(self._goldBarItem2, matType, matId)

	self._txtNum2.text = hasRefreshCoinNum
end

function AnniversaryMarketMainView:_inGetPrizeTime(idx)
	local prizePoolCfg = AnniversaryMarketConfig.instance:getPrizePoolCfgById(self._activityId, idx)
	local timeStamp = GameUtil.string2time(prizePoolCfg.startTime)

	return timeStamp <= ServerTime.now()
end

function AnniversaryMarketMainView:_playEffect()
	local effPath = "20251121/zhounianjishihuigui/fx_ui_znjshg_fw.prefab"

	self._sloganEffect = UIEffectManager.instance:playEffect(self, effPath, self._sloganEffRoot.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self.mainGO.transform)
	end)

	self._sloganEffect:setParent(self._sloganEffRoot.transform)
	self._sloganEffect:setLocalPos(0, 0, 0)
	self._sloganEffect:setScale(1)
end

return AnniversaryMarketMainView
