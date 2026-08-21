---@diagnostic disable: undefined-global
require "class"
---@class BattleManager:BaseClass
local BattleManager = class("BattleManager")
local BattleRoleManager = require "BattleRoleManager"
local BattleMap = require "BattleMap"
local SkillManager = require "SkillManager"
local LevelTargetsManager = require "LevelTargetsManager"
local EventManager = require "EventManager"
local BattleReporter = require "BattleReporter"
local BattleHistoryManager = require "BattleHistoryManager"
local BattleOrderManager = require "BattleOrderManager"
local Random = require "Random"
local BattleRoleAIManager = require "BattleRoleAIManager"
local CommonLogic = require "CommonLogic"

local needSaveOrderReport = true

---@class PrepareSkillFollowData
---@field sourceId integer 技能发动角色Id 
---@field blockId integer 技能目标地格Id
---@field skillId integer 技能id

function BattleManager:ctor()
	---@type Random
	self._battleRandom = nil
	---@type BattleMap
	self._map = nil

	self._roleMgr = BattleRoleManager.instance()
	self._skillMgr = SkillManager.instance()
	self._levelTargetsMgr = LevelTargetsManager.instance()
    self._battleEventMgr = EventManager.instance()
	self._historyMgr = BattleHistoryManager.instance()
	self._aiActiveMgr = BattleRoleAIManager:instance()
	---@type BattleOrderManager
	self._orderMgr = BattleOrderManager:new()
	---@type BattleReporter
	self._battleReporter = BattleReporter:new()
	---@type BattleShowManager
	self._showMgr = nil

	---@type BattleMap
	self._map = BattleMap:new()

	self._curRound = 1   --当前回合
	self._maxRounds = 10   --最大回合
	self._backtraceTimes = 99 --回溯次数

	self._clickThreshold = 30
	self._uiFormation = nil
	-- self._uiBattleMain = nil

	---@type BattleTiming
	self._battleTiming = nil
	-- self._manualCamp = 1

	self._verifyMode = false --验证模式

	self._isUseGMToWinBattle = false --是否使用GM命令直接赢得战斗

	---@type fun(resultData:BattleResultResp)? 战斗结束回调
	self._endBattleEvent = nil
	---@type fun(isWin:boolean?):boolean? 战斗失败/非三星时由客户端拦截结算，返回 true 表示已处理
	self._loseConfirmHandler = nil
	---@type boolean? 待确认结算的胜负结果
	self._pendingGameResult = nil
end

---@param isClear boolean? 是否清理战斗数据（主要用于战斗结束后）
function BattleManager:init(isClear)
	self._moveRangeIdList = {}
	self._skillRangeIdList = {}
	self._chooseRangeIdList = {}
	self._formationRangeIdList = {}
	---@type table<integer, BattleHeroInfo> 英雄信息映射表
	self._heroInfoMap = {}
	---@type table<integer, integer> 武器CID映射表
	self._weaponCidMap = {}
	self._levelInfo = nil
	---@type BattleRole
	self._selectedRole = nil
	self._lastSelectedRole = nil
	self._battleStateEvent = nil
	self._isActionState = false
	self._isBattleState = false
	self._chooseTargetState = false
	self._lastSkillSelectBlockId = nil
	self._isAutoMode = false	--自动模式
	self._backtraceTimes = 99 --回溯次数
	self._isEndCurRound = false	--是否结束当前回合
	self._isPauseState = false	--暂停状态
	---@type MovePowerType
	self._tmpMovePowType = GE.MovePowerType.Normal
	self._isEngagedInBattle = false --是否发生战斗（当前行动）
	---是否是当前阵营角色全部行动完后，进行切换阵营
	self._isActionCampChange = false
	
	self._inBacktrace = false --回溯中

	---@type table<integer,integer>
	self._actionRoleList = {}
	
	---@type table<integer,PrepareSkillFollowData[]> 准备类型技能瞄准角色时的数据列表
	self._prepareSkillFollowList = {}

	---@type table<BattleStateEnum, function[]> 前端注册的战斗状态事件回调
	self._setBattleStateEvent = {}

	---@type table<ClientBattleShowType, function>
	self.clientBattleShowEventDic = {}

	---@class SummonData
	---@field [1] integer 召唤物角色Id
	---@field [2] table<integer, number> 召唤物基础属性值列表(创建那一刻已确定)
	---@type table<integer, SummonData[]> 战斗中被保存的召唤物数据
	self._saveSummonRoleData = {}

	if self._historyMgr then
		self._historyMgr:initManager()
	end
	self._roleMgr:initManager()
	self._aiActiveMgr:initManager()
	self._isLocalBattle = nil
	self._autoSwitchChangeNum = 0
	
	---@type table<integer, BattleRoleLogData> 战斗日志数据
	self._battleRoleLogData = {}

	---@type ReportRoleDoSkillData[]
	self._simpleVerifyData = {}
	self._simpleVerify = false
	self._verifyMode = false
	self._replayMode = false
	self._randomCount = 0
	self._curRandomIndex = 1
	---@type number[] 存储的随机数列表
	self._randomNumList = {}
	---@type integer[] 获取随机数的id列表，主要用于验证战斗时获取固定的随机数
	self._getRandomNumIdList = {}
	---@type BattleStateEnum[] 待处理的战斗状态队列，避免同步递归切状态
	self._pendingBattleStates = {}
	self._isDispatchingBattleState = false
	self._isUseGMToWinBattle = false
	-- self:setCamps()
	self._beforeBackTranceSelectRoleId = nil
	self._friendCampAllDamageValue = 0
	---@type table<integer, integer> 有利角色列表
	self._advantageousRoleList = {}
	---@type integer[] 有利角色效果id列表
	self._advantageousRoleEffectIds = {}
	---@type table<integer, integer[]> 周常Boss注入的关卡技能列表
	self._weeklyBossLevelSkillList = {}
	---@type integer[] 周常Boss标签列表
	self._allWeeklyBossTag = {}
	---@type number 周常Boss本分数加成值
	self._weeklyBossScoreAddition = 0
	self._formationList = nil
end

---实例化
---@return BattleManager BattleManager
function BattleManager.instance()
	if (BattleManager._instance == nil) then
		BattleManager._instance = BattleManager:new(false)
	end
	return BattleManager._instance
end

---@param result integer
---@return string
function BattleManager:_getBattleVerifyLogDir(result)
	if GV.IsEditor then
		if result == 1 then
			return ".\\log\\battle_verify_win"
		end
		return ".\\log\\battle_verify_fail"
	end
	local rootPath = UnityEngine.Application.dataPath
	if not rootPath or rootPath == "" then
		rootPath = "."
	end
	local dirName = result == 1 and "battle_verify_win" or "battle_verify_fail"
	return string.format("%s/%s", rootPath, dirName)
end

---@return ReportRoleDoSkillData[]
function BattleManager:_getLocalSimpleVerifyLogData()
	local r = {}
	for index, data in ipairs(self._simpleVerifyData or {}) do
		local skillDamageData = data["skillDamageData"]
		local skillHitData = data["skillHitData"]
		r[index] = {
			cid = data.cid,
			sourceBlockId = data.sourceBlockId,
			sourceBuffIdList = data.sourceBuffIdList,
			targetBuffIdList = data.targetBuffIdList,
			skillId = data.skillId,
			curSourceHp = data.curSourceHp,
			curTargetHp = data.curTargetHp,
			targetCId = data.targetCId,
			targetLevel = data.targetLevel,
			targetBlockId = data.targetBlockId,
			isCrit = data.isCrit,
			damageValue = data.damageValue,
			terrainId = data.terrainId,
			skillDamageData = skillDamageData,
			skillHitData = skillHitData,
		}
	end
	return r
end

local function serializeOrderReport(obj)
    local chunks = {} -- 用数组存储所有字符串片段
    local function _serialize(val)
        local t = type(val)
        if t == "number" then
            table.insert(chunks, tostring(val))
        elseif t == "boolean" then
            table.insert(chunks, tostring(val))
        elseif t == "string" then
            table.insert(chunks, string.format("%q", val))
        elseif t == "table" then
            table.insert(chunks, "{\n")
            for k, v in pairs(val) do
                table.insert(chunks, "[")
                _serialize(k)
                table.insert(chunks, "]=")
                _serialize(v)
                table.insert(chunks, ",\n")
            end
            table.insert(chunks, "}")
        elseif t == "nil" then
            table.insert(chunks, "nil")
        end
    end

    _serialize(obj)
    return table.concat(chunks) -- 一次性高效拼接
end

---@param orderReport BattleOrderReport
function BattleManager:saveLocalBattleLog(orderReport)
	if self._verifyMode or not needSaveOrderReport or GV.IsServer then
		return
	end
	local path = UnityEngine.Application.persistentDataPath
	local content = serializeOrderReport({
		orderReport = orderReport,
		simpleVerifyData = self:_getLocalSimpleVerifyLogData(),
		battleStartInfo = self._battleReporter.battleReports.battleStartData,
		randomList = self._getRandomNumIdList,
	}) or ""

	---@type string
	local filePath = string.format("%s/battle_report_%d_%s.json", path, Me.uid, os.date("%Y%m%d%H%M%S"))
	if GV.IsEditor then
		path = self:_getBattleVerifyLogDir(orderReport.result)
		filePath = string.format("%s/battle_report_%d_%s.json", path, Me.uid, os.date("%Y%m%d%H%M%S"))
		if DFileUtil and DFileUtil.CreateDir then
			DFileUtil.CreateDir(path)
		else
			os.execute('mkdir "' .. path .. '"')
		end
		local file = io.open(filePath, "w")
		if file then
			file:write(content)
			file:close()
		else
			LuaLogger.es("BattleManager:saveLocalBattleLog open file fail", filePath)
		end
	elseif DFileUtil and DFileUtil.WriteFile then
		local err = DFileUtil.WriteFile(filePath, content, false)
		if err and err ~= "" then
			LuaLogger.es("BattleManager:saveLocalBattleLog write fail", filePath, err)
		end
	else
		LuaLogger.es("BattleManager:saveLocalBattleLog no file writer", filePath)
	end
end

---初始化战斗状态切换事件回调
function BattleManager:initBattleStateEvent()
	self._battleStateEvent = {
		--布阵完成状态
		[GE.BattleState.FormationFinish] = function()
			BattleManager.ds("BattleState FormationFinish")
			self:setFormation()
			if self._replayMode then
				local f = function ()
					local BattleVerifyReplayer = require "BattleVerifyReplayer"
					BattleVerifyReplayer.onReplayBattleEnd()
				end
				self:battleStart(self._battleStartInfo, false, f)
				return
			end
			self:enterBattle()
		end,
		--战斗初始化状态
		[GE.BattleState.BattleInit] = function()
			-- BattleManager.ds("BattleState BattleInit")
			self:setTiming(GE.BattleTiming.BattleInit)
			self._roleMgr:checkRolesInitEffects()
			self._isActionCampChange = false
			self:setBattleState(GE.BattleState.BattleStart)
		end,
		--战斗开始状态
		[GE.BattleState.BattleStart] = function()
			-- BattleManager.ds("BattleState BattleStart")
			self:setTiming(GE.BattleTiming.BattleStart)
			self:checkActionRoleCalculateActionRange()
			self._aiActiveMgr:CheckAIEvent(GE.MonsterActiveEventType.NoCondition)
			self:setBattleState(GE.BattleState.RoundStart)
		end,
		--回合开始状态
		[GE.BattleState.RoundStart] = function()
			-- BattleManager.ds("BattleState RoundStart")
			self:setTiming(GE.BattleTiming.RoundStart)
			local isFinish = self:checkWinLose()
			if isFinish == false then
				self:setBattleState(GE.BattleState.SwitchCamp)
			end
		end,
		--切换阵营状态
		[GE.BattleState.SwitchCamp] = function()
			-- BattleManager.ds("BattleState SwitchCamp")
			local curCamp = self._roleMgr:actionCamp()
            local roleList = self._roleMgr:getActionRolesByCamp(curCamp)
            local roleCount = #roleList
			---防止初始化完成时触发切换阵营事件
			if self._isActionCampChange == true then
				self:setTiming(GE.BattleTiming.SwitchCamp)
			end
			self._isActionCampChange = true
			self._roleMgr:checkRolesInitMyCampAction()
			if roleCount == 0 then
				self:AfterActionState()
			else
				self:setBattleState(GE.BattleState.RoleAction)
			end
		end,
		--角色行动状态
		[GE.BattleState.RoleAction] = function()
			-- BattleManager.ds("BattleState RoleAction")
			self._chooseTargetState = false
			self._lastSkillSelectBlockId = nil
			self._roleMgr:roleActionStart()
		end,
		--回合结束状态
		[GE.BattleState.RoundEnd] = function()
			-- BattleManager.ds("BattleState RoundEnd")
			self:setTiming(GE.BattleTiming.RoundEnd)
			self:_enterNextRound()
		end,
		--战斗胜利状态
		[GE.BattleState.BattleWin] = function()
			-- BattleManager.ds("BattleState BattleWin")
			-- UICommonUtils.PopToast("胜利")
			-- DLuaTimer:DoAfter(2, function()
			-- 	self:setBattleState(GE.BattleState.BattleResult)
			-- end)
		end,
		--战斗失败状态
		[GE.BattleState.BattleLose] = function()
			-- BattleManager.ds("BattleState BattleLose")
			-- UICommonUtils.PopToast("失败")
			-- DLuaTimer:DoAfter(2, function()
			-- 	self:setBattleState(GE.BattleState.BattleResult)
			-- end)
		end,
		--战斗结算状态
		[GE.BattleState.BattleResult] = function()
			-- BattleManager.ds("BattleState BattleResult")
			local orderReport = self._battleReporter:getOrderReport()
			if (self.gameOverCallback) then
				self.gameOverCallback(orderReport.result, orderReport)
			end
			self.gameOverCallback = nil
			self:saveLocalBattleLog(orderReport)
		end,
		--回溯状态
		[GE.BattleState.InBacktrace] = function()
			-- BattleManager.ds("BattleState InBacktrace")
		end,
		[GE.BattleState.WaitInputOrder] = function()
			-- BattleManager.ds("BattleState WaitInputOrder")
			if not (self:isVerifyMode() == true or self:IsLocalBattle() == true) then
				return
			end
			self:checkAvgEndForVerify()
			self._roleMgr:checkAutoAction(self._selectedRole)
		end,
		[GE.BattleState.AfterRoleAction] = function ()
			-- BattleManager.ds("BattleState AfterRoleAction")
			if not (self:isVerifyMode() == true or self:IsLocalBattle() == true) then
				return
			end
			self._roleMgr:completeAction()
		end,

		--其他状态
		default = function()
			-- BattleManager.ds("BattleManager:setBattleState wrong battle state!")
		end
	}
end

---开始布阵
function BattleManager:formationStart()
	local levelConfig = self:getLevelConfig()
	local levelId = levelConfig.id
	local levelData = nil
	---@type OrderReportInitData
	local initData = {
		level = levelId,
		heroInfoList = {},
		coveSkillList = {},
	}
	if not self._verifyMode and not self._isLocalBattle and not self._replayMode then
		levelData = Me:getLevelDataByid(levelId)
		local coveManager = CoveManager.instance()
		local coveSkillList = coveManager:getHomeSignal()
		for _, skillData in ipairs(coveSkillList) do
			local _skillType = skillData[1]
			local _skillId = skillData[2]
			local skillData = {
				type = _skillType,
				skillId = _skillId,
			}
			initData.coveSkillList[#initData.coveSkillList + 1] = skillData
			if not self._levelSkillList[_skillType] then
				self._levelSkillList[_skillType] = {}
			end
			local skilList = self._levelSkillList[_skillType]
			skilList[#skilList + 1] = _skillId
		end
	end
	---@type BattleResultData
	local resultData = {
		star = levelConfig.baseStar,
		achieveList = levelData and levelData.achieveList or {},
		rounds = self:getCurrentRound(),
		backtraceTimes = 99 - self:getBacktraceTimes(),
		friendCampDamage = 0,
	}
	self._battleReporter:init()
	self._battleReporter:setInitData(initData)
	self._battleReporter:setResultData(resultData)
	--  self._battleReporter:setGameData({})
	self._roleMgr:createEnemies(levelConfig)
	self._roleMgr:createNpcs(levelConfig)
	self._levelTargetsMgr:initManager()
	self._levelTargetsMgr:initTargetList()
	self._levelTargetsMgr:ChangeFinalRound(levelConfig.fightRounds)
	self._maxRounds = levelConfig.fightRounds
	self:initBattleRoleAIActiveEvent(levelConfig)
	self:setBattleState(GE.BattleState.Formation)
end

---战斗初始化
---@param levelConfig PveLevelTable
function BattleManager:initBattleTest(levelConfig)
	self._battleEventMgr:setBattleEventList(levelConfig.id)
	self._map:initMap(levelConfig, false)
	self._isBattleState = true
	self:formationStart()
end

function BattleManager:initWeekLyBossData()
	local levelId = self._levelConfig.id
	local tagList = Me:getWeeklyBossTagListByLevelId(levelId)
	self:initWeeklyBossTags(tagList)
	local bossLevel = Me:getWeeklyBossLevelConfigByLevelId(levelId)
	if bossLevel then
		self:setAdvantageousRoleList(bossLevel)
	end
end

---@param levelCid integer 关卡cid
---@param heroCidList integer[]? 英雄cid列表
---@return BattleStartInfo? 战斗开始信息
function BattleManager:setLocalStartBattleData(levelCid, heroCidList)
	local levelConfig = Config.GetPveLevelInfo(levelCid)
	if not levelConfig then
		BattleManager.es("BattleManager:setLocalStartBattleData levelConfig is nil for levelCid:", levelCid)
		return
	end
	local formationBlockNum = tablex.size(levelConfig.UserPosition)
	local maxPlayerNum = math.min(levelConfig.maxPerson, formationBlockNum)
	if not heroCidList or next(heroCidList) == nil then
		if not heroCidList then
			heroCidList = {}
		end
		local beforeRandomHeroList = {}
		local heroList = ClientData:GetRoleList()
		for id, _ in pairs(heroList) do
			beforeRandomHeroList[#beforeRandomHeroList + 1] = id
		end

		for i = 1, maxPlayerNum, 1 do
			local randomIndex = math.random(1, #beforeRandomHeroList)
			heroCidList[i] = beforeRandomHeroList[randomIndex]
			table.remove(beforeRandomHeroList, randomIndex)
		end
	end
    -- 获取英雄信息
    local heroInfoMap = {}
    local weaponCidMap = {}

    -- 处理NPC角色信息
    local npcList = {}
    for _, info in ipairs(levelConfig.npcInfo or {}) do
        if info.calltype == 1 and info.is_hero ~= 1 then
			npcList[info.id] = 1
        end
    end
    LuaLogger.ds("heroCidList List:", tablex.dump(heroCidList))
    -- 收集英雄和武器信息
    for _, heroCid in ipairs(heroCidList) do
        -- 检查是否是NPC
        local isNpc = npcList[heroCid]
        if not isNpc then
            -- 获取英雄战斗信息
            local heroInfo = Me:getBattleHeroInfo(heroCid)
			local testConfig = Config.GetBattleTestInfo(heroCid)
            if heroInfo then
				if testConfig then
					if testConfig.baseSkill and next(testConfig.baseSkill) then
						local testActiveSkillList = tablex.clone(testConfig.baseSkill)
						local replaceSkillList = {}
						for i = 1, 3, 1 do
							local skillCount = #testActiveSkillList
							if skillCount == 0 then
								break
							end
							local index = math.random(1, skillCount)
							local newSkillId = testActiveSkillList[index]
							table.insert(replaceSkillList, newSkillId)
							table.remove(testActiveSkillList, index)
						end
						BattleManager.ds("EquippedSkillList", tablex.dump(replaceSkillList))
						heroInfo.EquippedSkillList = replaceSkillList
					end
					if testConfig.passiveSkill and next(testConfig.passiveSkill) then
						local testPassiveSkillList = tablex.clone(testConfig.passiveSkill)
						local replaceSkillList = {}
						for i = 1, 5, 1 do
							local skillCount = #testPassiveSkillList
							if skillCount == 0 then
								break
							end
							local index = math.random(1, skillCount)
							local newSkillId = testPassiveSkillList[index]
							table.insert(replaceSkillList, newSkillId)
							table.remove(testPassiveSkillList, index)
						end
						BattleManager.ds("effectiveSkill", tablex.dump(replaceSkillList))
						heroInfo.effectiveSkill = replaceSkillList
					end
				end
				heroInfoMap[heroCid] = heroInfo
                -- 收集武器信息
                local carryWeapon = heroInfo.carryWeapon or {}
                for _, weaponId in ipairs(carryWeapon) do
                    local weaponInfo = Me:getWeaponDataById(weaponId)
                    if weaponInfo then
                        weaponCidMap[weaponId] = weaponInfo.cid
                    end
                end
            end
        end
    end

	local startTime = os.time()
    -- 创建战斗开始信息
    ---@type BattleStartInfo
    local battleStartInfo = {
        level = levelCid,
        randomseed = startTime,
        heroInfoMap = heroInfoMap,            -- 英雄信息
        weaponCidMap = weaponCidMap,          -- 武器信息
        levelInfo = {},                -- 关卡进度信息
        formation = heroCidList,              -- 编队信息
        enterMeans = 0,         -- 进入方式
        startTime = os.date('%Y-%m-%d %H:%M:%S', startTime), -- 战斗开始时间
    }

	return battleStartInfo
end

---@param levelCid integer 关卡cid
---@param battleStartInfo BattleStartInfo 战斗开始信息
---@param needVerify boolean 是否需要验证
---@return integer?, BattleOrderReport?, ReportRoleDoSkillData[]? 战斗结果，战斗报告，简易验证数据
function BattleManager:LocalStartBattle(levelCid, battleStartInfo, needVerify)
	self:init()
	self._isLocalBattle = true
	self._verifyMode = false
	local heroInfoList = battleStartInfo.heroInfoMap
	self._heroInfoMap = heroInfoList
	self._weaponCidMap = battleStartInfo.weaponCidMap
	self._levelInfo = battleStartInfo.levelInfo
	-- 获取关卡配置
    local levelConfig = Config.GetPveLevelInfo(levelCid)
    if not levelConfig then
		BattleManager.es("BattleManager:LocalStartBattle levelConfig is nil for levelCid:", levelCid)
		return
	end
	self:setLevelConfig(levelConfig)
	self:initBattleTest(levelConfig)

	self._showMgr = nil
	self._isAutoMode = true
	
	local formationBlockList = self._map:getFormationRange(levelConfig)
	local formationList = battleStartInfo.formation
	for index, cid in ipairs(formationList) do
		local blockId = formationBlockList[index]
		local block = self._map:getBlockById(blockId)
		if not block then
			BattleManager.es("BattleManager:LocalStartBattle block is nil for blockId:", blockId, "listIndex:", index)
			break
		end
		local roleConfig = Config.GetCharacterInfo(cid)
		---@type LevelRoleData
		local roleData = {
			block = block,
			camp = GE.BattleCampType.Friend,
			cid = cid,
			isMonster = false,
			activeAIId = roleConfig.baseAi or 1002,
			unactiveAIId = 1001,
		}
		self._roleMgr:createRole(roleData)
	end
	self:setFormation()
	local r, _orderReport, simpleVerifyData = nil, nil, nil
	self._heroInfoMap = battleStartInfo.heroInfoMap
	self._weaponCidMap = battleStartInfo.weaponCidMap
	self._levelInfo = battleStartInfo.levelInfo
	self:battleStart(battleStartInfo, false, function (result, orderReport)
		BattleManager.ds("BattleManager:LocalStartBattle GameOver callback!!!!!!!!!!!!!!!!!!!!!!!!!!!", result, orderReport)
		r = result
		_orderReport = orderReport
		if not (needVerify == false) then
			r = self:verifyBattle(battleStartInfo, orderReport)
			for _, data in ipairs(self._simpleVerifyData) do
                self:simpleVerifyBattle(battleStartInfo, data)
            end
			self:clear()
		end
		simpleVerifyData = self._simpleVerifyData
	end)
	return r, _orderReport, simpleVerifyData
end

---进入战斗（发送开始战斗协议）
function BattleManager:enterBattle()
	local cfg = self:getLevelConfig()
	local level = cfg.id
	local friends = self._roleMgr:getRolesByCamp(GE.BattleCampType.Friend)
	local heroCidList = {}
	for _, hero in ipairs(friends) do
		table.insert(heroCidList, hero.cid)
	end
	self._formationList = heroCidList
	Me:battleStartReq(level, heroCidList, Me:getNowEnterMeans(), function (data)
        self:battleStart(data.battleStartInfo, false, function (result, orderReport)
            BattleManager.ds("BattleState:_enterBattle GameOver callback!!!!!!!!!!!!!!!!!!!!!!!!!!!",result,orderReport)
			local logList = {}
			local cloneData = self:getCloneRoleLogData()
			for _, d in pairs(cloneData) do
				logList[#logList + 1] = d
			end
			---@class BattleLogDataResp
			---@field autoSwitchCount integer 自动切换阵营次数
			---@field battleRoleLogData BattleRoleLogData[] 战斗埋点日志数据
			---@field useGMToWinBattle boolean 是否使用GM命令直接赢得战斗
			local d = {
				autoSwitchCount = self._autoSwitchChangeNum,
				battleRoleLogData = logList,
				useGMToWinBattle = self._isUseGMToWinBattle,
			}
			self._isUseGMToWinBattle = false
            Me:battleResultReq(orderReport, d, self._simpleVerifyData, function (resultData)
				resultData.orderReport = orderReport
				if LuaLogger.Enabled then
					BattleManager.ds("battleResultResp resultData", tablex.dump(resultData))
				end
                if self._endBattleEvent then
					self._endBattleEvent(resultData)
					self._endBattleEvent = nil
				end
            end)
        end)
    end)
end

---战斗开始
---@param startData BattleStartInfo 关卡id
---@param verifyMode boolean 验证模式（纯计算 无战斗场景）
---@param gameOverCallback fun(result:integer, orderReport:BattleOrderReport)? 回调函数
function BattleManager:battleStart(startData, verifyMode, gameOverCallback)
	-- BattleManager.ds("BattleManager:initMap", debug.traceback())
	self._verifyMode = verifyMode
	self._curRound = 1
	self._battleRandom = Random:new(startData.randomseed)
	if not verifyMode then
		self._heroInfoMap = startData.heroInfoMap
		self._roleMgr:initAllRoleServerData(startData.heroInfoMap)
	end
	startData.formation = self._formationList
	self._battleReporter:setBattleStartData(startData)
	self._roleMgr:checkInstanceTmpId()
	self._isBattleState = true
	self._finishFormation = true
	self:setGameOverCallback(gameOverCallback)
	self:setBattleState(GE.BattleState.BattleInit)

	if (verifyMode) then
		if self._orderMgr:shouldAutoStart() then
			self._orderMgr:nextOrder()
		end
	end
	-- self:orderTest()
end

function BattleManager:verifyBattleFail()
	BattleManager.es("BattleManager:verifyBattleFail 战斗验证失败!!!")
	self.gameResult = false
end

---初始化战斗中角色AI激活事件
---@param levelConfig PveLevelTable
function BattleManager:initBattleRoleAIActiveEvent(levelConfig)
	local aiActiveData = levelConfig.aiWakeCondition
	for _, data in ipairs(aiActiveData) do
		local tableId = data.Condition
		local groupId = data.group
		self._aiActiveMgr:RegisterAIEvent(tableId, groupId)
		local roleList = self._roleMgr:getRoleByGroupId(groupId)
		for _, role in ipairs(roleList) do
			role:SetActiveState(false)
		end
	end
end

---设置阵容信息到战报
function BattleManager:setFormation()
	local blockIdList = self._map:getFormationRange(self:getLevelConfig())
	local blockIdDic = {}
	for _, blockId in ipairs(blockIdList) do
		blockIdDic[blockId] = true
	end
	local roles = self._roleMgr:getRolesByCamp(GE.BattleCampType.Friend)
	---@type ReportHeroData[]
	local list = {}
	for _, role in ipairs(roles) do
		local roleBlock = role.block
		local data = {
			id = role.id,
			cid = role.cid,
			blockCid = roleBlock.cid,
			camp = role.camp,
			level = role.level,
			showLevel = role.showLevel,
			isMonster = role.isMonster,
			activeAIId = role.roleConfig.baseAi or 1002,
			unactiveAIId = 1001,
			isOnFormationBlock = blockIdDic[roleBlock.id] == true
		}
		table.insert(list, data)
	end
	self._battleReporter.battleReports.initData.heroInfoList = list
end

---设置游戏结束回调
---@param callback fun(result:integer, orderReport:OrderReport)? 回调函数
function BattleManager:setGameOverCallback(callback)
	---@type fun(result:integer, orderReport:OrderReport)? 游戏结束回调
	self.gameOverCallback = callback
end

---进入下回合
function BattleManager:_enterNextRound()
	self._curRound = self._curRound + 1
	self._aiActiveMgr:CheckAIEvent(GE.MonsterActiveEventType.FightRound)
	self:setBattleState(GE.BattleState.RoundStart)
end

---重置战斗信息
---@param histroyData HistroyData?
function BattleManager:resetBattleData(histroyData)
	if (not histroyData) then
		BattleManager.es("BattleManager:resetBattleData histroyData nil")
		return
	end
	self:clearAllPrepareSkillRange()
	self:resetBaseBattleData(histroyData.battleData)
	self._map:resetBaseMapData(histroyData.mapData)
	self._aiActiveMgr:setActiveGroupList(histroyData.roleAIActiveData)
	self:resetSummonRoleData(histroyData.summonRoleData)
	self._roleMgr:resetBaseRolesData(histroyData.mainRole, histroyData.rolesData)
	self._roleMgr:resetRoleBlockEffectAndBuff()
	self._battleEventMgr:ClearBattleEventShowObj()
	self._battleEventMgr:setBattleEventData(histroyData.eventData)
	self._battleEventMgr:RefreshBattleEventShowObj()
	self._showMgr:resetMapData()
	self._showMgr:resetWholeBattle()
	self._aiActiveMgr:resetPrepareUseSkillData(histroyData.prepareSkillData)
	self._aiActiveMgr:resetOnlyMoveRoleTargetBlockIds(histroyData.onlyMoveRoleTargetIndexData)
	self._aiActiveMgr:resetSkillInOrderSkillIds(histroyData.useSkillInOrderData)
	self:resetBattleRoleLogData(histroyData.BattleRoleLogData)
	self:resetRandomIndex(histroyData.curRandomIndex)
	self._curWeatherId = histroyData.curWeatherId
	self:setBeforeBackTranceSelectRoleId(histroyData.mainRole)
	self:setBattleState(GE.BattleState.OnBacktrace)
	self:resetFriendCampAllDamageValue(histroyData.friendCampDamageValue)
	self:resetRoleMgrTmpId(histroyData.curRoleTmpId)
	self:resetSimpleVerifyData(histroyData.simpleVerifyData)
	self._battleEventMgr:resetEventLevelTarget(histroyData.eventLevelTarget)
end

---@class BaseBattleData
---@field curRound integer
---@field curIndex integer
---@field timing BattleTiming

---重置基本战斗信息
---@param battleData BaseBattleData
function BattleManager:resetBaseBattleData(battleData)
	self._curRound = battleData.curRound
	self._roleMgr:resetRoundIndex(battleData.curIndex)
	self._battleTiming = battleData.timing
end

---获取基本战斗信息
---@return BaseBattleData
function BattleManager:getBaseBattleData()
---@type BaseBattleData
	local data = {
		curRound = self._curRound,
		curIndex = self._roleMgr:getRoundIndex(),
		timing = self._battleTiming
	}
	return data
end

---@class HistroyData
---@field mainRole integer 主要角色的id
---@field battleData BaseBattleData 战斗信息
---@field rolesData BaseRolesData 当前角色信息
---@field mapData MapData 当前地图信息
---@field roleAIActiveData table<integer, integer> 非操作角色AI激活信息
---@field eventData BattleHistoryEventData 战斗事件数据
---@field prepareSkillData table<integer, PrepareUseSkillData> 等待释放的准备类技能数据
---@field onlyMoveRoleTargetIndexData table<integer, integer[]> 仅移动角色的目标地格索引
---@field useSkillInOrderData table<integer, integer[]> 按顺序释放技能的角色技能索引
---@field summonRoleData table<integer, SummonData[]> 战斗中保存的召唤物数据
---@field BattleRoleLogData table<integer, BattleRoleLogData> 战斗埋点日志数据
---@field curRandomIndex integer 当前随机数索引
---@field curWeatherId integer 当前天气id
---@field friendCampDamageValue integer 友方阵营总伤害值
---@field curRoleTmpId integer 当前角色管理器创建角色的id（回溯时使用）
---@field simpleVerifyData ReportRoleDoSkillData[] 简易验证数据（用于验证战斗结果）
---@field eventLevelTarget table 事件胜负数据

---保存历史数据
function BattleManager:saveHistroyData()
	local isVerifyMode = self:isVerifyMode()
	local isLocalBattle = self:IsLocalBattle()
	if (isVerifyMode == true or isLocalBattle == true) then
		return
	end
	---@type HistroyData
	local histroyData = {
		mainRole = self._selectedRole and self._selectedRole.id,
		battleData = self:getBaseBattleData(),
		rolesData = self._roleMgr:getBaseRolesData(),
		mapData = self._map:getBaseMapData(),
		roleAIActiveData = self._aiActiveMgr:getActiveGroupList(),
		eventData = self._battleEventMgr:getBattleEventData(),
		prepareSkillData = self._aiActiveMgr:getClonePrepareUseSkillData(),
		onlyMoveRoleTargetIndexData = self._aiActiveMgr:getOnlyMoveRoleCurTargetBlockIds(),
		useSkillInOrderData = self._aiActiveMgr:getSkillInOrderCurSkillIds(),
		summonRoleData = self:GetSummonRoleData(),
		BattleRoleLogData = self:getCloneRoleLogData(),
		curRandomIndex = self:getRandomIndex(),
		curWeatherId = self._curWeatherId,
		friendCampDamageValue = self:getFriendCampAllDamageValue(),
		curRoleTmpId = self._roleMgr:getCurRoleTmpId(),
		simpleVerifyData = self:getCloneSimpleVerifyData(),
		eventLevelTarget = self._battleEventMgr:getCloneEventLevelTarget(),
	}
	self._historyMgr:addHistoryData(self._curRound, histroyData)
end

function BattleManager:setUIDragging(isDrag)
	self._uiDragging = isDrag
end

--判断是否点击在ui上
function BattleManager:isPointerOverUIObject()
	if (not EventSystem.current) then
		return false
	end
	local eventDataCurrentPosition = UnityEngine.EventSystems.PointerEventData(EventSystem.current)
	eventDataCurrentPosition.position = Input.mousePosition
	local results = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	EventSystem.current:RaycastAll(eventDataCurrentPosition, results)
	return results.Count > 0
end

---是否处于布阵地格中（通常用于判断是否是该场战斗强制上阵的角色，不在布阵地格内的角色视为强制上阵）
---@param blockId integer 地格ID
---@return boolean
function BattleManager:isBlockInFormationRange(blockId)
	return tablex.contains(self._formationRangeIdList, blockId)
end

---点击地块
---@param block BattleBlock 地块
---@param orderPlay boolean? 是否播放点击音效
---@return ClickBlockResultType
function BattleManager:clickBlock(block, orderPlay)
	if (self._inBacktrace) then
		return GE.ClickBlockResultType.None
	end

	--判断格子是否在当前地图有效范围内
	if (self._map:getBlockId(block.col, block.row) == -1) then
		return GE.ClickBlockResultType.None
	end
	-- local tData =  block.terrainCfgData

	local blockId = block.id
	if not(self._lastSkillSelectBlockId) and (self._isActionState and self._selectedRole and tablex.any(self._chooseRangeIdList, function(i) return i.blockId == blockId end)) then
		self._skillRangeIdList = {}
		local skillConfig = Config.GetSkillInfo(self._selectedRole.selectedSkill)
		-- self._selectedRole:faceToBlock(block)
        -- LuaLogger.es("self._selectedRole.selectedSkill", self._selectedRole.selectedSkill)
        local isPass = self._skillMgr:checkBlockRoleCanBeSelect(skillConfig, self._selectedRole, block)
		local operateDirection = skillConfig.skillOperateType == GE.SkillOperateType.Direction
		if isPass then
			local block2 = nil
            local skillSelectType = skillConfig.rangeSelectType
			if operateDirection then
				skillSelectType = GE.SkillRangeType.SelectDirction
                block2 = self._map:getChooseRangeSourceBlock(blockId)
				self._selectedRole:setSkillDir(block)
			end
            self._selectedRole:faceToBlock(block)
            local skillEffectRange = self._skillMgr:GetSkillEffectRangeByRole(skillConfig, self._selectedRole)
            self._skillRangeIdList = self._map:getDiffuseRange(skillSelectType, block, skillEffectRange, block2)
		end

		if (#self._skillRangeIdList > 0) then
			local targetList = {}
			for _, blockData in ipairs(self._skillRangeIdList) do
				table.insert(targetList, blockData.blockId)
			end
			self._selectedRole:setTarget(targetList, block)
			---@type boolean 是否处于选择技能目标状态
			self._chooseTargetState = true
			self:setLastSkillSelectBlockId(blockId)
			return GE.ClickBlockResultType.SelectSkillTarget
		end
	end

	---验证/回放模式取消点击释放技能（由 RoleDoSkill 指令触发）
	if (self._chooseTargetState and self._verifyMode == false and not self._replayMode) then
		if self._lastSkillSelectBlockId == block.id then
			---判断二次扩散是否有目标在范围内
			local targetList = self._selectedRole:getCurSkillTarget()
			if next(targetList) then
				self._selectedRole:doAction(GE.ActionType.DoSkill)
				self._lastSkillSelectBlockId = nil
			else
				UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_BattleNoTarget)
			end
		end
		return GE.ClickBlockResultType.SelectSKillEffectTarget
	end

	return GE.ClickBlockResultType.SelectBlock
    -- LuaLogger.ds("地格Effect列表：", tablex.dump(block:getEffectGroup()))
end

function BattleManager:getSkillTargets()
	local skillTargets = self._selectedRole:getCurSkillTarget()
	return skillTargets
end

---@param blockRole BattleRole
function BattleManager:showRoleActionRange(blockRole)
	self:resetAndStopActionState(true)
	-- blockRole.selectedSkill = blockRole.normalSkill
	local chooseRangeIdList = blockRole:getRoleAtkRange()
	self:refreshChooseRange(chooseRangeIdList)
end

---是否敌对阵营
---@param role1 BattleRole 角色1
---@param role2 BattleRole	角色2
---@return boolean
function BattleManager:isEnemyCamp(role1, role2)
	return self._roleMgr:isEnemyCamp(role1, role2)
end

---设置选中角色
---@param role BattleRole?
function BattleManager:setSelectRole(role)
	local lockRole = self._roleMgr:getLockRole()
	if lockRole then
		role = lockRole
	end
	self._selectedRole = role
end

---是否处于当前选中状态
---@param selectRole BattleRole	角色
---@param isEnemyCamp boolean	是否敌对阵营
---@return boolean
function BattleManager:compareRoleskillSelectState(selectRole, isEnemyCamp)
	if not selectRole then
		return false
	end
	local state = isEnemyCamp and GE.SkillSelectType.OnlyEnemy or GE.SkillSelectType.OnlyFriend
    local roleState = selectRole:getSkilSelecctState()
    return roleState == GE.SkillSelectType.None or roleState == state
end

---@param role BattleRole
function BattleManager:refreshRoleActionState(role, isInit, cancelAnim)
	if (isInit) then
		self:setEngagedInBattle(false)
	end
	local selectRoleId = -1
	if self._selectedRole then
		selectRoleId = self._selectedRole.id
	end
	self:resetAndStopActionState(role.id ~= selectRoleId)
	local movePowType = GE.MovePowerType.Normal
	if (self._roleMgr:getLockRole() ~= nil) then
		movePowType = self._tmpMovePowType
	end
	self:refreshRoleActionType(role, GE.RoleActionType.Normal, movePowType, cancelAnim)
	role:enterActionState(isInit)
end

---@param role BattleRole 角色
---@param actionType RoleActionType 行动类型
---@param movePowType MovePowerType 移动力类型
function BattleManager:refreshRoleActionType(role, actionType, movePowType, cancelAnim)
	self._tmpMovePowType = movePowType
	self:setSelectRole(role)
	self._actionAgainType = actionType
	local roleId = self._selectedRole.id
	self._lastSelectRoleID = self._selectedRole.id
	self:setBeforeBackTranceSelectRoleId(roleId)
	self._moveRangeIdList = self._selectedRole:getRoleMoveRange()
	local chooseRangeIdList = {}
	if (actionType == GE.RoleActionType.Normal) then
		chooseRangeIdList = self._selectedRole:getRoleAtkRange()
	end
	self:refreshChooseRange(chooseRangeIdList, true, false)
	self._isActionState = true
end

---@param eventType ClientBattleShowType
---@param callback function
function BattleManager:registerClientShowEvent(eventType, callback)
	if not self.clientBattleShowEventDic then
		self.clientBattleShowEventDic = {}
	end
	self.clientBattleShowEventDic[eventType] = callback
end

---@param eventType ClientBattleShowType
---@param data table?
function BattleManager:callClientShowEvent(eventType, data)
	if self.clientBattleShowEventDic and self.clientBattleShowEventDic[eventType] then
		self.clientBattleShowEventDic[eventType](data)
	end
end

function BattleManager:setInBacktrace(value)
	self._inBacktrace = value
end

function BattleManager:setBacktraceTimes(value)
	self._backtraceTimes = value
end

function BattleManager:getBacktraceTimes()
	return self._backtraceTimes
end

---@param clearSelectArea boolean? 是否清除选择区域
function BattleManager:stopActionState(clearSelectArea)
	self._chooseTargetState = false
	self._lastSkillSelectBlockId = nil
	self:removeMoveRange()
	self:removeSkillRange()
	self._isActionState = false
end

---回合结束时检测所有角色身上的buff状态
function BattleManager:checkAllRoleBuffState()
	local roleList = self._roleMgr:getRolesList()
	for _, v in ipairs(roleList) do
        v.buffController:checkBuffsState()
	end
end

function BattleManager:resetAndStopActionState(isResetPos, clearSelectRole)
	if (isResetPos and self._selectedRole) then
		---防止出现当前选择角色不在场上的情况出现
		local roleId = self._selectedRole.id
		local role = self._roleMgr:getRole(roleId)
		if role then
			role:resetPos()
		end
	end
	self:stopActionState()
	if clearSelectRole ~= false then
		self:setSelectRole(nil)
	end
end

function BattleManager:getChooseRangeSourceBlock(targetBlock)
	return self._map:getChooseRangeSourceBlock(targetBlock)
end

function BattleManager:removeMoveRange()
	self._moveRangeIdList = {}
	self._chooseRangeIdList = {}
end

---刷新行动范围
---@param chooseRangelist BlockData[]
---@param isActionRole boolean?
---@param isSelectSkill boolean?
function BattleManager:refreshChooseRange(chooseRangelist, isActionRole, isSelectSkill)
	-- BattleManager.ds("BattleManager:refreshChooseRange chooseRangelist", #chooseRangelist)
	if (isActionRole) then
		self._chooseRangeIdList = chooseRangelist
	end
	if (isSelectSkill) then
		self._chooseTargetState = true
	end
end

---刷新技能范围
---@param skillRangeList BlockData[]
function BattleManager:refreshSkillRange(skillRangeList)
	self._chooseTargetState = true
	self._chooseRangeIdList = skillRangeList
end

function BattleManager:removeSkillRange()
	self._skillRangeIdList = {}
end

function BattleManager:checkWinLose()
	if (self._showMgr) then
		self._showMgr:refreshBattleMainPanel()
	end
	return self._levelTargetsMgr:checkWinLose()
end

---@param type BattleOrderType
function BattleManager:addBattleOrder(type, data)
	if (self:isVerifyMode()) then
		return
	end
	self._battleReporter:addOrder(type, data)
end

---是否是验证战斗
function BattleManager:isVerifyMode()
	return self._verifyMode
end

function BattleManager:isReplayMode()
	return self._replayMode == true
end

---是否是服务器本地战斗
function BattleManager:IsLocalBattle()
	return self._isLocalBattle
end

function BattleManager:isSimpleVerify()
	return self._simpleVerify
end

function BattleManager:isBattleState()
	return self._isBattleState
end

function BattleManager:getSkillManager()
	return self._skillMgr
end
function BattleManager:getRoleManager()
	return self._roleMgr
end

---@param showMgr BattleShowManager
function BattleManager:setShowManager(showMgr)
	self._showMgr = showMgr
end

function BattleManager:getShowManager()
	return self._showMgr
end

function BattleManager:getReporter()
	return self._battleReporter
end
function BattleManager:getMap()
	return self._map
end
function BattleManager:getLevelTargetsManager()
	return self._levelTargetsMgr
end

function BattleManager:getHistoryManager()
	return self._historyMgr
end

function BattleManager:getBattleRoleAIManager()
	return self._aiActiveMgr
end

function BattleManager:getBattleEventManager()
	return self._battleEventMgr
end

function BattleManager:getCurrentRound()
	return self._curRound
end

function BattleManager:getMaxRounds()
	return self._maxRounds
end

---@param blockId integer
function BattleManager:getBlockById(blockId)
	return self._map:getBlockById(blockId)
end

function BattleManager:getBlock(col, row)
	return self._map:getBlock(col, row)
end

function BattleManager:getBlockId(col, row)
	return self._map:getBlockId(col, row)
end

function BattleManager:getBlockByCid(cid)
	return self._map:getBlockByCid(cid)
end

function BattleManager:getTiming()
	return self._battleTiming
end

function BattleManager:getLevelId()
	return self._levelId
end

function BattleManager:setLevelId(levelId)
	self._levelId = levelId
end

---@param levelConfig PveLevelTable
function BattleManager:setLevelConfig(levelConfig)
	self._levelConfig = levelConfig
	local levelSkills = levelConfig.levelSkill
	self._levelSkillList = {}
	self._weeklyBossLevelSkillList = {}
	if levelSkills and next(levelSkills) then
		for _, value in ipairs(levelSkills) do
			local type = value.type
			local skillIds = value.skill
			if not self._levelSkillList[type] then
				self._levelSkillList[type] = {}
			end
			local l = self._levelSkillList[type]
			for _, skillId in ipairs(skillIds) do
				l[#l + 1] = skillId
			end
		end
	end
	self._curWeatherId = levelConfig.Weather or 0
end

---@return PveLevelTable
function BattleManager:getLevelConfig()
	return self._levelConfig
end

---@param skillList integer[]
---@param skillId integer
function BattleManager:addLevelSkill(skillList, skillId)
	if skillId <= 0 then
		return
	end
	if tablex.contains(skillList, skillId) then
		BattleManager.es("BattleManager:addLevelSkill skill already in list, skillId:", skillId)
		return
	end
	skillList[#skillList + 1] = skillId
end

---@param camp BattleCampType
---@return integer[]
function BattleManager:getLevelSkillList(camp)
	---@type integer[]
	local r = {}
	local function appendSkillList(skillList)
		if not skillList then
			return
		end
		for _, skillId in ipairs(skillList) do
			r[#r + 1] = skillId
		end
	end
	if camp == GE.BattleCampType.Friend or camp == GE.BattleCampType.FriendNPC then
		appendSkillList(self._levelSkillList[1])
		appendSkillList(self._weeklyBossLevelSkillList[1])
	elseif camp == GE.BattleCampType.Enemy then
		appendSkillList(self._levelSkillList[2])
		appendSkillList(self._weeklyBossLevelSkillList[2])
	end
	appendSkillList(self._levelSkillList[3])
	appendSkillList(self._weeklyBossLevelSkillList[3])
	return r
end

---@param tagList integer[]
function BattleManager:initWeeklyBossTags(tagList)
	---@type integer[] 周常BOSS标签列表
	self._allWeeklyBossTag = tagList
end

function BattleManager:RefreshWeeklyBossTags()
	local passTagList = {}
	---@type number 周常BOSS本分数加成值
	self._weeklyBossScoreAddition = 0
	self._weeklyBossLevelSkillList = {}
	for _, tagId in ipairs(self._allWeeklyBossTag) do
		local config = Config.GetPveBossBattleEffectInfo(tagId)
		local isPass = true
		if config then
			local effectList = config.Effect or {}
			for _, effectData in ipairs(effectList) do
				local effectDataType = effectData[1]
				if effectDataType == GE.WeeklyBossEffectType.ShipAttribute then
					local roleList = self._roleMgr:getRolesByCamp(GE.BattleCampType.Friend)
					local limitShipType = effectData[2]
					local limitNum = effectData[4]
					local passNum = 0
					for _, role in ipairs(roleList) do
						if role.restraintType == limitShipType then
							passNum = passNum + 1
						end
					end
					local r = CommonLogic.CompareTwoValue(passNum, limitNum, effectData[3])
					if r == false then
						isPass = false
						break
					end
				else
					local skillId = effectData[2]
					if skillId and skillId > 0 then
						if effectDataType == GE.WeeklyBossEffectType.FriendCampSkill then
							if not self._weeklyBossLevelSkillList[1] then
								self._weeklyBossLevelSkillList[1] = {}
							end
							local campSkillList = self._weeklyBossLevelSkillList[1]
							self:addLevelSkill(campSkillList, skillId)
						elseif effectDataType == GE.WeeklyBossEffectType.EnemyCampSkill then
							if not self._weeklyBossLevelSkillList[2] then
								self._weeklyBossLevelSkillList[2] = {}
							end
							local campSkillList = self._weeklyBossLevelSkillList[2]
							self:addLevelSkill(campSkillList, skillId)
						elseif effectDataType == GE.WeeklyBossEffectType.AllCampSkill then
							if not self._weeklyBossLevelSkillList[3] then
								self._weeklyBossLevelSkillList[3] = {}
							end
							local campSkillList = self._weeklyBossLevelSkillList[3]
							self:addLevelSkill(campSkillList, skillId)
						end
					end
				end
			end

			if isPass == true then
				passTagList[tagId] = true
				self._weeklyBossScoreAddition = self._weeklyBossScoreAddition + config.ScoreAddition
			end
		end
	end
	return passTagList
end

function BattleManager:getAllWeeklyBossTag()
	return self._allWeeklyBossTag
end

function BattleManager:getweeklyBossScoreAddition()
	return self._weeklyBossScoreAddition
end

function BattleManager:resetFriendCampAllDamageValue(value)
	self._friendCampAllDamageValue = value
end

function BattleManager:resetRoleMgrTmpId(tmpId)
	self._roleMgr:setCurRoleTmpId(tmpId)
end

---本局内友方阵营总伤害值
function BattleManager:setFriendCampAllDamageValue(value)
	self._friendCampAllDamageValue = self._friendCampAllDamageValue + value
	if self._levelConfig.typemain == GE.LevelTypeMain.WeeklyBoss then
		local totalScore = math.floor(self._friendCampAllDamageValue * (1 + self._weeklyBossScoreAddition))
		self._battleReporter:addReport(GE.BattleReportType.BossScoreChange, {
			totalValue = totalScore
		})
	end
end

function BattleManager:getFriendCampAllDamageValue()
	local r = self._friendCampAllDamageValue
	return r
end

---@param config PveBossBattleLevelTable 周常BOSS关卡配置
function BattleManager:setAdvantageousRoleList(config)
	local roleIds = config.AdvantageRole
	local effectIds = config.AdvantageRoleEffect
	if effectIds and tablex.next(effectIds) then
		self._advantageousRoleEffectIds = effectIds
	else
		return
	end
	if (roleIds and tablex.next(roleIds)) then
		for _, roleId in ipairs(roleIds) do
			self._advantageousRoleList[roleId] = 1
		end
	end
end

---获取优势角色效果列表
---@param roleId integer 角色CID
---@return integer[]?
function BattleManager:GetAdvantageousRoleEffectList(roleId)
	if not (tablex.next(self._advantageousRoleList) and tablex.next(self._advantageousRoleEffectIds)) then
		return nil
	end

	if self._advantageousRoleList[roleId] then
		return self._advantageousRoleEffectIds
	end
end

function BattleManager:getSelectedRole()
	return self._selectedRole
end

function BattleManager:getMoveRangeIdList()
	return self._moveRangeIdList
end

function BattleManager:getChooseRangeIdList()
	return self._chooseRangeIdList
end

function BattleManager:getActionType()
	return self._actionAgainType
end

function BattleManager:getMoveType()
	return self._tmpMovePowType
end

function BattleManager:getBattleState()
	return self._battleState
end

function BattleManager:getIsActionState()
	return self._isActionState
end

---@param timing BattleTiming
function BattleManager:setTiming(timing)
	self._battleTiming = timing
	if timing ~= GE.BattleTiming.PlayAVGEnd then
		self._roleMgr:UpdateAllRoleBuff()
	end
	if timing == GE.BattleTiming.RoleHpChange then
		---检测中破大破效果
		self._roleMgr:checkAllRoleOnHPChangeEffect()
	else
		if not (timing == GE.BattleTiming.SwitchCamp and self._isActionCampChange == false) then
			self._battleEventMgr:battleEventTrigger(timing)
		end
	end
	if (self._showMgr) then
		self._battleEventMgr:playEventPerformance()
	end
end

---获取回合信息
---@return RoundInfo 回合信息
function BattleManager:getRoundInfo()
	---@class RoundInfo
	---@field round integer 回合数
	---@field index integer 回合内行动序号
	local roundInfo = {
		round = self._curRound,
		index = self._roleMgr:getRoundIndex()
	}
	return roundInfo
end

-- ---获取战斗随机类
-- ---@return Random _battleRandom Random
-- function BattleManager:getRandom()
-- 	return self._battleRandom
-- end

---测试代码，不要使用
-- function BattleManager:resetRandom()
-- 	self._randomCount = 0
-- 	self._curRandomIndex = 1
-- 	self._randomNumList = {}
-- 	self._battleRandom = Random:new(12)
-- end

---获取一个随机整数值
---@param min integer 最小值
---@param max integer 最大值
---@param getRandomNumId integer? 获取随机数的id，主要用于验证战斗时获取固定的随机数
---@return integer 随机数
function BattleManager:getRandomNum(min, max, getRandomNumId)
	local num = 0
	if self._curRandomIndex > self._randomCount then
		num = self._battleRandom:next()
		self._randomCount = self._randomCount + 1
		self._randomNumList[self._randomCount] = num
	else
		num = self._randomNumList[self._curRandomIndex]
	end
	getRandomNumId = getRandomNumId or 0
	if (self._verifyMode or self._replayMode) and not GV.IsServer and tablex.next(self._getRandomNumIdList) then
		-- local verifyIdNum = self._getRandomNumIdList[self._curRandomIndex] or 0
		-- if verifyIdNum ~= getRandomNumId then
		-- 	BattleManager.es("BattleManager:getRandomNum 验证获取战斗随机数顺序不匹配", self._curRandomIndex, verifyIdNum, getRandomNumId)
		-- end
	else
		self._getRandomNumIdList[self._curRandomIndex] = getRandomNumId
	end
	local r = math.floor(num * (max - min + 1) + min)
	self._curRandomIndex = self._curRandomIndex + 1
	return r
end

---重置随机数索引
---@param index integer
function BattleManager:resetRandomIndex(index)
	self._curRandomIndex = index or 1
end

function BattleManager:getRandomIndex()
	return self._curRandomIndex
end

function BattleManager:getCurWeatherId()
	return self._curWeatherId
end

---设置游戏状态
---@param state BattleStateEnum
function BattleManager:setBattleState(state)
	local stateQueue = self._pendingBattleStates
	if not stateQueue then
		stateQueue = {}
		self._pendingBattleStates = stateQueue
	end
	stateQueue[#stateQueue + 1] = state
	if self._isDispatchingBattleState then
		return
	end
	if (not self._battleStateEvent) then
		self:initBattleStateEvent()
	end

	self._isDispatchingBattleState = true
	while #stateQueue > 0 do
		local nextState = stateQueue[1]
		tablex.removeproxy(stateQueue, 1)
		self._battleState = nextState

		local stateHandler = self._battleStateEvent[nextState] or self._battleStateEvent["default"]
		stateHandler()

		local funList = self._setBattleStateEvent[nextState]
		if funList and next(funList) then
			for _, event in ipairs(funList) do
				event()
			end
		end
	end
	self._pendingBattleStates = stateQueue
	self._isDispatchingBattleState = false
end

---@param isAuto boolean
function BattleManager:setAutoMode(isAuto)
	self._isAutoMode = isAuto
end

function BattleManager:onChangeAutoMode()
	self._autoSwitchChangeNum = self._autoSwitchChangeNum + 1
end

function BattleManager:endCurRound()
	self._isEndCurRound = true
	self._roleMgr:campStandup()
end

function BattleManager:isEndCurRound()
	return self._isEndCurRound
end

function BattleManager:setGameResult(result)
	LuaLogger.ds("BattleManager:setGameResult", result)
	if (self:isVerifyMode()) then
		self.gameResult = result
	else
		-- 失败或非三星胜利时，允许客户端拦截结算并询问是否回溯
		local needConfirm = not result
		if result then
			local levelConfig = self:getLevelConfig()
			local star = self._battleEventMgr:getBattleStar()
			if levelConfig and levelConfig.baseStar >= 3 and star < 3 then
				needConfirm = true
			end
		end
		if needConfirm and self._loseConfirmHandler and self._loseConfirmHandler(result) then
			self._pendingGameResult = result
			return
		end
		self:_finalizeGameResult(result)
	end
end

---写入战报结果并进入结算状态
---@param result boolean
function BattleManager:_finalizeGameResult(result)
	self._battleReporter:setResult(result and GE.BattleResultType.Win or GE.BattleResultType.Lose)
	self._battleReporter:setResultData(self._battleEventMgr:getToServerEventSaveData())
	self.gameResult = result
	self._pendingGameResult = nil
	self:setBattleState(GE.BattleState.BattleResult)
end

---注册战斗失败/非三星确认回调，返回 true 时延迟进入结算
---@param handler fun(isWin:boolean?):boolean?
function BattleManager:registerLoseConfirmHandler(handler)
	self._loseConfirmHandler = handler
end

---继续进入战斗结算
function BattleManager:proceedBattleResult()
	local result = self._pendingGameResult
	if result == nil then
		result = false
	end
	self:_finalizeGameResult(result)
end

---清除待结算的失败结果，用于进入回溯后继续战斗
function BattleManager:clearPendingLoseResult()
	self.gameResult = nil
end

---清除待确认的结算结果（确认回溯后战斗继续时调用）
function BattleManager:clearPendingGameResult()
	self._pendingGameResult = nil
end

---回退历史数据的回调，计算所有角色的移动范围
function BattleManager:confirmBackTrace()
	self._roleMgr:confirmResetRoleData()
end

---取消回退时，不应保存战斗历史数据，添加一个flag阻挡保存
function BattleManager:cancelBackTrace()
	self._isCancelBackTarce = true
end

---当前回合有交互行动的角色
function BattleManager:setCureentTurnActionRoleId(roleId)
	self._actionRoleList[roleId] = 1
end

function BattleManager:getCureentTurnActionRoleId()
    return self._actionRoleList
end

---设置技能上次选择释放的地格ID
function BattleManager:setLastSkillSelectBlockId(blockId)
	if self._verifyMode then
		return
	end
	self._lastSkillSelectBlockId = blockId
end

function BattleManager:clearActionRoleList()
    self._actionRoleList = {}
end

---@return BattleRole[]
function BattleManager:getAllHasTagRole(needFindDefeat)
	local r = {}
	local listIndex = 1
	local roleList = self._roleMgr:getRolesList()
	if needFindDefeat == true then
		local defeatRoleList = self._roleMgr:getDefeatRolesList()
		roleList = tablex.combine(roleList, defeatRoleList)
	end
	for _, role in pairs(roleList) do
		local roleTagList = role:GetTagList()
		if next(roleTagList) then
			r[listIndex] = role
			listIndex = listIndex + 1
		end
	end
	return r
end

---刷新所有行动角色的行动范围
function BattleManager:checkActionRoleCalculateActionRange()
	local roleList = self._roleMgr:getRolesList()
	for _, role in pairs(roleList) do
		role:calculateActionRange()
	end
end

---设置发生战斗
---@param value boolean
function BattleManager:setEngagedInBattle(value)
	self._isEngagedInBattle = value
end

---是否发生战斗（当前行动）
---@return boolean _isEngagedInBattle
function BattleManager:isEngagedInBattle()
	return self._isEngagedInBattle
end

---验证战斗
---@param startData BattleStartInfo 战斗开始数据
---@param orderReport BattleOrderReport 战报
---@param randomNumList integer[]? 验证战斗时使用的随机数列表,仅本地日志存在
---@param simpleVerifyData ReportRoleDoSkillData[]? 简单验证战斗时的技能释放数据列表
---@return boolean 战斗结果
function BattleManager:verifyBattle(startData, orderReport, randomNumList, simpleVerifyData)
	self:prepareVerifyBattle(startData, orderReport, nil, randomNumList, simpleVerifyData)

	BattleManager.ds("BattleManager:verifyBattle 战斗结果：", self.gameResult)
	return self.gameResult
end

---@param startData BattleStartInfo 战斗开始数据
---@param orderReport BattleOrderReport 战报
---@param options table?
---@param randomNumList integer[]?
---@param simpleVerifyData ReportRoleDoSkillData[]? 简单验证战斗时的技能释放数据列表
function BattleManager:prepareVerifyBattle(startData, orderReport, options, randomNumList, simpleVerifyData)
	self._replayMode = options and options.clientReplay == true or false
	if self._replayMode then
		self._verifyMode = false
	else
		self:clear()
		self._verifyMode = true
	end
	self._battleStartInfo = startData
	self:SetSimpleVerifyDataByVerifyData(simpleVerifyData)
	local levelId = startData.level
	local levelConfig = Config.GetPveLevelInfo(levelId)
	self:initWeeklyBossTags(startData.weeklyBossTagList or {})
	local bossPveLevelId = startData.weeklyBossPveLevelId or 0
	if bossPveLevelId > 0 then
		local bossPveConfig = Config.GetPveBossBattleLevelInfo(bossPveLevelId)
		if bossPveConfig then
			self:setAdvantageousRoleList(bossPveConfig)
		end
	end
	self._heroInfoMap = startData.heroInfoMap
	self._weaponCidMap = startData.weaponCidMap
	self._levelInfo = startData.levelInfo
	self:setLevelConfig(levelConfig)
	self:initBattleTest(levelConfig)
	local coveSkillList = orderReport.initData.coveSkillList or {}
	for _, skillData in ipairs(coveSkillList) do
		if not self._levelSkillList[skillData.type] then
			self._levelSkillList[skillData.type] = {}
		end
		local skilList = self._levelSkillList[skillData.type]
		skilList[#skilList + 1] = skillData.skillId
	end
	self._battleReporter:loadOrderReport(orderReport)
	self._orderMgr:initOrders(self._battleReporter:getOrders(), self, options)
	-- self:setFormation()
	local reportHeroList = self._battleReporter.battleReports.initData.heroInfoList
	self._roleMgr:createReportRoles(reportHeroList)
	self:RefreshWeeklyBossTags()
	self._getRandomNumIdList = randomNumList or {}
	if self._verifyMode then
		self:battleStart(startData, true, nil)
	end
end

function BattleManager:getOrderManager()
	return self._orderMgr
end

function BattleManager:stepVerifyBattleOrder()
	if not self._orderMgr then
		return false
	end
	return self._orderMgr:nextOrder()
end

---简单验证战斗（只验证战斗结果是否一致）
---@param startData BattleStartInfo 战斗开始数据
---@param doSkillData ReportRoleDoSkillData 角色释放技能数据
function BattleManager:simpleVerifyBattle(startData, doSkillData)
	self:clear()
	self._verifyMode = true
	self._simpleVerify = true
	local levelId = startData.level
	local levelConfig = Config.GetPveLevelInfo(levelId)
	self:setLevelConfig(levelConfig)
	self._map:initMap(levelConfig, true)
	self._showMgr = nil
	self._heroInfoMap = startData.heroInfoMap
	self._weaponCidMap = startData.weaponCidMap
	self._levelInfo = startData.levelInfo

	local targetCid = doSkillData.targetCId
	local targetRole = nil
	---@type LevelRoleData
	local data = {
		camp = GE.BattleCampType.Enemy,
		cid = targetCid,
		isMonster = true,
		level = doSkillData.targetLevel,
	}
	targetRole = self._roleMgr:createRole(data)
	if not targetRole then
		BattleManager.es("BattleManager:simpleVerifyBattle can not find targetRole", targetCid)
		return false
	end

	---@type LevelRoleData
	local roleData = {
		cid = doSkillData.cid,
		camp = GE.BattleCampType.Friend,
		isMonster = false,
	}
	local sourceRole = self._roleMgr:createRole(roleData)
	sourceRole:setHpValue(doSkillData.curSourceHp)
	targetRole:setHpValue(doSkillData.curTargetHp)
	local buffHandler = self._skillMgr:getBuffHandler()
	local buffIdList = doSkillData.sourceBuffIdList
	for _, buffId in ipairs(buffIdList) do
		local buffConfig = Config.GetBuffInfo(buffId)
		local buff = buffHandler:createBuff(buffId, 1, {}, sourceRole, buffConfig)
		sourceRole:addBuff(buff)
	end
	buffIdList = doSkillData.targetBuffIdList
	for _, buffId in ipairs(buffIdList) do
		local buffConfig = Config.GetBuffInfo(buffId)
		local buff = buffHandler:createBuff(buffId, 1, {}, targetRole, buffConfig)
		targetRole:addBuff(buff)
	end
	local skillCfg = Config.GetSkillInfo(doSkillData.skillId)
	local terrainId = doSkillData.terrainId
	local terrainConfig = Config.GetMapTerrainTypeInfo(terrainId)
	local damageData = self._skillMgr:getDamageData(sourceRole, targetRole, skillCfg, nil, doSkillData.isCrit, terrainConfig)
	local hitData, logData = targetRole:getHitData(damageData)
	local r = hitData.dmgValue == doSkillData.damageValue
	if not r then
		LuaLogger.es("BattleManager:simpleVerifyBattle verify fail", hitData.dmgValue, doSkillData.damageValue)
		-- LuaLogger.es("BattleManager:simpleVerifyBattle verify fail logData", tablex.dump(logData))
	end
	return r
end

---@param data ReportRoleDoSkillData
function BattleManager:setSimpleVerifyData(data)
	if self._verifyMode or self._simpleVerify then
		return
	end
	self._simpleVerifyData[#self._simpleVerifyData + 1] = data
end

function BattleManager:resetSimpleVerifyData(verifyData)
	self._simpleVerifyData = verifyData
end

function BattleManager:SetSimpleVerifyDataByVerifyData(verifyData)
	self._simpleVerifyData = verifyData or {}
	self._checkIndex = 1
end

function BattleManager:getCloneSimpleVerifyData()
	return tablex.clone(self._simpleVerifyData)
end

---@param data ReportRoleDoSkillData
function BattleManager:checkSimpleVerifyData(data)
	if not self._simpleVerifyData then
		return false
	end
	local checkData = self._simpleVerifyData[self._checkIndex]
	if not checkData then
		return false
	end
	if data.cid ~= checkData.cid or data.targetCId ~= checkData.targetCId or
		data.damageValue ~= checkData.damageValue or data.curSourceHp ~= checkData.curSourceHp or
		data.curTargetHp ~= checkData.curTargetHp then
		LuaLogger.es("BattleManager:checkSimpleVerifyData verify fail", tablex.dump(data), tablex.dump(checkData))
		return false
	end
	self._checkIndex = self._checkIndex + 1
	return true
end

---当前阵营缺少行动角色空过的回调
function BattleManager:AfterActionState()
    self:setBattleState(GE.BattleState.AfterRoleAction)
end

---获取角色服务器数据
---@param cid integer 角色cid
---@return BattleHeroInfo? 角色服务器数据
function BattleManager:getHeroServerData(cid)
	local r = nil
	if not self._heroInfoMap then
		self._heroInfoMap = {}
	end
	if (not self._verifyMode and not self._isLocalBattle and not self._heroInfoMap[cid]) then
		r = Me:getPlayerHero(cid)
		self._heroInfoMap[cid] = r
	elseif self._heroInfoMap then
		r = self._heroInfoMap[cid]
	end
	return r
end

---获取所有上阵角色服务器数据 前端用
---@return HeroInfo[] 角色服务器数据
function BattleManager:getHeroDataAll()
	return self._heroInfoMap or {}
end

---获取关卡信息
---@return PveLevelInfo? 关卡信息
function BattleManager:getLevelInfo()
	return self._levelInfo
end

---获取武器服务器数据
---@param id integer 武器id
---@return integer? 武器cid
function BattleManager:getWeaponCidById(id)
	if id == nil or id == 0 then
		return nil
	end
	if (not self._verifyMode and not self._isLocalBattle and (not self._weaponCidMap or not self._weaponCidMap[id])) then
		local weaponData = Me:getWeaponDataById(id)
        if weaponData then
            return weaponData.cid
		else
			return nil
        end
	end
	if (self._weaponCidMap == nil) then
		self._weaponCidMap = {}
	end
	return self._weaponCidMap[id]
end

---重置战斗日志数据
---@param data table<integer, BattleRoleLogData>
function BattleManager:resetBattleRoleLogData(data)
	self._battleRoleLogData = data
end

---@return table<integer, BattleRoleLogData>
function BattleManager:getCloneRoleLogData()
	return tablex.clone(self._battleRoleLogData)
end

---@param roleID integer 角色ID
---@return BattleRoleLogData 角色战斗日志数据
function BattleManager:GetBattleRoleLogData(roleID)
	return self._battleRoleLogData[roleID]
end

---@param roleID integer 角色ID
---@param logData BattleRoleLogData 角色战斗日志数据
function BattleManager:SetBattleRoleLogData(roleID, logData)
	self._battleRoleLogData[roleID] = logData
end

function BattleManager:clear()
	self:init()
	self._isBattleState = false
	self._isEndBattle = nil

	if (self._battleEventMgr) then
		self._battleEventMgr:clear()
	end

	if (self._aiActiveMgr) then
		self._aiActiveMgr:clear()
	end
	self._isCancelBackTarce = nil
	self._previewHpChangeValue = nil
	self._previewHpIsRepair = nil
	self._lastSelectRoleID = nil
	self:setBeforeBackTranceSelectRoleId(nil)
	if self._timer then
		self._timer:Stop()
		self._timer = nil
	end
	self._isAutoAction = nil
	self._prepareSkillFollowList = {}
	self._setBattleStateEvent = {}
	self._saveSummonRoleData = {}
	self.clientBattleShowEventDic = nil
	self._loseConfirmHandler = nil
	self.gameOverCallback = nil
	self.gameResult = nil
	self._pendingGameResult = nil
	self._roleMgr:clear()
	self._map:clear()
	self._levelConfig = nil
end

function BattleManager:allRoleActiveReport(delay)
	local reportData = {
		test = 1,
		delay = delay
	}
	self._battleReporter:addReport(GE.BattleReportType.AllRoleActive, reportData)
end

---@param skinConfig CharacterSkinTable
---@param AudioData table
---@param roleName LocalStrEnum?
function BattleManager:playBattleAudio(skinConfig, AudioData, roleName)
	if self._showMgr == nil then
		return
	end
	self._showMgr:PlayBattleAudio(skinConfig, AudioData, roleName)
end

---设置是否处于自动行动中标签
function BattleManager:setIsAutoAction(flag)
	self._isAutoAction = flag
end

function BattleManager:getIsAutoAction()
	return self._isAutoAction
end

function BattleManager:getIsAutoMode()
	return self._isAutoMode
end


---进入选择英雄时，记录选择的角色id，在退出回退状态时，重新选择当前角色
function BattleManager:setBeforeBackTranceSelectRoleId(RoleId)
	if self._verifyMode or self._isLocalBattle then
		return
	end
	self._beforeBackTranceSelectRoleId = RoleId
end

function BattleManager:getBeforeBackTranceSelectRoleId()
	return self._beforeBackTranceSelectRoleId
end

---对自身释放的技能设置相关参数
function BattleManager:SetIsInUseSelfSkill(blockId)
	self._chooseTargetState = true
	self:setLastSkillSelectBlockId(blockId)
end

function BattleManager:getChooseTargetState()
	return self._chooseTargetState
end

---设置准备类技能跟随角色数据列表
---@param sourceId integer 技能来源id
---@param roleId integer 技能目标角色id
---@param skillId integer 技能id
---@param blockId integer 技能目标blockId
---@param playInReport boolean? 是否在战报中播放
function BattleManager:setPrepareSkillFollowList(sourceId, roleId, skillId, blockId, playInReport)
	if not self._prepareSkillFollowList then
		self._prepareSkillFollowList = {}
	end
	if not self._prepareSkillFollowList[roleId] then
		self._prepareSkillFollowList[roleId] = {}
	end
	local dataList = self._prepareSkillFollowList[roleId]
	---@type PrepareSkillFollowData
	local d = {
		skillId = skillId,
		blockId = blockId,
		sourceId = sourceId,
	}
	table.insert(dataList, d)
	local role = self._roleMgr:getRole(roleId)
	self:checkRoleMoveIsInBePrepareSkillTarget(role, false)
	local d = {
        role = role,
        playInReport = playInReport,
    }
    self:callClientShowEvent(GE.ClientBattleShowType.PrepareSkill, d)
end

---清理跟随角色类准备技能的数据，清理技能范围显示
function BattleManager:clearPrepareSkillFollowList(roleId, sourceId)
	if self._prepareSkillFollowList then
		self._prepareSkillFollowList[roleId] = nil
    end
end

---@param roleId integer 技能目标角色id
function BattleManager:getPrepareSkillFollowList(roleId)
	return self._prepareSkillFollowList[roleId]
end

function BattleManager:removePrepareSkillRange(sourceId)
    local showMgr = self:getShowManager()
    if showMgr then
        -- showMgr:removePrepareSkillRange(sourceId)
		local report = self:getReporter()
		report:packStep()
		---@type PrepareSkillReportData
		local reportData = {
			roleId = sourceId,
			delay = 0.1
		}
		report:addReport(GE.BattleReportType.RemovePrepareSkillRange, reportData)
    end
end

function BattleManager:clearAllPrepareSkillRange()
	self._prepareSkillFollowList = {}
	local showMgr = self:getShowManager()
    if showMgr then
        showMgr:clearAllPrepareSkillRange()
    end
end

---@param sourceId integer 技能来源id
---@param prepareData PrepareUseSkillData 准备类技能数据
---@param playInReport boolean? 是否在战报中播放
function BattleManager:showPrepareSkillRange(sourceId, prepareData, playInReport)
	local showMgr = self:getShowManager()
	if showMgr then
		local blockIdList = {}
		local skillId = prepareData.skillId
		local roleBlockId = prepareData.targetBlockId
		local roleBlock = self._map:getBlockById(roleBlockId)
		local skillConfig = Config.GetSkillInfo(skillId)
        if skillConfig then
            local sourceRole = self._roleMgr:getRole(sourceId)
            if sourceRole then
				local sourceBlock = sourceRole:getShowBlock()
                local skillRangeType = skillConfig.rangeSelectType
                local skillEffectRange = self._skillMgr:GetSkillEffectRangeByRole(skillConfig, sourceRole)
                blockIdList = self._map:getDiffuseRange(skillRangeType, roleBlock, skillEffectRange, sourceBlock)
            end
        end
        if playInReport == true then
            local report = self:getReporter()
            ---@type PrepareSkillReportData
            local reportData = {
                roleId = sourceId,
                blockDataList = blockIdList,
                delay = 0.1,
            }
            report:addReport(GE.BattleReportType.ShowPrepareSkillRange, reportData)
            report:packStep()
        else
            showMgr:refreshPrepareSkillRange(sourceId, blockIdList)
        end
    end
end

---检测角色移动时是否有准备类技能瞄准
---@param role BattleRole 角色
---@param needCheckBlock boolean? 是否需要检测blockId是否一致
function BattleManager:checkRoleMoveIsInBePrepareSkillTarget(role, needCheckBlock)
	local roleID = role.id
	local dList = self._prepareSkillFollowList[roleID]
    if dList then
        for _, d in ipairs(dList) do
            local dataBlockId = d.blockId
            local roleBlock = role:getShowBlock()
            if needCheckBlock == false or roleBlock.id ~= dataBlockId then
                d.blockId = roleBlock.id
            end
        end
    end
end

---注册设置战斗状态响应事件
---@param state BattleStateEnum
---@param event function
function BattleManager:registerBattleStateEvent(state, event)
	if type(event) == "function" then
		if not self._setBattleStateEvent then
			self._setBattleStateEvent = {}
		end
		if not self._setBattleStateEvent[state] then
			self._setBattleStateEvent[state] = {}
		end
		table.insert(self._setBattleStateEvent[state], event)
	else
		BattleManager.es("BattleManager:registerSetBattleStateEvent event is not function")
	end
end

---注册前端响应的结束战斗事件
---@param callback? fun(resultData:BattleResultResp)
function BattleManager:registerClientGameOverCallback(callback)
	self._endBattleEvent = callback
end

---@param attribList table 属性列表 {{AttribType, AttribValueType, value}, ...} AttribValueType: 1-固定值 2-百分比
---@param source BattleRole?
---@param monsterConfig MonsterTable?
---@return table<AttribType, integer>
function BattleManager:SetBaseAttribByList(attribList, source, monsterConfig)
    local attribValueList = {}
	---@type table<AttribType, string>
	local keyValueTable = {}
	if monsterConfig then
		keyValueTable[GE.AttribType.Bombard] = "bombard"
		keyValueTable[GE.AttribType.Torpedo] = "torpedo"
		keyValueTable[GE.AttribType.Armor] = "armor"
		keyValueTable[GE.AttribType.Evade] = "evade"
		keyValueTable[GE.AttribType.AirDefense] = "airdefense"
		keyValueTable[GE.AttribType.Lucky] = "lucky"
		keyValueTable[GE.AttribType.MaxHp] = "hp"
	end
    for _, value in ipairs(attribList) do
        local attribId = value[1]
        local attribType = value[2]
        local attribValue = value[3]
        local r = 0
        if attribType == 1 then
            r = attribValue
		elseif attribType == 3 and monsterConfig and source then
			local level = attribValue > 0 and attribValue or source.level
			if keyValueTable[attribId] then
				local baseValue = monsterConfig[keyValueTable[attribId]] or 1
				r = math.floor(baseValue * level)
			end
        elseif source then
            local sourceAttribValue = source:getAttrib(attribId)
            r = math.floor(sourceAttribValue * attribValue)
        end
        attribValueList[attribId] = r
    end
    return attribValueList
end

---@param summonRoleData table<integer, SummonData[]>
function BattleManager:resetSummonRoleData(summonRoleData)
	self._saveSummonRoleData = summonRoleData
end

---@return table<integer, SummonData[]> 召唤物数据
function BattleManager:GetSummonRoleData()
	return tablex.clone(self._saveSummonRoleData)
end

function BattleManager:SetSummonRoleData(effectId, roleId, baseAttribValue)
	if not self._saveSummonRoleData[effectId] then
		self._saveSummonRoleData[effectId] = {}
	end
	local list = self._saveSummonRoleData[effectId]
	list[#list + 1] = { [1] = roleId, [2] = baseAttribValue }
end

function BattleManager:GetSummonRoleDataByEffectId(effectId)
	return self._saveSummonRoleData[effectId]
end

function BattleManager:GetSummonRoleBaseAttribList(effectId, roleId)
	local list = self._saveSummonRoleData[effectId]
	if list then
		for _, data in ipairs(list) do
			if data[1] == roleId then
				return data[2]
			end
		end
	end
	return nil
end

---@param effectId integer 召唤效果id
---@param roleId integer 角色id
function BattleManager:RemoveSummonRoleData(effectId, roleId)
	local list = self._saveSummonRoleData[effectId]
	if list then
		local listCount = #list
		for i = 1, listCount, 1 do
			if list[i] == roleId then
				table.remove(list, i)
				break
			end
		end
	end
end

function BattleManager:SetIsUseGMToWinBattle(isUse)
	if GV.IsEditor then
		self._isUseGMToWinBattle = isUse
	end
end

function BattleManager:NotAllowedOrderCallBack()
	BattleManager.es("BattleManager:NotAllowedOrderCallBack, current battle state not allow order operate")
	if self:isVerifyMode() then
		self:verifyBattleFail()
		self._orderMgr:orderFinish()
	end
end

---为验证战斗设置一个特殊的战斗时机，因战斗验证时无法触发剧情结束的回调，故放在此处触发
function BattleManager:setAVGEndTimingForVerify()
	self.needCheckAvgEnd = true
end

---验证战斗时触发结束AVG节点
function BattleManager:checkAvgEndForVerify()
	if self.needCheckAvgEnd == true then
		self.needCheckAvgEnd = nil
		self:setTiming(GE.BattleTiming.PlayAVGEnd)
	end
end

---region 战斗日志相关

---是否显示日志
local showLog = true

function BattleManager.SetShowLog(isShow)
	showLog = isShow
end

function BattleManager.isShowLog()
	return showLog
end

function BattleManager.ds(...)
	if showLog then
		LuaLogger.ds(...)
	end
end

function BattleManager.ws(...)
	if showLog then
		LuaLogger.ws(...)
	end
end

function BattleManager.es(...)
	if showLog then
		LuaLogger.es(...)
	end
end

---endregion

return BattleManager
