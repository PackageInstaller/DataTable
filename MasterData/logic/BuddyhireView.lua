-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyhire/view/BuddyhireView.lua

module("logic.extensions.buddyhire.view.BuddyhireView", package.seeall)

local BuddyhireView = class("BuddyhireView", ViewComponent)
local TAB_OTHER_HIRE = 1
local TAB_MY_HIRE = 2

function BuddyhireView:ctor()
	BuddyhireView.super.ctor(self)
end

function BuddyhireView:unbindEvents()
	BuddyhireView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTip)
	GameUtil.rmClickHandler(self.btnHire)
	GameUtil.rmClickHandler(self.btnPet)
	self._inputSearch:RemoveOnValueChanged()
	self._filterButton:RemoveClickListener()
	self._sortButton:RemoveClickListener()
	self._InputC_Search_Clear:RemoveClickListener()
end

function BuddyhireView:bindEvents()
	BuddyhireView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTip, self.onClickHelp, self)
	GameUtil.addClickHandler(self.btnHire, self.onClickHire, self)
	GameUtil.addClickHandler(self.btnPet, self.onClickPet, self)
	GameUtil.addClickHandler(self.btnReceive, self.onReceive, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._filterButton:AddClickListener(self._onClickFilter, self)
	self._InputC_Search_Clear:AddClickListener(self.onClearSearchClick, self)
end

function BuddyhireView:buildUI()
	BuddyhireView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTip = self:getGo("btnTip")
	self.btnHire = self:getGo("btnHire")
	self.btnPet = self:getGo("btnPet")
	self.btnHireRedPoint = self:getGo("btnHire/redPoint")
	self.btnPetRedPoint = self:getGo("btnPet/redPoint")
	self.btnReceiveRedpoint = self:getGo("info/reward/btnReceive/redPoint")
	self.txtTitle = self:getTxt("info/title/txtTitle")
	self.cell = self:getGo("info/cell")

	GameUtil.SetActive(self.cell, false)

	self.pos = self:getGo("info/pos")
	self.posPlan = self.pos:GetComponent(typeof(TestRecordPos))
	self.tip = self:getGo("info/tip")
	self.cellList = {}

	for i = 1, 3 do
		local cell = self:getGo("info/pos/cell_" .. i)

		table.insert(self.cellList, cell)
	end

	self.reward = self:getGo("info/reward")
	self.btnReceive = self:getGo("info/reward/btnReceive")
	self.txtReceive = self:getTxt("info/reward/btnReceive/Text")
	self.tableview = self:getGo("info/reward/tableview")
	self.item = self:getGo("info/reward/item")
	self._inputSearch = self:getInput("petList/InputField")
	self._InputC_Search_Clear = self:getBtn("petList/InputField/btnCancel")
	self._filterButton = self:getBtn("petList/btnFliter")
	self._sortButton = self:getBtn("petList/btnSort")
	self._sortBtnGo = self:getGo("btnSort")
	self.empty = self:getGo("petList/empty")
	self.txtTitlePet = self:getTxt("petList/txtTitle")
	self.tableviewPet = self:getGo("petList/tableview")
	self.pet = self:getGo("petList/pet")
	self.scrollListItem = ScrollerList.create(self.tableview, self.item, GameUtil.handler(self._updateCellItem, self), GameUtil.handler(self.clearCellItem, self))
	self.scrollList = ScrollerList.create(self.tableviewPet, self.pet, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function BuddyhireView:onExit()
	BuddyhireView.super.onExit(self)
	self.scrollList:dispose()
	self.scrollListItem:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.ON_BUDDY_HIRE_INFO_UPDATE, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.ON_BUDDY_HIRE_PET_SHOW, self.onShowPetInfo, self)
	BuddyHireModel.instance:resetMsg()
	RedPointController.instance:unregRedPoint(self.btnPetRedPoint)
	RedPointController.instance:unregRedPoint(self.btnReceiveRedpoint)
end

function BuddyhireView:onEnter()
	BuddyhireView.super.onEnter(self)

	self._currSearching = nil
	self.currTabIdx = TAB_OTHER_HIRE

	GlobalDispatcher:addListener(GlobalNotify.ON_BUDDY_HIRE_INFO_UPDATE, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.ON_BUDDY_HIRE_PET_SHOW, self.onShowPetInfo, self)
	self:sendMsg()
	RedPointController.instance:regRedPoint(self.btnPetRedPoint, 347)
	RedPointController.instance:regRedPoint(self.btnReceiveRedpoint, 347)
end

function BuddyhireView:updateFilterData(starList, jobList, rareList)
	self:_RefreshPetList()
end

function BuddyhireView:_RefreshPetList(force)
	self._curViewDatas = {}

	for k, v in pairs(self.allData) do
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	ArraySort.sortOn(self._curViewDatas, "zdl", ArraySort.DESCENDING)
	self.scrollList:reloadData(self._curViewDatas)
	GameUtil.SetActive(self.empty, #self._curViewDatas == 0)
end

function BuddyhireView:onFilter(data)
	local petCo = data.petCfg
	local isHit = false
	local maxAwaken = CharacterConfig.instance:getMaxAwaken(petCo.raceId)
	local rare = CharacterConfig.instance:getRareByAwakenLv(maxAwaken, petCo.raceId)

	isHit = self:_isMatch(petCo, rare, data.curFaceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function BuddyhireView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PET_BUDDY_HIRE, cfg, rare, skinId)
end

function BuddyhireView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_RefreshPetList()
	end
end

function BuddyhireView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function BuddyhireView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterButton.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PET_BUDDY_HIRE, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function BuddyhireView:onClearSearchClick()
	self._inputSearch.input.text = ""
end

function BuddyhireView:sendMsg()
	GameUtil.setUIGroupIdx(self.btnHire, 0)
	GameUtil.setUIGroupIdx(self.btnPet, 0)

	if self.currTabIdx == TAB_OTHER_HIRE then
		GameUtil.setUIGroupIdx(self.btnHire, 1)
		BuddyHireController.instance:getOtherListInfo()
	else
		GameUtil.setUIGroupIdx(self.btnPet, 1)
		BuddyHireController.instance:getMyListInfo()
	end
end

function BuddyhireView:onRefreshUI()
	for i, v in ipairs(self.cellList) do
		GameUtil.SetActive(v, false)
	end

	GameUtil.SetActive(self.tip, false)
	GameUtil.SetActive(self.reward, false)

	if self.currTabIdx == TAB_OTHER_HIRE then
		self.txtTitle.text = lang("我的租借精灵")
		self.txtTitlePet.text = lang("好友精灵列表")

		GameUtil.SetActive(self.tip, true)

		if not BuddyHireModel.instance.leasePetInfos then
			local leasePetInfos = {}

			if not BuddyHireModel.instance.buddyLeasePetInfos then
				local buddyLeasePetInfos = {}

				for i, cell in ipairs(self.cellList) do
					GameUtil.SetActive(cell, true)
					self:updateCellByOtherInfo(cell, leasePetInfos[i])
				end

				local list = {}

				for i, v in ipairs(buddyLeasePetInfos) do
					if not BuddyHireModel.instance:checkHasHire(v.petId, v.userId) then
						local skinCfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, v.curFaceId)
						local temp = {}

						temp.type = TAB_OTHER_HIRE
						temp.zdl = v.userZdl
						temp.curFaceId = v.curFaceId
						temp.data = v
						temp.skinCfg = skinCfg

						if skinCfg then
							temp.petCfg = MaterialMgr.getMatCfg(MatType.Pet, skinCfg.raceId)
						end

						table.insert(list, temp)
					end
				end

				self.allData = list

				self:_RefreshPetList()
			end
		end
	else
		self.txtTitle.text = lang("我出租的精灵")
		self.txtTitlePet.text = lang("精灵列表")

		GameUtil.SetActive(self.reward, true)

		local isGainPrize = BuddyHireModel.instance.isGainPrize

		GameUtil.SetGray(self.btnReceive, isGainPrize)

		self.txtReceive.text = isGainPrize and lang("已领取") or lang("领 取")

		local prize = BuddlyHireConfig.instance:getValueByKey("PRIZE")
		local itemList = string.split(prize, "#")

		self.scrollListItem:reloadData(itemList)

		local cell = self.cellList[1]

		GameUtil.SetActive(cell, true)

		if not BuddyHireModel.instance.petInfos then
			local petInfos = {}
			local obj

			if #petInfos > 0 then
				local data = petInfos[1]

				if data then
					obj = {
						petInfo = data
					}
				end
			end

			self:updateCellByOtherInfo(cell, obj)

			local bagList = BagModel.instance:getBagPets()
			local zdl = checknumber(BuddlyHireConfig.instance:getValueByKey("LIMIT_ZDL"))
			local list = {}

			for i, petMo in ipairs(bagList) do
				if BuddyHireController.instance:checkIsLimitRace(petMo.raceId) then
					local power = petMo:getFightingPower()

					if zdl <= power then
						local skinCfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, petMo.curFaceId)
						local temp = {}

						temp.zdl = power
						temp.type = TAB_MY_HIRE
						temp.curFaceId = petMo.curFaceId
						temp.data = petMo
						temp.skinCfg = skinCfg

						if skinCfg then
							temp.petCfg = MaterialMgr.getMatCfg(MatType.Pet, skinCfg.raceId)
						end

						table.insert(list, temp)
					end
				end
			end

			self.allData = list

			self:_RefreshPetList()
		end
	end
end

function BuddyhireView:updateCellByOtherInfo(cell, data)
	local info = goutil.findChild(cell, "info")
	local empty = goutil.findChild(cell, "empty")

	GameUtil.SetActive(info, false)
	GameUtil.SetActive(empty, false)
	GameUtil.rmClickHandler(cell)

	if data then
		GameUtil.SetActive(info, true)

		local pet = goutil.findChild(info, "pet/con")
		local attr = goutil.findChild(info, "attr/con")
		local txtLevel = goutil.findChildTextComponent(info, "txtLevel")
		local job = goutil.findChild(info, "job")
		local job1 = goutil.findChild(info, "job1")
		local txtRemain = goutil.findChildTextComponent(info, "remain/txt")
		local playerInfo = goutil.findChild(info, "playerInfo")
		local head = goutil.findChild(info, "playerInfo/head")
		local txtName = goutil.findChildTextComponent(info, "playerInfo/txtName")
		local txtUserLevel = goutil.findChildTextComponent(info, "playerInfo/txtLevel")

		txtRemain.text = ""

		if data.petInfo and data.petInfo.petView then
			local petMo = BagPetMo.New()

			petMo:initBaseView(data.petInfo.petView)

			if checknumber(data.petInfo.zdl) > 0 then
				petMo._zdl = data.petInfo.zdl
			end

			local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
			local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

			GameUtil.setUIImageSpriteIdx(job, firstJobIdx - 1)
			GameUtil.SetActive(job1, false)

			if secondJobIdx > 20 then
				GameUtil.SetActive(job1, true)
				GameUtil.setUIImageSpriteIdx(job1, secondJobIdx - 1 - 20)
			end

			local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

			race = race % 10

			local targetValue = race - 1

			GameUtil.setUIImageSpriteIdx(attr, targetValue)

			local modelCo = CharacterConfig.instance:getModelCo(checknumber(petMo.curFaceId))

			uGuiUtil.setSpriteToImage(pet.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

			txtLevel.text = "Lv." .. petMo.level

			GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickPetCell, self, petMo, data, cell))

			txtRemain.text = petMo.name
		end

		if data.times then
			txtRemain.text = langPara("剩余次数：<color=#20b376>%s</color>", data.times)
		end

		txtName.text = ""
		txtUserLevel.text = ""

		GameUtil.SetActive(playerInfo, false)

		if data.headInfo then
			GameUtil.SetActive(playerInfo, true)
			HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

			txtName.text = data.headInfo.userName
			txtUserLevel.text = data.headInfo.playerLv
		end

		GameUtil.SetActive(job, false)
		GameUtil.SetActive(job1, false)
	else
		GameUtil.SetActive(empty, true)
	end
end

function BuddyhireView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local skinId = data.data.curFaceId

	MaterialMgr.setCell(MatType.Pet, skinId, con)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickPetTips, self, data))
end

function BuddyhireView:clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function BuddyhireView:_updateCellItem(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell)
end

function BuddyhireView:clearCellItem(cell)
	MaterialMgr.resetAll(cell)
end

function BuddyhireView:onClickPetTips(data)
	if data.type == TAB_OTHER_HIRE then
		BuddyHireController.instance:tryShowPetInfo(data.data.petId, data.data.userId)
	else
		local goOrPos

		CommonTipsMgr.instance:showBuddyHirePetTips(data.data, BuddyhiredetailView.TYPE_HIRE_OUT, goOrPos)
	end
end

function BuddyhireView:onShowPetInfo(petMo, headInfo)
	local goOrPos

	CommonTipsMgr.instance:showBuddyHirePetTips(petMo, BuddyhiredetailView.TYPE_HIRE_IN, goOrPos, headInfo)
end

function BuddyhireView:onClickPetCell(petMo, data, cell)
	local goOrPos

	CommonTipsMgr.instance:showBuddyHirePetTips(petMo, BuddyhiredetailView.TYPE_HIRE_INFO, goOrPos, data.headInfo)
end

function BuddyhireView:onClickHire()
	self.currTabIdx = TAB_OTHER_HIRE

	self:sendMsg()
end

function BuddyhireView:onClickPet()
	self.currTabIdx = TAB_MY_HIRE

	self:sendMsg()
end

function BuddyhireView:onReceive()
	local isGainPrize = BuddyHireModel.instance.isGainPrize

	if not isGainPrize then
		if not BuddyHireModel.instance.petInfos then
			if #BuddyHireModel.instance.petInfos > 0 then
				BuddyHireController.instance:sendGetPrize()
			else
				TipsFacade.instance:openCommonTips(lang("请先出租一只精灵"))
			end
		end
	else
		TipsFacade.instance:openCommonTips(lang("奖励已领取"))
	end
end

function BuddyhireView:onClickHelp()
	local ruleId = BuddlyHireConfig.instance:getValueByKey("RULE_ID")

	UIStateManager.instance:push(ViewName.RulesView, ruleId)
end

return BuddyhireView
