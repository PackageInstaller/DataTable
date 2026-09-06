-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/view/AngelPowerClgMainView.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgMainView", package.seeall)

local AngelPowerClgMainView = class("AngelPowerClgMainView", ViewComponent)

function AngelPowerClgMainView:ctor()
	AngelPowerClgMainView.super.ctor(self)
end

function AngelPowerClgMainView:unbindEvents()
	AngelPowerClgMainView.super.unbindEvents(self)
end

function AngelPowerClgMainView:bindEvents()
	AngelPowerClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSKill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function AngelPowerClgMainView:buildUI()
	AngelPowerClgMainView.super.buildUI(self)

	self._btnChallenge = self:getGo("btnChallenge")
	self._btnRank = self:getGo("btnRank")
	self._btnCall = self:getGo("btnCall")
	self._btnPrize = self:getGo("btnPrize")
	self._petInfo = self:getGo("petInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtPetName = self:getTxt("petInfo/name/txtName")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("btnRule")
	self._timeGo = self:getGo("time")
	self._txtTime = self:getTxt("time/txtTime")
	self._petRace = self:getGo("petInfo/name/imgRare")
	self._petCon = self:getGo("petCon")
end

function AngelPowerClgMainView:onExit()
	AngelPowerClgMainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRace)
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function AngelPowerClgMainView:onEnter()
	AngelPowerClgMainView.super.onEnter(self)

	self._activityId = self:getFirstParam() or AngelPowerClgModel.instance:getCurrActId()
	self._actCfg = AngelPowerClgConfig.instance:getActivityCfg(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	MaterialMgr.resetAll(self._petRace)
	MaterialMgr.setCell(MatType.Rare, self._actCfg.raceId, self._petRace)

	local petCfg = CharacterConfig.instance:getPetCo(self._actCfg.raceId)

	self._txtPetName.text = petCfg.name
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._actCfg.raceId, self._petCon)
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_initAoqiGodUI()
	AngelPowerAgent.instance:sendPM_AngelPowerGetInfoReq(self._activityId)
end

function AngelPowerClgMainView:_initAoqiGodUI()
	GameUtil.SetActive(self._timeGo, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnRank, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnCall, not self._isAoqiGodProcessType)
end

function AngelPowerClgMainView:_onClickChallenge()
	local cfgs = AngelPowerClgConfig.instance:getStageCfgs(self._activityId)
	local allPass = AngelPowerClgModel.instance:getPassStage(self._activityId) >= #cfgs

	if self._isAoqiGodProcessType and allPass then
		AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.AngelPowerClg, self._activityId)
	end

	if allPass then
		FloatWordMgr.instance:show(lang("已通过全部关卡"))
	else
		UIStateManager.instance:push(ViewName.AngelPowerClgLevelView, self._activityId)
	end
end

function AngelPowerClgMainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jumpTo[1])
end

function AngelPowerClgMainView:_onClickCall()
	GotoMgr.gotoByString(self._actCfg.jumpTo[2])
end

function AngelPowerClgMainView:_onClickPrize()
	GotoMgr.gotoByString(self._actCfg.jumpTo[3])
end

function AngelPowerClgMainView:_onClickSKill()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:previewBattle(self._actCfg.raceId)
	end
end

function AngelPowerClgMainView:_onClickInfo()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:openPetinfoView(self._actCfg.raceId)
	end
end

function AngelPowerClgMainView:_onClickRule()
	TipsFacade.instance:openRulesView("angel_power_rule")
end

return AngelPowerClgMainView
