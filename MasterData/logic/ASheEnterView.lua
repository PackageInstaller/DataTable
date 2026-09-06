-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/ASheEnterView.lua

module("logic.extensions.ashechallenge.view.ASheEnterView", package.seeall)

local ASheEnterView = class("ASheEnterView", ViewComponent)

function ASheEnterView:ctor()
	ASheEnterView.super.ctor(self)
end

function ASheEnterView:buildUI()
	ASheEnterView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnTry = self:getBtn("btnTry")
	self._btnRank = self:getBtn("btnRank")
	self._btnShop = self:getBtn("btnShop")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnCultivate = self:getBtn("btnCultivate")
	self._btnReturn = self:getBtn("btnReturn")
	self._con = self:getGo("con")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/rare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtTime = self:getTxt("time/txt")
	self._goldBarCon = self:getGo("goldBarCon")
end

function ASheEnterView:bindEvents()
	ASheEnterView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnTry:AddClickListener(self._onClickTry, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnShop:AddClickListener(self._onClickShop, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnCultivate:AddClickListener(self._onClickCultivate, self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
end

function ASheEnterView:unbindEvents()
	ASheEnterView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnTry:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnCultivate:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function ASheEnterView:onEnter()
	ASheEnterView.super.onEnter(self)

	self._activityType = ASheModel.instance:getActivityType()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self:_getActivityId()
	end

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	printInfo("test ASheEnterView:onEnter", self._activityId, self._activityType)

	if not isInTime then
		self:_showPopupView()
	end

	self:_initPetInfo()
	self:_initActivityTime()
	self:_showRoleModel()
	self:_setGoldBarCon()
end

function ASheEnterView:onExit()
	ASheEnterView.super.onExit(self)
	self:_resetRoleModel()
	self:_resetPetInfo()
end

function ASheEnterView:_onClickTip()
	local key = ASheConfig.instance:getClientCommonValue(self._activityId, "RULE")

	UIStateManager.instance:push(ViewName.RulesView, key)
end

function ASheEnterView:_onClickTry()
	local str = ASheConfig.instance:getClientCommonValue(self._activityId, "JUMP_TO_1")

	GotoMgr.gotoByString(str)
end

function ASheEnterView:_onClickRank()
	local str = ASheConfig.instance:getClientCommonValue(self._activityId, "JUMP_TO_2")

	GotoMgr.gotoByString(str)
end

function ASheEnterView:_onClickShop()
	local str = ASheConfig.instance:getClientCommonValue(self._activityId, "JUMP_TO_3")

	GotoMgr.gotoByString(str)
end

function ASheEnterView:_onClickChallenge()
	UIStateManager.instance:push(self:_getMainView())
end

function ASheEnterView:_onClickCultivate()
	local str = ASheConfig.instance:getClientCommonValue(self._activityId, "JUMP_TO_4")

	GotoMgr.gotoByString(str)
end

function ASheEnterView:_onClickReturn()
	local str = ASheConfig.instance:getClientCommonValue(self._activityId, "JUMP_TO_5")

	GotoMgr.gotoByString(str)
end

function ASheEnterView:_initPetInfo()
	self._skinId = nil
	self._raceId = ASheConfig.instance:getClientCommonValue(self._activityId, "RACE_ID", true)
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function ASheEnterView:_setGoldBarCon()
	local value = ASheConfig.instance:getClientCommonValue(self._activityId, "SHOW_COIN")
	local matMo = string.splitToNumber(value, ":")
	local name = matMo[1] .. ":" .. matMo[2]
	local objList = {
		{
			showAdd = true,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function ASheEnterView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function ASheEnterView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId, self._skinId)
	end
end

function ASheEnterView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function ASheEnterView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function ASheEnterView:_initActivityTime()
	local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function ASheEnterView:_resetPetInfo()
	MaterialMgr.resetAll(self._rare)
end

function ASheEnterView:_showPopupView()
	local title = lang("tip")
	local text = lang("outtime")

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func)
end

function ASheEnterView:_getActivityId()
	self._activityId = ASheModel.instance:getActivityId()
end

function ASheEnterView:_getMainView()
	return ViewName.ASheMainView
end

return ASheEnterView
