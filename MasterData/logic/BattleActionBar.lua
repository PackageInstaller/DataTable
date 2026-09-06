-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleActionBar.lua

module("logic.extensions.battle.view.BattleActionBar", package.seeall)

local BattleActionBar = class("BattleActionBar")
local maxShowActionNums = 4

function BattleActionBar:ctor(go, view)
	self._view = view
	self.mainGO = go
	self._freeItems = {}
	self._curShowItem = nil
end

function BattleActionBar:buildUI()
	self._content = goutil.findChild(self.mainGO, "content")
	self._tableCell = goutil.findChild(self._content, "tablecell")

	self._tableCell:SetActive(false)

	local desc = goutil.findChild(self.mainGO, "desc")

	self._txtType = goutil.findChildTextComponent(desc, "txtType")
	self._txtName = goutil.findChildTextComponent(self._txtType.gameObject, "txtName")
	self._skillCanvasGroup = desc:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._initX, self._initY, self._initZ = Framework.TransformUtil.GetLocalPos(self._skillCanvasGroup.transform, 0, 0, 0)

	local curPoint = goutil.findChild(self._content, "curPoint")
	local nextPoint = goutil.findChild(self._content, "nextPoint")

	self._curX, self._curY, _ = Framework.TransformUtil.GetLocalPos(curPoint.transform, 0, 0, 0)
	self._nextX, self._nextY, _ = Framework.TransformUtil.GetLocalPos(nextPoint.transform, 0, 0, 0)
end

function BattleActionBar:onEnter()
	self._actionItems = {}
	self._modelIds = {}

	self:_updateActions()
	GlobalDispatcher:addListener(GlobalNotify.OnBattleRoundStart, self._popupAction, self)
	GlobalDispatcher:addListener(GlobalNotify.OnBattleRoundPush, self._onRoundPush, self)

	self._skillCanvasGroup.alpha = 0
end

function BattleActionBar:_updateActions()
	self._curViewDatas = self:getRounds()

	for i = 1, math.min(maxShowActionNums, #self._curViewDatas) do
		local round = self._curViewDatas[i]
		local item = self:_getFreeItem()

		self:_updateCell(item, round, i)
	end
end

function BattleActionBar:_onRoundPush()
	self:_updateActions()
end

function BattleActionBar:onExit()
	print("exit battleactionbar")

	if self._tweenTrans then
		self._tweenTrans:Kill(false)

		self._tweenTrans = nil
	end

	if self._tweenAlpha then
		self._tweenAlpha:Kill(false)

		self._tweenAlpha = nil
	end

	for _, v in ipairs(self._freeItems) do
		self:_clearItem(v.mainGO)
	end

	self._freeItems = {}

	for _, v in ipairs(self._actionItems) do
		self:_clearItem(v.mainGO)
	end

	self._actionItems = {}

	if self._curShowItem then
		self:_clearItem(self._curShowItem.mainGO)
	end

	self._curShowItem = nil

	self:_clearUtlSkillEff()
	GlobalDispatcher:removeListener(GlobalNotify.OnBattleRoundStart, self._popupAction, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnBattleRoundPush, self._onRoundPush, self)
end

function BattleActionBar:_clearItem(go)
	local imgIcon = goutil.findChild(go, "imgIcon")

	if imgIcon then
		uGuiUtil.clearImage(imgIcon)
	end

	goutil.destroy(go, true)
end

function BattleActionBar:getRounds()
	local t = {}
	local rounds = BattleModel.instance.rounds

	for i = 1, #rounds do
		local round = rounds[i]

		if round.roundType == BattleRoundBase.Round then
			local result = round:getCharactorResult()

			if result and result.skillId ~= 0 then
				table.insert(t, round)
			end
		end
	end

	return t
end

function BattleActionBar:_popupAction(round)
	if round.roundType == BattleRoundBase.Round then
		local result = round:getCharactorResult()

		if not result then
			return
		end

		if result then
			local skillId = result.skillId
			local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
			local characterId = result.caster.targetCharacterId
			local teamId = result.caster.targetTeamId
			local unit = battleScene.unitFactory:getUnit(teamId, characterId)
			local skinId = 0

			if unit then
				skinId = unit.raceId

				if unit.modelId > 0 then
					skinId = unit.modelId
				end
			end

			local skillCo = BattleConfig.instance:getSkillCo(skillId, skinId)

			if skillCo then
				self._txtName.text = skillCo.name
				self._txtType.text = unit.attrs:isSpiritInvocationPet() and ConstString.SkillType[GameEnum.SkillRaceType.SpiritInvocationSkill] .. "：" or skillCo.type .. "："
			end
		end

		table.remove(self._curViewDatas, 1)

		if self._curShowItem then
			self._skillCanvasGroup.alpha = 0

			self:_hideUtlSkillEff()
			self:_onTweenFinish()
		else
			self:_onTweenFinish()
		end
	end
end

function BattleActionBar:_onTweenFinish()
	if self._tweenAlpha then
		self._tweenAlpha:Kill(false)

		self._tweenAlpha = nil
	end

	if self._curShowItem then
		goutil.setActive(self._curShowItem.mainGO, false)
		table.insert(self._freeItems, self._curShowItem)
		self:_hideUtlSkillEff()
	end

	self._curShowItem = self._actionItems[1]

	if self._curShowItem then
		table.remove(self._actionItems, 1)

		self._tweenTrans = TweenUtil.ValueTo(0, 1, 0.3, function(val)
			for idx, item in ipairs(self._actionItems) do
				local x = self:_getTargetPosX(idx)
				local preX = self:_getTargetPosX(idx + 1)
				local _, y, z = Framework.TransformUtil.GetLocalPos(item.mainGO.transform, 0, 0, 0)

				Framework.TransformUtil.SetLocalPos(item.mainGO.transform, preX + (x - preX) * val, self._nextY, z)
			end

			Framework.TransformUtil.SetLocalPos(self._curShowItem.mainGO.transform, self._nextX + (self._curX - self._nextX) * val, self._nextY + (self._curY - self._nextY) * val, 0)

			local scale = 1 + 0.25 * val

			self._curShowItem.canvasGroup.alpha = scale

			Framework.TransformUtil.SetLocalScale(self._curShowItem.mainGO.transform, scale, scale, 1)
			Framework.TransformUtil.SetLocalPos(self._skillCanvasGroup.transform, self._initX + 80 * (1 - val), self._initY, self._initZ)

			self._skillCanvasGroup.alpha = val
		end, nil, self)

		local newIdx = #self._actionItems + 1

		if newIdx <= #self._curViewDatas then
			local newItem = self:_getFreeItem()
			local newData = self._curViewDatas[newIdx]

			self:_updateCell(newItem, newData, newIdx)
		end

		if self._curShowItem.result then
			local skillId = self._curShowItem.result.skillId
			local result = self._curShowItem.result
			local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
			local characterId = result.caster.targetCharacterId
			local teamId = result.caster.targetTeamId
			local unit = battleScene.unitFactory:getUnit(teamId, characterId)
			local skinId = 0

			if unit then
				skinId = unit.raceId

				if unit.modelId > 0 then
					skinId = unit.modelId
				end
			end

			local skillCo = BattleConfig.instance:getSkillCo(skillId, skinId)

			if skillCo and skillCo.powerType == GameEnum.SkillPowerType.AttackSuper then
				self:_playUtlSkillEff(self._curShowItem.mainGO)
			else
				self:_hideUtlSkillEff()
			end
		else
			self:_hideUtlSkillEff()
		end
	end
end

function BattleActionBar:_getFreeItem()
	local item

	if #self._freeItems > 0 then
		item = table.remove(self._freeItems, 1)
	else
		local go = goutil.cloneAndSetParent(self._tableCell, self._content.transform)

		item = {
			mainGO = go,
			imgIcon = goutil.findChild(go, "imgIcon"),
			imgColorChange = goutil.findChildComponent(go, "imgBg", typeof(UIImageSpriteChange)),
			rectTrans = go:GetComponent("RectTransform"),
			canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
		}
	end

	table.insert(self._actionItems, item)
	item.mainGO.transform:SetAsLastSibling()
	goutil.setActive(item.mainGO, true)

	return item
end

function BattleActionBar:_getTargetPosX(idx)
	return self._nextX + 50 * (idx - 1)
end

function BattleActionBar:_updateCell(item, data, idx)
	local x = self:_getTargetPosX(idx)
	local _, y, z = Framework.TransformUtil.GetLocalPos(item.mainGO.transform, 0, 0, 0)

	item.canvasGroup.alpha = 1

	Framework.TransformUtil.SetLocalPos(item.mainGO.transform, x, self._nextY, z)
	Framework.TransformUtil.SetLocalScale(item.mainGO.transform, 1, 1, 1)

	local result = data:getCharactorResult()

	item.result = result

	if result then
		local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
		local characterId = result.caster.targetCharacterId
		local teamId = result.caster.targetTeamId
		local unit = battleScene.unitFactory:getUnit(teamId, characterId)
		local rightTeamId = BattleModel.instance:getTeamDirection(teamId)
		local isEnemy = rightTeamId == GameEnum.BattleTeam.Right

		item.imgColorChange:SetState(isEnemy and 1 or 0)

		if unit then
			local preTfsModelId, afterTfModelId = data:getTransformModelId(characterId, teamId)

			self._modelIds[teamId] = self._modelIds[teamId] or {}
			self._modelIds[teamId][characterId] = self._modelIds[teamId][characterId] or unit.modelId

			if preTfsModelId then
				self._modelIds[teamId][characterId] = preTfsModelId
			end

			local modelId = self._modelIds[teamId][characterId]
			local modelCo = CharacterConfig.instance:getModelCo(modelId)

			if afterTfModelId then
				self._modelIds[teamId][characterId] = afterTfModelId
			end

			if modelCo then
				uGuiUtil.clearImage(item.imgIcon)
				uGuiUtil.setSpriteToImage(item.imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
			end

			if result.targetCharacterResults then
				for i = 1, #result.targetCharacterResults do
					local cR = result.targetCharacterResults[i]

					if cR.target.targetTeamId ~= teamId and cR.targetNum then
						local sR = cR.targetNum.resultObjectSummary

						if sR then
							local beforeCurFaceId = 0
							local afterCurFaceId = 0

							if sR.transform then
								for k = 1, #sR.transform do
									local tR = sR.transform[k]

									if tR.oc == GameEnum.BattleOc.After then
										afterCurFaceId = tR.curFaceId
									elseif tR.oc == GameEnum.BattleOc.Beffore then
										beforeCurFaceId = tR.curFaceId
									end
								end
							end

							local curFaceId = 0

							if afterCurFaceId > 0 then
								curFaceId = afterCurFaceId
							elseif beforeCurFaceId > 0 then
								curFaceId = beforeCurFaceId
							end

							if curFaceId > 0 then
								self._modelIds[cR.target.targetTeamId] = self._modelIds[cR.target.targetTeamId] or {}
								self._modelIds[cR.target.targetTeamId][cR.target.targetCharacterId] = curFaceId
							end
						end
					end
				end
			end
		end
	end
end

function BattleActionBar:_playUtlSkillEff(mainGO)
	if not self._utlSkillEff then
		self._utlSkillEff = UIEffectManager.instance:playEffectBrief(self._view, CommonResPath.BattleUtlUIEff, mainGO.transform, true)

		self._utlSkillEff:setSortingOrder(40)
	end

	self._utlSkillEff:setParent(mainGO.transform)
	self._utlSkillEff:setLocalPos(0, 0, 0)
	self._utlSkillEff:setScale(0.78)
	self._utlSkillEff:setVisible(true)
end

function BattleActionBar:_hideUtlSkillEff()
	if self._utlSkillEff then
		self._utlSkillEff:setVisible(false)
	end
end

function BattleActionBar:_clearUtlSkillEff()
	if self._utlSkillEff then
		UIEffectManager.instance:stopEffect(self._utlSkillEff)

		self._utlSkillEff = nil
	end
end

return BattleActionBar
