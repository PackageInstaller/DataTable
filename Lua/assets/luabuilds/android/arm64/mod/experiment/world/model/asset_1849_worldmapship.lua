local WorldMapShip = class("WorldMapShip", import("...BaseEntity"))

WorldMapShip.Fields = {
	hpRant = "number",
	buffs = "table",
	fleetId = "number",
	triggers = "table",
	id = "number"
}
WorldMapShip.EventHpRantChange = "WorldMapShip.EventHpRantChange"
WorldMapShip.EventUpdateBuff = "WorldMapShip.EventUpdateBuff"
WorldMapShip.EventUpdateBroken = "WorldMapShip.EventUpdateBroken"

function WorldMapShip:Build()
	self.id = nil
	self.hpRant = 10000
	self.buffs = {}
	self.triggers = {}

	return
end

function WorldMapShip:Setup(arg_2_1)
	self.id = arg_2_1.id
	self.hpRant = arg_2_1.hp_rant
	self.buffs = WorldConst.ParsingBuffs(arg_2_1.buff_list)

	return
end

function WorldMapShip:Dispose()
	self:Clear()

	return
end

function WorldMapShip:GetImportWorldShipVO()
	return setmetatable({
		triggers = self.triggers,
		isBroken = self:IsBroken(),
		IsBenefitSkillActive = function(self, arg_5_1)
			local var_5_0 = false

			if arg_5_1.type == Ship.BENEFIT_SKILL then
				if not self.isBroken and (not arg_5_1.limit[1] or arg_5_1.limit[1] == self.triggers.TeamNumbers) then
					var_5_0 = true
				end
			elseif arg_5_1.type == Ship.BENEFIT_EQUIP then
				for iter_5_0, iter_5_1 in ipairs((self:getAllEquipments())) do
					if iter_5_1 and table.contains(arg_5_1.limit, iter_5_1:getConfig("id")) then
						var_5_0 = true

						break
					end
				end
			elseif arg_5_1.type == Ship.BENEFIT_MAP_AURA then
				var_5_0 = not self.isBroken
			elseif arg_5_1.type == Ship.BENEFIT_AID then
				var_5_0 = not self.isBroken
			end

			return var_5_0
		end,
		GetStaminaDiscount = function(self, arg_6_1)
			local var_6_0 = 0

			if arg_6_1 == WorldConst.OpReqSub then
				for iter_6_0, iter_6_1 in pairs(self:getAllSkills()) do
					local var_6_1 = pg.skill_benefit_template[tonumber(iter_6_0 .. string.format("%.2d", iter_6_1.level))]

					if var_6_1 and self:IsBenefitSkillActive(var_6_1) and (var_6_1.type == Ship.BENEFIT_EQUIP or var_6_1.type == Ship.BENEFIT_SKILL) then
						var_6_0 = var_6_0 + defaultValue(var_6_1.world_extra_effect[1], 0)
					end
				end
			end

			return var_6_0
		end
	}, {
		__index = WorldConst.FetchRawShipVO(self.id)
	})
end

function WorldMapShip:UpdateHpRant(arg_7_1)
	if self.hpRant ~= arg_7_1 then
		self.hpRant = arg_7_1

		self:DispatchEvent(WorldMapShip.EventHpRantChange)
	end

	return
end

function WorldMapShip:IsValid()
	return tobool(WorldConst.FetchRawShipVO(self.id))
end

function WorldMapShip:IsAlive()
	return self.hpRant > 0
end

function WorldMapShip:IsHpFull()
	return self.hpRant == 16
end

function WorldMapShip:IsHpSafe()
	return self.hpRant >= 3000
end

function WorldMapShip:GetBuffList()
	local var_12_0 = underscore.filter(underscore.values(self.buffs), function(arg_13_0)
		return arg_13_0:GetFloor() > 0
	end)
	local var_12_1 = self.fleetId and nowWorld():GetFleet(self.fleetId):GetDamageBuff()

	if var_12_1 then
		table.insert(var_12_0, var_12_1)
	end

	return var_12_0
end

function WorldMapShip:GetBuff(arg_14_1)
	if not self.buffs[arg_14_1] then
		self.buffs[arg_14_1] = WorldBuff.New()

		self.buffs[arg_14_1]:Setup({
			floor = 0,
			id = arg_14_1
		})
	end

	return self.buffs[arg_14_1]
end

function WorldMapShip:AddBuff(arg_15_1, arg_15_2)
	assert(arg_15_1 and arg_15_2)
	self:GetBuff(arg_15_1):AddFloor(arg_15_2)

	if arg_15_1 == WorldConst.BrokenBuffId then
		self:DispatchEvent(WorldMapShip.EventUpdateBroken)
	end

	self:DispatchEvent(WorldMapShip.EventUpdateBuff)

	return
end

function WorldMapShip:RemoveBuff(arg_16_1, arg_16_2)
	if arg_16_2 then
		self:GetBuff(arg_16_1):AddFloor(arg_16_2 * -1)
	else
		self.buffs[arg_16_1] = nil
	end

	if arg_16_1 == WorldConst.BrokenBuffId then
		self:DispatchEvent(WorldMapShip.EventUpdateBroken)
	end

	self:DispatchEvent(WorldMapShip.EventUpdateBuff)

	return
end

function WorldMapShip:IsBuffMax(arg_17_1)
	return self:GetBuff(arg_17_1):GetFloor() >= WorldBuff.GetTemplate(arg_17_1).buff_maxfloor
end

function WorldMapShip:Rebirth()
	assert(self.hpRant <= 0)
	self:UpdateHpRant(pg.gameset.world_death_hpfix.key_value)
	self:AddBuff(WorldConst.BrokenBuffId, 1)

	return
end

function WorldMapShip:Repair()
	self:UpdateHpRant(10000)
	self:RemoveBuff(WorldConst.BrokenBuffId)

	return
end

function WorldMapShip:Regenerate(arg_20_1)
	self:UpdateHpRant((math.min(10000, self.hpRant + arg_20_1)))

	return
end

function WorldMapShip:RegenerateValue(arg_21_1)
	self:UpdateHpRant((math.min(10000, self.hpRant + math.floor(arg_21_1 / WorldConst.FetchShipVO(self.id):getProperties(nil, true, false)[AttributeType.Durability] * 16))))

	return
end

function WorldMapShip:IsBroken()
	return self:GetBuff(WorldConst.BrokenBuffId):GetFloor() > 0
end

function WorldMapShip:GetShipBuffProperties()
	local var_23_0 = {}
	local var_23_1 = {}

	WorldConst.AppendPropertiesFromBuffList(var_23_0, var_23_1, (self.fleetId or nil) and (nowWorld():GetFleet(self.fleetId):GetBuffList() or {}))

	return var_23_0, var_23_1
end

function WorldMapShip:GetShipPowerBuffProperties()
	local var_24_0 = {}

	WorldConst.ExtendPropertiesRatesFromBuffList(var_24_0, (self:GetBuffList()))

	return var_24_0
end

return WorldMapShip
