-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManLotteryView.lua

module("logic.extensions.beastrichman.view.BeastRichManLotteryView", package.seeall)

local BeastRichManLotteryView = class("BeastRichManLotteryView", ViewComponent)

function BeastRichManLotteryView:ctor()
	BeastRichManLotteryView.super.ctor(self)
end

function BeastRichManLotteryView:unbindEvents()
	BeastRichManLotteryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnToggle)
	GameUtil.rmClickHandler(self._btnGetPrize)
	GameUtil.rmClickHandler(self._leftArrow)
	GameUtil.rmClickHandler(self._rightArrow)
end

function BeastRichManLotteryView:bindEvents()
	BeastRichManLotteryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnToggle, self._onClickBtnToggle, self)
	GameUtil.addClickHandler(self._btnGetPrize, self._onClickBtnGetPrize, self)
	GameUtil.addClickHandler(self._leftArrow, self._onClickBtnLeftArrow, self)
	GameUtil.addClickHandler(self._rightArrow, self._onClickBtnRightArrow, self)
end

function BeastRichManLotteryView:buildUI()
	BeastRichManLotteryView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._toggleSkipAnim = self:getToggle("toggleSkipAnim")
	self._con = self:getGo("con")
	self._btnToggle = self:getGo("btnToggle")
	self._imgGouXuan = self:getGo("btnToggle/Background/imgGouXuan")
	self._btnGetPrize = self:getGo("right/prizeWheel/btnGetPrize")
	self._btnGetPrizeText = self:getTxt("right/prizeWheel/btnGetPrize/text")
	self._txtTip = self:getTxt("right/tip/txt")
	self._rewardPool = self:getGo("right/rewardPool")
	self._rewardGoList = GameUtil.getChildren(self._rewardPool.transform)
	self._rewardGoTable = {}
	self._imgChooseList = {}

	for i = 1, 8 do
		local rewardGo = self:getGo("right/rewardPool/reward" .. i)

		table.insert(self._rewardGoTable, rewardGo)

		local imgChooseGo = goutil.findChild(self._rewardGoList[i], "imgChoose")

		table.insert(self._imgChooseList, imgChooseGo)
	end

	self._rightArrow = self:getGo("right/rightArrow")
	self._leftArrow = self:getGo("right/leftArrow")
	self._rewardArrow = self:getGo("right/rewardArrow")
	self._imgSelect = self:getGo("right/rewardPool/imgSelect")
	self._rotateDuration = 5
	self._curSelectIndex = 1
end

function BeastRichManLotteryView:onExit()
	BeastRichManLotteryView.super.onExit(self)
	BeastRichmanController.instance:setNeedAutoPop(false)
	RoleObjectPool.instance:removeRole(self._role)
end

function BeastRichManLotteryView:onEnter()
	BeastRichManLotteryView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleEventRes, self._onEventRes, self)

	self._params = self:getOpenParam()
	self._activityId = checknumber(self._params[1])
	self._zoneId = checknumber(self._params[2])
	self._gridId = checknumber(self._params[3])
	self._isCurGrid = self._params[4]

	local zoneMap = BeastRichmanModel.instance:getZoneMap(self._activityId)
	local zone = zoneMap and zoneMap[self._zoneId]
	local state = zone and zone.state

	self._eventInfo = state and state.event
	self._dataTb = GameUtil.jsonToTable(self._eventInfo.param)
	self._gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._gridId)
	self._eventId = self._gridCfg.eventId
	self._eventCfg = BeastRichmanConfig.instance:getEventCfgById(self._activityId, self._eventId)
	self._canLotteryWheelId = checknumber(self._eventCfg.eventParam)
	self._lotteryPrizeCfgs = BeastRichmanConfig.instance:getLotteryPrizeCfgsById(self._activityId, self._canLotteryWheelId)
	self._lotteryExtraCfgs = BeastRichmanConfig.instance:getLotteryExtraCfgs(self._activityId)
	self._selectPoolId = self._canLotteryWheelId
	self._selectRound = BeastRichmanController.instance:getWheelCurRound(self._activityId, self._zoneId, self._eventId, self._selectPoolId)
	self._curShowGridId = self._gridId

	local key = string.format("BeastRichManLotteryView_%s", self._activityId)

	self._isSkipAnim = checkbool(GameUtil.getUserData(key))

	self:_initUI()
	self:_onUpdate()
end

function BeastRichManLotteryView:_initUI()
	GameUtil.SetActive(self._imgGouXuan, self._isSkipAnim)
	self:_initWheelUI()
end

function BeastRichManLotteryView:_setRole()
	local lotteryExtraCfg = BeastRichmanConfig.instance:getLotteryExtraCfgById(self._activityId, self._selectPoolId)
	local skinId = lotteryExtraCfg.skinId
	local posAndSize = lotteryExtraCfg.posAndSize

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	GameUtil.setLocalPos(self._con, posAndSize[1], posAndSize[2], 0)
	GameUtil.setLocalScale(self._con, posAndSize[3], posAndSize[3], posAndSize[3])
end

function BeastRichManLotteryView:_initWheelUI()
	for i = 1, 8 do
		GameUtil.SetActive(self._imgChooseList[i], false)

		local rewardGo = self._rewardGoTable[i]
		local icon = goutil.findChild(rewardGo, "icon")
		local hasGain = goutil.findChild(rewardGo, "hasGain")
		local txtNum = goutil.findChildTextComponent(rewardGo, "num/txtNum")

		GameUtil.SetGray(icon, false)
		GameUtil.SetActive(hasGain, false)
		GameUtil.SetActive(txtNum.gameObject, true)
	end

	GameUtil.setLocalRotation(self._rewardArrow, 0, 0, -45 * (self._curSelectIndex - 1))
	GameUtil.setLocalRotation(self._imgSelect, 0, 0, -270 - 45 * (self._curSelectIndex - 1))
	GameUtil.SetActive(self._leftArrow, true)
	GameUtil.SetActive(self._rightArrow, true)
end

function BeastRichManLotteryView:_onUpdate()
	self:_initWheelUI()

	local zoneMap = BeastRichmanModel.instance:getZoneMap(self._activityId)
	local zone = zoneMap and zoneMap[self._zoneId]
	local state = zone and zone.state

	self._eventInfo = state and state.event
	self._poolLotteryMap = BeastRichmanController.instance:getWheelPoolInfoMap(self._activityId, self._zoneId)
	self._poolLotteryList = BeastRichmanController.instance:getWheelPoolList(self._activityId, self._zoneId)

	local curWheelPrizeCfgs = BeastRichmanConfig.instance:getLotteryPrizeCfgsById(self._activityId, self._selectPoolId)

	self._curWheelInfoList = self._poolLotteryMap[self._selectPoolId] or {}
	self._showRewardCfgs = nil

	local totalRoundNum = #curWheelPrizeCfgs
	local curGridId = self:_getGridIdByWheelId(self._selectPoolId)

	if curGridId then
		self._curShowGridId = curGridId
		self._isCurGrid = self._selectPoolId == self._canLotteryWheelId
	end

	if self._selectRound > 0 then
		self._showRewardCfgs = BeastRichmanConfig.instance:getLotteryPrizeCfgsByRound(self._activityId, self._selectPoolId, self._selectRound)

		GameUtil.SetActive(self._leftArrow, self._selectRound > 1)
		GameUtil.SetActive(self._rightArrow, totalRoundNum > self._selectRound)
	else
		local curRound = BeastRichmanController.instance:getWheelCurRound(self._activityId, self._zoneId, self._eventId, self._selectPoolId)

		if curRound > 0 then
			self._showRewardCfgs = BeastRichmanConfig.instance:getLotteryPrizeCfgsByRound(self._activityId, self._selectPoolId, curRound)
		end

		GameUtil.SetActive(self._leftArrow, curRound > 1)
		GameUtil.SetActive(self._rightArrow, curRound < totalRoundNum)
	end

	self:_updateWheelUI()
	self:_updateWheelTip()
	self:_setRole()
end

function BeastRichManLotteryView:_updateWheelUI()
	if self._showRewardCfgs then
		for i, rewardGo in ipairs(self._rewardGoTable) do
			local icon = goutil.findChild(rewardGo, "icon")
			local hasGain = goutil.findChild(rewardGo, "hasGain")
			local txtNum = goutil.findChildTextComponent(rewardGo, "num/txtNum")
			local matStr = ""
			local rewardCfg = self._showRewardCfgs[i]

			if rewardCfg then
				local isCard = rewardCfg.cardId > 0
				local isScore = rewardCfg.score > 0

				if isCard then
					local cardId = rewardCfg.cardId
					local cardCfg = BeastRichmanConfig.instance:getCardCfg(self._activityId, cardId)

					matStr = cardCfg.matStr
				else
					matStr = isScore and rewardCfg.fakePrize or rewardCfg.prize
				end

				local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
				local curRound = BeastRichmanController.instance:getWheelCurRound(self._activityId, self._zoneId, self._eventId, self._selectPoolId)
				local hasGained = false

				if curRound > self._selectRound then
					hasGained = true
				elseif self._selectRound == curRound then
					hasGained = table.indexof(self._curWheelInfoList, rewardCfg.prizeId)
				end

				if self._selectRound > 0 then
					curRound = self._selectRound
				end

				txtNum.text = matNum

				MaterialMgr.setIcon(icon, matType, matId, nil, nil)
				GameUtil.addClickHandler(icon, function()
					TipsFacade.instance:openItemSourceView(matStr)
				end, self)
				GameUtil.SetGray(icon, hasGained)
				GameUtil.SetActive(hasGain, hasGained)
			end
		end
	end
end

function BeastRichManLotteryView:_updateWheelTip()
	local lotteryCfgs = BeastRichmanConfig.instance:getLotteryCfgsById(self._activityId, self._selectPoolId)
	local curRound = BeastRichmanController.instance:getWheelCurRound(self._activityId, self._zoneId, self._eventId, self._selectPoolId)

	if self._selectRound > 0 then
		curRound = self._selectRound
	end

	local isFinalRound = curRound == #lotteryCfgs

	self._txtTip.text = isFinalRound and "循环" or string.format("当前第<color=#F67674>%s</color>/%s层", curRound, #lotteryCfgs)
end

function BeastRichManLotteryView:_updateTabCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local complete = goutil.findChild(cell, "complete")
	local imgChoose = goutil.findChild(cell, "imgChoose")
	local hasComplete = BeastRichmanController.instance:getWheelHasFinish(self._activityId, self._zoneId, self._curShowGridId, data.wheelPoolId)

	txtName.text = data.wheelPoolId

	GameUtil.SetActive(imgChoose, data.wheelPoolId == self._selectPoolId)
	GameUtil.SetActive(complete, hasComplete)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickTabCell, self, data.wheelPoolId))
end

function BeastRichManLotteryView:_onClickTabCell(id)
	self._selectPoolId = id
	self._selectRound = 0

	self:_onUpdate()
end

function BeastRichManLotteryView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function BeastRichManLotteryView:_onClickBtnGetPrize()
	local isComplete = BeastRichmanController.instance:getWheelCurPoolHasComplete(self._activityId, self._zoneId, self._curShowGridId, self._selectPoolId)
	local curMatNum = MaterialModel.instance:getMaterialsNumber(self._matType, self._matId)

	if not self._isCurGrid then
		FloatWordMgr.instance:show("尚未触发当前事件，无法抽取")

		return
	end

	if isComplete then
		FloatWordMgr.instance:show("奖池已完成，无法再次抽取")

		return
	end

	if (self._eventInfo or nil) and self._eventInfo.finish and self._isCurGrid then
		FloatWordMgr.instance:show("已完成事件，无需重复完成")

		return
	end

	local curRound = BeastRichmanController.instance:getWheelCurRound(self._activityId, self._zoneId, self._eventId, self._selectPoolId)

	if self._selectRound ~= 0 and curRound < self._selectRound then
		FloatWordMgr.instance:show("先抽完前面的奖励，才能解锁本层奖励哦！")

		return
	elseif self._selectRound ~= 0 and curRound > self._selectRound and curRound ~= 1 then
		FloatWordMgr.instance:show("本层奖励已全部解锁，无法重复抽取")

		return
	end

	local param = ""

	BeastRichmanController.instance:sendPM_BeastRichManHandleEventReq(self._activityId, self._zoneId, self._gridId, param)
end

function BeastRichManLotteryView:_onClickBtnLeftArrow()
	local curRound = BeastRichmanController.instance:getWheelCurRound(self._activityId, self._zoneId, self._eventId, self._selectPoolId)

	if self._selectRound > 0 then
		self._selectRound = self._selectRound or curRound
	end

	if self._selectRound > 1 then
		self._selectRound = self._selectRound - 1 or self._selectRound
	end

	self._curSelectIndex = 1

	self:_onUpdate()
end

function BeastRichManLotteryView:_onClickBtnRightArrow()
	local curRound = BeastRichmanController.instance:getWheelCurRound(self._activityId, self._zoneId, self._eventId, self._selectPoolId)
	local wheelCfgs = BeastRichmanConfig.instance:getLotteryCfgsById(self._activityId, self._selectPoolId)
	local wheelNum = #wheelCfgs

	if self._selectRound > 0 then
		self._selectRound = self._selectRound or curRound
	end

	self._selectRound = math.min(self._selectRound + 1, wheelNum)
	self._curSelectIndex = 1

	self:_onUpdate()
end

function BeastRichManLotteryView:_onClickBtnToggle()
	self._isSkipAnim = not self._isSkipAnim

	local key = string.format("BeastRichManLotteryView_%s", self._activityId)

	GameUtil.saveUserData(key, self._isSkipAnim)
	GameUtil.SetActive(self._imgGouXuan, self._isSkipAnim)
end

function BeastRichManLotteryView:_playSelectAnim(resultParam)
	local preIndex = self._curSelectIndex

	self._curSelectIndex = checknumber(resultParam)

	if self._isSkipAnim then
		self:_showGetPrize()
		self:_onUpdate()

		return
	end

	local x, y, z = GameUtil.getLocalRotation(self._imgSelect)
	local finalAngle = z - 45 * (8 - (preIndex - 1)) - 1440 - 45 * (self._curSelectIndex - 1)

	self._imgSelect.transform:DORotate(Vector3.New(0, 0, finalAngle), self._rotateDuration, DG.Tweening.RotateMode.FastBeyond360):SetEase(DG.Tweening.Ease.InOutQuad):OnUpdate(function()
		local x, y, z = GameUtil.getLocalRotation(self._imgSelect)
		local curIndex = math.ceil((z + 270) / -45)
		local calIndex = (z + 270) / -45

		if curIndex - calIndex <= 0.3 then
			GameUtil.SetActive(self._imgChooseList[curIndex % 8 + 1], true)

			if curIndex % 8 ~= 0 then
				if not (curIndex % 8) then
					local lastIndex = 8

					GameUtil.SetActive(self._imgChooseList[lastIndex], false)
				end
			end
		end
	end)
	self._rewardArrow.transform:DORotate(Vector3.New(0, 0, -1440 - 45 * (self._curSelectIndex - 1)), self._rotateDuration, DG.Tweening.RotateMode.FastBeyond360):SetEase(DG.Tweening.Ease.InOutQuad):OnStart(function()
		ViewBlockMgr.instance:blockClick(true, self)
	end):OnComplete(function()
		self:_showGetPrize()
		self:_onUpdate()
		ViewBlockMgr.instance:blockClick(false, self)
	end)
end

function BeastRichManLotteryView:_onEventRes(resultParam)
	self:_playSelectAnim(resultParam)
end

function BeastRichManLotteryView:_showGetPrize()
	local curPrizeId = self._curSelectIndex
	local curRound = BeastRichmanController.instance:getWheelCurRound(self._activityId, self._zoneId, self._eventId, self._selectPoolId)

	if self._selectRound > 0 then
		self._selectRound = self._selectRound or curRound
	end

	local prizeCfg = BeastRichmanConfig.instance:getLotteryPrizeCfgsByPrizeId(self._activityId, self._selectPoolId, self._selectRound, curPrizeId)
	local changeSetId = BeastRichmanController.instance:getCurChangeSetId()

	if prizeCfg.cardId > 0 then
		local cardId = prizeCfg.cardId
		local cardCfg = BeastRichmanConfig.instance:getCardCfg(self._activityId, cardId)

		if cardCfg then
			if not cardCfg.matStr then
				local matStr = ""

				if not string.nilorempty(matStr) then
					local type, id, num = MaterialMgr.getMatParams(matStr)
					local list = {}

					if type == MatType.Item_Fake then
						local mo = MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, id, num)

						table.insert(list, mo)
					end

					local obj = {}

					obj.items = list
					obj.ci = 0

					MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
					MaterialController.instance:checkAndOpenDisplay()
				end
			end
		end
	elseif prizeCfg.score > 0 then
		BeastRichmanController.instance:tryPopCurScore(self._activityId)
	else
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function BeastRichManLotteryView:_getGridIdByWheelId(wheelId)
	for i, tb in ipairs(self._poolLotteryList) do
		if tb.wheelPoolId == wheelId then
			return tb.gridId
		end
	end
end

return BeastRichManLotteryView
