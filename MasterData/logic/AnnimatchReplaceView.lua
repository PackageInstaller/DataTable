-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchReplaceView.lua

module("logic.extensions.annimatch.view.AnnimatchReplaceView", package.seeall)

local AnnimatchReplaceView = class("AnnimatchReplaceView", ViewComponent)

function AnnimatchReplaceView:ctor()
	AnnimatchReplaceView.super.ctor(self)
end

function AnnimatchReplaceView:unbindEvents()
	AnnimatchReplaceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnReset)
end

function AnnimatchReplaceView:bindEvents()
	AnnimatchReplaceView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function AnnimatchReplaceView:buildUI()
	AnnimatchReplaceView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.card = self:getGo("card")

	GameUtil.SetActive(self.card, false)

	self.container = self:getGo("container")
	self.item = self:getGo("bottom/item")
	self.tableview = self:getGo("bottom/tableview")
	self.petScrollList = ScrollerList.create(self.tableview, self.item, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._btnSure = self:getGo("bottom/btnSure")
	self._btnReset = self:getGo("btnReset")
end

function AnnimatchReplaceView:onExit()
	AnnimatchReplaceView.super.onExit(self)

	self.cardCellList = GameUtil.clearCells(self.container, self.clearCardCell, self)

	GameUtil.clearCells(self.petcheck)
	self.petScrollList:dispose()
end

function AnnimatchReplaceView:onEnter()
	AnnimatchReplaceView.super.onEnter(self)

	self.activityId = AnnimatchController.instance:getCurrActId()
	self._curSelectPetId = nil
	self._curDragPetId = nil
	self._curReplaceIdList = nil
	self._curCreepsIdList = nil
	self._curNewReplaceId = nil
	self._curOldReplaceId = nil

	self.addGEvent(self, GlobalNotify.OnAnnimatchReplaceCreeps, self._handleReplace, self)
	self:onUpdatePetCard()
end

function AnnimatchReplaceView:_updateCell(view, cell, data, tag)
	local petMo = AnnimatchModel.instance:getPetMo(self.activityId, data)
	local con = goutil.findChild(cell, "con")
	local select = goutil.findChild(cell, "select")
	local replace = goutil.findChild(cell, "replace")

	MaterialMgr.resetAll(con)

	local proxy = MaterialMgr.setCellByMo(petMo, con)

	if proxy then
		proxy.binder:setContractTag(petMo.summonMasterId, petMo.summonedPetId)
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			if self._curSelectPetId then
				return
			end

			CommonTipsMgr.instance:showPetTips(petMo, true)
		end)
	end

	goutil.setActive(select, false)
	goutil.setActive(replace, self._curNewReplaceId == data)

	local replaceIdList = self:getReplaceList() or {}
	local creepsIdList = self:getPetList() or {}
	local dragIdNew = table.keyof(replaceIdList, self._curSelectPetId)
	local selectIdNew = table.keyof(replaceIdList, data)
	local selectIdOld = table.keyof(creepsIdList, data)

	if self._curSelectPetId then
		if dragIdNew then
			goutil.setActive(select, true)
		elseif selectIdOld then
			-- block empty
		else
			goutil.setActive(select, true)
		end
	end

	GameUtil.addClickHandler(select, function()
		if dragIdNew then
			if selectIdNew then
				self._curNewReplaceId = self._curSelectPetId
			else
				self._curNewReplaceId = self._curSelectPetId
				self._curOldReplaceId = data
			end
		elseif selectIdOld then
			self._curOldReplaceId = self._curSelectPetId
		else
			self._curNewReplaceId = nil
			self._curOldReplaceId = nil
		end

		self._curSelectPetId = nil

		self:onUpdatePetCard()
	end)
end

function AnnimatchReplaceView:clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function AnnimatchReplaceView:onUpdatePetCard()
	local datas = self:getCurReplaceList()

	if datas then
		self.cardCellList = GameUtil.updateCellsList(self.container, self.card, datas, self.updateCardCell, self)

		self.petScrollList:reloadData(self:getCurPetList() or {})
	else
		self:close()
	end
end

function AnnimatchReplaceView:updateCheckCell(cell, data, idx)
	local txt = goutil.findChildTextComponent(cell, "bg/txt")
	local info = AnnimatchModel.instance:getInfo(self.activityId)
	local desc = AnnimatchConfig.instance:getCommonByKey("PET_CHECK_ITEM_DESC")
	local connectDesc = AnnimatchConfig.instance:getCommonByKey("PET_CHECK_CONNECT")
	local career = data.career
	local arr = string.split(career, "|")
	local content = ""
	local boo = false
	local petIdList = self:getCurPetList()
	local strList = {}

	for i, job in ipairs(arr) do
		local str = ConstString.JobIdxToStr[GameEnum.JobZh[job]]

		table.insert(strList, str)

		if info and boo == false then
			for j, creepsId in ipairs(petIdList) do
				local petMo = AnnimatchModel.instance:getPetMo(self.activityId, creepsId)

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

function AnnimatchReplaceView:clearCardCell(cell, idx)
	local summonCon = goutil.findChild(cell, "summon/con")

	MaterialMgr.resetAll(summonCon)
end

function AnnimatchReplaceView:updateCardCell(cell, data, idx)
	local cellCon = goutil.findChild(cell, "cell")
	local summon = goutil.findChild(cell, "summon")
	local summonCon = goutil.findChild(cell, "summon/con")
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

	local btnReplace = goutil.findChild(cell, "btnReplace")

	GameUtil.addClickHandler(btnReplace, function()
		self._curSelectPetId = petMo.petId

		self:onUpdatePetCard()
	end)
end

function AnnimatchReplaceView:updateCardGo(cell, petMo)
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
	local tag = goutil.findChild(cell, "tag")
	local select = goutil.findChild(cell, "select")
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

	GameUtil.setUIImageSpriteIdx(job, firstJobIdx - 1)
	GameUtil.SetActive(jobbg1, false)

	if secondJobIdx > 20 then
		GameUtil.SetActive(jobbg1, true)
		GameUtil.setUIImageSpriteIdx(job1, secondJobIdx - 1 - 20)
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
	GameUtil.addClickHandler(con.gameObject, function()
		CommonTipsMgr.instance:showPetTips(petMo, true)
	end)

	local replaceList = self:getReplaceList() or {}
	local petId = petMo.petId

	goutil.setActive(tag, not table.keyof(replaceList, petId))
	goutil.setActive(select, self._curSelectPetId == petId)
end

function AnnimatchReplaceView:getReplaceList()
	return AnnimatchModel.instance:getReplaceCreepsIds(self.activityId)
end

function AnnimatchReplaceView:getCurReplaceList()
	if self._curNewReplaceId and self._curOldReplaceId then
		local dataList = {}

		for i, v in ipairs(self:getReplaceList()) do
			if v ~= self._curNewReplaceId then
				table.insert(dataList, v)
			else
				table.insert(dataList, self._curOldReplaceId)
			end
		end

		return dataList
	end

	return self:getReplaceList()
end

function AnnimatchReplaceView:getPetList()
	local info = AnnimatchModel.instance:getInfo(self.activityId)

	if info then
		if not info.creepsIds then
			local creepsIds = {}
			local petIdList = {}

			for _, petId in ipairs(creepsIds) do
				local petMo = AnnimatchModel.instance:getPetMo(self.activityId, petId)

				if not petMo:isSummonedPet() then
					table.insert(petIdList, petId)
				end
			end

			return petIdList
		end
	end
end

function AnnimatchReplaceView:getCurPetList()
	if self._curNewReplaceId and self._curOldReplaceId then
		local dataList = {}

		for i, v in ipairs(self:getPetList()) do
			if v ~= self._curOldReplaceId then
				table.insert(dataList, v)
			else
				table.insert(dataList, self._curNewReplaceId)
			end
		end

		return dataList
	end

	return self:getPetList()
end

function AnnimatchReplaceView:_onClickBtnSure()
	if self._curNewReplaceId and self._curOldReplaceId then
		local newPetMo = AnnimatchModel.instance:getPetMo(self.activityId, self._curNewReplaceId)
		local oldPetMo = AnnimatchModel.instance:getPetMo(self.activityId, self._curOldReplaceId)
		local tip1 = string.format("是否用%s（新）替换%s（旧）？", MaterialMgr.getMaterialsName(MatType.PET_SKIN, newPetMo.curFaceId), MaterialMgr.getMaterialsName(MatType.PET_SKIN, oldPetMo.curFaceId))

		TipsFacade.instance:openPopupWindow("提示", tip1, function()
			AnnimatchController.instance:sendReplaceCreeps(self.activityId, self._curOldReplaceId, self._curNewReplaceId)
		end)
	else
		local tip2 = "是否确认不替换任何精灵?"

		TipsFacade.instance:openPopupWindow("提示", tip2, function()
			AnnimatchController.instance:sendReplaceCreeps(self.activityId)
		end)
	end
end

function AnnimatchReplaceView:_onClickBtnReset()
	local text = "是否重置替换信息?"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		self._curNewReplaceId = nil
		self._curOldReplaceId = nil

		self:onUpdatePetCard()
	end)
end

function AnnimatchReplaceView:_handleReplace()
	self:close()

	local activityId = AnnimatchController.instance:getCurrActId()
	local alternativeBuffConfigIds = AnnimatchModel.instance:getCurrSelectBuffIds(activityId)

	if alternativeBuffConfigIds and #alternativeBuffConfigIds > 0 then
		UIStateManager.instance:push(ViewName.AnnimatchBuffView)
	end
end

return AnnimatchReplaceView
