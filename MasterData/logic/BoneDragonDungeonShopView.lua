-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragondungeon/view/BoneDragonDungeonShopView.lua

module("logic.extensions.bonedragondungeon.view.BoneDragonDungeonShopView", package.seeall)

local BoneDragonDungeonShopView = class("BoneDragonDungeonShopView", ViewComponent)

function BoneDragonDungeonShopView:ctor()
	BoneDragonDungeonShopView.super.ctor(self)
end

function BoneDragonDungeonShopView:unbindEvents()
	BoneDragonDungeonShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BoneDragonDungeonShopView:bindEvents()
	BoneDragonDungeonShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BoneDragonDungeonShopView:buildUI()
	BoneDragonDungeonShopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._costIcon = self:getGo("curItem/icon")
	self._txtNum = self:getTxt("curItem/txtNum")
end

function BoneDragonDungeonShopView:onExit()
	BoneDragonDungeonShopView.super.onExit(self)
	self._tableList:dispose()
	MaterialMgr.resetAll(self._costIcon)
end

function BoneDragonDungeonShopView:onEnter()
	BoneDragonDungeonShopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonDungeonBuyPetRes, self._refreshView, self)

	self._activityId = self:getFirstParam()
	self._activityCfg = BoneDragonDungeonConfig.instance:getActivityCfg(self._activityId)

	local matType, matId, _ = MaterialMgr.getMatParams(self._activityCfg.price)

	MaterialMgr.resetAll(self._costIcon)
	MaterialMgr.setIcon(self._costIcon, matType, matId)
	self:_refreshView()
end

function BoneDragonDungeonShopView:_refreshView()
	local list = BoneDragonDungeonConfig.instance:getPetShopCfgs(self._activityId)

	self._tableList:reloadData(list)

	local matType, matId, _ = MaterialMgr.getMatParams(self._activityCfg.price)

	self._txtNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)
end

function BoneDragonDungeonShopView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petmask/petCon")
	local costGo = goutil.findChild(go, "cost")
	local costCon = goutil.findChild(go, "cost/txtCost/icon")
	local txtCost = goutil.findChildTextComponent(go, "cost/txtCost")
	local gainTag = goutil.findChild(go, "gainTag")
	local txtPetName = goutil.findChildTextComponent(go, "petInfo/txtName")
	local txtLv = goutil.findChildTextComponent(go, "petInfo/txtLv")
	local imgChangeAttr = goutil.findChildComponent(go, "petInfo/imgAttr", ComponentType.UIImageSpriteChange)
	local btnBuy = goutil.findChild(go, "btnBuy")
	local showRaceId = data.raceId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. showRaceId)

		return
	end

	uGuiUtil.clearImage(petCon)
	uGuiUtil.setSpriteToImage(petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	txtPetName.text = data.creepsName
	txtLv.text = langPara("等级：%d", data.lv)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(showRaceId)

	race = race % 10

	local targetValue = race - 1

	if imgChangeAttr then
		imgChangeAttr:SetState(targetValue)
	end

	MaterialMgr.resetAll(costCon)

	local matType, matId, matNum = MaterialMgr.getMatParams(data.price)

	MaterialMgr.setIcon(costCon, matType, matId)

	txtCost.text = matNum

	GameUtil.rmClickHandler(btnBuy)
	GameUtil.addClickHandler(btnBuy, function()
		self:_onClickBuy(data.shopPosId)
	end)

	local isBuy = BoneDragonDungeonModel.instance:isPetBuy(data.shopPosId)

	GameUtil.SetActive(gainTag, isBuy)
	GameUtil.SetActive(costGo, not isBuy)
	GameUtil.SetActive(btnBuy, not isBuy)
end

function BoneDragonDungeonShopView:_clearCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petmask/petCon")
	local costCon = goutil.findChild(go, "cost/icon")
	local btnBuy = goutil.findChild(go, "btnBuy")

	MaterialMgr.resetAll(costCon)
	uGuiUtil.clearImage(petCon)
	GameUtil.rmClickHandler(btnBuy)
end

function BoneDragonDungeonShopView:_onClickBuy(shopPosId)
	local shopCfg = BoneDragonDungeonConfig.instance:getPetShopCfg(self._activityId, shopPosId)
	local matType, matId, matNum = MaterialMgr.getMatParams(shopCfg.price)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = langPara("是否确认消耗【%s×%d】租借【%s】？", matName, matNum, shopCfg.creepsName)

	TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
		BoneDragonDungeonAgent.instance:sendPM_BoneDragonDungeonBuyPetReq(self._activityId, shopPosId)
	end)
end

return BoneDragonDungeonShopView
