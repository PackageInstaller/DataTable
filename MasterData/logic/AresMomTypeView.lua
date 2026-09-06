-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomTypeView.lua

module("logic.extensions.aresmom.view.AresMomTypeView", package.seeall)

local AresMomTypeView = class("AresMomTypeView", ViewComponent)

function AresMomTypeView:buildUI()
	AresMomTypeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtChallenge = goutil.findChildTextComponent(self._btnChallenge, "Text")
	self._btnPrize = self:getGo("btnPrize")
	self._btnRedPoint = goutil.findChild(self._btnPrize, "redPoint")
	self._stageList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("stageList/stage_" .. i)
		cell.bgChange = goutil.findChildComponent(cell.go, "bg", "UIImageSpriteChange")
		cell.markPass = goutil.findChildComponent(cell.go, "markPass", "UIImageSpriteChange")
		cell.txtScore = goutil.findChildTextComponent(cell.go, "txtScore")
		cell.txtLevel = goutil.findChildTextComponent(cell.go, "txtLevel")
		cell.txtLevel.text = i
		cell.animParm = nil
		cell.info = nil
		self._stageList[i] = cell
	end

	self._descView = self:getGo("desc/descView")
	self._txtRewardDesc = self:getTxt("desc/descView/reward/txt")
	self._txtSpecialDesc = self:getTxt("desc/descView/special/txt")
	self._txtBattleDesc = self:getTxt("desc/descView/battleRule/txt")
	self._stageAnimParms = {
		{
			posY = 25,
			scale = 1,
			posX = 92,
			localPos = Vector3.zero
		},
		{
			posY = 22,
			scale = 0.8,
			posX = 335,
			localPos = Vector3.zero
		},
		{
			posY = 72,
			scale = 0.6,
			posX = 516,
			localPos = Vector3.zero
		},
		{
			posY = 72,
			scale = 0.6,
			posX = -331,
			localPos = Vector3.zero
		},
		{
			posY = 22,
			scale = 0.8,
			posX = -153,
			localPos = Vector3.zero
		}
	}
	self._drag = Framework.UIDragTrigger.Get(self:getGo("rayTrigger"))
end

function AresMomTypeView:bindEvents()
	AresMomTypeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)
end

function AresMomTypeView:unbindEvents()
	AresMomTypeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnPrize)
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
end

function AresMomTypeView:onEnter()
	AresMomTypeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._challengeId = checknumber(params[1])
	self._type = checknumber(params[2])

	local isInTime = AresMomController.instance:isInTime(self._challengeId)

	if not isInTime or self._type <= 0 then
		local text = "未开启"

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	local curTypeCfg = AresMomConfig.instance:getTypeCfg(self._challengeId, self._type)

	self._curTypeCfg = curTypeCfg
	self.stagePlanId = AresMomConfig.instance:getStagePlanId(self._challengeId, self._type)
	self._txtRewardDesc.text = curTypeCfg and curTypeCfg.rewardRuleDesc
	self._txtSpecialDesc.text = curTypeCfg and curTypeCfg.specialRuleDesc
	self._txtBattleDesc.text = curTypeCfg and curTypeCfg.formRuleDesc
	self._curInfo = AresMomModel.instance:getChallengeInfo(self._type)
	self._curSwithId = nil

	for i = 1, 5 do
		self._stageList[i].bgChange:SetState(self._type - 1)
	end

	if self._curInfo then
		AresMomModel.instance:setCurType(self._type)
		self:refreshView()
	end

	GlobalDispatcher:addListener(GlobalNotify.AresMomGainPrize, self._refreshPrizeRd, self)
	self:_forceRebuildLayoutAllChild(self._descView)
end

function AresMomTypeView:onExit()
	AresMomTypeView.super.onExit(self)
	removetimer(self._doMoveAnim, self)

	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end

	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end

	GlobalDispatcher:removeListener(GlobalNotify.AresMomGainPrize, self._refreshPrizeRd, self)
end

function AresMomTypeView:_onClickTip()
	return
end

function AresMomTypeView:_onClickChallenge()
	local info = self.infoList[self._curSwithId]

	if not info or not info.stage or not info.stageCfg then
		printError("配置为空")

		return
	end

	if self._curTypeCfg.useSystemPet then
		local mo = AresMomModel.instance:getCurSupCustomFmtMo()

		mo:initParams(info.stage, info.stageCfg.creepsMasterId, info.stageCfg.sysPetPlanId, self._challengeId, self._type)
		CustomFmtController.instance:showMissionView(mo)
	else
		local mo = AresMomModel.instance:getCurOwerCustomFmtMo()

		mo:initParams(info.stage, info.stageCfg.creepsMasterId, self._challengeId, self._type)
		CustomFmtController.instance:showMissionView(mo)
	end
end

function AresMomTypeView:_forceRebuildLayoutAllChild(mainGo)
	if mainGo:GetComponent(typeof(UnityEngine.UI.LayoutGroup)) ~= nil then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(mainGo:GetComponent(goutil.Type_RectTransform))
	end

	for idx = 1, mainGo.transform.childCount do
		local go = mainGo.transform:GetChild(idx - 1).gameObject

		self:_forceRebuildLayoutAllChild(go)
	end
end

function AresMomTypeView:_onClickPrize()
	UIStateManager.instance:push(ViewName.AresMomPrizeView, self._challengeId, self._type)
end

function AresMomTypeView:refreshView()
	local curDayId = self._curInfo.stageDay

	self.infoList = {}

	for k, v in ipairs(self._curInfo.stageInfoList) do
		local info = {}

		info.stage = k
		info.curScore = checkint(v)
		info.stageCfg = AresMomConfig.instance:getStageCfg(self.stagePlanId, curDayId, info.stage)

		table.insert(self.infoList, info)
	end

	self:_resetStageCellState()
	self:_refreshPrizeRd()
end

function AresMomTypeView:_resetStageCellState()
	for i = 1, 5 do
		local stageCell = self._stageList[i]
		local stageData = self.infoList[i]
		local animParm = self._stageAnimParms[i]

		stageCell.markPass:SetState(1)

		if stageData and stageData.curScore > 0 then
			stageCell.markPass:SetState(0)
		end

		if stageData then
			::label_12_0::

			local var_12_0 = stageData.stageCfg

			if stageData.stageCfg then
				local settleId = stageData.stageCfg.settleId
				local settleCfg = AresMomConfig.instance:getSettlerCfg(settleId)

				stageCell.txtScore.text = settleCfg and langPara(settleCfg.des, stageData.curScore) or ""

				GameUtil.setAnchoredPos(stageCell.go, animParm.posX, animParm.posY)
				GameUtil.setLocalScale(stageCell.go, animParm.scale, animParm.scale, animParm.scale)

				animParm.localPos = GameUtil.getLocalPos(stageCell.go)
			end
		end
	end

	local parms = self:getOpenParam()

	self._curSwithId = checkint(parms[2])

	if self._curSwithId < 1 or self._curSwithId > 5 then
		self._curSwithId = 1
	end

	for i = 1, 5 do
		local dataId = self._curSwithId + i - 1

		if dataId > 5 then
			dataId = dataId - 5
		end

		local stageData = self.infoList[dataId]

		if not stageData or stageData.curScore <= 0 then
			self._curSwithId = dataId

			break
		end
	end

	self:_onSwitchId()

	for i = 1, 5 do
		local stageCell = self._stageList[i]
		local animId = i - self._curSwithId + 1

		if animId < 1 then
			animId = animId + 5
		end

		local animParm = self._stageAnimParms[animId]

		GameUtil.setAnchoredPos(stageCell.go, animParm.posX, animParm.posY)
		GameUtil.setLocalScale(stageCell.go, animParm.scale, animParm.scale, animParm.scale)
	end
end

function AresMomTypeView:_onDrag(eventData)
	self._disMove = self._disMove + eventData.delta.x

	if self._ableToMove then
		if self._disMove > 120 then
			self:switchRight()

			self._ableToMove = false
		elseif self._disMove < -120 then
			self:switchLeft()

			self._ableToMove = false
		end
	end
end

function AresMomTypeView:_onBeginDrag(eventData)
	self._curMoveStep = 0
	self._disMove = 0
	self._needMoveStep = 0
	self._ableToMove = true
end

function AresMomTypeView:_onEndDrag(eventData)
	self._curMoveStep = 0
	self._disMove = 0
	self._needMoveStep = 0

	removetimer(self._doMoveAnim, self)

	self._ableToMove = false
end

function AresMomTypeView:_doMoveAnim()
	if self._curMoveStep > self._needMoveStep then
		self._curMoveStep = self._curMoveStep - 1

		self:switchLeft()
	elseif self._curMoveStep < self._needMoveStep then
		self._curMoveStep = self._curMoveStep + 1

		self:switchRight()
	end

	if self._curMoveStep == self._needMoveStep then
		removetimer(self._doMoveAnim, self)
	end
end

function AresMomTypeView:switchRight()
	local leftestId = self._curSwithId + 2

	if leftestId > 5 then
		leftestId = leftestId - 5
	end

	self._stageList[leftestId].go.transform:SetAsFirstSibling()

	for i = 1, 5 do
		local nextId = i + 2 - self._curSwithId

		if nextId > 5 then
			nextId = nextId - 5
		elseif nextId < 1 then
			nextId = nextId + 5
		end

		local cell = self._stageList[i]
		local animParm = self._stageAnimParms[nextId]
		local tweenMove = cell.go.transform:DOLocalMove(animParm.localPos, 0.5):SetEase(DG.Tweening.Ease.Linear)
		local newScale = Vector3.New(animParm.scale, animParm.scale, animParm.scale)
		local tweenScale = cell.go.transform:DOScale(newScale, 0.5):SetEase(DG.Tweening.Ease.Linear)

		self._tweenList = self._tweenList or {}

		table.insert(self._tweenList, tweenMove)
		table.insert(self._tweenList, tweenScale)
	end

	self._curSwithId = self._curSwithId - 1

	if self._curSwithId < 1 then
		self._curSwithId = 5
	end

	self:_onSwitchId()
end

function AresMomTypeView:switchLeft()
	local leftestId = self._curSwithId + 3

	if leftestId > 5 then
		leftestId = leftestId - 5
	end

	self._stageList[leftestId].go.transform:SetAsFirstSibling()

	for i = 1, 5 do
		local nextId = i - self._curSwithId

		if nextId < 1 then
			nextId = 5 + nextId
		end

		local cell = self._stageList[i]
		local animParm = self._stageAnimParms[nextId]
		local tweenMove = cell.go.transform:DOLocalMove(animParm.localPos, 0.5):SetEase(DG.Tweening.Ease.Linear)
		local newScale = Vector3.New(animParm.scale, animParm.scale, animParm.scale)
		local tweenScale = cell.go.transform:DOScale(newScale, 0.5):SetEase(DG.Tweening.Ease.Linear)

		self._tweenList = self._tweenList or {}

		table.insert(self._tweenList, tweenMove)
		table.insert(self._tweenList, tweenScale)
	end

	self._curSwithId = self._curSwithId + 1

	if self._curSwithId > 5 then
		self._curSwithId = 1
	end

	self:_onSwitchId()
end

function AresMomTypeView:_onSwitchId()
	local info = self.infoList[self._curSwithId]

	self._txtChallenge.text = info and info.curScore > 0 and lang("重新挑战") or lang("开始挑战")

	if self._selectEff then
		self._selectEff:setParent(self._stageList[self._curSwithId].go.transform)
		self._selectEff:setScale(1)
		self._selectEff:setLocalPos(0, -120, 0)
	else
		self._selectEff = UIEffectManager.instance:playEffect(self, "20220930/aruisimuqin/fx_ui_aruisimq_select.prefab", nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self._stageList[self._curSwithId].go.transform)
			eff:setLocalPos(0, -120, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	end
end

function AresMomTypeView:_onClickClose()
	local viewName = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_VIEW_NAME_CHALLENGE")

	if not string.nilorempty(viewName) then
		UIStateManager.instance:push(viewName, self._challengeId)
	end

	self:close()
end

function AresMomTypeView:_refreshPrizeRd()
	goutil.setActive(self._btnRedPoint, AresMomModel.instance:getIsAbleToGetPrize(self._type))
end

return AresMomTypeView
