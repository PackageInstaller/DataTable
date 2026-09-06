-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/view/BirthdaySportsHireView.lua

module("logic.extensions.birthdaysportswish.view.BirthdaySportsHireView", package.seeall)

local BirthdaySportsHireView = class("BirthdaySportsHireView", ViewComponent)

function BirthdaySportsHireView:ctor()
	BirthdaySportsHireView.super.ctor(self)
end

function BirthdaySportsHireView:buildUI()
	BirthdaySportsHireView.super.buildUI(self)

	self._tips = self:getGo("tips")
	self._txtTip = self:getTxt("tips/txtTip")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnRule = self:getGo("btnRule")
	self._btnBorrorw = self:getGo("btnBorrorw")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtName = self:getTxt("petInfo/txtName")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._conRoot = self:getGo("conRoot")
	self._con = self:getGo("conRoot/con")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BirthdaySportsHireView:bindEvents()
	BirthdaySportsHireView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnBorrorw, self._onClickBorrow, self)
end

function BirthdaySportsHireView:unbindEvents()
	BirthdaySportsHireView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnBorrorw)
end

function BirthdaySportsHireView:onEnter()
	BirthdaySportsHireView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BorrowPetGetActivityInfosRes, self._PM_BorrowPetGetActivityInfosRes, self)

	self._activityId = BorrowPetModel.instance:getCurrActId()

	if not self._activityId then
		FloatWordMgr.instance:show("此活动未在时间内")
		self:close()

		return
	end

	self._curItemId = 0
	self._activityCfg = BorrowPetConfig.instance:getActivityCfg(self._activityId)
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.BorrowPet, self._activityId)
	self._petList = BorrowPetConfig.instance:getBorrowPetPlanListCfg(self._activityCfg.planId)

	BorrowPetAgent.instance:sendPM_BorrowPetGetActivityInfosReq(self._activityId)
	settimer(1, self._onClock, self, true)
end

function BirthdaySportsHireView:onExit()
	BirthdaySportsHireView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)

	if self._petObj then
		RoleObjectPool.instance:removeRole(self._petObj)

		self._petObj = nil
	end

	self._tableList:dispose()
	removetimer(self._onClock, self)
end

function BirthdaySportsHireView:_refreshView()
	local list = {}
	local isNewHand = NewhandwelfareModel.instance:isNewHandPlayer()
	local isReturn = not PlayerReturnModel.instance:isOpenActivityEnd()
	local isStudent = TutorSystemModel.instance:getMyIdentityState() == GameEnum.IdentityState.IsStudying

	for i, v in ipairs(self._petList) do
		if v.newHandLimit == true and isNewHand == true or v.regressLimit == true and isReturn == true or v.studentLimit == true and isStudent == true then
			table.insert(list, v)
		elseif not v.newHandLimit and not v.regressLimit and not v.studentLimit then
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		local isBorrowA = checknumber(a.borrowTimesLimit) ~= 0 and a.borrowTimesLimit <= BorrowPetModel.instance:getPetBorrowTimes(self._activityId, a.itemId)
		local isBorrowB = checknumber(b.borrowTimesLimit) ~= 0 and b.borrowTimesLimit <= BorrowPetModel.instance:getPetBorrowTimes(self._activityId, b.itemId)

		if isBorrowA == isBorrowB then
			return a.index < b.index
		else
			return isBorrowB
		end

		return a.index < b.index
	end)

	if self._curItemId == 0 and list[1] then
		self._curItemId = list[1].itemId
	end

	self._tableList:reloadData(list)

	local itemCfg = BorrowPetConfig.instance:getBorrowPetItemCfg(self._curItemId)

	if self._petObj then
		RoleObjectPool.instance:removeRole(self._petObj)

		self._petObj = nil
	end

	MaterialMgr.resetAll(self._pointRare)

	if itemCfg then
		self._curPetRace = itemCfg.raceId
		self._petObj = RoleObjectPool.instance:addRoleToParent(self._petObj, self._curPetRace, self._con)

		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curPetRace)

		if skinCfg then
			MaterialMgr.setCell(MatType.Rare, self._curPetRace, self._pointRare)

			self._txtName.text = skinCfg.name
		end

		local modelCfg = CharacterConfig.instance:getModelUIPosAndScale("resultsofbattle", self._curPetRace)

		GameUtil.setLocalScale(self._con, modelCfg[3])
		GameUtil.setLocalPos(self._con, modelCfg[1], modelCfg[2], 0)
	end

	local petPlanCfg = BorrowPetConfig.instance:getBorrowPetPlanCfgByItemId(self._activityCfg.planId, self._curItemId)
	local onlineTime = 0

	if not string.nilorempty(petPlanCfg.onlineTime) then
		onlineTime = GameUtil.string2time(petPlanCfg.onlineTime)
	end

	local offlineTime = 0

	if not string.nilorempty(petPlanCfg.offlineTime) then
		offlineTime = GameUtil.string2time(petPlanCfg.offlineTime)
	end

	local isOpen = (onlineTime == 0 or onlineTime < ServerTime.now()) and (offlineTime == 0 or offlineTime > ServerTime.now())
	local isCanBorrow = BorrowPetModel.instance:getBorrowTotalTimes(self._activityId) < self._activityCfg.weeklyBorrowTimes

	GameUtil.SetActive(self._btnBorrorw, isOpen and isCanBorrow)
	GameUtil.SetActive(self._tips, not isOpen or not isCanBorrow)

	if not isOpen then
		self._txtTip.text = onlineTime > 0 and onlineTime > ServerTime.now() and langPara("%s 后开放", GameUtil.formatTimeStamp("%m.%d %H:%M", onlineTime)) or lang("活动已过期")
	end

	self._targetTime = not isCanBorrow and isOpen and GameUtil.getNextWeekDay(5) or 0

	self:_onClock()
end

function BirthdaySportsHireView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local tag = goutil.findChild(go, "tag")
	local txtTag = goutil.findChildTextComponent(go, "tag/txt")
	local container = goutil.findChild(go, "container")
	local imgSelect = goutil.findChild(container, "imgSelect")
	local imgBgMask = goutil.findChild(container, "imgBgMask")
	local con = goutil.findChild(container, "imgMask/con")
	local isSelect = data.itemId == self._curItemId
	local imageChangeTag = tag:GetComponent(ComponentType.UIImageSpriteChange)

	if isSelect == true then
		GameUtil.setLocalScale(container, 1)
	else
		GameUtil.setLocalScale(container, 0.9)
	end

	GameUtil.SetActive(imgSelect, isSelect)

	local itemCfg = BorrowPetConfig.instance:getBorrowPetItemCfg(data.itemId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(itemCfg.raceId))

	if not modelCo then
		printError("t_model id not exist:" .. raceId)

		return
	end

	uGuiUtil.clearImage(con)
	uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickPet(data.itemId)
	end)
	GameUtil.SetActive(imgBgMask, checknumber(data.borrowTimesLimit) ~= 0 and data.borrowTimesLimit <= BorrowPetModel.instance:getPetBorrowTimes(self._activityId, data.itemId))
	GameUtil.SetActive(tag, data.newHandLimit or data.regressLimit or data.studentLimit)

	if data.newHandLimit == true then
		imageChangeTag:SetState(0)

		txtTag.text = lang("新手")
	elseif data.regressLimit == true then
		txtTag.text = lang("回归")

		imageChangeTag:SetState(2)
	elseif data.studentLimit == true then
		txtTag.text = lang("师徒")

		imageChangeTag:SetState(1)
	end
end

function BirthdaySportsHireView:_clearCell(cell)
	local go = cell.gameObject
	local container = goutil.findChild(go, "container")
	local con = goutil.findChild(container, "imgMask/con")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(go)
end

function BirthdaySportsHireView:_onClickBorrow()
	local petPlanCfg = BorrowPetConfig.instance:getBorrowPetPlanCfgByItemId(self._activityCfg.planId, self._curItemId)

	if not petPlanCfg then
		return
	end

	local onlineTime = 0

	if not string.nilorempty(petPlanCfg.onlineTime) then
		onlineTime = GameUtil.string2time(petPlanCfg.onlineTime)
	end

	local offlineTime = 0

	if not string.nilorempty(petPlanCfg.offlineTime) then
		offlineTime = GameUtil.string2time(petPlanCfg.offlineTime)
	end

	local isOpen = (onlineTime == 0 or onlineTime < ServerTime.now()) and (offlineTime == 0 or offlineTime > ServerTime.now())
	local isReachBorrowTime = checknumber(petPlanCfg.borrowTimesLimit) ~= 0 and petPlanCfg.borrowTimesLimit <= BorrowPetModel.instance:getPetBorrowTimes(self._activityId, petPlanCfg.itemId)
	local isCanBorrow = BorrowPetModel.instance:getBorrowTotalTimes(self._activityId) < self._activityCfg.weeklyBorrowTimes and not isReachBorrowTime

	if isOpen and isCanBorrow then
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curPetRace)
		local content = langPara("确认选择精灵 %s 助战？\n每周只能选择一次，确认后本周内无法修改", skinCfg.name)

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			BorrowPetAgent.instance:sendPM_BorrowPetBorrowReq(self._activityId, self._curItemId)
		end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	elseif isReachBorrowTime == true then
		FloatWordMgr.instance:show(lang("已达租借次数上限"))
	else
		FloatWordMgr.instance:show(lang("无法租借"))
	end
end

function BirthdaySportsHireView:_onClickPet(itemId)
	self._curItemId = itemId

	self:_refreshView()
end

function BirthdaySportsHireView:_onClickSkill()
	local raceId = self._curPetRace
	local petCfg = CharacterConfig.instance:getPetCo(raceId)

	if raceId ~= 0 then
		if PetbookModel.instance:getIsHandBookPet(petCfg) then
			PetbookController.instance:previewBattle(raceId, raceId)
		else
			FloatWordMgr.instance:show(lang("精灵未上线，敬请期待"))
		end
	end
end

function BirthdaySportsHireView:_onClickInfo()
	local raceId = self._curPetRace
	local petCfg = CharacterConfig.instance:getPetCo(raceId)

	if raceId ~= 0 then
		if PetbookModel.instance:getIsHandBookPet(petCfg) then
			PetbookController.instance:openPetinfoView(raceId)
		else
			FloatWordMgr.instance:show(lang("精灵未上线，敬请期待"))
		end
	end
end

function BirthdaySportsHireView:_onClickRule()
	TipsFacade.instance:openRulesView("borrot_pet_view_rule")
end

function BirthdaySportsHireView:_onClock()
	if checknumber(self._targetTime) > 0 then
		if ServerTime.now() > self._targetTime then
			self._targetTime = 0

			BorrowPetAgent.instance:sendPM_BorrowPetGetActivityInfosReq(self._activityId)
		else
			self._txtTip.text = langPara("%s", GameUtil.FormatTimeSymbol(self._targetTime - ServerTime.now()))
		end
	end
end

function BirthdaySportsHireView:_PM_BorrowPetGetActivityInfosRes()
	self:_onClickPet(self._curItemId)
end

return BirthdaySportsHireView
