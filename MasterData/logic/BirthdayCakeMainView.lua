-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaycake/view/BirthdayCakeMainView.lua

module("logic.extensions.birthdaycake.view.BirthdayCakeMainView", package.seeall)

local BirthdayCakeMainView = class("BirthdayCakeMainView", ViewComponent)
local class = {
	classS = 1,
	classA = 2,
	classB = 3
}

function BirthdayCakeMainView:ctor()
	BirthdayCakeMainView.super.ctor(self)

	self._rewardClassTab = {}
	self._cakeThingsClass = {}
	self._cakeThingsEvent = nil
	self._effList = {}
end

function BirthdayCakeMainView:unbindEvents()
	BirthdayCakeMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnMake:RemoveClickListener()
	self._btnEat:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function BirthdayCakeMainView:bindEvents()
	BirthdayCakeMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(function()
		self:close()
	end)
	self._btnTask:AddClickListener(self._onClickTaskBtn, self)
	self._btnMake:AddClickListener(self._onClikMakeCake, self)
	self._btnEat:AddClickListener(self._onClickShareCake, self)
	self._btnAdd:AddClickListener(self._onClickAddTime, self)
	self._btnTip:AddClickListener(self._onClickTipBtn, self)
end

function BirthdayCakeMainView:buildUI()
	BirthdayCakeMainView.super.buildUI(self)

	self._txtWorldScore = self:getTxt("playerReward/txtPlayerScore")
	self._txtScore = self:getTxt("score/txtScore")
	self._txtTips = self:getTxt("specialItemCell/txtTips")
	self._txtTitle = self:getTxt("specialItemCell/txtTitle")
	self._txtEatTime = self:getTxt("pageBtns/btnEat/txtTime")
	self._txtMakeTime = self:getTxt("pageBtns/btnMake/txtTime")
	self._txtItemCellTitle = self:getTxt("specialItemCell/txtTitle")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnTask = self:getBtn("btnTask")
	self._btnDivide = self:getBtn("btnDivide")
	self._btnMake = self:getBtn("pageBtns/btnMake")
	self._btnEat = self:getBtn("pageBtns/btnEat")
	self._btnAdd = self:getBtn("score/btnAdd")
	self._role_1 = self:getGo("role_1")
	self._role_2 = self:getGo("role_2")
	self._worldProgress = self:getGo("playerReward")
	self._makeTime = self:getGo("pageBtns/btnMake/txtTime")
	self._eatTime = self:getGo("pageBtns/btnEat/txtTime")
	self._makeImg = self:getGo("pageBtns/btnMake/img")
	self._eatImg = self:getGo("pageBtns/btnEat/img")
	self._iconCell = self:getGo("itemCellBg")
	self._pageBtns = self:getGo("pageBtns")
	self._luckyRankGo = self:getGo("luckyRank")
	self._specialItemCell = self:getGo("specialItemCell")
	self._txtNobody = self:getGo("luckyRankGo/txtNobody")
	self._imgDecoration = self:getGo("imgDecoration")
	self._goodsGo = self:getGo("specialItemCell/goodsGo")
	self._btnTaskRedPoint = self:getGo("btnTask/redpoint")
	self._btnDivideRedPoint = self:getGo("btnDivide/redpoint")
	self._divider = BirthdayCakeDivide.New(self._btnDivide.gameObject, GameUtil.handler(self._judgeDivide, self))

	for i = 1, 3 do
		local list = {}
		local go = self:getGo("itemCell_" .. i)

		list.go = go
		list.num = 0
		list.txt = goutil.findChildTextComponent(go, "txtName")
		list.caker = BirthdayCakeThings.New(list.go, GameUtil.handler(self._judgeCakeTings, self), i)
		self._cakeThingsClass[i] = list
	end

	for i = 1, 3 do
		local list = {}
		local rGo = self:getGo("specialItemCell/rewardview_" .. i)

		list.rewardTab = ScrollerList.create(rGo, self._goodsGo, GameUtil.handler(self._rewardClassList, self), GameUtil.handler(self._clearRewardClassList, self))
		list.rewardList = {}

		table.insert(self._rewardClassTab, list)
	end

	local sliderGo = self:getGo("playerReward")

	self._birthDayCakeSliderMo = BirthDayCakeSliderMo.New(sliderGo)
end

function BirthdayCakeMainView:onEnter()
	BirthdayCakeMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.BirthdayCakeInfo, self._refreshViewInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.BirthdayCakeWorldProgress, self._refreshWorldProgress, self)
	GlobalDispatcher:addListener(GlobalNotify.BirthdayCakeThings, self._refreshCakeThings, self)
	GlobalDispatcher:addListener(GlobalNotify.BirthdayCakeBuyTime, self._refreshBuyTime, self)
	GlobalDispatcher:addListener(GlobalNotify.BirthdayCakeRecord, self._refreshLuckyTab, self)

	self._txtScore.text = ""
	self._activityId = BirthdayCakeModel.instance:getActivityId()
	self._actCfg = BirthdayCakeConfig.instance:getCfgById(self._activityId)

	BirthdayCakeAgent.instance:sendPM_BirthdayCakeInfoReq(self._activityId)
	BirthdayCakeAgent.instance:sendPM_BirthdayCakeWorldProgressValueReq(self._activityId)
	self:_setCakeBox()
	self._divider:onEnter()

	for i, v in pairs(self._cakeThingsClass) do
		v.caker:onEnter()
	end

	self:_refreshCakeThings()
	self:_initPlayerParams()

	self._loopRoller = self._loopRoller or LoopRoller.New(self:getGo("luckyRank"))

	self._loopRoller:init({
		margin = 4,
		updateCellFunc = self._updateRollerCell,
		removeCellFunc = self._removeRollerCell,
		thisArg = self,
		direction = LoopRoller.Direction_B2T,
		weekAlign = LoopRoller.WeekAlign_MiddleOrCenter,
		speed = checknumber(SummerLotteryConfig.instance:getCommonValue("RollerSpeed"))
	})
	RedPointController.instance:regRedPoint(self._btnTaskRedPoint, RedPointModel.ID_ACTIVITY_TASK)
	self:_showUIEff(self.mainGO, "fx_ui_srdg_jm.prefab")
end

function BirthdayCakeMainView:onExit()
	BirthdayCakeMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BirthdayCakeInfo, self._refreshViewInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.BirthdayCakeWorldProgress, self._refreshWorldProgress, self)
	GlobalDispatcher:removeListener(GlobalNotify.BirthdayCakeThings, self._refreshCakeThings, self)
	GlobalDispatcher:removeListener(GlobalNotify.BirthdayCakeBuyTime, self._refreshBuyTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.BirthdayCakeRecord, self._refreshLuckyTab, self)
	self._divider:onExit()

	for i, v in pairs(self._cakeThingsClass) do
		v.caker:onExit()
	end

	uGuiUtil.clearImage(self._imgDecoration)
	self._loopRoller:dispose()
	self:_stopEffect()

	self._cakeThingsEvent = nil
end

function BirthdayCakeMainView:_initPlayerParams()
	local param = {}

	param.view = self
	param.prizeCfgs = BirthdayCakeConfig.instance:getWorldRewardCfg(self._actCfg.prizePlanId)

	function param.getPlayerProgress()
		local progress = BirthdayCakeModel.instance:getWorldProgressValue()

		return checknumber(progress)
	end

	function param.getPrizeByRewardCfg(cfg)
		local prizes = string.split(cfg.prize, "#")

		return prizes[1]
	end

	function param.getNeedScoreByRewardCfg(cfg)
		return cfg.needScore
	end

	function param.isPlayerRewardCanGet(cfg)
		return BirthdayCakeModel.instance:isPlayerRewardCanGet(cfg.prizeId, cfg.needScore)
	end

	function param.isPlayerRewardGeted(cfg)
		return BirthdayCakeModel.instance:isPlayerRewardGeted(cfg.prizeId)
	end

	function param.sendGainPlayerPrizeReq(cfg)
		BirthdayCakeAgent.instance:sendPM_BirthdayCakeWorldProgressRewardReq(self._activityId, cfg.prizeId)
	end

	function param.parseGetProgress(cfg)
		return StringUtil.numberToString(cfg.needScore)
	end

	self._birthDayCakeSliderMo:initParam(param, true)
	self._birthDayCakeSliderMo:onEnter()
	self._birthDayCakeSliderMo:updatePlayerReward()
	self._birthDayCakeSliderMo:relocation()
end

function BirthdayCakeMainView:_refreshCakeThings()
	local cfg = BirthdayCakeConfig.instance:getCakeThingsCfg(self._actCfg.cakePlan)

	for i, v in ipairs(cfg) do
		local list = self._cakeThingsClass[i]
		local num = MaterialMgr.getMatCount(v.consume)

		self._cakeThingsClass[i].num = num
		self._cakeThingsClass[i].txt.text = MaterialMgr.getMaterialsNameByCfg(v.consume)

		MaterialMgr.resetAll(list.go)

		local proxy = MaterialMgr.setCellByCfg(v.consume, list.go)

		proxy:setNumStr(num)
	end

	if self._cakeThingsEvent then
		GameUtil.callBack(self._cakeThingsEvent)
	end
end

function BirthdayCakeMainView:_refreshViewInfo()
	self:_refreshRewardList()
	self:_judgeMode()
end

function BirthdayCakeMainView:_refreshRewardList()
	local cakeRewardList = BirthdayCakeModel.instance:getStoreInfo()
	local carveUpHistoryInfo = BirthdayCakeModel.instance:getCarveUpHistoryInfo()
	local count = BirthdayCakeModel.instance:getAllLotteryCountTypeS()

	for k, v in pairs(self._rewardClassTab) do
		if v then
			v.rewardList = {}
		end
	end

	local cfg = BirthdayCakeConfig.instance:getAllCakeStoreCfg(self._actCfg.storePlan)

	for i, v in ipairs(cfg) do
		local info = self:_getListValue(v.storeId, cakeRewardList)
		local history = self:_getListValue(v.storeId, carveUpHistoryInfo)

		v.surplus = nil
		v.history = nil
		v.isGray = false
		v.isHaveTop = false
		v.isBottom = false

		if info then
			local surplus = v.limitNum - checknumber(info.num)

			v.surplus = surplus > 0 and surplus or 0
		end

		if checknumber(v.activityGetPrice) > 0 then
			local historyCount = checknumber(v.activityGetPrice) - count

			v.history = historyCount > 0 and historyCount or nil
			v.isGray = history and history.num >= v.personalLimit
			v.isHaveTop = historyCount > 0 and not v.isGray
		elseif v.storeType == class.classS then
			local carveUpOpenTime = self._actCfg.carveUpOpenTime
			local carveUpEndTime = self._actCfg.carveUpEndTime

			v.isBottom = GameUtil.checkIsInTimePeriod(carveUpOpenTime, carveUpEndTime)
		end

		table.insert(self._rewardClassTab[v.storeType].rewardList, v)
	end

	for k, v in pairs(self._rewardClassTab) do
		if v.rewardTab then
			v.rewardTab:reloadData(v.rewardList)
		end
	end
end

function BirthdayCakeMainView:_getListValue(id, list)
	for k, v in pairs(list) do
		if id == v.storeId then
			return v
		end
	end
end

function BirthdayCakeMainView:_refreshLuckyTab()
	local data = BirthdayCakeModel.instance:getRecords()

	self._loopRoller:reload(data or {})
	self._loopRoller:play()
end

function BirthdayCakeMainView:_refreshCakeImg()
	local progress = BirthdayCakeModel.instance:getWorldProgressValue()
	local cfg = BirthdayCakeConfig.instance:getWorldRewardCfg(self._actCfg.prizePlanId)
	local cakeImg = ""

	for i, v in ipairs(cfg) do
		if progress <= v.needScore then
			cakeImg = v.cakeImg

			break
		end
	end

	if string.nilorempty(cakeImg) then
		cakeImg = cfg[#cfg].cakeImg
	end

	uGuiUtil.setSpriteToImage(self._imgDecoration, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/birthdaycake/%s.png", cakeImg))
end

function BirthdayCakeMainView:_refreshWorldProgress()
	self._txtWorldScore.text = string.format("全服贡献度: <color=#EFA6D6FF>%s</color>", BirthdayCakeModel.instance:getWorldProgressValue())

	self._birthDayCakeSliderMo:updatePlayerReward()
	self._birthDayCakeSliderMo:relocation()
	self:_refreshCakeImg()
end

function BirthdayCakeMainView:_luckyTabList(view, cell, data)
	local txtName = goutil.findChild(cell, "txtName")

	txtName.text = data
end

function BirthdayCakeMainView:_clearLuckyTabList(cell)
	return
end

function BirthdayCakeMainView:_onClikMakeCake()
	local makeOpenTime = self._actCfg.makeOpenTime
	local makeEndTime = self._actCfg.makeEndTime

	if not GameUtil.checkIsInTimePeriod(makeOpenTime, makeEndTime) then
		FloatWordMgr.instance:show("活动时间已过")

		return
	end

	self:_setOnClickCake(true)
	self:_refreshNextWeekReward()
end

function BirthdayCakeMainView:_onClickShareCake()
	local carveUpOpenTime = self._actCfg.carveUpOpenTime
	local carveUpEndTime = self._actCfg.carveUpEndTime

	if not GameUtil.checkIsInTimePeriod(carveUpOpenTime, carveUpEndTime) then
		FloatWordMgr.instance:show("没到活动时间")

		return
	end

	self:_setOnClickCake(false)
	self:_refreshBuyTime()
end

function BirthdayCakeMainView:_onClickAddTime()
	local carveTime = BirthdayCakeModel.instance:getCarveUpNum()
	local buyTime = BirthdayCakeModel.instance:getBuyNum()
	local totalNum = BirthdayCakeModel.instance:getTotalNum()
	local buyCfg = BirthdayCakeConfig.instance:getCakeBuyTimeCfg(self._actCfg.buyPlanId)

	if carveTime < buyTime + totalNum then
		FloatWordMgr.instance:show("当前还有剩余瓜分次数")
	elseif buyTime < #buyCfg then
		local extPrizeType, extPrizeId, extPrizeNum = MaterialMgr.getMatParams(buyCfg[buyTime + 1].cost)
		local extName = MaterialMgr.getMaterialsName(extPrizeType, extPrizeId)
		local content = langPara("确定花费%s%s购买一次瓜分机会吗？", extPrizeNum, extName)

		TipsFacade.instance:openPopupCostMatViewNew(extPrizeType, extPrizeId, extPrizeNum, content, function()
			local haveNum = MaterialModel.instance:getMaterialsNumber(extPrizeType, extPrizeId) or 0

			if haveNum < checknumber(extPrizeNum) then
				local cfg = MaterialMgr.getMatCfg(extPrizeType, extPrizeId)

				if cfg then
					FloatWordMgr.instance:show(langPara("所需%s不足！", cfg.name))
				else
					FloatWordMgr.instance:show(lang("所需货币不足！"))
				end
			else
				BirthdayCakeAgent.instance:sendPM_BirthdayCakeBuyReq(self._activityId)
			end
		end)
	else
		FloatWordMgr.instance:show("瓜分次数已经用完！")
	end
end

function BirthdayCakeMainView:_setOnClickCake(isMake)
	goutil.setActive(self._luckyRankGo, not isMake)
	goutil.setActive(self._btnDivide.gameObject, not isMake)
	goutil.setActive(self._btnAdd.gameObject, not isMake)
	goutil.setActive(self._eatImg, not isMake)
	goutil.setActive(self._role_2, not isMake)
	goutil.setActive(self._role_1, isMake)
	goutil.setActive(self._eatTime, isMake)
	goutil.setActive(self._btnTask.gameObject, isMake)
	goutil.setActive(self._iconCell, isMake)
	goutil.setActive(self._makeImg, isMake)
	goutil.setActive(self._worldProgress, isMake)

	for k, v in pairs(self._cakeThingsClass) do
		goutil.setActive(v.go, isMake)
	end
end

function BirthdayCakeMainView:_refreshBuyTime()
	local num = self:_getDivideCakeNum()
	local count = BirthdayCakeModel.instance:getAllLotteryCountTypeS()

	self._txtScore.text = string.format("今天可瓜分<color=#87FA77FF>%s次</color>蛋糕\n当前已经瓜分<color=#87FA77FF>%s次</color>S级大奖", num >= 0 and num or num, count)
	self._txtItemCellTitle.text = "当前可以瓜分大奖"
	self._txtTips.text = BirthdayCakeConfig.instance:getCommonString("CAKE_RULE2")

	goutil.setActive(self._btnDivideRedPoint, num > 0)
end

function BirthdayCakeMainView:_refreshNextWeekReward()
	local contribute = BirthdayCakeModel.instance:getContribute()
	local num = self:_getDivideCakeNum()

	self._txtItemCellTitle.text = "下周瓜分大奖"
	self._txtScore.text = string.format("<color=#FEF6A2FF>个人贡献度：%s</color>\n下周每天瓜分次数:<color=#fef6a2>%s次</color>", contribute, num)
	self._txtTips.text = BirthdayCakeConfig.instance:getCommonString("CAKE_RULE1")
end

function BirthdayCakeMainView:_getDivideCakeNum()
	local carveTime = BirthdayCakeModel.instance:getCarveUpNum()
	local buyTime = BirthdayCakeModel.instance:getBuyNum()
	local totalNum = BirthdayCakeModel.instance:getTotalNum()
	local num = buyTime + totalNum - carveTime

	if num >= 0 and not num then
		-- block empty
	end

	return num
end

function BirthdayCakeMainView:_onClickTaskBtn()
	UIStateManager.instance:push(ViewName.BirthdayCakeTaskView)
end

function BirthdayCakeMainView:_onClickTipBtn()
	UIStateManager.instance:push(ViewName.RulesView, "birthdaycakemainview_rule")
end

function BirthdayCakeMainView:_judgeMode()
	local makeOpenTime = self._actCfg.makeOpenTime
	local makeEndTime = self._actCfg.makeEndTime
	local carveUpOpenTime = self._actCfg.carveUpOpenTime
	local carveUpEndTime = self._actCfg.carveUpEndTime

	if GameUtil.checkIsInTimePeriod(makeOpenTime, makeEndTime) then
		self:_onClikMakeCake()
	end

	if GameUtil.checkIsInTimePeriod(carveUpOpenTime, carveUpEndTime) then
		self:_onClickShareCake()
		BirthdayCakeAgent.instance:sendPM_BirthdayCakeCarveUpRecordReq(self._activityId)
	end

	local startDate, endDate = GameUtil.string2date(carveUpOpenTime), GameUtil.string2date(carveUpEndTime)

	self._txtEatTime.text = string.format("开启时间:%s.%s-%s.%s", startDate.month, startDate.day, endDate.month, endDate.day)
end

function BirthdayCakeMainView:_rewardClassList(view, cell, data)
	local goodsPos = goutil.findChild(cell, "goodsPos")
	local imgTag = goutil.findChild(cell, "Img_Tag")
	local count = goutil.findChildTextComponent(cell, "count")
	local lottery = goutil.findChildTextComponent(cell, "lottery")
	local itmeType, itemId, itemNum = MaterialMgr.getMatParams(data.reward)

	MaterialMgr.resetAll(goodsPos)

	local proxy = MaterialMgr.setCellByCfg(data.reward, goodsPos)

	proxy:setNumStr(itemNum)
	proxy:setGray(data.isGray)
	goutil.setActive(imgTag, data.surplus and true or false)

	if data.surplus and data.isBottom then
		count.text = "剩余:" .. data.surplus or ""
	end

	lottery.text = data.isHaveTop and string.format("<color=#87FA77FF>%s</color>次S必得", data.history) or ""
end

function BirthdayCakeMainView:_clearRewardClassList(cell)
	return
end

function BirthdayCakeMainView:_setCakeBox()
	self._collider = goutil.findChild(self._imgDecoration.gameObject, "collider").transform

	local scaleX, scaleY = Framework.TransformUtil.GetLocalScale(self._imgDecoration.transform, 1, 1, 1)
	local cx, cyPos = Framework.TransformUtil.GetLocalPos(self._collider, nil, nil, nil)

	self._colliderLocalX = cx * scaleX
	self._colliderLocalY = cyPos * scaleY

	local sizeDelta = self._collider.transform.sizeDelta

	self._colliderSizeX = sizeDelta.x * scaleX
	self._colliderSizeY = sizeDelta.y * scaleY
	self._boundingBox = BoundingBox2D.New()

	local x, y = self:_getColliderPos()

	self._boundingBox:setSize(self._colliderSizeX, self._colliderSizeY)
	self._boundingBox:setCenter(x, y)
end

function BirthdayCakeMainView:_getColliderPos()
	local x, y = Framework.TransformUtil.GetLocalPos(self._imgDecoration.transform, nil, nil, nil)

	return self._colliderLocalX + x, y + self._colliderLocalY
end

function BirthdayCakeMainView:_judgeDivide()
	local carveTime = BirthdayCakeModel.instance:getCarveUpNum()
	local buyTime = BirthdayCakeModel.instance:getBuyNum()
	local totalNum = BirthdayCakeModel.instance:getTotalNum()
	local buyCfg = BirthdayCakeConfig.instance:getCakeBuyTimeCfg(self._actCfg.buyPlanId)
	local dBox = self._divider:getBoundingBox()

	if self._boundingBox:intersects(dBox) then
		if carveTime < buyTime + totalNum then
			BirthdayCakeAgent.instance:sendPM_BirthdayCakeCarveUpReq(self._activityId)
		elseif buyTime < #buyCfg then
			local extPrizeType, extPrizeId, extPrizeNum = MaterialMgr.getMatParams(buyCfg[buyTime + 1].cost)
			local extName = MaterialMgr.getMaterialsName(extPrizeType, extPrizeId)
			local content = langPara("确定花费%s%s购买一次瓜分机会吗？", extPrizeNum, extName)

			TipsFacade.instance:openPopupCostMatViewNew(extPrizeType, extPrizeId, extPrizeNum, content, function()
				local haveNum = MaterialModel.instance:getMaterialsNumber(extPrizeType, extPrizeId) or 0

				if haveNum < checknumber(extPrizeNum) then
					local cfg = MaterialMgr.getMatCfg(extPrizeType, extPrizeId)

					if cfg then
						FloatWordMgr.instance:show(langPara("所需%s不足！", cfg.name))
					else
						FloatWordMgr.instance:show(lang("所需货币不足！"))
					end
				else
					BirthdayCakeAgent.instance:sendPM_BirthdayCakeBuyReq(self._activityId)
				end
			end)
		else
			FloatWordMgr.instance:show("瓜分次数已经用完！")
		end
	end
end

function BirthdayCakeMainView:_judgeCakeTings(index)
	local box = self._cakeThingsClass[index].caker:getBoundingBox()

	if self._boundingBox:intersects(box) then
		if self._cakeThingsClass[index].num > 0 then
			BirthdayCakeAgent.instance:sendPM_BirthdayCakeMakeReq(self._activityId, index)

			function self._cakeThingsEvent()
				local cfg = BirthdayCakeConfig.instance:getCakeThingsCfg(self._actCfg.cakePlan)

				FloatWordMgr.instance:show(string.format("装扮成功，增加了%s贡献值", cfg[index].contribute))
				self:_refreshViewInfo()

				self._cakeThingsEvent = nil
			end
		else
			FloatWordMgr.instance:show("当前数量不足，请前往完成装扮任务吧！")
		end

		local pos = {}

		pos.x, pos.y, pos.z = Framework.TransformUtil.GetLocalPos(self._cakeThingsClass[index].go.transform, nil, nil, nil)

		self:_showThingEff(self.mainGO, "fx_ui_srdg_glow.prefab", pos)
	end
end

function BirthdayCakeMainView:_updateRollerCell(item, data, index)
	for i = 1, 2 do
		local itemGo = goutil.findChild(item, "loopItem_" .. i)
		local txtName = goutil.findChildTextComponent(itemGo, "txtName")
		local info = data[i]

		if not info then
			txtName.text = ""

			return
		end

		local userId = info.userId
		local koiName = info.userName
		local areaName = info.areaName
		local storePlanId = self._actCfg.storePlan
		local config = BirthdayCakeConfig.instance:getCakeStoreCfg(storePlanId, info.storeId) or {}
		local Rtype, id, num = MaterialMgr.getMatParams(config.reward)

		txtName.text = string.format("恭喜%s-%s-获得%sX%s", areaName, koiName, MaterialMgr.getMaterialsNameByCfg(config.reward), num)

		GameUtil.rmClickHandler(itemGo)
		GameUtil.addClickHandler(itemGo, function()
			if userId ~= nil then
				FriendController.instance:showInfoView(userId, txtName.gameObject)
			end
		end, self)
	end
end

function BirthdayCakeMainView:_removeRollerCell(item)
	local itemGo = goutil.findChild(item, "loopItem_1")
	local itemGo2 = goutil.findChild(item, "loopItem_2")

	GameUtil.rmClickHandler(itemGo)
	GameUtil.rmClickHandler(itemGo2)
end

function BirthdayCakeMainView:_showUIEff(go, effName)
	local effPath = "20221125/shengridangao/" .. effName
	local effect = UIEffectManager.instance:playEffect(self, effPath, go, 0, 0, true, false)

	effect:setParent(go.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)
	table.insert(self._effList, effect)
end

function BirthdayCakeMainView:_showThingEff(go, effName, pos)
	local effPath = "20221125/shengridangao/" .. effName
	local effect = UIEffectManager.instance:playEffect(self, effPath, go, 0, 0, false, false)

	effect:setParent(go.transform)
	effect:setScale(1)
	effect:setLocalPos(pos.x, pos.y, pos.z)
	table.insert(self._effList, effect)
end

function BirthdayCakeMainView:_stopEffect()
	for k, v in pairs(self._effList) do
		if v then
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._effList = {}
end

return BirthdayCakeMainView
