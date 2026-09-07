local BackYardSelfThemeTemplate = class("BackYardSelfThemeTemplate", import(".BackYardBaseThemeTemplate"))

function BackYardSelfThemeTemplate:Ctor(arg_1_1, arg_1_2)
	BackYardSelfThemeTemplate.super.Ctor(self, arg_1_1)

	self.floor = arg_1_2 or 1

	return
end

function BackYardSelfThemeTemplate:GetAllFurniture()
	self.furnitruesByIds = self.furnitruesByIds or self:InitFurnitures({
		mapSize = self:GetMapSize(),
		floor = self.floor,
		furniture_put_list = self:GetRawPutList()
	})

	return self.furnitruesByIds
end

function BackYardSelfThemeTemplate:AddFurniture(arg_3_1, arg_3_2)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_1.child) do
		var_3_0[iter_3_0] = iter_3_1
	end

	local var_3_1 = BackyardThemeFurniture.New({
		isNewStyle = true,
		id = arg_3_1.id,
		configId = arg_3_1.configId,
		position = Vector2(arg_3_1.x, arg_3_1.y),
		dir = arg_3_1.dir,
		child = var_3_0,
		parent = arg_3_1.parent,
		floor = arg_3_2
	})

	self:GetAllFurniture()[arg_3_1.id] = var_3_1

	return var_3_1
end

function BackYardSelfThemeTemplate:DeleteFurniture(arg_4_1)
	local var_4_0 = self:GetAllFurniture()

	if var_4_0[arg_4_1] then
		var_4_0[arg_4_1] = nil
	end

	return
end

function BackYardSelfThemeTemplate:GetFurniture(arg_5_1)
	return self:GetAllFurniture()[arg_5_1]
end

function BackYardSelfThemeTemplate:GetType()
	return BackYardConst.THEME_TEMPLATE_USAGE_TYPE_SELF
end

function BackYardSelfThemeTemplate:IsSystem()
	return false
end

function BackYardSelfThemeTemplate:IsCollected()
	return true
end

function BackYardSelfThemeTemplate:IsLiked()
	return true
end

function BackYardSelfThemeTemplate:UnLoad()
	self.time = 0

	return
end

function BackYardSelfThemeTemplate:Upload()
	self.time = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function BackYardSelfThemeTemplate:CanDispaly()
	local var_12_0 = self:IsPushed()

	return var_12_0 or not var_12_0 and self:ExistLocalImage()
end

function BackYardSelfThemeTemplate:IsUsing(arg_13_1)
	local var_13_0 = self:GetWarpFurnitures()
	local var_13_1 = table.getCount(arg_13_1)
	local var_13_2 = table.getCount(var_13_0)

	if var_13_1 ~= var_13_2 then
		local var_13_4 = Vector2(var_13_1, var_13_2)

		return
	end

	local var_13_5 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_1) do
		if self:IsSystem() and iter_13_1:getConfig("themeId") ~= self.id then
			return false, 0
		end

		local var_13_6 = iter_13_1:getConfig("id")

		var_13_5[var_13_6] = var_13_5[var_13_6] or {}

		table.insert(var_13_5[var_13_6], iter_13_1)
	end

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		if not arg_13_1[iter_13_3.id] then
			return false, 1
		end

		if not arg_13_1[iter_13_3.id]:isPaper() then
			if not arg_13_1[iter_13_3.id].position then
				return false, 2
			end

			local var_13_7 = false

			for iter_13_4, iter_13_5 in ipairs(var_13_5[iter_13_3.id] or {}) do
				if iter_13_5:isSame(iter_13_3) then
					var_13_7 = true

					break
				end
			end

			if not var_13_7 then
				return false, 3
			end
		end
	end

	return true
end

function BackYardSelfThemeTemplate:GetMissFurnitures(arg_14_1)
	local var_14_0 = self:GetWarpFurnitures()

	if #arg_14_1 == #var_14_0 then
		return
	end

	local var_14_1 = {}

	local function var_14_2(arg_15_0, arg_15_1)
		for iter_15_0, iter_15_1 in ipairs(arg_15_0) do
			arg_15_1[iter_15_1.id] = not arg_15_1[iter_15_1.id] and 0 or arg_15_1[iter_15_1.id] + 1
		end

		return
	end

	local var_14_3 = {}
	local var_14_4 = {}

	var_14_2(var_14_0, var_14_3)
	var_14_2(arg_14_1, var_14_4)

	local function var_14_5(arg_16_0)
		return {
			count = 1,
			name = pg.furniture_data_template[arg_16_0].name
		}
	end

	for iter_14_0, iter_14_1 in pairs(var_14_3) do
		if not var_14_4[iter_14_0] then
			var_14_1[iter_14_0] = var_14_5(iter_14_0)
		elseif var_14_4[iter_14_0] and iter_14_1 > var_14_4[iter_14_0] then
			var_14_1[iter_14_0] = var_14_1[iter_14_0] or var_14_5(iter_14_0)
			var_14_1[iter_14_0].count = iter_14_1 - var_14_4[iter_14_0]
		end
	end

	return var_14_1
end

function BackYardSelfThemeTemplate:getName()
	return self:GetName()
end

function BackYardSelfThemeTemplate:getIcon()
	return "themeicon"
end

return BackYardSelfThemeTemplate
