-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivitysummarypopView.lua

module("logic.extensions.operationsummary.view.ActivitysummarypopView", package.seeall)

local ActivitysummarypopView = class("ActivitysummarypopView", ViewComponent)

function ActivitysummarypopView:ctor()
	ActivitysummarypopView.super.ctor(self)
end

function ActivitysummarypopView:buildUI()
	ActivitysummarypopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnGo = self:getBtn("btnGo")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._effect = self:getGo("effect")
end

function ActivitysummarypopView:bindEvents()
	ActivitysummarypopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnGo:AddClickListener(function()
		GotoMgr.gotoByString("func#43#14")
	end)
end

function ActivitysummarypopView:unbindEvents()
	ActivitysummarypopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnGo:RemoveClickListener()
end

function ActivitysummarypopView:destroyUI()
	ActivitysummarypopView.super.destroyUI(self)
end

function ActivitysummarypopView:onEnter()
	ActivitysummarypopView.super.onEnter(self)

	self._activityId = 41002
	self._isOpen = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.SummaryPop, self._activityId)
	self._txtOpenTime.text = self:_getOpenTime()
	self._itemCfgList = OperationSummaryConfig.instance:getPopItemCfg(self._activityId)
	self._cellTab = {}

	self:_updateAllList()
end

function ActivitysummarypopView:onEnterFinished()
	ActivitysummarypopView.super.onEnterFinished(self)
end

function ActivitysummarypopView:onExit()
	ActivitysummarypopView.super.onExit(self)

	if self._showEff then
		UIEffectManager.instance:stopEffect(self._showEff)
	end

	for _, v in pairs(self._cellTab) do
		uGuiUtil.clearImage(v[1])
		uGuiUtil.clearImage(v[2])
		v[3]:RemoveClickListener()
		RedPointController.instance:unregRedPoint(v[4])
	end
end

function ActivitysummarypopView:onExitFinished()
	ActivitysummarypopView.super.onExitFinished(self)
end

function ActivitysummarypopView:_updateAllList()
	for i, v in pairs(self._itemCfgList) do
		local cmpTab = self:_updateItem(v)

		if cmpTab then
			self._cellTab[v.id] = cmpTab
		end
	end
end

function ActivitysummarypopView:_updateItem(data)
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
	local tagObj = goutil.findChild(cell, "node/tag")
	local tagText = goutil.findChildTextComponent(cell, "node/tag/txt")
	local btnJump = GameUtil.asBtn(go)

	btnJump:RemoveClickListener()
	GameUtil.setLocalPos(cell, data.pos[1], data.pos[2])

	txtName.text = data.name

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, data.icon .. ".png")
	uGuiUtil.setSpriteToImage(bgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getOperationSummaryIconUrl(data.bgIcon))

	if tagObj then
		local hadTip = not string.nilorempty(data.tips)

		goutil.setActive(tagObj, hadTip)

		if hadTip then
			tagText.text = data.tips
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

	if isOpen and not GameUtil.isEmptyString(data.redpointId) then
		RedPointController.instance:regRedPoint(redPoint, unpack(string.splitToNumber(data.redpointId or "", "#")))
	end

	if newObj then
		local isNew = OpSummaryModel.instance:isNewItem(data, GameEnum.ActivityType.SummaryPop)

		goutil.setActive(newObj, isNew)
	end

	if not isOpen then
		return {
			icon,
			bgIcon,
			btnJump,
			redPoint
		}
	end

	btnJump:AddClickListener(function()
		self:_jumpToFunction(data)
	end)

	return {
		icon,
		bgIcon,
		btnJump
	}
end

function ActivitysummarypopView:_jumpToFunction(data)
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

	self:_updateItem(data)
end

function ActivitysummarypopView:_getOpenTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SummaryPop, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	return string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function ActivitysummarypopView:_getDateTime(dataStr)
	local dataInfo = os.date("*t", GameUtil.string2time(dataStr))

	return string.format("%02d.%02d %02d:%02d\n上线", dataInfo.month, dataInfo.day, dataInfo.hour, dataInfo.min)
end

function ActivitysummarypopView:_showEffect(effect)
	if self._showEff then
		UIEffectManager.instance:stopEffect(self._showEff)
	end

	local effPath = effect .. ".prefab"

	self._showEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, nil, self)

	self._showEff:setParent(self._effect.transform)
	self._showEff:setLocalPos(0, 0, 0)
	self._showEff:setScale(1)
end

return ActivitysummarypopView
