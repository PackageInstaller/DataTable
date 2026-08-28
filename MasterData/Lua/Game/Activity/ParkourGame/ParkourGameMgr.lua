local ResourceModule = CS.Engine.Modules.ResourceModule
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local CDTimerModule = CS.Engine.Modules.CDTimerModule
local CountDownTime = 2592000 --30 * 86400 30天的秒数

local ParamsDefine = {
    RESTORE_HP_INTERVAL = 1, -- 恢复活动体力所需秒数
    RESTORE_NUM = 2, -- 活动体力每次恢复X点
    HP_UP_LIMIT = 3, -- 活动体力恢复上限
    BUY_CONSUME_ITEM = 4, -- 兑换体力用道具id
    BUY_CONSUME_ITEM_NUM = 5, -- 消耗道具的数量（从左至右依次递增。到最右后循环）
    BUY_NUM = 6, -- 消耗道具可兑换的体力数量
    BUY_DAILY_TIME_LIMIT = 7, -- 每日活动体力最多可兑换次数
}

---@type ActivityMgr
local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()

---@class ParkourGameMgr : Singleton
local ParkourGameMgr = Class("ParkourGameMgr", import("Frame.Singleton"))

function ParkourGameMgr:__init()
    ParkourGameMgr.super.__init(self)
    ---@type ParkourGameRunner
    self.gameRunner = nil
    ---@type ParkourPlayerController
    self.player = nil
    ---@type ParkourBoss
    self.boss = nil

    --[[
        mainQuestId;  -- int(只读) 目前为止已经打通的最新的一关, 不一定是玩家正在打的那一关; 若一关也没打通, 此值为 0
    ]]--
    ---@type table
    self.homeDojo = nil

    self.currentLevelId = nil -- 玩家当前在打的那一关, 刚进活动时, 此值指向第一关

    ---@type boolean
    self.isBackFromMainDialogForResume            = false -- 在主游戏结算界面点击 "重玩" 后, 要将本值设为 true
    ---@type boolean
    self.isBackFromMainDialogForResumeForInfinity = false -- 无限模式下的

    ---@type number | nil
    self.toWhichParkourLevel = nil -- 去哪个跑酷关卡; nil:未选; -1:无限模式; [1,+]:普通模式 

    self.isMainDialogInitDone = false

    ---@type number
    self.activityId = nil -- 活动排期表id, 1,2 这种

    ---@type number
    self.activityUuid = nil -- 

    --- 奖励
    self.rewards = nil

    self.enterTime = 0

    -- 每一关的收集数据; 对应 activityTinyWorld/freeParkourGrade 里的 questData
    self.scores = {
        gainGoodIds = {}, -- 增益道具id=>num
        beatTrapIds = {}, -- 击败踩到的陷阱 id=>num
        ---
        isUnwounded = 0,        -- role 是否未受伤
        mynaFind = 0,           -- 是否被八哥发现 0:未发现,1:发现
        activityGoodsIds = {},  -- 收集到的活动道具 id=>num
        bossRunAwayNums = 0,    -- boss 被击退的次数
        invisibleTimes = 0, -- 玩家开启 隐藏 的次数 (吃隐身孢子 和 开启隐身技能 是两回事)
        ---
        score = 0,          -- 自由探索总分数
        coinScore = 0,      -- 货币积分
        moveScore = 0,      -- 前进距离积分
        gainGoodScore = 0,  -- 增益积分
        beatTrapScore = 0,  -- 陷阱积分
        bossScore = 0,      -- boss击退积分
        invisibleScore = 0, -- 开启隐身技能 积分
    }

    -- 测试用数据
    self.debug = {
        isInvincible = false
    }
    self.isCallParkourGradeReachEnd = false -- 调用 parkourGrade 是否结束;
    self.isMainlineDialogFocus = false
    self.isParkourDialogFocus = false
    self.battleEndCB = nil
end

function ParkourGameMgr:__delete()
    self:CloseTimer()
    self.homeDojo = nil
    self.isBackFromMainDialogForResume = false
    self.isBackFromMainDialogForResumeForInfinity = false
    self.toWhichParkourLevel = nil
    self.isMainDialogInitDone = false
    self.activityId = nil
    self.activityUuid = nil
    self.currentLevelId = nil
    self.rewards = nil
    self.scores = nil
    self.debug = nil
    self.enterTime = 0
    self.isCallParkourGradeReachEnd = false
    self.isMainlineDialogFocus = false
    self.isParkourDialogFocus = false
    self.battleEndCB = nil
end


function ParkourGameMgr:ClearScores()
    self.scores = {
        gainGoodIds = {}, -- 增益道具id=>num
        beatTrapIds = {}, -- 击败踩到的陷阱 id=>num
        ---
        isUnwounded = 0,        -- role 是否未受伤
        mynaFind = 0,           -- 是否被八哥发现 0:未发现,1:发现
        activityGoodsIds = {},  -- 收集到的活动道具 id=>num
        bossRunAwayNums = 0,    -- boss 被击退的次数
        invisibleTimes = 0, -- 玩家开启 隐藏 的次数 (吃隐身孢子 和 开启隐身技能 是两回事)
        ---
        score = 0,          -- 自由探索总分数
        coinScore = 0,      -- 货币积分
        moveScore = 0,      -- 前进距离积分
        gainGoodScore = 0,  -- 增益积分
        beatTrapScore = 0,  -- 陷阱积分
        bossScore = 0,      -- boss击退积分
        invisibleScore = 0, -- 开启隐身技能 积分
    }
end 


---@param isFromHome_ boolean @ 是否是在调用了 后端接口 home 之后被调用的 clear;  (若是 parkourHome, 则要设为 false)
function ParkourGameMgr:Clear( isFromHome_ )
    self.gameRunner = nil
    self.player = nil
    self.boss = nil

    if isFromHome_ == true then 
        self.homeDojo = nil
        
    end 

    -- !! 不要主动 clear activityId 和 activityUuid
    -- self.activityId = nil
    -- self.activityUuid = nil
    
    self.currentLevelId = nil
    self.isBackFromMainDialogForResume = false
    self.isBackFromMainDialogForResumeForInfinity = false
    self.toWhichParkourLevel = nil
    self.rewards = nil
    self.enterTime = 0
    self.scores = {
        gainGoodIds = {}, -- 增益道具id=>num
        beatTrapIds = {}, -- 击败踩到的陷阱 id=>num
        ---
        isUnwounded = 0,        -- role 是否未受伤
        mynaFind = 0,           -- 是否被八哥发现 0:未发现,1:发现
        activityGoodsIds = {},  -- 收集到的活动道具 id=>num
        bossRunAwayNums = 0,    -- boss 被击退的次数
        invisibleTimes = 0, -- 玩家开启 隐藏 的次数 (吃隐身孢子 和 开启隐身技能 是两回事)
        ---
        score = 0,          -- 自由探索总分数
        coinScore = 0,      -- 货币积分
        moveScore = 0,      -- 前进距离积分
        gainGoodScore = 0,  -- 增益积分
        beatTrapScore = 0,  -- 陷阱积分
        bossScore = 0,      -- boss击退积分
        invisibleScore = 0, -- 开启隐身技能 积分
    }
    self.debug = {
        isInvincible = false
    }
    self.isCallParkourGradeReachEnd = false
    self.isMainlineDialogFocus = false
    self.isParkourDialogFocus = false
    self.battleEndCB = nil
end

-- 后端 home 接口
function ParkourGameMgr:SetHomeDojoData(dojo)
    self.homeDojo = dojo
    self:StartTimer()
end


-- 后端 parkourHome 接口
function ParkourGameMgr:SetParkourHomeDojoData(dojo)
     
    assert( isNotNull(self.homeDojo) )

    -- 只更新部分数据:
    self.homeDojo.mainQuestMap = dojo.parkourQuestMap
    self.homeDojo.mainQuestId = checkInt(dojo.parkourQuestId)

    self.homeDojo.playerRank = dojo.playerRank
    self.homeDojo.questGradeTaskProgress = dojo.questGradeTaskProgress
    self.homeDojo.percentageRank = dojo.percentageRank
    self.homeDojo.rank = dojo.rank
    self.homeDojo.playerRank = dojo.playerRank
    self.homeDojo.totalNum = dojo.totalNum -- totalRankNum

    --self:StartTimer() -- !!! 要不要 ?
end


function ParkourGameMgr:SetActivityId(id_)
    self.activityId = checkNumber(id_)
    print("设置 activityId: "..tostring(self.activityId) )
end

function ParkourGameMgr:SetActivityUID(uuid)
    self.activityUuid = checkNumber(uuid)
    print("设置 activityUuid: "..tostring(self.activityUuid) )
end


---@return number
function ParkourGameMgr:GetActivityGoodsNum()
    ---@type ParkourGameUtil
    local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")
    local id = tostring(ParkourGameUtil.activityGoodsId) 
    local num = checkInt(self.scores.activityGoodsIds[id])
    return num
end



-- 要么是第一关, 要么是玩家上次指向的一关
function ParkourGameMgr:GetCurrentLevelId()
    if isNotNull(self.currentLevelId) then
        return self.currentLevelId
    else
        if isNull(self.homeDojo) then
            printError("homeDojo 为空")
            return 0
        end
        local mainQuestMap = self.homeDojo.mainQuestMap
        local mainQuestId = self.homeDojo.mainQuestId
        if isNull(mainQuestMap) or (table.count(mainQuestMap) == 0) or isNull(mainQuestId) then
            printError("homeDojo 数据异常")
            return 0
        end
        ---
        if checkInt(mainQuestId) > 0 then
            return checkInt(mainQuestId)
        else
            return checkInt(mainQuestMap[1].questId)
        end
    end
end


-- 收集到 增益道具
function ParkourGameMgr:Add_Gain(id_)
    id_ = tostring(id_)
    if self.scores.gainGoodIds[id_] == nil then
        self.scores.gainGoodIds[id_] = 1
    else
        self.scores.gainGoodIds[id_] = self.scores.gainGoodIds[id_] + 1
    end
end
-- 收集到 击败踩到的陷阱
function ParkourGameMgr:Add_BeatTrap(id_)
    id_ = tostring(id_)
    if self.scores.beatTrapIds[id_] == nil then
        self.scores.beatTrapIds[id_] = 1
    else
        self.scores.beatTrapIds[id_] = self.scores.beatTrapIds[id_] + 1
    end
end
-- 收集到 活动道具, 就是两种 Coin
function ParkourGameMgr:Add_ActivityGoods(id_)
    id_ = tostring(id_)
    if self.scores.activityGoodsIds[id_] == nil then
        self.scores.activityGoodsIds[id_] = 1
    else
        self.scores.activityGoodsIds[id_] = self.scores.activityGoodsIds[id_] + 1
    end
end


-- 总结计算积分
function ParkourGameMgr:SumUpScores()
    ---@type ParkourGameUtil
    local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")
    ---
    self.scores.isUnwounded = self.player:IsUnwounded() and 1 or 0
    ---
    self.scores.score = 0
    self.scores.coinScore = 0      -- 货币积分 -
    self.scores.moveScore = 0      -- 前进距离积分 -
    self.scores.gainGoodScore = 0  -- 增益积分 -
    self.scores.beatTrapScore = 0  -- 陷阱积分 -
    self.scores.bossScore = 0      -- boss击退积分 -
    self.scores.invisibleScore = 0 -- 开启隐身技能 积分

    -- 货币积分
    self.scores.coinScore = checkInt(ParkourGameUtil.GetMiniWorldBuffItemVo(ParkourGameUtil.activityGoodsId).score) * 
                            self:GetActivityGoodsNum()

    -- 前进距离积分: 
    self.scores.moveScore = checkInt(self.gameRunner.tracks[3].moveDistance) * 
                            checkInt(ParkourGameUtil.GetVoParamValue(ParkourGameUtil.VoParamsId.InfiniteMode_MoveMultiplier))

    -- 增益道具 积分:
    for id, num in pairs(self.scores.gainGoodIds) do
        id = checkInt(id)
        local vo = ParkourGameUtil.GetMiniWorldBuffItemVo(id)
        local val = checkInt(vo.score) * num
        self.scores.gainGoodScore = self.scores.gainGoodScore + val
    end

    -- 击败踩到的陷阱 积分:
    for id, num in pairs(self.scores.beatTrapIds) do
        id = checkInt(id)
        local vo = ParkourGameUtil.GetMiniWorldTrapVo(id)
        local val = checkInt(vo.score) * num
        self.scores.beatTrapScore = self.scores.beatTrapScore + val
    end

    -- boss 积分:
    local bossId = ParkourGameUtil.GetVoParamValue(ParkourGameUtil.VoParamsId.BossId)
    self.scores.bossScore = checkInt(self.scores.bossRunAwayNums) * checkInt(ParkourGameUtil.GetMiniWorldTrapVo(bossId).score)


    -- 收集到的活动道具
    for id, num in pairs(self.scores.activityGoodsIds) do
        id = checkInt(id)
        local vo = ParkourGameUtil.GetMiniWorldBuffItemVo(id)
        self.scores.score = self.scores.score + checkInt(vo.score) * num
    end

    -- 开启隐身技能 积分:
    self.scores.invisibleScore = checkInt(self.scores.invisibleTimes) * 
                                checkInt(ParkourGameUtil.GetVoParamValue(ParkourGameUtil.VoParamsId.InfiniteMode_InvisibleScore))

    -- ==
    self.scores.score = self.scores.coinScore +      -- 货币积分 -
                        self.scores.moveScore +      -- 前进距离积分 -
                        self.scores.gainGoodScore +  -- 增益积分 -
                        self.scores.beatTrapScore +  -- 陷阱积分 -
                        self.scores.bossScore +      -- boss击退积分 -
                        self.scores.invisibleScore -- 开启隐身技能 积分

end




---获取活动体力道具id
function ParkourGameMgr:GetActivityHPId()
    if not self.homeDojo then
        return 0
    end
    local scheduleConf = self.homeDojo.scheduleConf
    return checkNumber(scheduleConf.energyId)
end

---显示活动体力tips
function ParkourGameMgr:ShowTipsCountDown(targetNode, title, description, rare, id, isShowNumText)
    ResourceModule.LoadGameObjectAsync("Prefabs/ActivityDreamAdventures12000801/ActivityDreamAdventuresStaminaTipsCountdown.prefab", function(go)
        if not KTool.IsNull(go) and not KTool.IsNull(targetNode) then
            go.name = "StaminaTipsCountdown"
            if not KTool.IsNull(go) and not KTool.IsNull(targetNode) then
                local script = GetLuaBehaviour(go, "Game.Activity.DreamAdventures.DreamAdventuresStaminaTipsCountDown")
                if not KTool.IsNull(script) then
                    script.Env:SetTimerType(2)
                    script.Env:RefreshBoardByContent(title, description, rare, id, isShowNumText)
                    script.Env:FixBoardPosition(targetNode)
                end
            end
        end
    end, true, UIModule.RootCanvas.transform)
end

function ParkourGameMgr:GetActivityDojo()
    return ActivityMgr:GetActivityComponent():GetDojoByActivityId(self.activityUuid)
end

---IsActive @ 判断活动是否开启
function ParkourGameMgr:IsActive()
    local activityDojo = self:GetActivityDojo()
    if isNull(activityDojo) then
        return false
    end
    local startTime = checkNumber(activityDojo.startTime)
    local endTime = checkNumber(activityDojo.endTime)
    ---@type PlayerComponent
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local curTime = comp:GetPlayerDojo():GetServerTimeWithTimeZone()
    return curTime >= startTime and curTime <= endTime
end

function ParkourGameMgr:GetConfigParamsById(id)
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6441, "LadderParameterVo", id)
    if vo == nil then
        printError("食契活动参数表 中未找到 %s", id)
        return 0
    end
    return vo.num
end

---购买活动体力
function ParkourGameMgr:BuyActivityHp()
    local activityDojo = self:GetActivityDojo()
    if not self:IsActive() then
        GameUtils.Toast(localize("活动已结束"))
        return
    end

    local maxLimit = self:GetConfigParamsById(ParamsDefine.HP_UP_LIMIT)
    local num = self:GetConfigParamsById(ParamsDefine.BUY_NUM)
    local consumeGoodsId = self:GetConfigParamsById(ParamsDefine.BUY_CONSUME_ITEM)
    local consumeGoodsNum = self:GetConfigParamsById(ParamsDefine.BUY_CONSUME_ITEM_NUM)
    local buyTimes = checkInt(self.homeDojo.hpData.buyTimes)
    local maxBuyLimit = self:GetConfigParamsById(ParamsDefine.BUY_DAILY_TIME_LIMIT)
    local maxBuyNum = 1
    if checkInt(buyTimes) >= checkInt(maxBuyLimit) then
        maxBuyNum = 0
    end
    local consumeNums = parse_strings(consumeGoodsNum)
    local consumeNum = consumeNums[buyTimes + 1] or consumeNums[#consumeNums]
    local prices = { { currency = checkInt(consumeGoodsId), current = checkInt(consumeNum) } }
    local activityTips = localize('今日剩余兑换次数: _num_', { _num_ = checkInt(maxBuyLimit) - buyTimes })
    local consume = { goodsId = consumeGoodsId, num = consumeNum }

    UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonBuyItemDialog, parameters = {
        goodsId = self:GetActivityHPId(),
        goodsNum = num,
        isShowNum = true,
        maxHaveNum = checkInt(maxLimit),
        prices = prices,
        maxBuyNum = maxBuyNum,
        activityTips = activityTips,
        buyCb = function(price, buyNum)
            GameUtils.Request("ActivityTinyWorld/buyHp", { consume = table.serialize(consume), activityUuid = activityDojo.id }, function(request, response)
                local showRewards = clone(response.data.rewards)
                table.insert(response.data.rewards, {
                    goodsId = consumeGoodsId,
                    num = -consumeNum
                })
                GoodsUtils.DrawRewards(response.data.rewards, true)
                local dojo = self.homeDojo.hpData
                self.homeDojo.hpData = checkTable(response.data.hp)
                --local hpInfo = checkTable(response.data.hpInfo)
                --dojo.buyTimes = checkInt(dojo.buyTimes) + 1
                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = showRewards } })
            end)
        end
    } })
end

function ParkourGameMgr:StartTimer()
    self:CloseTimer()
    self.timer = CDTimerModule.GetInstance():AddCD(1, function(_, _, delta)
        xTry(function()
            local dojo = self.homeDojo
            if isNull(dojo) then return end
            -- 体力已经恢复满，停止倒计时
            if self:IsHPFull() then
                dojo.hpData.lastCdTime = 0
                self:BroadcastHPChangeEvent(true, 0, 0)
                self:CloseTimer()
                return
            end

            if dojo.hpData.lastCdTime <= 0 then
                dojo.hpData.lastCdTime = checkNumber(self:GetConfigParamsById(ParamsDefine.RESTORE_HP_INTERVAL))
            end
            self:SubCDTime(delta)
        end)
    end, CountDownTime, true, true)
end

---移除定时器
function ParkourGameMgr:CloseTimer()
    if isNotNull(self.timer) then
        CDTimerModule.GetInstance():RemoveCD(self.timer)
        self.timer = nil
    end
end

function ParkourGameMgr:GetActivityHP()
    local dojo = self.homeDojo
    if not dojo or not dojo.hpData then
        return 0
    end
    return checkNumber(dojo.hpData.hp)
end
---判断活动体力是否回满
function ParkourGameMgr:IsHPFull()
    local ownCount = self:GetActivityHP()
    local max = checkNumber(self:GetConfigParamsById(ParamsDefine.HP_UP_LIMIT))
    return checkNumber(ownCount) >= max
end

---广播hp变动事件
function ParkourGameMgr:BroadcastHPChangeEvent(isFull, cd, totalCD)
    if Events.HasListener('MINI_WORLD_COUNT_DOWN') then
        Events.Broadcast('MINI_WORLD_COUNT_DOWN', isFull, cd, totalCD)
    end
end

---定时器处理
function ParkourGameMgr:SubCDTime(delta)
    local dojo = self.homeDojo
    dojo.hpData.lastCdTime = checkNumber(dojo.hpData.lastCdTime) - checkNumber(delta)
    -- 通知注册者数值发生了变化
    local goodsNum = GoodsUtils.GetThingNo(self:GetActivityHPId())
    local max = checkNumber(self:GetConfigParamsById(ParamsDefine.HP_UP_LIMIT))
    local hpRecoverSeconds = checkNumber(self:GetConfigParamsById(ParamsDefine.RESTORE_HP_INTERVAL))
    local recoveryHpPerTime = checkNumber(self:GetConfigParamsById(ParamsDefine.RESTORE_NUM))
    self:BroadcastHPChangeEvent(false, checkInt(dojo.hpData.lastCdTime), checkInt(dojo.hpData.lastCdTime + (max - goodsNum - 1) * checkInt(hpRecoverSeconds)))
    --local mod = (math.abs(dojo.hpData.lastCdTime) - 1) % hpRecoverSeconds    -- 溢出mod秒
    --local left = (math.abs(dojo.hpData.lastCdTime) - 1) / hpRecoverSeconds   -- 溢出left体力
    --print("===>>", mod, left, recoveryHpPerTime)
    if checkNumber(dojo.hpData.lastCdTime) <= 0 then
        -- 开始恢复体力
        local mod = (math.abs(dojo.hpData.lastCdTime) - 1) % recoveryHpPerTime    -- 溢出mod秒
        local left = (math.abs(dojo.hpData.lastCdTime) - 1) / hpRecoverSeconds   -- 溢出left体力
        local recoverCount = (left + 1) * recoveryHpPerTime

        print("CHANG DEBUG：实际恢复的体力:" .. checkString(recoverCount))
        GoodsUtils.DrawRewards({
            {
                goodsId = self:GetActivityHPId(),
                num = checkInt(recoverCount)
            }
        }, true)
        dojo.hpData.hp = checkNumber(dojo.hpData.hp) + checkInt(recoverCount)
        -- 重置倒计时
        dojo.hpData.lastCdTime = hpRecoverSeconds - mod
        self:StartTimer()
    end
end

return ParkourGameMgr
