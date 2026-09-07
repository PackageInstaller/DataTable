ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleAttr
local var_0_2 = ys.Battle.BattleTargetChoise

ys.Battle.BattleSkillFusion = class("BattleSkillFusion", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillFusion.__name = "BattleSkillFusion"

local var_0_3 = ys.Battle.BattleSkillFusion

ys.Battle.BattleSkillFusion.FREEZE_POS = {
	Vector3(-10000, 0, 58),
	[-1] = Vector3(10000, 0, 58)
}

function ys.Battle.BattleSkillFusion:Ctor(arg_1_1, arg_1_2)
	var_0_3.super.Ctor(self, arg_1_1, arg_1_2)

	self._fusionUnitTempID = self._tempData.arg_list.fusion_id
	self._fusionUnitSkinID = self._tempData.arg_list.ship_skin_id
	self._elementTagList = self._tempData.arg_list.element_tag_list
	self._attrInheritList = self._tempData.arg_list.attr_inherit_list
	self._fusionUnitEquipmentList = {}

	for iter_1_0, iter_1_1 in ipairs(self._tempData.arg_list.weapon_id_list) do
		table.insert(self._fusionUnitEquipmentList, {
			id = iter_1_1,
			equipment = {
				weapon_id = {
					iter_1_1
				}
			}
		})
	end

	self._fusionUnitSkillList = {}

	for iter_1_2, iter_1_3 in ipairs(self._tempData.arg_list.buff_list) do
		table.insert(self._fusionUnitSkillList, {
			id = iter_1_3,
			level = self._level
		})
	end

	self._duration = self._tempData.arg_list.duration

	return
end

function ys.Battle.BattleSkillFusion:DoDataEffect(arg_2_1, arg_2_2)
	self:doFusion(arg_2_1)

	return
end

function ys.Battle.BattleSkillFusion:DoDataEffectWithoutTarget(arg_3_1, arg_3_2)
	self:doFusion(arg_3_1)

	return
end

function ys.Battle.BattleSkillFusion:doFusion(arg_4_1)
	local var_4_0 = var_0_2.TargetShipTag(arg_4_1, {
		ship_tag_list = self._elementTagList
	}, (var_0_2.TargetAllHelp(arg_4_1)))
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(Ship.PROPERTIES) do
		var_4_1[iter_4_1] = 1
	end

	local var_4_2 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_4_3 = var_4_2:SpawnFusionUnit(arg_4_1, {
		shipGS = 1,
		name = "123",
		id = arg_4_1.id,
		tmpID = self._fusionUnitTempID,
		skinId = self._fusionUnitSkinID,
		level = var_0_1.GetCurrent(arg_4_1, "formulaLevel"),
		equipment = self._fusionUnitEquipmentList,
		properties = var_4_1,
		baseProperties = var_4_1,
		proficiency = {
			1,
			1,
			1
		},
		rarity = arg_4_1:GetRarity(),
		intimacy = arg_4_1:GetIntimacy(),
		skills = self._fusionUnitSkillList,
		baseList = {
			1,
			1,
			1
		},
		preloasList = {
			0,
			0,
			0
		}
	}, var_4_0, self._attrInheritList)
	local var_4_4 = var_4_3:GetHP()
	local var_4_5 = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_0) do
		if iter_4_3:IsMainFleetUnit() then
			var_4_5[iter_4_3] = Clone(iter_4_3:GetPosition())
		end

		var_4_2:FreezeUnit(iter_4_3)
		iter_4_3:SetPosition(var_0_3.FREEZE_POS[iter_4_3:GetIFF()])
	end

	if arg_4_1:IsMainFleetUnit() then
		var_4_5[arg_4_1] = Clone(arg_4_1:GetPosition())
	end

	var_4_2:FreezeUnit(arg_4_1)
	arg_4_1:SetPosition(var_0_3.FREEZE_POS[arg_4_1:GetIFF()])

	self._fusionTimer = nil
	self._fusionTimer = pg.TimeMgr.GetInstance():AddBattleTimer("fusionSkillTimer", 0, self._duration, function()
		local var_5_0, var_5_1 = var_4_3:GetHP()
		local var_5_2 = var_5_1 - var_5_0
		local var_5_4 = var_4_3:GetPosition()
		local var_5_5 = var_4_3:GetAttrByName("hpProvideRate")

		if arg_4_1:IsMainFleetUnit() then
			arg_4_1:SetPosition(var_4_5[arg_4_1])
		else
			arg_4_1:SetPosition(Clone(var_5_4))
		end

		var_4_2:HandleDirectDamage(arg_4_1, (math.floor(var_5_2 * var_5_5[arg_4_1:GetAttrByName("id")])))
		var_4_2:ActiveFreezeUnit(arg_4_1)

		for iter_5_0, iter_5_1 in ipairs(var_4_0) do
			if iter_5_1:IsMainFleetUnit() then
				iter_5_1:SetPosition(var_4_5[iter_5_1])
			else
				iter_5_1:SetPosition(Clone(var_5_4))
			end

			var_4_2:HandleDirectDamage(iter_5_1, (math.floor(var_5_2 * var_5_5[iter_5_1:GetAttrByName("id")])))
			var_4_2:ActiveFreezeUnit(iter_5_1)
		end

		var_4_2:DefusionUnit(var_4_3)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._fusionTimer)

		return
	end, true)

	return
end

function ys.Battle.BattleSkillFusion:Clear()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._fusionTimer)
	var_0_3.super.Clear(self)

	return
end

return
