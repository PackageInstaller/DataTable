-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/view/AnniversaryKoiresultView.lua

module("logic.extensions.anniversarykoi.view.AnniversaryKoiresultView", package.seeall)

local AnniversaryKoiresultView = class("AnniversaryKoiresultView", ViewComponent)

function AnniversaryKoiresultView:ctor()
	AnniversaryKoiresultView.super.ctor(self)
end

function AnniversaryKoiresultView:unbindEvents()
	AnniversaryKoiresultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)
end

function AnniversaryKoiresultView:bindEvents()
	AnniversaryKoiresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function AnniversaryKoiresultView:buildUI()
	AnniversaryKoiresultView.super.buildUI(self)

	self._petCell = self:getGo("lottery/petCell")
	self._myPet = self:getGo("lottery/myPet")
	self._txtTip = self:getTxt("lottery/txtTip")
	self._effect = self:getGo("effect")
	self._lotteryAnim = self:getGo("lottery/lotteryAnim/anim")
	self._hasGet = self:getGo("lottery/lotteryAnim/hasGet")
	self._myNumberInfo = self:getGo("lottery/myNumberInfo/number")
	self._txtEmpty = self:getGo("lottery/myNumberInfo/empty")
	self._btnGoto = self:getBtn("btnGoto")
	self._btnClose = self:getBtn("btnClose")
end

function AnniversaryKoiresultView:onExit()
	AnniversaryKoiresultView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnniversaryKoiGetInfoRes, self._refreshUI, self)
	removetimer(self._checkPetMoveState, self)
	removetimer(self._lotteryMask, self)

	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end

	if self._petMoves then
		for _, move in ipairs(self._petMoves) do
			move:stop()
			move:destroy()
		end
	end

	if self._myPets then
		for _, cell in ipairs(self._myPets) do
			MaterialMgr.resetAll(goutil.findChild(cell, "con"))
			goutil.destroy(cell, true)
		end
	end

	for _, effect in ipairs(self._effectList) do
		if effect then
			UIEffectManager.instance:stopEffect(effect)
		end
	end
end

function AnniversaryKoiresultView:onEnter()
	AnniversaryKoiresultView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.AnniversaryKoi)

	GlobalDispatcher:addListener(GlobalNotify.AnniversaryKoiGetInfoRes, self._refreshUI, self)
	AnniversaryKoiController.instance:sendPM_AnniversaryKoiGetInfoReq(self._activityId)

	self._activityCfg = AnniversaryKoiConfig.instance:getKoiActivityCfgById(self._activityId)
	self._poolCfg = AnniversaryKoiConfig.instance:getKoiPoolCfg(self._activityId)
	self._petNumberCfg = AnniversaryKoiConfig.instance:getKoiPetNumberCfg(self._activityId)
	self._numberCount = self._poolCfg[1].numberCount
	self._isInLotteryTime = self:_timeState() ~= GameUtil.beforeTimePeriod
	self._popKey = "AnniversaryKoiresultView"
	self._animKey = "AnniversaryKoiAnimView"

	GameUtil.SetActive(self._petCell, false)
	GameUtil.SetActive(self._myPet, false)
	GameUtil.saveUserDayData(self._popKey, true)

	self._curProgress = 0
	self._petId = 5
	self._curRoundNum = 1

	local effectPath = "20230331/zhounianjingli/fx_ui_zhounianjingli_weiraoguan.prefab"

	self:_playEffect(effectPath, self._effect, true)
end

function AnniversaryKoiresultView:_playEffect(path, parent, loop)
	self._effectList = {}

	local effectPath = path
	local effect = UIEffectManager.instance:playEffect(self, effectPath, parent, 0, 0, loop, nil, nil, nil, self)

	effect:setParent(parent.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)
	table.insert(self._effectList, effect)
end

function AnniversaryKoiresultView:_refreshUI()
	self._myNumber = AnniversaryKoiModel.instance:getMyNumberInfo() or {}
	self._koiNumber = AnniversaryKoiModel.instance:getKoiNumber() or {}

	self:_setLotteryUIState()
	self:_setMyNumber()
end

function AnniversaryKoiresultView:_refreshLotteryResult()
	if #self._koiNumber > 0 then
		self._txtTip.text = "今日天选锦鲤开奖中！"

		GameUtil.SetActive(self._hasGet, false)
		self:_startLotteryAnim()
	else
		self:_lotteryDescTip()
	end
end

function AnniversaryKoiresultView:_lotteryDescTip()
	local koiPlayers = AnniversaryKoiModel.instance:getPlayerList() or {}

	if self._isInLotteryTime then
		if #self._koiNumber <= 0 then
			self._txtTip.text = "不满足开奖人数，今日无法开奖!"

			return
		end

		local koiPlayers = AnniversaryKoiModel.instance:getPlayerList() or {}

		if #koiPlayers > 0 and koiPlayers[1].headInfo.userId == RoleModel.instance:getUserId() then
			self._txtTip.text = "恭喜你！你就是天选之人！"

			return
		else
			self._txtTip.text = "很遗憾，您未中奖，明日再来！"
		end
	end
end

function AnniversaryKoiresultView:_timeState()
	local nowTime = ServerTime.now()
	local openTime, endTime = "0-0-0 20:00:00", "0-0-0 05:00:00"

	return GameUtil.getTimePeriodType(openTime, endTime)
end

function AnniversaryKoiresultView:_setLotteryUIState()
	GameUtil.SetActive(self._myNumberInfo, #self._myNumber > 0)
	GameUtil.SetActive(self._txtEmpty, #self._myNumber <= 0)
	GameUtil.SetActive(self._hasGet, #self._koiNumber <= 0)

	if #self._koiNumber > 0 then
		self:_setPetCell()
	end
end

function AnniversaryKoiresultView:_setPetCell()
	self._animParms = {
		{
			posY = 200,
			posX = 60
		},
		{
			posY = 100,
			posX = 30
		},
		{
			posY = 0,
			posX = 0
		},
		{
			posY = -114,
			posX = -32
		},
		{
			posY = -228,
			posX = -64
		}
	}
	self._petMoves = {}

	for col = 1, self._numberCount do
		local parent = goutil.findChild(self._lotteryAnim, "pos_" .. col)
		local numMove = AnniversaryKoiNumMove.New(parent, self._animParms, self._petNumberCfg)

		numMove:init(self._petCell)
		table.insert(self._petMoves, numMove)
	end

	self:_refreshLotteryResult()
end

function AnniversaryKoiresultView:_startLotteryAnim()
	local speed = self._activityCfg.speed
	local round = self._activityCfg.round
	local moveNumber = self._koiNumber

	GameUtil.SetActive(self._myNumberInfo, true)
	GameUtil.SetActive(self._txtEmpty, #self._myNumber <= 0 and #self._koiNumber > 0)

	if #moveNumber > 0 then
		for i = 1, #moveNumber do
			self._petMoves[i]:setMoveParams(speed, round, checknumber(moveNumber[i]))

			if i == 1 then
				self._petMoves[i]:setSlown()
			end

			self._petMoves[i]:move()
		end

		settimer(speed, self._checkPetMoveState, self, true)
	end
end

function AnniversaryKoiresultView:_checkPetMoveState()
	for i = 1, #self._petMoves do
		local isCurCellNumber = self._petMoves[i]:getStopState() and not self._petMoves[i]:getSetNumber()

		if isCurCellNumber and i <= #self._petMoves then
			if self._petMoves[i + 1] then
				self._petMoves[i + 1]:setSlown()
			end

			self:_endLotteryAnim(i)
			self._petMoves[i]:setNumberOn()

			local parent = goutil.findChild(self._lotteryAnim, "pos_" .. i)
			local effectPath = "20230331/zhounianjingli/fx_ui_zhounianjingli_baokai.prefab"

			self:_playEffect(effectPath, parent, false)
		end
	end
end

function AnniversaryKoiresultView:_endLotteryAnim(id)
	if id == self._numberCount then
		AnniversaryKoiModel.instance:setRecordLightRed(true)
		self:_lotteryDescTip()
		GameUtil.saveUserDayData(self._animKey, true)
		removetimer(self._checkPetMoveState, self)

		for _, effect in ipairs(self._effectList) do
			if effect then
				UIEffectManager.instance:stopEffect(effect)
			end
		end
	end
end

function AnniversaryKoiresultView:_setMyNumber()
	self._myPets = {}

	if #self._myNumber > 0 then
		for id = 1, #self._myNumber do
			local pos = goutil.findChild(self._myNumberInfo, "pos_" .. id)
			local cell = goutil.cloneAndSetParent(self._myPet, pos.transform)

			GameUtil.setLocalPos(cell, 0, 0, 0)
			MaterialMgr.setIcon(goutil.findChild(cell, "con"), MatType.Pet, self._petNumberCfg[checknumber(self._myNumber[id])].raceId)
			GameUtil.SetActive(cell, true)
			table.insert(self._myPets, cell)
		end
	end
end

function AnniversaryKoiresultView:_onClickGoto()
	UIStateManager.instance:push(ViewName.AnniversaryKoimainView)
	self:close()
end

return AnniversaryKoiresultView
