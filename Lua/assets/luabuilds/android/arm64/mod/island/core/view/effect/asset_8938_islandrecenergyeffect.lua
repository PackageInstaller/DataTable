local IslandRecEnergyEffect = class("IslandRecEnergyEffect")

IslandRecEnergyEffect.TYPE = 1

local var_0_1 = 5
local var_0_2 = Vector3(0, 2, 0)

function IslandRecEnergyEffect:Ctor(arg_1_1)
	self.root = arg_1_1:Find("root")
	self.tpl = arg_1_1:Find("tpls/RecEnergyTpl")

	setActive(self.tpl, false)

	self.pool = {}
	self.active = {}

	return
end

function IslandRecEnergyEffect:GetType()
	return IslandRecEnergyEffect.TYPE
end

function IslandRecEnergyEffect:GetObject()
	local var_3_0 = table.remove(self.pool)

	if not var_3_0 or IsNil(var_3_0) then
		var_3_0 = Object.Instantiate(self.tpl.gameObject)
	end

	var_3_0.transform:SetParent(self.root, false)

	local var_3_1 = {
		expireTime = 0
	}

	self.active[var_3_0] = var_3_1

	setActive(var_3_0, true)

	return var_3_0, var_3_1
end

function IslandRecEnergyEffect:Recycle(arg_4_1)
	if not arg_4_1 or IsNil(arg_4_1) or not self.active or not self.active[arg_4_1] then
		return
	end

	self.active[arg_4_1] = nil

	setActive(arg_4_1, false)
	arg_4_1.transform:SetParent(self.root, false)

	arg_4_1.transform.localPosition = Vector3.zero

	table.insert(self.pool, arg_4_1)

	return
end

function IslandRecEnergyEffect:GetLocalPosition(arg_5_1)
	return IslandCalcUtil.WorldPosition2LocalPosition(self.root, arg_5_1._go.transform.position + var_0_2), arg_5_1._go.transform.position + var_0_2
end

function IslandRecEnergyEffect:Play(arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_1._go then
		return
	end

	local var_6_0, var_6_1 = self:GetObject()

	var_6_1.unit = arg_6_1
	var_6_1.expireTime = Time.time + var_0_1
	var_6_0.transform.localPosition = self:GetLocalPosition(arg_6_1)

	local var_6_2 = var_6_0.transform:Find("Text")

	if var_6_2 then
		setText(var_6_2, (arg_6_2 or nil) and (arg_6_2.value or 0))
	end

	return
end

function IslandRecEnergyEffect:Update()
	for iter_7_0, iter_7_1 in pairs(self.active or {}) do
		if IsNil(iter_7_0) then
			self.active[iter_7_0] = nil
		elseif Time.time >= iter_7_1.expireTime or not iter_7_1.unit or IsNil(iter_7_1.unit._go) then
			self:Recycle(iter_7_0)
		else
			local var_7_1, var_7_2 = self:GetLocalPosition(iter_7_1.unit)
			local var_7_3 = IslandCalcUtil.IsInViewport(var_7_2)

			setActive(iter_7_0, var_7_3)

			if var_7_3 then
				iter_7_0.transform.localPosition = var_7_1
			end
		end
	end

	return
end

function IslandRecEnergyEffect:Dispose()
	self.active = nil
	self.pool = nil
	self.root = nil
	self.tpl = nil

	return
end

return IslandRecEnergyEffect
