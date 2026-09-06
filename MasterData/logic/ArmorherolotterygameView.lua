-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorherolottery/view/ArmorherolotterygameView.lua

module("logic.extensions.armorherolottery.view.ArmorherolotterygameView", package.seeall)

local ArmorherolotterygameView = class("ArmorherolotterygameView", ViewComponent)

ArmorherolotterygameView.Key_Speed = "ArmorherolotterygameView.Key_Speed"
ArmorherolotterygameView.ItemCellAniType = {
	Clean = 4,
	Dispatch = 2,
	Open = 3,
	CleanFinish = 5,
	Normal = 1
}

function ArmorherolotterygameView:ctor()
	ArmorherolotterygameView.super.ctor(self)
end

function ArmorherolotterygameView:unbindEvents()
	ArmorherolotterygameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	self._btnSpeed:RemoveClickListener()
	self._btnOnekey:RemoveClickListener()
	self._btnAuto:RemoveClickListener()
	self._btnFire:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function ArmorherolotterygameView:bindEvents()
	ArmorherolotterygameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	self._btnSpeed:AddClickListener(self._onClickbtnSpeed, self)
	self._btnOnekey:AddClickListener(self._onClickbtnOnekey, self)
	self._btnAuto:AddClickListener(self._onClickbtnAuto, self)
	self._btnFire:AddClickListener(self._onClickbtnFire, self)
	self._btnTask:AddClickListener(self._onClickbtnTask, self)
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
end

function ArmorherolotterygameView:buildUI()
	ArmorherolotterygameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnSpeed = self:getBtn("btnSpeed")
	self._btnOnekey = self:getBtn("btnOnekey")
	self._btnAuto = self:getBtn("btnAuto")
	self._btnFire = self:getBtn("btnFire")
	self._btnTask = self:getBtn("btnTask")
	self._btnBuy = self:getBtn("btnBuy")
	self._txtNum = self:getTxt("txtNum")
	self._txtNextDesc = self:getTxt("txtNextDesc")
	self._timecellGo = self:getGo("timecell")
	self._timeconGo = self:getGo("timecon")
	self._timeCellLayout = self:getGo("timecon"):GetComponent(ComponentType.UILayoutSingleLine)

	self:_buildItemCells()

	self._txtBtnAuto = self:getTxt("btnAuto/txt")
	self._txtBtnSpeed = self:getTxt("btnSpeed/txt")
	self._txtScore = self:getTxt("txtScore")
	self._dispatchMoveGo = self:getGo("dispatchMoveGo")
end

function ArmorherolotterygameView:_buildTimeCells()
	goutil.setActive(self._timecellGo, false)

	local ruleCfgs = ArmorherolotteryConfig.instance:getRuleCfgs(self._activityId)

	self._timeCellGos = self._timeCellGos or {}

	for i = #ruleCfgs + 1, #self._timeCellGos do
		goutil.setActive(self._timeCellGos[i], false)
	end

	for i = 1, #ruleCfgs do
		if not self._timeCellGos[i] then
			local newTimeCell = goutil.cloneAndSetParent(self._timecellGo, self._timeconGo.transform)

			goutil.setActive(newTimeCell, true)
			table.insert(self._timeCellGos, newTimeCell)
		else
			goutil.setActive(self._timeCellGos[i], true)
		end
	end

	self._timeCellLayout:Layout()
end

function ArmorherolotterygameView:_buildItemCells()
	self._cellconGo = self:getGo("cellcon")
	self._cellGo = self:getGo("cell")
	self._itemCellGos = {}

	goutil.setActive(self._cellGo, true)

	for i = 1, 9 do
		local go = goutil.cloneAndSetParent(self._cellGo, self._cellconGo.transform)

		table.insert(self._itemCellGos, go)
	end

	goutil.setActive(self._cellGo, false)
end

function ArmorherolotterygameView:onExit()
	ArmorherolotterygameView.super.onExit(self)

	for i, v in ipairs(self._itemCellGos) do
		self:_clearItemCell(v)
	end

	removetimer(self._onTickPlayOpenAni, self)
	removetimer(self._onTickPlayDispatchAni, self)
	removetimer(self._onPlayCleanFinishAni, self)

	if self._cleanEffects then
		for k, v in pairs(self._cleanEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._cleanEffects = {}
	end

	if self._curDispatchEff then
		UIEffectManager.instance:stopEffect(self._curDispatchEff)

		self._curDispatchEff = nil
	end

	if self._tweenDispatch then
		self._tweenDispatch:Kill()

		self._tweenDispatch = nil
	end
end

function ArmorherolotterygameView:onEnter()
	ArmorherolotterygameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ArmorHeroLotteryDrawRes, self._onArmorHeroLotteryDrawRes, self)

	self._activityId = self:getFirstParam()
	self._speed = GameUtil.getUserData(ArmorherolotterygameView.Key_Speed) or 1
	self._txtBtnSpeed.text = self._speed .. "倍速"
	self._tickDuration = 0.2
	self._isPlayAni = false
	self._needChangeSpeedCnt = 0
	self._isPlayDispatchAni = false
	self._isPlayOpenAni = false
	self._isPlayCleanAni = false
	self._needSettlementAutoFire = false
	self._txtBtnAuto.text = "自动派发"
	self._isOneKeyFire = false
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_buildTimeCells()
	self:_updateUI()
end

function ArmorherolotterygameView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("armor_hero_lottery_rule")
end

function ArmorherolotterygameView:_onClickbtnSpeed()
	self._speed = self._speed + 1
	self._speed = self._speed % 2

	if self._speed == 0 then
		self._speed = 2
	end

	GameUtil.saveUserData(ArmorherolotterygameView.Key_Speed, self._speed)

	self._txtBtnSpeed.text = self._speed .. "倍速"
	self._changeDispatchSpeed = true
	self._changeOpenSpeed = true
end

function ArmorherolotterygameView:_onClickbtnOnekey()
	if self._isAutoFire then
		return
	end

	if self._isPlayAni then
		return
	end

	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)
	local hasNum = MaterialMgr.getMatCount(actCfg.cost)

	if hasNum <= 0 then
		FloatWordMgr.instance:show("盲盒数量不足1个")

		return
	end

	self._isOneKeyFire = true

	local needNum = math.min(200, hasNum)

	self:_initFireRecordData()
	ArmorHeroLotteryAgent.instance:sendPM_ArmorHeroLotteryDrawReq(self._activityId, needNum)
end

function ArmorherolotterygameView:_onClickbtnAuto()
	if self._needSettlementAutoFire then
		FloatWordMgr.instance:show("等待结算中")

		return
	end

	if self._isAutoFire then
		self._txtBtnAuto.text = "自动派发"
		self._needSettlementAutoFire = true

		if not self._isInAutoFireNotRes then
			if self._isPlayAni then
				FloatWordMgr.instance:show("派发动画结束后结算")
			else
				self:_onHandleAutoFireSettlement()
			end
		end

		return
	end

	if self._isPlayAni then
		return
	end

	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)
	local hasNum = MaterialMgr.getMatCount(actCfg.cost)

	if hasNum <= 0 then
		FloatWordMgr.instance:show("盲盒数量不足1个")

		return
	end

	self._txtBtnAuto.text = "派发中"

	self:_initFireRecordData()

	self._isAutoFire = true

	self:_startAutoFill()
end

function ArmorherolotterygameView:_initFireRecordData()
	self._autoFireRecord = {
		time = 0,
		ruleIdAndNum = {}
	}
end

function ArmorherolotterygameView:_onClickbtnFire()
	if self._isAutoFire then
		return
	end

	if self._isPlayAni then
		return
	end

	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)
	local hasNum = MaterialMgr.getMatCount(actCfg.cost)

	if hasNum <= 0 then
		FloatWordMgr.instance:show("盲盒数量不足1个")

		return
	end

	local needNum = 0

	if #self._info.itemIds <= 0 then
		needNum = 9
	else
		for i, v in ipairs(self._info.itemIds) do
			if v == 0 then
				needNum = needNum + 1
			end
		end
	end

	needNum = math.min(needNum, hasNum)

	ArmorHeroLotteryAgent.instance:sendPM_ArmorHeroLotteryDrawReq(self._activityId, needNum)
end

function ArmorherolotterygameView:_onClickbtnTask()
	if self._isAutoFire then
		self:_onClickbtnAuto()

		return
	end

	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)

	GotoMgr.gotoByString(actCfg.taskJump)
end

function ArmorherolotterygameView:_onClickbtnBuy()
	if self._isAutoFire then
		self:_onClickbtnAuto()

		return
	end

	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)

	GotoMgr.gotoByString(actCfg.shopJump)
end

function ArmorherolotterygameView:_updateUI()
	self._info = ArmorherolotteryModel.instance:getInfo(self._activityId)

	self:_udpateItems()
	self:_updateNum()
	self:_updateTimeCells()
	self:_updateNextRewardTip()
end

function ArmorherolotterygameView:_updateNum()
	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)
	local hasNum = MaterialMgr.getMatCount(actCfg.cost)

	self._txtNum.text = string.format("剩余盲盒：%s", hasNum)
end

function ArmorherolotterygameView:_updateTimeCells()
	self:_initRuleTimes()

	local ruleCfgs = ArmorherolotteryConfig.instance:getRuleCfgs(self._activityId)

	for i, v in ipairs(ruleCfgs) do
		self:_updateOneTimeCell(i)
	end
end

function ArmorherolotterygameView:_initRuleTimes()
	self._ruleTimes = {}

	for i, v in ipairs(self._info.historyRuleIdAndNum) do
		self._ruleTimes[v.left] = v.right
	end
end

function ArmorherolotterygameView:_getRuleTime(ruleId)
	return self._ruleTimes[ruleId] or 0
end

function ArmorherolotterygameView:_updateOneTimeCell(ruleId)
	local go = self._timeCellGos[ruleId]
	local ruleCfg = ArmorherolotteryConfig.instance:getRuleCfg(self._activityId, ruleId)
	local txtDesc = goutil.findChildTextComponent(go, "txt")
	local time = self:_getRuleTime(ruleId)

	txtDesc.text = string.format("%s次数 %s", ruleCfg.name, time)
end

function ArmorherolotterygameView:_udpateItems()
	local itemIds = self._info.itemIds

	for i, go in ipairs(self._itemCellGos) do
		if not itemIds[i] then
			self:_udpateOneItem(i, itemIds[i], ArmorherolotterygameView.ItemCellAniType.Normal)
		end
	end
end

function ArmorherolotterygameView:_udpateOneItem(idx, itemId, itemCellAniType)
	local go = self._itemCellGos[idx]
	local goIcon = goutil.findChild(go, "icon")
	local goMask = goutil.findChild(go, "mask")

	itemId = checknumber(itemId)

	local needMask = itemCellAniType == ArmorherolotterygameView.ItemCellAniType.Dispatch
	local isClean = itemCellAniType == ArmorherolotterygameView.ItemCellAniType.Clean
	local isOpen = itemCellAniType == ArmorherolotterygameView.ItemCellAniType.Open
	local isCleanFinish = itemCellAniType == ArmorherolotterygameView.ItemCellAniType.CleanFinish
	local isNormal = itemCellAniType == ArmorherolotterygameView.ItemCellAniType.Normal
	local hasItem = itemId > 0
	local x = (idx - 1) % 3 + 1
	local y = math.ceil(idx / 3)

	Framework.TransformUtil.SetAnchoredPos(go.transform, (x - 1) * 200, -(y - 1) * 173)
	goutil.setActive(goMask, needMask)

	if hasItem then
		local itemCfg = ArmorherolotteryConfig.instance:getItemCfg(self._activityId, itemId)

		uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, string.format("%s.png", itemCfg.icon))
	end

	if needMask then
		-- block empty
	elseif isOpen then
		goutil.setActive(goIcon, true)
	elseif isClean then
		self:_playCleanEffect(go)
	elseif isCleanFinish then
		goutil.setActive(goIcon, false)
	elseif isNormal then
		goutil.setActive(goIcon, hasItem)
	end
end

function ArmorherolotterygameView:_clearItemCell(go)
	local goIcon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(goIcon)
end

function ArmorherolotterygameView:_onArmorHeroLotteryDrawRes(status, msg)
	self._isInAutoFireNotRes = false

	if status ~= 0 then
		if self._isAutoFire or self._isOneKeyFire then
			self._needSettlementAutoFire = true

			self:_onHandleAutoFireSettlement()
		end

		return
	elseif self._isAutoFire or self._isOneKeyFire then
		self._autoFireRecord.time = self._autoFireRecord.time + msg.num

		for _, vn in ipairs(msg.ruleIdAndNum or {}) do
			local isHit = false

			for _, vo in ipairs(self._autoFireRecord.ruleIdAndNum) do
				if vo.left == vn.left then
					vo.right = vo.right + vn.right
					isHit = true

					break
				end
			end

			if not isHit then
				table.insert(self._autoFireRecord.ruleIdAndNum, {
					left = vn.left,
					right = vn.right
				})
			end
		end
	end

	if self._isOneKeyFire then
		self._needSettlementAutoFire = true

		self:_onHandleAutoFireSettlement()
		self:_updateUI()

		return
	end

	self:_updateNum()

	self._isPlayAni = true

	if not msg.rounds then
		self._rounds = msg.rounds
		self._roundCnt = #msg.rounds
		self._curRoundIdx = 0

		self:_onHandleNextRound()
		self:_onPlayDispatchAni()
	end
end

function ArmorherolotterygameView:_onHandleNextRound()
	if self._curRoundIdx >= self._roundCnt then
		self:_onFinishAllAni()
	else
		self._curRoundIdx = self._curRoundIdx + 1

		self:_onPlayDispatchAni()
	end
end

function ArmorherolotterygameView:_onPlayDispatchAni()
	local round = self._rounds[self._curRoundIdx]

	self._roundDispatchCnt = #(round.posAndItemIds or {})
	self._posAndItemIds = round.posAndItemIds
	self._curDispatchIdx = 0

	if self._curDispatchIdx >= self._roundDispatchCnt then
		removetimer(self._onTickPlayDispatchAni, self)
		self:_onPlayOpenAni()
	else
		self:_startTickDispatchAni()
	end
end

function ArmorherolotterygameView:_startTickDispatchAni()
	self._isPlayDispatchAni = true

	removetimer(self._onTickPlayDispatchAni, self)
	self:_onTickPlayDispatchAni()
end

function ArmorherolotterygameView:_onTickPlayDispatchAni()
	if self._changeDispatchSpeed then
		self._changeDispatchSpeed = false

		self:_startTickDispatchAni()

		return
	end

	if self._curDispatchIdx >= self._roundDispatchCnt then
		self._isPlayDispatchAni = false

		removetimer(self._onTickPlayDispatchAni, self)
		self:_onPlayOpenAni()
	else
		self._curDispatchIdx = self._curDispatchIdx + 1

		local pair = self._posAndItemIds[self._curDispatchIdx]
		local idx = pair.left
		local itemId = pair.right

		self._cacheDispatchData = {
			idx = idx,
			itemId = itemId
		}

		self:_playDIspatchEffect(self._btnFire.gameObject, self._itemCellGos[idx])
	end
end

function ArmorherolotterygameView:_onPlayOpenAni()
	self._curOpenIdx = 0

	if self._curOpenIdx >= self._roundDispatchCnt then
		removetimer(self._onTickPlayOpenAni, self)
		self:_onHandleNextRound()
	else
		self:_startTickOpenAni()
	end
end

function ArmorherolotterygameView:_startTickOpenAni()
	self._isPlayOpenAni = true

	removetimer(self._onTickPlayOpenAni, self)
	settimer(self._tickDuration / self._speed, self._onTickPlayOpenAni, self, true)
	self:_onTickPlayOpenAni()
end

function ArmorherolotterygameView:_onTickPlayOpenAni()
	if self._changeOpenSpeed then
		self._changeOpenSpeed = false

		self:_startTickOpenAni()

		return
	end

	if self._curOpenIdx >= self._roundDispatchCnt then
		self._isPlayOpenAni = false

		removetimer(self._onTickPlayOpenAni, self)
		self:_calBoxCleanRule()
	else
		self._curOpenIdx = self._curOpenIdx + 1

		local pair = self._posAndItemIds[self._curOpenIdx]
		local idx = pair.left
		local itemId = pair.right

		self:_udpateOneItem(idx, itemId, ArmorherolotterygameView.ItemCellAniType.Open)
	end
end

function ArmorherolotterygameView:_calBoxCleanRule()
	local round = self._rounds[self._curRoundIdx]

	self._cleanRuleCnt = not round.rules and 0 or #round.rules
	self._cleanRules = round.rules

	self:_onPlayCleanAni()
end

function ArmorherolotterygameView:_onPlayCleanAni()
	self._curCleanRuleIdx = 0

	if self._curCleanRuleIdx >= self._cleanRuleCnt then
		removetimer(self._onTickPlayCleanAni, self)
		self:_onHandleNextRound()
	else
		self:_startTickCleanAni()
	end
end

function ArmorherolotterygameView:_startTickCleanAni()
	self._isPlayCleanAni = true

	if self._curCleanRuleIdx >= self._cleanRuleCnt then
		self._isPlayCleanAni = false

		self:_onHandleNextRound()
	else
		self._curCleanRuleIdx = self._curCleanRuleIdx + 1

		local rule = self._cleanRules[self._curCleanRuleIdx]
		local costPosIds = rule.costPosIds

		for i, v in ipairs(costPosIds) do
			self:_udpateOneItem(v, 0, ArmorherolotterygameView.ItemCellAniType.Clean)
		end

		settimer(self._tickDuration / self._speed, self._onPlayCleanFinishAni, self, false)
	end
end

function ArmorherolotterygameView:_onPlayCleanFinishAni()
	local rule = self._cleanRules[self._curCleanRuleIdx]
	local costPosIds = rule.costPosIds

	for i, v in ipairs(costPosIds) do
		self:_udpateOneItem(v, 0, ArmorherolotterygameView.ItemCellAniType.CleanFinish)
	end

	self:_addRuleTime(rule.ruleId)
	self:_updateOneTimeCell(rule.ruleId)
	self:_updateNextRewardTip()
	self:_startTickCleanAni()
end

function ArmorherolotterygameView:_updateNextRewardTip()
	local ruleCfgs = ArmorherolotteryConfig.instance:getRuleCfgs(self._activityId)
	local prizeCfgs = ArmorherolotteryConfig.instance:getPrizeCfgs(self._activityId)
	local score = 0

	for i, v in ipairs(ruleCfgs) do
		local time = self:_getRuleTime(v.ruleId)

		score = score + time * v.score
	end

	local nextPrizeCfg

	for i, v in ipairs(prizeCfgs) do
		if score < v.needScore then
			nextPrizeCfg = v

			break
		end
	end

	self._txtScore.text = string.format("累计积分：%s", score)
	self._txtNextDesc.text = not nextPrizeCfg and "当前积分可获得\n所有奖励" or string.format("还差%s积分可获得\n[%s]", nextPrizeCfg.needScore - score, nextPrizeCfg.rewardName)
end

function ArmorherolotterygameView:_addRuleTime(ruleId)
	self._ruleTimes[ruleId] = (self._ruleTimes[ruleId] or 0) + 1
end

function ArmorherolotterygameView:_onFinishAllAni()
	self._isPlayAni = false
	self._isPlayDispatchAni = false
	self._isPlayOpenAni = false
	self._isPlayCleanAni = false

	self:_updateUI()

	if self._isAutoFire then
		if self._needSettlementAutoFire then
			self:_onHandleAutoFireSettlement()
		else
			self:_startAutoFill()
		end
	end
end

function ArmorherolotterygameView:_startAutoFill()
	local actCfg = ArmorherolotteryConfig.instance:getActCfg(self._activityId)
	local hasNum = MaterialMgr.getMatCount(actCfg.cost)

	if hasNum <= 0 then
		FloatWordMgr.instance:show("自动派发盲盒结束")

		self._needSettlementAutoFire = true

		self:_onHandleAutoFireSettlement()

		return
	end

	local needNum = 0

	if #self._info.itemIds <= 0 then
		needNum = 9
	else
		for i, v in ipairs(self._info.itemIds) do
			if v == 0 then
				needNum = needNum + 1
			end
		end
	end

	needNum = math.min(needNum, hasNum)
	self._isInAutoFireNotRes = true

	ArmorHeroLotteryAgent.instance:sendPM_ArmorHeroLotteryDrawReq(self._activityId, needNum)
end

function ArmorherolotterygameView:_onHandleAutoFireSettlement()
	if self._needSettlementAutoFire then
		self._needSettlementAutoFire = false

		if self._autoFireRecord and self._autoFireRecord.time > 0 then
			UIStateManager.instance:push(ViewName.ArmorherolotteryresultView, self._activityId, self._autoFireRecord.time, self._autoFireRecord.ruleIdAndNum)
		end

		self._autoFireRecord = nil
	end

	self._isAutoFire = false
	self._isOneKeyFire = false
end

function ArmorherolotterygameView:_playCleanEffect(go)
	self._cleanEffects = self._cleanEffects or {}

	local eff = self._cleanEffects[go]

	if eff then
		UIEffectManager.instance:stopEffect(eff)
	end

	local effName = "20250926/baoweiluobo/fx_ui_chuxian.prefab"

	eff = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	eff:setParent(go.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._cleanEffects[go] = eff
end

function ArmorherolotterygameView:_playDIspatchEffect(fromGo, toGo)
	local moveGo = self._dispatchMoveGo
	local effName = "fx_ui_xinshouzhiyin/fx_xinshouzhiyin_003/fx_feiru_xingxing.prefab"

	if self._curDispatchEff then
		UIEffectManager.instance:stopEffect(self._curDispatchEff)

		self._curDispatchEff = nil
	end

	self._curDispatchEff = UIEffectManager.instance:playEffect(self, effName, moveGo, 0, 0, true)

	self._curDispatchEff:setParent(moveGo.transform)
	self._curDispatchEff:setLocalPos(0, 0, 0)

	local fx, fy, fz = Framework.TransformUtil.GetPos(fromGo.transform, 0, 0, 0)
	local mx, my, mz = Framework.TransformUtil.GetPos(moveGo.transform, 0, 0, 0)
	local tx, ty, tz = Framework.TransformUtil.GetPos(toGo.transform, 0, 0, 0)

	Framework.TransformUtil.SetPos(moveGo.transform, fx, fy, mz)

	if self._tweenDispatch then
		self._tweenDispatch:Kill(false)

		self._tweenDispatch = nil
	end

	self._tweenDispatch = TweenUtil.ValueTo(0, 1, self._tickDuration / self._speed, function(val)
		fx = fx + (tx - fx) * val
		fy = fy + (ty - fy) * val

		Framework.TransformUtil.SetPos(moveGo.transform, fx, fy, mz)
	end, self._clearAction, self)
end

function ArmorherolotterygameView:_clearAction()
	if self._curDispatchEff then
		UIEffectManager.instance:stopEffect(self._curDispatchEff)

		self._curDispatchEff = nil
	end

	if self._cacheDispatchData then
		self:_udpateOneItem(self._cacheDispatchData.idx, self._cacheDispatchData.itemId, ArmorherolotterygameView.ItemCellAniType.Dispatch)
	end

	self._cacheDispatchData = nil

	self:_onTickPlayDispatchAni()
end

function ArmorherolotterygameView:_onClickBtnClose()
	if self._isAutoFire then
		self:_onClickbtnAuto()

		return
	end

	self:close()
end

return ArmorherolotterygameView
