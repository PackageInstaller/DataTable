-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchselectView.lua

module("logic.extensions.annimatch.view.AnnimatchselectView", package.seeall)

local AnnimatchselectView = class("AnnimatchselectView", ViewComponent)

function AnnimatchselectView:ctor()
	AnnimatchselectView.super.ctor(self)
end

function AnnimatchselectView:unbindEvents()
	AnnimatchselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function AnnimatchselectView:bindEvents()
	AnnimatchselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function AnnimatchselectView:buildUI()
	AnnimatchselectView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.card = self:getGo("card")

	GameUtil.SetActive(self.card, false)

	self.container = self:getGo("container")
	self.petcon = self:getGo("petcon")
	self.item = self:getGo("item")
	self.tableview = self:getGo("bottom/tableview")
	self.empty = self:getGo("bottom/empty")
	self.petScrollList = ScrollerList.create(self.tableview, self.item, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AnnimatchselectView:onExit()
	AnnimatchselectView.super.onExit(self)

	self.cardCellList = GameUtil.clearCells(self.container, self.clearCardCell, self)

	self.petScrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.OnAnnimatchSelectPetUpdate, self.onUpdatePetCard, self)
end

function AnnimatchselectView:onEnter()
	AnnimatchselectView.super.onEnter(self)

	self.activityId = AnnimatchController.instance:getCurrActId()

	GlobalDispatcher:addListener(GlobalNotify.OnAnnimatchSelectPetUpdate, self.onUpdatePetCard, self)
	self:onUpdatePetCard()
end

function AnnimatchselectView:_updateCell(view, cell, data, tag)
	local petMo = AnnimatchModel.instance:getPetMo(self.activityId, data)
	local proxy = MaterialMgr.setCellByMo(petMo, cell)

	if proxy then
		proxy.binder:setAutoTips(false)
		proxy.binder:setContractTag(petMo.summonMasterId, petMo.summonedPetId)
	end
end

function AnnimatchselectView:clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function AnnimatchselectView:onUpdatePetCard()
	local datas = AnnimatchController.instance:getNextCardArr(self.activityId)

	if datas then
		self.cardCellList = GameUtil.updateCellsList(self.container, self.card, datas, self.updateCardCell, self)

		local info = AnnimatchModel.instance:getInfo(self.activityId)

		if info then
			GameUtil.SetActive(self.empty, info.creepsIds == nil or #info.creepsIds == 0)
			self.petScrollList:reloadData(info.creepsIds or {})
		end

		local cfgList = AnnimatchConfig.instance:getPetCheckList()
	else
		self:close()
	end
end

function AnnimatchselectView:updateCheckCell(cell, data, idx)
	local txt = goutil.findChildTextComponent(cell, "bg/txt")
	local info = AnnimatchModel.instance:getInfo(self.activityId)
	local desc = AnnimatchConfig.instance:getCommonByKey("PET_CHECK_ITEM_DESC")
	local connectDesc = AnnimatchConfig.instance:getCommonByKey("PET_CHECK_CONNECT")
	local career = data.career
	local arr = string.split(career, "|")
	local content = ""
	local boo = false
	local petList = AnnimatchModel.instance:getPetList(self.activityId)
	local strList = {}

	for i, job in ipairs(arr) do
		local str = ConstString.JobIdxToStr[GameEnum.JobZh[job]]

		table.insert(strList, str)

		if info and boo == false then
			for j, petMo in ipairs(petList) do
				boo = PetSkinConfig.instance:checkHasJob(petMo.curFaceId, job)

				if boo then
					break
				end
			end
		end
	end

	content = table.concat(strList, connectDesc)
	txt.text = boo and "<color=#20b376>" .. langPara(desc, content) .. "</color>" or "<color=#eb4642>" .. langPara(desc, content) .. "</color>"
end

function AnnimatchselectView:clearCardCell(cell, idx)
	local select = goutil.findChild(cell, "select")
	local btn = goutil.findChild(cell, "select/btn")
	local cellCon = goutil.findChild(cell, "cell")
	local summon = goutil.findChild(cell, "summon")
	local summonCon = goutil.findChild(cell, "summon/con")

	MaterialMgr.resetAll(summonCon)
end

function AnnimatchselectView:updateCardCell(cell, data, idx)
	local select = goutil.findChild(cell, "select")
	local cellCon = goutil.findChild(cell, "cell")
	local summon = goutil.findChild(cell, "summon")
	local summonCon = goutil.findChild(cell, "summon/con")
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local petMo = AnnimatchModel.instance:getPetMo(self.activityId, data)

	self:updateCardGo(cellCon, petMo)
	GameUtil.SetActive(summon, false)

	if petMo.summonedPetId > 0 then
		GameUtil.SetActive(summon, true)

		local sommonPetMo = AnnimatchModel.instance:getPetMo(self.activityId, petMo.summonedPetId)
		local proxy = MaterialMgr.setCellByMo(sommonPetMo, summonCon)

		if proxy then
			proxy.binder:setAutoTips(false)
			proxy:setCallBack(function()
				CommonTipsMgr.instance:showPetTips(sommonPetMo, true)
			end)
		end
	end

	GameUtil.addClickHandler(btnSelect, function()
		AnnimatchController.instance:sendGetSysPetId(self.activityId, petMo.petId)
	end)
	GameUtil.addClickHandler(select, function()
		CommonTipsMgr.instance:showPetTips(petMo, true)
	end)
end

function AnnimatchselectView:updateCardGo(cell, petMo)
	local bg = goutil.findChild(cell, "bg")
	local con = goutil.findChild(cell, "mask/con")
	local downAttr = goutil.findChild(cell, "downAttr")
	local attr = goutil.findChild(cell, "attr")
	local rare = goutil.findChild(cell, "rare")
	local rareGo = goutil.findChild(cell, "rare/rare")

	GameUtil.SetActive(rareGo, false)

	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local job = goutil.findChild(cell, "jobbg/job")
	local jobbg1 = goutil.findChild(cell, "jobbg1")
	local job1 = goutil.findChild(cell, "jobbg1/job")
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

	GameUtil.setUIImageSpriteIdx(job, firstJobIdx - 1)
	GameUtil.SetActive(jobbg1, false)

	if secondJobIdx > 20 then
		GameUtil.SetActive(jobbg1, true)
		GameUtil.setUIImageSpriteIdx(job1, secondJobIdx - 1)
	end

	MaterialMgr.setCell(MatType.Rare, petMo.raceId, rare)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

	race = race % 10

	local targetValue = race - 1

	GameUtil.setUIImageSpriteIdx(attr, targetValue)
	GameUtil.setUIImageSpriteIdx(bg, targetValue)

	txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, petMo.curFaceId)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petMo.curFaceId))

	uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function AnnimatchselectView:onSelectCard(idx)
	if self.cardCellList then
		for i, cell in ipairs(self.cardCellList) do
			local select = goutil.findChild(cell, "select")
			local rare = goutil.findChild(cell, "cell/rare")

			MaterialMgr.resetAll(rare)

			local con = goutil.findChild(cell, "cell/mask/con")

			uGuiUtil.clearImage(con)
		end
	end
end

return AnnimatchselectView
