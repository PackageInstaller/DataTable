-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchFailSelectView.lua

module("logic.extensions.annimatch.view.AnnimatchFailSelectView", package.seeall)

local AnnimatchFailSelectView = class("AnnimatchFailSelectView", ViewComponent)

function AnnimatchFailSelectView:ctor()
	AnnimatchFailSelectView.super.ctor(self)
end

function AnnimatchFailSelectView:unbindEvents()
	AnnimatchFailSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnNext)
end

function AnnimatchFailSelectView:bindEvents()
	AnnimatchFailSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnNext, self.close, self)
end

function AnnimatchFailSelectView:buildUI()
	AnnimatchFailSelectView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnNext = self:getGo("btnNext")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("card")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tablecellSelect = self:getGo("tableviewSelect/tablecellSelect")
	self._tableviewSelect = self:getGo("tableviewSelect")
	self._scrollListSelect = ScrollerList.create(self._tableviewSelect, self._tablecellSelect, GameUtil.handler(self._updateCellSelect, self), GameUtil.handler(self._clearCellSelect, self))
end

function AnnimatchFailSelectView:onExit()
	AnnimatchFailSelectView.super.onExit(self)
	self._scrollList:dispose()
	self._scrollListSelect:dispose()
end

function AnnimatchFailSelectView:onEnter()
	AnnimatchFailSelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OnAnnimatchReplaceCreeps, self._onReplaceCreepsRes, self)
	self.addGEvent(self, GlobalNotify.OnAnnimatchInfoUpdate, self._onUpdate, self)

	self._activityId = AnnimatchController.instance:getCurrActId()
	self._actCfg = AnnimatchConfig.instance:getCfgById(self._activityId)

	self:_onUpdate()
end

function AnnimatchFailSelectView:_onUpdate()
	self._info = AnnimatchModel.instance:getInfo(self._activityId)
	self._failShop = self._info.failShop

	if self._failShop then
		self._replaceCreepsIds = self._failShop.replaceCreepsIds or {}
	end

	self._creepsIds = self._info.creepsIds or {}
	self._selectCreepId = 0
	self._hasReplace = false

	self._scrollList:reloadData(self._replaceCreepsIds)
	self._scrollListSelect:reloadData(self._creepsIds)
end

function AnnimatchFailSelectView:_updateCell(view, cell, data)
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local sellOut = goutil.findChild(cell, "sellOut")
	local rare = goutil.findChild(cell, "cell/rare")
	local con = goutil.findChild(cell, "cell/mask/con")
	local summon = goutil.findChild(cell, "summon")
	local summonCon = goutil.findChild(cell, "summon/con")
	local job1 = goutil.findChild(cell, "cell/jobbg1/job1")
	local txtName = goutil.findChildTextComponent(cell, "cell/txtName")
	local jobbg1 = goutil.findChild(cell, "cell/jobbg1")
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
		GameUtil.SetActive(job1, false)
		GameUtil.SetActive(jobbg1, secondJobIdx > 20)
		GameUtil.SetActive(sellOut, hasSellOut)

		if secondJobIdx > 20 then
			GameUtil.SetActive(job1, true)
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
			self:_onClickCell(creepsId)
		end)
	end
end

function AnnimatchFailSelectView:_clearCell(cell)
	local summonCon = goutil.findChild(cell, "summon/con")
	local btnSelect = goutil.findChild(cell, "btnSelect")

	MaterialMgr.resetAll(summonCon)
	GameUtil.rmClickHandler(btnSelect)
end

function AnnimatchFailSelectView:_updateCellSelect(view, cell, data)
	local pet = goutil.findChild(cell, "pet")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local txtCost = goutil.findChildTextComponent(cell, "txtCost")
	local creepsId = data
	local petMo = AnnimatchModel.instance:getPetMo(self._activityId, creepsId)

	txtCost.text = AnnimatchConfig.instance:getCostByCreepsId(self._activityId, creepsId)

	MaterialMgr.setCell(MatType.Pet, petMo.curFaceId, pet)
	GameUtil.SetActive(imgSelect, self._selectCreepId == creepsId)
	GameUtil.addClickHandler(btnSelect, function()
		if petMo.summonMasterId > 0 then
			FloatWordMgr.instance:show("召唤兽无法被替换")

			return
		end

		self._selectCreepId = creepsId

		self._scrollListSelect:reloadData(self._creepsIds)
	end)
end

function AnnimatchFailSelectView:_clearCellSelect(cell)
	local pet = goutil.findChild(cell, "pet")
	local btnSelect = goutil.findChild(cell, "btnSelect")

	MaterialMgr.resetAll(pet)
	GameUtil.rmClickHandler(btnSelect)
end

function AnnimatchFailSelectView:_onClickCell(creepsId)
	if self._hasReplace then
		FloatWordMgr.instance:show("已选择替换过精灵，无法再次选择")

		return
	end

	if self._selectCreepId <= 0 then
		FloatWordMgr.instance:show("尚未选择下方精灵，无法进行替换")

		return
	end

	local cost = AnnimatchConfig.instance:getCostByCreepsId(self._activityId, creepsId)
	local selectCost = AnnimatchConfig.instance:getCostByCreepsId(self._activityId, self._selectCreepId)

	if selectCost < cost then
		FloatWordMgr.instance:show("仅可替换等于或低于该精灵价值的精灵")

		return
	end

	local petMo = AnnimatchModel.instance:getPetMo(self._activityId, creepsId)
	local selectPetMo = AnnimatchModel.instance:getPetMo(self._activityId, self._selectCreepId)
	local planId = self._actCfg.systemPetPlanId
	local petCfg = AnnimatchConfig.instance:getPetCfg(planId, creepsId)
	local selectPetCfg = AnnimatchConfig.instance:getPetCfg(planId, self._selectCreepId)
	local petName = petCfg.creepsName
	local selectPetName = selectPetCfg.creepsName
	local tipsContent = string.format("<color=#FF0000>本次仅可选择一只精灵替换</color>\n您是否确认将%s精灵替换成%s精灵，确认后无法更改", selectPetName, petName)

	local function okFunc()
		AnnimatchController.instance:sendReplaceCreeps(self._activityId, self._selectCreepId, creepsId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function AnnimatchFailSelectView:_onReplaceCreepsRes()
	self._hasReplace = true

	self:close()
end

return AnnimatchFailSelectView
