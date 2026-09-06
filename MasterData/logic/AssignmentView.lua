-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/view/AssignmentView.lua

module("logic.extensions.assignment.view.AssignmentView", package.seeall)

local AssignmentView = class("AssignmentView", TableViewComponent)

function AssignmentView:ctor()
	AssignmentView.super.ctor(self)
end

function AssignmentView:_getPath()
	return {
		cellPath = "sv_item",
		viewPath = "sv_info"
	}
end

function AssignmentView:buildUI()
	AssignmentView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._goldBar = self:getGo("goldBar")
	self._Tableview = self:getGo("sv_info")
	self._refresh = self:getBtn("refresh")
	self._complete = self:getGo("complete/count"):GetComponent(goutil.Type_UIText)
	self._boxName = self:getGo("treasure/boxName"):GetComponent(goutil.Type_UIText)
	self._boxIcon = self:getGo("treasure/boxIcon")
	self._boxProgress = self:getGo("treasure/boxProgress/progress"):GetComponent("Image")
	self._boxProgressIng = self:getGo("treasure/boxProgress/num/ing"):GetComponent(goutil.Type_UIText)
	self._boxProgressEd = self:getGo("treasure/boxProgress/num/ed"):GetComponent(goutil.Type_UIText)
	self._boxCondition = self:getGo("treasure/condition/content"):GetComponent(goutil.Type_UIText)
	self._boxRewardItem = {}

	for i = 1, 4 do
		table.insert(self._boxRewardItem, self:getGo("treasure/reward/item_" .. i))
	end

	self._boxRefresh = self:getBtn("treasure/refresh")
	self._taskRefreshEffect = {}
	self._taskIdToRemain = {}
	self._btnOnekey = self:getBtn("btnOnekey")
	self._txtBtnOnekey = self:getTxt("btnOnekey/Text")
	self._inputComp = self:getInput("refrescount/InputField")
	self._tableviewGoType = self:getGo("type/panel/tableview")
	self._tablecellGoType = self:getGo("type/panel/tablecell")
	self._tablecellGoRefresh = self:getGo("refrescount/panel/tablecell")
	self._tableviewGoRefresh = self:getGo("refrescount/panel/tableview")
	self._typescrollerList = ScrollerList.create(self._tableviewGoType, self._tablecellGoType, GameUtil.handler(self._updateTypeCell, self), GameUtil.handler(self._clearTypeCell, self))
	self._refreshscrollerList = ScrollerList.create(self._tableviewGoRefresh, self._tablecellGoRefresh, GameUtil.handler(self._updateRefershCell, self), GameUtil.handler(self._clearRefreshCell, self))
	self._btnSelectMat = self:getBtn("type/btnSelectMat")
	self._btnSelectTime = self:getBtn("refrescount/btnSelectTime")
	self._panelTypeGo = self:getGo("type/panel")
	self._panelRefreshGo = self:getGo("refrescount/panel")
	self._typePanelGo = self:getGo("type/panel")
	self._customInput = UICustomInput.Get(self._typePanelGo)
	self._refresPanelGo = self:getGo("refrescount/panel")
	self._refreshCustomInput = UICustomInput.Get(self._refresPanelGo)
	self._txtTypeDesc = self:getTxt("type/txtDesc")
	self._typeArrowGo = self:getGo("type/arrow")
	self._refreshArrowGo = self:getGo("refrescount/arrow")
end

function AssignmentView:bindEvents()
	AssignmentView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickHelp, self)
	self._refresh:AddClickListener(self._onClickRefresh, self)
	self._boxRefresh:AddClickListener(self._onClickBoxRefresh, self)
	self._btnOnekey:AddClickListener(self._onClickbtnOnekey, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
	self._btnSelectMat:AddClickListener(self._onClickbtnSelectMat, self)
	self._btnSelectTime:AddClickListener(self._onClickbtnSelectTime, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._refreshCustomInput:AddListener(self._onCustomRefreshInputCallback, self)
end

function AssignmentView:unbindEvents()
	AssignmentView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._refresh:RemoveClickListener()
	self._boxRefresh:RemoveClickListener()
	self._btnOnekey:RemoveClickListener()
	self._inputComp:RemoveOnValueChanged()
	self._btnSelectMat:RemoveClickListener()
	self._btnSelectTime:RemoveClickListener()
	self._customInput:RemoveListener()
	self._refreshCustomInput:RemoveListener()
end

function AssignmentView:destroyUI()
	AssignmentView.super.destroyUI(self)

	for i, v in pairs(self._taskRefreshEffect) do
		UIEffectManager.instance:stopEffect(v)
	end

	UIEffectManager.instance:stopEffect(self._boxRefreshEffect)

	self._boxRefreshEffect = nil
end

function AssignmentView:onEnter()
	AssignmentView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RefreshDispatchData, self._onRefreshDispatchData, self)
	AssignmentController.instance:setRootView(self)

	self._txtrefreTimeStr = nil
	self._cellSelected = {}

	self:onGoldBar()
	self:_setOnekeyBtnTxt()
	self:_initPanels()

	self._cacheSelectTypeIds = nil

	PetDispatchAgent.instance:sendGetMyPetDispatchInfoReq()
end

function AssignmentView:onExit()
	AssignmentController.instance:setRootView(nil)
	AssignmentView.super.onExit(self)
	uGuiUtil.clearImage(self._boxIcon)
	removetimer(self._time, self)
	GlobalModel.instance:visibleMainCamera(true)
	self._typescrollerList:dispose()
	self._refreshscrollerList:dispose()

	self._selectTypeIds = {}
end

function AssignmentView:_cellSize()
	return 900, 96.42
end

function AssignmentView:_updateCell(view, cell, data)
	cell.gameObject:GetComponent("UIImageSpriteChange"):SetState(0)

	for i = 1, 6 do
		goutil.findChild(cell.gameObject, "star_" .. i):SetActive(false)
	end

	local consume = goutil.findChild(cell.gameObject, "consume")

	goutil.setActive(consume, data.status == 1 or data.status == 0)

	local remain = goutil.findChild(cell.gameObject, "remain")

	goutil.setActive(remain, data.status == 2)

	local dispatchBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "dispatchBtn")

	goutil.setActive(dispatchBtn.gameObject, data.status == 1)

	local receiveBtn = goutil.findChild(cell.gameObject, "receiveBtn")

	goutil.setActive(receiveBtn, data.status == 0)

	local complete = goutil.findChild(cell.gameObject, "complete")

	goutil.setActive(complete, data.status == 4)

	local assigning = goutil.findChild(cell.gameObject, "txtAssigning")

	goutil.setActive(assigning, data.status == 2)

	local rewardItems = {}

	rewardItems[1] = {
		itemGo = goutil.findChild(cell, "reward_1"),
		goodsPos = goutil.findChild(cell, "reward_1/goodsPos"),
		perfectGo = goutil.findChild(cell, "reward_1/perfectGo")
	}
	rewardItems[2] = {
		itemGo = goutil.findChild(cell, "reward_2"),
		goodsPos = goutil.findChild(cell, "reward_2/goodsPos"),
		perfectGo = goutil.findChild(cell, "reward_2/perfectGo")
	}
	rewardItems[3] = {
		itemGo = goutil.findChild(cell, "reward_3"),
		goodsPos = goutil.findChild(cell, "reward_3/goodsPos"),
		perfectGo = goutil.findChild(cell, "reward_3/perfectGo")
	}
	rewardItems[4] = {
		itemGo = goutil.findChild(cell, "reward_4"),
		goodsPos = goutil.findChild(cell, "reward_4/goodsPos"),
		perfectGo = goutil.findChild(cell, "reward_4/perfectGo")
	}

	local multipleGo = goutil.findChild(cell, "multipleGo")

	for _, rts in pairs(rewardItems or {}) do
		if rts then
			if rts.goodsPos then
				MaterialMgr.resetAll(rts.goodsPos)
			end

			if rts.perfectGo then
				GameUtil.SetActive(rts.perfectGo, false)
			end

			if rts.itemGo then
				GameUtil.SetActive(rts.itemGo, false)
			end
		end
	end

	if data and data.taskId then
		if AssignmentController.instance:taskRefreshIsPlay(data.taskId, self._refreshTaskId) then
			if not self._taskRefreshEffect[data.taskId] then
				local effect_path = "fx_ui_assignmentview/fx_ui_assignmentview_refresheffect.prefab"
				local _taskRefreshEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, false, nil, function()
					return
				end, function(finishHandler, eff)
					Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
					eff.effGo.transform:SetParent(cell.gameObject.transform)
					eff:setScrollRectClipping(self._Tableview:GetComponent(typeof(UnityEngine.UI.ScrollRect)))
				end)

				_taskRefreshEffect:setParent(cell.gameObject.transform)
				_taskRefreshEffect:setScale(1)

				self._taskRefreshEffect[data.taskId] = _taskRefreshEffect
			end
		elseif self._taskRefreshEffect[data.taskId] and self._taskRefreshEffect[data.taskId] then
			UIEffectManager.instance:stopEffect(self._taskRefreshEffect[data.taskId])

			self._taskRefreshEffect[data.taskId] = nil
		end
	end

	goutil.findChildComponent(cell.gameObject, "title", "Text").text = data.taskName

	for i = 1, data.taskQuality do
		goutil.findChild(cell.gameObject, "star_" .. i):SetActive(true)
	end

	local isInTime, title, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.petSendPrize)
	local mul = 1

	if isInTime and cfg and checknumber(cfg.featureParam) > 0 then
		mul = checknumber(cfg.featureParam)
	end

	local newhandDoubleValue = NewhandwelfareController.instance:getNewhandDoubleValue()

	mul = mul + newhandDoubleValue

	self:_showReword(data, rewardItems, mul)
	goutil.setActive(multipleGo, mul > 1)

	if data.status == 1 then
		goutil.findChildComponent(consume, "time", "Text").text = AssignmentController.instance:secondToDate(data.taskTime)

		dispatchBtn:AddClickListener(function()
			AssignmentDetailsModel.instance:setAssignment(data)
			UIStateManager.instance:push(ViewName.AssignmentDetailsView)

			self._cellSelected[cell] = true
		end, self)
	elseif data.status == 2 and ServerTime.now() < data.endTimeMillis then
		self._taskIdToRemain[data.taskId] = goutil.findChildComponent(remain, "time", "Text")
	elseif data.status == 0 then
		goutil.findChildComponent(consume, "time", "Text").text = AssignmentController.instance:secondToDate(data.taskTime)

		Framework.ButtonAdapter.GetFrom(receiveBtn, ""):AddClickListener(function()
			AssignmentController.instance:sendGainTaskPrizeReq({
				data.taskId
			})
		end, self)
	else
		local var_10_0

		if data.status == 4 then
			cell.gameObject:GetComponent("UIImageSpriteChange"):SetState(1)

			var_10_0 = AssignmentController.instance:isPoint(data, self._cellSelected[cell]) or data.status == 0
		end
	end

	goutil.setActive(goutil.findChild(cell.gameObject, "imgPoint"), var_10_0)
end

function AssignmentView:_clearTableview(cell)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "dispatchBtn"):RemoveClickListener()
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "receiveBtn"):RemoveClickListener()
end

function AssignmentView:_showReword(data, items, mul)
	local rdMats = string.split(data.reward, "#")
	local ptrdMats = string.split(data.rewardPerfect, "#")

	if data.status ~= 1 then
		if data.isPerfect then
			rdMats = nil
		else
			ptrdMats = nil
		end
	end

	local index = 0

	if rdMats and #rdMats > 0 then
		for i = 1, #rdMats do
			index = index + 1

			if items[index] then
				GameUtil.SetActive(items[index].itemGo, true)
				MaterialMgr.setCellByCfg(AssignmentController.instance.vipToPrize(rdMats[i], mul), items[index].goodsPos)
				GameUtil.SetActive(items[index].perfectGo, false)
			end
		end
	end

	if ptrdMats and #ptrdMats > 0 then
		for i = 1, #ptrdMats do
			index = index + 1

			if items[index] then
				GameUtil.SetActive(items[index].itemGo, true)
				MaterialMgr.setCellByCfg(AssignmentController.instance.vipToPrize(ptrdMats[i], mul), items[index].goodsPos)
				GameUtil.SetActive(items[index].perfectGo, true)
			end
		end
	end
end

function AssignmentView:_onClickClose()
	self:close()
end

function AssignmentView:_onClickRefresh()
	self._cacheSelectTypeIds = nil

	local isRefresh = false

	for _, task in ipairs(self._curViewDatas) do
		if task.status == 1 then
			isRefresh = true

			break
		end
	end

	if not isRefresh then
		FloatWordMgr.instance:show("今天没任务可刷新了，请明天再试")

		return
	end

	local times = checknumber(self._txtrefreTimeStr)
	local useTime = AssignmentModel.instance:getRefreshTimes(1)
	local costCfgs = AssignmentConfig.instance:getPetDispatchRefreshConfig(1)

	if useTime >= #costCfgs then
		FloatWordMgr.instance:show("已达到今天刷新上限，请明天再试")

		return
	end

	local costCfg = costCfgs[useTime + times]

	if not costCfg then
		FloatWordMgr.instance:show("可刷新次数不足")

		return
	end

	local matStrList = {}

	for k, v in pairs(self._selectTypeIds) do
		table.insert(matStrList, v.prizeTypeName)
	end

	local cost = AssignmentConfig.instance:getPetDispatchRefreshTotalCost(1, times, self._cacheTodayTaskRefreshTimes)
	local content = string.format("刷新的目标任务奖励为：%s\n自动刷新次数：<color=red>%s</color>\n刷新最多消耗：<color=red>%s</color>钻石\n是否确定自动刷新？", table.concat(matStrList, "、"), self._txtrefreTimeStr, cost)

	UIStateManager.instance:push(ViewName.AssignmenttipsView, content, true, function()
		local hasNum = MaterialMgr.getMatCount(costCfg.consume)

		if hasNum < cost then
			FloatWordMgr.instance:show("钻石不足")

			return
		end

		local ids = {}

		for k, v in pairs(self._selectTypeIds) do
			table.insert(ids, k)
		end

		self._cacheSelectTypeIds = self._selectTypeIds

		PetDispatchAgent.instance:sendRefreshTaskReq(ids, checknumber(self._txtrefreTimeStr))
	end)
end

function AssignmentView:_onClickBoxRefresh()
	local x = AssignmentConfig.instance:getPetDispatchRefreshConfig(2, AssignmentModel.instance:getRefreshTimes(2) + 1)

	if x ~= nil then
		local maxTimes = AssignmentConfig.instance:getPetDispatchRefreshMaxTimes(2)
		local consume = string.split(x.consume, ":")
		local price = GoodsConfig.instance:getCfgPrice(tonumber(consume[2])) * tonumber(consume[3])
		local tipText = string.format("是否花费%s钻石刷新宝箱\n还有%s次刷新机会", price, maxTimes - AssignmentModel.instance:getRefreshTimes(2))

		if AssignmentModel.instance:getBox().boxProgress > 0 then
			tipText = tipText .. "\n刷新宝箱将不保存已有进度，是否刷新？"
		end

		TipsFacade.instance:openPopupCostDiamondView(price, tipText, function()
			PetDispatchAgent.instance:sendRefreshBoxReq()
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		FloatWordMgr.instance:show("已达到今天刷新上限，请明天再试")
	end
end

function AssignmentView:_onClickHelp()
	UIStateManager.instance:open(ViewName.RulesView, "assignmentRule")
end

function AssignmentView:_onClickbtnOnekey()
	local ids = AssignmentController.instance:getCanGainTaskIds()

	if #ids > 0 then
		AssignmentController.instance:onekeyGainPrize()
	else
		AssignmentController.instance:onClickOnekeyDipatch()
	end
end

function AssignmentView:updateList(list)
	self._curViewDatas = list

	local x = 0

	for i = 1, #self._curViewDatas do
		if self._curViewDatas[i].status == 4 then
			x = x + 1
		end
	end

	self._complete.text = x .. "/" .. #self._curViewDatas
end

function AssignmentView:updateListData(list)
	self:updateList(list)
	removetimer(self._time, self)
	settimer(1, self._time, self, true)
	self:_time()
	self._tableview:ReloadData()
end

function AssignmentView:updateBoxData(box)
	self._boxName.text = box.boxName

	uGuiUtil.setSpriteToImage(self._boxIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("icon_box_0" .. box.boxQuality))
	self:updateBoxProgress(box.boxProgress, box.progress)

	self._boxCondition.text = AssignmentController.instance:analysisBoxCondition(box.detectorParam, box.progress)

	local s = string.split(box.reward, "#")

	for i = 1, #s do
		goutil.setActive(self._boxRewardItem[i], true)

		local proxy = MaterialMgr.setCellByCfg(AssignmentController.instance.vipToPrize(s[i], 1), self._boxRewardItem[i])

		Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.65, 0.65, 1)
	end
end

function AssignmentView:updateBoxProgress(ing, ed)
	self._boxProgress.fillAmount = ing / ed
	self._boxProgressIng.text = ing
	self._boxProgressEd.text = ed
end

function AssignmentView:refreshBox()
	local effect_path = "fx_ui_assignmentview/fx_ui_assignmentview_treasurechesteffects.prefab"

	UIEffectManager.instance:stopEffect(self._boxRefreshEffect)

	self._boxRefreshEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, false, nil, function()
		return
	end, function(finishHandler, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._boxRefreshEffect:setParent(self._boxIcon.transform)
	self._boxRefreshEffect:setScale(1)
	self:updateBoxData(AssignmentModel.instance:getBox())
end

function AssignmentView:setRefreshTaskId(taskIds, todayTaskRefreshTimes)
	self._refreshTaskId = taskIds

	self._tableview:ReloadData()

	self._refreshTaskId = nil

	self:_initPanels()
	self:_showRefreshTip(taskIds, todayTaskRefreshTimes)

	self._cacheTodayTaskRefreshTimes = AssignmentModel.instance:getRefreshTimes(1)
end

function AssignmentView:_showRefreshTip(taskIds, todayTaskRefreshTimes)
	if self._cacheSelectTypeIds then
		local refreshTypeIds = {}

		for i, v in ipairs(taskIds) do
			local taskCfg = AssignmentConfig.instance:getDispatchTask(v)

			refreshTypeIds[taskCfg.prizeType] = true
		end

		local notRefreshCount = 0

		for k, v in pairs(self._cacheSelectTypeIds) do
			if not refreshTypeIds[k] then
				notRefreshCount = notRefreshCount + 1
			end
		end

		local refeshTimes = todayTaskRefreshTimes - self._cacheTodayTaskRefreshTimes
		local cost = AssignmentConfig.instance:getPetDispatchRefreshTotalCost(1, refeshTimes, self._cacheTodayTaskRefreshTimes)
		local content = string.format("自动刷新成功!\n成功刷新任务数量：<color=green>%s</color>\n已刷新次数：<color=green>%s</color>\n刷新消耗：<color=green>%s</color>钻石\n%s", #taskIds, refeshTimes, cost, (notRefreshCount > 0 or nil) and string.format("剩余未能刷新出设定奖励任务数量：<color=red>%s</color>", notRefreshCount))

		UIStateManager.instance:push(ViewName.AssignmenttipsView, content)

		self._cacheSelectTypeIds = nil
	end
end

function AssignmentView:_time()
	if self._curViewDatas == nil then
		return
	end

	for i = 1, #self._curViewDatas do
		if self._curViewDatas[i].status == 2 then
			if ServerTime.now() < self._curViewDatas[i].endTimeMillis then
				self._curViewDatas[i].customDate = os.date("!%H:%M:%S", self._curViewDatas[i].endTimeMillis - ServerTime.now())

				if self._taskIdToRemain[self._curViewDatas[i].taskId] ~= nil then
					self._taskIdToRemain[self._curViewDatas[i].taskId].text = self._curViewDatas[i].customDate
				end
			else
				self._curViewDatas[i].status = 0

				self._tableview:ReloadData()
				self:_setOnekeyBtnTxt()
			end
		end
	end
end

function AssignmentView:onGoldBar()
	local objList = {
		{
			showAdd = false,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.Coin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)
end

function AssignmentView:_onRefreshDispatchData()
	if self._txtrefreTimeStr == nil then
		self:_initRefreshTime()
	end

	self:updateListData(AssignmentModel.instance:getAssignment())
	self:updateBoxData(AssignmentModel.instance:getBox())
	self:_setOnekeyBtnTxt()

	self._cacheTodayTaskRefreshTimes = AssignmentModel.instance:getRefreshTimes(1)
end

function AssignmentView:_setOnekeyBtnTxt()
	local taskIds = AssignmentController.instance:getCanGainTaskIds()

	self._txtBtnOnekey.text = #taskIds > 0 and "一键领取" or "一键派遣"
end

function AssignmentView:_initRefreshTime(times)
	self._txtrefreTimeStr = times and tostring(times) or self:_getDefaultTims()

	self._inputComp:SetText(self._txtrefreTimeStr)
end

function AssignmentView:_inputValueChanged(text)
	if text == self._txtrefreTimeStr then
		return
	end

	local times = checknumber(text)

	if times == 0 then
		self:_initRefreshTime()
		FloatWordMgr.instance:show("无效次数，已修正")

		return
	end

	AssignmentController.instance:setLastSavefreshTime(times)

	local hasRefreshTime = AssignmentModel.instance:getRefreshTimes(1)
	local costCfg = AssignmentConfig.instance:getPetDispatchRefreshConfig(1, hasRefreshTime + times)

	if not costCfg then
		FloatWordMgr.instance:show("可刷新次数不足")
		self:_initRefreshTime(self._txtrefreTimeStr)

		return
	end

	local hasNum = MaterialMgr.getMatCount(costCfg.consume)
	local matType, matId, matNum = MaterialMgr.getMatParams(costCfg.consume)
	local cost = AssignmentConfig.instance:getPetDispatchRefreshTotalCost(1, times, self._cacheTodayTaskRefreshTimes)

	if hasNum < cost then
		local modTimes = 1

		for i = times - 1, 1, -1 do
			costCfg = AssignmentConfig.instance:getPetDispatchRefreshConfig(1, i)
			cost = AssignmentConfig.instance:getPetDispatchRefreshTotalCost(1, i, self._cacheTodayTaskRefreshTimes)

			if cost <= hasNum then
				modTimes = i

				break
			end
		end

		self:_initRefreshTime(modTimes)
		FloatWordMgr.instance:show("钻石不满足消耗需求，已自动修改为最大次数")
	else
		self._txtrefreTimeStr = tostring(times)

		self._inputComp:SetText(self._txtrefreTimeStr)
	end
end

function AssignmentView:_onSelectRefresTime(times)
	local hasRefreshTime = AssignmentModel.instance:getRefreshTimes(1)
	local costCfg = AssignmentConfig.instance:getPetDispatchRefreshConfig(1, hasRefreshTime + times)

	if not costCfg then
		FloatWordMgr.instance:show("可刷新次数不足")

		return
	end

	local hasNum = MaterialMgr.getMatCount(costCfg.consume)
	local matType, matId, matNum = MaterialMgr.getMatParams(costCfg.consume)
	local cost = AssignmentConfig.instance:getPetDispatchRefreshTotalCost(1, times, self._cacheTodayTaskRefreshTimes)

	if hasNum < cost then
		FloatWordMgr.instance:show("钻石不满足消耗需求，无法选择")

		return
	end

	self:_inputValueChanged(tostring(times))
	self:_onClickbtnSelectTime()
end

function AssignmentView:_initPanels()
	self._openTypePanel = false
	self._openRefreshPanel = false

	goutil.setActive(self._panelTypeGo, self._openTypePanel)
	goutil.setActive(self._panelRefreshGo, self._openRefreshPanel)
	Framework.TransformUtil.SetLocalRotation(self._refreshArrowGo.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalRotation(self._typeArrowGo.transform, 0, 0, 0)

	local refeshTimes = {
		1,
		5,
		10,
		20,
		30,
		50
	}

	self._refreshscrollerList:reloadData(refeshTimes)

	local typeDatas = AssignmentController.instance:getTaskPrizeTypeDatas()

	self._selectTypeIds = self._selectTypeIds or {}
	self._selectTypeIds = AssignmentController.instance:getLastSelectTaskTypeIdMap()

	local currTime = checknumber(self._txtrefreTimeStr)

	if currTime > 1 then
		local hasRefreshTime = AssignmentModel.instance:getRefreshTimes(1)
		local costCfg = AssignmentConfig.instance:getPetDispatchRefreshConfig(1, hasRefreshTime + currTime)

		if not costCfg then
			for i = hasRefreshTime + currTime - 1, 2, -1 do
				costCfg = AssignmentConfig.instance:getPetDispatchRefreshConfig(1, i)

				if costCfg then
					self:_inputValueChanged(tostring(i - hasRefreshTime))

					break
				end
			end
		end
	end

	self._typescrollerList:reloadData(typeDatas)
	self:_setSelectTypeDesc()
end

function AssignmentView:_updateRefershCell(view, cell, time, tag)
	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txt.text = time

	btn:AddClickListener(function()
		self:_onSelectRefresTime(time)
	end)
end

function AssignmentView:_clearRefreshCell(cell)
	return
end

function AssignmentView:_updateTypeCell(view, cell, data, tag)
	local goSelect = goutil.findChild(cell.gameObject, "checkbox/select")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSelect")

	txtName.text = data.prizeTypeName

	goutil.setActive(goSelect, self._selectTypeIds[data.prizeType])
	btn:AddClickListener(function()
		local selectNum = table.nums(self._selectTypeIds)

		if selectNum <= 1 and self._selectTypeIds[data.prizeType] then
			FloatWordMgr.instance:show("至少选一种")

			return
		elseif selectNum >= 2 and not self._selectTypeIds[data.prizeType] then
			FloatWordMgr.instance:show("最多选两种")

			return
		end

		if self._selectTypeIds[data.prizeType] then
			self._selectTypeIds[data.prizeType] = nil

			AssignmentController.instance:setPrizeTypeIsSelect(data.prizeType, false)
		else
			self._selectTypeIds[data.prizeType] = data

			AssignmentController.instance:setPrizeTypeIsSelect(data.prizeType, true)
		end

		self:_setSelectTypeDesc()
		self._typescrollerList:refresh()
	end)
end

function AssignmentView:_clearTypeCell(cell)
	return
end

function AssignmentView:_setSelectTypeDesc()
	local strList = {}

	for k, v in pairs(self._selectTypeIds) do
		table.insert(strList, v.prizeTypeName)
	end

	self._txtTypeDesc.text = table.concat(strList, "、")
end

function AssignmentView:_onClickbtnSelectMat()
	self._openTypePanel = not self._openTypePanel

	Framework.TransformUtil.SetLocalRotation(self._typeArrowGo.transform, 0, 0, self._openTypePanel and 180 or 0)
	goutil.setActive(self._panelTypeGo, self._openTypePanel)
end

function AssignmentView:_onClickbtnSelectTime()
	self._openRefreshPanel = not self._openRefreshPanel

	Framework.TransformUtil.SetLocalRotation(self._refreshArrowGo.transform, 0, 0, self._openRefreshPanel and 180 or 0)
	goutil.setActive(self._panelRefreshGo, self._openRefreshPanel)
end

function AssignmentView:_onCustomInputCallback(hover)
	if not hover and self._openTypePanel then
		self:_onClickbtnSelectMat()
	end
end

function AssignmentView:_onCustomRefreshInputCallback(hover)
	if not hover and self._openRefreshPanel then
		self:_onClickbtnSelectTime()
	end
end

function AssignmentView:_getDefaultTims()
	local times = AssignmentController.instance:getLastSavefreshTime()
	local hasRefreshTime = AssignmentModel.instance:getRefreshTimes(1)
	local targetTime = hasRefreshTime + times
	local costCfg

	for i = targetTime, hasRefreshTime + 1, -1 do
		costCfg = AssignmentConfig.instance:getPetDispatchRefreshConfig(1, i)
		times = targetTime - hasRefreshTime

		if costCfg then
			break
		end
	end

	if not costCfg then
		return "1"
	end

	local hasNum = MaterialMgr.getMatCount(costCfg.consume)
	local matType, matId, matNum = MaterialMgr.getMatParams(costCfg.consume)
	local cost = AssignmentConfig.instance:getPetDispatchRefreshTotalCost(1, times, hasRefreshTime)

	if hasNum < cost then
		local modTimes = 1

		for i = times - 1, 1, -1 do
			costCfg = AssignmentConfig.instance:getPetDispatchRefreshConfig(1, i)
			cost = AssignmentConfig.instance:getPetDispatchRefreshTotalCost(1, i, hasRefreshTime)

			if cost <= hasNum then
				modTimes = i

				break
			end
		end

		return tostring(modTimes)
	else
		return tostring(times)
	end
end

return AssignmentView
