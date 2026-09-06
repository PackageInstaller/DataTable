-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/jigsaw/CORJigsawMainView.lua

module("logic.extensions.cantonoperaroad.view.copy.jigsaw.CORJigsawMainView", package.seeall)

local CORJigsawMainView = class("CORJigsawMainView", ViewComponent)

function CORJigsawMainView:buildUI()
	CORJigsawMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")

	local partScrollerview = goutil.findChild(self.mainGO, "partCol/partScrollerview")
	local partScrollercell = goutil.findChild(self.mainGO, "partCol/partScrollercell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "partCol/itemScrollercell")
	self._role = goutil.findChild(self.mainGO, "role")
	self._bubble = goutil.findChild(self.mainGO, "role/bubble")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "role/bubble/txt")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._partScrollList = ScrollerList.create(partScrollerview, partScrollercell, GameUtil.handler(self._updatePartCell, self), GameUtil.handler(self._clearPartCell, self))
	self._itemScrollListDic = {}
end

function CORJigsawMainView:bindEvents()
	CORJigsawMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function CORJigsawMainView:unbindEvents()
	CORJigsawMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function CORJigsawMainView:onEnter()
	CORJigsawMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._modelId = GameEnum.ModelTypeAsCOR.JIGSAW

	self:_onSetUI()
	self:_popPieceListAsBattleGet()
	GlobalDispatcher:addListener(GlobalNotify.CORJigsawInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.CORLightUpRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.CORJigsawBattleEndRes, self._popPieceListAsBattleGet, self)
	GlobalDispatcher:addListener(GlobalNotify.CORGetInfoRes, self._checkIsCanEnter, self)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadJigsawInfoReq(self._activityId)
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadGetInfoReq(self._activityId)
end

function CORJigsawMainView:onExit()
	CORJigsawMainView.super.onExit(self)
	removetimer(self._popPrizeFloatTips, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORJigsawInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORLightUpRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORJigsawBattleEndRes, self._popPieceListAsBattleGet, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORGetInfoRes, self._checkIsCanEnter, self)
	self._partScrollList:dispose()
end

function CORJigsawMainView:_onSetUI()
	local actData = CantonOperaRoadConfig.instance:getCorActData(self._activityId)
	local energyList = CantonOperaRoadController.instance:getEnergyListAsCOR(self._activityId)

	if self._goldBarCon then
		local list = {
			energyList
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end
end

function CORJigsawMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function CORJigsawMainView:_onUpdateData()
	self:_onUpdatePartColData()
end

function CORJigsawMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePartColUI()
end

function CORJigsawMainView:_onUpdatePlaneUI()
	return
end

function CORJigsawMainView:_checkIsCanEnter()
	if not CantonOperaRoadController.instance:isCanEnterModelAsCOR(self._modelId) then
		local tipsStr = CantonOperaRoadController.instance:getTipsStrByEnterResultAsCOR(self._modelId)

		if not string.nilorempty(tipsStr) then
			FloatWordMgr.instance:show(tipsStr)
		end

		self:close()
	end
end

function CORJigsawMainView:_onUpdatePartColData()
	self._partInfoList = {}

	local cfg = CantonOperaRoadConfig.instance:getCorJigsawCfgById(self._activityId)

	for _, data in ipairs(cfg) do
		local jigsawId = data.jigsawId

		self._partInfoList[jigsawId] = {
			data = data,
			isUnlock = CantonOperaRoadController.instance:isUnlockAsCORJigsaw(jigsawId),
			isInTime = CantonOperaRoadController.instance:isInTimeAsJigsaw(jigsawId),
			isUnlockCond = CantonOperaRoadController.instance:isUnlockConditionAsCORJigsaw(jigsawId),
			isPass = CantonOperaRoadController.instance:isPassAsJigsaw(jigsawId)
		}
	end
end

function CORJigsawMainView:_onUpdatePartColUI()
	self._partScrollList:reloadData(self._partInfoList)
end

function CORJigsawMainView:_updatePartCell(view, cell, info, tag)
	local data = info.data
	local isUnlock = info.isUnlock
	local isInTime = info.isInTime
	local isUnlockCond = info.isUnlockCond
	local isPass = info.isPass
	local mainGo = cell.gameObject
	local lock = goutil.findChild(mainGo, "lock")
	local icon = goutil.findChild(mainGo, "lock/icon")
	local txtLockTips = goutil.findChildTextComponent(mainGo, "lock/txtLockTips")
	local unLock = goutil.findChild(mainGo, "unLock")
	local jigsawIcon = goutil.findChild(mainGo, "unLock/jigsawIcon")
	local itemScrollerview = goutil.findChild(mainGo, "unLock/itemScrollerview")
	local btnJump = goutil.findChild(mainGo, "unLock/btnJump")
	local txtBtnJump = goutil.findChildTextComponent(mainGo, "unLock/btnJump/txt")
	local redBtnJump = goutil.findChild(mainGo, "unLock/btnJump/redPoint")
	local txtDesc = goutil.findChildTextComponent(mainGo, "unLock/txtDesc")

	GameUtil.SetActive(lock, not isUnlock)
	GameUtil.SetActive(unLock, isUnlock)

	local lockStr = ""

	if not isInTime then
		local timePeriod = GameUtil.getTimePeriod(data.openTime, data.endTime)

		if timePeriod == GameUtil.beforeTimePeriod then
			lockStr = string.format("%s将开启", GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openTime), nil))
		elseif timePeriod == GameUtil.afterTimePeriod then
			lockStr = string.format("%s已结束", GameUtil.getFormatTimeByStamp(nil, GameUtil.string2time(data.endTime)))
		end
	elseif not isUnlockCond then
		lockStr = string.format("未通关前置拼图")
	end

	txtLockTips.text = lockStr

	GameUtil.SetActive(txtDesc, isUnlock and isPass)

	txtDesc.text = data.txtDesc

	GameUtil.SetActive(itemScrollerview, isUnlock and not isPass)

	if itemScrollerview and self._itemScrollercell and not isPass then
		local prizeStrArr = string.split(data.preShowPrize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
		end
	end

	local path = data.simpleIcon

	if isPass then
		path = data.completeIcon
	end

	local bgGo = jigsawIcon

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/bigbg/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	GameUtil.SetActive(btnJump, not isPass)
	GameUtil.addClickHandler(btnJump, GameUtil.handler(self._onClickBtnJump, self, info))
end

function CORJigsawMainView:_clearPartCell(cell)
	local mainGo = cell.gameObject
	local btnJump = goutil.findChild(mainGo, "unLock/btnJump")
	local jigsawIcon = goutil.findChild(mainGo, "unLock/jigsawIcon")
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end

	uGuiUtil.clearImage(jigsawIcon)
	GameUtil.rmClickHandler(btnJump)
end

function CORJigsawMainView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function CORJigsawMainView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function CORJigsawMainView:_onClickBtnJump(info)
	UIStateManager.instance:push(ViewName.CORJigsawScenceView, info.data.jigsawId)
end

function CORJigsawMainView:_popPieceListAsBattleGet()
	local pieceInfoList = CantonOperaRoadModel.instance:getPieceInfoListAsJigsawBattleGet()

	self._prizeInfoList = {}

	for _, pieceInfo in ipairs(pieceInfoList) do
		local data = CantonOperaRoadConfig.instance:getCorJigsawPieceDataById(self._activityId, pieceInfo.pieceId)
		local info = {
			matName = data.name,
			matIconPath = data.icon,
			matNum = pieceInfo.num
		}

		table.insert(self._prizeInfoList, info)
	end

	CantonOperaRoadModel.instance:clearPieceInfoListAsJigsawBattleGet()
	self:_startPopAllPrizeFloatTips()
end

function CORJigsawMainView:_startPopAllPrizeFloatTips()
	self._curPopIdx = #self._prizeInfoList

	removetimer(self._popPrizeFloatTips, self)
	settimer(0.4, self._popPrizeFloatTips, self, true)
end

function CORJigsawMainView:_popPrizeFloatTips()
	if self._curPopIdx <= 0 then
		removetimer(self._popPrizeFloatTips, self)

		return
	end

	local info = self._prizeInfoList[self._curPopIdx]

	if info then
		FloatWordMgr.instance:show(string.format("获得 【%s】 x %d", info.matName, info.matNum))
	end

	self._curPopIdx = self._curPopIdx - 1
end

function CORJigsawMainView:_onClickBtnTip()
	return
end

return CORJigsawMainView
