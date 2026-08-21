local md5Lua = require "md5Lua"

--配置表生成复合键数据
local cfg = {}


--生成复合键的表 TechnologyTreePointTable
--根据lineid获取派遣配置
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_TechnologyTreePointTable(data)
	local new = {}
	for k, v in pairs(data) do
		if not new[v.page] then
			new[v.page] = {}
		end
		table.insert(new[v.page], v)
	end
	return {compound1 = new}
end

--生成复合键的表 ActivityTable
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ActivityTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.Type
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end
	return {compound1 = new}
end

--生成复合键的表 ActivitySecondaryTable
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ActivitySecondaryTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.group
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end
	return {compound1 = new}
end

--生成复合键的表 DispatchTable
--根据lineid获取派遣配置
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_DispatchTable(data)
	local new = {}
	local new2 = {}
	for k, v in pairs(data) do
		if not new[v.group] then
			new[v.group] = {}
		end
		table.insert(new[v.group], v)

		if not new2[v.type] then
			new2[v.type] = {}
		end
		table.insert(new2[v.type], v)

	end
	return {compound1 = new, compound2 = new2}
end

--生成复合键的表 ConstructionLevelTable
--根据建筑id和等级获取对应建筑等级信息
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ConstructionLevelTable(data)
	local new = {}
	local new2 = {}
	for k, v in pairs(data) do
		local key1 = v.type
		local key2 = v.level
		if not new[key1] then
			new[key1] = {}
		end

		if not new[key1][key2] then
			new[key1][key2] = v
		end


		if not new2[key1] then
			new2[key1] = {}
		end
		table.insert(new2[key1], v)
	end
	table.sort(new2, function(a, b)
		return a.id < b.id
	end)
	return {compound1 = new, compound2 = new2}
end

--生成复合键的表 TaskTable
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_TaskTable(data)
	local new = {}
	local new2 = {}
	local new3 = {}
	for k, v in pairs(data) do
		local key1 = v.taskType
		local key2 = v.taskGroup
		local key3 = v.type
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)

		if not new2[key1] then
			new2[key1] = {}
		end
		if not new2[key1][key2] then
			new2[key1][key2] = {}
		end
		table.insert(new2[key1][key2], v)

		if not new3[key1] then
			new3[key1] = {}
		end
		if not new3[key1][key2] then
			new3[key1][key2] = {}
		end
		if not new3[key1][key2][key3] then
			new3[key1][key2][key3] = {}
		end
		table.insert(new3[key1][key2][key3], v)
	end
	
	for k, v in pairs(new3) do
		for k1, v1 in pairs(v) do
			for k2, v2 in pairs(v1) do
				table.sort(v2, function(a, b)
					return a.id < b.id
				end)
			end
		end
	end
	
	return {compound1 = new, compound2 = new2, compound3 = new3}
end

--生成复合键的表 TalentTreeTable
--根据天赋树阶段和天赋树id查找对应stage的所有信息
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_TalentTreeTable(data)
	local new1 = {}
	local new2 = {}

	for k, v in pairs(data) do
		local key1 = v.treeId
		local key2 = v.stageId
		--new1
		if not new1[key1] then
			new1[key1] = {}
		end
		local list = new1[key1][key2]
		if not list then
			list = {}
			new1[key1][key2] = list
		end
		table.insert(list, v)

		--new2
		if not new2[key1] then
			new2[key1] = {}
		end
		table.insert(new2[key1], v)
	end

	--sort
	for treeId, v1 in pairs(new1) do
		for stageId, v2 in pairs(v1) do
			table.sort(v2, function(a, b)
				return a.id < b.id
			end)
		end
	end

	for k, v in pairs(new2) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return {compound1 = new1, compound2 = new2}
end

--根据groupId获取对应的loading描述信息
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_LoadingTipsTable(data)
	--只有客户端使用
	if GV.IsServer then
		return nil
	end

	local new = {}
	for k, v in pairs(data) do
		local key1 = v.group
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	return new
end

--根据groupId获取科技树
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_TechnologyTreeTable(data)
	local new = {}
	local new2 = {}
	for k, v in pairs(data) do
		local key1 = v.group
		local key2 = v.level

		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)

		if not new2[key1] then
			new2[key1] = {}
		end
		if not new2[key1][key2] then
			new2[key1][key2] = v
		end
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	-- for k, v in pairs(new2) do
	-- 	for k1, v1 in pairs(v) do
	-- 		table.sort(v1, function(a, b)
	-- 			return a.id < b.id
	-- 		end)
	-- 	end
	-- end
	return {compound1 = new, compound2 = new2}
end

--根据功能开放表生成复合键数据
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_FunctionOpenTable(data)
	local new = {}
	for _, v in pairs(data) do
		local key1 = v.unlock
		for _, unLockData in pairs(key1) do
			if new[unLockData[1]] == nil then
				new[unLockData[1]] = {}
			end
			table.insert(new[unLockData[1]], v)
		end
	end

	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return new
end

--根据groupId获取派遣路线
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_DispatchLineTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.group
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return new
end

--根据groupId获取签到奖励
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_SignAwardTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.group
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.coordinate < b.coordinate
		end)
	end
	return new
end

--根据groupId获取派遣点位
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_DispatchPointTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.group
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.order < b.order
		end)
	end
	return new
end

--根据角色id查找对应皮肤列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_CharacterSkinTable(data)

	local new = {}
	for k, v in pairs(data) do
		local key1 = v.CharacterID
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return new
end

--根据类型获取章节列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ChapterTable(data)

	local new1 = {}
	local new2 = {}
	for k, v in pairs(data) do
		local key1 = v.Type
		local key2 = v.DeepType
		local key3 = v.Map

		--new1
		if not new1[key1] then
			new1[key1] = {}
		end
		local list = new1[key1][key2]
		if not list then
			list = {}
			new1[key1][key2] = list
		end
		table.insert(list, v.id)

		--new2
		if not new2[key3] then
			new2[key3] = {}
		end
		table.insert(new2[key3], v)
	end

	for Type, v1 in pairs(new1) do
		for DeepType, v2 in pairs(v1) do
			table.sort(v2, function(a, b)
				return a < b
			end)
		end
	end

	return {compound1 = new1, compound2 = new2}
end

--根据 类型和等级 查找阶段等级信息
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_LevelconfigTable(data)
	local new1 = {}
	local new2 = {}

	for k, v in pairs(data) do
		local key1 = v.type
		local key2 = v.level

		--new1
		if not new1[key1] then
			new1[key1] = {}
		end
		new1[key1][key2] = v

		--new2
		if not new2[key1] then
			new2[key1] = {}
		end
		table.insert(new2[key1], v)
	end

	for k, v in pairs(new2) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return {compound1 = new1, compound2 = new2}
end

--根据系统id查找对应筛选数据
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_FilterTable(data)
	--只有客户端使用
	if GV.IsServer then
		return nil
	end

	local new = {}
	for k, v in pairs(data) do
		local key1 = v.system
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return new
end

--通过阶段id和天赋树组获取天赋树阶段数据
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_TalentTreeStageTable(data)
	local new1 = {}
	local new2 = {}
	for k, v in pairs(data) do
		local key1 = v.treeId
		local key2 = v.stageId
		if not new1[key1] then
			new1[key1] = {}
		end

		new1[key1][key2] = v

		--new2
		if not new2[key1] then
			new2[key1] = {}
		end
		table.insert(new2[key1], v)
	end

	return {compound1 = new1, compound2 = new2}
end

--根据升级组查找装备等级列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_EquipLevelTable(data)
	local new1 = {}
	local new2 = {}
	local new3 = {}

	for k, v in pairs(data) do
		local key1 = v.type
		local key2 = v.levelGroup
		local key3 = v.equipLevel
		local key4 = v.breakGroup

		--new1
		if key1 ~= 0 and key2 ~= 0 and key3 ~= 0 then
			if not new1[key1] then
				new1[key1] = {}
			end
			if not new1[key1][key2] then
				new1[key1][key2] = {}
			end
			new1[key1][key2][key3] = v
		end

		--new2
		if key1 ~= 0 and key2 ~= 0 then
			if not new2[key1] then
				new2[key1] = {}
			end
			if not new2[key1][key2] then
				new2[key1][key2] = {}
			end
			table.insert(new2[key1][key2], v)
		end

		--new3
		if key1 ~= 0 and key4 ~= 0 and key3 ~= 0 then
			if not new3[key1] then
				new3[key1] = {}
			end
			if not new3[key1][key4] then
				new3[key1][key4] = {}
			end
			new3[key1][key4][key3] = v
		end
	end

	for k, v in pairs(new2) do
		for k1, v1 in pairs(v) do
			table.sort(v1, function(a, b)
				return a.id < b.id
			end)
		end
	end

	return {compound1 = new1, compound2 = new2, compound3 = new3}
end

--根据战斗事件组id获取对应战斗事件
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_PveLevelTriggerTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.baseId
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return new
end

--根据武器词条组id寻找对应词条组
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_WeaponEntryTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.group
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return new
end

--根据组id寻找对应表情动作组
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ActionTable(data)
	--只有客户端使用
	if GV.IsServer then
		return nil
	end

	local new = {}
	for k, v in pairs(data) do
		local key1 = v.group
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return new
end

--根据组id寻找对应抽卡奖励组
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_GachaTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.group
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return new
end

--根据抽卡池id和计数组id获取保底配置组
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_GachaGuarantTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.group
		local key2 = v.countGroupID
		if not new[key1] then
			new[key1] = {}
		end
		if not new[key1][key2] then
			new[key1][key2] = {}
		end
		table.insert(new[key1][key2], v)
	end

	for k, v in pairs(new) do
		for key, value in pairs(v) do
			table.sort(value, function(a, b)
				return a.id < b.id
			end)
		end
	end

	return new
end

--根据区域id来寻找移动的信息
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_HomeMoveTable(data)
	--只有客户端使用
	if GV.IsServer then
		return nil
	end

	local new = {}
	for k, v in pairs(data) do
		local key1 = v.belongArea
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	return new
end

--根据区域id来寻找移动的信息
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_HomeMovePointTable(data)
	--只有客户端使用
	if GV.IsServer then
		return nil
	end

	local new = {}
	for k, v in pairs(data) do
		local key1 = v.id
		if not new[key1] then
			new[key1] = {}
		end
		if v.effect1 and #v.effect1 > 0 then
			local data = {
				effect = v.effect1,
				upList = v.weightUp1,
				lowList = v.weightDecrease1
			}
			table.insert(new[key1], data)
		end
		if v.effect2 and #v.effect2 > 0 then
			local data = {
				effect = v.effect2,
				upList = v.weightUp2,
				lowList = v.weightDecrease2
			}
			table.insert(new[key1], data)
		end
		if v.effect3 and #v.effect3 > 0 then
			local data = {
				effect = v.effect3,
				upList = v.weightUp3,
				lowList = v.weightDecrease3
			}
			table.insert(new[key1], data)
		end
	end

	return new
end

--根据皮肤id获取对应台词列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_HomeScreenLinesTable(data)
	--只有客户端使用
	if GV.IsServer then
		return nil
	end

	local new = {}
	for k, v in pairs(data) do
		local key1 = v.skinId
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return new
end

--获取建筑能生效的词条类型
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ConstructionTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.id
		if not new[key1] then
			new[key1] = {}
		end
		for _, tab in pairs(v.signalType) do
			for _, tagType in pairs(tab) do
				table.insert(new[key1], tagType)
			end
		end
	end

	return new
end

--根据章节id获取对应的章节奖励信息
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ChapterStarTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.chapterId
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.sort < b.sort
		end)
	end

	return new
end

--根据角色Id获取对应档案信息列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ArchiveTable(data)
	--只有客户端使用
	if GV.IsServer then
		return nil
	end

	local new1 = {}
	local new2 = {}

	for k, v in pairs(data) do
		local key1 = v.character
		local key2 = v.type

		--new1
		if not new1[key1] then
			new1[key1] = {}
		end
		if not new1[key1][key2] then
			new1[key1][key2] = {}
		end
		table.insert(new1[key1][key2], v)

		--new2
		if not new2[key1] then
			new2[key1] = {}
		end
		table.insert(new2[key1], v)
	end

	for k, v in pairs(new2) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return {compound1 = new1, compound2 = new2}
end

--根据角色Id获取对应档案信息列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_AffectionSoundTable(data)
	--只有客户端使用
	if GV.IsServer then
		return nil
	end

	local new = {}
	for _, v in pairs(data) do
		local key1 = v.extraGift
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	for _, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return new
end

--根据角色Id获取对应家园事件信息列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_HomeEventTable(data)
	local new = {}
	for _, v in pairs(data) do
		local key1 = v.character
		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)
	end

	for _, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return new
end

--根据触发器类型和限制类型获取对应的事件触发器
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_EventTriggerTable(data)
	local new1 = {}
	local new2 = {}
	for _, v in pairs(data) do
		local key1 = v.type
		local key2 = v.limit[1]
		if not new1[key1] then
			new1[key1] = {}
		end
		table.insert(new1[key1], v)

		if not new2[key2] then
			new2[key2] = {}
		end
		table.insert(new2[key2], v)
	end

	for _, v in pairs(new1) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	for _, v in pairs(new2) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return {compound1 = new1, compound2 = new2}
end

--根据商品组/商店id获得对应的商品列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ShopMerchandiseTable(data)
	local new1 = {}
	local new2 = {}
	for k, v in pairs(data) do
		local key1 = v.group
		local key2 = v.shop
		if not new1[key1] then
			new1[key1] = {}
		end
		if not new2[key2] then
			new2[key2] = {}
		end
		table.insert(new1[key1], v)
		table.insert(new2[key2], v)
	end

	for k, v in pairs(new1) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return {compound1 = new1, compound2 = new2}
end

--根据期数及层数获取模拟演习关卡列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_PveExerciseLevelTable(data)
	local new1 = {}
	local new2 = {}
	for k, v in pairs(data) do
		local key1 = v.issueNum
		local key2 = v.storeyNum
		local key3 = v.LevelId

	
		if not new1[key1] then
			new1[key1] = {}
		end
		local list = new1[key1][key2]
		if not list then
			list = {}
			new1[key1][key2] = list
		end
		table.insert(list, v)


		if not new2[key1] then
			new2[key1] = {}
		end
		new2[key1][key3] = v
	end

	for _, v1 in pairs(new1) do
		for _, v2 in pairs(v1) do
			table.sort(v2, function(a, b)
				return a.id < b.id
			end)
		end
	end

	return {compound1 = new1, compound2 = new2}
end

--根据storeyNum获取扫荡层表数据
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_PveExerciseStoreyTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.storeyNum
		if key1 then
			if not new[key1] then
				new[key1] = {}
			end
			table.insert(new[key1], v)
		end
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return new
end

--根据effectId获取道具列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ItemTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.effect[1]
		if key1 then
			if not new[key1] then
				new[key1] = {}
			end
			table.insert(new[key1], v)
		end
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return new
end

--根据skinId获取spine互动列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_SkinActionTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.skinId
		if key1 then
			if not new[key1] then
				new[key1] = {}
			end
			new[key1][v.id] = v
		end
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return new
end

--根据groupId获取看板娘动作组
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ActionDesignTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.group
		if key1 then
			if not new[key1] then
				new[key1] = {}
			end
			table.insert(new[key1], v)
		end
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return new
end

-- 手机号是否为预留手机号
--- @param data table 配置表内容
--- @return table? 复合键新表
function cfg:compoundKey_ReservedAccountTable(data)
	local t = {}
	local values = {}
	for k, v in pairs(data) do
		local key = tostring(v.account)
		if t[key] then
			assert(false, "ReservedAccountTable key existed " .. key)
		end

		t[key] = v.reserved_uid

		if values[v.reserved_uid] then
			assert(false, "ReservedAccountTable value existed " .. v.reserved_uid)
		end

		values[v.reserved_uid] = key
	end

	return t
end

-- 一测手机号
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_OpenBetaTest01Table(data)
	local new = {}
	for k, v in pairs(data) do
		local key = v.phone
		if key then
			new[key] = v.id
		end
	end
	return new
end

--根据PassportId获取通行证
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_PassportTable(data)
	local new = {}
	local new2 = {}
	for k, v in pairs(data) do
		local key1 = v.PassportId
		local key2 = v.Level

		if not new[key1] then
			new[key1] = {}
		end
		table.insert(new[key1], v)

		if not new2[key1] then
			new2[key1] = {}
		end
		new2[key1][key2] = v

	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.Level < b.Level
		end)
	end

	return {compound1 = new, compound2 = new2}
end

--根据期数id获取boss战当期表数据
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_PveBossBattleTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.IssueNum
		if key1 then
			if not new[key1] then
				new[key1] = v
			end
		end
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return new
end

--根据tag组id获取boss战tag列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_PveBossBattleEffectTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.MainEffectId
		if key1 then
			if not new[key1] then
				new[key1] = {}
			end
			table.insert(new[key1], v)
		end
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return new
end

--根据codeid获取问卷数据
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_QuestionnaireTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.Codeid
		if key1 then
			new[key1] = v
		end
	end
	return new
end

--根据chapter获取StoryArrary列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_StoryArraryTable(data)
	local new = {}
	for k, v in pairs(data) do
		local key1 = v.chapter
		if key1 then
			if not new[key1] then
				new[key1] = {}
			end
			table.insert(new[key1], v)
		end
	end
	for k, v in pairs(new) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
	return new
end

--根据chapter获取Plot列表
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_PlotTable(data)
	local new = {}
	for _, v in pairs(data) do
		if not new[v.chapter] then
			new[v.chapter] = {}
		end
		table.insert(new[v.chapter], v)
	end
	return {compound1 = new}
end


--根据 类型和等级 查找阶段等级信息
---@param data CoveStoryLineTable 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_CoveStoryLineTable(data)
	local new1 = {}
	for k, v in pairs(data) do
		local key1 = v.group
		local key2 = v.id
		--new1
		if not new1[key1] then
			new1[key1] = {}
		end
		new1[key1][key2] = v
	end
	return {compound1 = new1}
end

---@param data ProsperityTable 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_ProsperityTable(data)
	local new1 = {}
	for k, v in pairs(data) do
		new1[v.levelTask] = v
	end
	return {compound1 = new1}
end


---@param data WeatherReportTable[] 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_WeatherReportTable(data)

	local new1 = {}
	for k, v in pairs(data) do
		local key1 = v.character
		local key2 = v.textType
		local key3 = v.id
		--new1
		if not new1[key1] then
			new1[key1] = {}
		end

		if not new1[key1][key2] then
			new1[key1][key2] = {}
		end
		new1[key1][key2][key3] = v
	end
	return {compound1 = new1}
end


---@param data HomeInteractiveDialogueTable[] 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_HomeInteractiveDialogueTable(data)

	local new1 = {}
	for k, v in pairs(data) do
		local keys = v.type
		for i = 1, #keys do
			local key1 = keys[i]
			if not new1[key1] then
				new1[key1] = {}
			end
			table.insert(new1[key1], v)
		end
	end
	return {compound1 = new1}
end


---@param data AutoChessBuffTable[] 配置表内容
---@return table? 复合键新表
function cfg:compoundKey_AutoChessBuffTable(data)

	local new1 = {}
	for k, v in pairs(data) do
		local key1 = v.id
		local key2 = v.lv
		--new1
		if not new1[key1] then
			new1[key1] = {}
		end

		new1[key1][key2] = v
	end
	return {compound1 = new1}
end

---@param data HomeTouchWordsTable[] 家园英雄互动对话表
---@return table? 复合键新表
function cfg:compoundKey_HomeTouchWordsTable(data)
	local new1 = {}
	local new2 = {}
	for k, v in pairs(data) do
		local key1 = v.group
		local key2 = v.samePassage

		if not new1[key1] then
			new1[key1] = {}
		end
		table.insert(new1[key1], v)

		if not new2[key2] then
			new2[key2] = {}
		end
		table.insert(new2[key2], v)
	end
	return {compound1 = new1, compound2 = new2}
end

-------------------------------------------------------
-------------------------------------------------------
--生成复合键的接口
---@param name string 配置表名称
---@param data table 配置表内容
---@return table? 复合键新表
function cfg:genCompoundKey(name, data)
	local func = cfg["compoundKey_"..name]
	if not func then
		return nil
	end

	return func(self, data)
end

return cfg