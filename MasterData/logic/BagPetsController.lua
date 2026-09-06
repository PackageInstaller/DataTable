-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/controller/BagPetsController.lua

module("logic.extensions.bag.controller.BagPetsController", package.seeall)

local BagPetsController = class("BagPetsController", BaseController)
local PET_TOP_KEY = "BagPetsController_SetTop"
local PET_ONE_SET_COUNT = 1000

BagPetsController.NORMAL = 1
BagPetsController.NO_LEFT = 2
BagPetsController.NO_RIGHT = 3
BagPetsController.NO_LEFT_AND_RIGHT = 4
BagPetsController.PET_STATUS_BAG = 0
BagPetsController.PET_STATUS_BORROW = 1

local SYS_EQUIP = 1
local SYS_DECORATION = 2
local SYS_HOLYSTRIPES = 3
local SYS_CUTEPET = 4
local SYS_THRONE = 5
local SYS_GOODFELLING = 6
local SYS_HANDBOOK = 7
local SYS_ASSIST = 8
local SYS_MOUNT = 9
local SYS_FORMSTREANGTH = 10
local SYS_RUNE = 110
local SYS_HOSHIGAMI = 111
local SYS_ANIMAL = 112
local SYS_TEAM = 113

function BagPetsController:ctor()
	self._areadyGetPets = false
	self._curPetId = nil
end

function BagPetsController:onInit()
	PetAgent.instance:addHandler(PetAgent.PM_OnPetChanged, self.handlePM_OnPetChanged, self)
	PetAgent.instance:addHandler(PetAgent.PM_LoadUserPetsRes, self.handlePM_LoadUserPetsRes, self)
	PetAgent.instance:addHandler(PetAgent.PM_BatchLoadUserPetFullViewOnLoginRes, self.handlePM_BatchLoadUserPetFullViewOnLoginRes, self)
	self:onReset()

	self._contractMasterLimitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMON_MASTER_MIN_LVL"))
	self._contractSummonLimitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMONED_PET_MIN_LVL"))
end

function BagPetsController:onReset()
	PetFilterMgr.instance:resetAll()

	self._areadyGetPets = false
	self._curPetId = nil
	self._pet_change_version = 0
	self._petChangeList = {}
	self.needGetPetMap = nil
	self.lateAddPetList = nil

	self:_initSystemData()
end

function BagPetsController:_initSystemData()
	self._map = {}
	self._map[SYS_EQUIP] = false
	self._map[SYS_DECORATION] = false
	self._map[SYS_HOLYSTRIPES] = false
	self._map[SYS_CUTEPET] = false
	self._map[SYS_THRONE] = false
	self._map[SYS_GOODFELLING] = false
	self._map[SYS_HANDBOOK] = false
	self._map[SYS_ASSIST] = false
	self._map[SYS_MOUNT] = false
	self._map[SYS_FORMSTREANGTH] = false
	self._sysDataInit = false
end

function BagPetsController:_markSystemAndDone(sys)
	if self._map[sys] ~= nil and not self._sysDataInit then
		self._map[sys] = true

		for k, v in pairs(self._map) do
			if v == false then
				return
			end
		end

		local allPets = self:getBagAndBorrowPets()

		for k, petMo in pairs(allPets or {}) do
			petMo:calcAllAttr()
		end

		local changes = allPets

		self._pet_change_version = self._pet_change_version + 1
		self._petChangeList[self._pet_change_version] = changes

		GlobalDispatcher:dispatch(GlobalNotify.BagPetChanged, changes)

		self._sysDataInit = true
	end
end

function BagPetsController:handlePM_OnPetChanged(msg)
	print("handlePM_OnPetChanged xxxxxxxxxx")

	local pets = msg.pet

	if self._areadyGetPets then
		local changes = {}

		for i, v in ipairs(pets) do
			local id = v.baseView.petId
			local oldPet, newPet

			if v.baseView.status and v.baseView.status == BagPetsController.PET_STATUS_BORROW or BorrowPetModel.instance:getPet(id) then
				oldPet = BorrowPetModel.instance:setPet(id, v)
				newPet = BorrowPetModel.instance:getPet(id)
			else
				oldPet = self:setPet(id, v)
				newPet = self:getPet(id)
			end

			changes[id] = newPet

			if oldPet ~= nil then
				GlobalDispatcher:dispatch(GlobalNotify.BagPetAttrChanged, oldPet, newPet)
			else
				GlobalDispatcher:dispatch(GlobalNotify.BagPetNew, id)
			end
		end

		self._pet_change_version = self._pet_change_version + 1
		self._petChangeList[self._pet_change_version] = changes

		GlobalDispatcher:dispatch(GlobalNotify.BagPetChanged, changes)
	else
		self.lateAddPetList = self.lateAddPetList or {}

		for i, v in ipairs(pets) do
			table.insert(self.lateAddPetList, v)
		end
	end
end

function BagPetsController:getPetChangeVersion()
	return self._pet_change_version
end

function BagPetsController:getPetVersionChangeMap(lastVersion)
	local changes = {}

	for i = lastVersion + 1, self._pet_change_version do
		local map = self._petChangeList[i]

		if map then
			for petId, v in pairs(map) do
				changes[petId] = v
			end
		end
	end

	return changes
end

function BagPetsController:calcAllPetEquipAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_EQUIP)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcEquipAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcEquipAttr()
	end
end

function BagPetsController:calcAllPetHoshigamiAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_HOSHIGAMI)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcPetHoshigamiAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcPetHoshigamiAttr()
	end
end

function BagPetsController:calcAllPetHolyStripesAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_HOLYSTRIPES)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcHolyStripesAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcHolyStripesAttr()
	end
end

function BagPetsController:calcAllDecorationAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_DECORATION)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcDecorationAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcDecorationAttr()
	end
end

function BagPetsController:calcAllCutePetAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_CUTEPET)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcCutePetAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcCutePetAttr()
	end
end

function BagPetsController:sendChangePetBody(petMo, isShowTips)
	local cfg = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)
	local bodyType = cfg.bodyType
	local map = PetSkinConfig.instance:getPetSkinBodyMap(petMo.curFaceId)
	local nextBodyType = 0

	for k, v in pairs(map) do
		if checknumber(k) ~= bodyType then
			nextBodyType = checknumber(k)

			break
		end
	end

	local key = "BagPetsController_ChangeBody"

	if not GameUtil.getUserDayData(key) then
		local function funcTog()
			GameUtil.saveUserDayData(key, true)
		end

		local togText = lang("今日不再提示")

		TipsFacade.instance:openPopupWindowWithTog(lang("tip"), lang("petshowinfostacknew__shuangsheng"), function()
			PetskinController.instance:sendChangeBody(petMo.petId, nextBodyType)
		end, function()
			return
		end, funcTog, nil, nil, togText)
	else
		PetskinController.instance:sendChangeBody(petMo.petId, nextBodyType)
	end
end

function BagPetsController:calcAllPetThroneAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_THRONE)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcPetThroneAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcPetThroneAttr()
	end
end

function BagPetsController:calcAllPetGoodfellingAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_GOODFELLING)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcPetGoodfellingAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcPetGoodfellingAttr()
	end
end

function BagPetsController:calcAllPetHandbookAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_HANDBOOK)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcPetHandbookAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcPetHandbookAttr()
	end
end

function BagPetsController:calcAllAnimalAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_ANIMAL)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcAnimalAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcAnimalAttr()
	end
end

function BagPetsController:calcAllAssistAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_ASSIST)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcAssistAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcAssistAttr()
	end
end

function BagPetsController:calcAllMountAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_MOUNT)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcMountAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcMountAttr()
	end
end

function BagPetsController:updatePetEquipAttrById(petId)
	local petMo = self:getPet(petId)

	if petMo then
		local oldPet = petMo:GetClone()

		petMo:calcEquipAttr()
		GlobalDispatcher:dispatch(GlobalNotify.BagPetAttrChanged, oldPet, petMo)
	end
end

function BagPetsController:updatePetHoshigamiAttrById(petId)
	local petMo = self:getPet(petId)

	if petMo then
		local oldPet = petMo:GetClone()

		petMo:calcPetHoshigamiAttr()
		GlobalDispatcher:dispatch(GlobalNotify.BagPetAttrChanged, oldPet, petMo)
	end
end

function BagPetsController:updatePetHolyStripesAttrById(petId)
	local petMo = self:getPet(petId)

	if petMo then
		local oldPet = petMo:GetClone()

		petMo:calcHolyStripesAttr()
		GlobalDispatcher:dispatch(GlobalNotify.BagPetAttrChanged, oldPet, petMo)
	end
end

function BagPetsController:updateDecorationAttrById(petId)
	local petMo = self:getPet(petId)

	if petMo then
		local oldPet = petMo:GetClone()

		petMo:calcDecorationAttr()
		GlobalDispatcher:dispatch(GlobalNotify.BagPetAttrChanged, oldPet, petMo)
	end
end

function BagPetsController:updateStarGodPlusAttrById(petId)
	local petMo = self:getPet(petId)

	if petMo then
		local oldPet = petMo:GetClone()

		petMo:calcStarGodPlusAttr()
		GlobalDispatcher:dispatch(GlobalNotify.BagPetAttrChanged, oldPet, petMo)
	end
end

function BagPetsController:updateCutePetAttrById(petId)
	local petMo = self:getPet(petId)

	if petMo then
		local oldPet = petMo:GetClone()

		petMo:calcCutePetAttr()
		GlobalDispatcher:dispatch(GlobalNotify.BagPetAttrChanged, oldPet, petMo)
	end
end

function BagPetsController:calcAllPetTeamAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_TEAM)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcPetTeamAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcPetTeamAttr()
	end
end

function BagPetsController:calcAllPetRuneAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_RUNE)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcRuneAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcRuneAttr()
	end
end

function BagPetsController:calcAllPetFormStreangthAttr()
	if not self._sysDataInit then
		self:_markSystemAndDone(SYS_FORMSTREANGTH)

		return
	end

	local allPets = self:getAllPets()

	for k, petMo in pairs(allPets or {}) do
		petMo:calcFormStrengthAttr()
	end

	local allBorrowPets = BorrowPetModel.instance:getPets()

	for k, petMo in pairs(allBorrowPets or {}) do
		petMo:calcFormStrengthAttr()
	end
end

function BagPetsController:updatePetRuneAttrById(petId)
	local petMo = self:getPet(petId)

	if petMo then
		local oldPet = petMo:GetClone()

		petMo:calcRuneAttr()

		if RuneModel.instance.suitInfo and RuneModel.instance.allItems then
			GlobalDispatcher:dispatch(GlobalNotify.BagPetAttrChanged, oldPet, petMo)
		end
	end
end

function BagPetsController:getBagModel()
	PetAgent.instance:sendPM_LoadUserPetsReq()
end

function BagPetsController:handlePM_LoadUserPetsRes(msg)
	forcePrint("=====RoleDataRequestor:_loadPetBag===back")

	local petIdsList = msg.petId

	self.needGetPetMap = {}

	for i, v in ipairs(petIdsList) do
		self.needGetPetMap[v] = true
	end

	forcePrint("=====RoleDataRequestor:_loadPetsInfos")
	self:goAndGetPetInfo()
	GoodFeelModel.instance:setGoodFeelingInfoFromServer(msg.goodFeelingInfos)
end

function BagPetsController:handlePM_BatchLoadUserPetFullViewOnLoginRes(msg)
	local pets = msg.pet

	for i, v in ipairs(pets) do
		local petId = 0

		if v and v.baseView then
			petId = v.baseView.petId

			if v.baseView.status and v.baseView.status == BagPetsController.PET_STATUS_BORROW then
				BorrowPetModel.instance:setPet(petId, v)
			else
				BagModel.instance:setPet(petId, v)
			end

			self.needGetPetMap[petId] = nil
		end
	end

	for i, petId in ipairs(msg.emptyViewPetId) do
		self.needGetPetMap[petId] = nil
	end

	self:goAndGetPetInfo()
end

function BagPetsController:goAndGetPetInfo()
	local count = 0
	local list

	if self.needGetPetMap ~= nil then
		for petId, v in pairs(self.needGetPetMap) do
			if checknumber(petId) > 0 then
				list = list or {}

				table.insert(list, checknumber(petId))

				count = count + 1

				if count >= PET_ONE_SET_COUNT then
					break
				end
			end
		end
	end

	if list then
		PetAgent.instance:sendPM_BatchLoadUserPetFullViewOnLoginReq(list)
	else
		forcePrint("=====RoleDataRequestor:_loadPetsInfos===END")

		if self.lateAddPetList then
			for i, v in ipairs(self.lateAddPetList) do
				local petId = v.baseView.petId

				BagModel.instance:setPet(petId, v)
			end
		end

		self.lateAddPetList = nil
		self._areadyGetPets = true

		GlobalDispatcher:dispatch(GlobalNotify.BagPetsInit)
	end
end

function BagPetsController:getPetShowTab()
	return self._petShowTab or 1
end

function BagPetsController:setPetShowTab(tab)
	self._petShowTab = tab
end

function BagPetsController:getReady()
	return self._areadyGetPets
end

function BagPetsController:getAllPets()
	return BagModel.instance:getPets()
end

function BagPetsController:getBagPets()
	return BagModel.instance:getBagPets()
end

function BagPetsController:getBagAndBorrowPets()
	local pets = BagModel.instance:getBagPets()
	local borrowPets = BorrowPetModel.instance:getBagPets()

	for i, v in ipairs(borrowPets) do
		table.insert(pets, v)
	end

	return pets
end

function BagPetsController:getFightBagPet()
	local pets = BagModel.instance:getBagPets()
	local borrowPets = BorrowPetModel.instance:getBagPets()

	for i, v in ipairs(borrowPets) do
		table.insert(pets, v)
	end

	return pets
end

function BagPetsController:getMaxPowerPetId()
	local maxZdl = -1
	local maxPetMo
	local pets = BagModel.instance:getBagPets()

	for _, petMo in pairs(pets) do
		local tempZdl = petMo:getFightingPower()

		if maxZdl < tempZdl then
			maxPetMo = petMo
			maxZdl = tempZdl
		end
	end

	return maxPetMo and maxPetMo:getId() or 0
end

function BagPetsController:getPet(id)
	return BagModel.instance:getPet(id) or BorrowPetModel.instance:getPet(id)
end

function BagPetsController:getExistPet(id)
	return BagModel.instance:getBagPetById(id) or BorrowPetModel.instance:getExistPet(id)
end

function BagPetsController:setPet(id, data)
	return BagModel.instance:setPet(id, data)
end

function BagPetsController:hasPet(id)
	return self:getPet(id) ~= nil
end

function BagPetsController:openBagPetView(petId, page)
	BagPetsController.instance:SetCurPetId(petId)
	UIStateManager.instance:push(ViewName.PetShowView, page)
end

function BagPetsController:getPetNumByRaceId(raceId)
	return BagModel.instance:getRaceIdCount(raceId)
end

function BagPetsController:SetCurPetId(petId)
	self._curPetId = petId
end

function BagPetsController:GetCurPetId()
	return self._curPetId
end

function BagPetsController:GetCurPetMo()
	local pid = self:GetCurPetId()
	local pet

	return (pid ~= nil or nil) and (BagModel.instance:getPet(pid) or BorrowPetModel.instance:getPet(pid))
end

function BagPetsController:SetWarehousePetId(petId)
	self._warehousePetId = petId
end

function BagPetsController:GetWarehousePetId()
	return self._warehousePetId
end

function BagPetsController:ToWarehouse(petId)
	if BagModel.instance:BagCount() == 1 then
		FloatWordMgr.instance:show("背包至少要保留1只精灵喔")

		return
	end

	if FormationNewModel.instance:HasPet(petId) then
		TipsFacade.instance:openPopupWindow(lang("tips"), "该精灵正在出阵中, 你确定要放入仓库吗？", function()
			self:sendPM_SwitchPackPetAndStoragePetReq(petId, nil)
			self:SetCurPetId()
		end, function()
			return
		end)
	else
		self:sendPM_SwitchPackPetAndStoragePetReq(petId, nil)
		self:SetCurPetId()
	end
end

function BagPetsController:ToBag(petId)
	if BagModel.instance:BagCount() >= 80 then
		PetSelectController.instance:OpenView(true, "精灵背包已满，请选择1只精灵替换", function(pet)
			return pet:isExist()
		end, function(id)
			local selected = id

			self:sendPM_SwitchPackPetAndStoragePetReq(selected, petId)
			self:SetWarehousePetId()

			if selected == self:GetCurPetId() then
				self:SetCurPetId()
			end
		end, function()
			return
		end)
	else
		self:sendPM_SwitchPackPetAndStoragePetReq(nil, petId)
		self:SetWarehousePetId()
	end
end

function BagPetsController:sendPM_SwitchPackPetAndStoragePetReq(packPetId, storagePetId)
	PetAgent.instance:sendPM_SwitchPackPetAndStoragePetReq(packPetId, storagePetId, function()
		GlobalDispatcher:dispatch(GlobalNotify.SetPetToStorageOk)
	end)
end

function BagPetsController:changePetLockState(petId, isLock, handler, handlerObj)
	self._handler = handler
	self._handlerObj = handlerObj

	PetAgent.instance:sendPM_ChangeLockStateReq(petId, isLock, self._onChangePetLockStateRes, self)
end

function BagPetsController:_onChangePetLockStateRes(msg)
	if msg then
		local petMo = self:getPet(msg.petId)

		if petMo then
			print("setSwitchState = " .. msg.switchState)
			petMo:setSwitchState(msg.switchState)
			print("petMo islocked = " .. tostring(petMo:isLocked()))
		end
	end

	GameUtil.callBack(self._handler, self._handlerObj)
end

function BagPetsController:setPetViewNeedClearOffset(value)
	self._petViewNeedClearOffset = value
end

function BagPetsController:getPetViewNeedClearOffset()
	self._petViewNeedClearOffset = false

	return self._petViewNeedClearOffset == true
end

function BagPetsController:upgradePetSkill(petId, skillType, callback)
	PetAgent.instance:sendPM_UpgradePetSkillReq(petId, CharacterConfig.skillTypeMap[skillType], function()
		GameUtil.callBack(callback)
	end)
end

function BagPetsController:upgradePetSkillByServerType(petId, serverType, callback)
	PetAgent.instance:sendPM_UpgradePetSkillReq(petId, serverType, function()
		GameUtil.callBack(callback)
	end)
end

function BagPetsController:getPetSkillMaxLevel(skinId, skillType)
	if skillType == GameEnum.SkillRaceType.Hero then
		return 1
	else
		local skillInfocfg = CharacterConfig.instance:getSkillInfoById(skinId)
		local list = {}

		for k, v in pairs(skillInfocfg) do
			table.insert(list, v)
		end

		table.sort(list, function(a, b)
			return a.level < b.level
		end)

		local maxLevel = #list

		for i, v in ipairs(list) do
			if checknumber(v[PetSkillView.SKILL_ID[skillType]]) == 0 then
				maxLevel = i - 1

				break
			end
		end

		return checknumber(maxLevel)
	end
end

function BagPetsController:getPetSkillMaxLevelByCfgKey(skinId, key)
	if string.nilorempty(key) then
		return 1
	end

	local skillInfocfg = CharacterConfig.instance:getSkillInfoById(skinId)
	local list = {}

	for k, v in pairs(skillInfocfg) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.level < b.level
	end)

	local maxLevel = #list

	for i, v in ipairs(list) do
		if checknumber(v[key]) == 0 then
			maxLevel = i - 1

			break
		end
	end

	return math.max(1, checknumber(maxLevel))
end

function BagPetsController:getTalentCanLvlup(mo)
	return BagModel.instance:getTalentCanLvlup(mo)
end

function BagPetsController:getIfPetSkillUpgrade(petId, type)
	if not FuncOpenModel.instance:getFuncIsOpen(196) then
		return false
	end

	local mo = self:getPet(petId)

	if mo then
		local raceId = mo.raceId
		local petCo = CharacterConfig.instance:getPetCo(raceId)
		local skillLevelStrategyId = petCo.skillLevelStrategyId
		local isRed = false

		for i, skillKey in pairs(BagModel.KEY_LIST) do
			if type == nil or type == skillKey then
				local lvlKey = BagModel.SKILL_TYPE_LEVEL_MAP[i]
				local curSkillLevel = mo[lvlKey]
				local serType = BagModel.SERVER_ID[skillKey]
				local consumeCfg = CharacterConfig.instance:getSkillLevelCfgById(skillLevelStrategyId, serType, curSkillLevel + 1)
				local maxLevel = BagPetsController.instance:getPetSkillMaxLevelByCfgKey(mo.curFaceId, skillKey)

				if consumeCfg and curSkillLevel < maxLevel then
					local limit = consumeCfg.petLevelLimit
					local enoughLevel = limit <= mo.curLv
					local enoughItem = true
					local str = consumeCfg.costMp
					local strs = string.split(str, "#")

					for i = 1, #strs do
						local consume = strs[i]
						local arr = string.split(consume, ":")
						local useNum = checknumber(arr[3])
						local has_num = MaterialFacade.instance:getMatNumber(arr[1], arr[2])

						if has_num < useNum then
							enoughItem = false

							break
						end
					end

					if enoughLevel and enoughItem then
						isRed = true

						break
					end
				end
			end
		end

		return isRed
	else
		return false
	end
end

function BagPetsController:getPetIndex()
	local list = BagModel.instance:getCurPetViewList()

	if list == nil then
		list = BagModel.instance:getBagPets() or {}
	end

	local _curIndex = 0
	local petId = BagPetsController.instance:GetCurPetId()

	if petId ~= nil then
		for i, v in ipairs(list) do
			if petId == v.petId then
				_curIndex = i

				break
			end
		end
	end

	return _curIndex
end

function BagPetsController:checkState(_curIndex)
	_curIndex = checknumber(_curIndex)

	local list = BagModel.instance:getCurPetViewList()

	if list == nil then
		list = BagModel.instance:getBagPets() or {}
	end

	if _curIndex <= 1 then
		if _curIndex >= #list then
			return BagPetsController.NO_LEFT_AND_RIGHT
		end

		return BagPetsController.NO_LEFT
	elseif _curIndex >= #list then
		return BagPetsController.NO_RIGHT
	else
		return BagPetsController.NORMAL
	end
end

function BagPetsController:goNextPet(isAdd)
	local list = BagModel.instance:getCurPetViewList()

	if list == nil then
		list = BagModel.instance:getBagPets() or {}
	end

	local _curIndex = self:getPetIndex()

	_curIndex = isAdd and _curIndex + 1 or _curIndex - 1
	_curIndex = math.max(_curIndex, 1)
	_curIndex = math.min(_curIndex, #list)

	local mo

	if #list > 0 then
		mo = list[_curIndex]
	end

	if mo then
		self:SetCurPetId(mo.petId)
	else
		self:SetCurPetId(nil)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnPetSelect)
end

function BagPetsController:getPetAttrScore(petMo, propertyName)
	local raceId = petMo:getDefineId()
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local petSkinCo = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)
	local hasBody = PetSkinConfig.instance:checkHasMutiBody(raceId)
	local score

	return hasBody and petSkinCo and petSkinCo.bodyType ~= 0 and petSkinCo[propertyName] or petCo[propertyName]
end

function BagPetsController:getPetAwakeStatus(petMo)
	if not FuncOpenModel.instance:getFuncIsOpen(49) then
		return false
	end

	if petMo:isBorrowPet() then
		return false
	else
		return BagModel.instance:getPetAwakeStatusByMo(petMo)
	end
end

function BagPetsController:getPetIsTop(petId)
	local topDic = GameUtil.getUserData(PET_TOP_KEY) or {}

	return topDic[petId .. ""] or false
end

function BagPetsController:setPetIsTop(petId, isTop)
	local topDic = GameUtil.getUserData(PET_TOP_KEY) or {}
	local newDic = {}

	for petId, value in pairs(topDic) do
		newDic[petId] = value
	end

	newDic[petId .. ""] = isTop

	GameUtil.saveUserData(PET_TOP_KEY, newDic)
end

function BagPetsController:checkPetIsActiveMaster(petMo)
	return petMo:isSummonedMaster() and petMo.level >= self._contractMasterLimitLv and petMo.isMyPackPet
end

BagPetsController.instance = BagPetsController.New()

return BagPetsController
