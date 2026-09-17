local LimitTowerDefenceLevelManager = class("LimitTowerDefenceLevelManager", (require("controller.base_manager")))

LimitTowerDefenceLevelManager.MULTITON_MSG = "LimitTowerDefenceLevelManager instancealready constructed!"

function LimitTowerDefenceLevelManager:ctor()
	self.super.ctor(self)

	self.mode = nil
	self.modeList = {}
	self.modeIndex = nil
	self.startTime = nil
	self.endTime = nil
	self.season = nil
end

function LimitTowerDefenceLevelManager:getSeason()
	return self.season
end

function LimitTowerDefenceLevelManager:getStartTime()
	return self.startTime
end

function LimitTowerDefenceLevelManager:getEndTime()
	return self.endTime
end

function LimitTowerDefenceLevelManager:getModeList()
	return self.modeList
end

function LimitTowerDefenceLevelManager:getCurChapter()
	local var_6_0 = self:getCurMode()

	if var_6_0 then
		return (require("controller.level_manager"):getCurChapter(var_6_0))
	end

	return 1
end

function LimitTowerDefenceLevelManager:getModeTotalChapter()
	local var_7_0 = self:getCurMode()

	if var_7_0 then
		return (require("controller.level_manager"):getModeTotalChapter(var_7_0))
	end

	return nil
end

function LimitTowerDefenceLevelManager:setCurMode(arg_8_1)
	arg_8_1 = tonumber(arg_8_1)

	if arg_8_1 then
		self.mode = arg_8_1
	end
end

function LimitTowerDefenceLevelManager:getCurMode()
	return self.mode
end

function LimitTowerDefenceLevelManager:getModeByModeIndex(arg_10_1)
	if self.modeList[arg_10_1] then
		return self.modeList[arg_10_1]
	end

	return nil
end

function LimitTowerDefenceLevelManager:setCurModeIndex(arg_11_1)
	arg_11_1 = tonumber(arg_11_1)

	if arg_11_1 then
		self.modeIndex = arg_11_1
	end
end

function LimitTowerDefenceLevelManager:getCurModeIndex()
	return self.modeIndex
end

function LimitTowerDefenceLevelManager:getChapterInfoByMode(arg_13_1)
	arg_13_1 = tonumber(arg_13_1)

	if arg_13_1 then
		return (require("controller.level_manager"):getCurLevelInfo(arg_13_1))
	end

	return {}
end

function LimitTowerDefenceLevelManager:getCurChapterInfo()
	local var_14_0 = self:getCurMode()

	if var_14_0 then
		return (require("controller.level_manager"):getCurLevelInfo(var_14_0))
	end

	return {}
end

function LimitTowerDefenceLevelManager:getChapterStarsState(arg_15_1)
	local var_15_0 = self:getCurMode()

	if var_15_0 then
		return (require("controller.level_manager"):getChapterStarsState(var_15_0, arg_15_1))
	end

	return {}
end

function LimitTowerDefenceLevelManager:getModeTotalChapter()
	local var_16_0 = self:getCurMode()

	if var_16_0 then
		return (require("controller.level_manager"):getModeTotalChapter(var_16_0))
	end

	return 0
end

function LimitTowerDefenceLevelManager:getModeTotalStars()
	local var_17_0 = self:getCurMode()

	if var_17_0 then
		return (require("controller.level_manager"):getModeTotalStars(var_17_0))
	end

	return 0
end

function LimitTowerDefenceLevelManager:checkIsNewStarReward()
	local var_18_0 = self:getCurMode()

	if var_18_0 then
		return (require("controller.level_manager"):checkIsNewStarReward(var_18_0))
	end

	return false
end

function LimitTowerDefenceLevelManager:checkActive()
	local var_19_0 = self:getSeason()

	if not var_19_0 or var_19_0 == 0 then
		return false
	end

	local var_19_1 = self:getStartTime()
	local var_19_2 = self:getEndTime()

	if var_19_1 and var_19_2 then
		local var_19_3 = require("controller.time_check_manager"):getCurTime()

		if var_19_1 <= var_19_3 and var_19_3 < var_19_2 then
			return true
		end
	end

	return false
end

function LimitTowerDefenceLevelManager:getTipsStr()
	local var_20_0 = ""
	local var_20_1 = self:getSeason()

	if not var_20_1 or var_20_1 == 0 then
		var_20_0 = "暂未开启"
	else
		local var_20_2 = self:getStartTime()
		local var_20_3 = self:getEndTime()

		if var_20_2 and var_20_3 then
			local var_20_4 = require("controller.time_check_manager"):getCurTime()

			if var_20_4 < var_20_2 then
				local var_20_5 = "战争模式将于" .. os.date("%y年%m月%d日", self:getStartTime() or 0) .. "开启！"
			elseif var_20_3 <= var_20_4 then
				var_20_0 = "暂未开启"
			end
		end
	end

	return var_20_0
end

function LimitTowerDefenceLevelManager:isLevelModeAutoUnlocked()
	local var_21_0 = self:getCurMode()

	if var_21_0 then
		return (require("controller.level_manager"):isLevelModeAutoUnlocked(var_21_0))
	end

	return false
end

function LimitTowerDefenceLevelManager:isChapterModeUnlocked(arg_22_1)
	local var_22_0 = self:getCurMode()

	arg_22_1 = tonumber(arg_22_1)

	if var_22_0 and arg_22_1 then
		return (require("controller.level_manager"):isChapterModeUnlocked(var_22_0, arg_22_1))
	end

	return false
end

function LimitTowerDefenceLevelManager:getAllDrop(arg_23_1)
	local var_23_0 = self:getCurMode()

	if var_23_0 and arg_23_1 then
		local drop_manager = require("controller.drop_manager")
		local var_23_2 = require("controller.level_manager"):getLevelDropID(var_23_0, arg_23_1 .. "-1")
		local var_23_3 = drop_manager:getEquipAllDrops(var_23_2)
		local var_23_4 = drop_manager:getNormalDrops(var_23_2)
		local var_23_5 = {}

		if var_23_4.diamond > 0 then
			var_23_5[#var_23_5 + 1] = {}
			var_23_5[#var_23_5].dropid = 0
			var_23_5[#var_23_5].dropNum = var_23_4.diamond
		end

		if #var_23_5 > 0 then
			for iter_23_0 = #var_23_5, 1, -1 do
				table.insert(var_23_3, 1, var_23_5[iter_23_0])
			end
		end

		return var_23_3
	end

	return {}
end

function LimitTowerDefenceLevelManager:RequestInfo(arg_24_1)
	require("network.network"):rpc("get_tower_defence_info", nil, function(arg_25_0)
		self:HandlerInfo(arg_25_0)

		if arg_24_1 then
			arg_24_1()
		end
	end)
end

function LimitTowerDefenceLevelManager:HandlerInfo(arg_26_1)
	local playermodel = require("model.playermodel")

	self.modeList = arg_26_1.modelist or {}

	if arg_26_1.modeconfiglist and playermodel.levelmode then
		for iter_26_0 = 1, #arg_26_1.modeconfiglist do
			playermodel.levelmode[arg_26_1.modeconfiglist[iter_26_0].mode] = arg_26_1.modeconfiglist[iter_26_0]
		end
	end

	self.startTime = arg_26_1.starttime
	self.endTime = arg_26_1.finishtime
	self.season = arg_26_1.season

	if self.mode then
		local var_26_1 = false

		for iter_26_1 = 1, #self.modeList do
			if self.modeList[iter_26_1] == self.mode then
				var_26_1 = true

				break
			end
		end

		if not var_26_1 then
			self.mode = self.modeList[1]
		end
	elseif self.modeList and self.modeList[1] then
		self.mode = self.modeList[1]
	end

	self:updateLayer()
end

function LimitTowerDefenceLevelManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function LimitTowerDefenceLevelManager:updateStarReward()
	if self.layer then
		self.layer:updateStarReward()
	end
end

return LimitTowerDefenceLevelManager
