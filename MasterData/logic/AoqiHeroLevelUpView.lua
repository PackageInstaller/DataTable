-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroLevelUpView.lua

module("logic.extensions.aoqihero.view.AoqiHeroLevelUpView", package.seeall)

local AoqiHeroLevelUpView = class("AoqiHeroLevelUpView", ViewComponent)

function AoqiHeroLevelUpView:ctor()
	AoqiHeroLevelUpView.super.ctor(self)
end

function AoqiHeroLevelUpView:unbindEvents()
	AoqiHeroLevelUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPro)
	GameUtil.rmClickHandler(self._btnNext)
	GameUtil.rmClickHandler(self._btnLvUp)
	GameUtil.rmClickHandler(self._btnAttack2)
	GameUtil.rmClickHandler(self._btnDefence2)
	GameUtil.rmClickHandler(self._btnAttack1)
	GameUtil.rmClickHandler(self._btnDefence1)
	GameUtil.rmClickHandler(self._btnUtlSkill)
	GameUtil.rmClickHandler(self._btnNormalSkill)
end

function AoqiHeroLevelUpView:bindEvents()
	AoqiHeroLevelUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPro, self._onClickPro, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickNext, self)
	GameUtil.addClickHandler(self._btnLvUp, self._onClickLvUp, self)
	GameUtil.addClickHandler(self._btnAttack2, self._onClickAttack, self)
	GameUtil.addClickHandler(self._btnDefence2, self._onClickDefence, self)
	GameUtil.addClickHandler(self._btnAttack1, self._onClickAttack, self)
	GameUtil.addClickHandler(self._btnDefence1, self._onClickDefence, self)
	GameUtil.addClickHandler(self._btnUtlSkill, self._onClickUtlSkillTips, self)
	GameUtil.addClickHandler(self._btnNormalSkill, self._onClickNormalSkillTips, self)
end

function AoqiHeroLevelUpView:buildUI()
	AoqiHeroLevelUpView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goldBarCon = self:getGo("goldBar")
	self._costCon = self:getGo("cost/costCon")
	self._txtCost = self:getTxt("cost/txtCost")
	self._txtColorChangeCost = goutil.findChildComponent(self.mainGO, "cost/txtCost", ComponentType.UITextColorChange)
	self._maxLv = self:getGo("maxLv")
	self._cost = self:getGo("cost")
	self._btnUtlSkill = self:getGo("utlSkill")
	self._btnNormalSkill = self:getGo("normalSkill")
	self._normalSkillCon = self:getGo("normalSkill/con")
	self._utlSkillCon = self:getGo("utlSkill/con")
	self._petCon = self:getGo("pet/petCon")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnLvUp = self:getGo("btnLvUp")
	self._btnAttack2 = self:getGo("btnAttack2")
	self._imgChangeAttack2 = self._btnAttack2:GetComponent(ComponentType.UIChangeGroup)
	self._btnDefence2 = self:getGo("btnDefence2")
	self._imgChangeDefence2 = self._btnDefence2:GetComponent(ComponentType.UIChangeGroup)
	self._btnAttack1 = self:getGo("btnAttack1")
	self._imgChangeAttack1 = self._btnAttack1:GetComponent(ComponentType.UIChangeGroup)
	self._btnDefence1 = self:getGo("btnDefence1")
	self._imgChangeDefence1 = self._btnDefence1:GetComponent(ComponentType.UIChangeGroup)
	self._txtCriticalDamageRate = self:getTxt("property/txtCriticalDamageRate")
	self._txtCriticalRate = self:getTxt("property/txtCriticalRate")
	self._txtSpeed = self:getTxt("property/txtSpeed")
	self._txtAttack = self:getTxt("property/txtAttack")
	self._txtHp = self:getTxt("property/txtHp")
	self._txtLv = self:getTxt("nameInfo/txtLv")
	self._txtName = self:getTxt("nameInfo/txtName")
	self._btnPro = self:getGo("btnPro")
	self._btnNext = self:getGo("btnNext")
end

function AoqiHeroLevelUpView:onExit()
	AoqiHeroLevelUpView.super.onExit(self)
	uGuiUtil.clearImage(self._petCon)
	self._tableList:dispose()
	GlobalDispatcher:dispatch(GlobalNotify.AoQiHeroLevelUpViewClose)
end

function AoqiHeroLevelUpView:onEnter()
	AoqiHeroLevelUpView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroInfoRes, self._refreshView, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._pos = checknumber(params[2])

	local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, self._pos)

	self._raceId = posInfo.petId

	if self._raceId == 0 then
		self:close()
	end

	self._isAttack = true

	self:_initView()
	self:_refreshView()
end

function AoqiHeroLevelUpView:_initView()
	self:_setTopGoldBar()
end

function AoqiHeroLevelUpView:_refreshView()
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, self._raceId)
	local showRaceId = petCfg.faceIds
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. showRaceId)

		return
	end

	uGuiUtil.clearImage(self._petCon)
	uGuiUtil.setSpriteToImage(self._petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	self._txtName.text = petCfg.name

	local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, self._pos)
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, self._raceId)
	local lv = posInfo.lv
	local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, lv)
	local nextPropertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, lv + 1)

	self:_refreshProperty(propertyCfg, nextPropertyCfg)
	uGuiUtil.clearImage(self._normalSkillCon)
	uGuiUtil.clearImage(self._utlSkillCon)

	local normalSkillCo, utlSkillCo

	if self._isAttack == true then
		normalSkillCo = AoQiHeroConfig.instance:getSkillCfg(propertyCfg.normalSkillId)
		utlSkillCo = AoQiHeroConfig.instance:getSkillCfg(propertyCfg.ultSkillId)
	else
		normalSkillCo = AoQiHeroConfig.instance:getSkillCfg(propertyCfg.defenseNormalSkillId)
		utlSkillCo = AoQiHeroConfig.instance:getSkillCfg(propertyCfg.defenseUltSkillId)
	end

	uGuiUtil.setSpriteToImage(self._normalSkillCon, uGuiUtil.SpriteType.BigBg, normalSkillCo.skillImg)
	uGuiUtil.setSpriteToImage(self._utlSkillCon, uGuiUtil.SpriteType.BigBg, utlSkillCo.skillImg)

	local skillLvUpTipsCfgs = AoQiHeroConfig.instance:getSkillLvUpTips(petCfg.propertyStrategyId, self._isAttack)

	self._maxActiveTipsLv = 0

	local showIndex = 1
	local skillLvUpList = {}

	for i, v in ipairs(skillLvUpTipsCfgs) do
		if lv >= v.lv then
			self._maxActiveTipsLv = v.lv
			showIndex = i
		end

		table.insert(skillLvUpList, {
			index = i,
			cfg = v
		})
	end

	self._tableList:reloadData(skillLvUpList)
	self._tableList:MoveCellToCenter(showIndex - 1)
	GameUtil.SetActive(self._btnLvUp, nextPropertyCfg ~= nil)
	GameUtil.SetActive(self._cost, nextPropertyCfg ~= nil)
	GameUtil.SetActive(self._maxLv, nextPropertyCfg == nil)

	if nextPropertyCfg then
		local costCfg = AoQiHeroConfig.instance:getPosUpgrade(self._activityId, nextPropertyCfg.lv)
		local matType, matId, matNum = MaterialMgr.getMatParams(costCfg.cost)

		MaterialMgr.setIcon(self._costCon, matType, matId)

		self._txtCost.text = matNum

		if MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
			self._txtColorChangeCost:SetState(1)
		else
			self._txtColorChangeCost:SetState(0)
		end
	end

	if self._isAttack == true then
		self._imgChangeAttack1:SetState(1)
		self._imgChangeAttack2:SetState(1)
		self._imgChangeDefence2:SetState(0)
		self._imgChangeDefence1:SetState(0)
	else
		self._imgChangeAttack1:SetState(0)
		self._imgChangeAttack2:SetState(0)
		self._imgChangeDefence2:SetState(1)
		self._imgChangeDefence1:SetState(1)
	end

	self._txtLv.text = langPara("LV.%d", lv)

	local nextPosInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, self._pos + 1)

	if nextPosInfo and nextPosInfo.petId ~= 0 then
		GameUtil.SetActive(self._btnNext, true)
	else
		GameUtil.SetActive(self._btnNext, false)
	end

	local proPosInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, self._pos - 1)

	if proPosInfo and proPosInfo.petId ~= 0 then
		GameUtil.SetActive(self._btnPro, true)
	else
		GameUtil.SetActive(self._btnPro, false)
	end
end

function AoqiHeroLevelUpView:_refreshProperty(propertyCfg, nextPropertyCfg)
	local nextCriticalRate, curCriticalRate, nextCriticalDamageRate, curCriticalDamageRate, nextHp, curHp, nextSpeed, curSpeed, nextAtk, curAtk

	if self._isAttack == true then
		nextCriticalRate = propertyCfg.criticalRate
		curCriticalRate = propertyCfg.criticalRate
		nextCriticalDamageRate = propertyCfg.criticalDamageRate
		curCriticalDamageRate = propertyCfg.criticalDamageRate
		nextAtk = propertyCfg.Atk
		curAtk = propertyCfg.Atk
		nextHp = propertyCfg.hp
		curHp = propertyCfg.hp
		nextSpeed = propertyCfg.speed
		curSpeed = propertyCfg.speed

		if nextPropertyCfg then
			nextCriticalRate = nextPropertyCfg.criticalRate
			nextCriticalDamageRate = nextPropertyCfg.criticalDamageRate
			nextAtk = nextPropertyCfg.Atk
			nextHp = nextPropertyCfg.hp
			nextSpeed = nextPropertyCfg.speed
		end
	else
		nextCriticalRate = propertyCfg.defCriticalRate
		curCriticalRate = propertyCfg.defCriticalRate
		nextCriticalDamageRate = propertyCfg.defCriticalDamageRate
		curCriticalDamageRate = propertyCfg.defCriticalDamageRate
		nextAtk = propertyCfg.defAtk
		curAtk = propertyCfg.defAtk
		nextHp = propertyCfg.defHp
		curHp = propertyCfg.defHp
		nextSpeed = propertyCfg.defSpeed
		curSpeed = propertyCfg.defSpeed

		if nextPropertyCfg then
			nextCriticalRate = nextPropertyCfg.defCriticalRate
			nextCriticalDamageRate = nextPropertyCfg.defCriticalDamageRate
			nextAtk = nextPropertyCfg.defAtk
			nextHp = nextPropertyCfg.defHp
			nextSpeed = nextPropertyCfg.defSpeed
		end
	end

	GameUtil.SetActive(self._txtSpeed, not self._isAttack)

	local addCriticalDamageRate = nextCriticalDamageRate - curCriticalDamageRate

	self._txtCriticalDamageRate.text = addCriticalDamageRate > 0 and string.format("%s\t\t%d%%<color=#1AB95AFF>+%d%%</color>", lang("暴击伤害"), checkint(curCriticalDamageRate * 100), checkint(addCriticalDamageRate * 100)) or string.format("%s\t\t%d%%", lang("暴击伤害"), checkint(curCriticalDamageRate * 100))

	local addCriticalRate = nextCriticalRate - curCriticalRate

	self._txtCriticalRate.text = addCriticalRate > 0 and string.format("%s\t\t%d%%<color=#1AB95AFF>+%d%%</color>", lang("暴击"), checkint(curCriticalRate * 100), checkint(addCriticalRate * 100)) or string.format("%s\t\t%d%%", lang("暴击"), checkint(curCriticalRate * 100))

	local addAtk = nextAtk - curAtk

	self._txtAttack.text = addAtk > 0 and string.format("%s\t\t%d<color=#1AB95AFF>+%d</color>", lang("攻击"), curAtk, addAtk) or string.format("%s\t\t%d", lang("攻击"), curAtk)

	local addHp = nextHp - curHp

	self._txtHp.text = addHp > 0 and string.format("%s\t\t%d<color=#1AB95AFF>+%d</color>", lang("生命"), curHp, addHp) or string.format("%s\t\t%d", lang("生命"), curHp)

	local addSpeed = nextSpeed - curSpeed

	self._txtSpeed.text = addSpeed > 0 and string.format("%s\t\t%d<color=#1AB95AFF>+%d</color>", lang("速度"), curSpeed, addSpeed) or string.format("%s\t\t%d", lang("速度"), curSpeed)
end

function AoqiHeroLevelUpView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgCur = goutil.findChild(go, "imgCur")
	local imgLock = goutil.findChild(go, "imgLock")
	local txtLv = goutil.findChildTextComponent(go, "txtLv")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local textColorChanege = go:GetComponent(ComponentType.UIChangeGroup)
	local bgImageChange = goutil.findChildComponent(go, "imgBg", ComponentType.UIImageColorChange)
	local cfg = data.cfg

	GameUtil.SetActive(imgCur, cfg.lv == self._maxActiveTipsLv)
	GameUtil.SetActive(imgLock, cfg.lv > self._maxActiveTipsLv)

	txtLv.text = langPara("Lv.%d", cfg.lv)
	txtDesc.text = self._isAttack == true and cfg.skillLvUpTips or cfg.defenseSkillLvUpTips

	if cfg.lv > self._maxActiveTipsLv then
		textColorChanege:SetState(1)
	else
		textColorChanege:SetState(0)
	end

	bgImageChange:SetState(data.index % 2)
end

function AoqiHeroLevelUpView:_clearCell(cell)
	return
end

function AoqiHeroLevelUpView:_setTopGoldBar()
	local activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)
	local btn_list = {}
	local cfgList = string.split(activityCfg.showBar, "#")

	for i, v in ipairs(cfgList) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function AoqiHeroLevelUpView:_onClickLvUp()
	local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, self._pos)
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, self._raceId)
	local lv = posInfo.lv
	local nextPropertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, lv + 1)
	local costCfg = AoQiHeroConfig.instance:getPosUpgrade(self._activityId, nextPropertyCfg.lv)
	local matType, matId, matNum = MaterialMgr.getMatParams(costCfg.cost)

	if MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
		AoQiHeroAgent.instance:sendPM_AoQiHeroUpgradePositionReq(self._activityId, self._pos)
	else
		FloatWordMgr.instance:show(lang("材料不足"))
	end
end

function AoqiHeroLevelUpView:_onClickAttack()
	if self._isAttack == false then
		self._isAttack = true

		self:_refreshView()
	end
end

function AoqiHeroLevelUpView:_onClickDefence()
	if self._isAttack == true then
		self._isAttack = false

		self:_refreshView()
	end
end

function AoqiHeroLevelUpView:_onClickNormalSkillTips()
	local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, self._pos)
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._petCon)
	local param = {}

	param.pos = pos
	param.sizeDelta = sizeDelta
	param.view = self
	param.activityId = self._activityId
	param.raceId = self._raceId
	param.isAttack = self._isAttack
	param.lv = posInfo.lv
	param.defIndex = 1

	ViewMgr.instance:open(ViewName.AoqiHeroPetTipsView, param)
end

function AoqiHeroLevelUpView:_onClickUtlSkillTips()
	local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, self._pos)
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._petCon)
	local param = {}

	param.pos = pos
	param.sizeDelta = sizeDelta
	param.view = self
	param.activityId = self._activityId
	param.raceId = self._raceId
	param.isAttack = self._isAttack
	param.lv = posInfo.lv
	param.defIndex = 2

	ViewMgr.instance:open(ViewName.AoqiHeroPetTipsView, param)
end

function AoqiHeroLevelUpView:_onClickPro()
	self._pos = self._pos - 1

	local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, self._pos)

	self._raceId = posInfo.petId
	self._isAttack = true

	self:_refreshView()
end

function AoqiHeroLevelUpView:_onClickNext()
	self._pos = self._pos + 1

	local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, self._pos)

	self._raceId = posInfo.petId
	self._isAttack = true

	self:_refreshView()
end

return AoqiHeroLevelUpView
