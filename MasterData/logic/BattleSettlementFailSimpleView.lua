-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/BattleSettlementFailSimpleView.lua

module("logic.extensions.battlesettlement.view.BattleSettlementFailSimpleView", package.seeall)

local BattleSettlementFailSimpleView = class("BattleSettlementFailSimpleView", ViewComponent)

function BattleSettlementFailSimpleView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._blurBg = self:getGo("blurBg"):GetComponent(typeof(StaticBluredScreen))
	self._btnStatics = self:getBtn("btnStatics")
	self._rank = self:getGo("bottom/rank")
	self._txtOldRank = self:getTxt("bottom/rank/txtOld")
	self._txtNewRank = self:getTxt("bottom/rank/txtNew")
	self._power = self:getGo("bottom/power")
	self._txtPowerNum = self:getTxt("bottom/power/txtNum")
	self._item1 = self:getGo("bottom/power/imgPower")
	self._damage = self:getGo("bottom/damage")
	self._damageTxt = self:getTxt("bottom/damage/txt")
	self._score = self:getGo("bottom/score")
	self._txtOldScore = self:getTxt("bottom/score/txtOld")
	self._txtNewScore = self:getTxt("bottom/score/txtNew")
	self._btnEquipUp = self:getBtn("bottom/btnEquipUp")
	self._btnPetUp = self:getBtn("bottom/btnPetUp")
	self._btnRecFmt = self:getBtn("bottom/btnRecFmt")
	self._btnStronger = self:getBtn("bottom/btnStronger")
end

function BattleSettlementFailSimpleView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnStatics:AddClickListener(self._onClickStatics, self)
	self._btnEquipUp:AddClickListener(self._onClickEquip, self)
	self._btnPetUp:AddClickListener(self._onClickPetUp, self)
	self._btnRecFmt:AddClickListener(self._onClickFmtRecommend, self)
	self._btnStronger:AddClickListener(self._onClickStronger, self)
end

function BattleSettlementFailSimpleView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnEquipUp:RemoveClickListener()
	self._btnPetUp:RemoveClickListener()
	self._btnRecFmt:RemoveClickListener()
	self._btnStatics:RemoveClickListener()
	self._btnStronger:RemoveClickListener()
end

function BattleSettlementFailSimpleView:onEnter()
	self:_playVoice()

	local enumType = BattleSettlementModel.instance:getType()
	local params = BattleSettlementModel.instance:getParams()
	local isShowPower = params and not params.isHideStrength

	self._rank:SetActive(enumType == BattleSettlementModel.Enum.Arena)
	self._damage:SetActive(enumType == BattleSettlementModel.Enum.LongZunChallenge)
	self._score:SetActive(enumType == BattleSettlementModel.Enum.YoungChampionKingQualifier)
	self._power:SetActive(BattleSettlementModel.instance:isGiveBackTili(enumType) and isShowPower)

	if enumType == BattleSettlementModel.Enum.Arena then
		self._txtOldRank.text = params.preRank
		self._txtNewRank.text = params.postRank
	elseif enumType == BattleSettlementModel.Enum.LongZunChallenge then
		self._damageTxt.text = string.format("本次伤害:<color=#E83A3A>%s</color>", BattleModel.instance.bettleResultData.teamATotalDamage)
	elseif enumType == BattleSettlementModel.Enum.YoungChampionKingQualifier then
		local stepId = params.stepId

		if stepId == YoungChampionKingEnum.Qualify_Step_Id or stepId == YoungChampionKingEnum.Score_Match_Step_Id then
			self._txtOldScore.text = params.oldScore
			self._txtNewScore.text = params.newScore
		else
			self._score:SetActive(false)
		end
	elseif BattleSettlementModel.instance:isGiveBackTili(enumType) and isShowPower and params and params.giveBackItem and not string.nilorempty(params.giveBackItem) then
		local arr = string.splitToNumber(params.giveBackItem, ":")

		self._txtPowerNum.text = "X" .. checknumber(arr[3])

		MaterialMgr.setIcon(self._item1, arr[1], arr[2])
	end

	self:_setBlurBg()
	self:_popupExtraView()
end

function BattleSettlementFailSimpleView:onExit()
	self:_removeBlurBg()
	MaterialMgr.resetAll(self._item1)
end

function BattleSettlementFailSimpleView:_setBlurBg()
	self._blurBg:Release()
	self._blurBg:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._blurBg:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function BattleSettlementFailSimpleView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function BattleSettlementFailSimpleView:_removeBlurBg()
	StaticBluredHook.instance:stop()
	self._blurBg:Release()
end

function BattleSettlementFailSimpleView:_onClickClose()
	BattleController.instance:endBattle()
end

function BattleSettlementFailSimpleView:_playVoice()
	AudioBgmPlayer.instance:startPlayEffect(30202)
end

function BattleSettlementFailSimpleView:_onClickStatics()
	ViewMgr.instance:open(ViewName.BattleStatics)
end

function BattleSettlementFailSimpleView:_onClickEquip()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickGotoEquip)
	UIJumper.instance:pushClearCurStack(ViewName.PetShowView, true, 4)
	self._onClickClose()
end

function BattleSettlementFailSimpleView:_onClickPetUp()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickGotoAwaken)
	UIJumper.instance:pushClearCurStack(ViewName.PetShowView, true, 1)
	self._onClickClose()
end

function BattleSettlementFailSimpleView:_onClickFmtRecommend()
	UIJumper.instance:pushClearCurStack(ViewName.PetNoticeView, true, 5)
	self._onClickClose()
end

function BattleSettlementFailSimpleView:_onClickStronger()
	UIJumper.instance:pushClearCurStack(ViewName.StrongerView, true)
	self._onClickClose()
end

function BattleSettlementFailSimpleView:_popupExtraView()
	local enumType = BattleSettlementModel.instance:getType()

	if enumType == BattleSettlementModel.Enum.ShenJiChallenge then
		local params = BattleSettlementModel.instance:getParams()

		ShenJiChallengeController.instance:openBossBattleResultView(params)
	end
end

return BattleSettlementFailSimpleView
