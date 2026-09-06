-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivitySummaryView.lua

module("logic.extensions.operationsummary.view.ActivitySummaryView", package.seeall)

local ActivitySummaryView = class("ActivitySummaryView", ViewComponent)

function ActivitySummaryView:ctor()
	ActivitySummaryView.super.ctor(self)
end

function ActivitySummaryView:buildUI()
	ActivitySummaryView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btn_tip")
	self._btnPv = self:getBtn("leftTop/btn_pv")
	self._objPv = self:getGo("leftTop/btn_pv")
	self._txtTitleName = self:getTxt("leftTop/txtTitle")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._bg = self:getGo("bg")
	self._effect = self:getGo("effect")
end

function ActivitySummaryView:bindEvents()
	ActivitySummaryView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "gashaponview")
	end)
	self._btnPv:AddClickListener(function()
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, checknumber(self._bgCfg.pvStoryId))
	end)
end

function ActivitySummaryView:unbindEvents()
	ActivitySummaryView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnPv:RemoveClickListener()
end

function ActivitySummaryView:destroyUI()
	ActivitySummaryView.super.destroyUI(self)
end

function ActivitySummaryView:onEnter()
	ActivitySummaryView.super.onEnter(self)

	self._activityId = 17006
	self._mainCfg = OperationSummaryConfig.instance:getSummaryCfgById(self._activityId)
	self._isOpen = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.Summary, self._activityId)
	self._txtTitleName.text = self._mainCfg.summaryName
	self._txtOpenTime.text = self:_getOpenTime()
	self._bgCfg = OperationSummaryConfig.instance:getOpenBgCfg(self._mainCfg.bgPlanId)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getHuoDongUrl(self._bgCfg.bgName))

	if not string.nilorempty(self._bgCfg.effect) then
		self:_showEffect(self._bgCfg.effect)
	end

	goutil.setActive(self._objPv, self._bgCfg.pvStoryId > 0)

	self._itemCfgList = OperationSummaryConfig.instance:getItemCfg(self._activityId)
	self._cellTab = {}

	self:_updateAllList()
end

function ActivitySummaryView:onEnterFinished()
	ActivitySummaryView.super.onEnterFinished(self)
end

function ActivitySummaryView:onExit()
	ActivitySummaryView.super.onExit(self)
	uGuiUtil.clearImage(self._bg)

	if self._showEff then
		UIEffectManager.instance:stopEffect(self._showEff)
	end

	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateAllList, self)

	for _, v in pairs(self._cellTab) do
		uGuiUtil.clearImage(v[1])
		uGuiUtil.clearImage(v[2])
		v[3]:RemoveClickListener()
		RedPointController.instance:unregRedPoint(v[4])
	end
end

function ActivitySummaryView:onExitFinished()
	ActivitySummaryView.super.onExitFinished(self)
end

function ActivitySummaryView:_updateAllList()
	for i, v in pairs(self._itemCfgList) do
		local cmpTab = self:_updateItem(v)

		if cmpTab then
			self._cellTab[v.id] = cmpTab
		end
	end
end

function ActivitySummaryView:_updateItem(data)
	local isShow = OperationSummaryConfig.instance:isShowItem(data)
	local isRelate = ActivityDefineController.instance:isRelateServerBy(data.relatedAreaIds)
	local itemName = "item" .. data.id
	local cell = goutil.findChild(self.mainGO, itemName)

	if isShow and isRelate and not cell then
		local cellObj = self:getGo("objs/" .. data.cellName)

		cell = goutil.cloneAndSetParent(cellObj, self.mainGO.transform, itemName)
	end

	goutil.setActive(cell, isShow)

	if not isShow or not isRelate then
		return
	end

	local go = goutil.findChild(cell, "node")
	local overObj = goutil.findChild(cell, "over")
	local timeObj = goutil.findChild(cell, "time")
	local icon = goutil.findChild(cell, "node/icon/con")
	local bgIcon = goutil.findChild(cell, "node/bg")
	local redPoint = goutil.findChild(cell, "node/imgRed")
	local newObj = goutil.findChild(cell, "node/new")
	local txtName = goutil.findChildTextComponent(cell, "node/txtName")
	local tab = goutil.findChild(cell, "node/tab")
	local txtTab = goutil.findChildTextComponent(cell, "node/tab/txt")
	local txtbg = goutil.findChild(cell, "node/tab/bg")
	local btnJump = GameUtil.asBtn(go)

	btnJump:RemoveClickListener()
	GameUtil.setLocalPos(cell, data.pos[1], data.pos[2])

	txtName.text = data.name

	if not GameUtil.isEmptyString(data.icon) then
		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, data.icon .. ".png")
	end

	if not GameUtil.isEmptyString(data.bgIcon) then
		uGuiUtil.setSpriteToImage(bgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getOperationSummaryIconUrl(data.bgIcon))
	end

	if GameUtil.isEmptyString(data.tips) then
		goutil.setActive(tab, false)
	else
		goutil.setActive(tab, true)

		txtTab.text = data.tips

		if not GameUtil.isEmptyString(data.picture) then
			uGuiUtil.setSpriteToImage(txtbg, uGuiUtil.SpriteType.BigBg, GameUrl.getOperationSummaryIconUrl(data.picture))
		end
	end

	local curType, startTime = OperationSummaryConfig.instance:getOpenTimeInfo(data)

	if timeObj then
		goutil.setActive(timeObj, curType == GameUtil.beforeTimePeriod)
	end

	if overObj then
		goutil.setActive(overObj, curType == GameUtil.afterTimePeriod)
	end

	if startTime and timeObj then
		goutil.findChildTextComponent(timeObj, "txtTime").text = self:_getDateTime(startTime)
	end

	local isOpen = curType == GameUtil.inTimePeriod

	goutil.setActive(redPoint, false)

	if newObj then
		local isNew = OpSummaryModel.instance:isNewItem(data, GameEnum.ActivityType.Summary)

		goutil.setActive(newObj, isNew)
	end

	if not isOpen then
		return
	end

	if not GameUtil.isEmptyString(data.redpointId) then
		RedPointController.instance:regRedPoint(redPoint, unpack(string.splitToNumber(data.redpointId or "", "#")))
	end

	btnJump:AddClickListener(function()
		self:_jumpToFunction(data)
	end)

	return {
		icon,
		bgIcon,
		btnJump,
		redPoint
	}
end

function ActivitySummaryView:_jumpToFunction(data)
	if checknumber(data.funcId) > 0 then
		SurveyController.instance:reportBehavior(data.reportBehavior)

		if string.nilorempty(data.params) then
			FuncOpenController.instance:openFunc(data.funcId)
		else
			GotoMgr.gotoByString(string.format("func#%s#%s", data.funcId, data.params))
		end

		OpSummaryModel.instance:setNewItem(data)
	elseif not string.nilorempty(data.viewname) then
		SurveyController.instance:reportBehavior(data.reportBehavior)
		FuncOpenController.instance:openFuncByViewName(data.viewname)
		OpSummaryModel.instance:setNewItem(data)
	else
		FloatWordMgr.instance:show("未配置!!!")
	end
end

function ActivitySummaryView:_getOpenTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Summary, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	return string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function ActivitySummaryView:_getDateTime(dataStr)
	local dataInfo = os.date("*t", GameUtil.string2time(dataStr))

	return string.format("%02d.%02d %02d:%02d 上线", dataInfo.month, dataInfo.day, dataInfo.hour, dataInfo.min)
end

function ActivitySummaryView:_showEffect(effect)
	if self._showEff then
		UIEffectManager.instance:stopEffect(self._showEff)
	end

	local effPath = effect .. ".prefab"

	self._showEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, nil, self)

	self._showEff:setParent(self._effect.transform)
	self._showEff:setLocalPos(0, 0, 0)
	self._showEff:setScale(1)
end

function ActivitySummaryView:_showAnimationFirst()
	if not self._isOpen then
		return
	end

	if GameUtil.getUserData(OpSummaryModel.FIRST_ANIM .. self._activityId) then
		return
	end

	GameUtil.saveUserData(OpSummaryModel.FIRST_ANIM .. self._activityId, true)
	ViewBlockMgr.instance:blockClick(true, self)
	AnimationPlayer.play("storyconfig/animations/wumengmeng_anim.txt", function()
		ViewBlockMgr.instance:blockClick(false, self)
	end, function()
		return
	end)
end

return ActivitySummaryView
