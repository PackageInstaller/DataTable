-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapter3MainView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapter3MainView", package.seeall)

local BoccaccioChapter3MainView = class("BoccaccioChapter3MainView", ViewComponent)

function BoccaccioChapter3MainView:ctor()
	BoccaccioChapter3MainView.super.ctor(self)
end

function BoccaccioChapter3MainView:unbindEvents()
	BoccaccioChapter3MainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnTip)
end

function BoccaccioChapter3MainView:bindEvents()
	BoccaccioChapter3MainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function BoccaccioChapter3MainView:buildUI()
	BoccaccioChapter3MainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnBuff = self:getGo("btnBuff")
	self._redBuff = self:getGo("btnBuff/red")
	self._txtDescBuff = self:getTxt("btnBuff/txtDesc")

	local cellProgress = self:getGo("prize/cell")
	local tabProgress = self:getGo("prize/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumDamage = self:getTxt("prize/damageNum/txtNum")

	local goCellStage = self:getGo("stage/tableview/tablecell")
	local goTabStage = self:getGo("stage/tableview")

	self._petitem = self:getGo("stage/petitem")

	goutil.setActive(self._petitem, false)

	self._tableviewStage = ScrollerList.create(goTabStage, goCellStage, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	local goCellPet = self:getGo("pets/tableview/tablecell")
	local goTabPet = self:getGo("pets/tableview")

	self._tableviewPet = ScrollerList.create(goTabPet, goCellPet, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
	self._emptyPet = self:getGo("pets/empty")
	self._con = self:getGo("con")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnTip = self:getGo("leftTop/btnTip")
end

function BoccaccioChapter3MainView:onExit()
	BoccaccioChapter3MainView.super.onExit(self)
	self._tableviewProgress:dispose()
	self._tableviewStage:dispose()
	self._tableviewPet:dispose()

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function BoccaccioChapter3MainView:onEnter()
	BoccaccioChapter3MainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapterInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapter3SignUpRes, self._handleSignUp, self)
	self.addGEvent(self, GlobalNotify.HandleBoccaccioChapter3SelectBuffId, self._handleSelectBuff, self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapterOneClickGainProgressPrizeRes, self._updatePrizes, self)

	self._subTabviewDic = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 580001
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	BoccaccioChapterController.instance:sendPM_BoccaccioChapterInfoReq(self._activityId)
end

function BoccaccioChapter3MainView:_updateUIByCfg()
	self._buffCfgs = BoccaccioChapterConfig.instance:getChapter3SignUpBuffDatas(self._activityId) or {}
	self._progressCfgs = BoccaccioChapterConfig.instance:getProgressPrizeDatas(self._activityId, BoccaccioChapterEnum.ChapterId_3) or {}
	self._stageCfgs = BoccaccioChapterConfig.instance:getChapter3StageDatas(self._activityId) or {}
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	local skinId = 17027
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[3] then
		local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, modelCfg[3], nil, true, x, y)
	end
end

function BoccaccioChapter3MainView:_updateUIByInfo()
	self._maxPassStageId = 0
	self._stageInfoMap = {}

	local petIdMap = {}

	self._curPetIds = {}

	local chapter3Info = BoccaccioChapterController.instance:getChapterInfo(self._activityId, BoccaccioChapterEnum.ChapterId_3)

	if chapter3Info then
		self._maxPassStageId = checknumber(chapter3Info.maxPassStageId)

		if not chapter3Info.stageInfo then
			local stageInfos = {}

			for _, stageInfo in ipairs(stageInfos) do
				self._stageInfoMap[checknumber(stageInfo.stageId)] = stageInfo

				if not stageInfo.hasConsumeCharacterId then
					for _, characterId in ipairs(stageInfo.hasConsumeCharacterId) do
						if not petIdMap[characterId] and BagPetsController.instance:hasPet(characterId) then
							table.insert(self._curPetIds, characterId)

							petIdMap[characterId] = true
						end
					end
				end
			end
		end
	end

	self._tableviewStage:reloadData(self._stageCfgs)
	self._tableviewStage:MoveCellToBegin(((self._maxPassStageId >= #self._stageCfgs or nil) and self._maxPassStageId) - 1)
	self._tableviewPet:reloadData(self._curPetIds)
	goutil.setActive(self._emptyPet, #self._curPetIds <= 0)
	self:_updatePrizes()
	self:_updateUIByBuffInfo()
	BoccaccioChapterController.instance:unlockPlot(self._activityId, BoccaccioChapterEnum.PolotUnlockType.EatPetCount, #self._curPetIds)
end

function BoccaccioChapter3MainView:_updateUIByBuffInfo()
	self._hasSignUpDays = 0
	self._isSignUpToday = false

	local isBuffLVMax = false

	self._canSignUp = false

	local chapter3Info = BoccaccioChapterController.instance:getChapterInfo(self._activityId, BoccaccioChapterEnum.ChapterId_3)

	if chapter3Info then
		self._hasSignUpDays = checknumber(chapter3Info.hasSignUpDays)
		self._isSignUpToday = chapter3Info.isSignUpToday
	end

	if self._buffCfgs and #self._buffCfgs > 0 then
		local maxBuffCfg = self._buffCfgs[#self._buffCfgs]

		isBuffLVMax = self._hasSignUpDays >= checknumber(maxBuffCfg.signUpDay)
	end

	self._canSignUp = not self._isSignUpToday and not isBuffLVMax

	goutil.setActive(self._redBuff, self._canSignUp)
	self:_updateUIByBuffId()
end

function BoccaccioChapter3MainView:_updateUIByBuffId()
	local selectedBuffId = BoccaccioChapterController.instance:getChapter3SelectedBuffId(self._activityId) or 0

	if selectedBuffId > #self._buffCfgs then
		selectedBuffId = 0

		BoccaccioChapterController.instance:setChapter3SelectedBuffId(self._activityId, 0)
	end

	local isExistTrueBuff = false

	for _, cfg in ipairs(self._buffCfgs) do
		if cfg.signUpDay <= self._hasSignUpDays then
			isExistTrueBuff = true

			break
		end
	end

	local selectedBuffCfg

	for _, cfg in ipairs(self._buffCfgs) do
		if cfg.buffId == selectedBuffId then
			selectedBuffCfg = cfg

			break
		end
	end

	self._txtDescBuff.text = selectedBuffCfg and selectedBuffCfg.buffDesc or isExistTrueBuff and "无效果(可切换)" or "无效果"
	self._txtDescBuff.text = lang("点击\n切换")

	if self._canSignUp then
		self._txtDescBuff.text = lang("点击\n签到")
	end
end

function BoccaccioChapter3MainView:_updatePrizes()
	self._maxPassStageId = 0
	self._maxGainProgressId = 0

	local chapter3Info = BoccaccioChapterController.instance:getChapterInfo(self._activityId, BoccaccioChapterEnum.ChapterId_3)

	if chapter3Info then
		self._maxPassStageId = checknumber(chapter3Info.maxPassStageId)
		self._maxGainProgressId = checknumber(chapter3Info.maxGainProgressId)
	end

	local showIndex = -1
	local lastIndex = -1
	local scoreList = {}

	for index, cfg in ipairs(self._progressCfgs) do
		if self._maxPassStageId >= checknumber(cfg.progress) then
			if self._maxGainProgressId < checknumber(cfg.progressId) then
				if showIndex < 0 then
					showIndex = index
				end
			else
				lastIndex = index
			end
		end

		table.insert(scoreList, checknumber(cfg.progress))
	end

	if lastIndex <= 0 then
		lastIndex = 1
	end

	if showIndex < 0 then
		showIndex = lastIndex
	end

	self._tableviewProgress:updateUnderSlider(self._progressBar, self._maxPassStageId, scoreList)
	self._tableviewProgress:reloadData(self._progressCfgs)
	self._tableviewProgress:MoveCellToBegin(showIndex - 1)

	self._txtNumDamage.text = self._maxPassStageId
end

function BoccaccioChapter3MainView:_handleSignUp()
	self:_updateUIByBuffInfo()
end

function BoccaccioChapter3MainView:_handleSelectBuff()
	self:_updateUIByBuffId()
end

function BoccaccioChapter3MainView:_onClickBuff()
	UIStateManager.instance:push(ViewName.BoccaccioChapter3BuffView, self._activityId)
end

function BoccaccioChapter3MainView:_updateProgressCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data.prize, item)

	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = data.progress

	local isGain = self._maxGainProgressId >= checknumber(data.progressId)
	local isMatchGain = not isGain and self._maxPassStageId >= checknumber(data.progress)
	local btnGet = goutil.findChild(cell.gameObject, "btnGet")

	goutil.setActive(btnGet, isMatchGain)

	local effect = goutil.findChild(cell.gameObject, "effect")

	if isMatchGain then
		self:_playCellEffect(effect)
		GameUtil.addClickHandler(btnGet, self._onClickGainPrize, self)
	else
		self:_clearCellEffect(effect)
	end

	local geted = goutil.findChild(cell.gameObject, "geted")

	goutil.setActive(geted, isGain)
end

function BoccaccioChapter3MainView:_clearProgressCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	if item then
		MaterialMgr.resetAll(item)
	end

	local btnGet = goutil.findChild(cell.gameObject, "btnGet")

	if btnGet then
		GameUtil.rmClickHandler(btnGet)
	end

	local effect = goutil.findChild(cell.gameObject, "effect")

	if effect then
		self:_clearCellEffect(effect)
	end
end

function BoccaccioChapter3MainView:_onClickGainPrize()
	BoccaccioChapterController.instance:sendPM_BoccaccioChapterOneClickGainProgressPrizeReq(self._activityId, BoccaccioChapterEnum.ChapterId_3)
end

function BoccaccioChapter3MainView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("prize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function BoccaccioChapter3MainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function BoccaccioChapter3MainView:_updateStageCell(view, cell, data)
	local go = cell.gameObject
	local btnClg = goutil.findChild(go, "btnClg")
	local txtStage = goutil.findChildTextComponent(go, "txtStage")
	local empty = goutil.findChild(go, "empty")

	txtStage.text = langPara("第<size=54>%d</size>关", checknumber(data.stageId))

	GameUtil.addClickHandler(btnClg, GameUtil.handler(self._onClickStageClg, self, data.stageId), self)
	goutil.setActive(btnClg, data.stageId <= self._maxPassStageId + 1)

	local subTabview = self._subTabviewDic[go]
	local goPetList = goutil.findChild(go, "petlist")

	if not subTabview and goPetList then
		subTabview = ScrollerList.create(goPetList, self._petitem, GameUtil.handler(self._updateStageCellPet, self), GameUtil.handler(self._clearStageCellPet, self))
		self._subTabviewDic[go] = subTabview
	end

	if subTabview then
		local stageInfo = self._stageInfoMap[checknumber(data.stageId)]
		local petIds = {}

		if stageInfo then
			if not stageInfo.hasConsumeCharacterId then
				for _, characterId in ipairs(stageInfo.hasConsumeCharacterId) do
					if BagPetsController.instance:hasPet(characterId) then
						table.insert(petIds, characterId)
					end
				end
			end
		end

		subTabview:reloadData(petIds)
		subTabview:dragNotifyParent()
		goutil.setActive(empty, #petIds == 0)
	end
end

function BoccaccioChapter3MainView:_clearStageCell(cell)
	local go = cell.gameObject
	local tableview = self._subTabviewDic[go]

	if tableview then
		tableview:dispose()
		tableview:removeDragNotifyParent()

		self._subTabviewDic[go] = nil
	end

	local btnClg = goutil.findChild(go, "btnClg")

	GameUtil.rmClickHandler(btnClg)
end

function BoccaccioChapter3MainView:_onClickStageClg(stageId)
	BoccaccioChapterController.instance:enterBattleC3(self._activityId, stageId)
end

function BoccaccioChapter3MainView:_updateStageCellPet(view, cell, data)
	local petMo = BagPetsController.instance:getPet(data)
	local proxy = MaterialMgr.setCellByMo(petMo, cell.gameObject)

	if proxy then
		proxy.binder:setAutoTips(false)
	end
end

function BoccaccioChapter3MainView:_clearStageCellPet(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function BoccaccioChapter3MainView:_updateCellPet(view, cell, data)
	local petMo = BagPetsController.instance:getPet(data)
	local proxy = MaterialMgr.setCellByMo(petMo, cell.gameObject)
end

function BoccaccioChapter3MainView:_clearCellPet(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function BoccaccioChapter3MainView:_onClickBtnTip()
	BoccaccioChapterController.instance:openChapterRule(self._activityId, BoccaccioChapterEnum.ChapterId_3)
end

return BoccaccioChapter3MainView
