-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManShopView.lua

module("logic.extensions.beastrichman.view.BeastRichManShopView", package.seeall)

local BeastRichManShopView = class("BeastRichManShopView", ViewComponent)

function BeastRichManShopView:ctor()
	BeastRichManShopView.super.ctor(self)
end

function BeastRichManShopView:unbindEvents()
	BeastRichManShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnNoBuy)
	GameUtil.rmClickHandler(self._btnGoldBar)
	GameUtil.rmClickHandler(self._btnTip)
end

function BeastRichManShopView:bindEvents()
	BeastRichManShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnNoBuy, self._onClickBtnNoBuy, self)
	GameUtil.addClickHandler(self._btnGoldBar, self._onClickBtnGoldBar, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function BeastRichManShopView:buildUI()
	BeastRichManShopView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnNoBuy = self:getGo("btnNoBuy")
	self._btnGoldBar = self:getGo("goldbar/btnGoldBar")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtDesc = self:getTxt("bubble/txtDesc")
	self._txtGold = self:getTxt("goldbar/txtGold")
	self._imgIcon = self:getGo("goldbar/imgIcon")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._roleconGo = self:getGo("rolecon")
end

function BeastRichManShopView:onExit()
	BeastRichManShopView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgIcon)
	self._scrollList:dispose()

	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)
end

function BeastRichManShopView:onEnter()
	BeastRichManShopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleEventRes, self._onEventRes, self)

	self._params = self:getOpenParam() or {}
	self._activityId = checknumber(self._params[1])
	self._zoneId = checknumber(self._params[2])
	self._gridId = checknumber(self._params[3])
	self._isCurGrid = self._params[4]
	self._gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._gridId)

	local eventId = self._gridCfg.eventId

	self._eventCfg = BeastRichmanConfig.instance:getEventCfgById(self._activityId, eventId)
	self._shopId = checknumber(self._eventCfg.eventParam)
	self._shopCfgs = BeastRichmanConfig.instance:getShopCfgsById(self._activityId, self._shopId)
	self._actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)
	self._petCardItem = {}
	self._info = BeastRichmanModel.instance:getInfo(self._activityId)

	if self._info then
		self._supportPetIds = self._info.supportPetIds or {}
	end

	self:_initUI()
end

function BeastRichManShopView:_initUI()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.scoreMatStr)

	if self._info then
		self._txtGold.text = self._info.score or 0
	end

	MaterialMgr.setIcon(self._imgIcon, matType, matId, nil, nil)
	self._scrollList:reloadData(self._shopCfgs)
	GameUtil.SetActive(self._btnNoBuy, false)

	local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
	local skinId = zoneCfg.skinId
	local posAndSize = zoneCfg.posAndSize

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, skinId, self._roleconGo, 1, nil, true)

	GameUtil.setLocalPos(self._roleconGo, posAndSize[1], posAndSize[2], 0)
	GameUtil.setLocalScale(self._roleconGo, posAndSize[3], posAndSize[3], posAndSize[3])
end

function BeastRichManShopView:_onEventRes()
	BeastRichmanController.instance:sendPM_BeastRichManInfoReq(self._activityId)
end

function BeastRichManShopView:_onUpdate()
	self._info = BeastRichmanModel.instance:getInfo(self._activityId)

	if self._info then
		self._supportPetIds = self._info.supportPetIds or {}
	end

	self._scrollList:reloadData(self._shopCfgs)

	if self._info then
		self._txtGold.text = self._info.score or 0
	end
end

function BeastRichManShopView:_updateCell(view, cell, data)
	local btnTips = goutil.findChild(cell.gameObject, "btnTips")
	local btnBuy = goutil.findChild(cell.gameObject, "btnBuy")
	local mainGo = goutil.findChild(cell.gameObject, "root")
	local con = goutil.findChild(mainGo, "mask/con")
	local txtCost = goutil.findChildTextComponent(cell, "cost/txtCost")
	local costIcon = goutil.findChild(cell, "cost/icon")
	local goCost = goutil.findChild(cell, "cost")
	local goTxtHadBuyTips = goutil.findChild(cell, "txtHadBuyTips")
	local qiyueGo = goutil.findChild(cell, "qiyue")
	local qiyueItemGo = goutil.findChild(cell, "qiyue/item")
	local txtLvl = goutil.findChildTextComponent(cell, "txtLvl")
	local Nego_Attr = goutil.findChild(cell, "layout/Nego_Attr")
	local Img_attr = goutil.findChild(cell, "layout/Nego_Attr/Img_attr")
	local Nego_Job = goutil.findChild(cell, "layout/Nego_Job")
	local ImgC_Job = goutil.findChild(cell, "layout/Nego_Job/ImgC_Job")
	local Nego_Job1 = goutil.findChild(cell, "layout/Nego_Job1")
	local ImgC_Job_1 = goutil.findChild(cell, "layout/Nego_Job1/ImgC_Job")
	local limitGo = goutil.findChild(cell, "limit")
	local summonedPetId = checknumber(data.summonedPetId)
	local hasSummoned = summonedPetId > 0
	local skinId = checknumber(data.faceId)

	if skinId <= 0 then
		skinId = data.raceId
	end

	local hasSoldPet = table.indexof(self._supportPetIds, data.id)

	goutil.setActive(qiyueGo, hasSummoned)

	if hasSummoned then
		local rentCfg = BeastRichmanConfig.instance:getShopCfgByCreepsId(self._activityId, self._shopId, summonedPetId)
		local proxy = MaterialMgr.setCell(MatType.Pet, rentCfg.raceId, qiyueItemGo)

		if proxy then
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				local fMoS = FightingPowerPetMo.New()

				fMoS:fromChallengeCreepCo(rentCfg)

				local bagPetMoS = fMoS:toBaseBagPetMo()

				if bagPetMoS then
					CommonTipsMgr.instance:showPetTips(bagPetMoS)
				end
			end)
		end
	end

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	txtLvl.text = data.lv

	local scoreMat = self._actCfg.scoreMatStr
	local matType, matId, matNum = MaterialMgr.getMatParams(scoreMat)

	txtCost.text = data.cost

	MaterialMgr.setIcon(costIcon, matType, matId)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = race % 10

	GameUtil.setUIImageSpriteIdx(Img_attr, race - 1)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

	GameUtil.setUIImageSpriteIdx(ImgC_Job, firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(skinId)
	local isNeedJob1 = secondJobIdx > 20

	GameUtil.SetActive(Nego_Job1, isNeedJob1)

	if isNeedJob1 then
		GameUtil.setUIImageSpriteIdx(ImgC_Job_1, secondJobIdx - 1 - 20)
	end

	local hadBuy = hasSoldPet

	goutil.setActive(goCost, not hadBuy)
	goutil.setActive(goTxtHadBuyTips, hadBuy)
	goutil.setActive(limitGo, hadBuy)
	GameUtil.addClickHandler(btnTips, GameUtil.handler(self._onClickBtnTips, self, data.id))
	GameUtil.addClickHandler(btnBuy, function()
		if not self._isCurGrid then
			FloatWordMgr.instance:show("当前未触发此建筑事件，无法操作")

			return
		end

		if hasSoldPet then
			FloatWordMgr.instance:show("已购买该精灵，无需重复购买")

			return
		end

		local cost = data.cost
		local skinId = checknumber(data.faceId)

		UIStateManager.instance:push(ViewName.BeastRichManShopTipView, self._activityId, self._zoneId, self._gridId, data.id, cost, (skinId > 0 or nil) and PetSkinConfig.instance:getPetSkinName(skinId))
	end, self)
end

function BeastRichManShopView:_onClickBtnTips(creepsId)
	local rentCfg = BeastRichmanConfig.instance:getShopCfgById(self._activityId, self._shopId, creepsId)
	local fMo = FightingPowerPetMo.New()

	fMo:fromChallengeCreepCo(rentCfg)

	local bagPetMo = fMo:toBaseBagPetMo()

	if bagPetMo then
		CommonTipsMgr.instance:showPetTips(bagPetMo)
	end
end

function BeastRichManShopView:_clearCell(cell)
	local imgCost = goutil.findChild(cell.gameObject, "imgCost")
	local btnBuy = goutil.findChild(cell.gameObject, "btnBuy")
	local comp = self._petCardItem[cell]

	if comp then
		comp:dispose()
	end

	MaterialMgr.clearIcon(imgCost)
	GameUtil.rmClickHandler(btnBuy)
end

function BeastRichManShopView:_OnClickPet(bagPetMo)
	CommonTipsMgr.instance:showPetTips(bagPetMo)
end

function BeastRichManShopView:_onClickBtnNoBuy()
	local zoneMap = BeastRichmanModel.instance:getZoneMap(self._activityId)
	local zone = zoneMap and zoneMap[self._zoneId]
	local tipsContent = "是否确认不购买？"

	TipsFacade.instance:openPopupWindow("提示", tipsContent, function()
		self:close()
	end, nil, "确定", "取消")
end

function BeastRichManShopView:_onClickBtnGoldBar()
	TipsFacade.instance:openItemSourceView(self._actCfg.scoreMatStr)
end

function BeastRichManShopView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyShop

	TipsFacade.instance:openRulesView(key)
end

return BeastRichManShopView
