-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonMainView.lua

module("logic.extensions.bonedragon.view.BoneDragonMainView", package.seeall)

local BoneDragonMainView = class("BoneDragonMainView", ViewComponent)

function BoneDragonMainView:ctor()
	BoneDragonMainView.super.ctor(self)
end

function BoneDragonMainView:unbindEvents()
	BoneDragonMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnJump4)
end

function BoneDragonMainView:bindEvents()
	BoneDragonMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnExtClg, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnInfo, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, self._onClickFirPass, self)
end

function BoneDragonMainView:buildUI()
	BoneDragonMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._txtTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnChallenge = self:getGo("btnExtClg/btn")
	self._firstPass = self:getGo("btnExtClg/firstPass")
end

function BoneDragonMainView:onExit()
	BoneDragonMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function BoneDragonMainView:onEnter()
	BoneDragonMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonClgInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 488001
	end

	self._actCfg = BoneDragonConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = BoneDragonConfig.instance:getStageCfgs(self._activityId)

	self:_onSetUI()
	BoneDragonModel.instance:setActivityId(self._activityId)
	BoneDragonController.instance:sendPM_BoneDragonClgInfoReq(self._activityId)
end

function BoneDragonMainView:_onSetUI()
	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = self._actCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end
end

function BoneDragonMainView:_onClickBtnJump(jumpIdx)
	local btnStr = self._actCfg.jumpTo[jumpIdx]

	GotoMgr.gotoByString(btnStr)
end

function BoneDragonMainView:_onClickBtnExtClg(jumpIdx)
	UIStateManager.instance:push(ViewName.BoneDragonChallengeView, self._activityId)
end

function BoneDragonMainView:_onBtnSkillClg()
	local raceId = self:_getRaceId()
	local skinId = self._actCfg.skinId

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function BoneDragonMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function BoneDragonMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function BoneDragonMainView:_onUpdate()
	self._info = BoneDragonModel.instance:getInfo(self._activityId)

	local stageNum = #self._stageCfgs

	GameUtil.SetActive(self._firstPass, stageNum <= self._info.bestStageId)
end

function BoneDragonMainView:_getRaceId()
	local skinId = self._actCfg.skinId

	return PetSkinConfig.instance:getPetSkinRaceId(skinId)
end

function BoneDragonMainView:_onClickFirPass()
	UltimateTrialController.instance:gotoFirstPassRankView(self._activityId)
end

return BoneDragonMainView
