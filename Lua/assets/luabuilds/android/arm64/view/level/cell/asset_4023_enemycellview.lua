local EnemyCellView = class("EnemyCellView")

function EnemyCellView:Ctor()
	self._extraEffectList = {}

	return
end

function EnemyCellView:SetPoolType(arg_2_1)
	self.poolType = arg_2_1

	return
end

function EnemyCellView:GetPoolType()
	return self.poolType
end

function EnemyCellView:ClearExtraEffects()
	for iter_4_0, iter_4_1 in pairs(self._extraEffectList) do
		if not IsNil(iter_4_1) then
			Destroy(iter_4_1)
		end
	end

	table.clear(self._extraEffectList)

	return
end

function EnemyCellView:LoadExtraEffects(arg_5_1)
	if arg_5_1 and #arg_5_1 > 0 then
		local var_5_0 = "effect/" .. arg_5_1

		self:GetLoader():LoadPrefab("effect/" .. arg_5_1, arg_5_1, function(arg_6_0)
			self._extraEffectList[var_5_0] = arg_6_0

			setParent(arg_6_0, self.tf, false)

			arg_6_0.transform.localScale = arg_6_0.transform.localScale

			self:ResetCanvasOrder()

			return
		end)
	end

	return
end

function EnemyCellView:RefreshEnemyTplIcons(arg_7_1, arg_7_2)
	local var_7_0 = self.tf:Find("random_buff_container")

	if not var_7_0 then
		return
	end

	local var_7_1 = {}

	if arg_7_1.icon_type == 1 then
		if ChapterConst.EnemySize[arg_7_1.type] == 1 or not ChapterConst.EnemySize[arg_7_1.type] then
			table.insert(var_7_1, "xiao")
		elseif ChapterConst.EnemySize[arg_7_1.type] == 2 then
			table.insert(var_7_1, "zhong")
		elseif ChapterConst.EnemySize[arg_7_1.type] == 3 then
			table.insert(var_7_1, "da")
		end
	end

	if arg_7_1.bufficon and #arg_7_1.bufficon > 0 then
		table.insertto(var_7_1, arg_7_1.bufficon)
	end

	underscore(arg_7_2:GetWeather(self.line.row, self.line.column)):chain():filter(function(arg_8_0)
		return arg_8_0 == ChapterConst.FlagWeatherFog
	end):each(function(arg_9_0)
		table.insert(var_7_1, pg.weather_data_template[arg_9_0].buff_icon)

		return
	end)
	setActive(var_7_0, true)
	LevelGrid.AlignListContainer(var_7_0, #var_7_1)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if #iter_7_1 > 0 then
			self:GetLoader():GetSpriteQuiet("ui/share/ship_gizmos_atlas", iter_7_1, (var_7_0:GetChild(iter_7_0 - 1)))
		end
	end

	return
end

function EnemyCellView:Clear()
	LevelCellView.Clear(self)
	self:ClearExtraEffects()

	return
end

return EnemyCellView
