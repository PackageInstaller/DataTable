-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchinfoView.lua

module("logic.extensions.annimatch.view.AnnimatchinfoView", package.seeall)

local AnnimatchinfoView = class("AnnimatchinfoView", ViewComponent)

function AnnimatchinfoView:ctor()
	AnnimatchinfoView.super.ctor(self)
end

function AnnimatchinfoView:unbindEvents()
	AnnimatchinfoView.super.unbindEvents(self)
end

function AnnimatchinfoView:bindEvents()
	AnnimatchinfoView.super.bindEvents(self)
end

function AnnimatchinfoView:buildUI()
	AnnimatchinfoView.super.buildUI(self)

	self.txtCountdown = self:getTxt("txtCountdown")
	self.myformation = self:getGo("animNode/root/left/information/formation")
	self.myHead = self:getGo("animNode/root/left/information/head")
	self.mywinNum = self:getGo("animNode/root/left/information/winNum/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self.myname = self:getTxt("animNode/root/left/information/name/txt")
	self.myheroSkill = self:getGo("animNode/root/left/information/heroSkill/Icon")
	self.mybuffForm = self:getGo("animNode/root/left/information/buffForm/icon")
	self.mytxtbuffForm = self:getTxt("animNode/root/left/information/buffForm/icon/lv/txt")
	self.mytxtbuffFormName = self:getTxt("animNode/root/left/information/buffForm/text")
	self.myContract = self:getGo("animNode/root/left/information/contractPet/IconBg/Icon")
	self.myformation = self:getGo("animNode/root/left/information/formation")
	self.enemyformation = self:getGo("animNode/root/right/information/formation")
	self.enemyHead = self:getGo("animNode/root/right/information/head")
	self.enemywinNum = self:getGo("animNode/root/right/information/winNum/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self.enemyname = self:getTxt("animNode/root/right/information/name/txt")
	self.enemyheroSkill = self:getGo("animNode/root/right/information/heroSkill/Icon")
	self.enemybuffForm = self:getGo("animNode/root/right/information/buffForm/icon")
	self.enemytxtbuffForm = self:getTxt("animNode/root/right/information/buffForm/icon/lv/txt")
	self.enemytxtbuffFormName = self:getTxt("animNode/root/right/information/buffForm/text")
	self.enemyContract = self:getGo("animNode/root/right/information/contractPet/IconBg/Icon")
	self.enemyformation = self:getGo("animNode/root/right/information/formation")
	self._goEffectVS = self:getGo("effectVS")
	self._goEffectSuccess = self:getGo("effectSuccess")
end

function AnnimatchinfoView:onExit()
	AnnimatchinfoView.super.onExit(self)
	self:_removeEffect()
	HeadItemController.instance:resetHeadCell(self.myHead)
	HeadItemController.instance:resetHeadCell(self.myHead)
	MaterialMgr.clearIcon(self.myContract)
	MaterialMgr.clearIcon(self.enemyContract)
	removetimer(self.onUpdateTime, self)
end

function AnnimatchinfoView:onEnter()
	AnnimatchinfoView.super.onEnter(self)
	self:refreshUI()
	self:_loadEffect()

	self.curTimeCount = 5

	settimer(1, self.onUpdateTime, self, true)

	self.txtCountdown.text = GameUtil.FormatTimeSymbol(self.curTimeCount)
end

function AnnimatchinfoView:onUpdateTime()
	self.curTimeCount = self.curTimeCount - 1
	self.txtCountdown.text = GameUtil.FormatTimeSymbol(self.curTimeCount)

	if self.curTimeCount <= 0 then
		removetimer(self.onUpdateTime, self)
		AnnimatchController.instance:goBattle()
		self:close()
	end
end

function AnnimatchinfoView:refreshUI()
	local currBattleRes = AnnimatchModel.instance:getBattleRes()
	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getInfo(activityId)

	self:setFormation(self.myformation, 1, info.simpleForm, self.mybuffForm, self.mytxtbuffForm, self.mytxtbuffFormName, self.myContract)
	HeadItemController.instance:setMyHeadCell(self.myHead)
	self.mywinNum:SetNum(currBattleRes.myWinTimes)

	self.myname.text = RoleModel.instance:getUserName()

	local skillId = 0

	if info.simpleForm and info.simpleForm.extParams then
		skillId = checknumber(info.simpleForm.extParams.heroSkillId)
	end

	self.myheroSkill:SetActive(skillId > 0)
	BagPetsFacade.setHeadIconByRaceId(self.myheroSkill, math.fmod(skillId, 100000))
	self:setFormation(self.enemyformation, 0, currBattleRes.rivalSimpleForm, self.enemybuffForm, self.enemytxtbuffForm, self.enemytxtbuffFormName, self.enemyContract)
	HeadItemController.instance:setHeadCellByInfo(self.enemyHead, currBattleRes.rivalHeadInfo)
	self.enemywinNum:SetNum(currBattleRes.rivalWinTimes)

	self.enemyname.text = currBattleRes.rivalHeadInfo.userName

	local skillId = 0

	if currBattleRes.rivalSimpleForm and currBattleRes.rivalSimpleForm.extParams then
		skillId = checknumber(currBattleRes.rivalSimpleForm.extParams.heroSkillId)
	end

	self.enemyheroSkill:SetActive(skillId > 0)
	BagPetsFacade.setHeadIconByRaceId(self.enemyheroSkill, math.fmod(skillId, 100000))
end

function AnnimatchinfoView:setFormation(formation, planId, simpleForm, buffForm, buffLv, buffName, contract)
	local _recordPos = formation:GetComponent(typeof(TestRecordPos))

	_recordPos:LoadPlan(planId)

	if not simpleForm.pos then
		local positions = {}
		local activityId = AnnimatchController.instance:getCurrActId()
		local summonPetId = 0
		local summonMasterMo

		for i = 1, 9 do
			local petId = positions[i]
			local cell = goutil.findChild(formation, "cell_" .. i)
			local con = goutil.findChild(formation, "cell_" .. i .. "/con")

			GameUtil.SetActive(cell, false)
			MaterialMgr.resetAll(con)

			local petMo = AnnimatchModel.instance:getPetMo(activityId, petId)

			if petMo then
				GameUtil.SetActive(cell, true)
				MaterialMgr.setCellByMo(petMo, con)

				if checknumber(petMo.summonMasterId) > 0 then
					summonPetId = petMo.petId
					summonMasterMo = AnnimatchModel.instance:getPetMo(activityId, checknumber(petMo.summonMasterId))
				end
			end
		end

		GameUtil.SetActive(contract, false)
		MaterialMgr.clearIcon(contract)

		if summonMasterMo then
			GameUtil.SetActive(contract, true)
			MaterialMgr.setIcon(contract, MatType.PET_SKIN, summonMasterMo.curFaceId)
		end

		local cfg = FightingPowerFormula.instance:getFormStrength(positions, summonPetId)

		goutil.setActive(buffForm, false)

		buffName.text = lang("阵法")

		if cfg then
			goutil.setActive(buffForm, true)
			GameUtil.setUIImageSpriteIdx(buffForm, cfg.formStrengthId - 1)

			buffName.text = cfg.name
			buffLv.text = "Lv." .. 20
		end
	end
end

function AnnimatchinfoView:clearFormation(formation)
	for i = 1, 9 do
		local cell = goutil.findChild(formation, "cell_" .. i)
		local con = goutil.findChild(formation, "cell_" .. i .. "/con")

		MaterialMgr.resetAll(con)
	end
end

function AnnimatchinfoView:_loadEffect()
	self._vsUIEffect = UIEffectManager.instance:playEffect(self, AnnimatchinfoViewPresentor.VSPath, self._goEffectVS.transform, 0, 0, true, false)

	self._vsUIEffect:setParent(self._goEffectVS.transform)
	self._vsUIEffect:setScale(1)

	self._imgUIEffect = UIEffectManager.instance:playEffect(self, AnnimatchinfoViewPresentor.IngPath, self._goEffectVS.transform, 0, 0, true, false)

	self._imgUIEffect:setParent(self._goEffectVS.transform)
	self._imgUIEffect:setScale(1)
	self._imgUIEffect:setLocalPos(0, 298, 0)

	self._successUIEffect = UIEffectManager.instance:playEffect(self, AnnimatchinfoViewPresentor.SuccessPath, self._goEffectSuccess.transform, 0, 0, true, false)

	self._successUIEffect:setParent(self._goEffectSuccess.transform)
	self._successUIEffect:setScale(1)
end

function AnnimatchinfoView:_removeEffect()
	if self._vsUIEffect then
		UIEffectManager.instance:stopEffect(self._vsUIEffect)

		self._vsUIEffect = nil
	end

	if self._imgUIEffect then
		UIEffectManager.instance:stopEffect(self._imgUIEffect)

		self._imgUIEffect = nil
	end

	if self._successUIEffect then
		UIEffectManager.instance:stopEffect(self._successUIEffect)

		self._successUIEffect = nil
	end
end

function AnnimatchinfoView:_showVsEffect()
	self._goEffectVS:SetActive(true)
end

function AnnimatchinfoView:_showSucessEffect()
	self._goEffectSuccess:SetActive(true)
end

function AnnimatchinfoView:_resetEffectGo()
	self._goEffectVS:SetActive(false)
	self._goEffectSuccess:SetActive(false)
end

return AnnimatchinfoView
