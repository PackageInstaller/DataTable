-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushFmtView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushFmtView", package.seeall)

local AbyssGoldRushFmtView = class("AbyssGoldRushFmtView", ViewComponent)
local STAGE_FORMATION = 1
local STAGE_HOLYSTIPE = 2
local holyStripePosition = {
	{
		rotate = 90,
		x = -42.2,
		y = -203.9
	},
	{
		rotate = 45,
		x = 6.7,
		y = -75.7
	},
	{
		rotate = 0,
		x = 137.1,
		y = -27.9
	},
	{
		rotate = -45,
		x = 266.7,
		y = -76.8
	},
	{
		rotate = -90,
		x = 316.4,
		y = -204.1
	}
}

function AbyssGoldRushFmtView:ctor()
	AbyssGoldRushFmtView.super.ctor(self)
end

function AbyssGoldRushFmtView:unbindEvents()
	AbyssGoldRushFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPrizeDetail)
	GameUtil.rmClickHandler(self._btnHolyStripe)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._changeBtn)
	self._customInput:RemoveListener()
end

function AbyssGoldRushFmtView:bindEvents()
	AbyssGoldRushFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPrizeDetail, self._onClickShowPrizeDetail, self)
	GameUtil.addClickHandler(self._btnHolyStripe, self._onClickHolyStripe, self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._changeBtn, self._onClickChange, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function AbyssGoldRushFmtView:buildUI()
	AbyssGoldRushFmtView.super.buildUI(self)

	self._btnPrizeDetail = self:getGo("prize/btnPrizeDetail")
	self._btnHolyStripe = self:getGo("btnHolyStripe")
	self._btnHide = self:getGo("rightRoot/btnHide")
	self._rightRoot = self:getGo("rightRoot")
	self._txtPrize = self:getTxt("prize/txtPrize")
	self._bubblePrize = self:getGo("prize/bubblePrize")
	self._customInput = UICustomInput.Get(self._bubblePrize)
	self._txtCoin = self:getTxt("myCoin/txtCoin")
	self._coinIcon = self:getGo("myCoin/icon")
	self._txtTime = self:getTxt("stageTime/txtTime")
	self._changeBtn = self:getGo("rightRoot/changeBtn")

	self:_buildEquipItems()

	self._txtName = self:getTxt("rightRoot/attrRoot/txtName")
	self._txtEffect = self:getTxt("rightRoot/attrRoot/txtEffect")
	self._planTableview = self:getGo("rightRoot/planTableview")
	self._planTablecell = self:getGo("rightRoot/planTablecell")
	self._planTableList = ScrollerList.create(self._planTableview, self._planTablecell, GameUtil.handler(self._updatePlanCell, self), GameUtil.handler(self._clearPlanCell, self))
	self._txtPrizeDesc = self:getTxt("prize/bubblePrize/txtPrizeDesc")
end

function AbyssGoldRushFmtView:_buildEquipItems()
	local equipCell = self:getGo("rightRoot/equipRoot/cell1")
	local equipRoot = self:getGo("rightRoot/equipRoot")

	self._equipItems = {}

	local goList = {
		equipCell
	}

	for i = 2, 5 do
		goList[i] = goutil.cloneAndSetParent(equipCell, equipRoot.transform, "cell" .. i)
	end

	for i, go in ipairs(goList) do
		local btn = Framework.ButtonAdapter.GetFrom(go, "raycast")
		local icon = goutil.findChild(go, "icon")
		local lvText = goutil.findChildTextComponent(go, "lvText")
		local nameText = goutil.findChildTextComponent(go, "nameText")
		local effect = goutil.findChild(go, "effect")
		local redpoint = goutil.findChild(go, "redpoint")
		local select = goutil.findChild(go, "select")
		local quality = goutil.findChild(go, "quality")
		local qualityUIChange = goutil.findChildComponent(go, "quality", "UIImageSpriteChange")

		self._equipItems[i] = {
			btn = btn,
			icon = icon,
			lvText = lvText,
			effect = effect,
			nameText = nameText,
			redPoint = redpoint,
			select = select,
			quality = quality,
			qualityUIChange = qualityUIChange
		}

		local pos = holyStripePosition[i]

		GameUtil.setAnchoredPos(go, pos.x, pos.y)

		if select then
			Framework.TransformUtil.SetLocalRotation(select.transform, 0, 0, pos.rotate)
		end

		if quality then
			Framework.TransformUtil.SetLocalRotation(quality.transform, 0, 0, pos.rotate)
		end
	end
end

function AbyssGoldRushFmtView:onExit()
	AbyssGoldRushFmtView.super.onExit(self)
	removetimer(self._onClock, self)
end

function AbyssGoldRushFmtView:onEnter()
	AbyssGoldRushFmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.AbyssGoldRushFormationConfirm, self._onConfirmFormation, self)
	self.addGEvent(self, GlobalNotify.AbyssGoldRushPresetUse, self._onPresetChange, self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo.activityId
	self._activityCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
	self._gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

	local nextStepId = AbyssGoldRushGameController.instance:getNextStepId(self._activityId)
	local stepCfg = AbyssGoldRushConfig.instance:getStepCfg(self._activityId, nextStepId)
	local roundCfg = AbyssGoldRushConfig.instance:getRoundCfg(self._activityId, stepCfg.roundId)

	self._txtPrize.text = roundCfg.prizeDesc

	local actCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
	local matType, matId, _ = MaterialMgr.getMatParams(actCfg.fakeItem)

	MaterialMgr.setIcon(self._coinIcon, matType, matId)

	self._txtCoin.text = AbyssGoldRushModel.instance:getAbyssCoinCount(self._activityId) - -self._gameInfo.baseInfo.decCoin

	self._fmtMo:setFormationStage(STAGE_FORMATION)

	self._txtPrizeDesc.text = actCfg.prizeDesc
	self._changeTime = self._activityCfg.formationTime
	self._txtTime.text = langPara("布阵时间:%s", self._changeTime)

	GameUtil.SetActive(self._bubblePrize, false)
	settimer(1, self._onClock, self, true)

	self._curSelectIndex = 1
	self._presetList = {}

	for i = 1, self._activityCfg.presetCount do
		table.insert(self._presetList, i)
	end

	self:_refreshView()
end

function AbyssGoldRushFmtView:_refreshView()
	self._curPresetId = AbyssGoldRushGameModel.instance:getUsePresetId()

	local curPresetIds = AbyssGoldRushGameModel.instance:getPresetIds(self._curPresetId)

	self._posDataList = {}

	for i, v in ipairs(curPresetIds) do
		self._posDataList[i] = v
	end

	self:_setEquipItems()

	local selectItem = self._posDataList[self._curSelectIndex]

	if selectItem and checknumber(selectItem.defineId) > 0 then
		local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(selectItem.defineId)

		self._txtName.text = holyStripeCfg.effectName
		self._txtEffect.text = holyStripeCfg.effectDesc
	else
		self._txtName.text = lang("无")
		self._txtEffect.text = lang("无")
	end

	self._planTableList:reloadData(self._presetList)
end

function AbyssGoldRushFmtView:_setEquipItems()
	for i, v in ipairs(self._equipItems) do
		v.lvText.text = ""
		v.nameText.text = ""

		v.btn:RemoveClickListener()
		v.btn:AddClickListener(function()
			self:_onItemBtnClick(i)
		end)
		goutil.setActive(v.icon, false)
		goutil.setActive(v.quality, false)
		MaterialMgr:clearIcon(v.icon)

		if v.select then
			goutil.setActive(v.select, self._curSelectIndex == i)
		end

		goutil.setActive(v.redPoint, false)
	end

	for posType, v in pairs(self._posDataList) do
		if checknumber(v.id) > 0 then
			local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(v.defineId)
			local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)
			local iconGo = self._equipItems[posType].icon
			local quality = self._equipItems[posType].quality
			local qualityUIChange = self._equipItems[posType].qualityUIChange

			self._equipItems[posType].lvText.text = ""

			local _, color
			local var_9_0, var_9_1 = PetEquipController:GetQualityStrByNum(targetCfg.quality)

			_ = var_9_0
			self._equipItems[posType].nameText.text = langPara("<color=%s>%s</color>", var_9_1, targetCfg.name)

			goutil.setActive(quality, true)
			qualityUIChange:SetState(targetCfg.quality)
			MaterialMgr.setIcon(iconGo, MatType.HolyStripe, targetCfg.id)
			goutil.setActive(iconGo, true)
			self._equipItems[posType].btn:RemoveClickListener()
			goutil.setActive(self._equipItems[posType].redPoint, false)
			self._equipItems[posType].btn:AddClickListener(function()
				self:_onItemBtnClick(posType)
			end)
		end
	end
end

function AbyssGoldRushFmtView:_resetEquipItems()
	for i, item in ipairs(self._equipItems) do
		item.btn:RemoveClickListener()
		MaterialMgr:clearIcon(item.icon)
		MaterialMgr.resetAll(item.icon)
	end
end

function AbyssGoldRushFmtView:_updatePlanCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local imgCur = goutil.findChild(go, "imgCur")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local btn = goutil.findChild(go, "btnSelect")

	nameText.text = langPara("方案%s", GameUtil.getChineseNumber(data))

	if AbyssGoldRushGameModel.instance:isInGame() == true then
		GameUtil.SetActive(imgCur, data == AbyssGoldRushGameModel.instance:getUsePresetId())
	else
		GameUtil.SetActive(imgCur, data == AbyssGoldRushModel.instance:getUsePresetId(self._activityId))
	end

	GameUtil.SetActive(imgSelect, data == self._curPresetId)
	GameUtil.addClickHandler(btn, function()
		self:_onClickPreset(data)
	end)
end

function AbyssGoldRushFmtView:_clearPlanCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btnSelect")

	GameUtil.rmClickHandler(btn)
end

function AbyssGoldRushFmtView:_onClickPreset(presetId)
	AbyssGoldRushGameModel.instance:saveUsePresetId(presetId)
	self:_onPresetChange()
end

function AbyssGoldRushFmtView:_onItemBtnClick(posType)
	self._curSelectIndex = posType

	self:_refreshView()
end

function AbyssGoldRushFmtView:_onClock()
	self._changeTime = self._changeTime - 1

	local stageName = self._fmtMo.formationStage == STAGE_FORMATION and lang("布阵时间") or lang("调整时间")

	self._txtTime.text = langPara("%s:%s", stageName, self._changeTime)

	if self._changeTime <= 0 then
		if self._fmtMo.formationStage == STAGE_FORMATION then
			if self._fmtMo:isEmpty() == true then
				FloatWordMgr.instance:show(lang("当前阵型为空，已为您自动布阵，进入灵纹调整阶段"))
				GlobalDispatcher:dispatch(GlobalNotify.CustomMissionOneKey)
			else
				FloatWordMgr.instance:show(lang("进入灵纹调整阶段,不再能修改精灵"))
			end

			self._fmtMo:setFormationStage(STAGE_HOLYSTIPE)

			self._changeTime = self._activityCfg.holyStripeTime

			self._fmtMo:setFormationLock(true)
			self._fmtMo:showAllEnemyPets()
		else
			self._fmtMo:fightHandler()
			removetimer(self._onClock, self)
		end
	end
end

function AbyssGoldRushFmtView:_onClickShowPrizeDetail()
	GameUtil.SetActive(self._bubblePrize, true)
end

function AbyssGoldRushFmtView:_onClickHolyStripe()
	GameUtil.SetActive(self._rightRoot, true)
end

function AbyssGoldRushFmtView:_onClickHide()
	GameUtil.SetActive(self._rightRoot, false)
end

function AbyssGoldRushFmtView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._bubblePrize, false)
	end
end

function AbyssGoldRushFmtView:_onConfirmFormation()
	if self._fmtMo.formationStage == STAGE_FORMATION then
		if self._fmtMo:isEmpty() == true then
			FloatWordMgr.instance:show(lang("当前阵型为空，已为您自动布阵，进入灵纹调整阶段，不可更改上阵精灵"))
			GlobalDispatcher:dispatch(GlobalNotify.CustomMissionOneKey)
		else
			FloatWordMgr.instance:show(lang("灵纹调整阶段，不可更改上阵精灵"))
		end

		self._fmtMo:setFormationStage(STAGE_HOLYSTIPE)

		self._changeTime = self._activityCfg.holyStripeTime

		self._fmtMo:setFormationLock(true)
		self._fmtMo:showAllEnemyPets()

		local stageName = self._fmtMo.formationStage == STAGE_FORMATION and lang("布阵时间") or lang("调整时间")

		self._txtTime.text = langPara("%s:%s", stageName, self._changeTime)
	else
		self._fmtMo:fightHandler()
		removetimer(self._onClock, self)
	end
end

function AbyssGoldRushFmtView:_onClickChange()
	UIStateManager.instance:push(ViewName.AbyssGoldRushFmtBagView, self._activityId, self._fmtMo)
end

function AbyssGoldRushFmtView:_onPresetChange()
	self._fmtMo:checkUseHolyStripe()
	self._fmtMo:initPetList()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
	GlobalDispatcher:dispatch(GlobalNotify.BagPetChanged)
	self:_refreshView()
end

return AbyssGoldRushFmtView
