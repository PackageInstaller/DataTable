-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/athenabless/view/AthenaBlessView.lua

module("logic.extensions.athenabless.view.AthenaBlessView", package.seeall)

local AthenaBlessView = class("AthenaBlessView", TableViewComponent)
local SliderAnim = "athenablessslideranim"

function AthenaBlessView:ctor()
	self._unitPageWidth = 990
	self._prePageWidth = 50
	self._postPageWidth = 50
	self._pageNum = 2
end

function AthenaBlessView:buildUI()
	AthenaBlessView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnDetail = self:getBtn("roleArea/bg2")
	self._roleGo = self:getGo("roleArea/role")
	self._specialIcon = self:getGo("roleArea/special/icon")
	self._txtSpecialDesc = self:getTxt("roleArea/special/txtDesc")
	self._txtName = self:getTxt("roleArea/bg2/txtName")
	self._txtDesc = self:getTxt("roleArea/bg2/txtDesc")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtLevel = self:getTxt("sliderArea/txtLevel")
	self._txtSliderDesc = self:getTxt("sliderArea/txtSliderDesc")
	self._slider = self:getSlider("sliderArea/ScrollRect/ViewPort/Content/progressBar")
	self._progressBarRect = self:getGo("sliderArea/ScrollRect/ViewPort/Content/progressBar"):GetComponent(goutil.Type_RectTransform)
	self._sliderStartPos = self._progressBarRect.anchoredPosition.x
	self._sliderWidth = self._progressBarRect.rect.width
	self._levelCell = self:getGo("sliderArea/levelCell")
	self._rewardCell = self:getGo("sliderArea/rewardCell")

	goutil.setActive(self._levelCell, false)
	goutil.setActive(self._rewardCell, false)

	self._content = self:getGo("sliderArea/ScrollRect/ViewPort/Content")
	self._contentRectTrans = self._content:GetComponent(goutil.Type_RectTransform)
	self._scrollRectTransform = self:getGo("sliderArea/ScrollRect"):GetComponent(goutil.Type_RectTransform)
	self._scrollRect = self:getGo("sliderArea/ScrollRect"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._effectGo = self:getGo("roleArea/bg2/effect")
	self._txtTitle = self:getTxt("title")
	self._txtWeekScore = self:getTxt("weekscore/txtScore")
	self._sliderMask = self:getGo("sliderArea/ScrollRect/sliderMask")
end

function AthenaBlessView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "scrollrect"
	}
end

function AthenaBlessView:bindEvents()
	AthenaBlessView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
end

function AthenaBlessView:unbindEvents()
	AthenaBlessView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
end

function AthenaBlessView:onEnter()
	AthenaBlessView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.AthenaBlessGetInfo, self._onGetInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.AthenaBlessGainPrize, self._onGainPrize, self)

	self._isFirst = true

	self:_initSliderAnimInfo()
	self:_initContentPageInfo()
	self:_loadRole()
	self:_loadCircleEffect()
	self:_setTxtDesc()
	self:_setSpecialItem()

	local cfgActivityDefine = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.AthenaBless)

	if cfgActivityDefine then
		AthenaBlessController.instance:markRedPoint(cfgActivityDefine.activityId)
		AthenaBlessAgent.instance:sendPM_AnthenaBlessGetInfoReq(cfgActivityDefine.activityId)
	else
		self:_showCloseTip()

		return
	end

	self._cfgBlessActivity = AthenaBlessConfig.instance:getActivityCfg(cfgActivityDefine.activityId)

	if not self._cfgBlessActivity then
		printError("test 配置不存在")

		return
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.AthenaBless, cfgActivityDefine.activityId)

	self._endTimestamp = endTime

	self:_onSecond()
	settimer(1, self._onSecond, self)
end

function AthenaBlessView:onExit()
	AthenaBlessView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AthenaBlessGetInfo, self._onGetInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.AthenaBlessGainPrize, self._onGainPrize, self)
	removetimer(self._onSecond, self)
	self:_removeRole()
	self:_clearLevelCell()
	self:_clearRewardCells()
	self:_removeCircleEffect()
	self:_removeSpecialItem()
	self:_removeTween()
end

function AthenaBlessView:_onClickClose()
	self:close()
end

function AthenaBlessView:_onClickDetail()
	local title = lang("tip")
	local text = AthenaBlessConfig.instance:getConstValue("athena_desc2")
	local btnText = lang("tip_know")

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function AthenaBlessView:_onGetInfo()
	self:_refreshView()
end

function AthenaBlessView:_onGainPrize(isSuccess)
	if isSuccess then
		printInfo("test 领取奖励成功")
		self:_refreshView()
	end
end

function AthenaBlessView:_onSecond()
	self:_updateCountdown()
end

function AthenaBlessView:_updateCountdown()
	if self._endTimestamp and self._endTimestamp > 0 then
		local leftTime = self._endTimestamp - ServerTime.now()

		leftTime = leftTime >= 0 and leftTime or 0
		self._txtTime.text = string.format("剩余：%s", GameUtil.FormatTimeSymbol(leftTime))
	end
end

function AthenaBlessView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtScore2 = goutil.findChildTextComponent(cell, "txtScore/txtScore2")
	local btnTip = Framework.ButtonAdapter.GetFrom(cell.gameObject, "txtName/btnTip")
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")

	local function funcTip()
		local title = lang("tip")
		local text = data.cfg.desc
		local btnText = lang("tip_know")

		TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
	end

	local function funcGo()
		GotoMgr.gotoByString(data.cfg.funcId)
	end

	btnTip:AddClickListener(funcTip)
	btnGo:AddClickListener(funcGo)

	txtName.text = data.cfg.name

	local isRankRace = data.cfg.jump == 69

	if isRankRace then
		goutil.setActive(txtScore2.gameObject, true)

		txtScore.text = string.format("参与次数：%d/%d", AthenaBlessModel.instance:getTriggerTimes(data.cfg.taskId), data.cfg.timesDailyLimit)
		txtScore2.text = string.format("今日积分：%d/%d", data.curScore, data.maxScore)
	else
		local scoreTxt = string.format("%d/%d", data.curScore, data.maxScore)

		txtScore.text = "今日积分：" .. scoreTxt

		goutil.setActive(txtScore2.gameObject, false)
	end
end

function AthenaBlessView:_clearTableview(cell)
	local btnTip = Framework.ButtonAdapter.GetFrom(cell.gameObject, "txtName/btnTip")
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")

	btnTip:RemoveClickListener()
	btnGo:RemoveClickListener()
end

function AthenaBlessView:_loadRole()
	local curFaceId = checknumber(AthenaBlessConfig.instance:getConstValue("athena_desc5"))
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_removeRole()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._roleGo, scale, nil, true, x, y)
end

function AthenaBlessView:_removeRole()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function AthenaBlessView:_setTxtDesc()
	self._txtName.text = AthenaBlessConfig.instance:getConstValue("athena_buffname")
	self._txtDesc.text = AthenaBlessConfig.instance:getConstValue("athena_desc1")
	self._txtTitle.text = AthenaBlessConfig.instance:getConstValue("athena_title")
	self._txtSpecialDesc.text = AthenaBlessConfig.instance:getConstValue("athena_awardtxt")
end

function AthenaBlessView:_setSpecialItem()
	local str = AthenaBlessConfig.instance:getConstValue("athena_award")

	MaterialMgr.setCellByCfg(str, self._specialIcon)
end

function AthenaBlessView:_removeSpecialItem()
	MaterialMgr.resetAll(self._specialIcon)
end

function AthenaBlessView:_showCloseTip()
	local title = lang("tip")
	local text = "未在活动时间"

	local function func()
		self:_onClickClose()
	end

	local btnText = lang("tip_know")

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function AthenaBlessView:_refreshView()
	self:_refreshScrollList()
	self:_refreshRewardSlider()
	self:_refreshWeekScore()
end

function AthenaBlessView:_refreshScrollList()
	local list = AthenaBlessController.instance:getTaskList()

	self:updateListData(list)
end

function AthenaBlessView:_refreshRewardSlider()
	local totalScore = checknumber(AthenaBlessConfig.instance:getConstValue("athena_desc4"))

	totalScore = totalScore ~= 0 and totalScore or 1

	self:_initContentPageInfo()
	self:_refreshScoreDesc(totalScore)
	self:_refreshRewardCells(totalScore)
	self:_refreshLevelCells(totalScore)

	if self._isFirst then
		self._isFirst = false

		if self._isPlaySliderAnim then
			self:_playSliderAnimation()
		else
			self:_updateScrollRectPos()
		end
	end
end

function AthenaBlessView:_refreshWeekScore()
	local curScore = AthenaBlessModel.instance:getWeeklyScore()
	local totalScore = self._cfgBlessActivity.weeklyScoreLimit

	self._txtWeekScore.text = string.format("每周积分：%d/%d", curScore, totalScore)
end

function AthenaBlessView:_setSlider(curScore, totalScore)
	local planId = self._cfgBlessActivity.prizePlanId
	local list = AthenaBlessConfig.instance:getProgressPrizeCfgList(planId)

	if not list or #list == 0 then
		return
	end

	local num = 0
	local count = #list
	local lastScore = 0
	local interval = 1 / count
	local sliderValue = 0

	for i, v in ipairs(list) do
		if curScore < v.needScore then
			sliderValue = num * interval + (curScore - lastScore) / (v.needScore - lastScore) * interval

			break
		elseif i ~= #list then
			lastScore = v.needScore
			num = num + 1
		else
			sliderValue = 1
		end
	end

	self._slider:SetValue(sliderValue)
end

function AthenaBlessView:_refreshScoreDesc(totalScore)
	local curScore = AthenaBlessModel.instance:getCurScore()
	local planId = self._cfgBlessActivity.scoreLvPlanId

	self:_setSlider(curScore, totalScore)

	local list = AthenaBlessConfig.instance:getLevelCfgList(planId)

	if list and #list > 0 then
		for i, v in ipairs(list) do
			if curScore >= v.score then
				self._txtLevel.text = "活动奖励"
			end
		end
	end

	local prizePlanId = self._cfgBlessActivity.prizePlanId
	local prizeList = AthenaBlessConfig.instance:getProgressPrizeCfgList(prizePlanId)

	if prizeList and #prizeList > 0 then
		local maxCount = #prizeList

		for i, v in ipairs(prizeList) do
			if curScore < v.needScore then
				self._txtSliderDesc.text = string.format("积分达到 %d/%d\n可领取奖励", curScore, v.needScore)

				break
			end

			if i == maxCount then
				self._txtSliderDesc.text = "已解锁全部奖励"
			end
		end
	end
end

function AthenaBlessView:_refreshLevelCells(totalScore)
	local isShow = checknumber(AthenaBlessConfig.instance:getConstValue("athena_levelshow")) == 1

	if isShow then
		local planId = self._cfgBlessActivity.scoreLvPlanId
		local list = AthenaBlessConfig.instance:getLevelCfgList(planId)

		if not list or #list == 0 then
			return
		end

		self._levelEffectList = self._levelEffectList or {}
		self._levelGoList = self._levelGoList or {}

		if #self._levelGoList > 0 then
			for i, v in ipairs(self._levelGoList) do
				self:_updateLevelCell(i, v, list[i])
			end
		else
			for i, v in ipairs(list) do
				local go = goutil.cloneAndSetParent(self._levelCell, self._content.transform, "level_" .. i)

				goutil.setActive(go, true)
				table.insert(self._levelGoList, go)

				local rectTrans = go:GetComponent(goutil.Type_RectTransform)

				Framework.TransformUtil.SetAnchoredPos(rectTrans, self._sliderStartPos + v.score / totalScore * self._sliderWidth, 0)
				self:_updateLevelCell(i, go, v)
			end
		end
	elseif self._levelGoList and #self._levelGoList > 0 then
		for i, v in ipairs(self._levelGoList) do
			goutil.setActive(v, false)
		end
	end
end

function AthenaBlessView:_updateLevelCell(index, go, cfg)
	goutil.setActive(go, true)

	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local imgLevel = goutil.findChild(go, "imgLevel")
	local effectGo = goutil.findChild(go, "effect")

	txtNum.text = "Lv." .. index

	uGuiUtil.setSpriteToImage(imgLevel, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("athenabless", cfg.icon))

	if not self._levelEffectList[index] and not string.nilorempty(cfg.effResPath) then
		local path = string.format("20211126/yadiannadezhufu/%s.prefab", cfg.effResPath)
		local uiEffect = UIEffectManager.instance:playEffect(self, path, effectGo.transform, 0, 0, true, false, nil, function(target, eff)
			if not goutil.isNil(self._scrollRectTransform) then
				eff:setClipping(self._scrollRectTransform)
			end
		end)

		uiEffect:setParent(effectGo.transform)
		uiEffect:setScale(1)

		self._levelEffectList[index] = uiEffect
	end
end

function AthenaBlessView:_clearLevelCell()
	if self._levelGoList and #self._levelGoList > 0 then
		for i, v in ipairs(self._levelGoList) do
			local imgLevel = goutil.findChild(v, "imgLevel")

			uGuiUtil.clearImage(imgLevel)
		end
	end

	if self._levelEffectList then
		for k, v in pairs(self._levelEffectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._levelEffectList = nil
	end
end

function AthenaBlessView:_initContentPageInfo()
	self._unitPageScore = checknumber(AthenaBlessConfig.instance:getConstValue("athena_desc3"))
	self._totalPageScore = checknumber(AthenaBlessConfig.instance:getConstValue("athena_desc4"))
	self._unitScoreDiviveUnitWidth = self._unitPageScore / self._unitPageWidth
	self._sliderWidth = self._totalPageScore * self._unitScoreDiviveUnitWidth
	self._contentWidth = self._prePageWidth + self._sliderWidth + self._postPageWidth

	goutil.setWidth(self._contentRectTrans, self._contentWidth)
	goutil.setWidth(self._progressBarRect, self._sliderWidth)
end

function AthenaBlessView:_refreshRewardCells(totalScore)
	local planId = self._cfgBlessActivity.prizePlanId
	local list = AthenaBlessConfig.instance:getProgressPrizeCfgList(planId)

	if not list or #list == 0 then
		return
	end

	self._rewardGoList = self._rewardGoList or {}
	self._rewardEffectList = self._rewardEffectList or {}

	if #self._rewardGoList > 0 then
		for i, v in ipairs(self._rewardGoList) do
			self:_updateRewardCell(i, v, list[i])
		end
	else
		local count = #list
		local interval = self._sliderWidth / count

		for i, v in ipairs(list) do
			local go = goutil.cloneAndSetParent(self._rewardCell, self._content.transform, "reward_" .. i)

			goutil.setActive(go, true)
			table.insert(self._rewardGoList, go)

			local rectTrans = go:GetComponent(goutil.Type_RectTransform)
			local x = self._sliderStartPos + i * interval

			Framework.TransformUtil.SetAnchoredPos(rectTrans, x, 0)
			self:_updateRewardCell(i, go, v)
		end
	end
end

function AthenaBlessView:_updateRewardCell(index, go, cfg)
	local itemGo = goutil.findChild(go, "item/itemcell")
	local getedGo = goutil.findChild(go, "item/received")
	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local canGet = goutil.findChild(go, "item/canGet")
	local curScore = AthenaBlessModel.instance:getCurScore()
	local isGeted = AthenaBlessModel.instance:isGetedReward(cfg.prizeId)
	local isCanGet = curScore >= cfg.needScore

	local function onClick()
		if isGeted then
			FloatWordMgr.instance:show("奖励已领取")
		elseif isCanGet then
			AthenaBlessAgent.instance:sendPM_AnthenaBlessGainPrizeReq(self._cfgBlessActivity.activityId, cfg.prizeId)
		else
			FloatWordMgr.instance:show(string.format("请先达到%d积分", cfg.needScore))
		end
	end

	btn:AddClickListener(onClick)

	txtNum.text = cfg.needScore

	goutil.setActive(getedGo, isGeted)
	goutil.setActive(canGet, not isGeted and isCanGet)
	goutil.setActive(btn.gameObject, not isGeted and isCanGet)
	MaterialMgr.setCellByCfg(cfg.prize, itemGo)

	if not self._rewardEffectList[index] then
		local effect = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", canGet.transform, 0, 0, true, false, nil, function(target, eff)
			if not goutil.isNil(self._scrollRectTransform) then
				eff:setClipping(self._scrollRectTransform)
			end
		end)

		effect:setParent(canGet.transform)
		effect:setScale(1)

		self._rewardEffectList[index] = effect
	end
end

function AthenaBlessView:_clearRewardCells()
	self._rewardGoList = self._rewardGoList or {}
	self._rewardEffectList = self._rewardEffectList or {}

	for i, go in ipairs(self._rewardGoList) do
		local itemGo = goutil.findChild(go, "item/itemcell")
		local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

		MaterialMgr.resetAll(itemGo)
		btn:RemoveClickListener()
	end

	if self._rewardEffectList then
		for k, v in pairs(self._rewardEffectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._rewardEffectList = nil
	end
end

function AthenaBlessView:_initSliderAnimInfo()
	local isPlayed = GameUtil.getUserData(SliderAnim)

	self._isPlaySliderAnim = not isPlayed

	goutil.setActive(self._sliderMask, not isPlayed)
end

function AthenaBlessView:_playSliderAnimation()
	local isPlayed = true
	local startPos = 0
	local endPos = 1
	local duration = 3
	local delay = 1

	GameUtil.saveUserData(SliderAnim, isPlayed)

	local function updateTween(num)
		if self._scrollRect then
			self._scrollRect.horizontalNormalizedPosition = num
		end
	end

	local function endTween()
		goutil.setActive(self._sliderMask, false)
		self:_updateScrollRectPos()
	end

	self._scrollRect.horizontalNormalizedPosition = 0

	goutil.setActive(self._sliderMask, true)

	self._sequence = DG.Tweening.DOTween.Sequence()

	self._sequence:SetDelay(delay)

	local tweener1 = TweenUtil.DOTweenNum(startPos, endPos, duration, updateTween, self)
	local tweener2 = TweenUtil.DOTweenNum(endPos, startPos, duration - 1, updateTween, self)
	local tweener3 = TweenUtil.DoDelay(1, endTween)

	self._sequence:Append(tweener1)
	self._sequence:Append(tweener2)
	self._sequence:Append(tweener3)
end

function AthenaBlessView:_removeTween()
	if self._sequence then
		self._sequence:Kill(false)
	end
end

function AthenaBlessView:_updateScrollRectPos()
	local planId = self._cfgBlessActivity.prizePlanId
	local list = AthenaBlessConfig.instance:getProgressPrizeCfgList(planId)

	if not list or #list == 0 then
		self._scrollRect.horizontalNormalizedPosition = 0

		return
	end

	local canGetIndex = 0
	local getedIndex = 0
	local curScore = AthenaBlessModel.instance:getCurScore()

	for i, v in ipairs(list) do
		local isGeted = AthenaBlessModel.instance:isGetedReward(v.prizeId)
		local isCanGet = curScore >= v.needScore

		if canGetIndex == 0 and not isGeted and isCanGet then
			canGetIndex = i

			break
		end

		if isGeted then
			getedIndex = i
		end
	end

	local pos = 0

	if self._contentWidth > self._unitPageWidth then
		if canGetIndex > 0 then
			pos = (self._sliderStartPos + list[canGetIndex].needScore * self._unitScoreDiviveUnitWidth) / (self._contentWidth - self._unitPageWidth)
		elseif getedIndex > 0 then
			pos = (self._sliderStartPos + list[getedIndex].needScore * self._unitScoreDiviveUnitWidth) / (self._contentWidth - self._unitPageWidth)
		end
	end

	pos = pos <= 1 and pos or 1
	self._scrollRect.horizontalNormalizedPosition = pos
end

function AthenaBlessView:_loadCircleEffect()
	self:_removeCircleEffect()

	local path = "20211126/yadiannadezhufu/fx_ui_jineng_yadiannadezhufu.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, self._effectGo.transform, 0, 0, true, false)

	effect:setParent(self._effectGo.transform)
	effect:setScale(1)

	self._uiCircleEffect = effect
end

function AthenaBlessView:_removeCircleEffect()
	if self._uiCircleEffect then
		UIEffectManager.instance:stopEffect(self._uiCircleEffect)

		self._uiCircleEffect = nil
	end
end

return AthenaBlessView
