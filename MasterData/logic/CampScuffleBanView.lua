-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleBanView.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleBanView", package.seeall)

local CampScuffleBanView = class("CampScuffleBanView", ViewComponent)
local Enum = {
	Ban = 2,
	Default = 1,
	StartSetFmt = 4,
	RandomSet = 3
}

function CampScuffleBanView:ctor()
	CampScuffleBanView.super.ctor(self)

	self._scufflePetCellList = {}
	self._countDown = 0
	self._curState = Enum.Default
	self._isCountdown = false
	self._banTimeCountdown = 0
	self._isBanCountdown = false
end

function CampScuffleBanView:buildUI()
	CampScuffleBanView.super.buildUI(self)

	local petCard = self:getGo("petCard")

	petCard:SetActive(false)

	self._playerInfo1 = CampScuffleBanPlayer.New(true)
	self._playerInfo2 = CampScuffleBanPlayer.New(false)

	self._playerInfo1:buildUI(self:getGo("playerInfo1"), petCard)
	self._playerInfo2:buildUI(self:getGo("playerInfo2"), petCard)

	self._scrollRect = self:getGo("tableview"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._petListGo = self:getGo("tableview/viewport/content")
	self._petCell = self:getGo("petCell")

	self._petCell:SetActive(false)

	self._rangeRect = self._scrollRect.gameObject:GetComponent(goutil.Type_RectTransform)
	self._txtBanNum = self:getTxt("txtBanNum")
	self._btnSure = self:getBtn("btnSure")
	self._txtTime = self:getTxt("txtTime")
	self._txtDesc = self:getTxt("txtDesc")
	self._tipBoard = self:getGo("tipBoard")
	self._imgChangeTip = self:getGo("tipBoard/imgTip"):GetComponent(typeof(UIImageSpriteChange))
	self._maskGo = self:getGo("mask")
	self._waitShow = self:getGo("waitShow")
	self._txtWait = self:getTxt("waitShow/txtWait")
	self._imgGo = self:getGo("img")
end

function CampScuffleBanView:destroyUI()
	CampScuffleBanView.super.destroyUI(self)
	self._playerInfo1:destroyUI()
	self._playerInfo2:destroyUI()
end

function CampScuffleBanView:bindEvents()
	CampScuffleBanView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function CampScuffleBanView:unbindEvents()
	CampScuffleBanView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function CampScuffleBanView:onEnter()
	CampScuffleBanView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.CS_NotfiyStartSetFormRes, self._onStartSetFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CS_NotifyGameEndRes, self._onGameEndRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CampScuffleSelectPet, self._onClickSelectPet, self)
	self:_endWaitShow()
	settimer(1, self._onSecond, self)
	self:_resetView()
	self:_startDefaultState()
end

function CampScuffleBanView:onExit()
	CampScuffleBanView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_NotfiyStartSetFormRes, self._onStartSetFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_NotifyGameEndRes, self._onGameEndRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CampScuffleSelectPet, self._onClickSelectPet, self)
	removetimer(self._onSecond, self)
	self._playerInfo1:onExit()
	self._playerInfo2:onExit()
	self:_removePetCellList()
	self:_resetView()
	self:_removeTween()
	self:_endWaitShow()
end

function CampScuffleBanView:_onClickClose()
	self:close()
end

function CampScuffleBanView:_onClickSure()
	if CampScuffleModel.instance:isCanSelectBanPet() then
		self._isBanCountdown = false

		self:_closeBtnSure()
		CampScuffleModel.instance:setIsCanSelectBanPet(false)
		CampScuffleController.instance:sendCS_BanPetReq()
		self:_startWaitShow(self._banTimeCountdown)
	else
		FloatWordMgr.instance:show("禁用已完成")
	end
end

function CampScuffleBanView:_onStartSetFormRes()
	self:_onBanFinish()
	self:_endWaitShow()
	self:_showTipBoard(Enum.RandomSet)
end

function CampScuffleBanView:_onGameEndRes()
	ScuffleController.instance:onGameEndRes(function()
		self:_onClickClose()
	end)
end

function CampScuffleBanView:_onClickSelectPet()
	self:_updateBanNum()
end

function CampScuffleBanView:_updateBanNum()
	local curCount = CampScuffleModel.instance:getMyBanPetCount()
	local maxCount = CampScuffleModel.instance:getMaxBanPetCount()

	self._txtBanNum.text = string.format("%d/%d", curCount, maxCount)
end

function CampScuffleBanView:_onSecond()
	if self._isCountdown then
		if self._countDown > 0 then
			self._countDown = self._countDown - 1
		else
			self._isCountdown = false

			self:_closeTipBoard()
			self:_changeState()
		end
	end

	if self._isBanCountdown then
		if self._banTimeCountdown >= 0 then
			self:_showTxtTime(self._banTimeCountdown)

			self._banTimeCountdown = self._banTimeCountdown - 1
		else
			self:_onClickSure()
		end
	end

	if self._isStartWaitShow then
		if self._waitCountdown > 0 then
			self._waitCountdown = self._waitCountdown - 1

			self:_showWaitLeftTime(self._waitCountdown)
		else
			self:_stopWaitShow()
		end
	end
end

function CampScuffleBanView:_resetView()
	self._maskGo:SetActive(false)
	self._tipBoard:SetActive(false)
	self._maskGo:SetActive(false)
	self._txtBanNum.gameObject:SetActive(true)
	self._txtDesc.gameObject:SetActive(false)
	self._btnSure.gameObject:SetActive(false)
	self._imgGo:SetActive(false)
	self._txtTime.gameObject:SetActive(false)
	uGuiUtil.setImageGrayStateRecursive(self._btnSure.gameObject, false)
end

function CampScuffleBanView:_closeBtnSure()
	self._txtDesc.gameObject:SetActive(true)
	self._txtTime.gameObject:SetActive(false)
	self._imgGo:SetActive(false)
	uGuiUtil.setImageGrayStateRecursive(self._btnSure.gameObject, true)
end

function CampScuffleBanView:_openBtnSure()
	self._txtDesc.gameObject:SetActive(false)
	self._btnSure.gameObject:SetActive(true)
	self._imgGo:SetActive(true)
	self._txtTime.gameObject:SetActive(true)
end

function CampScuffleBanView:_onBanFinish()
	self._txtDesc.gameObject:SetActive(false)
end

function CampScuffleBanView:_startDefaultState()
	self._isCountdown = false
	self._curState = Enum.Default

	self._playerInfo1:setPlayerInfo(true)
	self._playerInfo1:initCardList(CampScuffleModel.instance:getMyInitPets())
	self._playerInfo2:setPlayerInfo(false)
	self._playerInfo2:initCardList(CampScuffleModel.instance:getEnemyInitPets())
	self:_initPetList()
	self:_updateBanNum()
	self:_showTipBoard(Enum.Ban)
end

function CampScuffleBanView:_startBanState()
	self._curState = Enum.Ban

	CampScuffleModel.instance:setIsCanSelectBanPet(true)
	self:_openBtnSure()

	self._banTimeCountdown = checknumber(CampGameConfig.instance:getCommonValueByKey("BAN_TIME"))
	self._isBanCountdown = true

	self:_showTxtTime(self._banTimeCountdown)
end

function CampScuffleBanView:_startRandomSetPet()
	self._curState = Enum.RandomSet

	self._playerInfo1:addCardList(CampScuffleModel.instance:getMyRandomPets())
	self._playerInfo2:addCardList(CampScuffleModel.instance:getEnemyRandomPets())
	self:_updatePoolPetsState()

	self._tween = TweenUtil.DoDelay(6, function()
		self:_showTipBoard(Enum.StartSetFmt)
	end)
end

function CampScuffleBanView:_startSetFormationState()
	self._curState = Enum.StartSetFmt

	self:_openFormationView()
	self:_onClickClose()
end

function CampScuffleBanView:_openFormationView()
	UIStateManager.instance:push(ViewName.CampScuffleMissionView)
end

function CampScuffleBanView:_initPetList()
	self:_removePetCellList()

	self._scrollRect.horizontalNormalizedPosition = 0

	local creepsIdList = CampScuffleModel.instance:getPoolPets()

	for index, id in ipairs(creepsIdList) do
		local go = goutil.cloneAndSetParent(self._petCell, self._petListGo.transform, "petCell" .. index)

		go:SetActive(true)

		local scufflePetCell = GameUtil.AddLuaOnce(go, CampScufflePetCell)

		scufflePetCell:buildUI(go)
		scufflePetCell:init(index, id)
		table.insert(self._scufflePetCellList, scufflePetCell)
	end
end

function CampScuffleBanView:_removePetCellList()
	for i, v in ipairs(self._scufflePetCellList) do
		v:onReset()
	end

	table.clear(self._scufflePetCellList)
	goutil.clearChildren(self._petListGo)
end

function CampScuffleBanView:_showTipBoard(enumState)
	self._countDown = 1
	self._isCountdown = true

	self._tipBoard:SetActive(true)
	self._maskGo:SetActive(true)

	local txt

	if enumState == Enum.Ban then
		txt = "请选择本局禁用精灵"
		self._countDown = 1

		self._imgChangeTip:SetState(0)
	elseif enumState == Enum.RandomSet then
		txt = "开始随机分配精灵"

		self._imgChangeTip:SetState(1)
	elseif enumState == Enum.StartSetFmt then
		self._countDown = 1
		txt = "请开始布阵"

		self._imgChangeTip:SetState(2)
	end

	printInfo("test _showTipBoard", txt)
end

function CampScuffleBanView:_closeTipBoard()
	self._tipBoard:SetActive(false)
	self._maskGo:SetActive(false)
end

function CampScuffleBanView:_changeState()
	if self._curState == Enum.Default then
		self:_startBanState()
	elseif self._curState == Enum.Ban then
		self:_startRandomSetPet()
	elseif self._curState == Enum.RandomSet then
		self:_startSetFormationState()
	end
end

function CampScuffleBanView:_updatePoolPetsState()
	local internalTime = 0

	for i, v in ipairs(self._scufflePetCellList) do
		if v:isRandomSelectPet() then
			internalTime = internalTime + 0.1

			v:setRandomSelect(internalTime, self, self._rangeRect)
		else
			v:setRandomSelect()
		end
	end
end

function CampScuffleBanView:_showTxtTime(time)
	self._txtTime.text = string.format("剩余时间%ds", time)
end

function CampScuffleBanView:_removeTween()
	if self._tween then
		self._tween:Kill()

		self._tween = nil
	end
end

function CampScuffleBanView:_startWaitShow(time)
	self._isStartWaitShow = true
	self._waitCountdown = time

	self._waitShow:SetActive(true)
	self:_showWaitLeftTime(self._waitCountdown)
end

function CampScuffleBanView:_stopWaitShow()
	self._isStartWaitShow = false
end

function CampScuffleBanView:_endWaitShow()
	self:_stopWaitShow()
	self._waitShow:SetActive(false)
end

function CampScuffleBanView:_showWaitLeftTime(second)
	self._txtWait.text = string.format("剩余<color=#ff0000>%d</color>秒", second)
end

return CampScuffleBanView
