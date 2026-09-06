-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/view/BoccaccioclgmainView.lua

module("logic.extensions.boccaccioclg.view.BoccaccioclgmainView", package.seeall)

local BoccaccioclgmainView = class("BoccaccioclgmainView", ViewComponent)

function BoccaccioclgmainView:ctor()
	BoccaccioclgmainView.super.ctor(self)
end

function BoccaccioclgmainView:buildUI()
	BoccaccioclgmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/rare")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnGos = {}

	local jumpBtnCol = self:getGo("jumpBtnCol")

	for i = 1, jumpBtnCol.transform.childCount do
		local go = jumpBtnCol.transform:GetChild(i - 1).gameObject

		table.insert(self._jumpBtnGos, go)
	end

	self._btnClg = goutil.findChild(self.mainGO, "btnClg")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._txtOpen = self:getTxt("btnClg/open/txt")
end

function BoccaccioclgmainView:bindEvents()
	BoccaccioclgmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtnJump, self, i))
	end

	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
end

function BoccaccioclgmainView:unbindEvents()
	BoccaccioclgmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.rmClickHandler(v)
	end

	GameUtil.rmClickHandler(self._btnClg)
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function BoccaccioclgmainView:onEnter()
	BoccaccioclgmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BoccaccioClgGetInfoRes, self._updateUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._actCfg = BoccaccioclgConfig.instance:getActCfg(self._activityId)

	self:_updateStaticUI()
	BoccaccioClgAgent.instance:sendPM_BoccaccioClgGetInfoReq(self._activityId)
end

function BoccaccioclgmainView:onExit()
	BoccaccioclgmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
end

function BoccaccioclgmainView:_getRaceId()
	return self._actCfg.raceId
end

function BoccaccioclgmainView:_onClickBtnJump(idx)
	if self._actCfg.jumpList and self._actCfg.jumpList[idx] then
		GotoMgr.gotoByString(self._actCfg.jumpList[idx])
	end
end

function BoccaccioclgmainView:_onClickBtnClg()
	if not BoccaccioclgController.instance:isInChallengeTime(self._activityId) then
		FloatWordMgr.instance:show("暂未开启")

		return
	end

	UIStateManager.instance:push(ViewName.BoccaccioclgstageView, self._activityId)
end

function BoccaccioclgmainView:_onClickBtnTip()
	local challengeCfg = BoccaccioclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function BoccaccioclgmainView:_updateUI()
	self._info = BoccaccioclgModel.instance:getInfo(self._activityId)

	local rankCfg = GodDailyRankConfig.instance:getRankCfgById(self._activityId)

	if not rankCfg.challengeClosedTimeRange then
		local arr = string.split(rankCfg.challengeClosedTimeRange, "-") or {}
		local startStr = self:_getHourMinFormat(arr[2])
		local endStr = self:_getHourMinFormat(arr[1])

		self._txtOpen.text = string.format("可挑战时间\n%s-%s", startStr, endStr)
	end
end

function BoccaccioclgmainView:_getHourMinFormat(timeStr)
	local arr = string.split(timeStr, ":") or {}

	return string.format("%s:%s", arr[1], arr[2])
end

function BoccaccioclgmainView:_isInChallengeTime()
	local rankCfg = GodDailyRankConfig.instance:getRankCfgById(self._activityId)

	if not rankCfg.challengeClosedTimeRange then
		local arr = string.split(rankCfg.challengeClosedTimeRange, "-") or {}

		return not GameUtil.checkIsInTimePeriod(arr[1], arr[2], true)
	end
end

function BoccaccioclgmainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getRaceId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function BoccaccioclgmainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Boccaccioclg)
	end
end

function BoccaccioclgmainView:_onClickbtnSkill()
	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self:_getRaceId())
end

function BoccaccioclgmainView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

return BoccaccioclgmainView
