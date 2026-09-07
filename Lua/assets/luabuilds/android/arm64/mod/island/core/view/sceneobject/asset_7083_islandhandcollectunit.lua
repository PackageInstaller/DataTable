local IslandHandCollectUnit = class("IslandHandCollectUnit", import(".IslandSlotBaseUnit"))
local Vector3 = require("Framework.toLua.UnityEngine.Vector3")

function IslandHandCollectUnit:Ctor(arg_1_1, arg_1_2)
	IslandHandCollectUnit.super.Ctor(self, arg_1_1, arg_1_2)

	self.slotData = self.data.slotData
	self.formulaId = pg.island_production_slot[self.slotData.configId].formula[1]
	self.maxHp = pg.island_formula[self.formulaId].hitpoint
	self.currentHp = self.maxHp

	return
end

function IslandHandCollectUnit:OnAttach(arg_2_1)
	IslandHandCollectUnit.super.OnAttach(self, arg_2_1)

	self._tf = self._go.transform

	return
end

function IslandHandCollectUnit:OnStart()
	self:UpdateHandCollet()

	return
end

function IslandHandCollectUnit:LoadEffectItem()
	local var_4_0 = Vector3(pg.island_formula[self.formulaId].vfx_offset[1][1], pg.island_formula[self.formulaId].vfx_offset[1][2], pg.island_formula[self.formulaId].vfx_offset[1][3])
	local var_4_1 = Quaternion.Euler(pg.island_formula[self.formulaId].vfx_offset[2][1], pg.island_formula[self.formulaId].vfx_offset[2][2], pg.island_formula[self.formulaId].vfx_offset[2][3])

	self.effectPath = pg.island_unit_item[pg.island_formula[self.formulaId].collectable_vfx].model

	self:LoadSceneEffectItemRes(self.effectPath, function(arg_5_0)
		setParent(arg_5_0, self:GetView().root)

		self.effectGo = arg_5_0
		self.effectGo.transform.position = self._tf:TransformPoint(var_4_0)
		self.effectGo.transform.rotation = self._tf.rotation * var_4_1

		return
	end)

	return
end

function IslandHandCollectUnit:UpdateHandCollet()
	if self.slotData:GetCanCollectTimeStamps() <= 0 then
		self.hasEffect = true

		self:LoadEffectItem()
	else
		if self.hasEffect and self.effectGo then
			self:UnLoadSceneItemRes(self.effectPath, self.effectGo)
		end

		self.hasEffect = false
	end

	return
end

function IslandHandCollectUnit:GetToolId()
	local var_7_0
	local var_7_1 = getProxy(IslandProxy):GetIsland():GetAblityAgency()

	for iter_7_0, iter_7_1 in ipairs(pg.island_production_place[pg.island_production_slot[self.slotData.configId].place].tool_list) do
		if pg.island_animation_attachments[iter_7_1].unlock == 0 then
			var_7_0 = iter_7_1
		end

		if var_7_1:IsUnlockCollectTool(iter_7_1) then
			var_7_0 = iter_7_1
		end
	end

	return var_7_0
end

function IslandHandCollectUnit:GetAnimatorTrigger()
	if pg.island_production_slot[self.slotData.configId].place == IslandProductConst.MinePlaceId then
		return IslandConst.MINING_FLAG
	else
		return IslandConst.LOP_FLAG
	end

	return
end

function IslandHandCollectUnit:TakeDamage(arg_9_1)
	if self.currentHp then
		self.currentHp = self.currentHp - arg_9_1
	end

	return
end

function IslandHandCollectUnit:ResetHp()
	self.currentHp = self.maxHp

	return
end

function IslandHandCollectUnit:CheckCanStartColloct()
	if self.slotData:GetCanCollectTimeStamps() ~= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_log_recover", ((function(arg_12_0)
			return string.format("%02d:%02d:%02d", math.floor(arg_12_0 / 16), math.floor(arg_12_0 % 16 / 60), arg_12_0 % 60)
		end)(self.slotData:GetCanCollectTimeStamps() - pg.TimeMgr.GetInstance():GetServerTime()))))

		return false
	end

	return true
end

function IslandHandCollectUnit:GetHudInfo()
	local var_13_0 = {}

	if not self.slotData then
		var_13_0.needShowHud = false

		return var_13_0
	end

	var_13_0.needShowHud = true

	local var_13_1 = pg.island_formula[self.formulaId]

	var_13_0.name = pg.island_formula[self.formulaId].name

	local var_13_2 = self.slotData:GetCanCollectTimeStamps() == 0 and 1 or 0

	var_13_0.numProcess = string.format("%d/%d", var_13_2, 1)
	var_13_0.itemIcon = "island/" .. pg.island_item_data_template[var_13_1.item_id].icon

	if var_13_2 == 0 then
		var_13_0.process = 0
	elseif self.maxHp ~= 0 then
		var_13_0.process = self.currentHp / self.maxHp
	end

	return var_13_0
end

function IslandHandCollectUnit:TakeAttack()
	self:NotifiyIsland(IslandProxy.GEN_RECYCLEITEM, {
		id = self.id,
		unitId = pg.island_formula[self.formulaId].affected_vfx[1],
		position = self.position,
		rotation = self.rotation,
		recycleAssetType = IslandDelayRecycleUnitBuilder.RecycleType.ProductEffect,
		delayRecycleTime = pg.island_formula[self.formulaId].affected_vfx[2],
		behaviourTree = {}
	})

	if self.maxHp ~= 0 then
		self:TakeDamage(pg.island_animation_attachments[self:GetToolId()].attack)
		self:NotifiyCore(ISLAND_EVT.UPDATE_HUD, tonumber(self.id))

		if self.currentHp < 0 then
			self.slotData:StartColloct()
		end
	else
		self.slotData:StartColloct()
	end

	return
end

function IslandHandCollectUnit:OnDispose()
	IslandHandCollectUnit.super.OnDispose(self)

	if self.effectGo then
		self:UnLoadSceneItemRes(self.effectPath, self.effectGo)
	end

	self.hasEffect = false

	return
end

return IslandHandCollectUnit
