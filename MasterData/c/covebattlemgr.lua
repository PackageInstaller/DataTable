

local key = "CoveBattleInfo"


---@class FightingInfo
---@field id integer
---@field uid integer?
---@field coveType CoveType
---@field hp integer
---@field mp integer
---@field isDead boolean
---@field pos CovePos
---@field defDir integer
---@field stateType integer


---@class CoveBattleInfo
---@field createTime integer    创建时间 服务器时间
---@field duration integer 持续时间
---@field fightId integer 对战id 对应HomeFightTable表格
---@field players FightingInfo[]
---@field monsters FightingInfo[]
---@field isFight boolean  是否已经开始对战  怪物之后在开始对战后才能攻击
---@field isGameOver boolean    是否游戏结束



---@class FightPoint
---@field id integer
---@field point UnityEngine.Transform
---@field isUse boolean

local CoveBox = require("CoveBox")


---@class CoveBattleMgr
local CoveBattleMgr = class("CoveBattleMgr")
function CoveBattleMgr:ctor(...)
    ---@type boolean 是否初始化战斗信息
    self.initBattle = false 
    ---@type boolean    是否战斗中   
	self.isBattle = false
    ---@type integer[] 怪物列表 uid
    self.monsterIds = nil

    ---@type table<integer, table<integer, FightPoint>> 战斗点 1角色战斗点 2怪物战斗点 3补给点
    self.fightPoints = nil

    ---@type CoveBattleInfo?
    self.battleInfo = nil 

    ---@type table<integer, CoveBox>
    self.coveBoxs = nil

    ---@type fun(m:integer, n:integer):integer
    self.random = math.random

    --self.random = BindCallback(Me:getRandom(), Me:getRandom().range)
end

---实例化
---@return CoveBattleMgr CoveBattleMgr
function CoveBattleMgr.instance()

	if (CoveBattleMgr._instance == nil) then
		CoveBattleMgr._instance = CoveBattleMgr:new()
	end
	return CoveBattleMgr._instance
end


function CoveBattleMgr:InitBattleInfoData()
    self.battleInfo = nil
    local battleInfoStr = MyPrefs:GetString(key)
    if not string.isNullOrEmpty(battleInfoStr) then
        ---@type CoveBattleInfo
        local battleInfo = Me:jsonDecode(battleInfoStr)
        if battleInfo == nil or battleInfo.fightId == nil then
           battleInfo = nil 
        end
        local serverTime = EngineUtil.ServerTime_Seconds()
        serverTime = math.floor(serverTime)
        if battleInfo ~= nil and serverTime > battleInfo.createTime + battleInfo.duration + 10 then
            battleInfo = nil        --战斗结束了
        end

        if battleInfo ~= nil then
            if battleInfo.players == nil then
                battleInfo.players = {}
            end
            for i = 1, #battleInfo.players do
                battleInfo.players[i].uid = 0
                local pos = battleInfo.players[i].pos
                if pos ~= nil then
                    pos = Vector3.New(pos.x, pos.y, pos.z)
                    battleInfo.players[i].pos = pos            
                end
            end
            if battleInfo.monsters == nil then
            battleInfo.monsters = {} 
            end
            for i = 1, #battleInfo.monsters do
                battleInfo.monsters[i].uid = 0
                local pos = battleInfo.monsters[i].pos
                if pos ~= nil then
                    pos = Vector3.New(pos.x, pos.y, pos.z)
                    battleInfo.monsters[i].pos = pos          
                end
            end
        end
        self.battleInfo = battleInfo
    end

    local coveBattleData = Me:GetCoveBattleData()
    local fightId = coveBattleData.fightId
    if fightId == 0 then
        self.battleInfo = nil   
        return
    end
    if self.battleInfo ~= nil and self.battleInfo.fightId == fightId then
        self:StartBattle()
	    self:PrintBattleInfo()
    else
        self:RestartGame(fightId)
    end
end


---初始化战斗
function CoveBattleMgr:InitBattle()
    if self.initBattle then
        return    
    end

    GameMsgMgr:regEvent(GameMsgType.HomeLandCoveBattleDataChange, self, self.OnHomeLandCoveBattleDataChange)
    --初始化对战点
    local coveScene = CoveManager.instance()._coveScene
    local fightPointGroups = coveScene.fightPointGroups
    local childCount = fightPointGroups.Length

    self.fightPoints = {}
    self.initBattle = true
    
    for i = 0, childCount - 1 do
        self.fightPoints[i + 1] = {}
        local trs = fightPointGroups[i]
        local cc = trs.childCount
        for j = 1, cc - 1 do
            local pointTrs = trs:GetChild(j)
            local id = tonumber(pointTrs.name)
            local pos = pointTrs.position
            pos = Vector3.New(pos.x, pos.y, pos.z)
            ---@type FightPoint
            local point = {
                id = id,
                point = pointTrs,
                isUse = false,
            }
            self.fightPoints[i + 1][id] = point
        end
    end
    self.coveBoxs = {}
    local boxs = Me:getHomeland().coveBoxRewards
    if boxs ~= nil then
        self:CreateCoveBox(boxs)
    end
   
    self:InitBattleInfoData()
    Me:ReportHomelandEnterExitReq(true)
end

---随机家园找到配置
---@param fightId integer
function CoveBattleMgr:CreateBattle(fightId)
    local serverTime = EngineUtil.ServerTime_Seconds()
    if serverTime == nil then
        return
    end
    serverTime = math.floor(serverTime)
    local cfg = Config.GetHomeFightTableInfo(fightId)
    if cfg == nil then
        LuaLogger.es("开启战斗失败找到对应配置 id:" .. tostring(fightId))
        return
    end
    self.battleInfo = {
        createTime = serverTime,
        duration =  10*60,
        fightId = cfg.id,
        players = {},
        monsters = {},
        isGameOver = false,
        isFight = false,
    }
    self:SaveBattleInfo()
end

---随机参战人员
function CoveBattleMgr:RandomFighter()
    if self.battleInfo == nil then
       return 
    end
    if self.battleInfo.isGameOver then
        return    
    end

    if #self.battleInfo.players ~= 0 then
       return 
    end
    local fid = self.battleInfo.fightId
    local cfg = Config.GetHomeFightTableInfo(fid)
    if cfg == nil then
        self.battleInfo.isGameOver = true
        return
    end
    ---随机我方人数
    local characters = self:GetRandomFighterHero(cfg.charaNum)
    if #characters == 0 then
        LuaLogger.ds("我方人员数量为0")
        return
    end
   
    --characters = {10008}            ---TODO 指定参战人员
    local monsters = {}
    local count = cfg.enemyNum
    for i = 1, count do
        local rv = self.random(1, #cfg.enemyId)
        table.insert(monsters, cfg.enemyId[rv])
    end
    --monsters = {21101}      --TODO 指定怪物
    if #characters == 0 or #monsters == 0 then
        return
    end

    self.battleInfo.fightId = cfg.id
    ---self.battleInfo.fightId = 10003     ---TODO 指定战斗位置
    self.battleInfo.players = {}
    for i = 1, #characters do

        local characterCfg = Config.GetCharacterInfo(characters[i])
        if characterCfg == nil then
            LuaLogger.es("战斗创建角色错误 未找到对应配置 id:" .. characters[i])
           goto continue 
        end
        if characterCfg.isSpecial == 1 then
           goto continue 
        end
        ---@type FightingInfo
        local fInfo = {
            id = characters[i],
            coveType = CoveType.Player,
            hp = characterCfg.homeFightHp,
            mp = characterCfg.homeFightMp,
            isDead = false,
            pos = nil,
            stateType = 0
        }
        table.insert(self.battleInfo.players, fInfo)
        ::continue::
    end

    self.battleInfo.monsters = {}
    local covePoints = {}
    for i = 1, #monsters do
        local monsterCfg = Config.GetMonsterInfo(monsters[i])
        if monsterCfg == nil then
            LuaLogger.es("战斗创建角色错误 未找到对应配置 id:" .. monsters[i])
            goto continue 
        end
        local pos, dir = self:GetFightPoint(CoveType.Monster)
        if pos == nil then
           pos = {x =0, y = 0, z = 0}
           dir = 0
        end
        ---@type CoveType
        pos = {
            x = math.floor(pos.x * 100),
            y = math.floor(pos.y * 100),
            z = math.floor(pos.z * 100),
        }
        ---@type FightingInfo
        local fInfo = {
            id = monsters[i],
            coveType = CoveType.Monster,
            hp = monsterCfg.homeFightHp,
            mp = monsterCfg.homeFightMp,
            isDead = false,
            pos = pos,
            defDir = math.floor(dir * 100),
            stateType = 0,
        }
        table.insert(self.battleInfo.monsters, fInfo)
        covePoints[i] = pos
        ::continue::
    end
    --发送怪物位置
    Me:ReportCreateHomelandBattleRewardBoxReq(covePoints, false)
    self:SaveBattleInfo()
end


local lastUpdateTime = 0
function CoveBattleMgr:Update()

	--是否在家园场景
	if not CoveManager.instance():getFocusState() then
		return
	end

    local time = Time.realtimeSinceStartup
	local passTime = time - lastUpdateTime
	if lastUpdateTime ~= 0 and passTime < 10 then
		return
	end
    lastUpdateTime = time

    self:UpdateCoveProperty()
end

function CoveBattleMgr:CheckBattleInfo()
    if self:IsBattle() then
        return
    end
    if self.battleInfo ~= nil and self.battleInfo.isGameOver then
       return
    end
    local battleInfo = Me:GetCoveBattleData()
    if battleInfo.fightId == 0 then
       return
    end
    self:CreateBattle(battleInfo.fightId)
    if self.battleInfo == nil then
       return 
    end
    if self.battleInfo.isGameOver then
       return
    end
    self:RandomFighter()
    self:StartBattle()
end


---获取战斗点
---@param coveType CoveType
---@return Vector3? 位置, number? 旋转朝向
function CoveBattleMgr:GetFightPoint(coveType)
    if self.fightPoints == nil then
        return
    end
    local tab = self.fightPoints[coveType]
    if tab == nil or tablex.empty(tab) then
        return
    end
    local cfg = Config.GetHomeFightTableInfo(self.battleInfo.fightId)
    if cfg == nil then
       LuaLogger.ws(" 寻找对战参数错误 id:" .. self.battleInfo.fightId)
       return
    end

    ---@type FightPoint[]
    local noUsePoint = {}
    for i,v in pairs(tab) do
        if v.isUse then
            goto continue
        end
        if coveType == CoveType.Monster then
            if not tablex.find(cfg.enemyLocation, i) then
                goto continue
            end
        end
         table.insert(noUsePoint, v)
        ::continue::
    end

    local index = self.random(1, #noUsePoint)
    local point = noUsePoint[index]
    if point == nil then
        return
    end
    point.isUse = true
    return point.point.position, point.point.localEulerAngles.y
end

---获取战斗点
---@param coveType CoveType
---@param pos Vector3
---@param checkUse boolean? 释放检测使用
---@return Vector3? 位置, number? 朝向
function CoveBattleMgr:GetNearestFightPoint(coveType, pos, checkUse)
    if self.fightPoints == nil then
        return
    end

    local tab = self.fightPoints[coveType]
    if tab == nil or tablex.empty(tab) then
        return
    end

    local cfg = Config.GetHomeFightTableInfo(self.battleInfo.fightId)
    if cfg == nil then
       LuaLogger.ws(" 寻找对战参数错误 id:" .. self.battleInfo.fightId)
       return
    end

    local minDis = nil
    ---@type FightPoint?
    local point = nil
    for i,v in pairs(tab) do
        if checkUse == true and v.isUse then
            goto continue
        end
        if coveType == CoveType.Monster then
            if not tablex.find(cfg.enemyLocation, i) then
                goto continue
            end
        end
        local dis = Vector3.Distance(pos, v.point.transform.position)
        if minDis == nil or minDis > dis then
            point = v
        end
        ::continue::
    end
    if point == nil then
       return 
    end
    return point.point.position, point.point.localEulerAngles.y
end


function CoveBattleMgr:StartBattle()
    if true then
        ---return --TODO 禁用家园战斗
    end
    if (UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.CoveBattle)) ~= GE.FunctionOpenState.Open then
        return
    end
    self.isBattle = false
    if self.battleInfo == nil then
        return
    end

    if self.battleInfo.isGameOver then
        return
    end
    
    local characters = {}
    for i = 1, #self.battleInfo.players do
        table.insert(characters, self.battleInfo.players[i].id)
    end

    local monsters = {}
    for i = 1, #self.battleInfo.monsters do
        local mInfo = self.battleInfo.monsters[i]
        if not mInfo.isDead then
            table.insert(monsters, self.battleInfo.monsters[i].id)
        end
    end

    LuaLogger.ds("===>>> 战斗开始 character:" .. table.concat(characters, ",") .. " monster:" .. table.concat(monsters, ","))

    --重置对站点
    for k, v in pairs(self.fightPoints) do
        for i = 1, #v do
            v[i].isUse = false
        end
    end
      
    self.isBattle = true
    local roleMgr = CoveManager.instance()._roleMgr
    for i = 1, #self.battleInfo.monsters do
        local mInfo = self.battleInfo.monsters[i]
        if not mInfo.isDead then
            local id = mInfo.id
            local monster = roleMgr:createMonster({id = id})
            mInfo.uid = monster:GetUID()
        end
    end

    --创建character
    for i = 1, #self.battleInfo.players do
        local pInfo = self.battleInfo.players[i]
        local id = pInfo.id
        local isHas = roleMgr:isHasRoleInCove(id)
        if isHas then
            local coveRole = roleMgr:getRole(id)
            if coveRole ~= nil then
                self:CheckRoleUID(coveRole)
                pInfo.uid = coveRole:GetUID()
                if coveRole.modelLoadFinish then
                    coveRole:GotoBattle()
                end
            end
            goto continue
        end
        local roleData = Me:getPlayerHero(id)
        if roleData == nil then
            LuaLogger.ws("创建战斗角色失败 id:" .. id)
            goto continue
        end
        local room = CoveManager.instance():getRoomMgr():getRoom(10001)
        local data = {
            roleData = Me:getPlayerHero(id),
            room = room,
            coveRoleType = CoveRoleType.Random,
            isPreRole = false,
            homeWorkIndex = 1,
            isCreateInRoom = false,
            constructId = 0,
            isBattleRole = true,
        }
        local coveData = roleMgr:createCoveRole(nil, data)
        local coveRole = roleMgr:createSingleRole(coveData)
        pInfo.uid = coveRole:GetUID()
        ::continue::
    end

    local bgm = self:GetFightBGM()
    if bgm ~= nil then
        UIMgr:SetBasalBgm(bgm)
    end
    UIMgr:PlayBasalBgm()
    GameMsgMgr:sendEvent(GameMsgType.RefreshCoveBattleInfo)
end

---@param coveRole CoveRole
function CoveBattleMgr:CheckRoleUID(coveRole)
    if not self:IsBattle() then
        return
    end

    if self.battleInfo == nil or self.battleInfo.players == nil then
        return
    end
    for i = 1, #self.battleInfo.players do
        local pInfo = self.battleInfo.players[i]
        if pInfo.id == coveRole:GetID() then
            pInfo.uid = coveRole:GetUID()
            break 
        end
    end
end


---@param coveBase CoveBase
function CoveBattleMgr:DeleteCoveMonster(coveBase)
    if coveBase == nil then
        return    
    end
    local uid = coveBase:GetUID()
    local aliveCount = 0
    ---@type integer
    local index = -1
    for i = 1, #self.battleInfo.monsters do
        local pInfo = self.battleInfo.monsters[i]
        if pInfo.uid == uid then
            pInfo.isDead = true
            index = i
        end
        if not pInfo.isDead then
            aliveCount = aliveCount + 1
        end
    end
    if index == -1 then
       return 
    end

    local target = self:GetForceAttackTarget()
    if target ~= nil and target:GetUID() == uid then
        self:SetForceAttackTarget(nil) 
    end

    --发送怪物死亡
    local pos = coveBase:GetPosition()
    ---@type CovePos
    local cpos = {
        x = 0,
        y = 0,
        z = 0,
    }
    if pos ~= nil then
        cpos.x = math.floor(pos.x * 100)
        cpos.y = math.floor(pos.y * 100)
        cpos.z = math.floor(pos.z * 100)
    end
    self:SaveBattleInfo()
    Me:ReportCreateHomelandBattleRewardBoxReq({[index] = cpos}, true, function(coveBoxReward)
        self:CreateCoveBox(coveBoxReward)
    end)

    if aliveCount == 0 then
       self:OnBattleOver()
    end
end



---@param coveBase CoveBase?
function CoveBattleMgr:SetForceAttackTarget(coveBase)
    self.forceAttackTarget = coveBase
end

---@return CoveBase? 优先攻击对象
function CoveBattleMgr:GetForceAttackTarget()
    return self.forceAttackTarget
end


---@return boolean
function CoveBattleMgr:IsBattle()
    return self.isBattle
end

function CoveBattleMgr:OnBattleOver()
    LuaLogger.ds("战斗结束")
    --清除战斗点使用信息
    if self.fightPoints ~= nil then
        for k, v in pairs(self.fightPoints) do
            for k1, v1 in pairs(v) do
                v1.isUse = false
            end
        end
    end
    self.battleInfo.isGameOver = true
    self:SaveBattleInfo()

    local curBasalBgm = UIMgr:GetBasalBgm()
    UIMgr:SetBasalBgm()
    if UIMgr.curBgmId == curBasalBgm then
        UIMgr:PlayBasalBgm()
    end
    self.isBattle = false
    GameMsgMgr:sendEvent(GameMsgType.RefreshCoveBattleInfo)
    


    DLuaTimer:DoAfter(0.1, function()
        Me:ReportHomelandBattleGameOverReq(function(coveBoxReward)
            self:CreateCoveBox(coveBoxReward)
        end)
    end)
end

function CoveBattleMgr:IsBattleCharacter(uid)
    if not self:IsBattle() then
        return false
    end

    if self.battleInfo == nil then
       return false 
    end
    for i = 1, #self.battleInfo.players do
        local pInfo = self.battleInfo.players[i]
        if pInfo.uid == uid then
           return true
        end
    end

    for i = 1, #self.battleInfo.monsters do
        local pInfo = self.battleInfo.monsters[i]
        if pInfo.uid == uid then
           return true
        end
    end
    return false
end


function CoveBattleMgr:IsBattleCharacterById(id)
    if not self:IsBattle() then
        return false
    end

    for i = 1, #self.battleInfo.players do
        local pInfo = self.battleInfo.players[i]
        if pInfo.id == id then
           return true
        end
    end
    return false
end

---设置开始战斗
function CoveBattleMgr:SetBattleIsFight()
    if not self:IsBattle() then
        return false
    end

    if self.battleInfo.isFight then
        return
    end
    self.battleInfo.isFight = true
    self:SaveBattleInfo()
end

---是否已经开始战斗
function CoveBattleMgr:IsFight()
    if not self:IsBattle() then
        return false
    end
    if self.battleInfo.isFight then
        return true
    end
    return false
end



---播放特效
---@param parent UnityEngine.Transform.Position	父节点Position
---@param id number	特效id
---@param rotation UnityEngine.Quaternion?	特效旋转
---@param performanceType GE.SkillPerformanceType?	表现类型
---@param buffid number?	特效buffid
---@param roleId number?	角色id
function CoveBattleMgr:playEffect(coveId, effectId, pos, rotation)
	--特效
	if effectId == 0 or effectId == "" then
		return
	end
	local effectConfig = Config.GetSoundAndEffectInfo(effectId)
	if not effectConfig then
		LuaLogger.ws("特效配置不存在  ", effectId)
		return
	end
	local role = CoveRoleManager.instance():GetRoleBuyUid(coveId)
    if role == nil or (not role.modelLoadFinish)  then
        return
    end

	local effectName = effectConfig.effectResource
	local effectPath = string.format(Config.PrefabPath.BattleEffect, effectName, effectName)
	PoolMgr:Get(effectPath, function (obj)
		if (obj) then
            if role.destroyed then
                PoolMgr.Free(obj)
                return 
            end
			LuaLogger.ds("BattleShowManager:playEffect", effectPath)
			obj.transform.position = pos
			if rotation then
				LuaLogger.ds("BattleShowManager:playEffect rotation", rotation)
				obj.transform.rotation = rotation
			end
			---@type UnityEngine.ParticleSystem
			local particle = obj.transform:Find("Effect"):GetComponent("ParticleSystem")
			particle:Simulate(0)
			particle:Play()
			local effect2 = obj.transform:Find("Effect_2")
			if (effect2) then
				---@type UnityEngine.ParticleSystem
				local particle2 = effect2:GetComponent("ParticleSystem")
				particle2:Simulate(0)
				particle2:Play()
			end

            obj:SetParent(role._model.transform)
            role:AddEffect(effectId, obj)
		end
	end)
	--特效对应音效
	local soundName = effectConfig.SoundResource
	local soundPath = string.format(Config.AudioPath.SE, soundName)
	if soundName and soundName ~= "" then
		LuaLogger.ds("BattleShowManager:playEffect soundPath", soundPath)
		TimeMgr:AddWaitTimeExecute(effectConfig.delay, function()
			LuaMain:play2DSound(soundPath)
		end, nil)
	end

end




---保存战斗数据
function CoveBattleMgr:UpdateCoveProperty()
    if self.battleInfo == nil then
        return
    end
    if not self:IsBattle() then
        return
    end

    for i = 1, #self.battleInfo.players do
        local pInfo = self.battleInfo.players[i]
        local cove = CoveRoleManager.instance():GetRoleBuyUid(pInfo.uid)
        if cove ~= nil and cove.modelLoadFinish then
            local hp = cove:GetResourceVal(HeroAttributeType.Hp)
            pInfo.hp = hp

            local mp = cove:GetResourceVal(HeroAttributeType.Mp)
            pInfo.mp = mp

            local pos = cove:GetPosition()
            if pos ~= nil then
                pInfo.pos = pInfo.pos or {x = 0, y = 0, z = 0}
                pInfo.pos.x = math.floor(pos.x * 100)
                pInfo.pos.y = math.floor(pos.y * 100)
                pInfo.pos.z = math.floor(pos.z * 100)
            end
            pInfo.stateType = cove.coveModelState
        end
    end

    for i = 1, #self.battleInfo.monsters do
        local mInfo = self.battleInfo.monsters[i]
        local cove = CoveRoleManager.instance():GetRoleBuyUid(mInfo.uid)
        if cove ~= nil and cove.modelLoadFinish then
            local hp = cove:GetResourceVal(HeroAttributeType.Hp)
            mInfo.hp = hp
            local mp = cove:GetResourceVal(HeroAttributeType.Mp)
            mInfo.mp = mp
            local pos = cove:GetPosition()
            if pos ~= nil then
                mInfo.pos = mInfo.pos or {x = 0, y = 0, z = 0}
                mInfo.pos.x = math.floor(pos.x * 100)
                mInfo.pos.y = math.floor(pos.y * 100)
                mInfo.pos.z = math.floor(pos.z * 100)
            end
            mInfo.stateType = cove.coveModelState
        end
    end
    self:SaveBattleInfo()
end

function CoveBattleMgr:SaveBattleInfo()
    local info = self.battleInfo
    if MyPrefs == nil then
       return 
    end
    if info == nil then
        MyPrefs:SetString(key, "")
        return
    end
    local s = Me:jsonEncode(info)
	MyPrefs:SetString(key, s)
end


---获取对象战斗信息
---@param cove CoveBase
---@return FightingInfo?
function CoveBattleMgr:GetSaveFightingInfo(cove)
    if self.battleInfo == nil then
       return nil
    end
    local tab = nil
    if cove:GetType() == CoveType.Player then
        tab = self.battleInfo.players
    elseif cove:GetType() == CoveType.Monster then
        tab = self.battleInfo.monsters
    end
    if tab == nil then
       return nil 
    end
    for i = 1, #tab do
        if tab[i].uid == cove:GetUID() then
           return tab[i] 
        end
    end
    return nil
end


---镜头定位到指定人员
function CoveBattleMgr:FocusingBattle()

    if not self:IsBattle() then
       return 
    end
    if self.battleInfo == nil or self.battleInfo.monsters == nil then
       return 
    end
    ---@type integer
    local ri = #self.battleInfo.monsters
    if ri == 0 then
       return 
    end
    ri = self.random(1, ri)
    local uid = self.battleInfo.monsters[ri].uid
    local coveBase = CoveRoleManager.instance():GetRoleBuyUid(uid)
    if coveBase == nil then
       return 
    end
    local lockPos = coveBase:GetPosition()
    if lockPos == nil then
       return 
    end
    CoveManager.instance():LookAtPos(GE.HomeLandPerspectiveType.Whole, lockPos, { time = 0.5 })
end


---获得战斗bgm
---@return integer?
function CoveBattleMgr:GetFightBGM()
    if not self:IsBattle() then
       return nil 
    end
    if self.battleInfo == nil then
       return nil 
    end
    local fid = self.battleInfo.fightId
    local fightCfg = Config.GetHomeFightTableInfo(fid)
    if fightCfg ~= nil and fightCfg.BGM ~= nil and fightCfg.BGM ~= 0 then
        return fightCfg.BGM
    end
    return nil
end

function CoveBattleMgr:PrintBattleInfo()
    
    if self.battleInfo == nil then
       LuaLogger.ds("  战斗未初始化")
       return  
    end

    if self.battleInfo.isGameOver then
        LuaLogger.ds("  游戏已经结束")
        return
    end
    local str = ""
    for i = 1, #self.battleInfo.monsters do
        local pInfo = self.battleInfo.monsters[i]
        local id = pInfo.uid
        ---@type CoveMonster
        local role = CoveRoleManager.instance():GetRoleBuyUid(id)
        if role ~= nil and role.readTypeInfo ~= nil then
            str = str .. "id:" .. role:GetID() .. "   readTypeInfo:"
            for k, v in pairs(role.readTypeInfo) do
                if v == true then
                   str = str .. "," .. k 
                end
            end
            str = str .. "\n"
        end
    end

    for i = 1, #self.battleInfo.players do
       local pInfo = self.battleInfo.players[i]
        local id = pInfo.uid
        ---@type CoveMonster
        local role = CoveRoleManager.instance():GetRoleBuyUid(id)
        if role ~= nil and role.readTypeInfo ~= nil then
            str = str .. "id:" .. role:GetID() .. "   readTypeInfo:"
            for k, v in pairs(role.readTypeInfo) do
                if v == true then
                   str = str .. "," .. k 
                end
            end
            str = str .. "\n"
        end
    end
    local infoStr = tablex.dump(self.battleInfo)
    LuaLogger.ds("战斗开始:\n"  .. infoStr .. "\n" .. str)
end

function CoveBattleMgr:Clear()
    self.initBattle = false
    self.fightPoints = nil
    if self:IsBattle() then
        for i = 1, #self.battleInfo.monsters do
            local pInfo = self.battleInfo.monsters[i]
            local id = pInfo.uid
            ---@type CoveMonster
            local role = CoveRoleManager.instance():GetRoleBuyUid(id)
            if role ~= nil then
                role:Destroy()
            end
        end

        for i = 1, #self.battleInfo.players do
            local pInfo = self.battleInfo.players[i]
            local id = pInfo.uid
            ---@type CoveRole
            local role = CoveRoleManager.instance():GetRoleBuyUid(id)
            if role ~= nil and not role.destroyed then
                role:GotoGameOver() 
            end
        end
        self.isBattle = false
    end
    if self.coveBoxs ~= nil then
        for k, v in pairs(self.coveBoxs) do
            v:Destroy()
        end
        self.coveBoxs = nil
    end
    self:SaveBattleInfo()
    GameMsgMgr:unRegEvent(GameMsgType.HomeLandCoveBattleDataChange, self, self.OnHomeLandCoveBattleDataChange)
end


function CoveBattleMgr:RestartGame(fightId)
    ---@type CoveBattleInfo?
    self.battleInfo = nil 
    self:CreateBattle(fightId)
    if self.battleInfo == nil then
       return 
    end
    self:RandomFighter()
    self:StartBattle()
	self:PrintBattleInfo()
end


function CoveBattleMgr:GetRandomFighterHero(count)
    local tab = {}
    ---找到巡逻人员
    local patrolRoomId = GE.CoustructionEnum.PatrolRoom
    local buildingList = Me:getConstructionMapData()
    local patrolBuild = buildingList[GE.CoustructionEnum.PatrolRoom]
    if patrolBuild ~= nil then
        local ids = {}
        for i = 1, #patrolBuild.disposeHeroList do
            local id = patrolBuild.disposeHeroList[i]
            if id > 0 then
               table.insert(ids, id) 
            end
        end
        tablex.shuffle(ids)
        local c = math.min(#ids, count)
        for i = #ids, c + 1, -1 do
            ids[i] = nil
        end
        tablex.move(ids, 1, #ids, #tab + 1, tab)
    end
    if #tab >= count then
       return tab 
    end

    --找到散步 工作 等等在场内的人员
    local ids = {}
    ---添加工作角色
    for k, v in pairs(buildingList) do
        if k == GE.CoustructionEnum.PatrolRoom then
           goto continue 
        end
        for i = 1, #v.disposeHeroList do
            local id = v.disposeHeroList[i]
            if id > 0 then
               table.insert(ids, id) 
            end
        end
        ::continue::
    end
    --添加散步的角色
    local homeland = Me:getHomeland()
    local walkIds = homeland.homeWalkHeroList
    for i = 1, #walkIds do
        if walkIds[i] > 0 then
            table.insert(ids, walkIds[i])
        end
    end

    --添加随机角色
    for k, v in pairs(homeland.rolePreRoom) do
        if k > 0  then
            table.insert(ids, k)
        end
    end
    tablex.shuffle(ids)
    local addCount = count - #tab
    local c = math.min(#ids, addCount)
    for i = #ids, c + 1, -1 do
        ids[i] = nil
    end
    tablex.move(ids, 1, #ids, #tab + 1, tab)
    if #tab >= count then
       return tab 
    end

    ---添加不在场上的人员
    local ids = {}
    for k, v in pairs(Me.heroList) do
        local cfg = Config.GetCharacterInfo(v.id)
        if cfg == nil or cfg.homeFightAtk == nil or #cfg.homeFightAtk == 0 then
            goto continue
        end
        if tablex.indexof(tab, v.id) > 0 then
            goto continue
        end
        table.insert(ids, v.id)
        ::continue::
    end
    tablex.shuffle(ids)
    local addCount = count - #tab
    local c = math.min(#ids, addCount)
    for i = #ids, c + 1, -1 do
        ids[i] = nil
    end
    tablex.move(ids, 1, #ids, #tab + 1, tab)
    return tab
end

---@param coveBoxReward table<integer, CoveBoxReward>| CoveBoxReward[]
function CoveBattleMgr:CreateCoveBox(coveBoxReward)
    if coveBoxReward == nil then
       return 
    end
    for k, v in pairs(coveBoxReward) do
        if v == nil or tablex.empty(v) then
           goto continue 
        end
        local data = v
        local coveBox = self:GetCoveBox(data.uid)
        if coveBox ~= nil then
            LuaLogger.es("当前奖励已经创建 无需重复创建 uid:" .. data.uid)
            goto continue
        end
        coveBox = CoveBox:new(data)
        self.coveBoxs[data.uid] = coveBox
        ::continue::
    end
end

---@param boxUid integer
---@return CoveBox?
function CoveBattleMgr:GetCoveBox(boxUid)
    if self.coveBoxs == nil then
       return nil
    end
    return self.coveBoxs[boxUid]
end

function CoveBattleMgr:DeleteCoveBox(uid)

    local coveBox = self:GetCoveBox(uid)
    if coveBox == nil then
       return 
    end
    self.coveBoxs[uid] = nil
    coveBox:Destroy()
end



--------------------
----家园战斗信息改变通知
---@param v CoveBattleData
function CoveBattleMgr:OnHomeLandCoveBattleDataChange(v)
    if v == nil or v.fightId == nil then
       return 
    end
    self:CheckBattleInfo()
end

return CoveBattleMgr
