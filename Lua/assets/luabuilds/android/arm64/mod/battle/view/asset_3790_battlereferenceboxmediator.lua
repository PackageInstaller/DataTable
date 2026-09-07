ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleConst
local BattleReferenceBoxMediator = class("BattleReferenceBoxMediator", ys.MVC.Mediator)

ys.Battle.BattleReferenceBoxMediator = BattleReferenceBoxMediator
BattleReferenceBoxMediator.__name = "BattleReferenceBoxMediator"

function BattleReferenceBoxMediator:Ctor()
	BattleReferenceBoxMediator.super.Ctor(self)

	return
end

function BattleReferenceBoxMediator:Initialize()
	BattleReferenceBoxMediator.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)
	self._sceneMediator = self._state:GetSceneMediator()
	self._boxContainer = GameObject("BoxContainer")
	self._detailContainer = self._state:GetUI()._tf:Find("CharacterDetailContainer").gameObject
	self._unitBoxList = {}
	self._bulletBoxList = {}
	self._wallBoxList = {}
	self._detailViewList = {}
	self._unitBoxActive = false
	self._bulletBoxActive = false
	self._detailViewActive = false

	self:initUnitEvent()

	return
end

function BattleReferenceBoxMediator:ActiveUnitBoxes(arg_3_1)
	if arg_3_1 and not self._unitBoxActive then
		self._unitBoxActive = true

		self:createExistBoxes()
	elseif not arg_3_1 and self._unitBoxActive then
		self._unitBoxActive = false

		self:removeAllBoxes()
	end

	return
end

function BattleReferenceBoxMediator:ActiveBulletBoxes(arg_4_1)
	if arg_4_1 and not self._bulletBoxActive then
		self:initBulletEvent()

		self._bulletBoxActive = true
	elseif not arg_4_1 and self._bulletBoxActive then
		self:disInitBulletEvent()
		self:removeAllBulletBoxes()

		self._bulletBoxActive = false
	end

	return
end

function BattleReferenceBoxMediator:ActiveUnitDetail(arg_5_1)
	SetActive(self._detailContainer, arg_5_1)

	if arg_5_1 and not self._detailViewActive then
		for iter_5_0, iter_5_1 in ipairs(self._dataProxy:GetFleetList()) do
			for iter_5_2, iter_5_3 in ipairs((iter_5_1:GetUnitList())) do
				self:createDetail(iter_5_3)
			end
		end

		for iter_5_4, iter_5_5 in pairs(self._dataProxy:GetUnitList()) do
			if table.contains(var_0_0.Battle.BattleUnitDetailView.EnemyMarkList, iter_5_5:GetTemplate().id) then
				self:createDetail(unit)
			end
		end

		self._detailViewActive = true
	elseif not arg_5_1 and self._detailViewActive then
		self._detailViewActive = false

		self:removeAllDetail()
	end

	return
end

function BattleReferenceBoxMediator:Update()
	for iter_6_0, iter_6_1 in pairs(self._dataProxy:GetUnitList()) do
		if self._unitBoxList[iter_6_0] then
			self._unitBoxList[iter_6_0].transform.localPosition = iter_6_1:GetPosition()
		end
	end

	if self._bulletBoxActive then
		for iter_6_2, iter_6_3 in pairs(self._dataProxy:GetBulletList()) do
			local var_6_0 = self._bulletBoxList[iter_6_2] or self:createBulletBox(iter_6_3)

			var_6_0.transform.localPosition = iter_6_3:GetPosition()
			var_6_0.transform.localEulerAngles = Vector3(0, -iter_6_3:GetYAngle(), 0)

			local var_6_1 = iter_6_3:GetBoxSize() * 2

			var_6_0.transform.localScale = Vector3(var_6_1.x, var_6_1.y, var_6_1.z)
		end

		for iter_6_4, iter_6_5 in pairs(self._dataProxy:GetWallList()) do
			(self._wallBoxList[iter_6_4] or self:createWallBox(iter_6_5)).transform.localPosition = iter_6_5:GetPosition()
		end
	end

	if self._detailViewActive then
		for iter_6_6, iter_6_7 in pairs(self._detailViewList) do
			iter_6_7:Update()
		end
	end

	return
end

function BattleReferenceBoxMediator:initUnitEvent()
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_UNIT, self.onAddUnit)
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_UNIT, self.onRemoveUnit)

	return
end

function BattleReferenceBoxMediator:disInitUnitEvent()
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_UNIT)

	return
end

function BattleReferenceBoxMediator:onAddUnit(arg_9_1)
	if self._unitBoxActive then
		self._unitBoxList[arg_9_1.Data.unit:GetUniqueID()] = self:createBox(arg_9_1.Data.unit)
	end

	if self._detailViewActive then
		if arg_9_1.Data.type == var_0_2.UnitType.PLAYER_UNIT then
			self:createDetail(arg_9_1.Data.unit)
		elseif table.contains(var_0_0.Battle.BattleUnitDetailView.EnemyMarkList, arg_9_1.Data.unit:GetTemplate().id) then
			self:createDetail(arg_9_1.Data.unit)
		end
	end

	return
end

function BattleReferenceBoxMediator:createBox(arg_10_1)
	local var_10_0
	local var_10_2 = arg_10_1:GetIFF() == 1 and "_friendly" or "_foe"
	local var_10_3 = arg_10_1:GetBoxSize()

	if var_10_3.range then
		var_10_0 = self._sceneMediator:InstantiateCharacterComponent("Cylinder" .. nil)
	else
		var_10_0 = self._sceneMediator:InstantiateCharacterComponent("Cube" .. nil)
		var_10_3 = var_10_3 * 2
	end

	var_10_0.transform:SetParent(self._boxContainer.transform)

	var_10_0.layer = LayerMask.NameToLayer("Default")
	var_10_0.transform.localScale = var_10_3.range and Vector3(var_10_3.range * 2, var_10_3.tickness * 2, var_10_3.range * 2) or Vector3(var_10_3.x, var_10_3.y, var_10_3.z)

	SetActive(var_10_0, true)

	return var_10_0
end

function BattleReferenceBoxMediator:createExistBoxes()
	for iter_11_0, iter_11_1 in pairs(self._dataProxy:GetUnitList()) do
		self._unitBoxList[iter_11_0] = self:createBox(iter_11_1)
	end

	return
end

function BattleReferenceBoxMediator:createDetail(arg_12_1)
	local var_12_0 = var_0_0.Battle.BattleUnitDetailView.New()
	local var_12_1 = arg_12_1:GetIFF()
	local var_12_2 = self._sceneMediator:InstantiateCharacterComponent("CharacterDetailContainer/detailPanel")

	var_12_2.transform:SetParent(self._state:GetUI()._tf:Find("CharacterDetailContainer/" .. arg_12_1:GetIFF()), true)
	var_12_0:ConfigSkin(var_12_2)
	var_12_0:SetUnit(arg_12_1)

	self._detailViewList[arg_12_1:GetUniqueID()] = var_12_0

	return var_12_0
end

function BattleReferenceBoxMediator:onRemoveUnit(arg_13_1)
	if self._unitBoxActive then
		self:removeBox(arg_13_1.Data.UID)
	end

	if self._detailViewActive and (arg_13_1.Data.type ~= var_0_2.UnitType.PLAYER_UNIT or arg_13_1.Data.type ~= var_0_2.UnitType.ENEMY_UNIT or arg_13_1.Data.type ~= var_0_2.UnitType.BOSS_UNIT) and self._detailViewList[arg_13_1.Data.UID] then
		self:removeDetail(arg_13_1.Data.UID)
	end

	return
end

function BattleReferenceBoxMediator:removeBox(arg_14_1)
	GameObject.Destroy(self._unitBoxList[arg_14_1])

	self._unitBoxList[arg_14_1] = nil

	return
end

function BattleReferenceBoxMediator:removeDetail(arg_15_1)
	self._detailViewList[arg_15_1]:Dispose()

	self._detailViewList[arg_15_1] = nil

	return
end

function BattleReferenceBoxMediator:removeAllBoxes()
	for iter_16_0, iter_16_1 in pairs(self._dataProxy:GetUnitList()) do
		self:removeBox(iter_16_0)
	end

	return
end

function BattleReferenceBoxMediator:removeAllDetail()
	for iter_17_0, iter_17_1 in pairs(self._detailViewList) do
		self:removeDetail(iter_17_0)
	end

	return
end

function BattleReferenceBoxMediator:initBulletEvent()
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_BULLET, self.onRemoveBullet)

	return
end

function BattleReferenceBoxMediator:disInitBulletEvent()
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_BULLET)

	return
end

function BattleReferenceBoxMediator:onRemoveBullet(arg_20_1)
	self:removeBulletBox(arg_20_1.Data.UID)

	return
end

function BattleReferenceBoxMediator:removeBulletBox(arg_21_1)
	GameObject.Destroy(self._bulletBoxList[arg_21_1])

	self._bulletBoxList[arg_21_1] = nil

	return
end

function BattleReferenceBoxMediator:removeAllBulletBoxes()
	for iter_22_0, iter_22_1 in pairs(self._bulletBoxList) do
		self:removeBulletBox(iter_22_0)
	end

	return
end

function BattleReferenceBoxMediator:createBulletBox(arg_23_1)
	local var_23_0 = arg_23_1:GetIFF() == 1 and self._sceneMediator:InstantiateCharacterComponent("Cube_friendly") or self._sceneMediator:InstantiateCharacterComponent("Cube_foe")

	var_23_0.transform:SetParent(self._boxContainer.transform)

	var_23_0.layer = LayerMask.NameToLayer("Default")

	local var_23_1 = arg_23_1:GetBoxSize() * 2

	var_23_0.transform.localScale = Vector3(var_23_1.x, var_23_1.y, var_23_1.z)

	SetActive(var_23_0, true)

	self._bulletBoxList[arg_23_1:GetUniqueID()] = var_23_0

	return var_23_0
end

function BattleReferenceBoxMediator:createWallBox(arg_24_1)
	local var_24_0 = self:createBox(arg_24_1)

	self._wallBoxList[arg_24_1:GetUniqueID()] = var_24_0

	return var_24_0
end

function BattleReferenceBoxMediator:Dispose()
	self:disInitUnitEvent()

	for iter_25_0, iter_25_1 in pairs(self._unitBoxList) do
		GameObject.Destroy(iter_25_1)
	end

	for iter_25_2, iter_25_3 in pairs(self._bulletBoxList) do
		GameObject.Destroy(iter_25_3)
	end

	for iter_25_4, iter_25_5 in pairs(self._wallBoxList) do
		GameObject.Destroy(iter_25_5)
	end

	self._unitBoxList = nil
	self._wallBoxList = nil
	self._bulletBoxList = nil

	self:removeAllDetail()

	self._detailViewList = nil

	GameObject.Destroy(self._boxContainer)
	BattleReferenceBoxMediator.super.Dispose(self)

	return
end

return
