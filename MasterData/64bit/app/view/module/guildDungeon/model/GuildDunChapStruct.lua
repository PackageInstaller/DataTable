local GuildDunChapStruct = class("GuildDunChapStruct")
local GuildDunStageStruct = require("app.view.module.guildDungeon.model.GuildDunStageStruct")
local var_0_2 = g.core.config.guild_dungeon_stage_info

GuildDunChapStruct.CHAPTER_NUM = 4

function GuildDunChapStruct:ctor(arg_1_1)
	self._chapterId = arg_1_1
	self._stageMap = {}
	self._stageList = {}
	self._cfg = {}
	self._curChapterHp = 0
	self._rebirth = 1
	self._isInitData = false
end

function GuildDunChapStruct:getCfg()
	return self._cfg
end

function GuildDunChapStruct:setCfg(arg_3_1, arg_3_2, arg_3_3)
	self._cfg = arg_3_1

	self:_initStageInfo(arg_3_2, arg_3_3)
end

function GuildDunChapStruct:setRebirth(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self._stageList) do
		if iter_4_1.setRebirth then
			iter_4_1:setRebirth(arg_4_1)
		end
	end
end

function GuildDunChapStruct:_initStageInfo(arg_5_1, arg_5_2)
	for iter_5_0 = 1, GuildDunChapStruct.CHAPTER_NUM do
		local var_5_0 = var_0_2.get(self._cfg["dungeon_" .. iter_5_0])
		local var_5_1 = GuildDunStageStruct.new(self._cfg["dungeon_" .. iter_5_0])

		var_5_1:setCfg(var_5_0, arg_5_1, arg_5_2)

		self._stageMap[var_5_0.id] = var_5_1

		table.insert(self._stageList, var_5_1)
	end
end

function GuildDunChapStruct:getChapterTotalHp()
	local var_6_0 = 0

	for iter_6_0 = 1, #self._stageList do
		var_6_0 = math.uint64_add(var_6_0, (self._stageList[iter_6_0]:getStageTotalHp()))
	end

	return var_6_0
end

function GuildDunChapStruct:setServerData(arg_7_1)
	self:setRebirth(arg_7_1.rebirth or 1)

	self._curChapterHp = math.uint64_sub(self:getChapterTotalHp(), arg_7_1.current_chapter_hp)
end

function GuildDunChapStruct:updateCurHp()
	self._curChapterHp = "0"

	for iter_8_0 = 1, #self._stageList do
		self._curChapterHp = math.uint64_add(self._curChapterHp, (self._stageList[iter_8_0]:getStageCurHp()))
	end
end

function GuildDunChapStruct:getChapterProgress()
	return (1 - tonumber((string.format("%.2f", math.uint64_div(self._curChapterHp, (self:getChapterTotalHp())))))) * 100
end

function GuildDunChapStruct:getChapterId()
	return self._cfg.id
end

function GuildDunChapStruct:getCurrentHp()
	return self._curChapterHp
end

function GuildDunChapStruct:getStageMap()
	return self._stageMap
end

function GuildDunChapStruct:getStageList()
	return self._stageList
end

function GuildDunChapStruct:getStageById(arg_14_1)
	return self._stageMap[arg_14_1]
end

return GuildDunChapStruct
