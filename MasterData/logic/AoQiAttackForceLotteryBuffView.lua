-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceLotteryBuffView.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceLotteryBuffView", package.seeall)

local AoQiAttackForceLotteryBuffView = class("AoQiAttackForceLotteryBuffView", ViewComponent)
local MAX_SELECT_BUFF = 6

function AoQiAttackForceLotteryBuffView:ctor()
	AoQiAttackForceLotteryBuffView.super.ctor(self)
end

function AoQiAttackForceLotteryBuffView:unbindEvents()
	AoQiAttackForceLotteryBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBag)
	GameUtil.rmClickHandler(self._btnExit)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnGain)
end

function AoQiAttackForceLotteryBuffView:bindEvents()
	AoQiAttackForceLotteryBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBag, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnExit, self._onClickExit, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnGain, self._onClickGain, self)
end

function AoQiAttackForceLotteryBuffView:buildUI()
	AoQiAttackForceLotteryBuffView.super.buildUI(self)

	self._txtCoin = self:getTxt("txtCoin")
	self._iconCoin = self:getGo("txtCoin/icon")
	self._lottery = self:getGo("lottery")
	self._lotteryCell = self:getGo("lottery/cell")
	self._lotteryContainer = self:getGo("lottery/lotteryContainer")
	self._lotteryArrow = self:getGo("lottery/arrow")
	self._lotteryCost = self:getGo("lottery/cost")
	self._txtLotteryFreeTime = self:getTxt("lottery/cost/txtFree")
	self._iconLotteryCost = self:getGo("lottery/cost/cost")
	self._txtLotteryCost = self:getTxt("lottery/cost/cost/txtCost")
	self._arrow = self:getGo("lottery/arrow")
	self._gainBuff = self:getGo("gainBuff")
	self._gainBuffCell = self:getGo("gainBuff/cell")
	self._txtNameGainBuff = self:getTxt("gainBuff/cell/txtName")
	self._txtDescGainBuff = self:getTxt("gainBuff/cell/txtDesc")
	self._iconGainBuff = self:getGo("gainBuff/cell/BuffIcon")
	self._btnBag = self:getGo("btnBag")
	self._btnExit = self:getGo("btnExit")
	self._btnLottery = self:getGo("lottery/btnLottery")
	self._btnGain = self:getGo("gainBuff/btnGain")
end

function AoQiAttackForceLotteryBuffView:onExit()
	AoQiAttackForceLotteryBuffView.super.onExit(self)
	uGuiUtil.clearImage(self._iconCoin)
	uGuiUtil.clearImage(self._iconLotteryCost)
	removetimer(self._updateLotteryAnim, self)
	removetimer(self._onLotteryEnd, self)
end

function AoQiAttackForceLotteryBuffView:onEnter()
	AoQiAttackForceLotteryBuffView.super.onEnter(self)

	self._curActCfg = AoQiAttackForceModel.instance:getCurActCfg()
	self._curBuffIds, limit = AoQiAttackForceModel.instance:getRandomBuffList(MAX_SELECT_BUFF)
	self._curGainBuffIdMap = {}

	local curEquipsInGame = AoQiAttackForceModel.instance:getCurEquipsInGame()

	self._curEquipMap = {}

	for i, equip in ipairs(curEquipsInGame) do
		self._curEquipMap[equip.defineId] = true
	end

	GameUtil.SetActive(self._lottery, true)
	GameUtil.SetActive(self._gainBuff, false)
	self:_refreshBuff()

	local coinPath = GameUrl.getItemIconUrl(AoQiAttackForceConfig.instance:getCoinIconPath(self._curActCfg.activityId))

	uGuiUtil.setSpriteToImage(self._iconCoin, uGuiUtil.SpriteType.BigBg, coinPath, function()
		local img = self._iconCoin:GetComponent(goutil.Type_UIImage)
	end)
	uGuiUtil.setSpriteToImage(self._iconLotteryCost, uGuiUtil.SpriteType.BigBg, coinPath, function()
		local img = self._iconLotteryCost:GetComponent(goutil.Type_UIImage)
	end)
end

function AoQiAttackForceLotteryBuffView:_getAvailableBuffIds()
	local list = {}

	if not self._curBuffIds then
		return list
	end

	for _, buffId in ipairs(self._curBuffIds) do
		if self._curGainBuffIdMap[buffId] ~= true then
			table.insert(list, buffId)
		end
	end

	return list
end

function AoQiAttackForceLotteryBuffView:_getRandomBuffIdByWeight(buffIds)
	if not buffIds or #buffIds <= 0 then
		return nil
	end

	if AoQiAttackForceModel.instance:getIsEndlessState() then
		local var_10_0 = AoQiAttackForceModel.instance:getCurClgCfg().buffPlan

		if not var_10_0 then
			var_10_0 = AoQiAttackForceModel.instance:getCurWaveCfg().buffPlan

			local curBuffPlan = var_10_0
			local buffPlanCfgs = AoQiAttackForceConfig.instance:getBuffPlanInGameCfg(curBuffPlan) or {}
			local weightMap = {}

			for _, cfg in ipairs(buffPlanCfgs) do
				weightMap[cfg.buffId] = cfg.weight or 0
			end

			local totalWeight = 0

			for _, buffId in ipairs(buffIds) do
				totalWeight = totalWeight + (weightMap[buffId] or 0)
			end

			if totalWeight <= 0 then
				local randomIndex = math.random(1, #buffIds)

				return buffIds[randomIndex]
			end

			local randomWeight = math.random(1, totalWeight)
			local curWeight = 0

			for _, buffId in ipairs(buffIds) do
				curWeight = curWeight + (weightMap[buffId] or 0)

				if randomWeight <= curWeight then
					return buffId
				end
			end

			return buffIds[#buffIds]
		end
	end
end

function AoQiAttackForceLotteryBuffView:_refreshBuff()
	self._curDataList = {}

	for i, buffId in ipairs(self._curBuffIds) do
		local data = {}

		data.index = i
		data.buffId = buffId
		data.cfg = AoQiAttackForceConfig.instance:getBuffCfgInGameCfg(buffId)

		table.insert(self._curDataList, data)
	end

	for i = #self._curDataList + 1, MAX_SELECT_BUFF do
		table.insert(self._curDataList, {
			buffId = 0,
			index = i
		})
	end

	if #self._curBuffIds <= 0 then
		UIStateManager.instance:push(ViewName.AoqiattackbackpackView)
		self:close()

		return
	end

	self._txtCoin.text = AoQiAttackForceModel.instance:getCurCoinNum()

	local waveCfg = AoQiAttackForceModel.instance:getCurWaveCfg()
	local lotteryCfgs = AoQiAttackForceConfig.instance:getHeroChallengeLotteryClgs(waveCfg.lotteryPlanId)
	local curCostTime = -AoQiAttackForceModel.instance:getCurBuffTimes()

	curCostTime = curCostTime >= 0 and curCostTime + 1 or 0

	local curCostCfg

	for i, v in ipairs(lotteryCfgs) do
		if curCostTime >= v.count then
			curCostCfg = v
		end
	end

	if curCostCfg then
		self._txtLotteryCost.text = langPara("%s", curCostCfg.lotteryCost)
	end

	GameUtil.SetActive(self._iconLotteryCost, curCostTime > 0)
	GameUtil.SetActive(self._txtLotteryFreeTime, curCostTime <= 0)
	GameUtil.SetActive(self._lotteryCost, true)

	self._ramdomBuffGoMap = {}

	GameUtil.updateCells(self._lotteryContainer, self._curDataList, self._updateCell, self)
end

function AoQiAttackForceLotteryBuffView:_updateCell(cell, data, index)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local buffGo = goutil.findChild(cell.gameObject, "buff")
	local buffIcon = goutil.findChild(cell.gameObject, "buff/icon")
	local gainGo = goutil.findChild(cell.gameObject, "gain")
	local selectGo = goutil.findChild(cell.gameObject, "select")

	GameUtil.SetActive(selectGo, false)

	self._ramdomBuffGoMap[data.index] = selectGo

	uGuiUtil.clearImage(buffIcon)

	if data.cfg then
		txtName.text = data.cfg.name

		GameUtil.SetActive(gainGo, self._curGainBuffIdMap[data.buffId] == true)

		local picPath = string.format("%s.png", data.cfg.icon)

		uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, picPath)
		GameUtil.SetActive(buffGo, true)
	else
		txtName.text = ""

		GameUtil.SetActive(buffIcon)
		GameUtil.SetActive(gainGo, false)
		GameUtil.SetActive(buffGo, false)
	end
end

function AoQiAttackForceLotteryBuffView:_clearCell(cell)
	local buffIcon = goutil.findChild(cell.gameObject, "buff/icon")

	uGuiUtil.clearImage(buffIcon)
end

function AoQiAttackForceLotteryBuffView:startLottery()
	self._isLotteryRuning = true

	local skip = AoQiAttackForceModel.instance:getSkipLotteryBuffAnim()
	local availableBuffIds = self:_getAvailableBuffIds()

	if #availableBuffIds <= 0 then
		return
	end

	self._resultBuffId = self:_getRandomBuffIdByWeight(availableBuffIds)

	if not self._resultBuffId or not self._curDataList or #self._curDataList <= 0 then
		return
	end

	GameUtil.SetActive(self._lotteryCost, false)

	self._txtCoin.text = AoQiAttackForceModel.instance:getCurCoinNum()

	local targetIndex

	for i, data in ipairs(self._curDataList) do
		if data.buffId == self._resultBuffId then
			targetIndex = i

			break
		end
	end

	if not targetIndex then
		return
	end

	if not skip then
		for _, go in pairs(self._ramdomBuffGoMap) do
			GameUtil.SetActive(go, false)
		end

		self._validAnimIndices = {}

		for i, data in ipairs(self._curDataList) do
			if data.buffId and data.buffId ~= 0 and data.cfg and self._curGainBuffIdMap[data.buffId] ~= true then
				table.insert(self._validAnimIndices, i)
			end
		end

		self._animStep = 0
		self._totalSteps = 12 + targetIndex
		self._animInterval = 0.1
		self._curAnimIndex = 0

		settimer(self._animInterval, self._updateLotteryAnim, self, true)
	else
		self:_onLotteryEnd()
	end
end

function AoQiAttackForceLotteryBuffView:_updateLotteryAnim()
	if self._curAnimIndex > 0 then
		local prevGo = self._ramdomBuffGoMap[self._curAnimIndex]

		GameUtil.SetActive(prevGo, false)
	end

	self._animStep = self._animStep + 1

	local validCount = #self._validAnimIndices

	if validCount > 0 then
		self._curAnimIndex = self._validAnimIndices[(self._animStep - 1) % validCount + 1]
	end

	if self._curAnimIndex > 0 then
		local curGo = self._ramdomBuffGoMap[self._curAnimIndex]

		GameUtil.SetActive(curGo, true)
	end

	if self._animStep >= self._totalSteps and self._totalSteps - 12 == self._curAnimIndex then
		removetimer(self._updateLotteryAnim, self)
		settimer(0.5, self._onLotteryEnd, self, false)
	end
end

function AoQiAttackForceLotteryBuffView:_onLotteryEnd()
	GameUtil.SetActive(self._gainBuff, true)

	local data

	for i, selectData in ipairs(self._curDataList) do
		if selectData.buffId == self._resultBuffId then
			data = selectData

			break
		end
	end

	if not data then
		return
	end

	uGuiUtil.clearImage(self._iconGainBuff)

	local picPath = string.format("%s.png", data.cfg.icon)

	uGuiUtil.setSpriteToImage(self._iconGainBuff, uGuiUtil.SpriteType.BigBg, picPath)

	self._txtNameGainBuff.text = data.cfg.name
	self._txtDescGainBuff.text = data.cfg.desc

	GameUtil.SetActive(self._lottery, false)

	self._isLotteryRuning = nil
end

function AoQiAttackForceLotteryBuffView:_onClickLottery()
	if self._isLotteryRuning == true then
		return
	end

	local availableBuffIds = self:_getAvailableBuffIds()

	if #availableBuffIds <= 0 then
		FloatWordMgr.instance:show(lang("已无可抽取增益"))

		return
	end

	local waveCfg = AoQiAttackForceModel.instance:getCurWaveCfg()
	local lotteryCfgs = AoQiAttackForceConfig.instance:getHeroChallengeLotteryClgs(waveCfg.lotteryPlanId)
	local curCostTime = -AoQiAttackForceModel.instance:getCurBuffTimes()

	curCostTime = curCostTime >= 0 and curCostTime + 1 or 0

	local curCostCfg

	for i, v in ipairs(lotteryCfgs) do
		if curCostTime >= v.count then
			curCostCfg = v
		end
	end

	local skip = AoQiAttackForceModel.instance:getSkipLotteryBuffAnim()

	if curCostCfg then
		local isEnough = curCostCfg.lotteryCost <= AoQiAttackForceModel.instance:getCurCoinNum()

		if isEnough == true then
			local content = langPara("是否确认消耗货币×%s，抽取一次祝福？", curCostCfg.lotteryCost)

			if not skip then
				TipsFacade.instance:openPopupWindowWithTog(lang("提示"), content, function()
					AoQiAttackForceModel.instance:costCoin(curCostCfg.lotteryCost)
					self:startLottery()
				end, nil, function()
					AoQiAttackForceModel.instance:setSkipLotteryBuffAnim()
				end)
			else
				TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
					AoQiAttackForceModel.instance:costCoin(curCostCfg.lotteryCost)
					self:startLottery()
				end)
			end
		else
			FloatWordMgr.instance:show(lang("货币不足"))
		end
	else
		self:startLottery()
	end
end

function AoQiAttackForceLotteryBuffView:_onClickBtnSelect(data)
	self._curSelectIndex = data.index

	self._tableview:reloadData(self._curDataList)
end

function AoQiAttackForceLotteryBuffView:_onClickBuff()
	UIStateManager.instance:push(ViewName.AoqiAttackallbuffView)
end

function AoQiAttackForceLotteryBuffView:_onClickExit()
	AoQiAttackForceModel.instance:recordWaveState()
	UIStateManager.instance:push(ViewName.AoqiattackbackpackView)
	self:close()
end

function AoQiAttackForceLotteryBuffView:_onClickGain()
	self:_selectBuff()
end

function AoQiAttackForceLotteryBuffView:_selectBuff()
	local buffIds = {}

	table.insert(buffIds, self._resultBuffId)

	self._curGainBuffIdMap[self._resultBuffId] = true

	AoQiAttackForceModel.instance:selectBuffs(buffIds)
	self:_refreshBuff()
	GameUtil.SetActive(self._lottery, true)
	GameUtil.SetActive(self._gainBuff, false)
	GameUtil.SetActive(self._btnExit, true)
end

return AoQiAttackForceLotteryBuffView
