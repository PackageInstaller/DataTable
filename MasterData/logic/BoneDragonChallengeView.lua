-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonChallengeView.lua

module("logic.extensions.bonedragon.view.BoneDragonChallengeView", package.seeall)

local BoneDragonChallengeView = class("BoneDragonChallengeView", ViewComponent)
local HAS_FINISH_FORMATION = -1

function BoneDragonChallengeView:ctor()
	BoneDragonChallengeView.super.ctor(self)
end

function BoneDragonChallengeView:unbindEvents()
	BoneDragonChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRestart)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function BoneDragonChallengeView:bindEvents()
	BoneDragonChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRestart, self._onClickBtnRestart, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
end

function BoneDragonChallengeView:buildUI()
	BoneDragonChallengeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnRestart = self:getGo("btnRestart")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtTime = self:getTxt("time/txt")
	self._itemPass = self:getGo("pass/itemPass")
	self._geted = self:getGo("pass/geted")
	self._tableViewPass = self:getGo("tableview/pass")
	self._formationPass = self:getGo("left/pass")
	self._posView = self:getGo("left/posView")
	self._posCell = self:getGo("left/posCell")
	self._imgTip = self:getGo("imgTip")
	self._tableviewPet = self:getGo("tableview")
	self._tablecellPet = self:getGo("tableview/tablecell")
	self._scrollListPet = ScrollerList.create(self._tableviewPet, self._tablecellPet, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._tableviewStage = self:getGo("tableviewStage")
	self._tablecell = self:getGo("tableviewStage/tablecell")
	self._scrollList = ScrollerList.create(self._tableviewStage, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BoneDragonChallengeView:onExit()
	BoneDragonChallengeView.super.onExit(self)

	for i, formationGo in ipairs(self._formationList) do
		local petHead = goutil.findChild(formationGo, "content/petHead")
		local btnPet = goutil.findChild(formationGo, "content/btnPet")

		MaterialMgr.resetAll(petHead)
		goutil.destroy(formationGo)
		GameUtil.rmClickHandler(formationGo)
		GameUtil.rmClickHandler(btnPet)
	end

	self._formationList = nil

	MaterialMgr.resetAll(self._itemPass)
end

function BoneDragonChallengeView:onEnter()
	BoneDragonChallengeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonClgResetRes, self._onReset, self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonClgSelectPetRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_BoneDragonClgSelectFormationRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 488001
	end

	self._actCfg = BoneDragonConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = BoneDragonConfig.instance:getStageCfgs(self._activityId)
	self._supportList = BoneDragonConfig.instance:getSupportPetIdList()

	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._illegalPosList = {}
	self._fightingPowerPetMo = FightingPowerPetMo.New()

	self:_initFormation()
	BoneDragonController.instance:sendPM_BoneDragonClgInfoReq(self._activityId)
end

function BoneDragonChallengeView:_initFormation()
	self._formationList = {}

	GameUtil.SetActive(self._posCell, true)

	for i = 1, BoneDragonModel.FORMATION_POS_NUM do
		local go = goutil.cloneAndSetParent(self._posCell, self._posView.transform, "posCell" .. i)

		table.insert(self._formationList, go)
	end

	GameUtil.SetActive(self._posCell, false)
end

function BoneDragonChallengeView:_updateFormation()
	local posLimitDic = BoneDragonConfig.instance:getFormationPosDicByStageId(self._activityId, self._curStageId, self._chooseFormationId)

	if self._formationList then
		for idx, formationGo in ipairs(self._formationList) do
			local contentGo = goutil.findChild(formationGo, "content")
			local imgSelect = goutil.findChild(formationGo, "imgSelect")
			local btnPet = goutil.findChild(formationGo, "content/btnPet")
			local bloodBg = goutil.findChild(formationGo, "content/bloodBg")
			local petHead = goutil.findChild(formationGo, "content/petHead")
			local jobChangeComp = goutil.findChild(formationGo, "content/tag/iconJob"):GetComponent(ComponentType.UIImageSpriteChange)
			local txtName = goutil.findChildTextComponent(formationGo, "content/tag/txtName")
			local txtBlood = goutil.findChildTextComponent(formationGo, "content/txtBlood")
			local txtPos = goutil.findChild(formationGo, "content/txtPos"):GetComponent(typeof(UIImgNumeralText))
			local jobName = posLimitDic[idx]
			local formationPetId = self._formationPetDic[idx]

			MaterialMgr.resetAll(petHead)

			if jobName then
				local jobId = GameEnum.JobZh[jobName]

				jobChangeComp:SetState(jobId - 1)

				txtName.text = jobName
			end

			if formationPetId ~= 0 then
				local skinId = 0
				local hp = ""
				local isSupportPet = table.indexof(self._supportList, formationPetId)
				local petMo

				if isSupportPet then
					local supportPetCfg = BoneDragonConfig.instance:getSupportCfg(formationPetId)

					skinId = checknumber(supportPetCfg.faceId)

					if checknumber(skinId) == 0 then
						skinId = checknumber(supportPetCfg.raceId)
					end

					hp = "100%"

					self._fightingPowerPetMo:fromChallengeCreepCo(supportPetCfg)

					petMo = self._fightingPowerPetMo:toBaseBagPetMo()
				else
					local curBagPetMo = BagPetsController.instance:getPet(formationPetId)
					local leftHp = BoneDragonModel.instance:getPetHp(self._activityId, formationPetId)

					if leftHp == -1 then
						hp = "100%"
					else
						hp = math.ceil(leftHp / curBagPetMo._maxHp * 10000) / 100
						hp = math.min(hp, 100)
					end

					skinId = curBagPetMo.curFaceId
					petMo = curBagPetMo
				end

				txtBlood.text = string.format("血量:%s", hp)

				MaterialMgr.setCell(MatType.Pet, skinId, petHead)
				GameUtil.addClickHandler(btnPet, function()
					CommonTipsMgr.instance:showPetTips(petMo)
				end, self)
			end

			txtPos:SetNum(idx)
			GameUtil.SetActive(imgSelect, idx == self._choosePosId)
			GameUtil.SetActive(contentGo, jobName or formationPetId ~= 0)
			GameUtil.SetActive(txtBlood.gameObject, formationPetId ~= 0)
			GameUtil.SetActive(bloodBg.gameObject, formationPetId ~= 0)
			GameUtil.SetActive(formationGo, true)
			GameUtil.addClickHandler(formationGo, function()
				FloatWordMgr.instance:show("不可手动选择站位")
			end, self)
		end
	end
end

function BoneDragonChallengeView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function BoneDragonChallengeView:_updateData()
	self._illegalPosList = {}
	self._info = BoneDragonModel.instance:getInfo(self._activityId) or {}
	self._curInfo = self._info.curInfo or {}
	self._curStageId = 1
	self._curStageId = checknumber(self._curInfo.curStageId) + 1
	self._curStageId = math.min(self._curStageId, #self._stageCfgs)
	self._chooseFormationId = self._curInfo.formationId or 1
	self._stageCfg = BoneDragonConfig.instance:getStageCfgByStageId(self._activityId, self._curStageId)
	self._choosePosId = self:getCurFormationChooseIdx()
	self._formationPetDic = BoneDragonModel.instance:getFormationPetDic(self._activityId)
end

function BoneDragonChallengeView:_updateUI()
	local changeSetId = BoneDragonModel.instance:getChangeSetId(self._activityId)

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end

	if #self._illegalPosList ~= 0 then
		for i, pos in ipairs(self._illegalPosList) do
			FloatWordMgr.instance:show(string.format("站位%d无符合条件精灵，已进入下一个站位的选择", pos))
		end

		self._illegalPosList = {}
	end

	BoneDragonModel.instance:saveChangeSetId(self._activityId)

	local stageNum = #self._stageCfgs
	local hasPassChallenge = self._curStageId == stageNum and self._curInfo.selectFormationId == nil

	if not hasPassChallenge then
		if self._curInfo.pets == nil or #self._curInfo.pets == 0 then
			UIStateManager.instance:push(ViewName.BoneDragonPetChooseView, self._activityId)
		else
			local petList = self:_getCurSortPetList(self._choosePosId)

			self._scrollListPet:reloadData(petList)
		end

		if self._curInfo.formationId == -1 and #self._curInfo.pets ~= 0 then
			UIStateManager.instance:push(ViewName.BoneDragonChooseView, self._activityId)
		end

		MaterialMgr.setCellByCfg(self._stageCfg.prize, self._itemPass)
		GameUtil.SetActive(self._geted, self._curStageId <= self._info.bestStageId)
		self:_updateFormation()
		self._scrollList:reloadData(self._stageCfgs)
	else
		for i, formationGo in ipairs(self._formationList) do
			GameUtil.SetActive(formationGo, false)
		end

		MaterialMgr.setCellByCfg(self._stageCfg.prize, self._itemPass)
		GameUtil.SetActive(self._geted, self._curStageId <= self._info.bestStageId)
		self._scrollList:reloadData(self._stageCfgs)
	end

	GameUtil.SetActive(self._tableViewPass, hasPassChallenge)
	GameUtil.SetActive(self._formationPass, hasPassChallenge)
	GameUtil.SetActive(self._imgTip, self._choosePosId == HAS_FINISH_FORMATION)
end

function BoneDragonChallengeView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local bg = goutil.findChild(cell, "bg")
	local pass = goutil.findChild(cell, "pass")
	local txtStage = goutil.findChildTextComponent(cell, "txtStage")
	local stageNum = goutil.findChild(cell, "stageNum")
	local stageNumGo2 = goutil.findChild(cell, "stageNum/img2")
	local imgNum = goutil.findChild(cell, "imgNum")
	local imageChangeComp = imgNum:GetComponent("UIImageSpriteChange")
	local imageComp = bg:GetComponent(goutil.Type_UIImage)
	local curStageId = checknumber(self._curInfo.curStageId) + 1

	if data.stageId <= 5 then
		imageChangeComp:SetState(data.stageId - 1)
	end

	GameUtil.SetGray(imageComp, curStageId < data.stageId)
	GameUtil.SetActive(pass, curStageId > data.stageId)
	GameUtil.SetActive(stageNumGo2, data.stageId == 7)
	GameUtil.SetActive(imgNum, data.stageId <= 5)
	GameUtil.SetActive(stageNum, data.stageId > 5)
	GameUtil.addClickHandler(cell, function()
		if curStageId < data.stageId then
			FloatWordMgr.instance:show("请通关上一关卡")

			return
		end

		if data.stageId < curStageId then
			FloatWordMgr.instance:show("已通关，无需再次挑战")

			return
		end

		self._curStageId = data.stageId

		self._scrollList:reloadData(self._stageCfgs)
	end, self)
end

function BoneDragonChallengeView:_clearCell(cell)
	GameUtil.rmClickHandler(cell)
end

function BoneDragonChallengeView:_updatePetCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local bg = goutil.findChild(cell, "bg")
	local state = goutil.findChild(cell, "state")
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local btnPet = goutil.findChild(cell, "btnPet")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtState = goutil.findChildTextComponent(cell, "txtState")
	local txtBlood = goutil.findChildTextComponent(cell, "txtBlood")
	local txtEffect = goutil.findChildTextComponent(cell, "txtEffect")
	local txtPower = goutil.findChildTextComponent(cell, "txtPower")
	local stateChangeGroup = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local outlineStateComp = txtState:GetComponent(ComponentType.OutlineEx)
	local skinId = 0
	local petId = 0
	local petMo

	if data.supportPetMo then
		petMo = data.supportPetMo
		txtName.text = data.supportPetMo.name
		txtBlood.text = "剩余血量： 100%"
		txtPower.text = data.supportPetMo.zdl
		txtState.text = "援"
		txtEffect.text = data.petEffect
		skinId = data.supportPetMo.curFaceId
		petId = data.supportPetId

		GameUtil.SetActive(state, true)
		GameUtil.SetActive(txtState.gameObject, true)
		GameUtil.SetActive(txtPower.gameObject, false)

		local outlineColor = GameUtil.getColorByHexColor("0F8713FF")

		outlineStateComp.OutlineWidth = 2

		outlineStateComp:SetColorRGBA(outlineColor.r, outlineColor.g, outlineColor.b, outlineColor.a)
	else
		petMo = data.bagPetMo
		petId = data.petId
		txtName.text = data.name

		if data.leftHp == -1 then
			txtBlood.text = "剩余血量： <color=#55C291FF>100%</color>"
		else
			local showHp = math.ceil(data.leftHp / data.HP * 10000) / 100
			local colorStr = ""

			colorStr = data.leftHp == 0 and "EE6D67FF" or "55C291FF"
			showHp = math.min(showHp, 100)
			txtBlood.text = string.format("剩余血量： <color=#%s>%d%%</color>", colorStr, showHp)
		end

		txtPower.text = data.zdl
		txtState.text = "亡"
		skinId = data.skinId

		GameUtil.SetActive(state, data.leftHp == 0)
		GameUtil.SetActive(txtState.gameObject, data.leftHp == 0)
		GameUtil.SetActive(txtEffect.gameObject, false)

		local outlineColor = GameUtil.getColorByHexColor("B2120EFF")

		outlineStateComp.OutlineWidth = 2

		outlineStateComp:SetColorRGBA(outlineColor.r, outlineColor.g, outlineColor.b, outlineColor.a)
	end

	stateChangeGroup:SetState(data.supportPetMo ~= nil and 1 or 0)
	MaterialMgr.setCell(MatType.Pet, skinId, item)

	if data.leftHp == 0 then
		GameUtil.rmClickHandler(btnSelect)
	else
		GameUtil.addClickHandler(btnSelect, function()
			local firstChooseId = BoneDragonConfig.instance:getFirstChoosePosId(self._activityId, 1)

			if self._curStageId == 1 and self._choosePosId == firstChooseId then
				TipsFacade.instance:openPopupWindow("提示", "上阵后不可更改，是否确认上阵该精灵", function()
					self:_onClickPetCell(petId)
				end, nil, "确定", "取消")
			else
				self:_onClickPetCell(petId)
			end
		end, self)
	end

	GameUtil.addClickHandler(btnPet, function()
		CommonTipsMgr.instance:showPetTips(petMo)
	end, self)
end

function BoneDragonChallengeView:_clearPetCell(cell)
	local item = goutil.findChild(cell, "item")
	local btnPet = goutil.findChild(cell, "btnPet")

	GameUtil.rmClickHandler(cell)
	GameUtil.rmClickHandler(btnPet)
	MaterialMgr.resetAll(item)
end

local YUAN_LIMIT = 2

function BoneDragonChallengeView:_getCurSortPetList(choosePosId)
	local jobPetList = {}
	local yuanCount = 0
	local petList = BoneDragonModel.instance:getFormationPetDic(self._activityId)

	for idx, petId in ipairs(petList) do
		local isSupportPet = table.indexof(self._supportList, petId)

		if isSupportPet then
			local supportPetCfg = BoneDragonConfig.instance:getSupportCfg(petId)
			local skinId = checknumber(supportPetCfg.faceId)

			if checknumber(skinId) == 0 then
				skinId = checknumber(supportPetCfg.raceId)
			end

			if PetSkinConfig.instance:checkHasEleAttr(skinId, GameEnum.RaceType.Yuan) then
				yuanCount = yuanCount + 1
			end
		else
			local curBagPetMo = BagPetsController.instance:getPet(petId)

			if curBagPetMo and PetSkinConfig.instance:checkHasEleAttr(curBagPetMo.curFaceId, GameEnum.RaceType.Yuan) then
				yuanCount = yuanCount + 1
			end
		end
	end

	local posLimitDic = BoneDragonConfig.instance:getFormationPosDicByStageId(self._activityId, self._curStageId, self._chooseFormationId)
	local curNeedJobName = posLimitDic[choosePosId]

	if curNeedJobName and self._curInfo.pets then
		for i, data in ipairs(self._curInfo.pets) do
			local hasInFormation = BoneDragonModel.instance:isInFormationPetDic(data.petId)

			if not hasInFormation then
				local curPet = {}
				local curBagPetMo = BagPetsController.instance:getPet(data.petId)

				if curBagPetMo then
					if (PetSkinConfig.instance:checkHasEleAttr(curBagPetMo.curFaceId, GameEnum.RaceType.Yuan) and yuanCount >= YUAN_LIMIT or nil) and false then
						local jobNameList = PetSkinConfig.instance:getJobKeyList(curBagPetMo.curFaceId)

						for i, jobName in ipairs(jobNameList) do
							if jobName == curNeedJobName then
								curPet.leftHp = data.leftHp
								curPet.zdl = curBagPetMo.zdl
								curPet.name = curBagPetMo.name
								curPet.skinId = curBagPetMo.curFaceId
								curPet.HP = curBagPetMo._maxHp
								curPet.petId = curBagPetMo.petId
								curPet.bagPetMo = curBagPetMo

								table.insert(jobPetList, curPet)
							end
						end
					end
				end
			end
		end

		local function funcHP(data)
			if data.leftHp == -1 then
				return math.huge
			end

			return data.leftHp
		end

		ArraySort.sortOn(jobPetList, {
			funcHP,
			"zdl"
		}, {
			ArraySort.DESCENDING,
			ArraySort.NUMERIC
		})

		local supportPetId = self._stageCfg.supportPetId
		local hasInFormation = BoneDragonModel.instance:isInFormationPetDic(supportPetId)

		if not hasInFormation then
			local curSupportPet = {}
			local supportPetCfg = BoneDragonConfig.instance:getSupportCfg(supportPetId)
			local fmo = FightingPowerPetMo.New()

			fmo:fromChallengeCreepCo(supportPetCfg)

			local petMo = fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)

			if (PetSkinConfig.instance:checkHasEleAttr(petMo.curFaceId, GameEnum.RaceType.Yuan) and yuanCount >= YUAN_LIMIT or nil) and false then
				curSupportPet.supportPetMo = petMo
				curSupportPet.petEffect = supportPetCfg.petEffect
				curSupportPet.supportPetId = supportPetId

				table.insert(jobPetList, 1, curSupportPet)
			end
		end
	end

	return jobPetList
end

function BoneDragonChallengeView:_hasAlivePet(petList)
	local hasAlive = false

	for i, curPet in ipairs(petList) do
		if curPet.leftHp ~= 0 and curPet.supportPetId == nil then
			hasAlive = true
		end
	end

	return hasAlive
end

function BoneDragonChallengeView:getCurFormationChooseIdx()
	local formationPetNum = BoneDragonModel.instance:getFormationPetNum(self._activityId)
	local posLimitDic = BoneDragonConfig.instance:getFormationPosDicByStageId(self._activityId, self._curStageId, self._chooseFormationId)
	local formationDic = BoneDragonModel.instance:getFormationPetDic(self._activityId)

	if formationPetNum ~= 0 then
		local petHasInFormationNum = 0

		for k, petId in ipairs(formationDic) do
			if petId ~= 0 then
				petHasInFormationNum = petHasInFormationNum + 1
			end
		end

		petHasInFormationNum = petHasInFormationNum + 1

		for i = 1, BoneDragonModel.FORMATION_POS_NUM do
			local hasPos = posLimitDic[i]
			local sortList = self:_getCurSortPetList(i)
			local hasAlivePet = self:_hasAlivePet(sortList)
			local hasSupportPet = self:_hasSupportPet()
			local hasPet = formationDic[i] ~= 0

			if hasPos and not hasSupportPet and #sortList == 0 and not hasPet and not table.indexof(self._illegalPosList, i) then
				table.insert(self._illegalPosList, i)
			end

			if hasPos and hasPet or #sortList > 0 and hasAlivePet and hasPos or hasPos and hasSupportPet then
				petHasInFormationNum = petHasInFormationNum - 1
			end

			if petHasInFormationNum == 0 then
				return i
			end
		end

		return HAS_FINISH_FORMATION
	end

	for i = 1, BoneDragonModel.FORMATION_POS_NUM do
		local hasPos = posLimitDic[i]

		if hasPos then
			return i
		end
	end
end

function BoneDragonChallengeView:_onClickPetCell(data)
	BoneDragonModel.instance:setFormationPetDic(self._activityId, self._choosePosId, data)

	self._choosePosId = self:getCurFormationChooseIdx(self._activityId)

	if self._choosePosId == HAS_FINISH_FORMATION then
		local curFmtHasSummonMaster = BoneDragonController.instance:curFormationHasSummonMaster(self._activityId)

		if curFmtHasSummonMaster then
			local summonPosList = BoneDragonConfig.instance:getSummonPosList(self._activityId, self._curStageId, self._chooseFormationId)

			UIStateManager.instance:push(ViewName.BoneDragonSummonedPetView, self._activityId, self._curStageId, summonPosList)
		else
			local petPosList, petMoList = BoneDragonModel.instance:getFormationPosAndMo(self._activityId)

			BoneDragonController.instance:enterBattleClg(self._activityId, self._curStageId, petPosList, petMoList, 0, self._curInfo.pets)
		end
	end

	self:_onUpdate()
end

function BoneDragonChallengeView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyChallenge

	TipsFacade.instance:openRulesView(key)
end

function BoneDragonChallengeView:_onClickBtnRestart()
	TipsFacade.instance:openPopupWindow("提示", "是否确认重置所有关卡", function()
		BoneDragonController.instance:sendPM_BoneDragonClgResetReq(self._activityId)
	end, nil, "确认", "取消")
end

function BoneDragonChallengeView:_onClickBtnChallenge()
	self._illegalPosList = {}

	local stageNum = #self._stageCfgs
	local hasPassChallenge = self._curStageId == stageNum and self._curInfo.selectFormationId == nil

	if hasPassChallenge then
		FloatWordMgr.instance:show("已挑战完成，无需再次挑战")

		return
	end

	local curFmtHasSummonMaster = BoneDragonController.instance:curFormationHasSummonMaster(self._activityId)

	if curFmtHasSummonMaster then
		local summonPosList = BoneDragonConfig.instance:getSummonPosList(self._activityId, self._curStageId, self._chooseFormationId)

		UIStateManager.instance:push(ViewName.BoneDragonSummonedPetView, self._activityId, self._curStageId, summonPosList, summonPetList)
	else
		local petPosList, petMoList = BoneDragonModel.instance:getFormationPosAndMo(self._activityId)

		BoneDragonController.instance:enterBattleClg(self._activityId, self._curStageId, petPosList, petMoList, 0, self._curInfo.pets)
	end
end

function BoneDragonChallengeView:_onReset()
	BoneDragonModel.instance:clearFormationPetDic(self._activityId)
	BoneDragonController.instance:sendPM_BoneDragonClgInfoReq(self._activityId)
end

function BoneDragonChallengeView:_hasSupportPet()
	local formationPetDic = BoneDragonModel.instance:getFormationPetDic(self._activityId)

	for i = 1, BoneDragonModel.FORMATION_POS_NUM do
		local formationPetId = formationPetDic[i]
		local isSupportPet = table.indexof(self._supportList, formationPetId)

		if isSupportPet then
			return false
		end
	end

	return true
end

return BoneDragonChallengeView
