-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanbreakView.lua

module("logic.extensions.beastrichman.view.BeastrichmanbreakView", package.seeall)

local BeastrichmanbreakView = class("BeastrichmanbreakView", ViewComponent)

function BeastrichmanbreakView:ctor()
	BeastrichmanbreakView.super.ctor(self)
end

function BeastrichmanbreakView:unbindEvents()
	BeastrichmanbreakView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function BeastrichmanbreakView:bindEvents()
	BeastrichmanbreakView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function BeastrichmanbreakView:buildUI()
	BeastrichmanbreakView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))
	self._scrollerList:setCenterMode(true)

	self._txtDesc = self:getTxt("tablecell/desc/txtDesc")
end

function BeastrichmanbreakView:onExit()
	BeastrichmanbreakView.super.onExit(self)
	self._scrollerList:dispose()
end

function BeastrichmanbreakView:onEnter()
	BeastrichmanbreakView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._zoneId = params[2]
	self._beastType = params[3]
	self._beastId = params[4]
	self._playerGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)
	self._gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._playerGridId)
	self._stageInfo = BeastRichmanModel.instance:getStageInfo(self._activityId, self._beastId)

	if self._stageInfo then
		self._passStageId = self._stageInfo.stageId or 0
	end

	self:_updateUI()
end

function BeastrichmanbreakView:_updateUI()
	self:_updateFormations()
end

function BeastrichmanbreakView:_updateFormations()
	local stageCfgs = BeastRichmanConfig.instance:getBeakStageCfgs(self._activityId, self._beastId)

	self._scrollerList:reloadData(stageCfgs)
end

function BeastrichmanbreakView:_updateCell(view, cell, stageCfg, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passGo = goutil.findChild(cell.gameObject, "btn/pass")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txtName")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "desc/txtDesc")
	local txtBuffDesc = goutil.findChildTextComponent(cell.gameObject, "buff/txtDesc")
	local txtBtn = goutil.findChildTextComponent(cell.gameObject, "btn/txtBtn")
	local isPass = self._passStageId >= stageCfg.stageId
	local creepsMasterId = stageCfg.creepsMasterId
	local posList = {}

	txtBtn.text = "进入挑战"

	if isPass then
		txtBtn.text = "已通关"
	end

	for i = 1, 9 do
		local petPosCell = {}

		petPosCell.go = goutil.findChild(cell.gameObject, "formation/cell_" .. i)
		petPosCell.con = goutil.findChild(petPosCell.go, "con")
		posList[i] = petPosCell
	end

	self:_petPosReset(posList)

	local creepsCfgs = BeastRichmanConfig.instance:getCreepsCfgs(creepsMasterId)

	for i, v in ipairs(creepsCfgs) do
		local cellCfg = creepsCfgs[i]

		if cellCfg.posId > 0 then
			GameUtil.SetActive(posList[cellCfg.posId].go, true)

			local faceId = checknumber(cellCfg.faceId) > 0 and checknumber(cellCfg.faceId) or cellCfg.raceId
			local modelCo = CharacterConfig.instance:getModelCo(faceId)

			uGuiUtil.setSpriteToImage(posList[cellCfg.posId].con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end
	end

	btn:AddClickListener(function()
		if self._passStageId + 1 < stageCfg.stageId then
			FloatWordMgr.instance:show("先完成前面关卡")

			return
		end

		local gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._playerGridId)

		if gridCfg.beastType ~= self._beastType or self._beastId ~= gridCfg.beastId then
			FloatWordMgr.instance:show("当前距离瑞兽过远，请站到指定的格子上再来挑战吧！")

			return
		end

		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		end

		local fmtMo = BeastRichmanModel.instance:getBreakFmtMo()

		fmtMo:initParams(self._activityId, self._zoneId, self._beastId, stageCfg.stageId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end)

	local masterCfg = BeastRichmanConfig.instance:getMasterCfg(creepsMasterId)

	txtName.text = string.format("第%s关", stageCfg.stageId)
	txtDesc.text = masterCfg.WinDesc

	GameUtil.SetGray(btn, isPass)

	txtBuffDesc.text = string.format("每分钟可获得%s银票的收益\n通关本关卡后累计获得\n%s排名积分", stageCfg.hanging, stageCfg.rankScore)
end

function BeastrichmanbreakView:_petPosReset(posList)
	for i = 1, #posList do
		GameUtil.SetActive(posList[i].go, false)
		uGuiUtil.clearImage(posList[i].con)
	end
end

function BeastrichmanbreakView:_clearCell(cell)
	return
end

function BeastrichmanbreakView:_onClickbtnTip()
	local actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)
	local key = actCfg.stageBossRuleKey

	TipsFacade.instance:openRulesView(key)
end

function BeastrichmanbreakView:_onClickbtnClose()
	DivinewatertianyanModel.instance:setCurrStageType(nil)
	self:close()
end

function BeastrichmanbreakView:_onReloadFinish()
	local stageCfgs = BeastRichmanConfig.instance:getBeakStageCfgs(self._activityId, self._beastId)

	if self._passStageId >= stageCfgs[#stageCfgs].stageId then
		self._scrollerList:MoveCellToBegin(#stageCfgs - 1)
	else
		for i, v in ipairs(stageCfgs) do
			if self._passStageId + 1 == v.stageId then
				self._scrollerList:MoveCellToBegin(i - 1)

				break
			end
		end
	end
end

function BeastrichmanbreakView:_updateRewardCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	local isCanGet = self._normalProgress >= data.progress
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function BeastrichmanbreakView:_onClickGetPrize(data)
	local isCanGet = self._normalProgress >= data.progress
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	if isCanGet and not isGainPrize then
		OriginAresMomClgAgent.instance:sendPM_OriginAresMomClgGainNormalPrizeReq(self._activityId, data.prizeId)
	end
end

function BeastrichmanbreakView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function BeastrichmanbreakView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progressReward/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function BeastrichmanbreakView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return BeastrichmanbreakView
