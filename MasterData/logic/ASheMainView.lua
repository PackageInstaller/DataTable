-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/ASheMainView.lua

module("logic.extensions.ashechallenge.view.ASheMainView", package.seeall)

local ASheMainView = class("ASheMainView", ViewComponent)

function ASheMainView:ctor()
	ASheMainView.super.ctor(self)
end

function ASheMainView:buildUI()
	ASheMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._con = self:getGo("con")
	self._imgRecZdl = self:getGo("zdl/imgRecZdl"):GetComponent(ComponentType.UIImgNumeralText)
	self._btnLevel1 = self:getBtn("level/btnCol/btn1")
	self._btnLevel2 = self:getBtn("level/btnCol/btn2")
	self._btnLevel3 = self:getBtn("level/btnCol/btn3")
	self._select1 = goutil.findChild(self._btnLevel1.gameObject, "select")
	self._select2 = goutil.findChild(self._btnLevel2.gameObject, "select")
	self._select3 = goutil.findChild(self._btnLevel3.gameObject, "select")
	self._nameColorChange1 = goutil.findChild(self._btnLevel1.gameObject, "txtName"):GetComponent(ComponentType.UITextColorChange)
	self._nameColorChange2 = goutil.findChild(self._btnLevel2.gameObject, "txtName"):GetComponent(ComponentType.UITextColorChange)
	self._nameColorChange3 = goutil.findChild(self._btnLevel3.gameObject, "txtName"):GetComponent(ComponentType.UITextColorChange)
	self.scrollerGo = self:getGo("level/rewardCol/tableview")
	self.cellGo = self:getGo("level/rewardCol/rewardCell")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollRectTrans = self.scrollerGo:GetComponent(goutil.Type_RectTransform)
	self._txtTime = self:getTxt("time/txt")
	self._txtDailyBuff = self:getTxt("infoCol/dailyBuff/txtDesc")
	self._txtPassDesc = self:getTxt("infoCol/passDesc/txtDesc")
	self._txtRemain = self:getTxt("infoCol/txtRemain")
	self._btnBlessBuff1 = self:getBtn("infoCol/blessBuff/btnBuff1")
	self._btnBlessBuff2 = self:getBtn("infoCol/blessBuff/btnBuff2")
	self._blessBuffIcon1 = self:getGo("infoCol/blessBuff/btnBuff1/buffIcon")
	self._blessBuffIcon2 = self:getGo("infoCol/blessBuff/btnBuff2/buffIcon")
	self._enemyItemList = {}

	for i = 1, 9 do
		local item = {}

		item.go = self:getGo(string.format("infoCol/enemyCol/formation/cell_%d", i))
		item.con = self:getGo(string.format("infoCol/enemyCol/formation/cell_%d/con", i))

		table.insert(self._enemyItemList, item)
	end

	self._btnRefresh = self:getBtn("infoCol/btnRefresh")
	self._btnChallenge = self:getBtn("infoCol/btnChallenge")
	self._goldBarCon = self:getGo("goldBarCon")
	self._redPoint = self:getGo("infoCol/btnChallenge/redpoint")
end

function ASheMainView:bindEvents()
	ASheMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnLevel1:AddClickListener(self._onClickLevel1, self)
	self._btnLevel2:AddClickListener(self._onClickLevel2, self)
	self._btnLevel3:AddClickListener(self._onClickLevel3, self)
	self._btnBlessBuff1:AddClickListener(self._onClickBlessBuff1, self)
	self._btnBlessBuff2:AddClickListener(self._onClickBlessBuff2, self)
	self._btnRefresh:AddClickListener(self._onClickRefresh, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function ASheMainView:unbindEvents()
	ASheMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnLevel1:RemoveClickListener()
	self._btnLevel2:RemoveClickListener()
	self._btnLevel3:RemoveClickListener()
	self._btnBlessBuff1:RemoveClickListener()
	self._btnBlessBuff2:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function ASheMainView:onEnter()
	ASheMainView.super.onEnter(self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onChangeDay, self)
	GlobalDispatcher:addListener(GlobalNotify.ASheChallengeInfoRes, self._onChallengeInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ASheChallengeSelectBuffRes, self._onSelectBuffRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ASheChallengeRefreshRes, self._onRefreshRes, self)
	self:_resetGos()
	self:_getActivityId()

	self._activityType = ASheModel.instance:getActivityType()
	self._cfgActivity = ASheConfig.instance:getActivityCfg(self._activityId)
	self._difficultyPlanId = self._cfgActivity.difficultyPlanId
	self._dailyBuffPlanId = self._cfgActivity.dailyBuffPlanId
	self._selectBuffPlanId = self._cfgActivity.selectBuffPlanId
	self._dailyChallengeTimes = self._cfgActivity.dailyChallengeTimes
	self._raceId = ASheConfig.instance:getClientCommonValue(self._activityId, "RACE_ID", true)
	self._tabId = 0

	self:_initView()
	ASheChallengeAgent.instance:sendPM_ASheChallengeInfoReq(self._activityId)
end

function ASheMainView:onExit()
	ASheMainView.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._onChangeDay, self)
	GlobalDispatcher:removeListener(GlobalNotify.ASheChallengeInfoRes, self._onChallengeInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ASheChallengeSelectBuffRes, self._onSelectBuffRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ASheChallengeRefreshRes, self._onRefreshRes, self)
	self.scrollList:dispose()
	self:_resetRoleModel()
	self:_clearHeadIcon()
	self:_clearBlessBuff()
end

function ASheMainView:_onClickTip()
	local key = ASheConfig.instance:getClientCommonValue(self._activityId, "RULE")

	UIStateManager.instance:push(ViewName.RulesView, key)
end

function ASheMainView:_onClickLevel1()
	self:_changeLevelTab(1)
end

function ASheMainView:_onClickLevel2()
	self:_changeLevelTab(2)
end

function ASheMainView:_onClickLevel3()
	self:_changeLevelTab(3)
end

function ASheMainView:_onClickBlessBuff1()
	UIStateManager.instance:push(ViewName.ASheBuffSelectView, self._activityId, self._selectBuffPlanId)
end

function ASheMainView:_onClickBlessBuff2()
	UIStateManager.instance:push(ViewName.ASheBuffSelectView, self._activityId, self._selectBuffPlanId)
end

function ASheMainView:_onClickRefresh()
	if ASheController.instance:getLeftChallengeTimes(self._activityId) <= 0 then
		FloatWordMgr.instance:show("今日无挑战次数，无法刷新敌阵。")

		return
	end

	local prizeStr = ASheConfig.instance:getCommonValue("REFRESH_ENEMY_COST")
	local matType, id, matNum = MaterialMgr.getMatParams(prizeStr)
	local itemStr = MaterialMgr.getContentMatCfg(matType, id, 40, -8, MaterialMgr.ICON_TYPE_ICON)
	local content = string.format("确定花费%s*%d刷新敌阵吗？", itemStr, matNum)

	local function okFunc()
		ASheChallengeAgent.instance:sendPM_ASheChallengeRefreshReq(self._activityId, self._tabId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, id, matNum, content, okFunc, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function ASheMainView:_onClickChallenge()
	if ASheController.instance:getLeftChallengeTimes(self._activityId) <= 0 then
		FloatWordMgr.instance:show("今日无挑战次数。")

		return
	end

	if not ASheModel.instance:isSelectedBuffs(self._activityId) then
		FloatWordMgr.instance:show("需要设置斗场祝福后才可以开始挑战。")

		return
	end

	local creepsMasterId = ASheController.instance:getCreepsMasterId(self._activityId, self._difficultyPlanId, self._tabId)

	if creepsMasterId == 0 then
		FloatWordMgr.instance:show("敌阵不存在")

		return
	end

	self:_openMissionView(creepsMasterId)
end

function ASheMainView:_openMissionView(creepsMasterId)
	ASheController.instance:openMissionView(self._activityId, self._tabId, creepsMasterId, self:_getEnterView(), self:_getMainView())
end

function ASheMainView:_onChangeDay()
	self:_updateDailyBuffDesc()
end

function ASheMainView:_onChallengeInfoRes()
	local tabId = ASheModel.instance:getLastFinishDifficultyId(self._activityId)

	if tabId > 0 then
		self:_showRoleModel(tabId)
		self:_changeLevelTab(tabId)
		self:_updatePassDesc(tabId)
		self:_updateBlessBuff()
		self:_updateRemainNum()
	else
		self:_showRoleModel(self._tabId)
		self:_updateEnemyFmtHeadIcon(self._tabId)
		self:_updatePassDesc(self._tabId)
		self:_updateBlessBuff()
		self:_updateRemainNum()
	end

	self:_updateChallengeRedPoint()
end

function ASheMainView:_onSelectBuffRes()
	self:_updateBlessBuff()
end

function ASheMainView:_onRefreshRes()
	self:_showRoleModel(self._tabId)
	self:_updateEnemyFmtHeadIcon(self._tabId)
	self:_updatePassDesc(self._tabId)
end

function ASheMainView:_updateCell(view, cell, data, tag)
	local itemPos = goutil.findChild(cell, "itemPos")

	MaterialMgr.setCellByCfg(data, itemPos)
end

function ASheMainView:_clearCell(cell)
	local itemPos = goutil.findChild(cell, "itemPos")

	MaterialMgr.resetAll(itemPos)
end

function ASheMainView:_resetGos()
	goutil.setActive(self._select1, false)
	goutil.setActive(self._select2, false)
	goutil.setActive(self._select3, false)
	goutil.setActive(self._blessBuffIcon1, false)
	goutil.setActive(self._blessBuffIcon2, false)
	goutil.setActive(self._redPoint, false)
	self._nameColorChange1:SetState(0)
	self._nameColorChange2:SetState(0)
	self._nameColorChange3:SetState(0)
end

function ASheMainView:_initView()
	self:_initActivityTime()
	self:_updateDailyBuffDesc()
	self:_updateBlessBuff()
	self:_updateRemainNum()
	self:_changeLevelTab(1)
	self:_setGoldBarCon()
	self:_updateChallengeRedPoint()
end

function ASheMainView:_initActivityTime()
	local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function ASheMainView:_showRoleModel(tabId)
	local curFaceId = ASheController.instance:getShowRaceId(self._activityId, self._difficultyPlanId, tabId)
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function ASheMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function ASheMainView:_changeLevelTab(tabId)
	if self._tabId == tabId then
		return
	end

	self._tabId = tabId

	self:_showRoleModel(tabId)
	self:_updatePowerNum(tabId)
	self:_updateBtns(tabId)
	self:_updatePrizes(tabId)
	self:_updateEnemyFmtHeadIcon(tabId)
	self:_updatePassDesc(tabId)
end

function ASheMainView:_updatePowerNum(tabId)
	local cfg = ASheConfig.instance:getDifficultyCfg(self._difficultyPlanId, tabId)

	if cfg then
		self._imgRecZdl:SetNum(cfg.recPower)
	else
		self._imgRecZdl:SetNum(0)
	end
end

function ASheMainView:_updateBtns(tabId)
	goutil.setActive(self._select1, tabId == ASheModel.LevelEnum.Simple)
	goutil.setActive(self._select2, tabId == ASheModel.LevelEnum.Medium)
	goutil.setActive(self._select3, tabId == ASheModel.LevelEnum.Hard)
	self._nameColorChange1:SetState(tabId == ASheModel.LevelEnum.Simple and 1 or 0)
	self._nameColorChange2:SetState(tabId == ASheModel.LevelEnum.Medium and 1 or 0)
	self._nameColorChange3:SetState(tabId == ASheModel.LevelEnum.Hard and 1 or 0)
end

function ASheMainView:_updatePrizes(tabId)
	local cfg = ASheConfig.instance:getDifficultyCfg(self._difficultyPlanId, tabId)

	if cfg then
		local datas = MaterialMgr.changeItemStrArr(cfg.prize)
		local count = #datas

		Framework.TransformUtil.SetAnchoredPos(self._scrollRectTrans, count == 1 and -60 or count == 2 and -124 or -181, 35)
		self.scrollList:reloadData(datas)
	end
end

function ASheMainView:_updateEnemyFmtHeadIcon(tabId)
	printInfo("test 更新敌阵1", self._difficultyPlanId, tabId)
	self:_resetHeadList()

	local creepsMasterId = ASheController.instance:getCreepsMasterId(self._activityId, self._difficultyPlanId, tabId)

	printInfo("test 更新敌阵2", self._difficultyPlanId, tabId, creepsMasterId)

	local cfgCreepsList = ASheConfig.instance:getCreepsList(creepsMasterId)

	for i, cfgEnemy in ipairs(cfgCreepsList) do
		local item = self._enemyItemList[cfgEnemy.posId]

		if item.go then
			goutil.setActive(item.go, true)
			GameUtil.setLocalScale(item.con, 0.5, 0.5, 0.5)

			local proxy = MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, item.con)
		end
	end
end

function ASheMainView:_updateDailyBuffDesc()
	self._txtDailyBuff.text = ASheController.instance:getDailyBuffDesc(self._activityId)
end

function ASheMainView:_updatePassDesc(tabId)
	local creepsMasterId = ASheController.instance:getCreepsMasterId(self._activityId, self._difficultyPlanId, self._tabId)
	local cfgTeam = ASheConfig.instance:getTeam(creepsMasterId)

	if cfgTeam then
		if not cfgTeam.winId then
			local winId = 0

			self._txtPassDesc.text = BattleSettlementController.instance:getDescByWinId(winId)
		end
	end
end

function ASheMainView:_updateRemainNum()
	local leftNum = ASheController.instance:getLeftChallengeTimes(self._activityId)

	if leftNum > 0 then
		if not ColorConst.Green3 then
			local colorStr = ColorConst.Red

			self._txtRemain.text = string.format("今日剩余挑战次数：<color=#%s>%d</color>", colorStr, leftNum)
		end
	end
end

function ASheMainView:_updateBlessBuff()
	local buffIds = ASheModel.instance:getSelectedBuffs(self._activityId)
	local count = #buffIds
	local isSelected = count >= 2

	goutil.setActive(self._blessBuffIcon1, isSelected)
	goutil.setActive(self._blessBuffIcon2, isSelected)

	if isSelected then
		local buffId1 = buffIds[1]
		local buffCfg1 = ASheConfig.instance:getSelectBuff(self._selectBuffPlanId, buffId1)

		if buffCfg1 then
			uGuiUtil.setSpriteToImage(self._blessBuffIcon1, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(buffCfg1.iconName))
		end

		local buffId2 = buffIds[2]
		local buffCfg2 = ASheConfig.instance:getSelectBuff(self._selectBuffPlanId, buffId2)

		if buffCfg2 then
			uGuiUtil.setSpriteToImage(self._blessBuffIcon2, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(buffCfg2.iconName))
		end
	else
		self:_clearBlessBuff()
	end
end

function ASheMainView:_updateChallengeRedPoint()
	local isShow = ASheController.instance:getLeftChallengeTimes(self._activityId) > 0

	goutil.setActive(self._redPoint, isShow)
end

function ASheMainView:_setGoldBarCon()
	local value = ASheConfig.instance:getClientCommonValue(self._activityId, "SHOW_COIN")
	local matMo = string.splitToNumber(value, ":")
	local name = matMo[1] .. ":" .. matMo[2]
	local objList = {
		{
			showAdd = true,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function ASheMainView:_clearBlessBuff()
	MaterialMgr.clearIcon(self._blessBuffIcon1)
	MaterialMgr.clearIcon(self._blessBuffIcon2)
end

function ASheMainView:_resetHeadList()
	for i, v in ipairs(self._enemyItemList) do
		goutil.setActive(v.go, false)
	end
end

function ASheMainView:_clearHeadIcon()
	for i, v in ipairs(self._enemyItemList) do
		MaterialMgr.resetAll(v.con)
	end
end

function ASheMainView:_getActivityId()
	self._activityId = ASheModel.instance:getActivityId()
end

function ASheMainView:_getEnterView()
	return ViewName.ASheEnterView
end

function ASheMainView:_getMainView()
	return ViewName.ASheMainView
end

return ASheMainView
