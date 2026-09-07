local JiuJiuExpeditionGameView = class("JiuJiuExpeditionGameView", import("...base.BaseUI"))
local var_0_1 = 50
local var_0_2 = 153
local var_0_3 = 175
local var_0_4 = 16

function JiuJiuExpeditionGameView:getUIName()
	return "JiuJiuExpeditionGameView"
end

function JiuJiuExpeditionGameView:init()
	self.isTweening = 0

	return
end

function JiuJiuExpeditionGameView:onBackPressed()
	if self.isTweening > 0 then
		return
	end

	self:emit(JiuJiuExpeditionGameView.ON_BACK_PRESSED)

	return
end

function JiuJiuExpeditionGameView:didEnter()
	self.activityId = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_EXPEDITION).id

	if not self.activityId then
		self:closeView()

		return
	end

	self.stgDatas = pg.activity_template[self.activityId].config_data
	self.stgAmount = #pg.activity_template[self.activityId].config_data
	self.uiAtlasName = self:getUIName()

	local var_4_0 = findTF(self._tf, "ad")

	onButton(self, findTF(var_4_0, "back"), function()
		if self.isTweening > 0 then
			return
		end

		self:closeView()

		return
	end, SFX_CONFIRM)

	self.tplStgTag = findTF(var_4_0, "posStgTag/tplStgTag")
	self.bookUnLock = findTF(var_4_0, "leftUI/bookUnLock")

	setActive(self.bookUnLock, false)

	self.amountText = findTF(var_4_0, "rightUI/amount/text")

	setText(self.amountText, "")

	self.stgText = findTF(var_4_0, "upUI/labelStg")
	self.posCharactor = findTF(var_4_0, "map/posChar")
	self.charactor = findTF(var_4_0, "map/posChar/charactor")
	self.tplBaoxiang = findTF(var_4_0, "map/posChar/tplBaoxiang")

	setActive(self.tplBaoxiang, false)

	self.baoxiangList = {}
	self.poolBaoxiangList = {}
	self.stgProgress = findTF(var_4_0, "upUI/labelStgProgress")

	setText(self.stgProgress, "0%")

	self.posStgTag = findTF(var_4_0, "posStgTag")
	self.stgTags = {}

	for iter_4_0 = 1, self.stgAmount do
		local var_4_1 = tf(instantiate(self.tplStgTag))

		setImageSprite(findTF(var_4_1, "open/desc"), GetSpriteFromAtlas("ui/" .. self.uiAtlasName .. "_atlas", "stg" .. iter_4_0), true)
		setParent(var_4_1, self.posStgTag)
		setActive(var_4_1, true)
		table.insert(self.stgTags, var_4_1)

		local var_4_2 = iter_4_0

		onButton(self, var_4_1, function()
			if self.level < var_4_2 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("jiujiu_expedition_stg_tip"))
			else
				self:changeSelectTag(var_4_2)
			end

			return
		end, SFX_CONFIRM)
	end

	self.mapCloseBg = findTF(var_4_0, "map/closeBg")
	self.mapOpenBg = findTF(var_4_0, "map/openBg/bg")
	self.mapClearBg = findTF(var_4_0, "map/openBg/clear")
	self.enterBossUI = findTF(self._tf, "pop/enterBossUI")
	self.posMask = findTF(var_4_0, "map/openBg/posMask")
	self.tplBgMask = findTF(var_4_0, "map/openBg/posMask/tplMask")
	self.poolMasks = {}
	self.posBottom = findTF(var_4_0, "map/posBottom")
	self.tplBottomGrid = findTF(var_4_0, "map/posBottom/tplBottomGrid")
	self.poolBottomGrids = {}
	self.posUp = findTF(var_4_0, "map/posUp")
	self.tplUpGrid = findTF(var_4_0, "map/posUp/tplUpGrid")
	self.poolUpGrids = {}
	self.mapDic = {}

	onButton(self, findTF(self.enterBossUI, "sure"), function()
		self:enterBattle()

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(self.enterBossUI, "cancel"), function()
		self:hideEnterBossUI()

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(var_4_0, "help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_jiujiu_expedition_game.tip
		})

		return
	end, SFX_CONFIRM)
	pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 0,
		activity_id = self.activityId
	})
	pg.BgmMgr.GetInstance():ContinuePlay()

	return
end

function JiuJiuExpeditionGameView:activityUpdate()
	local var_10_0 = getProxy(ActivityProxy):getActivityById(self.activityId)

	if var_10_0.data1 == 0 then
		self.level = self.stgAmount + 1 or var_10_0.data1
	end

	self.complete = var_10_0.data1 == 0
	self.charPos = var_10_0.data2
	self.tickets = var_10_0.data3
	self.gridTypes = var_10_0.data1_list

	if PLATFORM_CODE == PLATFORM_JP then
		local var_10_1, var_10_2, var_10_3, var_10_4 = JiuJiuExpeditionCollectionMediator.GetCollectionData()

		if self.getRewardIndex ~= var_10_3 then
			self.getRewardIndex = var_10_3

			if var_10_4 < var_10_3 then
				self:showBookUnLock()
			else
				setActive(self.bookUnLock, false)
			end
		end
	end

	self.completeBossId = var_10_0.data4
	self.inMessage = false

	if #self.gridTypes == 0 then
		self.curSelectLevel = self.stgAmount
		self.chequerConfig = pg.activity_event_chequer[self.stgDatas[self.curSelectLevel]]
		self.chequerMap = Clone(self.chequerConfig.chequer_map)

		for iter_10_0 = 1, self.chequerMap[1] * self.chequerMap[2] do
			table.insert(self.gridTypes, ActivityConst.EXPEDITION_TYPE_GOT)
		end

		local var_10_5

		if self.level <= self.stgAmount then
			var_10_5 = self.level or self.stgAmount
		end
	end

	self:changeSelectTag(var_10_5)

	return
end

function JiuJiuExpeditionGameView:showBookUnLock()
	setImageAlpha(self.bookUnLock, 1)
	setActive(self.bookUnLock, true)

	if LeanTween.isTweening(go(self.bookUnLock)) then
		LeanTween.cancel(go(self.bookUnLock))
	end

	LeanTween.delayedCall(go(self.bookUnLock), 3, System.Action(function()
		LeanTween.alpha(rtf(self.bookUnLock), 0, 2)

		return
	end))

	return
end

function JiuJiuExpeditionGameView:showBaoxiang(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self.isTweening = self.isTweening + 1

	LeanTween.delayedCall(go(arg_13_4), 0.5, System.Action(function()
		local var_14_0, var_14_1 = self:getPosition(arg_13_1, arg_13_2)

		arg_13_4.localPosition = Vector3(var_14_0, var_14_1 + 50, -1)

		setActive(arg_13_4, true)
		setActive(findTF(arg_13_4, "baoxiang_guan"), true)
		LeanTween.moveLocal(go(arg_13_4), Vector3(var_14_0, var_14_1, -1), 0.2)

		self.isTweening = self.isTweening - 1

		onButton(self, arg_13_4, function()
			if not self.isMoveChar and not self.isOpenBaoxiang then
				self.isOpenBaoxiang = true

				self:openBaoxiang(arg_13_4, arg_13_3)
			end

			return
		end)

		return
	end))

	return
end

function JiuJiuExpeditionGameView:openBaoxiang(arg_16_1, arg_16_2)
	setActive(findTF(arg_16_1, "baoxiang_guan"), false)
	setActive(findTF(arg_16_1, "baoxiang_kai"), true)

	self.isTweening = self.isTweening + 1

	LeanTween.delayedCall(go(arg_16_1), 1, System.Action(function()
		self.isTweening = self.isTweening - 1

		self:getGridReward(arg_16_2)

		for iter_17_0 = #self.baoxiangList, 1, -1 do
			if self.baoxiangList[iter_17_0].tf == arg_16_1 then
				table.remove(self.baoxiangList, iter_17_0)
			end
		end

		self:returnBaoxiang(arg_16_1)

		self.isOpenBaoxiang = false

		return
	end))

	return
end

function JiuJiuExpeditionGameView:changeSelectTag(arg_18_1)
	self.curSelectLevel = arg_18_1

	self:selectTagChange(arg_18_1 ~= self.curSelectLevel)

	return
end

function JiuJiuExpeditionGameView:selectTagChange(arg_19_1)
	if self.curSelectLevel > self.level then
		self:changeSelectTag(self.level)

		return
	end

	self:clear(arg_19_1)
	self:updateConfig()
	self:updateTag()
	self:updateMap()
	self:updateGridDatas()
	self:updateCharactor()
	self:updateUI()

	return
end

function JiuJiuExpeditionGameView:updateCharactor()
	if not self.complete and self.curSelectLevel == self.level and self.charPos > 0 then
		if self.charPos ~= self.curCharPos then
			self.curCharPos = self.charPos

			local var_20_0 = self:getMapByIndex(self.charPos)

			if var_20_0 then
				self.isMoveChar = true

				local var_20_1, var_20_2 = self:getPosition(var_20_0.v, var_20_0.h)

				self:moveChar(var_20_1, var_20_2, function()
					self.isMoveChar = false

					self:checkExpeditionMap()

					return
				end)
			end
		else
			self:checkExpeditionMap()
		end
	else
		self.curCharPos = nil

		self:hideChar()
	end

	return
end

function JiuJiuExpeditionGameView:checkExpeditionMap()
	if not self.expeditionMap or bit.band(self.expeditionMap.type, ActivityConst.EXPEDITION_TYPE_BAOXIANG) ~= 0 then
		-- block empty
	elseif bit.band(self.expeditionMap.type, ActivityConst.EXPEDITION_TYPE_OPEN) ~= 0 then
		self:getGridReward(self.expeditionMap.mapIndex)
	elseif bit.band(self.expeditionMap.type, ActivityConst.EXPEDITION_TYPE_BOSS) ~= 0 then
		if self.expeditionMap.mapIndex == self.charPos or self.expeditionMap.mapIndex == self.completeBossId then
			self:onClickGrid(self.expeditionMap)
		end
	else
		self:onClickGrid(self.expeditionMap)
	end

	return
end

function JiuJiuExpeditionGameView:updateUI()
	setText(self.amountText, "x" .. self.tickets)
	setText(self.stgText, (i18n("jiujiu_expedition_game_stg_desc", self.curSelectLevel or 1)))

	if self.level > self.curSelectLevel then
		setText(self.stgProgress, "100%")
	else
		local var_23_0 = 0

		for iter_23_0 = 1, #self.gridTypes do
			if bit.band(self.gridTypes[iter_23_0], ActivityConst.EXPEDITION_TYPE_GOT) ~= 0 then
				var_23_0 = var_23_0 + 1
			end
		end

		setText(self.stgProgress, math.floor(var_23_0 / self.totalNums * 100) .. "%")
	end

	return
end

function JiuJiuExpeditionGameView:updateGridDatas()
	if self.curSelectLevel == self.level then
		for iter_24_0 = 1, #self.gridTypes do
			local var_24_0 = self:getMapActivityType(self.gridTypes[iter_24_0])

			if var_24_0 == ActivityConst.EXPEDITION_TYPE_OPEN then
				self.expeditionMap = self:getMapByPosNum(iter_24_0)
			elseif var_24_0 == ActivityConst.EXPEDITION_TYPE_BOSS and (self.completeBossId == iter_24_0 or self.charPos == iter_24_0) then
				self.expeditionMap = self:getMapByPosNum(iter_24_0)
			end
		end
	end

	for iter_24_1 = 1, #self.mapDic do
		local var_24_1 = self.mapDic[iter_24_1]

		if self.curSelectLevel < self.level then
			self:setMapGridType(var_24_1, ActivityConst.EXPEDITION_TYPE_GOT)
		else
			local var_24_2 = self:getMapActivityType(self.gridTypes[var_24_1.mapIndex])
			local var_24_3 = bit.rshift(self.gridTypes[var_24_1.mapIndex], 4)

			if (self.charPos <= 0 or not self.charPos) and self.tickets > 0 then
				self:setMapGridType(var_24_1, var_0_4)
			elseif var_24_2 == ActivityConst.EXPEDITION_TYPE_LOCK and self:getGridSideOpen(var_24_1) and self.tickets > 0 then
				self:setMapGridType(var_24_1, var_0_4)
			else
				self:setMapGridType(var_24_1, var_24_2, var_24_3)
			end
		end
	end

	return
end

function JiuJiuExpeditionGameView:getMapActivityType(arg_25_1)
	if bit.band(arg_25_1, ActivityConst.EXPEDITION_TYPE_GOT) == ActivityConst.EXPEDITION_TYPE_GOT then
		return ActivityConst.EXPEDITION_TYPE_GOT
	elseif bit.band(arg_25_1, ActivityConst.EXPEDITION_TYPE_BOSS) == ActivityConst.EXPEDITION_TYPE_BOSS then
		return ActivityConst.EXPEDITION_TYPE_BOSS
	elseif bit.band(arg_25_1, ActivityConst.EXPEDITION_TYPE_BAOXIANG) == ActivityConst.EXPEDITION_TYPE_BAOXIANG then
		return ActivityConst.EXPEDITION_TYPE_BAOXIANG
	elseif bit.band(arg_25_1, ActivityConst.EXPEDITION_TYPE_OPEN) == ActivityConst.EXPEDITION_TYPE_OPEN then
		return ActivityConst.EXPEDITION_TYPE_OPEN
	end

	return ActivityConst.EXPEDITION_TYPE_LOCK
end

function JiuJiuExpeditionGameView:updateConfig()
	self.chequerConfig = pg.activity_event_chequer[self.stgDatas[self.curSelectLevel]]
	self.chequerMap = Clone(self.chequerConfig.chequer_map)

	local var_26_0 = Clone(self.chequerConfig.empty_grid)

	self.emptyPosNums = {}

	for iter_26_0 = 1, #var_26_0 do
		table.insert(self.emptyPosNums, (self:getPosNum(var_26_0[iter_26_0][1], var_26_0[iter_26_0][2])))
	end

	self.totalNums = self.chequerMap[1] * self.chequerMap[2] - #self.emptyPosNums

	return
end

function JiuJiuExpeditionGameView:getGridSideOpen(arg_27_1)
	local var_27_0 = arg_27_1.h % 2 == 1 and {
		arg_27_1.posNum - 1,
		arg_27_1.posNum + 1,
		arg_27_1.posNum - self.chequerMap[2],
		arg_27_1.posNum + self.chequerMap[2],
		arg_27_1.posNum + self.chequerMap[2] - 1,
		arg_27_1.posNum + self.chequerMap[2] + 1
	} or {
		arg_27_1.posNum - 1,
		arg_27_1.posNum + 1,
		arg_27_1.posNum - self.chequerMap[2],
		arg_27_1.posNum + self.chequerMap[2],
		arg_27_1.posNum - self.chequerMap[2] - 1,
		arg_27_1.posNum - self.chequerMap[2] + 1
	}
	local var_27_1 = arg_27_1.v

	for iter_27_0 = #var_27_0, 1, -1 do
		if math.abs(math.ceil(var_27_0[iter_27_0] / self.chequerMap[2]) - var_27_1) > 1 or math.abs((var_27_0[iter_27_0] - 1) % self.chequerMap[2] + 1 - arg_27_1.h) > 1 then
			table.remove(var_27_0, iter_27_0)
		end
	end

	for iter_27_1 = 1, #var_27_0 do
		local var_27_3 = self:getMapByPosNum(var_27_0[iter_27_1])

		if var_27_3 and self:getMapIndexType(var_27_3.mapIndex) == ActivityConst.EXPEDITION_TYPE_GOT then
			return true
		end
	end

	return false
end

function JiuJiuExpeditionGameView:getMapByPosNum(arg_28_1)
	if arg_28_1 <= 0 then
		return nil
	end

	if arg_28_1 > self.chequerMap[2] * self.chequerMap[1] then
		return nil
	end

	for iter_28_0 = 1, #self.mapDic do
		if self.mapDic[iter_28_0].posNum == arg_28_1 then
			return self.mapDic[iter_28_0]
		end
	end

	return nil
end

function JiuJiuExpeditionGameView:getMapByIndex(arg_29_1)
	for iter_29_0 = 1, #self.mapDic do
		if self.mapDic[iter_29_0].mapIndex == arg_29_1 then
			return self.mapDic[iter_29_0]
		end
	end

	return nil
end

function JiuJiuExpeditionGameView:getMapIndexType(arg_30_1)
	return self:getMapActivityType(self.gridTypes[arg_30_1])
end

function JiuJiuExpeditionGameView:updateMap()
	setImageSprite(self.mapCloseBg, GetSpriteFromAtlas("ui/" .. self.uiAtlasName .. "_atlas", "map_close_" .. self.chequerConfig.difficult), true)
	setImageSprite(self.mapOpenBg, GetSpriteFromAtlas("ui/" .. self.uiAtlasName .. "_atlas", "map_open_" .. self.chequerConfig.difficult), true)
	setImageSprite(self.mapClearBg, GetSpriteFromAtlas("ui/" .. self.uiAtlasName .. "_atlas", "map_open_" .. self.chequerConfig.difficult), true)

	self.mapDic = {}

	local var_31_0 = 0

	for iter_31_0 = 1, self.chequerMap[1] do
		for iter_31_1 = 1, self.chequerMap[2] do
			local var_31_1 = self:getPosNum(iter_31_0, iter_31_1)

			var_31_0 = var_31_0 + 1

			if not table.contains(self.emptyPosNums, var_31_1) then
				local var_31_2 = self:getMask()
				local var_31_3 = self:getBottomGrid()
				local var_31_4 = self:getUpGrid()

				self:setMapTfPosition(var_31_2, iter_31_0, iter_31_1)
				self:setMapTfPosition(var_31_3, iter_31_0, iter_31_1)
				self:setMapTfPosition(var_31_4, iter_31_0, iter_31_1)

				local var_31_5 = {
					mask = var_31_2,
					bottomGrid = var_31_3,
					upGrid = var_31_4,
					v = iter_31_0,
					h = iter_31_1,
					posNum = var_31_1,
					mapIndex = var_31_0
				}

				onButton(self, var_31_4, function()
					self:onClickGrid(var_31_5)

					return
				end, SFX_CONFIRM)
				table.insert(self.mapDic, var_31_5)
			end
		end
	end

	return
end

function JiuJiuExpeditionGameView:setMapGridType(arg_33_1, arg_33_2, arg_33_3)
	arg_33_1.type = arg_33_2
	arg_33_1.params = arg_33_3

	setActive(arg_33_1.bottomGrid, true)

	local var_33_0 = findTF(arg_33_1.upGrid, "select")
	local var_33_1 = findTF(arg_33_1.upGrid, "boss")
	local var_33_2 = findTF(arg_33_1.upGrid, "bottomLight")
	local var_33_3 = findTF(arg_33_1.upGrid, "outLine")

	setActive(arg_33_1.mask, false)
	setActive(var_33_0, false)
	setActive(var_33_3, false)
	setActive(var_33_1, false)
	setActive(var_33_2, false)

	if arg_33_2 == ActivityConst.EXPEDITION_TYPE_OPEN or arg_33_2 == ActivityConst.EXPEDITION_TYPE_GOT then
		setActive(var_33_0, true)
		arg_33_1.upGrid:SetAsLastSibling()
	elseif arg_33_2 == ActivityConst.EXPEDITION_TYPE_LOCK then
		setActive(arg_33_1.mask, true)
		setActive(var_33_3, true)
	elseif arg_33_2 == ActivityConst.EXPEDITION_TYPE_BAOXIANG then
		setActive(var_33_0, true)
		self:addBaoXiang(arg_33_1)
		arg_33_1.upGrid:SetAsLastSibling()
	elseif arg_33_2 == ActivityConst.EXPEDITION_TYPE_BOSS then
		setActive(var_33_0, true)
		setActive(var_33_1, true)
		arg_33_1.upGrid:SetAsLastSibling()
	elseif arg_33_2 == var_0_4 then
		setActive(arg_33_1.mask, true)
		setActive(var_33_0, true)
		setActive(var_33_2, true)
		arg_33_1.upGrid:SetAsLastSibling()
	end

	return
end

function JiuJiuExpeditionGameView:addBaoXiang(arg_34_1)
	for iter_34_0 = 1, #self.baoxiangList do
		if self.baoxiangList[iter_34_0].mapIndex == arg_34_1.mapIndex then
			return
		end
	end

	local var_34_0 = self:getBaoxiang()

	self:showBaoxiang(arg_34_1.v, arg_34_1.h, arg_34_1.mapIndex, var_34_0)
	table.insert(self.baoxiangList, {
		tf = var_34_0,
		mapIndex = arg_34_1.mapIndex
	})

	return
end

function JiuJiuExpeditionGameView:setMapTfPosition(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0, var_35_1 = self:getPosition(arg_35_2, arg_35_3)

	arg_35_1.localPosition = Vector3(var_35_0, var_35_1, 0)

	return
end

function JiuJiuExpeditionGameView:updateTag()
	for iter_36_0 = 1, #self.stgTags do
		local var_36_0 = self.stgTags[iter_36_0]

		if iter_36_0 <= self.level then
			setActive(findTF(var_36_0, "open"), true)
			setActive(findTF(var_36_0, "close"), false)
		else
			setActive(findTF(var_36_0, "open"), false)
			setActive(findTF(var_36_0, "close"), true)
		end

		if iter_36_0 == self.curSelectLevel then
			setActive(findTF(var_36_0, "open/on"), true)
			setActive(findTF(var_36_0, "open/off"), false)
		else
			setActive(findTF(var_36_0, "open/on"), false)
			setActive(findTF(var_36_0, "open/off"), true)
		end
	end

	return
end

function JiuJiuExpeditionGameView:onClickGrid(arg_37_1)
	if arg_37_1.type == var_0_4 then
		if not self.isMoveChar then
			self:openGrid(arg_37_1.mapIndex)
		end
	elseif arg_37_1.type == ActivityConst.EXPEDITION_TYPE_BOSS then
		self.bossId = arg_37_1.params

		if self.completeBossId == arg_37_1.mapIndex then
			self:getGridReward(self.completeBossId)

			if PLATFORM_CODE == PLATFORM_JP then
				self:showBookUnLock()
			end
		elseif not self.isMoveChar and self.isTweening == 0 and not self.isOpenBaoxiang then
			self:showEnterBossUI()
		end
	elseif arg_37_1.type == ActivityConst.EXPEDITION_TYPE_LOCK and self.tickets <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("jiujiu_expedition_amount_tip"))
	end

	return
end

function JiuJiuExpeditionGameView:moveChar(arg_38_1, arg_38_2, arg_38_3)
	if LeanTween.isTweening(go(self.charactor)) then
		LeanTween.cancel(go(self.charactor))
	end

	if isActive(self.charactor) then
		self:hideChar(function()
			self:showChar(arg_38_1, arg_38_2, arg_38_3)

			return
		end)
	else
		self:showChar(arg_38_1, arg_38_2, arg_38_3)
	end

	return
end

function JiuJiuExpeditionGameView:showChar(arg_40_1, arg_40_2, arg_40_3)
	self.charactor.localPosition = Vector3(arg_40_1, arg_40_2 + var_0_1)

	setActive(self.charactor, true)
	LeanTween.value(go(self.charactor), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_41_0)
		GetComponent(self.charactor, typeof(CanvasGroup)).alpha = arg_41_0

		return
	end))
	LeanTween.moveLocal(go(self.charactor), Vector3(arg_40_1, arg_40_2, 0), 0.2):setOnComplete(System.Action(function()
		if arg_40_3 then
			arg_40_3()
		end

		return
	end))

	return
end

function JiuJiuExpeditionGameView:hideChar(arg_43_1)
	LeanTween.value(go(self.charactor), 1, 0, 0.2):setOnUpdate(System.Action_float(function(arg_44_0)
		GetComponent(self.charactor, typeof(CanvasGroup)).alpha = arg_44_0

		return
	end))
	LeanTween.moveLocal(go(self.charactor), Vector3(self.charactor.localPosition.x, self.charactor.localPosition.y + var_0_1, 0), 0.2):setOnComplete(System.Action(function()
		setActive(self.charactor, false)

		if arg_43_1 then
			arg_43_1()
		end

		return
	end))

	return
end

function JiuJiuExpeditionGameView:enterBattle()
	self:hideEnterBossUI()
	pg.m02:sendNotification(GAME.BEGIN_STAGE, {
		system = SYSTEM_REWARD_PERFORM,
		stageId = self.bossId
	})

	self.bossId = nil

	return
end

function JiuJiuExpeditionGameView:openGrid(arg_47_1)
	if self.inMessage then
		return
	end

	self.inMessage = true

	pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 1,
		activity_id = self.activityId,
		arg1 = arg_47_1
	})

	return
end

function JiuJiuExpeditionGameView:getGridReward(arg_48_1)
	if self.inMessage then
		return
	end

	self.inMessage = true

	pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
		cmd = 2,
		activity_id = self.activityId,
		arg1 = arg_48_1
	})

	return
end

function JiuJiuExpeditionGameView:showEnterBossUI()
	pg.UIMgr.GetInstance():BlurPanel(self.enterBossUI)
	setActive(self.enterBossUI, true)

	return
end

function JiuJiuExpeditionGameView:hideEnterBossUI()
	setActive(self.enterBossUI, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.enterBossUI)

	return
end

function JiuJiuExpeditionGameView:getPosNum(arg_51_1, arg_51_2)
	return (arg_51_1 - 1) * self.chequerMap[2] + arg_51_2
end

function JiuJiuExpeditionGameView:clear(arg_52_1)
	for iter_52_0 = 1, #self.mapDic do
		self:returnBottomGrid(self.mapDic[iter_52_0].bottomGrid)
		self:returnMask(self.mapDic[iter_52_0].mask)
		self:returnUpGrid(self.mapDic[iter_52_0].upGrid)
	end

	self.mapDic = {}

	if arg_52_1 then
		for iter_52_1 = 1, #self.baoxiangList do
			if LeanTween.isTweening(go(self.baoxiangList[iter_52_1].tf)) then
				LeanTween.cancel(go(self.baoxiangList[iter_52_1].tf))
			end

			self:returnBaoxiang(self.baoxiangList[iter_52_1].tf)
		end

		self.baoxiangList = {}
	end

	self.expeditionMap = nil

	return
end

function JiuJiuExpeditionGameView:getBaoxiang()
	local var_53_0

	if #self.poolBaoxiangList > 0 then
		var_53_0 = table.remove(self.poolBaoxiangList, #self.poolBaoxiangList)
	else
		var_53_0 = tf(instantiate(self.tplBaoxiang))

		setParent(var_53_0, self.posCharactor)
	end

	setActive(findTF(var_53_0, "baoxiang_guan"), true)
	setActive(findTF(var_53_0, "baoxiang_kai"), false)

	return var_53_0
end

function JiuJiuExpeditionGameView:returnBaoxiang(arg_54_1)
	setActive(arg_54_1, false)
	table.insert(self.poolBaoxiangList, arg_54_1)

	return
end

function JiuJiuExpeditionGameView:getMask()
	local var_55_0

	if #self.poolMasks > 0 then
		var_55_0 = table.remove(self.poolMasks, #self.poolMasks)
	else
		var_55_0 = tf(instantiate(self.tplBgMask))

		setParent(var_55_0, self.posMask)
	end

	setActive(var_55_0, true)

	return var_55_0
end

function JiuJiuExpeditionGameView:returnMask(arg_56_1)
	setActive(arg_56_1, false)
	table.insert(self.poolMasks, arg_56_1)

	return
end

function JiuJiuExpeditionGameView:getBottomGrid()
	local var_57_0

	if #self.poolBottomGrids > 0 then
		var_57_0 = table.remove(self.poolBottomGrids, #self.poolBottomGrids)
	else
		var_57_0 = tf(instantiate(self.tplBottomGrid))

		setParent(var_57_0, self.posBottom)
	end

	setActive(var_57_0, true)

	return var_57_0
end

function JiuJiuExpeditionGameView:returnBottomGrid(arg_58_1)
	setActive(arg_58_1, false)
	table.insert(self.poolBottomGrids, arg_58_1)

	return
end

function JiuJiuExpeditionGameView:getUpGrid()
	local var_59_0

	if #self.poolUpGrids > 0 then
		var_59_0 = table.remove(self.poolUpGrids, #self.poolUpGrids)
	else
		var_59_0 = tf(instantiate(self.tplUpGrid))

		setParent(var_59_0, self.posUp)
	end

	setActive(var_59_0, true)

	return var_59_0
end

function JiuJiuExpeditionGameView:returnUpGrid(arg_60_1)
	setActive(arg_60_1, false)
	table.insert(self.poolUpGrids, arg_60_1)

	return
end

function JiuJiuExpeditionGameView:getPosition(arg_61_1, arg_61_2)
	local var_61_0 = -(arg_61_1 - 1) * var_0_3

	if arg_61_2 % 2 == 0 then
		var_61_0 = var_61_0 + var_0_3 / 2
	end

	return (arg_61_2 - 1) * var_0_2, var_61_0
end

function JiuJiuExpeditionGameView:willExit()
	if LeanTween.isTweening(go(self.charactor)) then
		LeanTween.cancel(go(self.charactor))
	end

	for iter_62_0 = 1, #self.baoxiangList do
		if LeanTween.isTweening(go(self.baoxiangList[iter_62_0].tf)) then
			LeanTween.cancel(go(self.baoxiangList[iter_62_0].tf))
		end
	end

	if LeanTween.isTweening(go(self.bookUnLock)) then
		LeanTween.cancel(go(self.bookUnLock))
	end

	return
end

return JiuJiuExpeditionGameView
