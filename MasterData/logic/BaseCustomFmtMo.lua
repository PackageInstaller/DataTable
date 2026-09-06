-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/model/BaseCustomFmtMo.lua

module("logic.extensions.customfmt.model.BaseCustomFmtMo", package.seeall)

local BaseCustomFmtMo = class("BaseCustomFmtMo", ICustomFmtMo)

function BaseCustomFmtMo:onInit()
	BaseCustomFmtMo.super.onInit(self)

	self.useMaxFightPower = false
	self.isShowTab = false
	self.curTabIndex = 1
	self.isOnlyUpdateExistPet = false
end

function BaseCustomFmtMo:initFormationMo()
	self.forMationMap = {}
	self.formationMo = self:getCurFormation()
end

function BaseCustomFmtMo:onExitView()
	self:clearAllFixedEffects()
end

function BaseCustomFmtMo:getCurFormation()
	if self.forMationMap[self.curTabIndex] == nil then
		self.forMationMap[self.curTabIndex] = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	end

	self.formationMo = self.forMationMap[self.curTabIndex]

	return self.forMationMap[self.curTabIndex]
end

function BaseCustomFmtMo:getMonsterConfigList()
	return {}
end

function BaseCustomFmtMo:getFmtInfoConfig()
	return {}
end

function BaseCustomFmtMo:initFightHandler()
	return
end

function BaseCustomFmtMo:initSaveHandler()
	return
end

function BaseCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = self:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function BaseCustomFmtMo:getFightBagPet()
	return (BagPetsController.instance:getFightBagPet())
end

function BaseCustomFmtMo:refreshPetList(changePetMoMap)
	if changePetMoMap and _G.next(changePetMoMap) and self._rightPetMap then
		local indexMap, removeIdxMap

		for petId, petMo in pairs(changePetMoMap) do
			local mo = self._rightPetMap[petMo.petId]

			if self.isOnlyUpdateExistPet then
				if mo == nil then
					-- block empty
				elseif petMo.isSupportedPet == mo.isSupportedPet and petMo.isMyPackPet == mo.isMyPackPet then
					if indexMap == nil then
						removeIdxMap = {}
						indexMap = {}

						for i, v in ipairs(self._rightPetList) do
							indexMap[v.petId] = i
						end
					end

					self:_updatePetMoEx(petMo, indexMap, removeIdxMap)
				end
			else
				if indexMap == nil then
					removeIdxMap = {}
					indexMap = {}

					for i, v in ipairs(self._rightPetList) do
						indexMap[v.petId] = i
					end
				end

				self:_updatePetMoEx(petMo, indexMap, removeIdxMap)
			end
		end

		if removeIdxMap and _G.next(removeIdxMap) then
			for i = #self._rightPetList, 1, -1 do
				if removeIdxMap[i] then
					table.remove(self._rightPetList, i)
				end
			end
		end
	end
end

function BaseCustomFmtMo:_updatePetMoEx(mo, indexMap, removeIdxMap)
	mo = self:_changePetMo(mo)

	local idx = indexMap[mo.petId]

	if idx and idx > 0 then
		if mo:isExist() then
			self._rightPetList[idx] = mo
			self._rightPetMap[mo.petId] = mo
		else
			self._rightPetMap[mo.petId] = nil
			removeIdxMap[idx] = true
		end
	elseif mo:isExist() then
		table.insert(self._rightPetList, mo)

		self._rightPetMap[mo.petId] = mo
		indexMap[mo.petId] = #self._rightPetList
	end
end

function BaseCustomFmtMo:_changePetMo(petMo)
	if self.useMaxFightPower then
		return FightingPowerPetMo.getMaxPetMoByData(petMo)
	end

	return petMo
end

function BaseCustomFmtMo:getFinalFmoList(posList, petList, needPets)
	local _fixedPosList = self:getFixedPosList()

	if _fixedPosList and #_fixedPosList > 0 then
		local fixPosList = {}
		local fixPetMoList = {}

		for i, posId in ipairs(_fixedPosList) do
			local petId = self:getCurFormation():GetPosition(posId)
			local petMo = self:getPetMoById(petId)

			if petMo then
				table.insert(fixPosList, posId)
				table.insert(fixPetMoList, petMo)
			end
		end

		posList, petList = CustomFmtController.instance:getFinalFmoListAsFixPos(self:getCurFormation(), posList, petList, needPets, fixPosList, fixPetMoList, self.needUpPetCount)
	end

	if self.needUpPetCount > 5 then
		posList, petList = CustomFmtController.instance:extraPetAtFormation(self.needUpPetCount, needPets, petList, posList, self:getCurFormation())
	end

	return posList, petList
end

function BaseCustomFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("此精灵不可上阵")
end

function BaseCustomFmtMo:checkPetIsInOtherTab(checkPetMo, isForce)
	local isForbit = false

	if self.isShowTab or checkbool(isForce) then
		for i = 1, self.maxTabCount do
			if i ~= self.curTabIndex then
				if self.forMationMap then
					if self.forMationMap then
						local pet_poisition = self.forMationMap:GetPositions() or {}

						for idx, v in ipairs(pet_poisition) do
							if v ~= 0 then
								local petmo = self:getPetMoById(v)

								if petmo and checkPetMo:getDefineId() == petmo:getDefineId() then
									isForbit = true

									break
								end
							end
						end
					end
				end
			end
		end
	end

	return isForbit
end

return BaseCustomFmtMo
