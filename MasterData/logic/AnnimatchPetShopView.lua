-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchPetShopView.lua

module("logic.extensions.annimatch.view.AnnimatchPetShopView", package.seeall)

local AnnimatchPetShopView = class("AnnimatchPetShopView", ViewComponent)

function AnnimatchPetShopView:ctor()
	AnnimatchPetShopView.super.ctor(self)
end

function AnnimatchPetShopView:unbindEvents()
	AnnimatchPetShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnNext)
end

function AnnimatchPetShopView:bindEvents()
	AnnimatchPetShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickBtnNext, self)
end

function AnnimatchPetShopView:buildUI()
	AnnimatchPetShopView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnNext = self:getGo("btnNext")
	self._btnRefresh = self:getGo("btnRefresh")
	self._txtGold = self:getTxt("goldbar/txtGold")
	self._imgGold = self:getGo("goldbar/imgGold")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("card")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tablecellSelect = self:getGo("tableviewSelect/tablecellSelect")
	self._tableviewSelect = self:getGo("tableviewSelect")
	self._scrollListSelect = ScrollerList.create(self._tableviewSelect, self._tablecellSelect, GameUtil.handler(self._updateCellSelect, self), GameUtil.handler(self._clearCellSelect, self))
end

function AnnimatchPetShopView:onExit()
	AnnimatchPetShopView.super.onExit(self)
	self._scrollList:dispose()
	self._scrollListSelect:dispose()
end

function AnnimatchPetShopView:onEnter()
	AnnimatchPetShopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnnualCompetitionBuySysPetRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_AnnualCompetitionRefreshSysPetShopRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_AnnualCompetitionFinishBuyPetRes, self._onFinishBuyPetRes, self)

	self._activityId = AnnimatchController.instance:getCurrActId()
	self._info = AnnimatchModel.instance:getInfo(self._activityId)
	self._actCfg = AnnimatchConfig.instance:getCfgById(self._activityId)
	self._selectPetList = {}

	self:_onSetUI()
end

function AnnimatchPetShopView:_onSetUI()
	local shop = self._info.shop

	if not shop.alternativeCreepsIds then
		if not self._info.creepsIds then
			local creepsIds = {}
			local totalCost = self:_getTotalCost()

			self._leftGold = self._actCfg.sysTotalCost - totalCost
			self._txtGold.text = self._leftGold

			self._scrollList:reloadData(shop.alternativeCreepsIds)
			self._scrollListSelect:reloadData(creepsIds)
		end
	end
end

function AnnimatchPetShopView:_onUpdate()
	self._info = AnnimatchModel.instance:getInfo(self._activityId)

	if not self._info.shop.alternativeCreepsIds then
		local shopRefreshTime = self._info.shop.refreshTimes

		if not self._info.creepsIds then
			local totalCost = self:_getTotalCost()

			self._leftGold = self._actCfg.sysTotalCost - totalCost
			self._txtGold.text = self._leftGold

			self._scrollList:reloadData(self._info.shop.alternativeCreepsIds)
			self._scrollListSelect:reloadData(self._info.creepsIds)
			GameUtil.SetGray(self._btnRefresh, shopRefreshTime >= self._actCfg.sysRefreshTimes)
		end
	end
end

function AnnimatchPetShopView:_updateCell(view, cell, data)
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local sellOut = goutil.findChild(cell, "sellOut")
	local rare = goutil.findChild(cell, "cell/rare")
	local con = goutil.findChild(cell, "cell/mask/con")
	local summon = goutil.findChild(cell, "summon")
	local summonCon = goutil.findChild(cell, "summon/con")
	local job1 = goutil.findChild(cell, "cell/jobbg1/job1")
	local jobbg1 = goutil.findChild(cell, "cell/jobbg1")
	local txtName = goutil.findChildTextComponent(cell, "cell/txtName")
	local txtCost = goutil.findChildTextComponent(cell, "cell/txtCost")
	local bgChangeComp = goutil.findChild(cell, "cell/bg"):GetComponent("UIImageSpriteChange")
	local attrChangeComp = goutil.findChild(cell, "cell/attr"):GetComponent("UIImageSpriteChange")
	local jobChangeComp = goutil.findChild(cell, "cell/jobbg/job"):GetComponent("UIImageSpriteChange")
	local jobChangeComp1 = goutil.findChild(cell, "cell/jobbg1/job1"):GetComponent("UIImageSpriteChange")

	if not self._info.creepsIds then
		local creepsIds = {}
		local creepsId = data
		local hasSellOut = table.indexof(creepsIds, creepsId)
		local petMo = AnnimatchModel.instance:getPetMo(self._activityId, creepsId)
		local raceId = petMo.raceId
		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
		local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

		GameUtil.setUIImageSpriteIdx(jobChangeComp, firstJobIdx - 1)
		GameUtil.SetActive(job1, secondJobIdx > 20)
		GameUtil.SetActive(jobbg1, secondJobIdx > 20)
		GameUtil.SetActive(sellOut, hasSellOut)

		if secondJobIdx > 20 then
			GameUtil.setUIImageSpriteIdx(jobChangeComp1, secondJobIdx - 1 - 20)
		end

		txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, petMo.curFaceId)
		txtCost.text = AnnimatchConfig.instance:getCostByCreepsId(self._activityId, creepsId)

		MaterialMgr.setCell(MatType.Rare, raceId, rare)

		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

		race = race % 10

		local targetValue = race - 1

		GameUtil.setUIImageSpriteIdx(attrChangeComp, targetValue)
		GameUtil.setUIImageSpriteIdx(bgChangeComp, targetValue)
		GameUtil.SetActive(summon, false)

		if petMo.summonedPetId > 0 then
			GameUtil.SetActive(summon, true)

			local sommonPetMo = AnnimatchModel.instance:getPetMo(self._activityId, petMo.summonedPetId)
			local proxy = MaterialMgr.setCellByMo(sommonPetMo, summonCon)

			if proxy then
				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					CommonTipsMgr.instance:showPetTips(sommonPetMo, true)
				end)
			end
		end

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(petMo.curFaceId))

		uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
		GameUtil.addClickHandler(btnSelect, function()
			self:_onClickBtnSelect(creepsId)
		end)
	end
end

function AnnimatchPetShopView:_clearCell(cell)
	local summonCon = goutil.findChild(cell, "summon/con")
	local btnSelect = goutil.findChild(cell, "btnSelect")

	MaterialMgr.resetAll(summonCon)
	GameUtil.rmClickHandler(btnSelect)
end

function AnnimatchPetShopView:_updateCellSelect(view, cell, data)
	local btnPetTip = goutil.findChild(cell, "btnPetTip")
	local pet = goutil.findChild(cell, "pet")
	local petMo = AnnimatchModel.instance:getPetMo(self._activityId, data)

	MaterialMgr.setCell(MatType.Pet, petMo.curFaceId, pet)
	GameUtil.addClickHandler(btnPetTip, function()
		CommonTipsMgr.instance:showPetTips(petMo, true)
	end)
end

function AnnimatchPetShopView:_clearCellSelect(cell)
	local btnPetTip = goutil.findChild(cell, "btnPetTip")
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
	GameUtil.rmClickHandler(btnPetTip)
end

function AnnimatchPetShopView:_onClickBtnSelect(creepsId)
	if not self._info.creepsIds then
		local creepsIds = {}
		local hasSellOut = table.indexof(creepsIds, creepsId)

		if hasSellOut then
			FloatWordMgr.instance:show("该精灵已售罄，无需重复购买")

			return
		end

		local cost = AnnimatchConfig.instance:getCostByCreepsId(self._activityId, creepsId)
		local petMo = AnnimatchModel.instance:getPetMo(self._activityId, creepsId)
		local petName = MaterialMgr.getMaterialsName(MatType.PET_SKIN, petMo.curFaceId)

		if cost > checknumber(self._leftGold) then
			FloatWordMgr.instance:show("剩余竞技币不足，无法购买")

			return
		end

		local function okFunc()
			AnnimatchController.instance:sendPM_AnnualCompetitionBuySysPetReq(self._activityId, creepsId)
		end

		local content = string.format("是否花费%d购买%s，购买后无法取消", cost, petName)
		local key = "AnnimatchPetShopView_" .. self._activityId

		if GameUtil.getUserDayData(key) then
			okFunc()
		else
			local function funcTog()
				GameUtil.saveUserDayData(key, true)
			end

			TipsFacade.instance:openPopupWindowWithTog("提示", content, okFunc, nil, funcTog, "确定", "取消", "今日不再提示")
		end
	end
end

function AnnimatchPetShopView:_onClickBtnRefresh()
	local shopRefreshTime = self._info.shop.refreshTimes

	if shopRefreshTime >= self._actCfg.sysRefreshTimes then
		FloatWordMgr.instance:show("刷新次数不足，无法刷新")

		return
	end

	local function okFunc()
		AnnimatchController.instance:sendPM_AnnualCompetitionRefreshSysPetShopReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", "是否刷新商店（仅一次机会）", okFunc, nil, "确定", "取消")
end

function AnnimatchPetShopView:_onClickBtnNext()
	if not self._info.creepsIds then
		local creepsIds = {}
		local selectPetNum = #creepsIds

		if not self._info.creepsIds then
			local totalCost = self:_getTotalCost()
			local sysTotalCost = self._actCfg.sysTotalCost

			if selectPetNum <= 0 then
				FloatWordMgr.instance:show("请选择精灵后进入竞技")

				return
			elseif totalCost < sysTotalCost then
				local matStr = AnnimatchConfig.instance:getCommonByKey("SYS_COST_MAT_STR")
				local matName = MaterialMgr.getMaterialsNameByCfg(matStr)
				local tipsContent = string.format("您有剩余%s未使用完,是否继续,选择继续后,将无法回到商店继续购买", matName)

				local function okFunc()
					AnnimatchController.instance:sendPM_AnnualCompetitionFinishBuyPetReq(self._activityId)
				end

				TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
			else
				AnnimatchController.instance:sendPM_AnnualCompetitionFinishBuyPetReq(self._activityId)
			end
		end
	end
end

function AnnimatchPetShopView:_getTotalCost()
	local totalCost = 0

	if not self._info.creepsIds then
		for i, creepsId in ipairs(self._info.creepsIds) do
			local petMo = AnnimatchModel.instance:getPetMo(self._activityId, creepsId)

			if petMo.summonMasterId <= 0 then
				local cost = AnnimatchConfig.instance:getCostByCreepsId(self._activityId, creepsId)

				totalCost = totalCost + cost
			end
		end

		return totalCost
	end
end

function AnnimatchPetShopView:_onFinishBuyPetRes()
	UIStateManager.instance:push(ViewName.AnnimatchmainView)
	UIStateManager.instance:popByName(ViewName.AnnimatchPetShopView)
end

return AnnimatchPetShopView
