local ExpeditionManager = class("ExpeditionManager", function()
	return require("controller.expedition_base_manager"):create()
end)
local level_manager = require("controller.level_manager")
local monster_manager = require("controller.monster_manager")
local core_manager = require("controller.core_manager")
local network = require("network.network")
local playermodel = require("model.playermodel")
local chapter_data = require("data.chapter_data")
local skill_data = require("data.skill_data")
local total_skill_data = require("data.total_skill_data")
local expedition_event_basic_data = require("data.expedition_event_basic_data")
local expedition_total_skill_data = require("data.expedition_total_skill_data")
local expedition_skill_pool_data = require("data.expedition_skill_pool_data")
local servant_data = require("data.servant_data")
local expedition_entrance_data = require("data.expedition_entrance_data")
local expedition_conversation_data = require("data.expedition_conversation_data")
local time_check_manager = require("controller.time_check_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local item_manager = require("controller.item_manager")
local dropcache_manager = require("controller.dropcache_manager")
local souls_manager = require("controller.souls_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local item_data = require("data.item_data")
local bigWar_base_data = require("data.bigWar_base_data")
local model_data = require("data.model_data")
local levelmode_data = require("data.levelmode_data")
local bigWar_role_cost_data = require("data.bigWar_role_cost_data")
local expedition_shop_data = require("data.expedition_shop_data")
local var_0_27
local bit = require("bit")
local var_0_30 = 0
local var_0_31 = {
	Free = 1,
	NeedEvent = 3,
	NeedResult = 4,
	NeedBattle = 2
}
local var_0_32 = {
	CanOperate = 3,
	HaveGot = 1,
	NotOperate = 4,
	HaveMiss = 2
}
local var_0_33 = {
	"开始冒险",
	"关卡",
	"精英",
	"随机事件",
	"休息时间",
	"招募队员",
	"",
	"",
	"关卡",
	"精英",
	""
}
local var_0_34 = {
	Reborn = 2,
	Skill = 4,
	Drop = 6,
	Blood = 1,
	Recruit = 3,
	Step = 5
}
local var_0_35

function ExpeditionManager:create()
	if var_0_35 == nil then
		var_0_35 = self.new()
	end

	return var_0_35
end

function ExpeditionManager:ctor()
	var_0_27 = 1
end

ExpeditionManager.battleFieldStatus = nil

function ExpeditionManager:set_expedition_battlefield_status(arg_4_1)
	self.battleFieldStatus = arg_4_1
end

function ExpeditionManager:get_expedition_battlefield_status()
	return self.battleFieldStatus
end

function ExpeditionManager:get_expedition_battlefield_status_info()
	if not self.battleFieldStatus then
		return nil
	end

	local battlefield_status_data = require("data.battlefield_status_data")
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(self.battleFieldStatus) do
		if battlefield_status_data[iter_6_1].des then
			table.insert(var_6_1, {
				des = battlefield_status_data[iter_6_1].des,
				icon = self:get_expedition_battlefield_status_icon(iter_6_1)
			})
		end
	end

	return var_6_1
end

local function var_0_36(arg_7_0)
	return "ArenaLayer/icon_" .. io.pathinfo(arg_7_0).filename
end

function ExpeditionManager:get_expedition_battlefield_status_localicon(arg_8_1)
	local var_8_0 = require("data.battlefield_status_data")[arg_8_1]

	if var_8_0.targetattr then
		return var_0_36(ATTRICONPATH[var_8_0.targetattr])
	end

	if var_8_0.targetcareer then
		return var_0_36(ATTRICONPATH[var_8_0.targetcareer])
	end

	return "FightLayer/map_icon.png"
end

function ExpeditionManager:get_expedition_battlefield_status_icon(arg_9_1)
	local var_9_0 = require("data.battlefield_status_data")[arg_9_1]

	if var_9_0.targetattr then
		return ATTRICONPATH[var_9_0.targetattr]
	end

	if var_9_0.targetcareer then
		return ATTRICONPATH[var_9_0.targetcareer]
	end

	return "FightLayer/map_icon.png"
end

function ExpeditionManager:initInfo(arg_10_1, arg_10_2)
	function self.updateCurLevelViewPanel()
		return
	end

	local var_10_0 = expedition_entrance_data[arg_10_1]
	local var_10_1 = {}
	local var_10_2 = 1

	while var_10_0["coin_id" .. var_10_2] do
		local var_10_3 = item_manager:getItemNumber(var_10_0["coin_id" .. var_10_2]) or 0

		table.insert(var_10_1, {
			id = var_10_0["coin_id" .. var_10_2],
			num = var_10_3,
			isSelected = var_10_2 == var_0_27 and true or false
		})

		var_10_2 = var_10_2 + 1
	end

	local var_10_4 = {
		inittype = arg_10_1,
		flip_id = expedition_entrance_data[arg_10_1].flip_id
	}

	var_10_4.flipnum = item_manager:getItemNumber(expedition_entrance_data[arg_10_1].flip_id) or 0
	var_10_4.seasontype = expedition_entrance_data[arg_10_1].season_type
	var_10_4.coinlist = var_10_1
	self.expeditionInfo = var_10_4

	self:initPlayTalkList()
	self:requestExpeditionInfo(function(arg_12_0)
		self:initExpeditionInfo(arg_12_0)

		if var_10_0.storyid then
			if not RoleDefault:getInstance():getBoolForKey("act_expedition_story" .. arg_10_1, false) then
				RoleDefault:getInstance():setBoolForKey("act_expedition_story" .. arg_10_1, true)
				require("view.Layer.TalkLayer")
				global_basic_scene:addChild(TalkLayer:create(var_10_0.storyid, nil, 1, "", function()
					if type(arg_10_2) == "function" then
						arg_10_2()
					end
				end))

				goto label_12_0
			end
		end

		if type(arg_10_2) == "function" then
			arg_10_2()
		end

		::label_12_0::
	end)
end

function ExpeditionManager:updateCoinNum()
	self.expeditionInfo.flipnum = item_manager:getItemNumber(self.expeditionInfo.flip_id) or 0

	for iter_14_0, iter_14_1 in pairs(self.expeditionInfo.coinlist) do
		iter_14_1.num = item_manager:getItemNumber(iter_14_1.id) or 0
	end
end

function ExpeditionManager:getCoinList(arg_15_1)
	arg_15_1 = arg_15_1 or false

	local var_15_0

	if arg_15_1 == true then
		for iter_15_0, iter_15_1 in pairs(self.expeditionInfo.coinlist) do
			if iter_15_1.isSelected == true then
				var_15_0 = iter_15_1

				break
			end
		end
	else
		var_15_0 = self.expeditionInfo.coinlist
	end

	return var_15_0
end

function ExpeditionManager:requestExpeditionInfo(arg_16_1)
	network:rpc("get_expedition_info", {
		type = self.expeditionInfo.inittype
	}, function(arg_17_0)
		if arg_17_0.result == 1 then
			hx_print("msg.expeditionstatuses:" .. dump(arg_17_0.expeditionstatuses), CONSOLE_COLOR_GREEN)
			hx_print("msg.monsterpower:" .. dump(arg_17_0.monsterpower), CONSOLE_COLOR_GREEN)
			self:set_expedition_battlefield_status(arg_17_0.expeditionstatuses)

			if arg_17_0.coinItem and arg_17_0.coinItem.itemcount > 0 then
				item_manager:setItemByServerItem(arg_17_0.coinItem)
				self:updateCoinNum()
			end

			if type(arg_16_1) == "function" then
				arg_16_1(arg_17_0)
			end
		else
			print("返回出错")
		end
	end)
end

function ExpeditionManager:initTeamList(arg_18_1)
	if arg_18_1 then
		for iter_18_0, iter_18_1 in pairs(arg_18_1) do
			if iter_18_1.career == "0" then
				iter_18_1.career = nil
			end

			if iter_18_1.rare == "0" then
				iter_18_1.rare = nil
			end

			if iter_18_1.servantid == nil then
				iter_18_1.isNeedSelect = true
			end

			iter_18_1.bloodpercent = tonumber(iter_18_1.bloodpercent)
			iter_18_1.energypercent = tonumber(iter_18_1.energypercent)
		end

		if self.expeditionInfo.teamList then
			for iter_18_2, iter_18_3 in pairs(arg_18_1) do
				for iter_18_4, iter_18_5 in pairs(self.expeditionInfo.teamList) do
					if iter_18_5.id == iter_18_3.id and iter_18_5.isNeedSelect == true then
						iter_18_3.isNeedSelect = true

						break
					end
				end

				if iter_18_3.servantid == nil then
					iter_18_3.isNeedSelect = true
				end
			end
		end
	end

	return arg_18_1
end

function ExpeditionManager:initEnemyList(arg_19_1, arg_19_2, arg_19_3)
	arg_19_3 = arg_19_3 or {}

	local var_19_0 = {}
	local var_19_1 = arg_19_1 or self.expeditionInfo.initmode
	local var_19_2 = arg_19_2 or self:getCurRoomIndex()

	if var_19_2 == nil then
		return
	end

	local var_19_3 = chapter_data[var_19_1 .. "-" .. var_19_2]

	if self.expeditionInfo.seasontype ~= EXPEDITION.SEASONTYPE.Monopoly then
		if self.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Expedition and (chapter_data[var_19_1 .. "-" .. var_19_2].level_type == ExpeditionRoomType.Normal or var_19_3.level_type == ExpeditionRoomType.Elite or var_19_3.level_type == ExpeditionRoomType.Boss or var_19_3.level_type == ExpeditionRoomType.TowerDefenceNormal or var_19_3.level_type == ExpeditionRoomType.TowerDefenceElite or var_19_3.level_type == ExpeditionRoomType.TowerDefenceBoss) == true then
			for iter_19_0, iter_19_1 in pairs((monster_manager.initBossList(var_19_3.bigboss))) do
				local var_19_4 = 100
				local var_19_5 = 0

				for iter_19_2, iter_19_3 in pairs(arg_19_3) do
					if iter_19_3.monsterid == iter_19_1.id then
						var_19_4 = iter_19_3.bloodpercent
						var_19_5 = iter_19_3.energypercent

						break
					end
				end

				table.insert(var_19_0, {
					id = #var_19_0 + 1,
					monsterid = iter_19_1.id,
					bloodpercent = tonumber(var_19_4),
					energypercent = tonumber(var_19_5)
				})
			end
		end
	end

	return var_19_0
end

function ExpeditionManager:getSkillList(arg_20_1)
	if arg_20_1 then
		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			if iter_20_1.rare then
				iter_20_1.needRareList = string.split(iter_20_1.rare, ",")
			end

			if iter_20_1.skillid == nil then
				iter_20_1.isNeedSelect = true
			end
		end

		if self.expeditionInfo.skilllist then
			for iter_20_2, iter_20_3 in pairs(arg_20_1) do
				for iter_20_4, iter_20_5 in pairs(self.expeditionInfo.skilllist) do
					if iter_20_5.id == iter_20_3.id and iter_20_5.isNeedSelect == true then
						iter_20_3.isNeedSelect = true

						break
					end
				end

				if iter_20_3.skillid == nil then
					iter_20_3.isNeedSelect = true
				end
			end
		end
	end

	return arg_20_1
end

function ExpeditionManager:getCurModeStr(arg_21_1)
	local var_21_0 = ""

	var_21_0 = arg_21_1 >= 10 and var_21_0 .. arg_21_1 or var_21_0 .. "0" .. arg_21_1

	return tonumber(self.expeditionInfo.inittype .. var_21_0)
end

function ExpeditionManager:getCurLevelIndex()
	return #self.expeditionInfo.curPassInfo - 1
end

function ExpeditionManager:getCurSelectLevelIndex()
	return (self.expeditionInfo.curPassInfo[#self.expeditionInfo.curPassInfo] ~= 0 or nil) and self.expeditionInfo.curPassInfo[#self.expeditionInfo.curPassInfo]
end

function ExpeditionManager:setCurSelectLevelIndex(arg_24_1, arg_24_2)
	local var_24_1 = arg_24_2
	local var_24_2 = self:getCurLevelIndex()

	for iter_24_0 = var_24_2 + 1, var_24_2 + arg_24_2 do
		if self.expeditionInfo.levelList[iter_24_0][1].level_type == ExpeditionRoomType.Elite or self.expeditionInfo.levelList[iter_24_0][1].level_type == ExpeditionRoomType.Boss or self.expeditionInfo.levelList[iter_24_0][1].level_type == ExpeditionRoomType.Transmit or self.expeditionInfo.levelList[iter_24_0][1].level_type == ExpeditionRoomType.TowerDefenceElite or self.expeditionInfo.levelList[iter_24_0][1].level_type == ExpeditionRoomType.TowerDefenceBoss then
			var_24_1 = iter_24_0 - var_24_2

			break
		end
	end

	for iter_24_1 = 1, var_24_1 - 1 do
		self.expeditionInfo.curPassInfo[#self.expeditionInfo.curPassInfo + 1] = 0
	end

	self.expeditionInfo.curPassInfo[#self.expeditionInfo.curPassInfo] = arg_24_1
	self.expeditionInfo.curSelectLevel = self:getCurSelectLevelIndex()
	self.expeditionInfo.curLevel = self:getCurLevelIndex()
end

function ExpeditionManager:initExpeditionInfo(arg_25_1)
	if arg_25_1 == nil then
		return
	end

	self.expeditionInfo.initmode = self:getCurModeStr(arg_25_1.curchapter)

	local var_25_0 = {}
	local var_25_1 = {}

	for iter_25_0, iter_25_1 in pairs(chapter_data) do
		if iter_25_1.mode == self.expeditionInfo.initmode then
			table.insert(var_25_0, iter_25_1)

			if var_25_1[iter_25_1.level_index] == nil then
				var_25_1[iter_25_1.level_index] = {}
			end

			table.insert(var_25_1[iter_25_1.level_index], iter_25_1)
		end
	end

	if #var_25_0 > 1 then
		table.sort(var_25_0, function(arg_26_0, arg_26_1)
			return arg_26_0.index < arg_26_1.index
		end)
	end

	for iter_25_2, iter_25_3 in pairs(var_25_1) do
		table.sort(iter_25_3, function(arg_27_0, arg_27_1)
			return arg_27_0.index < arg_27_1.index
		end)
	end

	self.expeditionInfo.needChapterData = var_25_0
	self.expeditionInfo.stepLength = var_25_0[#var_25_0].level_index
	self.expeditionInfo.levelList = var_25_1
	self.expeditionInfo.curChapter = arg_25_1.curchapter

	local var_25_2 = arg_25_1.curpassinfo

	self.expeditionInfo.curPassInfo = arg_25_1.curpassinfo
	self.expeditionInfo.recordInfo = arg_25_1.recordInfo
	self.expeditionInfo.curEventInfo = arg_25_1.cureventinfo
	self.expeditionInfo.curLevel = self:getCurLevelIndex()
	self.expeditionInfo.curSelectLevel = self:getCurSelectLevelIndex()
	self.expeditionInfo.endTime = arg_25_1.endtime
	self.expeditionInfo.enemylist = arg_25_1.enemylist
	self.expeditionInfo.isBackToOrigin = arg_25_1.isbacktoorigin == 1
	self.expeditionInfo.teamList = self:initTeamList(arg_25_1.teamlist)
	self.expeditionInfo.skillList = self:getSkillList(arg_25_1.skilllist)
	self.expeditionInfo.canFightServantList = self:getCanFightServantList()
	self.expeditionInfo.originTeamList = arg_25_1.teamlist
	self.expeditionInfo.originSkillList = arg_25_1.skilllist
	self.expeditionInfo.enemyList = self:initEnemyList(nil, nil, arg_25_1.enemylist)
	self.expeditionInfo.levelTitle = "第" .. self.expeditionInfo.curChapter .. "章"
	self.expeditionInfo.stepList = {}
	self.expeditionInfo.initFightRoleList = {}
	self.expeditionInfo.monsterpower = arg_25_1.monsterpower

	local var_25_4 = 1

	for iter_25_4 = 1, self.expeditionInfo.stepLength do
		local var_25_5 = {}

		for iter_25_5 = 1, #self.expeditionInfo.levelList[iter_25_4] do
			local var_25_6 = self.expeditionInfo.needChapterData[var_25_4].level_type or ExpeditionRoomType.Normal
			local var_25_7

			if var_25_6 == ExpeditionRoomType.Start then
				var_25_7 = "当前第" .. self.expeditionInfo.curChapter .. "章" or var_0_33[var_25_6]
			end

			local var_25_8 = self.expeditionInfo.needChapterData[var_25_4]
			local var_25_9 = ""
			local var_25_10 = {}

			while var_25_8["event_id" .. 1] do
				assert(expedition_event_basic_data[var_25_8["event_id" .. 1]], string.format("expedition_event_basic_data 中没有id为%d的数据，请检查~", var_25_8["event_id" .. 1]))

				if 1 == 1 then
					var_25_9 = expedition_event_basic_data[var_25_8["event_id" .. 1]].event_icon and "mainScenebg/postcard/" .. expedition_event_basic_data[var_25_8["event_id" .. 1]].event_icon .. ".png" or ""
				end

				table.insert(var_25_10, {
					eventid = var_25_8["event_id" .. 1],
					classification = expedition_event_basic_data[var_25_8["event_id" .. 1]].event_classification
				})
			end

			local var_25_12

			if self.expeditionInfo.curSelectLevel == nil then
				if var_25_2[iter_25_4] == nil then
					var_25_12 = var_0_32.NotOperate
				elseif var_25_2[iter_25_4] == 0 and #var_25_2 == iter_25_4 then
					if iter_25_4 <= 1 then
						var_25_12 = var_0_32.CanOperate
					else
						local var_25_13 = self.expeditionInfo.levelList[iter_25_4 - 1][var_25_2[iter_25_4 - 1]].next_level2

						var_25_12 = (self.expeditionInfo.levelList[iter_25_4 - 1][var_25_2[iter_25_4 - 1]].next_level1 and self.expeditionInfo.levelList[iter_25_4 - 1][var_25_2[iter_25_4 - 1]].next_level1 == self.expeditionInfo.levelList[iter_25_4][iter_25_5].index or var_25_13 and var_25_13 == self.expeditionInfo.levelList[iter_25_4][iter_25_5].index) and var_0_32.CanOperate or var_0_32.HaveMiss
					end
				elseif var_25_2[iter_25_4] == iter_25_5 then
					var_25_12 = var_0_32.HaveGot
				elseif var_25_2[iter_25_4] ~= iter_25_5 then
					var_25_12 = var_0_32.HaveMiss
				end
			elseif var_25_2[iter_25_4] == nil then
				var_25_12 = var_0_32.NotOperate
			elseif var_25_2[iter_25_4] == iter_25_5 and iter_25_4 - 1 == self.expeditionInfo.curLevel then
				var_25_12 = var_0_32.CanOperate
			elseif var_25_2[iter_25_4] ~= iter_25_5 and iter_25_4 - 1 == self.expeditionInfo.curLevel then
				var_25_12 = var_0_32.HaveMiss
			elseif var_25_2[iter_25_4] == iter_25_5 and iter_25_4 - 1 ~= self.expeditionInfo.curLevel then
				var_25_12 = var_0_32.HaveGot
			elseif var_25_2[iter_25_4] ~= iter_25_5 and iter_25_5 ~= self.expeditionInfo.curSelectLevel then
				var_25_12 = var_0_32.HaveMiss
			end

			local var_25_14 = {}

			if var_25_6 ~= ExpeditionRoomType.TowerDefenceNormal and var_25_6 ~= ExpeditionRoomType.TowerDefenceElite then
				local var_25_18

				if var_25_6 == ExpeditionRoomType.TowerDefenceBoss then
					for iter_25_6, iter_25_7 in pairs({
						"player",
						"enemy"
					}) do
						local var_25_15 = {}

						table.insert(var_25_15, {
							isbase = true,
							pos_x = var_25_8[iter_25_7 .. "base_posx"],
							baseid = var_25_8[iter_25_7 .. "baseid"],
							majorlist = var_25_8[iter_25_7 .. "baseid"] and bigWar_base_data[var_25_8[iter_25_7 .. "baseid"]],
							charactertype = iter_25_7
						})

						while var_25_8 and var_25_8[(iter_25_7 .. "tower") .. 1] do
							table.insert(var_25_15, {
								isbase = false,
								pos_x = var_25_8[(iter_25_7 .. "tower") .. 1 .. "_posx"],
								baseid = var_25_8[(iter_25_7 .. "tower") .. 1],
								majorlist = bigWar_base_data[var_25_8[(iter_25_7 .. "tower") .. 1]],
								charactertype = iter_25_7
							})
						end

						table.insert(var_25_14, var_25_15)
					end

					var_25_18 = {
						isCanOperate = false,
						roomIndex = var_25_4,
						roomType = var_25_6,
						name = var_25_7,
						des = var_25_8.des,
						eventClassificationList = var_25_10,
						detailPath = var_25_9,
						roomStatus = var_25_12,
						next_level1 = var_25_8.next_level1,
						next_level2 = var_25_8.next_level2,
						roomIcon = var_25_8.roomIcon,
						baseConfig = var_25_14
					}
				end
			end

			var_25_18.isHaveFog = true

			table.insert(var_25_5, var_25_18)

			var_25_4 = var_25_4 + 1
		end

		table.insert(self.expeditionInfo.stepList, {
			index = iter_25_4,
			name = "第" .. iter_25_4 .. "层",
			roomList = var_25_5
		})
	end

	self:initExpeditionOperateInfo()

	for iter_25_8, iter_25_9 in pairs(arg_25_1.recordInfo) do
		if iter_25_9 ~= 0 and self.expeditionInfo.stepList[iter_25_8] then
			self.expeditionInfo.stepList[iter_25_8].roomList[iter_25_9].isHaveFog = false
		end
	end

	local var_25_19 = levelmode_data[self:getCurMode()]

	self.isLastLevelMode = var_25_19.jumpnextmode == nil
	self.expeditionInfo.chapterTipsStr = var_25_19.levelmode_tips or "示例文字示例文字示例文字示例文字示例文字示例文字示例文字示例文字示例文字"
	self.expeditionInfo.chapterDropId = var_25_19.chapter_drop or "SPBLQ2LB05"
	self.expeditionInfo.bossPath = var_25_19.boss_path or "40000"
end

function ExpeditionManager:initExpeditionOperateInfo()
	if self.expeditionInfo.stepList[self.expeditionInfo.curLevel + 1] then
		if self.expeditionInfo.curLevel > 0 then
			if self.expeditionInfo.curPassInfo[self.expeditionInfo.curLevel] > 0 then
				local var_29_0 = self.expeditionInfo.needChapterData[self.expeditionInfo.stepList[self.expeditionInfo.curLevel].roomList[math.abs(self.expeditionInfo.curPassInfo[self.expeditionInfo.curLevel])].roomIndex]

				if var_29_0 then
					for iter_29_0 = 1, 2 do
						if var_29_0["next_level" .. iter_29_0] ~= nil then
							for iter_29_1 = 1, #self.expeditionInfo.stepList[self.expeditionInfo.curLevel + 1].roomList do
								if self.expeditionInfo.stepList[self.expeditionInfo.curLevel + 1].roomList[iter_29_1].roomIndex == var_29_0["next_level" .. iter_29_0] and (self.expeditionInfo.curSelectLevel == nil or iter_29_1 == math.abs(self.expeditionInfo.curSelectLevel)) then
									self.expeditionInfo.stepList[self.expeditionInfo.curLevel + 1].roomList[iter_29_1].isCanOperate = true

									break
								end
							end
						end
					end
				end
			else
				print("lastSelectIndex==0!!!!!!!!")
			end
		else
			local var_29_1 = self.expeditionInfo.stepList[1].roomList

			if self.expeditionInfo.curSelectLevel == nil then
				for iter_29_2 = 1, #var_29_1 do
					var_29_1[iter_29_2].isCanOperate = true
				end
			else
				for iter_29_3 = 1, #var_29_1 do
					var_29_1[iter_29_3].isCanOperate = self.expeditionInfo.curSelectLevel == iter_29_3
				end
			end
		end
	end
end

function ExpeditionManager:getCurServantStatus(arg_30_1)
	local var_30_0 = 1
	local var_30_1 = 1

	for iter_30_0, iter_30_1 in pairs(self.expeditionInfo.teamList) do
		if iter_30_1.servantid == arg_30_1 then
			var_30_0 = iter_30_1.bloodpercent and iter_30_1.bloodpercent / 100 or 1
			var_30_1 = iter_30_1.energypercent and iter_30_1.energypercent / 100 or 1

			break
		end
	end

	return var_30_0, var_30_1
end

function ExpeditionManager:getCurLevelBossInfo(arg_31_1)
	return (monster_manager.initBossList(chapter_data[self.expeditionInfo.initmode .. "-" .. arg_31_1].bigboss))
end

function ExpeditionManager:getCurLevelBossBloodInfo(arg_32_1)
	local var_32_2 = monster_manager.initBossList(chapter_data[self.expeditionInfo.initmode .. "-" .. arg_32_1].bigboss)
	local var_32_3 = self.expeditionInfo.enemyList
	local var_32_4

	if not self.expeditionInfo.enemyList then
		var_32_3 = {}
	end

	for iter_32_0, iter_32_1 in pairs(self.expeditionInfo.stepList) do
		for iter_32_2, iter_32_3 in pairs(iter_32_1.roomList) do
			if iter_32_3.roomIndex == arg_32_1 then
				var_32_4 = iter_32_3

				break
			end
		end
	end

	local var_32_5 = var_32_2.boss.majorlist.hp
	local var_32_6 = 0

	if var_32_4.roomStatus == var_0_32.HaveGot then
		var_32_6 = 0
	elseif var_32_4.roomStatus == var_0_32.HaveMiss or var_32_4.roomStatus == var_0_32.NotOperate then
		var_32_6 = var_32_2.boss.majorlist.hp
	elseif var_32_4.roomStatus == var_0_32.CanOperate then
		if self:getCurLevelStatus() ~= var_0_31.Free and self:getCurLevelStatus() ~= var_0_31.NeedBattle then
			var_32_6 = 0
		else
			var_32_6 = var_32_2.boss.majorlist.hp

			for iter_32_4, iter_32_5 in pairs(var_32_3) do
				if iter_32_5.monsterid == var_32_2.boss.id then
					var_32_6 = var_32_5 * iter_32_5.bloodpercent / 100

					break
				end
			end
		end
	end

	return var_32_6, var_32_5
end

function ExpeditionManager:getExpeditionInfo()
	return self.expeditionInfo
end

function ExpeditionManager:getExpeditionTeamListInfo()
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(self.expeditionInfo.teamList) do
		var_34_0[iter_34_1.servantid] = {
			servantid = iter_34_1.servantid,
			bloodpercent = iter_34_1.bloodpercent,
			energypercent = iter_34_1.energypercent
		}
	end

	local var_34_1 = {}

	for iter_34_2, iter_34_3 in pairs((self:getOwnServant())) do
		if var_34_0[iter_34_3] then
			table.insert(var_34_1, {
				servantid = iter_34_3,
				bloodpercent = var_34_0[iter_34_3].bloodpercent,
				energypercent = var_34_0[iter_34_3].energypercent
			})
		else
			table.insert(var_34_1, {
				bloodpercent = 100,
				energypercent = 0,
				servantid = iter_34_3
			})
		end
	end

	return var_34_1
end

function ExpeditionManager:getCanFightServantList(...)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in pairs(self.expeditionInfo.teamList) do
		var_35_0[iter_35_1.servantid] = {
			servantid = iter_35_1.servantid,
			bloodpercent = iter_35_1.bloodpercent,
			energypercent = iter_35_1.energypercent
		}
	end

	local var_35_1 = {}

	for iter_35_2, iter_35_3 in pairs((self:getOwnServant())) do
		if not var_35_0[iter_35_3] then
			table.insert(var_35_1, {
				bloodpercent = 100,
				energypercent = 0,
				servantid = iter_35_3
			})
		elseif var_35_0[iter_35_3].bloodpercent > 0 then
			table.insert(var_35_1, {
				servantid = iter_35_3,
				bloodpercent = var_35_0[iter_35_3].bloodpercent,
				energypercent = var_35_0[iter_35_3].energypercent
			})
		end
	end

	local var_35_2 = {}

	for iter_35_4, iter_35_5 in pairs(var_35_1) do
		table.insert(var_35_2, iter_35_5.servantid)
	end

	local var_35_3 = {}

	for iter_35_6, iter_35_7 in pairs((self:sortRoleListTbl(var_35_2))) do
		var_35_3[iter_35_7] = iter_35_6
	end

	table.sort(var_35_1, function(arg_36_0, arg_36_1)
		return var_35_3[arg_36_0.servantid] < var_35_3[arg_36_1.servantid]
	end)

	return var_35_1
end

function ExpeditionManager:getInitFightRoles()
	return self.expeditionInfo.initFightRoleList
end

function ExpeditionManager:isHaveStudent()
	local var_38_0 = false

	for iter_38_0, iter_38_1 in pairs(self.expeditionInfo.teamList) do
		if iter_38_1.servantid then
			var_38_0 = true

			break
		end
	end

	return var_38_0
end

function ExpeditionManager:setExpeditionStudentList(arg_39_1, arg_39_2, arg_39_3)
	if arg_39_1 <= #self.expeditionInfo.teamList then
		self.expeditionInfo.teamList[arg_39_1].servantid = arg_39_2
	end

	if type(arg_39_3) == "function" then
		arg_39_3(1)
	end
end

function ExpeditionManager:set_expedition_servant(arg_40_1)
	return
end

function ExpeditionManager:set_expedition_skill(arg_41_1, arg_41_2)
	if arg_41_1 == nil then
		global_ShowBlockWords("skillid 为空!!!")

		return
	end

	network:rpc("set_expedition_skill", {
		type = self.expeditionInfo.inittype,
		skillid = arg_41_1
	}, function(arg_42_0)
		if arg_42_0.result == 1 then
			self.expeditionInfo.skillList = self:getSkillList(arg_42_0.skilllist)

			self:clearLastSkillList()
		elseif arg_42_0.result == 3 then
			print("已经有一个同样的技能啦")
		elseif arg_42_0.result == 4 then
			print("skillid 不合法，检查下服务端的表传了没")
		end

		if arg_41_2 then
			arg_41_2()
		end
	end)
end

function ExpeditionManager:getCurMode()
	return self.expeditionInfo.initmode
end

function ExpeditionManager:isServantSelectReady()
	local var_44_0 = true

	for iter_44_0, iter_44_1 in pairs(self.expeditionInfo.teamList) do
		if iter_44_1.servantid == nil then
			var_44_0 = false

			break
		end
	end

	return var_44_0
end

function ExpeditionManager:getExpeditionSkillListInfo()
	return self.expeditionInfo.skillList
end

function ExpeditionManager:isHaveSkillSelected()
	return #self.expeditionInfo.skillList > 0
end

function ExpeditionManager.updateCurLevelViewPanel()
	return
end

function ExpeditionManager:isNeedAutoPlay()
	return self.expeditionInfo.curChapter == 1 and self.expeditionInfo.curLevel == 0 or false
end

function ExpeditionManager:setSelectInfo(arg_49_1, arg_49_2)
	RoleDefault:getInstance():setStringForKey("ExpeditionSelectInfo" .. self.expeditionInfo.initmode, arg_49_1 .. "," .. arg_49_2)
end

function ExpeditionManager:getSelectInfo()
	local var_50_0 = RoleDefault:getInstance()

	return tonumber(var_50_0[1]), tonumber(string.split(var_50_0:getStringForKey("ExpeditionSelectInfo" .. self.expeditionInfo.initmode), ",")[2])
end

function ExpeditionManager:isNeedCostCoin()
	local var_51_0 = false
	local var_51_1, var_51_2 = self:getSelectInfo()

	if var_51_1 ~= nil and var_51_2 ~= nil then
		if self.expeditionInfo.stepList[var_51_1].roomList[var_51_2].roomType == ExpeditionRoomType.Normal or self.expeditionInfo.stepList[var_51_1].roomList[var_51_2].roomType == ExpeditionRoomType.Elite or self.expeditionInfo.stepList[var_51_1].roomList[var_51_2].roomType == ExpeditionRoomType.Boss or self.expeditionInfo.stepList[var_51_1].roomList[var_51_2].roomType == ExpeditionRoomType.TowerDefenceNormal or self.expeditionInfo.stepList[var_51_1].roomList[var_51_2].roomType == ExpeditionRoomType.TowerDefenceElite or self.expeditionInfo.stepList[var_51_1].roomList[var_51_2].roomType == ExpeditionRoomType.TowerDefenceBoss then
			var_51_0 = true
		end
	end

	local var_51_3 = false

	if self.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Monopoly or self.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Expedition and var_51_0 == true then
		if next(self.expeditionInfo.coinlist) ~= nil then
			var_51_3 = true
		end
	else
		var_51_3 = false
	end

	return var_51_3
end

function ExpeditionManager:isHaveEnoughCoinNum()
	local var_52_0 = false

	if next(self.expeditionInfo.coinlist) ~= nil then
		for iter_52_0, iter_52_1 in pairs(self.expeditionInfo.coinlist) do
			if iter_52_1.isSelected == true and iter_52_1.num > 0 then
				var_52_0 = true

				break
			end
		end
	end

	return var_52_0
end

function ExpeditionManager:costCoinNum()
	if next(self.expeditionInfo.coinlist) ~= nil then
		for iter_53_0, iter_53_1 in pairs(self.expeditionInfo.coinlist) do
			if iter_53_1.isSelected == true and iter_53_1.num > 0 then
				iter_53_1.num = iter_53_1.num - 1

				item_manager:deleteItem(iter_53_1.id, 1)

				break
			end
		end
	end
end

function ExpeditionManager:select_level_expedition(arg_54_1, arg_54_2)
	local var_54_0 = arg_54_1.roomindex
	local var_54_1 = arg_54_1.tips or "需要货币不足"
	local var_54_2 = self:isNeedCostCoin()

	if self:getCurLevelStatus() == var_0_31.Free then
		if var_54_2 == true and self:isHaveEnoughCoinNum() == false and self:isNeedAutoPlay() == false then
			global_ShowBlockWords(var_54_1)

			return
		elseif var_54_2 == true and self:isHaveEnoughCoinNum() and self:isNeedAutoPlay() == false then
			self:costCoinNum()
		end

		local var_54_3 = self:getCoinList(true)

		assert(var_54_3, "needCoinInfo is nil")
		network:rpc("select_level_expedition", {
			type = self.expeditionInfo.inittype,
			curselectlevel = arg_54_1.roomindex,
			coinid = var_54_3.id
		}, function(arg_55_0)
			if arg_55_0.result == 1 then
				self.expeditionInfo.monsterpower = arg_55_0.monsterpower

				hx_print("monsterPower:" .. dump(self.expeditionInfo.monsterpower), CONSOLE_COLOR_GREEN)
				self:setCurSelectLevelIndex(var_54_0, arg_55_0.stepnum)
				self:setCurLevelStatus(arg_55_0.levelstatus)

				local var_55_0 = self.expeditionInfo.stepList[self:getCurLevelIndex() + 1].roomList

				for iter_55_0 = 1, #var_55_0 do
					if iter_55_0 == var_54_0 then
						var_55_0[iter_55_0].isCanOperate = true
						var_55_0[iter_55_0].roomStatus = var_0_32.CanOperate
					else
						var_55_0[iter_55_0].isCanOperate = false
						var_55_0[iter_55_0].roomStatus = var_0_32.HaveMiss
					end
				end

				self.updateCurLevelViewPanel()

				if arg_54_2 then
					arg_54_2(arg_55_0.stepnum)
				end
			elseif arg_55_0.result == 2 then
				global_ShowBlockWords("模式不合法")
			elseif arg_55_0.result == 3 then
				global_ShowBlockWords("选择的房间索引不合法")
			elseif arg_55_0.result == 5 then
				global_ShowBlockWords("已经通关")
			elseif arg_55_0.result == 6 and arg_54_2 then
				arg_54_2(arg_55_0)
			end
		end)
	else
		global_ShowBlockWords("当前类型不对，不能选关")
	end
end

function ExpeditionManager:getCurRoomIndex()
	local var_56_0

	if self.expeditionInfo.stepList then
		if self.expeditionInfo.stepList[self.expeditionInfo.curLevel + 1] and self.expeditionInfo.curSelectLevel then
			for iter_56_0 = 1, #self.expeditionInfo.stepList[self.expeditionInfo.curLevel + 1].roomList do
				if iter_56_0 == math.abs(self.expeditionInfo.curSelectLevel) then
					var_56_0 = self.expeditionInfo.stepList[self.expeditionInfo.curLevel + 1].roomList[iter_56_0].roomIndex

					break
				end
			end
		end
	else
		var_56_0 = 1
	end

	return var_56_0
end

function ExpeditionManager:getRoomIndex(arg_57_1, arg_57_2)
	local var_57_0

	if self.expeditionInfo.stepList[arg_57_1] then
		for iter_57_0 = 1, #self.expeditionInfo.stepList[arg_57_1].roomList do
			if iter_57_0 == arg_57_2 then
				var_57_0 = self.expeditionInfo.stepList[arg_57_1].roomList[iter_57_0].roomIndex

				break
			end
		end
	end

	return var_57_0
end

function ExpeditionManager:dealWithDropData(arg_58_1)
	local var_58_0 = {}

	if arg_58_1.gold and arg_58_1.gold > 0 then
		playermodel.gold = playermodel.gold + arg_58_1.gold

		table.insert(var_58_0, {
			entityid = "gold",
			dropNum = arg_58_1.gold
		})
	end

	if arg_58_1.items then
		for iter_58_0, iter_58_1 in pairs(arg_58_1.items) do
			dropcache_manager:insertItemCache(iter_58_1)
		end
	end

	if arg_58_1.gainitems then
		for iter_58_2, iter_58_3 in pairs(arg_58_1.gainitems) do
			local var_58_2 = {}
			local var_58_3 = item_manager:setItemByServerItem(iter_58_3)

			var_58_2.entityid = iter_58_3.entityid
			var_58_2.dropNum = var_58_3
			var_58_2.number = var_58_3

			if var_58_3 > 0 then
				table.insert(var_58_0, var_58_2)
			end

			if item_data[iter_58_3.itemid].bag_item_type == kITEM_HERO or item_data[iter_58_3.itemid].bag_item_type == kITEM_SKIN then
				require("view.Layer.GetRoleAnimationLayer")

				local var_58_4 = GetRoleAnimationLayer:create(iter_58_3.itemid)

				if not var_58_4:getParent() then
					global_basic_scene:addChild(var_58_4, 999)
				end
			end
		end
	end

	if arg_58_1.sp then
		playermodel.strengthpoint = playermodel.strengthpoint + arg_58_1.sp

		global_update_strengthpoint(true)
		AlertManager:check_servant_strenghth(true)
	end

	if arg_58_1.honor and arg_58_1.honor > 0 then
		playermodel.honor = playermodel.honor + arg_58_1.honor
	end

	if arg_58_1.diamond then
		playermodel.diamond = playermodel.diamond + arg_58_1.diamond

		global_update_gold_stone_diamond(nil, nil, arg_58_1.diamond)
	end

	return {
		gold = arg_58_1.gold,
		diamond = arg_58_1.diamond,
		honor = arg_58_1.honor,
		score = arg_58_1.score,
		items = var_58_0
	}
end

function ExpeditionManager:do_battle_result_expedition(arg_59_1, arg_59_2)
	local var_59_0 = cloneconf(self.expeditionInfo.teamList)
	local var_59_1 = cloneconf(self.expeditionInfo.enemyList)

	for iter_59_0, iter_59_1 in pairs(var_59_0) do
		iter_59_1.bloodpercent = tostring(iter_59_1.bloodpercent)
		iter_59_1.energypercent = tostring(iter_59_1.energypercent)
	end

	for iter_59_2, iter_59_3 in pairs(var_59_1) do
		iter_59_3.bloodpercent = tostring(iter_59_3.bloodpercent)
		iter_59_3.energypercent = tostring(iter_59_3.energypercent)
	end

	network:rpc("do_battle_result_expedition", {
		type = self.expeditionInfo.inittype,
		curchapter = self.expeditionInfo.curChapter,
		curlevel = self.expeditionInfo.curLevel,
		battleresult = arg_59_1,
		battleteamlist = var_59_0,
		battleenemylist = var_59_1
	}, function(arg_60_0)
		if arg_60_0.result == 1 then
			self:setCurLevelStatus(arg_60_0.levelstatus)

			if type(arg_59_2) == "function" then
				arg_59_2((self:dealWithDropData(arg_60_0.drop)))
			end
		elseif arg_60_0.result == 2 then
			global_ShowBlockWords("模式不合法")
		elseif arg_60_0.result == 3 then
			global_ShowBlockWords("关卡不合法")
		elseif arg_60_0.result == 4 then
			global_ShowBlockWords("战斗结果不合法")
		elseif arg_60_0.result == 5 then
			global_ShowBlockWords("战斗编队不合法")
		end
	end)
end

function ExpeditionManager:do_level_result_expedition(arg_61_1)
	network:rpc("do_level_result_expedition", {
		type = self.expeditionInfo.inittype,
		curchapter = self.expeditionInfo.curChapter,
		curlevel = self.expeditionInfo.curLevel
	}, function(arg_62_0)
		if arg_62_0.result == 1 then
			(function()
				if curlevel == #self.expeditionInfo.stepList - 1 then
					if curchapter == 1 then
						AnalyticManager.expedition_first_1_chapter()
					elseif curchapter == 2 then
						local var_63_0 = RoleDefault:getInstance():getIntegerForKey("ExpeditionResultChapter2-" .. self.expeditionInfo.initmode, 0)

						if var_63_0 < 1 then
							AnalyticManager.expedition_first_2_chapter()
							RoleDefault:getInstance():setIntegerForKey("ExpeditionResultChapter2-" .. self.expeditionInfo.initmode, 1)
						elseif var_63_0 < 2 then
							AnalyticManager.expedition_twice_2_chapter()
							RoleDefault:getInstance():setIntegerForKey("ExpeditionResultChapter2-" .. self.expeditionInfo.initmode, 2)
						end
					elseif curchapter == 3 then
						local var_63_1 = RoleDefault:getInstance():getIntegerForKey("ExpeditionResultChapter3-" .. self.expeditionInfo.initmode, 0)

						if var_63_1 < 1 then
							AnalyticManager.expedition_first_3_chapter()
							RoleDefault:getInstance():setIntegerForKey("ExpeditionResultChapter3-" .. self.expeditionInfo.initmode, 1)
						elseif var_63_1 < 2 then
							AnalyticManager.expedition_twice_3_chapter()
							RoleDefault:getInstance():setIntegerForKey("ExpeditionResultChapter3-" .. self.expeditionInfo.initmode, 2)
						end

						local var_63_2 = self.expeditionInfo.teamList

						if #self.expeditionInfo.teamList > 8 then
							AnalyticManager.expedition_3_chapter_student_more_8()
						elseif #var_63_2 <= 4 then
							AnalyticManager.expedition_3_chapter_student_less_4()
						end
					end
				end
			end)()
			self:setCurLevelStatus(arg_62_0.levelstatus)
			self:setFightEventId(nil)
			self:setCurEventInfo("")

			if type(arg_61_1) == "function" then
				arg_61_1(arg_62_0.levelstatus)
			end
		elseif arg_62_0.result == 2 then
			global_ShowBlockWords("模式不合法")
		elseif arg_62_0.result == 3 then
			global_ShowBlockWords("关卡不合法")
		elseif arg_62_0.result == 4 then
			global_ShowBlockWords("战斗结果不合法")
		elseif arg_62_0.result == 5 then
			global_ShowBlockWords("战斗编队不合法")
		end
	end)
end

function ExpeditionManager:getGenerateEnemyList()
	local var_64_0 = {}

	for iter_64_0, iter_64_1 in pairs((monster_manager.initBossList(chapter_data[self.expeditionInfo.initmode .. "-" .. self:getCurRoomIndex()].bigboss))) do
		for iter_64_2, iter_64_3 in pairs(self.expeditionInfo.enemyList) do
			if iter_64_1.id == iter_64_3.monsterid and iter_64_3.bloodpercent > 0 then
				iter_64_1.bloodpercent = iter_64_3.bloodpercent
				iter_64_1.energypercent = iter_64_3.energypercent

				if iter_64_0 == "boss" then
					var_64_0[iter_64_0] = iter_64_1

					break
				end

				table.insert(var_64_0, iter_64_1)

				break
			end
		end
	end

	return var_64_0
end

function ExpeditionManager:getAllLevelEnemys(arg_65_1, arg_65_2)
	local var_65_0 = {}
	local var_65_1 = {}
	local var_65_2 = level_manager.getCurMonsterTeamData(arg_65_1, chapter_data[arg_65_1 .. "-" .. arg_65_2].bigboss)

	if chapter_data[arg_65_1 .. "-" .. arg_65_2].level_type == ExpeditionRoomType.TowerDefenceNormal or chapter_data[arg_65_1 .. "-" .. arg_65_2].level_type == ExpeditionRoomType.TowerDefenceElite or chapter_data[arg_65_1 .. "-" .. arg_65_2].level_type == ExpeditionRoomType.TowerDefenceBoss then
		local var_65_3 = 1

		while var_65_2["subteam" .. var_65_3] do
			local var_65_4 = level_manager.getCurMonsterTeamData(arg_65_1, var_65_2["subteam" .. var_65_3])

			while var_65_4["monster" .. 1] do
				table.insert(var_65_0, level_manager.monsterData[arg_65_1][var_65_4["monster" .. 1]].modelid)
			end

			var_65_3 = var_65_3 + 1
		end
	else
		local var_65_6 = 1

		while var_65_2["monster" .. var_65_6] do
			table.insert(var_65_0, level_manager.monsterData[arg_65_1][var_65_2["monster" .. var_65_6]].modelid)

			var_65_6 = var_65_6 + 1
		end

		if var_65_2.boss then
			table.insert(var_65_0, level_manager.monsterData[arg_65_1][var_65_2.boss].modelid)
		end

		for iter_65_0, iter_65_1 in pairs(var_65_0) do
			var_65_1[iter_65_1] = true
		end
	end

	return var_65_0, var_65_1
end

function ExpeditionManager:sortRoleListTbl(arg_66_1)
	local var_66_0 = {}

	print(dump(arg_66_1))

	for iter_66_0, iter_66_1 in ipairs(arg_66_1) do
		if role_false_level_manager:isRoleFalseLevelMember(iter_66_1, FightManager.getFightType()) then
			local var_66_1, var_66_2, var_66_3, var_66_4 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(iter_66_1)

			var_66_0[iter_66_1] = var_66_2 + var_66_4
		end
	end

	table.sort(arg_66_1, function(arg_67_0, arg_67_1)
		return (var_66_0[arg_67_1] or core_manager:getCoreLv(arg_67_1)) < (var_66_0[arg_67_0] or core_manager:getCoreLv(arg_67_0))
	end)

	return arg_66_1
end

function ExpeditionManager:getRandomFightingModelid()
	local var_68_0 = {}

	for iter_68_0 in RoleDefault:getInstance():getStringForKey("Expedition" .. self.expeditionInfo.inittype, ""):gmatch("([^,]+)") do
		table.insert(var_68_0, (tonumber(iter_68_0)))
	end

	return global_get_servant_skin(var_68_0[math.random(#var_68_0)]) or "22120"
end

function ExpeditionManager:saveRoleList(arg_69_1)
	local var_69_0 = ""

	for iter_69_0, iter_69_1 in pairs(arg_69_1) do
		var_69_0 = var_69_0 .. iter_69_1 .. ","
	end

	RoleDefault:getInstance():setStringForKey("Expedition" .. self.expeditionInfo.inittype, var_69_0)
end

function ExpeditionManager:isServantCanSelect(arg_70_1)
	for iter_70_0, iter_70_1 in pairs(self.expeditionInfo.teamList) do
		if arg_70_1 == iter_70_1.servantid and iter_70_1.bloodpercent == 0 then
			return false
		end
	end

	return true
end

function ExpeditionManager:updateTeamList(arg_71_1)
	if arg_71_1 == nil then
		return
	end

	local var_71_0 = {}

	for iter_71_0, iter_71_1 in pairs(self.expeditionInfo.teamList) do
		var_71_0[iter_71_1.servantid] = iter_71_0
	end

	for iter_71_2, iter_71_3 in pairs(arg_71_1) do
		if var_71_0[iter_71_3.servantid] then
			self.expeditionInfo.teamList[var_71_0[iter_71_3.servantid]].bloodpercent = iter_71_3.bloodpercent
			self.expeditionInfo.teamList[var_71_0[iter_71_3.servantid]].energypercent = iter_71_3.energypercent
		else
			table.insert(self.expeditionInfo.teamList, {
				id = #self.expeditionInfo.teamList + 1,
				servantid = iter_71_3.servantid,
				bloodpercent = iter_71_3.bloodpercent,
				energypercent = iter_71_3.energypercent
			})
		end
	end
end

function ExpeditionManager:updateEnemyList(arg_72_1)
	if arg_72_1 == nil or next(arg_72_1) == nil then
		return
	end

	for iter_72_0, iter_72_1 in pairs(arg_72_1) do
		for iter_72_2, iter_72_3 in pairs(self.expeditionInfo.enemyList) do
			if iter_72_1.monsterid == iter_72_3.monsterid then
				iter_72_3.bloodpercent = iter_72_1.bloodpercent or iter_72_3.bloodpercent
				iter_72_3.energypercent = iter_72_1.energypercent or iter_72_3.energypercent

				break
			end
		end
	end
end

function ExpeditionManager:fightResult(arg_73_1, arg_73_2)
	local var_73_0 = self:getCurLevelIndex()
	local var_73_1 = var_73_0 + 1
	local var_73_2 = self:getCurSelectLevelIndex()

	if arg_73_1.battleresult == 1 then
		AnalyticManager.expedition_battle_success({
			curlevel = var_73_0,
			curselectlevel = var_73_2,
			playerlevel = playermodel.grade,
			studentnum = #self.expeditionInfo.teamList,
			studentdienum = self:getStudentDieNum(),
			skillnum = #self.expeditionInfo.skillList
		})
	else
		AnalyticManager.expedition_battle_fail({
			curlevel = var_73_0,
			curselectlevel = var_73_2,
			playerlevel = playermodel.grade,
			studentnum = #self.expeditionInfo.teamList,
			studentdienum = self:getStudentDieNum(),
			skillnum = #self.expeditionInfo.skillList
		})
	end

	local var_73_3 = self.expeditionInfo.stepList[var_73_1].roomList[var_73_2].roomType

	if self.expeditionInfo.stepList[var_73_1].roomList[var_73_2].roomType == ExpeditionRoomType.TowerDefenceNormal or var_73_3 == ExpeditionRoomType.TowerDefenceElite or var_73_3 == ExpeditionRoomType.TowerDefenceBoss then
		self:resetExpeditionTowerFight()
	end

	self:do_battle_result_expedition(arg_73_1.battleresult, function(arg_74_0)
		if arg_73_2 then
			arg_73_2(arg_73_1.battleresult, arg_74_0)
		end
	end)
end

function ExpeditionManager:setCurSelectDiceIndex(arg_75_1)
	var_0_27 = arg_75_1
end

function ExpeditionManager:isTeamListCanBattle()
	local var_76_0 = {}

	for iter_76_0, iter_76_1 in pairs(self.expeditionInfo.teamList) do
		var_76_0[iter_76_1.servantid] = {
			servantid = iter_76_1.servantid,
			bloodpercent = iter_76_1.bloodpercent,
			energypercent = iter_76_1.energypercent
		}
	end

	for iter_76_2, iter_76_3 in pairs((self:getOwnServant())) do
		if not var_76_0[iter_76_3] or var_76_0[iter_76_3].bloodpercent ~= "0" then
			return true
		end
	end

	return false
end

function ExpeditionManager:getCurStatus()
	return self.expeditionInfo.curStatus
end

function ExpeditionManager:isTeamListNeedSelect()
	return true
end

function ExpeditionManager:selectBattleCallback(arg_79_1)
	self:setFightEventId({
		levelindex = arg_79_1.levelindex,
		roomindex = arg_79_1.roomindex,
		eventClassificationList = arg_79_1.eventClassificationList
	})

	if self:isTeamListCanBattle() then
		self.expeditionInfo.enemyList = self:initEnemyList(nil, nil, self.expeditionInfo.enemylist)

		if self:isTeamListNeedSelect() then
			LayerManager:switchShowLayer("ExpeditionSelectLayer", {
				mode = self.expeditionInfo.initmode,
				chapter = self.expeditionInfo.curChapter,
				level = self:getRoomIndex(arg_79_1.levelindex, arg_79_1.roomindex),
				sureCallback = function(arg_80_0)
					self.expeditionInfo.initFightRoleList = arg_80_0

					RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", self.expeditionInfo.inittype)

					if self.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Monopoly then
						FightManager.refreshFightToType(FIGHTTYPE_EXPEDITION_MONOPOLY)
					elseif arg_79_1.roomType == ExpeditionRoomType.TowerDefenceNormal or arg_79_1.roomType == ExpeditionRoomType.TowerDefenceElite or arg_79_1.roomType == ExpeditionRoomType.TowerDefenceBoss then
						FightManager.refreshFightToType(FIGHTTYPE_EXPEDITION_TOWER)
					else
						FightManager.refreshFightToType(FIGHTTYPE_EXPEDITION)
					end

					LayerManager:switchShowLayer("FightLayer", {
						is_hide_topcost = true,
						is_hide_listbutton = true
					})
				end,
				roomType = arg_79_1.roomType,
				seasontype = self.expeditionInfo.seasontype
			})
		else
			if self.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Monopoly then
				self:switchExpeditionToLimiteTimeMode()
			end

			local var_79_0

			do
				self:switchExpeditionTower(arg_79_1.roomType)

				var_79_0 = {}
			end

			for iter_79_0, iter_79_1 in pairs(self.expeditionInfo.teamList) do
				if iter_79_1.servantid and iter_79_1.bloodpercent > 0 then
					table.insert(var_79_0, iter_79_1.servantid)
				end
			end

			self:saveRoleList(var_79_0)
		end
	else
		global_ShowBlockWords("已没有可参战的学员，请重置")
	end
end

function ExpeditionManager:setCurEventInfo(arg_81_1)
	RoleDefault:getInstance():setStringForKey("ExpeditionCurEventInfo-" .. self.expeditionInfo.inittype, arg_81_1)
end

function ExpeditionManager:getCurEventInfo()
	return (RoleDefault:getInstance():getStringForKey("ExpeditionCurEventInfo-" .. self.expeditionInfo.inittype, ""))
end

function ExpeditionManager:selectEventCallback(arg_83_1)
	local var_83_0 = self:getCurEventInfo()

	if self.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Monopoly and self.expeditionInfo.isBackToOrigin == true and self.expeditionInfo.curLevel == 0 then
		arg_83_1.eventClassificationList = {
			{
				eventid = 9107
			}
		}
	end

	local var_83_1 = var_83_0 == "" and arg_83_1.eventClassificationList[1].classification or tonumber(string.split(var_83_0, ",")[1])

	if var_83_1 == nil or var_83_1 == 0 then
		local var_83_2 = arg_83_1.eventClassificationList[1].eventid

		self:setCurEventInfo("0" .. "," .. arg_83_1.eventClassificationList[1].eventid)

		local var_83_3 = self:initTriggerEventInfo(var_83_2, function(arg_84_0)
			if type(arg_83_1.callback) == "function" then
				arg_83_1.callback(arg_84_0)
			end
		end)
	else
		local function var_83_4(arg_85_0)
			local var_85_0

			for iter_85_0, iter_85_1 in pairs(arg_83_1.eventClassificationList) do
				if iter_85_1.classification == arg_85_0 then
					var_85_0 = iter_85_1.eventid

					break
				end
			end

			self:setCurEventInfo(arg_85_0 .. "," .. var_85_0)

			local var_85_1 = self:initTriggerEventInfo(var_85_0, function(arg_86_0)
				if type(arg_83_1.callback) == "function" then
					arg_83_1.callback(arg_86_0)
				end
			end)
		end

		if self.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Monopoly and self:isHavePlayTalk(var_83_1) == true then
			var_83_4(var_83_1)
		else
			self:setTalkToList(var_83_1)
			require("view.Layer.TalkLayer")
			global_basic_scene:addChild(TalkLayer:create(var_83_1, nil, TALK_TYPE_NORMAL, nil, function(arg_87_0)
				var_83_4(arg_87_0)
			end), 5)
		end
	end
end

function ExpeditionManager:initPlayTalkList()
	self.expeditionInfo.talkList = {}

	local var_88_0 = {}

	for iter_88_0, iter_88_1 in pairs((string_split(RoleDefault:getInstance():getStringForKey("expedition_" .. self.expeditionInfo.inittype .. "_talklist", ""), "="))) do
		var_88_0[iter_88_1] = true
	end

	self.expeditionInfo.talkList = var_88_0
end

function ExpeditionManager:setTalkToList(arg_89_1)
	self.expeditionInfo.talkList[arg_89_1] = true

	local var_89_0 = ""

	for iter_89_0, iter_89_1 in pairs(self.expeditionInfo.talkList) do
		var_89_0 = var_89_0 .. iter_89_0 .. "="
	end

	RoleDefault:getInstance():setStringForKey("expedition_" .. self.expeditionInfo.inittype .. "_talklist", var_89_0)
end

function ExpeditionManager:isHavePlayTalk(arg_90_1)
	if self.expeditionInfo.talkList[tostring(arg_90_1)] then
		return true
	else
		return false
	end
end

function ExpeditionManager:isShowLine(arg_91_1)
	local var_91_0 = false
	local var_91_1 = false

	if self.expeditionInfo.needChapterData[arg_91_1].next_level1 ~= nil then
		if self.expeditionInfo.needChapterData[self.expeditionInfo.needChapterData[arg_91_1].next_level1] and self.expeditionInfo.needChapterData[self.expeditionInfo.needChapterData[arg_91_1].next_level1].level_type ~= ExpeditionRoomType.Transmit then
			var_91_0 = true
		end
	end

	if self.expeditionInfo.needChapterData[arg_91_1].next_level2 ~= nil then
		if self.expeditionInfo.needChapterData[self.expeditionInfo.needChapterData[arg_91_1].next_level2] and self.expeditionInfo.needChapterData[self.expeditionInfo.needChapterData[arg_91_1].next_level2].level_type ~= ExpeditionRoomType.Transmit then
			var_91_1 = true
		end
	end

	return var_91_0, var_91_1
end

function ExpeditionManager:isShowLineLight(arg_92_1, arg_92_2, arg_92_3)
	local var_92_0 = false
	local var_92_1 = self.expeditionInfo.stepList[arg_92_1].roomList[arg_92_2]
	local var_92_3 = arg_92_3 == 1 and var_92_1.next_level1 or var_92_1.next_level2

	if var_92_3 == nil then
		var_92_0 = false
	else
		local var_92_4 = self.expeditionInfo.stepList[self.expeditionInfo.needChapterData[var_92_3].level_index].roomList

		for iter_92_0 = 1, #self.expeditionInfo.stepList[self.expeditionInfo.needChapterData[var_92_3].level_index].roomList do
			if var_92_4[iter_92_0].roomIndex == var_92_3 then
				if var_92_4[iter_92_0].roomStatus == var_0_32.HaveGot and var_92_1.roomStatus == var_0_32.HaveGot then
					var_92_0 = true
				end

				break
			end
		end
	end

	return var_92_0
end

function ExpeditionManager:getArray()
	local var_93_0 = {}

	for iter_93_0, iter_93_1 in pairs(self.expeditionInfo.teamList) do
		if iter_93_1.bloodpercent > 0 then
			table.insert(var_93_0, {
				fight_girl = iter_93_1.servantid
			})
		end
	end

	return var_93_0
end

function ExpeditionManager:getExpeditionConfig(arg_95_1)
	local var_95_0 = {
		skillList = {}
	}
	local var_95_1 = {}
	local var_95_2

	var_95_2 = arg_95_1 == "player" and self.expeditionInfo.skillList or (arg_95_1 ~= "enemy" or true) and var_95_2

	for iter_95_0 = 1, (var_95_2 or nil) and (#var_95_2 or 0) do
		table.insert(var_95_1, var_95_2[iter_95_0].skillid)
	end

	var_95_0.skillList = var_95_1

	return var_95_0
end

function ExpeditionManager:clearTeamListSelectStatus()
	for iter_96_0, iter_96_1 in pairs(self.expeditionInfo.teamList) do
		if iter_96_1.isNeedSelect == true then
			iter_96_1.isNeedSelect = false
		end
	end
end

function ExpeditionManager:clearSkillListSelectStatus()
	for iter_97_0, iter_97_1 in pairs(self.expeditionInfo.skillList) do
		if iter_97_1.isNeedSelect == true then
			iter_97_1.isNeedSelect = false
		end
	end
end

function ExpeditionManager:updateCurPassInfo(arg_98_1)
	if self.expeditionInfo.curPassInfo[arg_98_1] and self.expeditionInfo.curPassInfo[arg_98_1] < 0 then
		self.expeditionInfo.curPassInfo[arg_98_1] = math.abs(self.expeditionInfo.curPassInfo[arg_98_1])
		self.expeditionInfo.curSelectLevel = self:getCurSelectLevelIndex()
	end
end

function ExpeditionManager:getCurLevelStatus()
	return self.expeditionInfo.curEventInfo
end

function ExpeditionManager:setCurLevelStatus(arg_100_1)
	self.expeditionInfo.curEventInfo = arg_100_1
end

function ExpeditionManager:useItemEffect(arg_101_1)
	if arg_101_1 == nil then
		return
	end

	local var_101_0 = self.expeditionInfo.teamList

	assert(expedition_shop_data[arg_101_1.id], string.format("curExpeditionShopData is nil,itemid is %d", arg_101_1.id))

	if arg_101_1.type == EXPEDITION.SHOP_ITEMTYPE.SKILL then
		table.insert(self.expeditionInfo.skillList, {
			id = #self.expeditionInfo.skillList + 1,
			skillid = expedition_shop_data[arg_101_1.id].skill_id
		})
	elseif arg_101_1.type == EXPEDITION.SHOP_ITEMTYPE.REBORN then
		for iter_101_0, iter_101_1 in pairs(var_101_0) do
			iter_101_1.zdlNum = fight_capacity_manager:getSoulFightCapacity(iter_101_1.servantid, "number")
		end

		table.sort(var_101_0, function(arg_102_0, arg_102_1)
			return arg_102_0.zdlNum > arg_102_1.zdlNum
		end)

		for iter_101_2, iter_101_3 in pairs(var_101_0) do
			if iter_101_3.bloodpercent == 0 then
				iter_101_3.bloodpercent = 100

				if expedition_shop_data[arg_101_1.id].is_fuHuo <= 1 then
					break
				else
					-- block empty
				end
			end
		end
	end
end

function ExpeditionManager:initTriggerEventInfo(arg_103_1, arg_103_2)
	local var_103_0 = {}

	while expedition_event_basic_data[arg_103_1]["event_type_" .. 1] do
		table.insert(var_103_0, {
			id = #var_103_0 + 1,
			eventtype = expedition_event_basic_data[arg_103_1]["event_type_" .. 1],
			eventvalue = expedition_event_basic_data[arg_103_1]["event_reward_" .. 1]
		})
	end

	self.expeditionInfo.teamList = self:initTeamList(cloneconf(self.expeditionInfo.originTeamList))
	self.expeditionInfo.skillList = self:getSkillList(cloneconf(self.expeditionInfo.originSkillList))

	for iter_103_0, iter_103_1 in pairs(var_103_0) do
		if iter_103_1.eventtype == var_0_34.Blood then
			for iter_103_2, iter_103_3 in pairs(self.expeditionInfo.teamList) do
				if iter_103_3.bloodpercent and iter_103_3.bloodpercent ~= 0 then
					iter_103_3.bloodpercent = math.max(0, (math.min(100, iter_103_3.bloodpercent + tonumber(iter_103_1.eventvalue))))
				end
			end
		elseif iter_103_1.eventtype == var_0_34.Reborn then
			for iter_103_4, iter_103_5 in pairs(self.expeditionInfo.teamList) do
				iter_103_5.zdlNum = fight_capacity_manager:getSoulFightCapacity(iter_103_5.servantid, "number")
			end

			table.sort(self.expeditionInfo.teamList, function(arg_104_0, arg_104_1)
				return arg_104_0.zdlNum > arg_104_1.zdlNum
			end)

			for iter_103_6, iter_103_7 in pairs(self.expeditionInfo.teamList) do
				if iter_103_7.bloodpercent == 0 then
					iter_103_7.bloodpercent = 100

					break
				end
			end
		elseif iter_103_1.eventtype == var_0_34.Recruit then
			local var_103_2 = string.split(iter_103_1.eventvalue, "&")

			table.insert(self.expeditionInfo.teamList, {
				isNeedSelect = true,
				id = #self.expeditionInfo.teamList + 1,
				rare = (var_103_2[1] ~= "0" or nil) and var_103_2[1],
				career = (var_103_2[2] ~= "0" or nil) and var_103_2[2]
			})
		elseif iter_103_1.eventtype == var_0_34.Skill then
			table.insert(self.expeditionInfo.skillList, {
				isNeedSelect = true,
				id = #self.expeditionInfo.skillList + 1
			})
		end
	end

	if type(arg_103_2) == "function" then
		arg_103_2(var_103_0)
	end
end

function ExpeditionManager:trigger_event_expedition(arg_105_1, arg_105_2)
	local var_105_0 = cloneconf(self.expeditionInfo.teamList)

	for iter_105_0, iter_105_1 in pairs(var_105_0) do
		iter_105_1.bloodpercent = tostring(iter_105_1.bloodpercent)
		iter_105_1.energypercent = tostring(iter_105_1.energypercent)
	end

	if self:getCurLevelStatus() == var_0_31.NeedEvent then
		network:rpc("trigger_event_expedition", {
			type = self.expeditionInfo.inittype,
			curchapter = self.expeditionInfo.curChapter,
			curlevel = self.expeditionInfo.curLevel,
			eventid = tonumber(string.split(self:getCurEventInfo(), ",")[2]),
			teamlist = var_105_0,
			skilllist = self.expeditionInfo.skillList
		}, function(arg_106_0)
			if arg_106_0.result == 1 then
				self:setCurLevelStatus(arg_106_0.levelstatus)

				local var_106_0 = self:dealWithDropData(arg_106_0.drop)

				if var_106_0.items and #var_106_0.items > 0 then
					LayerManager:pushInLayer("PopPurchaseResultLayer", {
						items = var_106_0.items
					})
				end

				if arg_106_0.clearlevelindex ~= nil then
					self:setClearLevelIndex(arg_106_0.clearlevelindex)
				end

				if type(arg_105_2) == "function" then
					arg_105_2()
				end
			elseif arg_106_0.result == 2 then
				global_ShowBlockWords("模式不合法")
			elseif arg_106_0.result == 3 then
				global_ShowBlockWords("触发事件不合法")
			elseif arg_106_0.result == 4 then
				global_ShowBlockWords("重复触发")
			end
		end)
	end
end

function ExpeditionManager:setClearLevelIndex(arg_107_1)
	self.levelIndex = arg_107_1
end

function ExpeditionManager:getClearLevelIndex()
	return self.levelIndex
end

function ExpeditionManager:getStudentDieNum()
	local var_109_0 = 0

	for iter_109_0 = 1, #self.expeditionInfo.teamList do
		if self.expeditionInfo.teamList[iter_109_0].bloodpercent and self.expeditionInfo.teamList[iter_109_0].bloodpercent <= 0 then
			var_109_0 = var_109_0 + 1
		end
	end

	return var_109_0
end

function ExpeditionManager:reset_expedition(arg_110_1)
	self:setFightEventId(nil)
	self:setCurEventInfo("")
	AnalyticManager.click_expedition_reset({
		curlevel = self:getCurLevelIndex(),
		curselectlevel = self:getCurSelectLevelIndex(),
		studentnum = #self.expeditionInfo.teamList,
		studentdienum = self:getStudentDieNum(),
		skillnum = #self.expeditionInfo.skillList
	})
	network:rpc("reset_expedition", {
		type = self.expeditionInfo.inittype
	}, function(arg_111_0)
		if arg_111_0.result == 1 then
			self:saveRoleList({})

			if type(arg_110_1) == "function" then
				arg_110_1()
			end
		end
	end)
end

local function var_0_38(arg_112_0)
	if not arg_112_0 then
		return
	end

	if arg_112_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_112_0 / 86400), math.floor(arg_112_0 % 86400 / 3600))
	elseif arg_112_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_112_0 / 3600), math.floor(arg_112_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_112_0 / 60))
	end
end

function ExpeditionManager:getLeftTimeStr()
	local var_113_1 = time_check_manager:getCurTime()
	local var_113_2 = os.date("*t", var_113_1)

	var_113_2.hour = 23
	var_113_2.min = 59
	var_113_2.sec = 59
	var_113_2.day = var_113_2.day + (7 - var_113_2.wday + 1) % 7

	local var_113_3 = os.time(var_113_2) - var_113_1

	return (var_113_3 > 0 or nil) and var_0_38(var_113_3)
end

function ExpeditionManager:getEndTimeStr(arg_114_1)
	assert(expedition_entrance_data[arg_114_1], string.format("curExpeditionEntranceData is nil,the typeid is %d", arg_114_1))

	return expedition_entrance_data[arg_114_1].finishtime
end

function ExpeditionManager:getStarTimeStr(arg_115_1)
	assert(expedition_entrance_data[arg_115_1], string.format("curExpeditionEntranceData is nil,the typeid is %d", arg_115_1))

	return expedition_entrance_data[arg_115_1].starttime
end

function ExpeditionManager:getExpeditionCurLevelData()
	local var_116_0 = require("data.leveldata.level_data_" .. self.expeditionInfo.initmode)

	assert(var_116_0[self.expeditionInfo.initmode .. "-" .. self.expeditionInfo.curChapter .. "-" .. self.expeditionInfo.curLevel + 1])

	return var_116_0[self.expeditionInfo.initmode .. "-" .. self.expeditionInfo.curChapter .. "-" .. self.expeditionInfo.curLevel + 1]
end

function ExpeditionManager:setFightEventId(arg_117_1)
	self.lastEventId = arg_117_1
end

function ExpeditionManager:getFightEventId()
	return self.lastEventId
end

function ExpeditionManager:initSelectSkillInfo(arg_119_1)
	local var_119_0 = {}
	local var_119_1 = RoleDefault:getInstance():getStringForKey("ExpeditionSelectSkill-" .. self.expeditionInfo.inittype)

	if var_119_1 and var_119_1 ~= "" then
		local var_119_2 = string.split(var_119_1, ",")

		for iter_119_0 = 1, 3 do
			local var_119_3 = tonumber(var_119_2[iter_119_0])
			local var_119_5 = {
				id = #var_119_0 + 1,
				skillid = var_119_3,
				rare = expedition_total_skill_data[var_119_3].skill_rare,
				name = expedition_total_skill_data[var_119_3].name,
				des = expedition_total_skill_data[var_119_3].description
			}

			var_119_5.iconPath = "skill_new/skill/" .. (expedition_total_skill_data[var_119_3].icon or 22822) .. ".png"

			table.insert(var_119_0, var_119_5)
		end
	else
		local var_119_6 = expedition_skill_pool_data[arg_119_1]

		if expedition_skill_pool_data[arg_119_1] == nil then
			print("远征系统没有该技能池！！！！")
			print("skillpoolid")
			print(arg_119_1)

			return
		end

		local var_119_7 = {}

		while var_119_6["skill_" .. 1] do
			table.insert(var_119_7, var_119_6["skill_" .. 1])
		end

		local var_119_9 = #var_119_7
		local var_119_10 = {}

		for iter_119_1 = 1, #var_119_7 do
			table.insert(var_119_10, iter_119_1)
		end

		local var_119_11 = ""

		for iter_119_2 = 1, 3 do
			local var_119_12 = math.random(iter_119_2, var_119_9)

			var_119_10[var_119_12], var_119_10[iter_119_2] = var_119_10[iter_119_2], var_119_10[var_119_12]

			assert(expedition_total_skill_data[var_119_7[var_119_10[iter_119_2]]], string.format("expedition_total_skill_data id nil :%d", var_119_7[var_119_10[iter_119_2]]))

			local var_119_14 = {
				id = #var_119_0 + 1,
				skillid = var_119_7[var_119_10[iter_119_2]],
				rare = expedition_total_skill_data[var_119_7[var_119_10[iter_119_2]]].skill_rare,
				name = expedition_total_skill_data[var_119_7[var_119_10[iter_119_2]]].name,
				des = expedition_total_skill_data[var_119_7[var_119_10[iter_119_2]]].description
			}

			var_119_14.iconPath = "skill_new/skill/" .. (expedition_total_skill_data[var_119_7[var_119_10[iter_119_2]]].icon or 22822) .. ".png"

			table.insert(var_119_0, var_119_14)

			var_119_11 = var_119_11 .. "," .. var_119_7[var_119_10[iter_119_2]]
		end

		RoleDefault:getInstance():setStringForKey("ExpeditionSelectSkill-" .. self.expeditionInfo.inittype, var_119_11)
	end

	return var_119_0
end

function ExpeditionManager:clearLastSkillList()
	RoleDefault:getInstance():setStringForKey("ExpeditionSelectSkill-" .. self.expeditionInfo.inittype, "")
end

function ExpeditionManager:isMeetConfitionTriggerEvent(arg_121_1)
	if arg_121_1 == nil then
		return false
	end

	local var_121_0

	if arg_121_1.roomType == ExpeditionRoomType.Normal or arg_121_1.roomType == ExpeditionRoomType.Elite or arg_121_1.roomType == ExpeditionRoomType.BOSS or arg_121_1.roomType == ExpeditionRoomType.TowerDefenceNormal or arg_121_1.roomType == ExpeditionRoomType.TowerDefenceElite or arg_121_1.roomType == ExpeditionRoomType.TowerDefenceBoss or arg_121_1.roomType == ExpeditionRoomType.Random then
		do return true end

		var_121_0 = false
	end

	local var_121_1 = expedition_event_basic_data[arg_121_1.eventClassificationList[1].eventid]
	local var_121_2 = {}

	while var_121_1["event_type_" .. 1] do
		table.insert(var_121_2, {
			id = #var_121_2 + 1,
			eventtype = var_121_1["event_type_" .. 1],
			eventvalue = var_121_1["event_reward_" .. 1]
		})
	end

	local var_121_4 = {}

	for iter_121_0, iter_121_1 in pairs(var_121_2) do
		if iter_121_1.eventtype == var_0_34.Recruit then
			local var_121_5 = string.split(iter_121_1.eventvalue, "&")

			table.insert(var_121_4, {
				id = #var_121_4 + 1,
				rare = (var_121_5[1] ~= "0" or nil) and var_121_5[1],
				career = (var_121_5[2] ~= "0" or nil) and var_121_5[2]
			})
		end
	end

	local var_121_8 = {}

	if #var_121_4 > 0 then
		var_121_8 = {
			rare = var_121_4[1].rare,
			career = var_121_4[1].career
		}
	end

	local var_121_9 = self.expeditionInfo.teamList

	if next(var_121_8) == nil then
		var_121_0 = true
	else
		local var_121_10 = {}

		for iter_121_2, iter_121_3 in pairs((playermodel:getOwnedServantByCondition(var_121_8))) do
			local var_121_11 = false

			for iter_121_4, iter_121_5 in pairs(var_121_9) do
				if iter_121_5.servantid == iter_121_2 then
					var_121_11 = true

					break
				end
			end

			if var_121_11 == false then
				table.insert(var_121_10, iter_121_2)
			end
		end

		if #var_121_10 < #var_121_4 then
			global_ShowBlockWords("可供招募学员不足")
		else
			var_121_0 = true
		end
	end

	return var_121_0
end

function ExpeditionManager:getCurLevelInfo()
	return (self.expeditionInfo.curSelectLevel and self.expeditionInfo.curLevel or nil) and self.expeditionInfo.stepList[self.expeditionInfo.curLevel + 1].roomList[self.expeditionInfo.curSelectLevel]
end

function ExpeditionManager:get_player_expedition_task(arg_123_1)
	network:rpc("get_player_expedition_task", {}, function(arg_124_0)
		for iter_124_0, iter_124_1 in pairs(arg_124_0.task) do
			iter_124_1.sortIndex = iter_124_1.status == 1 and 3 or iter_124_1.percent >= 100 and 1 or 2
		end

		table.sort(arg_124_0.task, function(arg_125_0, arg_125_1)
			if arg_125_0.sortIndex == arg_125_1.sortIndex then
				return arg_125_0.taskid < arg_125_1.taskid
			else
				return arg_125_0.sortIndex < arg_125_1.sortIndex
			end
		end)

		if arg_123_1 then
			arg_123_1(arg_124_0.task)
		end
	end)
end

function ExpeditionManager:get_task_reward(arg_126_1, arg_126_2)
	network:rpc("get_task_reward", {
		taskid = arg_126_1
	}, function(arg_127_0)
		if arg_127_0.result ~= 1 then
			return
		end

		global_gain(arg_127_0)

		if arg_126_2 then
			arg_126_2(arg_127_0.task)
		end
	end)
end

function ExpeditionManager:setExpeditionParam(arg_128_1)
	self.params = arg_128_1
end

function ExpeditionManager:getExpeditionParam()
	return self.params
end

function ExpeditionManager:isExpeditionSeasonEnded(arg_130_1)
	local var_130_0 = expedition_entrance_data[arg_130_1]

	assert(expedition_entrance_data[arg_130_1], "the expedition season id is no data, seasonid is :%d", arg_130_1)

	local var_130_1 = time_check_manager:getCurTime()

	return var_130_1 - global_get_time_by_date(var_130_0.starttime) < 0 and -1 or global_get_time_by_date(var_130_0.finishtime) - var_130_1 > 0 and 0 or 1
end

function ExpeditionManager:switchExpeditionTower(arg_131_1)
	if arg_131_1 == ExpeditionRoomType.TowerDefenceNormal or arg_131_1 == ExpeditionRoomType.TowerDefenceElite or arg_131_1 == ExpeditionRoomType.TowerDefenceBoss then
		self:initExpeditionTowerInfo()
	else
		self.expeditionTowerInfo = nil
	end
end

function ExpeditionManager:updateTotalCost(arg_132_1)
	var_0_30 = var_0_30 + arg_132_1

	if var_0_30 >= self.configInfo.cost_time then
		var_0_30 = 0
		self.totalCost = self.totalCost + self.configInfo.grow_cost

		if self.totalCost >= self.configInfo.max_cost then
			self.totalCost = self.configInfo.max_cost
		end
	end
end

function ExpeditionManager:initExpeditionTowerInfo()
	self.curRoleNum = 0
	self.isPlayerBossDie = false
	self.isEnemyBossDie = false

	local var_133_0 = chapter_data[self:getCurMode() .. "-" .. self:getCurRoomIndex()]

	assert(var_133_0, "curChapterData is nil")

	self.isFighting = true
	self.enemyConf = self:initEnemyConf()
	self.totalCost = var_133_0.begin_cost or 50

	local var_133_1 = {}

	var_133_1.begin_cost = var_133_0.begin_cost or 50
	var_133_1.grow_cost = var_133_0.grow_cost or 5
	var_133_1.max_cost = var_133_0.max_cost or 500
	var_133_1.cost_time = var_133_0.cost_time or 3
	var_133_1.max_role = var_133_0.max_role or 10
	var_133_1.role_limit = var_133_0.max_role or 10
	var_133_1.free_xp_count = var_133_0.free_xp_count or 0
	var_133_1.free_reflag_count = var_133_0.free_reflag_count or 0
	var_133_1.fightauto = playermodel.autoXP
	var_133_1.fightspeed = FightManager.getBossSpeedUpForce()
	var_133_1.analysis_info = {}
	self.configInfo = var_133_1
	self._fighting = {}
	self._dead = {}

	FightManager.setWorldMapWidth(FIGHTTYPE_EXPEDITION_TOWER, var_133_0.level_lenth or 3000)
end

function ExpeditionManager:resetExpeditionTowerFight()
	if FightLayer and FightLayer.getInstance() then
		FightLayer.getInstance():updateFightAutoMode((self.configInfo or nil) and (self.configInfo.fightauto or playermodel.autoXP))
		FightLayer.getInstance():updateFightSpeedUp((self.configInfo or nil) and (self.configInfo.fightspeed or 1.5))

		local var_134_1 = FightLayer.getInstance().expeditionTowerPanel.camera

		FightManager.unregisterWorldMapListener(var_134_1, var_134_1.listenerFunc)
		FightLayer.getInstance().btnAuto:setVisible(true)
		FightLayer.getInstance().btnSpeedup:setVisible(true)
	end

	self.isFighting = nil
	self.enemyConf = nil
	self.totalCost = nil
	self.configInfo = nil
	self._fighting = nil
	self._dead = nil
	self.isEnemyBossDie = nil
	self.isPlayerBossDie = nil
end

function ExpeditionManager:refreshExpeditionTowerFight()
	self.curRoleNum = 0
	self.isPlayerBossDie = false
	self.isEnemyBossDie = false

	local var_135_0 = chapter_data[self:getCurMode() .. "-" .. self:getCurRoomIndex()]

	assert(var_135_0, "curChapterData is nil")

	self.isFighting = true
	self.enemyConf = self:initEnemyConf()
	self.totalCost = var_135_0.begin_cost or 50

	local var_135_1 = {
		isrefresh = 1
	}

	var_135_1.begin_cost = var_135_0.begin_cost or 50
	var_135_1.grow_cost = var_135_0.grow_cost or 5
	var_135_1.max_cost = var_135_0.max_cost or 500
	var_135_1.cost_time = var_135_0.cost_time or 3
	var_135_1.max_role = var_135_0.max_role or 10
	var_135_1.role_limit = var_135_0.max_role or 10
	var_135_1.free_xp_count = var_135_0.free_xp_count or 0
	var_135_1.free_reflag_count = var_135_0.free_reflag_count or 0
	var_135_1.fightauto = playermodel.autoXP
	var_135_1.fightspeed = FightManager.getBossSpeedUpForce()
	var_135_1.analysis_info = {}
	self.configInfo = var_135_1
	self._fighting = {}
	self._dead = {}
end

function ExpeditionManager:setCurRoleNum(arg_136_1)
	self.curRoleNum = arg_136_1
end

function ExpeditionManager:getCurRoleNum()
	if not self.isFighting then
		return
	end

	return self.configInfo.role_limit - self.configInfo.max_role
end

function ExpeditionManager:getMaxRole(...)
	return self.configInfo.max_role
end

function ExpeditionManager:getRoleTotalLimitNum()
	if not self.isFighting then
		return
	end

	return self.configInfo.role_limit
end

function ExpeditionManager:getCurTotalCost()
	if not self.isFighting then
		return
	end

	return self.totalCost
end

function ExpeditionManager:getXPItemNum()
	return "×" .. item_manager:getItemNumber(levelmode_data[self:getCurMode()].special_cost_item1)
end

function ExpeditionManager:getXPFreeCount()
	if not self.configInfo then
		return 0
	end

	return self.configInfo.free_xp_count
end

function ExpeditionManager:getReflagFreeCount()
	if not self.configInfo then
		return 0
	end

	return self.configInfo.free_reflag_count
end

function ExpeditionManager:getReflagItemNum()
	return "×" .. item_manager:getItemNumber(levelmode_data[self:getCurMode()].special_cost_item2)
end

function ExpeditionManager:getReflagItemNum2()
	return item_manager:getItemNumber(levelmode_data[self:getCurMode()].special_cost_item2)
end

function ExpeditionManager:isRoleDead(arg_146_1)
	if not self.isFighting then
		return
	end

	return not not self._dead[arg_146_1]
end

function ExpeditionManager:isRoleFighting(arg_147_1)
	if not self.isFighting then
		return
	end

	if self._fighting[arg_147_1] then
		return true
	else
		return false
	end
end

function ExpeditionManager:getCurFightPos(arg_148_1)
	return arg_148_1 + #self:getCurLevelInfo().baseConfig[1]
end

function ExpeditionManager:addRoleByManualWithServantid(arg_149_1)
	for iter_149_0, iter_149_1 in pairs(self.expeditionInfo.canFightServantList) do
		if iter_149_1.servantid == arg_149_1 then
			self:addRoleByManual(iter_149_0)
		end
	end
end

function ExpeditionManager:addRoleByManual(arg_150_1, arg_150_2)
	if not self.isFighting then
		return
	end

	if not self.expeditionInfo.canFightServantList[arg_150_1] then
		global_ShowBlockWords("学员不可选")

		return
	end

	local var_150_0 = self.expeditionInfo.canFightServantList[arg_150_1].servantid

	if self:isRoleDead(self.expeditionInfo.canFightServantList[arg_150_1].servantid) then
		global_ShowBlockWords("学员不可选")

		return
	end

	if self.configInfo.max_role <= 0 then
		global_ShowBlockWords("上场人数已达上限")

		return
	end

	if self._fighting[var_150_0] then
		return
	end

	self._fighting[var_150_0] = true

	FightManager.addTowerPlayerByManual(var_150_0, self:getCurFightPos(arg_150_1), arg_150_2)

	self.configInfo.max_role = self.configInfo.max_role - 1
	self.totalCost = self.totalCost - self:get_servant_cost(var_150_0)

	self:updateExpeditionTowerPanelUI(var_150_0)

	return true
end

function ExpeditionManager:get_servant_cost(arg_151_1)
	return 0
end

function ExpeditionManager:getRoleCostPercent(arg_152_1)
	local var_152_0 = 100 - (self:getCurTotalCost() + var_0_30 / self.configInfo.cost_time * self.configInfo.grow_cost) / self:get_servant_cost(arg_152_1) * 100

	var_152_0 = var_152_0 > 100 and 100 or var_152_0

	return var_152_0
end

function ExpeditionManager:getRoleDeadTime(arg_153_1)
	if self:isRoleDead(arg_153_1) then
		return math.floor(self._dead[arg_153_1])
	else
		return ""
	end
end

function ExpeditionManager:getRoleDeadTimePercent(arg_154_1)
	if self:isRoleDead(arg_154_1) then
		return (self:get_servant_dead_cd(arg_154_1) - self._dead[arg_154_1]) / self:get_servant_dead_cd(arg_154_1) * 100
	else
		return 0
	end
end

function ExpeditionManager:updateDeadTime(arg_155_1)
	return
end

function ExpeditionManager:costSpecialItem(arg_156_1, arg_156_2)
	if not self.isFighting then
		arg_156_2({})

		return
	end

	arg_156_1 = arg_156_1 == "xp" and 1 or 2

	local var_156_0 = self:getCurMode()

	;(function()
		network:rpc("expedition_tower_cost_item", {
			costtype = arg_156_1,
			isrefresh = self.configInfo.isrefresh,
			add_free_cost = self.configInfo.add_free_cost
		}, function(arg_158_0)
			if arg_158_0.result == 1 then
				if arg_158_0.costitemid then
					item_manager:deleteItem(arg_158_0.costitemid, arg_158_0.costnum)
				elseif arg_158_0.costdiamond then
					playermodel.diamond = playermodel.diamond - arg_158_0.costdiamond

					global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
				elseif arg_158_0.free_xp_count then
					self.configInfo.free_xp_count = arg_158_0.free_xp_count
					self.configInfo.add_free_cost = nil
				elseif arg_158_0.free_reflag_count then
					self.configInfo.free_reflag_count = arg_158_0.free_reflag_count
				end

				if self.configInfo.isrefresh then
					self.configInfo.isrefresh = nil
				end

				if arg_156_2 then
					arg_156_2(arg_158_0)
				end
			else
				global_ShowBlockWords((not L_TOWER_DEFENCE_COST_ERROR[arg_158_0.result] or nil) and "ERROR")

				if arg_156_2 then
					arg_156_2(arg_158_0)
				end
			end
		end)
	end)()
end

function ExpeditionManager:getTeamIdxStr()
	if not self.isFighting then
		return ""
	end

	return self.enemyConf.index .. "/" .. #self.enemyConf.teams, (self.enemyConf.index >= 10 or nil) and 0.8
end

function ExpeditionManager:initEnemyConf()
	local var_160_0 = self:getCurMode()
	local var_160_1 = level_manager.getCurMonsterTeamData(var_160_0, chapter_data[var_160_0 .. "-" .. self:getCurRoomIndex()].bigboss)
	local var_160_2 = {
		index = 0,
		teams = {},
		times = {},
		isFinal = {}
	}

	while var_160_1["subteam" .. 1] do
		table.insert(var_160_2.teams, monster_manager.initBossList(var_160_1["subteam" .. 1]))

		local var_160_3 = level_manager.getCurMonsterTeamData(var_160_0, var_160_1["subteam" .. 1])

		table.insert(var_160_2.times, {
			income_time = var_160_3.income_time,
			force_time = var_160_3.force_time
		})

		if var_160_3.is_endless then
			var_160_2.forever_team = monster_manager.initBossList(var_160_1["subteam" .. 1])
			var_160_2.forever_time = var_160_3.endless_time or 6
			var_160_2.forever_init_time = var_160_2.forever_time
		end

		if var_160_3.isFinal then
			var_160_2.isFinal[#var_160_2.teams] = true
		end
	end

	return var_160_2
end

function ExpeditionManager:updateEnemyAppearTime(arg_161_1, arg_161_2)
	self:updateTotalCost(arg_161_1)
	self:updateDeadTime(arg_161_1)

	if FightLayer and FightLayer.getInstance() and FightLayer.getInstance().expeditionTowerPanel then
		FightLayer.getInstance().expeditionTowerPanel:updatePanel()
	end

	if #self.enemyConf.teams <= self.enemyConf.index then
		if self.enemyConf.forever_time then
			self.enemyConf.forever_time = self.enemyConf.forever_time - arg_161_1

			if self.enemyConf.forever_time <= 0 then
				self.enemyConf.forever_time = self.enemyConf.forever_init_time

				return true, self.enemyConf.forever_team
			end
		end
	else
		if arg_161_2 then
			self.enemyConf.times[self.enemyConf.index + 1].income_time = self.enemyConf.times[self.enemyConf.index + 1].force_time
		end

		for iter_161_0 = self.enemyConf.index + 1, #self.enemyConf.teams do
			self.enemyConf.times[iter_161_0].income_time = self.enemyConf.times[iter_161_0].income_time - arg_161_1
		end

		if self.enemyConf.times[self.enemyConf.index + 1].income_time <= 0 then
			self.enemyConf.index = self.enemyConf.index + 1

			if FightLayer and FightLayer.getInstance() and FightLayer.getInstance().expeditionTowerPanel then
				FightLayer.getInstance():updateTowerDefenceWave()
			end

			return true, self.enemyConf.teams[self.enemyConf.index + 1], self.enemyConf.isFinal[self.enemyConf.index + 1]
		end
	end

	return false
end

function ExpeditionManager:isBossDie(arg_162_1)
	if arg_162_1 == "player" then
		return self.isPlayerBossDie or false
	elseif arg_162_1 == "enemy" then
		return self.isEnemyBossDie or false
	else
		return self.isEnemyBossDie or self.isPlayerBossDie or false
	end
end

function ExpeditionManager:addCostOnEnemyDie(arg_163_1)
	if not self.isFighting then
		return
	end

	local var_163_0 = arg_163_1.model
	local var_163_1
	local var_163_2

	if arg_163_1.model.baseid then
		var_163_1 = bigWar_base_data[var_163_0.baseid].kill_cost or 0
		var_163_2 = bigWar_base_data[var_163_0.baseid].free_xp_count or 0
	elseif var_163_0.monsterid then
		local var_163_3 = level_manager.getCurMonsterData(self:getCurMode(), var_163_0.monsterid)

		var_163_1 = var_163_3.kill_cost or 0
		var_163_2 = var_163_3.free_xp_count or 0
	end

	self.totalCost = self.totalCost + var_163_1

	if self.totalCost >= self.configInfo.max_cost then
		self.totalCost = self.configInfo.max_cost
	end

	self.configInfo.add_free_cost = (self.configInfo.add_free_cost or 0) + var_163_2
	self.configInfo.free_xp_count = self.configInfo.free_xp_count + var_163_2

	if FightLayer and FightLayer.getInstance() and FightLayer.getInstance().expeditionTowerPanel then
		local var_163_4 = FightLayer.getInstance().expeditionTowerPanel

		if var_163_2 > 0 then
			var_163_4:updateXpCountUI()
			var_163_4:showMonsterDropSp("xp")
		end
	end

	if arg_163_1:isBoss() then
		self.isEnemyBossDie = true
	end
end

function ExpeditionManager:onPlayerDie(arg_164_1, arg_164_2, arg_164_3)
	if arg_164_2 then
		if arg_164_3 then
			self.isPlayerBossDie = true
		end

		return
	end

	local var_164_0 = FightManager.getCharacter("players@" .. arg_164_1):getAttribute("servantid")

	self.configInfo.max_role = self.configInfo.max_role + 1

	self:setCurRoleNum(math.max(self:getCurRoleNum() - 1, 0))

	self._fighting[var_164_0] = nil
	self._dead[var_164_0] = self:get_servant_dead_cd(var_164_0)

	self:updateExpeditionTowerPanelUI(var_164_0)
end

function ExpeditionManager:updateExpeditionTowerPanelUI(arg_165_1)
	if FightLayer and FightLayer.getInstance() and FightLayer.getInstance().expeditionTowerPanel then
		local var_165_0 = FightLayer.getInstance().expeditionTowerPanel

		var_165_0:updateUI()
		var_165_0:updatePanelSp(arg_165_1)
	end
end

function ExpeditionManager:get_servant_dead_cd(arg_166_1)
	local var_166_0 = global_get_servant_skin(arg_166_1)

	assert(servant_data[arg_166_1], arg_166_1)

	local var_166_1 = model_data[var_166_0].modeltype or ""

	for iter_166_0, iter_166_1 in ipairs({
		"servant" .. tostring(arg_166_1),
		"modeltype" .. var_166_1,
		model_data[var_166_0].career .. "_" .. servant_data[arg_166_1].roll_rarity
	}) do
		if bigWar_role_cost_data[iter_166_1] then
			return bigWar_role_cost_data[iter_166_1].dead_cd
		end
	end

	return 999
end

function ExpeditionManager:updatedaily()
	playermodel:reloadPlayerItems(function()
		if self.updateShopCoinNumCallback then
			self.updateShopCoinNumCallback()
		end

		if self.updateMainCoinNumCallback then
			self.updateMainCoinNumCallback()
		end
	end)
end

function ExpeditionManager:switchExpeditionToLimiteTimeMode()
	self:initExpeditionLimitTimeInfo()
end

function ExpeditionManager:initExpeditionLimitTimeInfo()
	self.expeditionLimitTimeInfo = {}
	self.expeditionLimitTimeInfo.totaltime = 20
	self.expeditionLimitTimeInfo.fighttime = 0
	self.expeditionLimitTimeInfo.damage = 0
	self.expeditionLimitTimeInfo.minhpvalue = 100
end

function ExpeditionManager:sync_expedition_time(arg_171_1)
	if self.expeditionLimitTimeInfo == nil then
		return
	end

	network:rpc("expedition_sync_time", {
		dt = tostring(arg_171_1),
		damage = tostring(self.expeditionLimitTimeInfo.damage)
	}, function(arg_172_0)
		if arg_172_0.result == 1 then
			self:updateFightTime(tonumber(arg_172_0.time))
		elseif arg_172_0.result == 2 then
			FightManager.fightEndExtern(EXPEDITION.FIGHT_RESULT.TIME_OUT)
		end
	end)
end

function ExpeditionManager:get_remain_time()
	return self.expeditionLimitTimeInfo.totaltime - self.expeditionLimitTimeInfo.fighttime
end

function ExpeditionManager:get_fight_time()
	return self.expeditionLimitTimeInfo.fighttime
end

function ExpeditionManager:sync_boss_damage(arg_175_1)
	self.expeditionLimitTimeInfo.damage = self.expeditionLimitTimeInfo.damage + arg_175_1
end

function ExpeditionManager:getDamage()
	return self.expeditionLimitTimeInfo.damage
end

function ExpeditionManager:checkMonopolyCurHp(arg_177_1)
	if arg_177_1 < self.expeditionLimitTimeInfo.minhpvalue then
		arg_177_1 = self.expeditionLimitTimeInfo.minhpvalue

		FightManager.fightEndExtern(EXPEDITION.FIGHT_RESULT.MAX_DAMAGE)
	end

	return arg_177_1
end

function ExpeditionManager:updateFightTime(arg_178_1)
	self.expeditionLimitTimeInfo.fighttime = arg_178_1

	FightManager.updateFightTimeByServer(self.expeditionLimitTimeInfo.fighttime, 1, 0)
	self:updateFighLayerLefttTime()
end

function ExpeditionManager:updateFighLayerLefttTime()
	FightLayer.getInstance():updateInfinteTimePanel(self:get_remain_time() or 0)
end

function ExpeditionManager:get_expedition_rank_list(arg_180_1)
	network:rpc("get_expedition_rank_list", {
		stop = 100,
		start = 1
	}, function(arg_181_0)
		if arg_181_0.result == 1 and type(arg_180_1) == "function" then
			arg_180_1(arg_181_0.data)
		end
	end)
end

function ExpeditionManager:isEndlessMode()
	return not not (self.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Monopoly and self.isLastLevelMode)
end

function ExpeditionManager:getOwnServant(...)
	local var_183_0 = {}

	for iter_183_0, iter_183_1 in pairs(servant_data) do
		if iter_183_1.classtype == 1 and playermodel.haveServant[iter_183_1.id] then
			table.insert(var_183_0, iter_183_1.id)
		end
	end

	return var_183_0
end

function ExpeditionManager:getMonsterPower()
	return self.expeditionInfo.monsterpower
end

return ExpeditionManager:create()
