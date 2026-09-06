-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceClgView.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceClgView", package.seeall)

local AoQiAttackForceClgView = class("AoQiAttackForceClgView", ViewComponent)

function AoQiAttackForceClgView:ctor()
	AoQiAttackForceClgView.super.ctor(self)
end

function AoQiAttackForceClgView:unbindEvents()
	AoQiAttackForceClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for i, cell in ipairs(self._enterList) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function AoQiAttackForceClgView:bindEvents()
	AoQiAttackForceClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for i, cell in ipairs(self._enterList) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickBtnClg, self, i))
	end
end

function AoQiAttackForceClgView:buildUI()
	AoQiAttackForceClgView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")

	local cellGo = self:getGo("prizeItem")

	self._enterList = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("enterList/enterCell" .. i)
		cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.txtTips = goutil.findChildTextComponent(cell.go, "txtTips")
		cell.txtNum = goutil.findChildTextComponent(cell.go, "cost/txtNum")
		cell.iconCost = goutil.findChild(cell.go, "cost/img")

		local tableviewGo = goutil.findChild(cell.go, "itemScrollerview")

		cell.itemTableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		cell.itemTableview:setCenterMode(true)
		table.insert(self._enterList, cell)
	end

	self._txtCurStrength = self:getTxt("curStrength/txt")
	self._iconCurStrength = self:getGo("curStrength/icon")
end

function AoQiAttackForceClgView:onExit()
	AoQiAttackForceClgView.super.onExit(self)

	for i, cell in ipairs(self._enterList) do
		uGuiUtil.clearImage(cell.icon)
		uGuiUtil.clearImage(cell.iconCost)
		cell.itemTableview:dispose()
	end

	uGuiUtil.clearImage(self._iconCurStrength)
end

function AoQiAttackForceClgView:onEnter()
	AoQiAttackForceClgView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self:_updateByInfo()
	self.addGEvent(self, GlobalNotify.AQAFGetInfoRes, self._updateByInfo, self)
	AoQiAttackForceController.instance:getInfo(self._activityId)

	local tiliPath = GameUrl.getItemIconUrl(AoQiAttackForceConfig.instance:getTiliIconPath(self._activityId))

	uGuiUtil.setSpriteToImage(self._iconCurStrength, uGuiUtil.SpriteType.BigBg, tiliPath, function()
		local img = self._iconCurStrength:GetComponent(goutil.Type_UIImage)

		img.raycastTarget = false
	end)

	for i, cell in ipairs(self._enterList) do
		uGuiUtil.setSpriteToImage(cell.iconCost, uGuiUtil.SpriteType.BigBg, tiliPath, function()
			local img = cell.iconCost:GetComponent(goutil.Type_UIImage)

			img.raycastTarget = false
		end)
	end
end

function AoQiAttackForceClgView:_updateByInfo()
	self._actCfg = AoQiAttackForceConfig.instance:getActivityCfg(self._activityId)

	local baseInfo = AoQiAttackForceModel.instance:getBaseInfoByActId(self._activityId)
	local challengeInfos = baseInfo.challenges

	self._curPassWaveMap = {}

	for _, info in pairs(challengeInfos) do
		self._curPassWaveMap[info.challengeId] = info.bestWaveId
	end

	for i, cell in ipairs(self._enterList) do
		local clgCfg = AoQiAttackForceConfig.instance:getChallengeCfg(self._activityId, i)
		local waveTotalNums = AoQiAttackForceConfig.instance:getChallengeWaveTotalNums(self._activityId, i)
		local curWaves = checknumber(self._curPassWaveMap[i])
		local tips = "暂无记录"

		if waveTotalNums <= curWaves then
			tips = "已通关\n可扫荡获得奖励"
		elseif curWaves > 0 then
			tips = string.format("最高记录：%s波次", curWaves)
		end

		cell.txtTips.text = tips
		cell.txtNum.text = clgCfg.strength

		if clgCfg then
			if not clgCfg.showPrize then
				local prize = ""
				local itemList = string.split(prize, "#")

				cell.itemTableview:reloadData(itemList)

				cell.txtTitle.text = clgCfg.enterName

				local itemPath = GameUrl.getItemIconUrl(clgCfg.itemPath)

				uGuiUtil.setSpriteToImage(cell.icon, uGuiUtil.SpriteType.BigBg, itemPath, function()
					local img = cell.icon:GetComponent(goutil.Type_UIImage)

					img.raycastTarget = false
				end)
			end
		end
	end

	self._txtCurStrength.text = string.format("%s/%s", self._actCfg.dailyStrength - baseInfo.dailyUsedStrength, self._actCfg.dailyStrength)
end

function AoQiAttackForceClgView:_onClickBtnClg(challengeId)
	local baseInfo = AoQiAttackForceModel.instance:getBaseInfoByActId(self._activityId)
	local leftStrength = self._actCfg.dailyStrength - baseInfo.dailyUsedStrength
	local clgCfg = AoQiAttackForceConfig.instance:getChallengeCfg(self._activityId, challengeId)
	local waveTotalNums = AoQiAttackForceConfig.instance:getChallengeWaveTotalNums(self._activityId, challengeId)
	local curWaves = checknumber(self._curPassWaveMap[challengeId])

	if leftStrength < clgCfg.strength then
		TipsFacade.instance:openCommonTips("体力不足，请凌晨5点后再来挑战吧")

		return
	end

	if waveTotalNums <= curWaves then
		local tips = string.format("已通关，是否花费%s体力进行扫荡？", clgCfg.strength)

		TipsFacade.instance:openTipWindow("提示", tips, function()
			AoQiAttackForceController.instance:sweepClg(self._activityId, challengeId)
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)
	else
		local limitNum = self._actCfg.useEquipmentLimit

		if baseInfo then
			if not baseInfo.equipments then
				local equipInfos = {}
				local curUnlockNum = 0
				local curUseNum = 0

				for _, equipInfo in ipairs(equipInfos) do
					if equipInfo.isUsed then
						curUseNum = curUseNum + 1
					end

					if equipInfo.level > 0 then
						curUnlockNum = curUnlockNum + 1
					end
				end

				local isMatch = false

				isMatch = limitNum < curUnlockNum and curUseNum == limitNum or curUseNum == curUnlockNum

				if not isMatch then
					local tips = "前方挑战艰难，请上阵更多装备，提高胜算"

					TipsFacade.instance:openTipWindow("提示", tips, nil, "确定", UnityEngine.TextAnchor.MiddleCenter)

					return
				end

				local tips = string.format("是否花费%s体力进入战斗？", clgCfg.strength)

				TipsFacade.instance:openTipWindow("提示", tips, function()
					AoQiAttackForceController.instance:startClg(self._activityId, challengeId)
				end, "确定", UnityEngine.TextAnchor.MiddleCenter)
			end
		end
	end
end

function AoQiAttackForceClgView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function AoQiAttackForceClgView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function AoQiAttackForceClgView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return AoQiAttackForceClgView
