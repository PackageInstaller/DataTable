-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/borrowpet/view/BorrowPetView.lua

module("logic.extensions.borrowpet.view.BorrowPetView", package.seeall)

local BorrowPetView = class("BorrowPetView", ViewComponent)

function BorrowPetView:ctor()
	BorrowPetView.super.ctor(self)
end

function BorrowPetView:buildUI()
	BorrowPetView.super.buildUI(self)

	self._cellList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("cell_" .. i)
		cell.pointRare = goutil.findChild(cell.go, "petInfo/pointRare")
		cell.btnSkill = goutil.findChild(cell.go, "petInfo/btnSkill")
		cell.btnIntroduce = goutil.findChild(cell.go, "petInfo/btnIntroduce")
		cell.btnBorrow = goutil.findChild(cell.go, "btnBorrow")
		cell.txtBorrow = goutil.findChildTextComponent(cell.go, "btnBorrow/txt")
		cell.txtName = goutil.findChildTextComponent(cell.go, "petInfo/txtName")
		cell.itemId = 0
		cell.skinId = 0
		self._cellList[i] = cell
	end

	self._txtTip = self:getTxt("txtTip")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnRule = self:getGo("btnRule")
	self._cellGo = self:getGo("cell")
	self._cellContainer = self:getGo("cellContainer")
	self._posRecord = self._cellContainer:GetComponent(ComponentType.TestRecordPos)
	self._cellTableView = ItemGroup.New(self._cellContainer, self._cellGo)
end

function BorrowPetView:bindEvents()
	BorrowPetView.super.bindEvents(self)

	for k, cell in ipairs(self._cellList) do
		GameUtil.addClickHandler(cell.btnSkill, GameUtil.handler(self._onClickSkill, self, cell))
		GameUtil.addClickHandler(cell.btnIntroduce, GameUtil.handler(self._onClickInfo, self, cell))
		GameUtil.addClickHandler(cell.btnBorrow, GameUtil.handler(self._onClickBorrow, self, cell))
	end

	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function BorrowPetView:unbindEvents()
	BorrowPetView.super.unbindEvents(self)

	for k, cell in ipairs(self._cellList) do
		GameUtil.rmClickHandler(cell.btnSkill)
		GameUtil.rmClickHandler(cell.btnIntroduce)
		GameUtil.rmClickHandler(cell.btnBorrow)
	end

	GameUtil.rmClickHandler(self._btnRule)
end

function BorrowPetView:onEnter()
	BorrowPetView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BorrowPetGetActivityInfosRes, self._refreshViewByInfo, self)

	self._activityId = BorrowPetModel.instance:getCurrActId()

	self:_refreshViewByCfg(self._activityId)

	if not self._activityId then
		FloatWordMgr.instance:show("此活动未在时间内")
		self:close()

		return
	end

	BorrowPetAgent.instance:sendPM_BorrowPetGetActivityInfosReq(self._activityId)

	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.BorrowPet, self._activityId)
end

function BorrowPetView:onExit()
	BorrowPetView.super.onExit(self)

	for k, cell in ipairs(self._cellList) do
		MaterialMgr.resetAll(cell.pointRare)
	end

	self._cellTableView:dispose(self._clearCell, self)
end

function BorrowPetView:_refreshViewByCfg(activityId)
	self._activityCfg = BorrowPetConfig.instance:getActivityCfg(activityId)
	self._petsPlanCfg = BorrowPetConfig.instance:getBorrowPetPlanListCfg(self._activityCfg.planId)

	self._cellTableView:updateWithMoArray(self._petsPlanCfg, self._updateCell, self)
	self._posRecord:LoadPlan(#self._petsPlanCfg - 1)
end

function BorrowPetView:_refreshViewByInfo()
	self._cellTableView:updateWithMoArray(self._petsPlanCfg, self._updateCell, self)
end

function BorrowPetView:_updateCell(cell, data, index)
	local go = cell.mainGO
	local pointRare = goutil.findChild(go, "petInfo/pointRare")
	local btnSkill = goutil.findChild(go, "petInfo/btnSkill")
	local btnIntroduce = goutil.findChild(go, "petInfo/btnIntroduce")
	local btnBorrow = goutil.findChild(go, "btnBorrow")
	local txtBorrow = goutil.findChildTextComponent(go, "btnBorrow/txt")
	local txtName = goutil.findChildTextComponent(go, "petInfo/txtName")
	local itemCfg = BorrowPetConfig.instance:getBorrowPetItemCfg(data.itemId)
	local posRecord = go:GetComponent(ComponentType.TestRecordPos)

	GameUtil.rmClickHandler(btnSkill)
	GameUtil.addClickHandler(btnSkill, function()
		self:_onClickSkill(itemCfg.raceId)
	end)
	GameUtil.rmClickHandler(btnIntroduce)
	GameUtil.addClickHandler(btnIntroduce, function()
		self:_onClickInfo(itemCfg.raceId)
	end)
	GameUtil.rmClickHandler(btnBorrow)
	GameUtil.addClickHandler(btnBorrow, function()
		self:_onClickBorrow(data)
	end)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(itemCfg.raceId)

	if skinCfg then
		MaterialMgr.setCell(MatType.Rare, itemCfg.raceId, pointRare)

		txtName.text = skinCfg.name
	end

	local isCanBorrow = BorrowPetModel.instance:getBorrowTimes(self._activityId) < self._activityCfg.weeklyBorrowTimes

	txtBorrow.text = isCanBorrow and lang("助战") or lang("已助战")

	local onlineTime = 0

	if not string.nilorempty(data.onlineTime) then
		onlineTime = GameUtil.string2time(data.onlineTime)
	end

	local offlineTime = 0

	if not string.nilorempty(data.offlineTime) then
		offlineTime = GameUtil.string2time(data.offlineTime)
	end

	local isOpen = (onlineTime == 0 or onlineTime < ServerTime.now()) and (offlineTime == 0 or offlineTime > ServerTime.now())

	GameUtil.SetGray(btnBorrow, not isCanBorrow)
	GameUtil.SetActive(btnBorrow, isOpen)

	if index == 1 then
		posRecord:LoadPlan(0)
	elseif index == #self._petsPlanCfg then
		posRecord:LoadPlan(2)
	else
		posRecord:LoadPlan(1)
	end
end

function BorrowPetView:_clearCell(cell)
	local go = cell.mainGO
	local btnSkill = goutil.findChild(go, "petInfo/btnSkill")
	local btnIntroduce = goutil.findChild(go, "petInfo/btnIntroduce")
	local btnBorrow = goutil.findChild(go, "btnBorrow")

	GameUtil.rmClickHandler(btnSkill)
	GameUtil.rmClickHandler(btnIntroduce)
	GameUtil.rmClickHandler(btnBorrow)
end

function BorrowPetView:_onClickBorrow(data)
	BorrowPetAgent.instance:sendPM_BorrowPetBorrowReq(self._activityId, data.itemId)
end

function BorrowPetView:_onClickSkill(raceId)
	if raceId ~= 0 then
		PetbookController.instance:previewBattle(raceId, raceId)
	end
end

function BorrowPetView:_onClickInfo(raceId)
	if raceId ~= 0 then
		PetbookController.instance:openPetinfoView(raceId)
	end
end

function BorrowPetView:_onClickRule()
	TipsFacade.instance:openRulesView("borrot_pet_view_rule")
end

return BorrowPetView
