-- Desc: GM指令处理

local Player = require("PlayerAll").loadAllModules()
local GMServer = {}
local json = require("cjson")



local GMType = {
	["一键解锁所有功能"] = {"gmOneKeyUnlock"},
	["一键满级"] = {"gmOneKeyMaxLevel"},
	["一键中级"] = {"gmOneKeyMidLevel"},
	["增加体力"] = {"gmAddTicket", "增加数量"},
	["扣除体力"] = {"gmSubTicket", "扣除数量"},
	["增加道具"] = {"gmAddItem", "道具ID", "增加数量"},
	["扣除道具"] = {"gmSubItem", "道具ID", "扣除数量"},
	["增加英雄"] = {"gmAddHero", "英雄ID"},
	["增加装备"] = {"gmAddEquip", "装备ID"},
	["增加武器"] = {"gmAddWeapon", "武器ID"},
	["增加指挥官经验"] = {"gmAddPlayerExp", "经验值"},
	["完成任务"] = {"gmFinishTask", "任务ID"},
	["触发好感度事件"] = {"gmTriggerAffectionEvent", "事件ID"},
	["解锁功能"] = {"gmUnlockFunction", "功能ID", "状态"},
	["解锁关卡"] = {"gmUnlockLevel", "关卡ID", "是否满星", "是否通关"},
	["解锁章节"] = {"gmUnlockChapter", "章节ID", "是否满星", "是否通关"},
	["设置关卡通关次数"] = {"gmSetLevelCompleteNum", "关卡ID", "通关次数"},
	["生成派遣随机任务"] = {"GenDispatchRandomTask", "派遣ID"},
	["完成派遣任务"] = {"gmFinishDispatchTask", "派遣ID"},
	["刷新商店"] = {"gmRefreshShop", "商店ID"},
	["设置装备满级满星"] = {"gmSetEquipLevel", "装备实例ID"},
	["解锁天赋树阶段"] = {"gmUnlockTalentTreeStage", "英雄ID", "天赋树阶段ID"},
	["增加家园奖励小时数"] = {"gmAddHomelandRewardHour", "小时数"},
	["模拟演习-通关某一层"] = {"gmSimulateExercisePassLayer", "层数"},
	["模拟演习-修改往期最高层"] = {"gmSimulateExerciseSetMaxLayer", "层数"},
	["添加测试邮件"] = {"gmAddTestMail"},
	["触发家园战斗事件"] = {"gmTriggerHomelandBattleEvent"},
}


---@param player Player
---@param content string gm命令
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.clientGmRequest(player, content)
    if GV.IsServer and not GF.isGmOpen() then
        return ActionFailReason.Failed
    end

    if not content or #content < 10 then
        return ActionFailReason.GmNoCommand
    end

    if string.sub(content,1,2) ~= "//" then
        return ActionFailReason.GmWrongParam
    end

    --命令解析
    local cmd = string.sub(content,3)
	local cmdList = string.split(cmd, " ")
	local cmdName = table.remove(cmdList, 1)

	local cmdFunc = GMServer[cmdName]
	if not cmdFunc then
		return ActionFailReason.GmNoCommand
	end

	local ok, ret, needUserInfo = cmdFunc(player, table.unpack(cmdList))
	if ret ~= ActionFailReason.None then
		return ret
	end

    return ActionFailReason.None, needUserInfo
end

-------------------------------------------------------------------------------
--返回GM命令列表
---@param player Player
---@return boolean 是否成功
---@return string GM命令列表
function GMServer.help(player)
	local list = {}
	for name, cfg in pairs(GMType) do
		table.insert(list, {name = name, desc = table.concat(cfg, " ")})
	end
	return true, json.encode(list)
end


--一键解锁
---@param player Player
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmOneKeyUnlock(player)
	local needUserInfo = {}
	--解锁所有功能
	for id, _ in pairs(player.funtionOpenMap) do
		player.funtionOpenMap[id] = 2 --解锁
	end
	needUserInfo.funtionOpenMap = player.funtionOpenMap
	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end
	return true, ActionFailReason.None, needUserInfo
end

--一键满级
---@param player Player
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmOneKeyMaxLevel(player)
	local needUserInfo = {}

	--指挥官等级满级
	if player.level < 60 then
		local ret = player:addUserExp(99999, needUserInfo)
		if ret ~= ActionFailReason.None then
			LuaLogger.ws("gmOneKeyMaxLevel addUserExp failed: ", ret)
		end
	end

	--所有功能全开
	for id, _ in pairs(player.funtionOpenMap) do
		player.funtionOpenMap[id] = 2 --解锁
	end
	needUserInfo.funtionOpenMap = player.funtionOpenMap

	--添加道具
	local allItemCfg = Config.GetAllConfig("ItemTable")
	for _, cfg in pairs(allItemCfg) do
		--不添加繁荣值
		if cfg.isOpen == 1 and cfg.id ~= 100016 then
			local itemNum = player:getItemNumById(cfg.id)
			local addNum = 50000000
			--如果上限本就不多，则不减半
			if cfg.maxOwn <= 0 then
				addNum = cfg.maxOwn - itemNum
			else
				addNum = math.ceil(cfg.maxOwn / 2 - itemNum)
			end
			if addNum > 0 then
				local ret = player:addItem(cfg.id, addNum, needUserInfo, GE.EventItemType.GM, 0)
				if ret ~= ActionFailReason.None then
					LuaLogger.ws("gmOneKeyMaxLevel addItem failed: ", ret)
				end
			end
		end
	end

	--直接推送一部分数据
	player:notifyDirect({"user.UserInfoUpdate", {userinfo = needUserInfo}})
	needUserInfo = {}

	--获得所有英雄
	local needRoleList = Config.GetAllConfig("CharacterTable")
	for _, data in pairs(needRoleList) do
		if data.isOpen == 1 then
			player:addPlayerHero(data.id, needUserInfo, GE.EventItemType.GM, 0)
		end
	end

	--所有英雄满级、满星、点满天赋树、满好感度
	for cid, heroInfo in pairs(player.heroList) do
		local heroCfg = Config.GetCharacterInfo(cid)
		if heroCfg then
			--英雄经验
			local itemNum1 = player:getItemNumById(110011)
			if itemNum1 < 3000000 then
				player:addItem(110011, 99999999, needUserInfo, GE.EventItemType.GM, 0)
			end
			--金币
			local itemNum2 = player:getItemNumById(100003)
			if itemNum2 < 50000000 then
				player:addItem(100003, 99999999, needUserInfo, GE.EventItemType.GM, 0)
			end
			--升星碎片
			local cost = heroCfg.patchCost[1]
			local itemNum3 = player:getItemNumById(cost[2])
			if itemNum3 < 420 then
				player:addItem(cost[2], 999, needUserInfo, GE.EventItemType.GM, 0)
			end

			--升级
			if heroInfo.level < 60 then
				local ret = player:heroLevelUp(cid, 60, needUserInfo)
				if ret ~= ActionFailReason.None then
					LuaLogger.ws("gmOneKeyMaxLevel heroLevelUp failed: ", ret)
				end
			end
			--升星
			if heroInfo.star < 6 then
				for i = heroInfo.star + 1, 6 do
					local ret = player:heroStarUp(cid, needUserInfo)
					if ret ~= ActionFailReason.None then
						LuaLogger.ds("gmOneKeyMaxLevel heroStarUp failed: ", ret, cid, i)
					end
				end
			end
			--升好感度
			if heroInfo.affectionLevel < 10 and heroCfg.isSpecial == 0 then
				local HeroAffectionCfg = Config.GetAffectionInfo(heroCfg.affection)
				if HeroAffectionCfg and heroCfg.rank > GE.HeroRankStar.R then
					local ret = player:giveAffectionGift(cid, HeroAffectionCfg.Gift[1], 55, needUserInfo)
					if ret ~= ActionFailReason.None then
						LuaLogger.ws("gmOneKeyMaxLevel giveAffectionGift failed: ", ret, cid, HeroAffectionCfg.Gift[1])
					end
				else
					LuaLogger.ws("not HeroAffectionCfg ", heroCfg.affection)
				end
			end
			--最后再点满天赋树
			local treeListCfg = Config.GetTalentTreeInfoByTreeId(heroCfg.talentTree)
			if tablex.size(heroInfo.talentTreeList) < tablex.size(treeListCfg) then
				for _, cfg in pairs(treeListCfg) do
					if not tablex.find(heroInfo.talentTreeList, cfg.id) then
						local ret = player:talentTreeUnLockPoint(cid, cfg.id, needUserInfo, true)
						if ret ~= ActionFailReason.None then
							LuaLogger.ws("gmOneKeyMaxLevel talentTreeUnLockPoint failed: ", ret, cid, cfg.id)
						end
					end
				end
			end
		else
			LuaLogger.ws("not heroCfg ", cid)
		end
	end

	--直接推送一部分数据
	player:notifyDirect({"user.UserInfoUpdate", {userinfo = needUserInfo}})
	needUserInfo = {}

	--增加所有装备
	local allEquipCfg = Config.GetAllConfig("EquipmentTable")
	for _, cfg in pairs(allEquipCfg) do
		if cfg.isOpen == 1 then
			local ret = player:addPlayerEquip(cfg.id, needUserInfo, GE.EventItemType.GM, 0)
			if ret ~= ActionFailReason.None then
				LuaLogger.ws("gm add equip failed: ", ret)
			end
		end
	end

	--所有装备满级、满星，装备可以重复完成，不用考虑任务，直接加满
	for id, equipInfo in pairs(player.equipMap) do
		if equipInfo.level < 50 then
			local equipConfig = Config.GetEquipmentInfo(equipInfo.cid)
			equipInfo.level = 50
			---触发升级装备相关的任务
			player:missionTrigger(GE.MissionFinishType.EquipLevel, {count = 1}, needUserInfo)
			player:missionTrigger(GE.MissionFinishType.OwnEquipCountByLevelPartRank, {level = equipInfo.level, part = equipConfig.part[1], rank = equipConfig.quality}, needUserInfo)
			-- 如果是支援舰装，触发支援舰装任务
			if equipConfig.equipType == GE.EquipType.equip then
				player:missionTrigger(GE.MissionFinishType.SupportEquipReachLevel, {level = equipInfo.level}, needUserInfo)
			end
		end
		if equipInfo.star < 6 then
			equipInfo.star = 6
			---触发升星装备相关的任务
			player:missionTrigger(GE.MissionFinishType.EquipStarUp, {count = 1}, needUserInfo)
		end
	end
	needUserInfo.equipMap = player.equipMap

	--直接推送一部分数据
	player:notifyDirect({"user.UserInfoUpdate", {userinfo = needUserInfo}})
	needUserInfo = {}

	--增加所有武器
	local allWeaponCfg = Config.GetAllConfig("WeaponTable")
	for _, cfg in pairs(allWeaponCfg) do
		if cfg.isOpen == 1 then
			local ret = player:addPlayerWeapon(cfg.id, needUserInfo, GE.EventItemType.GM, 0)
			if ret ~= ActionFailReason.None then
				LuaLogger.ws("gm add weapon failed: ", ret)
			end
		end
	end

	--所有武器满级
	for id, weaponInfo in pairs(player.weaponMap) do
		local weaponConfig = Config.GetWeaponInfo(weaponInfo.cid)
		if weaponConfig then
			if weaponInfo.level < weaponConfig.levelMax then
				if weaponConfig.levelMax == 6 then
					local ret = player:addWeaponExperience(id,{{type = 1, id = 110010,num = 2}}, needUserInfo)
					if ret ~= ActionFailReason.None then
						LuaLogger.ws("gm add weapon exp failed: ", ret)
					end
				elseif weaponConfig.levelMax == 9 then
					local ret = player:addWeaponExperience(id,{{type = 1, id = 110010,num = 7}}, needUserInfo)
					if ret ~= ActionFailReason.None then
						LuaLogger.ws("gm add weapon exp failed: ", ret)
					end
				else
					local ret = player:addWeaponExperience(id,{{type = 1, id = 110010,num = 25}}, needUserInfo)
					if ret ~= ActionFailReason.None then
						LuaLogger.ws("gm add weapon exp failed: ", ret)
					end
				end
			end
		end
	end
	needUserInfo.weaponMap = player.weaponMap

	--直接推送一部分数据
	player:notifyDirect({"user.UserInfoUpdate", {userinfo = needUserInfo}})
	needUserInfo = {}

	--基盘升满
	local treeNodeMap = player:getTechTreeNodeMap()
	local technologyTreeCfg = Config.GetAllCompoundData("TechnologyTreeTable")["compound1"]
	for groupId, techList in pairs(technologyTreeCfg) do
		if not treeNodeMap[groupId] then
			treeNodeMap[groupId] = 0
		end
		--金币
		local itemNum = player:getItemNumById(100003)
		if itemNum < 50000000 then
			player:addItem(100003, 99999999, needUserInfo, GE.EventItemType.GM, 0)
		end
		if treeNodeMap[groupId] < tablex.size(techList) then
			for i = treeNodeMap[groupId] + 1, tablex.size(techList) do
				local ret = player:lightTechTreeNode(groupId, needUserInfo, true)
				if ret ~= ActionFailReason.None then
					LuaLogger.ws("gm lightTechTreeNode failed: ", ret, groupId, i)
				end
			end
		end
	end

	--直接推送一部分数据
	player:notifyDirect({"user.UserInfoUpdate", {userinfo = needUserInfo}})
	needUserInfo = {}

	--家园建筑满级
	local buildingList = player:getConstructionMapData()
	local constructionLevelCfg = Config.GetAllCompoundData("ConstructionLevelTable")["compound2"]
	for type, cfg in pairs(constructionLevelCfg) do
		if buildingList[type] then
			local maxlv = tablex.size(cfg) - 1
			if buildingList[type].level <= maxlv then
				for i = buildingList[type].level + 1, maxlv do
					local ret = player:homeBuildingLvUp(type, needUserInfo)
					if ret ~= ActionFailReason.None then
						LuaLogger.ws("gm homeBuildingLvUp failed: ", ret, type)
					end
				end
			end
		else
			LuaLogger.ws("not buildingList ", type)
		end
	end

	--直接推送一部分数据
	player:notifyDirect({"user.UserInfoUpdate", {userinfo = needUserInfo}})
	needUserInfo = {}

	--所有关卡解锁
	local LevelList = Config.GetAllConfig("PveLevelTable")
	for id, cfg in pairs(LevelList) do
		if not player.pveLevelMap[id] then
			player.pveLevelMap[id] = {
				id = id,
				state = GE.LevelStateType.Finish,
				star = 3,
				achieveList = {},
				completeNum = 1,
				battleNum = 1,
				dailyBattleNum = 0,
			}
			if not needUserInfo.pveLevelMap then
				needUserInfo.pveLevelMap = {}
			end
			needUserInfo.pveLevelMap[id] = player.pveLevelMap[id]
		end

		--更新主线关卡最大值
		if cfg.typemain == GE.LevelTypeMain.Main and id > player.userData.LevelMainMax then
			player.userData.LevelMainMax = id
			--更新社交数据
			player:socialUpdateCurrLevelId(id)
		end
	
		if cfg.typemain == GE.LevelTypeMain.Difficulty and id > player.userData.LevelDifficultMax then
			player.userData.LevelDifficultMax = id
		end

		--任务触发器
		player:missionTrigger(GE.MissionFinishType.ClearLevel, {}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelType, {levelId = id, count = 1}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelTypeCount, {count = 1}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelCount, {levelId = id, count = 1}, needUserInfo)
		-- 通关后检查以"通关指定关卡"为解锁条件的锁定任务
		player:missionLockUpdate(GE.MissionUnLockType.ClearLevel, needUserInfo)
	end

	--直接推送一部分数据
	player:notifyDirect({"user.UserInfoUpdate", {userinfo = needUserInfo}})
	needUserInfo = {}

	--获得所有皮肤
	local allSkinCfg = Config.GetAllConfig("CharacterSkinTable")
	for _, cfg in pairs(allSkinCfg) do
		player:addSkin(cfg.id, needUserInfo, GE.EventItemType.GM, 0)
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--一键中级
---@param player Player
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmOneKeyMidLevel(player)
	local needUserInfo = {}
	--指挥官升到30级
	player:addUserExp(7658, needUserInfo)

	--添加道具
	local allItemCfg = Config.GetAllConfig("ItemTable")
	for _, cfg in pairs(allItemCfg) do
		--不添加繁荣值
		if cfg.isOpen == 1 and cfg.id ~= 100016 then
			local itemNum = player:getItemNumById(cfg.id)
			local addNum = 50000000
			--如果上限本就不多，则不减半
			if cfg.maxOwn <= 0 then
				addNum = cfg.maxOwn - itemNum
			else
				addNum = math.ceil(cfg.maxOwn / 2 - itemNum)
			end
			if addNum > 0 then
				local ret = player:addItem(cfg.id, addNum, needUserInfo, GE.EventItemType.GM, 0)
				if ret ~= ActionFailReason.None then
					LuaLogger.ws("gmOneKeyMaxLevel addItem failed: ", ret)
				end
			end
		end
	end

	--增加所有武器
	local allWeaponCfg = Config.GetAllConfig("WeaponTable")
	for _, cfg in pairs(allWeaponCfg) do
		if cfg.isOpen == 1 then
			local ret = player:addPlayerWeapon(cfg.id, needUserInfo, GE.EventItemType.GM, 0)
			if ret ~= ActionFailReason.None then
				LuaLogger.ws("gm add weapon failed: ", ret)
			end
		end
	end

	--增加所有装备
	local allEquipCfg = Config.GetAllConfig("EquipmentTable")
	for _, cfg in pairs(allEquipCfg) do
		if cfg.isOpen == 1 then
			local ret = player:addPlayerEquip(cfg.id, needUserInfo, GE.EventItemType.GM, 0)
			if ret ~= ActionFailReason.None then
				LuaLogger.ws("gm add equip failed: ", ret)
			end
		end
	end

	--添加所有英雄
	local needRoleList = Config.GetAllConfig("CharacterTable")
	for _, data in pairs(needRoleList) do
		if data.isOpen == 1 then
			player:addPlayerHero(data.id, needUserInfo, GE.EventItemType.GM, 0)
		end
	end

	--所有英雄升到30级
	for cid, heroInfo in pairs(player.heroList) do
		if heroInfo.level < 30 then
			player:heroLevelUp(cid, 30, needUserInfo)
		end
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--增加体力
---@param player Player
---@param addnum integer 增加数量
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmAddTicket(player, addnum)
	addnum = addnum and tonumber(addnum) or 0
	if addnum <= 0 then
		addnum = 999 - player.ticket.num
	end

	local needUserInfo = {}
	local reason = player:addNormalTicket(addnum, true, GE.EventItemType.GM, 0)
	if reason ~= ActionFailReason.None then
		return false, reason
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--扣除体力
---@param player Player
---@param subnum integer 扣除数量
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmSubTicket(player, subnum)
	subnum = subnum and tonumber(subnum) or 0

	--gm特殊处理
	if subnum <= 0 then
		subnum = player.ticket.num
	end

	local needUserInfo = {}
	local reason = player:costNormalTicket(subnum, needUserInfo, GE.EventItemType.GM, 0)
	if not reason then
		return false, ActionFailReason.Failed
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--增加道具
---@param player Player
---@param itemid integer 道具ID
---@param num integer 增加数量
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmAddItem(player, itemid, num)
	--如果itemid为0，则表示增加所有道具
	itemid = itemid and tonumber(itemid) or 0
	--如果数量小于等于0，则默认补满一半
	num = num and tonumber(num) or 0

	local reason = ActionFailReason.None
	local needUserInfo = {}

	if itemid > 0 then
		local cfg = Config.GetItemInfo(itemid)
		if not cfg then
			return false, ActionFailReason.CfgNotFind
		end
		local itemNum = player:getItemNumById(itemid)
		local addNum = 0
		if num <= 0 then
			addNum = math.ceil(cfg.maxOwn / 2 - itemNum)
		else
			addNum = num
		end
		if addNum > 0 then
			reason = player:addItem(itemid, addNum, needUserInfo, GE.EventItemType.GM, 0)
		end
	else
		local allCfg = Config.GetAllConfig("ItemTable")
		for _, cfg in pairs(allCfg) do
			if cfg.isOpen == 1 then
				local itemNum = player:getItemNumById(cfg.id)
				local addNum = 0
				if num <= 0 then
					addNum = math.ceil(cfg.maxOwn / 2 - itemNum)
				else
					addNum = num
				end
				if addNum > 0 then
					player:addItem(cfg.id, addNum, needUserInfo, GE.EventItemType.GM, 0)
				end
			end
		end
	end

	if reason ~= ActionFailReason.None then
		return false, reason
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--扣除道具
---@param player Player
---@param itemid integer 道具ID
---@param num integer 扣除数量
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmSubItem(player, itemid, num)
	--如果itemid为0，则表示扣除所有道具
	itemid = itemid and tonumber(itemid) or 0
	--如果数量小于等于0，则默认扣除所有
	num = num and tonumber(num) or 0
	--如果扣除数量大于拥有数量，则扣除所有

	local reason = ActionFailReason.None
	local needUserInfo = {}

	if itemid <= 0 then
		local allItemList = player:getItemMap()
		for _, itemInfo in pairs(allItemList) do
			local delNum = 0
			if num <= 0 then
				delNum = itemInfo.num
			else
				delNum = num > itemInfo.num and itemInfo.num or num
			end
			if delNum > 0 then
				player:useItem(itemInfo.id, delNum, needUserInfo, GE.EventItemType.GM, 0)
			end
		end
	else
		local itemInfo = player:getItemById(itemid)
		if not itemInfo then
			return true, ActionFailReason.None
		end
		local delNum = 0
		if num <= 0 then
			delNum = itemInfo.num
		else
			delNum = num > itemInfo.num and itemInfo.num or num
		end

		reason = player:useItem(itemid, delNum, needUserInfo, GE.EventItemType.GM, 0)
		if reason ~= ActionFailReason.None then
			return false, reason
		end
	end


	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--增加英雄
---@param player Player
---@param heroCid integer 英雄ID
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmAddHero(player, heroCid)
	heroCid = heroCid and tonumber(heroCid) or 0

	local needUserInfo = {}

	if heroCid > 0 then
		player:addPlayerHero(heroCid, needUserInfo, GE.EventItemType.GM, 0)
	else
		local needRoleList = Config.GetAllConfig("CharacterTable")
		for _, data in pairs(needRoleList) do
			if data.isOpen == 1 then
				player:addPlayerHero(data.id, needUserInfo, GE.EventItemType.GM, 0)
			end
		end
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--增加装备
---@param player Player
---@param equipCid integer 装备ID
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmAddEquip(player, equipCid)
	equipCid = equipCid and tonumber(equipCid) or 0

	local needUserInfo = {}

	if equipCid > 0 then
		local ret, newId = player:addPlayerEquip(equipCid, needUserInfo, GE.EventItemType.GM, 0)
		if ret ~= ActionFailReason.None then
			return false, ret
		end
	else
		local allCfg = Config.GetAllConfig("EquipmentTable")
		for _, cfg in pairs(allCfg) do
			if cfg.isOpen == 1 then
				player:addPlayerEquip(cfg.id, needUserInfo, GE.EventItemType.GM, 0)
			end
		end
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--增加武器
---@param player Player
---@param weaponCid integer 武器ID
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmAddWeapon(player, weaponCid)
	weaponCid = weaponCid and tonumber(weaponCid) or 0
	local needUserInfo = {}

	if weaponCid > 0 then
		local ret, newId = player:addPlayerWeapon(weaponCid, needUserInfo, GE.EventItemType.GM, 0)
		if ret ~= ActionFailReason.None then
			return false, ret
		end
	else
		local allCfg = Config.GetAllConfig("WeaponTable")
		for _, cfg in pairs(allCfg) do
			if cfg.isOpen == 1 then
				player:addPlayerWeapon(cfg.id, needUserInfo, GE.EventItemType.GM, 0)
			end
		end
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--增加指挥官经验
---@param player Player
---@param exp integer 经验值
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmAddPlayerExp(player, exp)
	exp = exp and tonumber(exp) or 0

	local needUserInfo = {}
	local reason = player:addUserExp(exp, needUserInfo)
	if reason ~= ActionFailReason.None then
		return false, reason
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--完成指定任务
---@param player Player
---@param taskId integer 任务ID
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmFinishTask(player, taskId)
	taskId = taskId and tonumber(taskId) or 0

	local needUserInfo = {}
	local reason = player:gmFinishTask(taskId, needUserInfo)
	if reason ~= ActionFailReason.None then
		return false, reason
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--触发指定好感度事件
---@param player Player
---@param eventId integer 事件ID
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmTriggerAffectionEvent(player, eventId)
	eventId = eventId and tonumber(eventId) or 0

	local needUserInfo = {}
	local reason = player:gmTriggerAffectionEvent(eventId, needUserInfo)
	if reason ~= ActionFailReason.None then
		return false, reason
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--功能解锁
---@param player Player
---@param funcId integer 功能ID
---@param state integer 状态
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmUnlockFunction(player, funcId, state)
	funcId = funcId and tonumber(funcId) or 0
	state = state and tonumber(state) or 0
	if state < 1 or state > 3 then
		state = 2 --默认解锁
	end

	local needUserInfo = {}
	if not player.funtionOpenMap[funcId] then
		for id, _ in pairs(player.funtionOpenMap) do
			player.funtionOpenMap[id] = state
		end
	else
		player.funtionOpenMap[funcId] = state
	end

	needUserInfo = {
		funtionOpenMap = player.funtionOpenMap,
	}

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--解锁任意关卡
---@param player Player
---@param levelCid integer 目标关卡ID	 0表示全部关卡
---@param needFullStar integer 是否满星 0否 1是 默认不满星
---@param isClear integer 是否通关 0否 1是 默认只解锁
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmUnlockLevel(player, levelCid, isClear, needFullStar)
	levelCid = levelCid and tonumber(levelCid) or 0
	needFullStar = needFullStar and tonumber(needFullStar) or 0
	isClear = isClear and tonumber(isClear) or 0

	local starNum = needFullStar == 1 and 3 or 0
	local state = isClear == 1 and GE.LevelStateType.Finish or GE.LevelStateType.UnLock
	local completeNum = isClear == 1 and 1 or 0

	local needUserInfo = {pveLevelMap = {}}
	local LevelList = Config.GetAllConfig("PveLevelTable") or {}
	--全解锁
	if levelCid == 0 then
		for id, cfg in pairs(LevelList) do
			if not player.pveLevelMap[id] then
				player.pveLevelMap[id] = {
					id = id,
					state = state,
					star = starNum,
					achieveList = {},
					completeNum = completeNum,
					battleNum = completeNum,
					dailyBattleNum = completeNum,
				}
				needUserInfo.pveLevelMap[id] = player.pveLevelMap[id]
			else
				player.pveLevelMap[id].state = state
				player.pveLevelMap[id].star = starNum
				needUserInfo.pveLevelMap[id] = player.pveLevelMap[id]
			end

			--更新主线关卡最大值
			if cfg.typemain == GE.LevelTypeMain.Main and id > player.userData.LevelMainMax then
				player.userData.LevelMainMax = id
				--更新社交数据
				player:socialUpdateCurrLevelId(id)
			end
		
			if cfg.typemain == GE.LevelTypeMain.Difficulty and id > player.userData.LevelDifficultMax then
				player.userData.LevelDifficultMax = id
			end

			--任务触发器
			player:missionTrigger(GE.MissionFinishType.ClearLevel, {}, needUserInfo, {})
			player:missionTrigger(GE.MissionFinishType.ClearLevelType, {levelId = id, count = 1}, needUserInfo, {})
			player:missionTrigger(GE.MissionFinishType.ClearLevelTypeCount, {count = 1}, needUserInfo, {})
			player:missionTrigger(GE.MissionFinishType.ClearLevelCount, {levelId = id, count = 1}, needUserInfo)
			-- 通关后检查以"通关指定关卡"为解锁条件的锁定任务
			player:missionLockUpdate(GE.MissionUnLockType.ClearLevel, needUserInfo)
		end
	elseif LevelList[levelCid] then
		if not player.pveLevelMap[levelCid] then
			player.pveLevelMap[levelCid] = {
				id = levelCid,
				state = state,
				star = starNum,
				achieveList = {},
				completeNum = completeNum,
				battleNum = completeNum,
				dailyBattleNum = completeNum,
			}
		else
			player.pveLevelMap[levelCid].star = starNum
			player.pveLevelMap[levelCid].state = state
		end
		needUserInfo.pveLevelMap[levelCid] = player.pveLevelMap[levelCid]

		--更新主线关卡最大值
		if LevelList[levelCid].typemain == GE.LevelTypeMain.Main and levelCid > player.userData.LevelMainMax then
			player.userData.LevelMainMax = levelCid
			--更新社交数据
			player:socialUpdateCurrLevelId(levelCid)
		end
		if LevelList[levelCid].typemain == GE.LevelTypeMain.Difficulty and levelCid > player.userData.LevelDifficultMax then
			player.userData.LevelDifficultMax = levelCid
		end

		--任务触发器
		player:missionTrigger(GE.MissionFinishType.ClearLevel, {}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelType, {levelId = levelCid, count = 1}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelTypeCount, {count = 1}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelCount, {levelId = levelCid, count = 1}, needUserInfo)
		-- 通关后检查以"通关指定关卡"为解锁条件的锁定任务
		player:missionLockUpdate(GE.MissionUnLockType.ClearLevel, needUserInfo)
	else
		return false, ActionFailReason.LevelNoFind
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--解锁指定章节对应关卡 同时会解锁章节前置条件关卡
---@param player Player
---@param chapterId integer 目标章节ID
---@param needFullStar integer 是否满星 0否 1是 默认不满星
---@param isClear integer 是否通关 0否 1是 默认只解锁
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmUnlockChapter(player, chapterId, isClear, needFullStar)
	chapterId = chapterId and tonumber(chapterId) or 0
	needFullStar = needFullStar and tonumber(needFullStar) or 0
	isClear = isClear and tonumber(isClear) or 0

	local starNum = needFullStar == 1 and 3 or 0
	local state = isClear == 1 and GE.LevelStateType.Finish or GE.LevelStateType.UnLock
	local completeNum = isClear == 1 and 1 or 0

	local needUserInfo = {pveLevelMap = {}}
	local levelList = {}
	local preLevelList = {}
	local AllChapterList = Config.GetAllConfig("ChapterTable") or {}
	local AllLevelList = Config.GetAllConfig("PveLevelTable") or {}

	if not AllChapterList[chapterId] then
		return false, ActionFailReason.ChapterNoFind
	end

	--指定章节对应关卡解锁
	local levelIds = AllChapterList[chapterId].PveLevel
	for _, levelInfo in pairs(levelIds) do
		local levelId = levelInfo[1]
		if not AllLevelList[levelId] then
			return false, ActionFailReason.LevelNoFind
		else
			table.insert(levelList, levelId)
		end
	end
	local condition = AllChapterList[chapterId].Condition
	--章节前置条件解锁
	for _, v in pairs(condition) do
		if v and v[1] == 1 then
			local preLevelId = v[2]
			table.insert(preLevelList, preLevelId)
		end
	end
	--解锁章节所有关卡
	for _, levelId in pairs(levelList) do
		local cfg = AllLevelList[levelId]
		if not player.pveLevelMap[levelId] then
			needUserInfo.pveLevelMap[levelId] = {
				id = levelId,
				state = state,
				star = starNum,
				achieveList = {},
				completeNum = completeNum,
				battleNum = completeNum,
				dailyBattleNum = completeNum,
			}
		else
			needUserInfo.pveLevelMap[levelId] = player.pveLevelMap[levelId]
			needUserInfo.pveLevelMap[levelId].star = starNum
			needUserInfo.pveLevelMap[levelId].state = state
		end

		--更新主线关卡最大值
		if cfg.typemain == GE.LevelTypeMain.Main and levelId > player.userData.LevelMainMax then
			player.userData.LevelMainMax = levelId
			--更新社交数据
			player:socialUpdateCurrLevelId(levelId)
		end
	
		if cfg.typemain == GE.LevelTypeMain.Difficulty and levelId > player.userData.LevelDifficultMax then
			player.userData.LevelDifficultMax = levelId
		end

		--任务触发器
		player:missionTrigger(GE.MissionFinishType.ClearLevel, {}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelType, {levelId = levelId, count = 1}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelTypeCount, {count = 1}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelCount, {levelId = levelId, count = 1}, needUserInfo)
		-- 通关后检查以"通关指定关卡"为解锁条件的锁定任务
		player:missionLockUpdate(GE.MissionUnLockType.ClearLevel, needUserInfo)
	end
	--解锁章节前置条件关卡 状态需要为通关
	for _, levelId in pairs(preLevelList) do
		local cfg = AllLevelList[levelId]
		if not player.pveLevelMap[levelId] then
			needUserInfo.pveLevelMap[levelId] = {
				id = levelId,
				state = GE.LevelStateType.Finish,
				star = starNum,
				achieveList = {},
				completeNum = 1,
				battleNum = 1,
				dailyBattleNum = 1,
			}
		else
			needUserInfo.pveLevelMap[levelId] = player.pveLevelMap[levelId]
			needUserInfo.pveLevelMap[levelId].star = starNum
			needUserInfo.pveLevelMap[levelId].state = GE.LevelStateType.Finish
		end

		--更新主线关卡最大值
		if cfg.typemain == GE.LevelTypeMain.Main and levelId > player.userData.LevelMainMax then
			player.userData.LevelMainMax = levelId
			--更新社交数据
			player:socialUpdateCurrLevelId(levelId)
		end
	
		if cfg.typemain == GE.LevelTypeMain.Difficulty and levelId > player.userData.LevelDifficultMax then
			player.userData.LevelDifficultMax = levelId
		end

		--任务触发器
		player:missionTrigger(GE.MissionFinishType.ClearLevel, {}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelType, {levelId = levelId, count = 1}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelTypeCount, {count = 1}, needUserInfo, {})
		player:missionTrigger(GE.MissionFinishType.ClearLevelCount, {levelId = levelId, count = 1}, needUserInfo)
		-- 通关后检查以"通关指定关卡"为解锁条件的锁定任务
		player:missionLockUpdate(GE.MissionUnLockType.ClearLevel, needUserInfo)
	end
	for k, v in pairs(needUserInfo.pveLevelMap) do
		player.pveLevelMap[k] = v
	end
	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--修改关卡当日通关次数
---@param player Player
---@param levelCid integer 关卡ID
---@param num integer 通关次数
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmSetLevelCompleteNum(player, levelCid, num)
	levelCid = levelCid and tonumber(levelCid) or 0
	num = num and tonumber(num) or 0

	local needUserInfo = {}
	local levelInfo = player.pveLevelMap[levelCid]
	if not levelInfo then
		return false, ActionFailReason.BattleNoLevelData
	end

	levelInfo.completeNum = num
	needUserInfo.pveLevelMap = {}
	needUserInfo.pveLevelMap[levelCid] = levelInfo

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--生成派遣随机任务
---@param player Player
---@param dispatchId integer 派遣id
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.GenDispatchRandomTask(player, dispatchId)
	dispatchId = dispatchId and tonumber(dispatchId) or 0

	local needUserInfo = {}
	--指定派遣任务
	if dispatchId > 0 then
		local dispatchInfo = player:getDispatchTaskDataById(dispatchId)
		if dispatchInfo then
			return false, ActionFailReason.RoleInDispatch
		end
		local randomList = player:getDispatchRandomTaskList()
		if randomList[dispatchId] then
			return false, ActionFailReason.RoleInDispatch
		end
		randomList[dispatchId] = {
			dispatchId = dispatchId,
			endTime = DLuaUtil.GetGreenwichTime() + 60,
			lineId = 0,
		}
		player:updateDispatchRandomTaskList(dispatchId, needUserInfo)
	--随机派遣任务
	else
		player:randomDispatchEvent(needUserInfo)
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--完成派遣任务
---@param player Player
---@param dispatchId integer 派遣id
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmFinishDispatchTask(player, dispatchId)
	dispatchId = dispatchId and tonumber(dispatchId) or 0

	local needUserInfo = {}
	local dispatchInfo = player:getDispatchTaskDataById(dispatchId)
	if not dispatchInfo then
		return false, ActionFailReason.DispatchNotFind
	end

	dispatchInfo.state = GE.DispatchState.Finish

	needUserInfo.dispatchData = player:getDispatchData()

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--商店强制刷新
---@param player Player
---@param shopTab integer 商店页签
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmRefreshShop(player, shopTab)
	shopTab = shopTab and tonumber(shopTab) or 0
	
	local needUserInfo = {}
	local ret = player:refreshShopData(shopTab, needUserInfo)
	if ret ~= ActionFailReason.None then
		return false, ret
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--设置装备满级满星, robot专用
---@param player Player
---@param equipId integer 装备ID
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmSetEquipLevel(player, equipId)
	equipId = equipId and tonumber(equipId) or 0

	local needUserInfo = {}
	local equipInfo = player:getEquipDataByid(equipId)
	if not equipInfo then
		return false, ActionFailReason.EquipNoFind
	end

	equipInfo.level = 50
	equipInfo.star = 6
	needUserInfo.equipMap = {}
	needUserInfo.equipMap[equipId] = equipInfo

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--点亮某个阶段的天赋树
---@param player Player
---@param heroCid integer 英雄ID
---@param stageId integer 阶段id
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmUnlockTalentTreeStage(player, heroCid, stageId)
	heroCid = heroCid and tonumber(heroCid) or 0
	stageId = stageId and tonumber(stageId) or 0
	if heroCid <= 0 or stageId <= 0 then
		return false, ActionFailReason.ParameterInvalid
	end

	local needUserInfo = {}
	local heroInfo = player.heroList[heroCid]
	if not heroInfo then
		return false, ActionFailReason.HeroNoFind
	end

	local heroCfg = Config.GetCharacterInfo(heroCid)
	if not heroCfg then
		return false, ActionFailReason.HeroNoFind
	end

	local treeListCfg = Config.GetTalentTreeInfoByTreeId(heroCfg.talentTree)
	for _, cfg in pairs(treeListCfg) do
		if cfg.stageId == stageId and not tablex.find(heroInfo.talentTreeList, cfg.id) then
			local ret = player:talentTreeUnLockPoint(heroCid, cfg.id, needUserInfo, true)
			if ret ~= ActionFailReason.None then
				LuaLogger.ws("gmUnlockTalentTreeStage talentTreeUnLockPoint failed: ", ret, heroCid, cfg.id)
			end
		end
	end

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--家园增加一小时奖励
function GMServer.gmAddHomelandRewardHour(player, hours)
	hours = hours and tonumber(hours) or 0
	if hours <= 0 then
		return false, ActionFailReason.ParameterInvalid
	end

	local needUserInfo = {}
	local consMap = player:getConstructionMapData()
    for consId, consData in pairs(consMap) do
        local consConfig = Config.GetConstructionInfo(consId) or {}
        --产出建筑
        if consConfig.workType == GE.HomeLandWorkType.Resource then
            local diffTime = 3600 * hours  --增加的时间 s
            local refreshTime = Config.GetConfigInfo("constructionRate") --间隔时间 半小时刷新一次
            local passedPeriod = math.floor(diffTime / refreshTime)      --过去的周期数
            --生产时间满足 计算资源增加
            if passedPeriod > 0 then
                local effectTime = passedPeriod * refreshTime       --资源产出生效时间 s
                local efficiency = player:getHomeOutputEfficiency(consId)   --计算建筑资源产出效率
                --每个产出单独计算（效率 上限）
                for _, efficiencyDetail in pairs(efficiency) do
                    local max = efficiencyDetail[4]
                    local speed = efficiencyDetail[3]
                    local itemId = efficiencyDetail[2]
                    --产生资源数量
                    local newResourceNum = math.floor(effectTime / 3600 * speed)  --生产速度单位是xxx/小时
                    --已有资源数量
                    local existResourceNum = math.floor(player:getConstructionOutput(consId, itemId))
                    --判断资源是否已经到达上限
                    if existResourceNum >= max then
                        --到达上限不做处理
                    else
                        local finalNum = (newResourceNum + existResourceNum) >= max and max or (newResourceNum + existResourceNum)
                        player:setConstructionOutput(consId, itemId, finalNum)
                    end
                end
            end
        end
    end

	---@type Player
	player = player
    --计算仓库自然收益
    local curTime = DLuaUtil.GetGreenwichTime()

	local time = player.homeland.lastUpdateStorageTime
	if time == nil or time == 0 then
		time = curTime
	end
	time  = time - 60*60
	player.homeland.lastUpdateStorageTime = time

	local time = player.homeland.lastUpdateEarningsTime
	if time == nil or time == 0 then
		time = curTime
	end
	time  = time - 60*60
	player.homeland.lastUpdateEarningsTime = time
	player:UpdateHomelandStorageItemData(false, needUserInfo)

	--全量推送
	needUserInfo.homeland = player.homeland

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--模拟演习-通关某一层 robot专用
---@param player Player
---@param layer integer 层数
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmSimulateExercisePassLayer(player, layer)
	layer = layer and tonumber(layer) or 0
	if layer <= 0 then
		return false, ActionFailReason.ParameterInvalid
	end

	local simulatedData = player:getSimulatedActivityData()
	local nowPeriod = simulatedData.nowPeriod
	local cfgList = Config.GetPveExerciseLevelByIssueAndStorey(nowPeriod, layer)
	if not cfgList or tablex.size(cfgList) == 0 then
		return false, ActionFailReason.ParameterInvalid
	end

	local storeyCfg = Config.GetPveExerciseStoreyInfoByStoreyNum(layer)
	if not storeyCfg or not storeyCfg[1] then
		return false, ActionFailReason.ParameterInvalid
	end

	if not simulatedData.simulatedLevelMap[storeyCfg[1].id] then
		simulatedData.simulatedLevelMap[storeyCfg[1].id] = {
			getReward = false,
			levelList = {},
		}
	end
	local levelList = simulatedData.simulatedLevelMap[storeyCfg[1].id].levelList
	for _, cfg in pairs(cfgList) do
		if not tablex.find(levelList, cfg.id) then
			tablex.insertproxy(levelList, cfg.id)
		end
	end

	local needUserInfo = {}
	needUserInfo.simulatedActivity = simulatedData

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--模拟演习-修改往期最高层 robot专用
---@param player Player
---@param maxLayer integer 层数
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmSimulateExerciseSetMaxLayer(player, maxLayer)
	maxLayer = maxLayer and tonumber(maxLayer) or 0
	if maxLayer <= 0 then
		return false, ActionFailReason.ParameterInvalid
	end

	local simulatedData = player:getSimulatedActivityData()
	--不能往下调
	if maxLayer < simulatedData.maxFloor then
		return false, ActionFailReason.ParameterInvalid
	end

	simulatedData.maxFloor = maxLayer

	local needUserInfo = {}
	needUserInfo.simulatedActivity = simulatedData

	if needUserInfo and not tablex.empty(needUserInfo) then
		needUserInfo = { "user.UserInfoUpdate", { userinfo = needUserInfo } }
	end

	return true, ActionFailReason.None, needUserInfo
end

--增加测试邮件 robot专用
---@param player Player
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmAddTestMail(player)
	local needUserInfo = {}
	local mailInfo = {
		title = "测试邮件",
		content = "测试邮件内容",
		reward = {{1, 100003, 10}},
		sender = "robot",
	}
	player:createNewMail(mailInfo)
	return true, ActionFailReason.None, needUserInfo
end

--触发家园战斗事件 robot专用
---@param player Player
---@return boolean 是否成功
---@return ActionFailReason 错误码
---@return table? 协议数据
function GMServer.gmTriggerHomelandBattleEvent(player)
	local needUserInfo = {}
	player:RandomHomelandBattle(nil, needUserInfo)
	return true, ActionFailReason.None, needUserInfo
end

return GMServer