-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarymarket/view/AnniversaryMarketRefreshView.lua

module("logic.extensions.anniversarymarket.view.AnniversaryMarketRefreshView", package.seeall)

local AnniversaryMarketRefreshView = class("AnniversaryMarketRefreshView", ViewComponent)

function AnniversaryMarketRefreshView:ctor()
	AnniversaryMarketRefreshView.super.ctor(self)
end

function AnniversaryMarketRefreshView:unbindEvents()
	AnniversaryMarketRefreshView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnDontSave)
	GameUtil.rmClickHandler(self._btnSaveReward)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnLevel)
end

function AnniversaryMarketRefreshView:bindEvents()
	AnniversaryMarketRefreshView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnDontSave, self._onClickBtnDontSave, self)
	GameUtil.addClickHandler(self._btnSaveReward, self._onClickBtnSaveReward, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._btnLevel, self._onClickBtnLevel, self)
	GameUtil.rmClickHandler(self._btnDetail)
	GameUtil.rmClickHandler(self._btnDetail2)
end

function AnniversaryMarketRefreshView:buildUI()
	AnniversaryMarketRefreshView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._mask = self:getGo("rewards/cell2/mask")
	self._refreshEffRoot = self:getGo("rewards/cell2/effRoot")
	self._imgReward = self:getGo("rewards/cell1/mask/imgReward")
	self._imgReward2 = self:getGo("rewards/cell2/mask/imgReward")
	self._imgPet = self:getGo("rewards/cell1/mask/imgPet")
	self._imgPet2 = self:getGo("rewards/cell2/mask/imgPet")
	self._imgPetComp = self._imgPet:GetComponent(goutil.Type_UIImage)
	self._imgPetComp2 = self._imgPet:GetComponent(goutil.Type_UIImage)
	self._txtNum = self:getTxt("rewards/cell1/num/txtNum")
	self._txtNum2 = self:getTxt("rewards/cell2/num/txtNum")
	self._btnDetail = self:getGo("rewards/cell1/btnDetail")
	self._btnDetail2 = self:getGo("rewards/cell2/btnDetail")
	self._bigPrizeTag = self:getGo("rewards/cell2/bigPrizeTag")
	self._btnDontSave = self:getGo("btnDontSave")
	self._btnSaveReward = self:getGo("btnSaveReward")
	self._btnRefresh = self:getGo("btnRefresh")
	self._txtTipNum = self:getTxt("tip/txtNum")
	self._imgItem = self:getGo("tip/imgItem")
	self._btnLevel = self:getGo("level")
	self._txtLevel = self:getTxt("level/txtLevel")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtGoldBarNum = self:getTxt("goldBar/txtNum")
	self._itemGoldBar = self:getGo("goldBar/item")
end

function AnniversaryMarketRefreshView:onExit()
	AnniversaryMarketRefreshView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgPet)
	MaterialMgr.clearIcon(self._imgPet2)
	uGuiUtil.clearImage(self._imgPet)
	uGuiUtil.clearImage(self._imgPet2)
	MaterialMgr.resetAll(self._imgReward)
	MaterialMgr.resetAll(self._imgReward2)
	MaterialMgr.clearIcon(self._imgItem)
end

function AnniversaryMarketRefreshView:onEnter()
	AnniversaryMarketRefreshView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnniversaryMarketRefreshPrizePoolRes, self._onRefreshPrizePoolRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._poolId = checknumber(params[2])
	self._prePrizeId = checknumber(params[3])
	self._actCfg = AnniversaryMarketConfig.instance:getActCfg(self._activityId)
	self._prizePoolCfg = AnniversaryMarketConfig.instance:getPrizePoolCfgById(self._activityId, self._poolId)
	self._info = AnniversaryMarketModel.instance:getInfo(self._activityId)
	self._curPrizeId = params[4] or self._info.newPrizeId

	self:_checkRewardIsPet()
	self:_playRefreshEff()
	self:_onSetUI()
end

local effPath = "20250403/znqsj/fx_ui_znsj_shuaxin.prefab"

function AnniversaryMarketRefreshView:_playRefreshEff()
	self:playViewEffectUniGo(effPath, self._refreshEffRoot.transform, nil, false, nil, nil)
end

function AnniversaryMarketRefreshView:_onSetUI()
	local preMatStr = AnniversaryMarketConfig.instance:getPrizeContent(self._prePrizeId)
	local curMatStr = AnniversaryMarketConfig.instance:getPrizeContent(self._info.newPrizeId)
	local matType, matId, matNum = MaterialMgr.getMatParams(preMatStr)
	local matType2, matId2, matNum2 = MaterialMgr.getMatParams(curMatStr)
	local newMatName = MaterialMgr.getMaterialsName(matType2, matId2)
	local refreshCoinStr = self._actCfg.refreshCoinMpKey
	local matRefreshType, matRefreshId, matRefreshNum = MaterialMgr.getMatParams(refreshCoinStr)
	local hasRefreshCoinNum = MaterialModel.instance:getMaterialsNumber(matRefreshType, matRefreshId)
	local isBigPrize = AnniversaryMarketConfig.instance:getIsBigPrize(self._info.newPrizeId)

	self._info = AnniversaryMarketModel.instance:getInfo(self._activityId)

	MaterialMgr.setIcon(self._imgItem, matRefreshType, matRefreshId, nil, nil)

	local modelCo = CharacterConfig.instance:getModelCo(matId)
	local modelCo2 = CharacterConfig.instance:getModelCo(matId2)
	local isPet = matType == MatType.PET_SKIN or matType == MatType.Pet
	local isPet2 = matType2 == MatType.PET_SKIN or matType2 == MatType.Pet

	if isPet then
		uGuiUtil.setSpriteToImage(self._imgPet, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
		self._imgPetComp:SetNativeSize()
	else
		local proxy = MaterialMgr.setCell(matType, matId, self._imgReward)

		proxy.binder:setBgActive(false)
		proxy.binder:setEffStatus(false)
	end

	if isPet2 then
		uGuiUtil.setSpriteToImage(self._imgPet2, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo2.cardName))
		self._imgPetComp2:SetNativeSize()
	else
		local proxy = MaterialMgr.setCell(matType2, matId2, self._imgReward2)

		proxy.binder:setBgActive(false)
		proxy.binder:setEffStatus(false)
	end

	MaterialMgr.setIcon(self._itemGoldBar, matRefreshType, matRefreshId, nil, nil)

	self._txtNum.text = "×" .. matNum
	self._txtNum2.text = "×" .. matNum2
	self._txtTipNum.text = self._prizePoolCfg.refreshPrice
	self._txtLevel.text = self._info.totalRefreshTimes
	self._txtTitle.text = string.format("恭喜你刷出<color=#eb4642>%s</color>,是否保留奖励?", newMatName)
	self._txtGoldBarNum.text = hasRefreshCoinNum

	GameUtil.SetActive(self._imgPet, isPet)
	GameUtil.SetActive(self._imgPet2, isPet2)
	GameUtil.SetActive(self._imgReward, not isPet)
	GameUtil.SetActive(self._imgReward2, not isPet2)
	GameUtil.SetActive(self._txtNum.gameObject, not isPet)
	GameUtil.SetActive(self._txtNum2.gameObject, not isPet2)
	GameUtil.SetActive(self._bigPrizeTag, isBigPrize)
	GameUtil.addClickHandler(self._btnDetail, function()
		CommonTipsMgr.instance:openMaterialTips(self._prizeCol, matType, matId, matNum)
	end, self)
	GameUtil.addClickHandler(self._btnDetail2, function()
		CommonTipsMgr.instance:openMaterialTips(self._prizeCol, matType2, matId2, matNum2)
	end, self)
end

function AnniversaryMarketRefreshView:_onClickBtnDontSave()
	self:close()
end

function AnniversaryMarketRefreshView:_onClickBtnSaveReward()
	AnniversaryMarketController.instance:sendPM_AnniversaryMarketConfirmRefreshReq(self._activityId, self._poolId)
	self:close()
end

function AnniversaryMarketRefreshView:_onClickBtnRefresh()
	if self._prizePoolCfg then
		local poolName = self._prizePoolCfg.prizePoolName

		if self._prizePoolCfg then
			local refreshPrice = self._prizePoolCfg.refreshPrice
			local matRefreshType, matRefreshId, matRefreshNum = MaterialMgr.getMatParams(self._actCfg.refreshCoinMpKey)
			local isBigPrize = AnniversaryMarketConfig.instance:getIsBigPrize(self._info.newPrizeId)
			local matName = MaterialMgr.getMaterialsName(matRefreshType, matRefreshId)
			local tip = string.format("是否消耗%s×%d,刷新一次%s奖池", matName, refreshPrice, poolName)

			if isBigPrize then
				TipsFacade.instance:openPopupWindow("提示", "已经刷出大奖，是否继续刷新？", function()
					local function succesFunc()
						AnniversaryMarketController.instance:sendPM_AnniversaryMarketRefreshPrizePoolReq(self._activityId, self._poolId)
					end

					local toggleKey = "AnniversaryMarketMainView_" .. self._activityId

					TipsFacade.instance:openPopupCostMatViewWithToggleKey(matRefreshType, matRefreshId, refreshPrice, tip, succesFunc, toggleKey, "今日不再提示刷新消耗")
				end, nil, "确定", "取消")
			else
				local function succesFunc()
					AnniversaryMarketController.instance:sendPM_AnniversaryMarketRefreshPrizePoolReq(self._activityId, self._poolId)
				end

				local toggleKey = "AnniversaryMarketMainView_" .. self._activityId

				TipsFacade.instance:openPopupCostMatViewWithToggleKey(matRefreshType, matRefreshId, refreshPrice, tip, succesFunc, toggleKey, "今日不再提示刷新消耗")
			end
		end
	end
end

function AnniversaryMarketRefreshView:_onClickBtnLevel()
	UIStateManager.instance:push(ViewName.AnniversaryMarketRewardLevelView, self._activityId, self._poolId)
end

function AnniversaryMarketRefreshView:_onConfirmRefreshRes()
	self._onSetUI()
end

function AnniversaryMarketRefreshView:_onRefreshPrizePoolRes(poolId, prePrizeId, newPrizeId)
	self._poolId = poolId
	self._prePrizeId = prePrizeId
	self._curPrizeId = newPrizeId

	self:_onSetUI()
	self:_playRefreshEff()
end

function AnniversaryMarketRefreshView:_checkRewardIsPet()
	self._isPetReward = self._poolId <= AnniversaryMarketModel.BIG_CELL_NUM
end

return AnniversaryMarketRefreshView
