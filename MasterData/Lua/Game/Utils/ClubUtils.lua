-------------------------------------------------------------------------------
-- 社团 - 工具类
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-25 14:08:12
-------------------------------------------------------------------------------

---@class ClubUtils
local ClubUtils = {}

---@type table<ClubUtils.ParamsId, integer>
ClubUtils.paramValueMap_ = {}


---@alias ClubUtils.ParamsId integer @ 社团参数id
ClubUtils.ParamsId = {
    REFRESH_CLUB_NUM            = 1,  -- 社团列表 显示的社团个数（客户端不用）
    REFRESH_CLUB_CD             = 2,  -- 社团列表 手动刷新cd（秒）
    NAME_LENGTH                 = 3,  -- 社团名字 字数上限
    NOTICE_LENGTH               = 4,  -- 社团公告 字数上限
    BUILD1_USE_GID              = 5,  -- 普通建设 消耗道具id
    BUILD1_USE_GNUM             = 6,  -- 普通建设 消耗道具数量
    BUILD2_USE_GID              = 7,  -- 高级建设 消耗道具id
    BUILD2_USE_GNUM             = 8,  -- 高级建设 消耗道具数量
    BUILD1_GET_GID              = 9,  -- 普通建设 获得道具id
    BUILD1_GET_GNUM             = 10, -- 普通建设 获得道具数量
    BUILD2_GET_GID              = 11, -- 高级建设 获得道具id
    BUILD2_GET_GNUM             = 12, -- 高级建设 获得道具数量
    BUILD1_DO_NUM               = 29, -- 普通建设 次数（客户端不用）
    BUILD2_DO_NUM               = 30, -- 高级建设 次数（客户端不用）
    BUILD1_GET_EXP              = 20, -- 普通建设 社团获得经验
    BUILD2_GET_EXP              = 21, -- 高级建设 社团获得经验
    QUIT_PROTECT_CD             = 14, -- 退出社团 保护cd（小时）
    LOG_STASH_DAY               = 15, -- 社团日志 记录保持天数
    APPLY_CLUB_NUM              = 16, -- 社团申请 玩家同时申请的数量（客户端不用）
    APPLY_EXPIRE_DAY            = 17, -- 社团申请 x天未处理就清除（客户端不用）
    APPLY_MEMBER_NUM            = 18, -- 社团申请 收到的名额上限（客户端不用）
    APPLY_LEVEL_MAX             = 31, -- 社团申请 加入的等级上限
    CREATE_USE_GID              = 22, -- 创建社团 消耗道具id
    CREATE_USE_GNUM             = 23, -- 创建社团 消耗道具数量
    RENAME_USE_GID              = 24, -- 社团改名 消耗道具id
    RENAME_USE_GNUM             = 25, -- 社团改名 消耗道具数量
    CLUB_EXP_ID                 = 19, -- 社团经验id
    DEFAULT_HEAD                = 26, -- 社团头像默认
    BOSS_CHALLENGE_REWARD_TIMES = 33, -- 社团Boss 挑战超过这个次数才有奖励
    BOSS_CHALLENGE_COUNT        = 34, -- 社团Boss 挑战次数
    TOTAL_CHALLENGE_COUNT       = 39, -- 社团Boss 所有成员挑战总次数
    Recruit_ConsumeId           = 42, -- 社团招募 喊话消耗道具 ID
    Recruit_ConsumeNum          = 43, -- 社团招募 喊话消耗数量 NUM
    OfflineRecruit_ConsumeId    = 44, -- 离线招募喊话推送总数
    
    ---猫车
    Dice_Submit_Count           = 45, -- 骰子提交次数
    Dice_Reset_Free_Count       = 46, -- 免费骰子重置次数
    Dice_Reset_Pay_Count        = 47, -- 骰子重置总次数
    Dice_Reset_Pay_GID          = 48, -- 付费骰子消耗道具id
    Dice_Reset_Pay_Num          = 49, -- 付费骰子消耗道具数量
    Dice_Convert_Point          = 50, -- 转化为1张刮刮乐的点数
    Speed_Stage_Days            = 51, -- 猫车竞速阶段天数
    Boss_Stage_Days             = 52, -- 猫车打BOS天数
    Lottery_Stage_Days          = 53, -- 猫车抽奖天数
    Lottery_Record_Keep         = 54, -- 猫车刮刮乐记录保留数量
    Rank_Reward_Min_Count       = 55, -- 领取猫车排行榜奖励最低参与次数
    Boss_Limit_Fight_Count      = 56, -- 猫车BOSS限制战斗次数
    Car_Distance_Ratio            = 61, -- 1分数差对应猫车距离比例
}


---@alias ClubUtils.EventName string @ 社团事件名字
ClubUtils.EventName = {
    JOIN_SUCCED              = 'OVERSEA_CLUB.JOIN_SUCCED',              -- 社团 加入成功
    KICKOUT_SELF             = 'OVERSEA_CLUB.KICKOUT_SELF',             -- 社团 被提出去
    UPDATE_INFO              = 'OVERSEA_CLUB.UPDATE_INFO',              -- 社团更新 信息
    UPDATE_NAME              = 'OVERSEA_CLUB.UPDATE_NAME',              -- 社团更新 名字
    UPDATE_NOTICE            = 'OVERSEA_CLUB.UPDATE_NOTICE',            -- 社团更新 公告
    UPDATE_EXP               = 'OVERSEA_CLUB.UPDATE_EXP',               -- 社团更新 经验
    UPDATE_MEMBERS           = 'OVERSEA_CLUB.UPDATE_MEMBERS',           -- 社团更新 成员数
    UPDATE_MEMBER_JOB        = 'OVERSEA_CLUB.UPDATE_MEMBER_JOB',        -- 社团更新 成员职位
    ACTIVITY_BOSS_DIED       = 'OVERSEA_CLUB.ACTIVITY_BOSS_DIED',       -- 社团Boss 死亡
    ACTIVITY_ENTRY_COUNTDOWN = 'OVERSEA_CLUB.ACTIVITY_ENTRY_COUNTDOWN', -- 社团活动 入口倒计时
    GVG_APPLY_SUCCESS        = 'OVERSEA_CLUB.GVG_APPLY_SUCCESS',        -- 社团GVG 报名成功
    
    ---猫车
    Dice_Submit              = 'OVERSEA_CLUB.DICE_SUBMIT',              -- 骰子提交
    Dice_Call                = 'OVERSEA_CLUB.DICE_CALL',                -- 投骰子
    Loading_End              = 'OVERSEA_CLUB.LOADING_END',              -- loading界面end
    MileageSettlement_Open  = 'OVERSEA_CLUB.MILEAGE_SETTLEMENT_START', -- 里程结算开始
    MileageSettlement_Close   = 'OVERSEA_CLUB.MILEAGE_SETTLEMENT_END',   -- 里程结算关闭

    ---社团投喂神兽
    FeedCat_Open             = 'OVERSEA_CLUB.FEED_CAT_OPEN',            -- 社团投喂神兽 打开
    FeedCat_Close            = 'OVERSEA_CLUB.FEED_CAT_CLOSE',           -- 社团投喂神兽 关闭
    FeedCat_ChooseFood       = 'OVERSEA_CLUB.FEED_CAT_CHOOSE_FOOD',     -- 选择食物
    FeedCat_FeedSuccess      = 'OVERSEA_CLUB.FEED_CAT_FEED_SUCCESS',    -- 投喂成功
    FeedCat_LevelUp          = 'OVERSEA_CLUB.FEED_CAT_LEVEL_UP',        -- 升级
    FeedCat_PhaseUp          = 'OVERSEA_CLUB.FEED_CAT_PHASE_UP',        -- 阶段升级
    FeedCat_RefineCoinChange = 'OVERSEA_CLUB.FEED_CAT_REFINE_COIN_CHANGE', -- 洗练币变化
    FeedCat_CatClick         = 'OVERSEA_CLUB.FEED_CAT_CAT_CLICK',       -- 点击神兽模型

    ---大厅
    ENTER_SCENE              = 'OVERSEA_CLUB.ENTER_SCENE',             -- 进入大厅
    EXIT_SCENE               = 'OVERSEA_CLUB.EXIT_SCENE',              -- 离开大厅
    SYNC_POSITION            = 'OVERSEA_CLUB.SYNC_POSITION',           -- 同步位置
    DO_INTERACTION           = 'OVERSEA_CLUB.DO_INTERACTION',          -- 互动动画
}


---@alias ClubUtils.ApplyType integer @ 社团申请类型
ClubUtils.ApplyType = {
    FREE  = 0,  -- 自由加入
    APPLY = 1,  -- 需要审批
}


---@alias ClubUtils.BossType integer @ 社团Boss挑战类型
ClubUtils.BossType = {
    NormalBoss = 1,
    BigBoss = 2,
}


---@alias ClubUtils.BossRankType integer @ 社团Boss排行类型
ClubUtils.BossRankType = {
    AllServerClub = 1,   -- 全服社团排名
    ClubMember = 2,      -- 社团内成员排名
    Personnel = 3,       -- 全服个人排名
}


---@alias ClubUtils.RecordType integer @ 社团Boss记录类型
ClubUtils.RecordType = {
    Club = 1,     -- 社团记录
    MySelf = 2,   -- 我的记录
}


---@alias ClubUtils.BuildType integer @ 社团建造类型
ClubUtils.BuildType = {
    NORMAL   = 1,  -- 普通的
    ADVANCED = 2,  -- 高级的
}


---@alias ClubUtils.JobType integer @ 社团职位类型
ClubUtils.JobType = {
    CHAIRMAN    = 101, -- 社长
    SUBCHAIRMAN = 201, -- 副社长
    MEMBER      = 301, -- 社员
    MEMBER_REFINE_FEEDCATSKIN = 401, -- 社员，拥有投喂神兽功能的皮肤洗练权限
}


---@alias ClubUtils.JobFuncId integer @ 社团职位职能id
ClubUtils.JobFuncId = {
    MODIFY_INFO    = 1,  -- 修改公会信息
    MODIFY_NOTICE  = 2,  -- 修改公告内容
    JOB_MANAGER    = 3,  -- 成员任命职位
    APPLY_MANAGE   = 4,  -- 操作申请列表
    KICKOUT_MEMBER = 5,  -- 踢出社团
    CLUB_RECRUIT   = 6,  -- 社团招募
    GVG_APPLY      = 7,  -- 社团GVG报名
    FEEDCAT_REFINE_SKIN = 8,  -- 投喂神兽功能,洗练权限
}


---@alias ClubUtils.ImpeachmentState integer @ 社团弹劾状态
ClubUtils.ImpeachmentState = {
    VOTEABLE = 0, -- 可投票
    AGREED   = 1, -- 已同意
    REFUSED  = 2, -- 已拒绝
}


---@alias ClubUtils.ActivityEntryType integer @ 社团活动入口id
ClubUtils.ActivityEntryType = {
    BOSS    = 1,  -- 特训（社团boss）
    CAT_CAR = 2,  -- 猫车
    GVG     = 3,  -- GVG
}


-------------------------------------------------------------------------------
-- about conf
-------------------------------------------------------------------------------

--- 根据参数id 获取 社团参数表
---@param paramId ClubUtils.ParamsId
---@return ClubParamsVo
function ClubUtils.GetParamVo(paramId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6001, 'Club.ClubParamsVo', paramId) or {}
end


--- 根据职位id 获取 社团职位表
---@param jobId integer
---@return ClubJobVo
function ClubUtils.GetJobVo(jobId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6002, 'Club.ClubJobVo', jobId) or {}
end


--- 根据等级 获取 社团等级表
---@param level integer
---@return ClubLevelVo
function ClubUtils.GetLevelVo(level)
    return CfUtils.GetCfVo(AutoIds.IdSetting6003, 'Club.ClubLevelVo', level) or {}
end


--- 获取 社团最大等级
---@return integer
function ClubUtils.GetLevelMax()
    if not ClubUtils.clubLevelMax_ then
        local clubLevelVoList = CfUtils.GetWholeVo(AutoIds.IdSetting6003, 'Club.ClubLevelVo')
        ClubUtils.clubLevelMax_ = #clubLevelVoList
    end
    return ClubUtils.clubLevelMax_
end


--- 根据参数id 获取参数值
---@param paramId ClubUtils.ParamsId
---@return number
function ClubUtils.GetParamValue(paramId)
    local paramValue = ClubUtils.paramValueMap_[paramId]
    if not paramValue then
        local paramVo = ClubUtils.GetParamVo(paramId)
        paramValue = checkNumber(paramVo.paramNum)
        ClubUtils.paramValueMap_[paramId] = paramValue
    end
    return paramValue
end


--- 某个职位 是否拥有某个职能
---@param jobId ClubUtils.JobType
---@param funcId ClubUtils.JobFuncId
---@return boolean
function ClubUtils.HasJobFunc(jobId, funcId)
    local clubJobVo = ClubUtils.GetJobVo(jobId)
    return clubJobVo.HaveFunc and clubJobVo:HaveFunc(funcId) or false
end


--- 获取 直到某个等级的所需总经验
---@param level integer
function ClubUtils.GetLevelExp(level)
    local levelExp = 0
    for levelIndex = 1, checkInt(level) do
        local levelVo = ClubUtils.GetLevelVo(levelIndex) or {}
        levelExp = levelExp + checkInt(levelVo.expNum)
    end
    return levelExp
end


-------------------------------------------------------------------------------
-- about res
-------------------------------------------------------------------------------

--- 获取全部的社团头像id
---@return string[]
function ClubUtils.GetClubHeadIdList()
    local PlayerInfoUtils = import('Game.UI.Player.PlayerInfoUtils')
    return PlayerInfoUtils.GetItemIdsByKind(Constants.PlayerAvatarItemType.ClubHead) or {}
end


--- 根据社团头像id 获取头像图片路径
---@param clubHeadId integer
---@return PlayerHeadAvatarVo
function ClubUtils.GetClubHeadVo(clubHeadId)
    local PlayerInfoUtils = import('Game.UI.Player.PlayerInfoUtils')
    return PlayerInfoUtils.GetHeadAvatarVo(clubHeadId) or {}
end


-------------------------------------------------------------------------------
-- about short
-------------------------------------------------------------------------------

---@return ClubComponent
function ClubUtils.GetClubComp()
    return GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ClubComponent)
end


--- 获取 排行奖励
---@param type integer @ 类型（1名次，2百分比）
---@param rank integer @ 名次
---@return table[]
function ClubUtils.GetRankReward(type, rank)
    ---@param rankRewardVo ClubRankRewardVo
    for _, rankRewardVo in pairs(CfUtils.GetCf(AutoIds.IdSetting6098, 'Club.ClubRankRewardVo', true)) do
        if rankRewardVo.type == type then
            if rank >= checkNumber(rankRewardVo.upperLimit) and rank <= checkNumber(rankRewardVo.lowerLimit) then
                return rankRewardVo.rewards
            end
        end
    end
    return {}
end

--- 获取 排行奖励
---@param rank number @ 名次
---@return table[]
function ClubUtils.GetCatCarRankReward(rank)
    ---@param rankRewardVo ClubCatCarRankRewardVo
    for _, rankRewardVo in pairs(CfUtils.GetCf(AutoIds.IdSetting6296, 'ClubCatCarRankRewardVo', true)) do
        if rank >= checkNumber(rankRewardVo.upperLimit) and rank <= checkNumber(rankRewardVo.lowerLimit) then
            return rankRewardVo.rewards
        end
    end
    return {}
end


--- 通过皮肤id 获取 猫模型路径
---@param cardId integer
---@return string
function ClubUtils.GetCatModelPath(cardId)
    local CardConstants = import('Game.CardProgression.CardProgressionConstants')
    local cardConfMgr   = CardConfMgr:GetInstance()
    local cardRoleVo    = cardConfMgr:GetCardByRefId(cardId) or {}
    local cardSkinVo    = cardConfMgr:GetCardSkinBySkinId(cardRoleVo.defaultSkin) or {}
    local prefabPath    = string.format(CardConstants.PrefabPath.CatLobbyPath, tostring(cardSkinVo.catPrefab))
    return prefabPath
end


-------------------------------------------------------------------------------
-- about boss
-------------------------------------------------------------------------------

--- 获取 社团Boss 排期vo
---@param refId integer
---@return ClubBossActivityVo
function ClubUtils.GetBossActivityVo(refId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6107, 'Club.ClubBossActivityVo', refId) or {}
end


--- 获取 社团Boss 通关vo
---@param questId integer
---@return ClubBossPassVo
function ClubUtils.GetBossPassVo(questId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6100, 'Club.ClubBossPassVo', questId) or {}
end


--- 通过排期 获取 社团boss通关vo列表
---@param scheduleId integer
---@return ClubBossPassVo[]
function ClubUtils.GetPassPassVoByScheduleId(scheduleId)
    local bossPassVoList = {}
    local bossActivityVo = ClubUtils.GetBossActivityVo(scheduleId)
    local scheduleCopyId = checkInt(bossActivityVo.copyId)
    ---@param bossPassVo ClubBossPassVo
    for _, bossPassVo in pairs(CfUtils.GetWholeVo(AutoIds.IdSetting6100, 'Club.ClubBossPassVo')) do
        if checkInt(bossPassVo.copyId) == scheduleCopyId then
            table.insert(bossPassVoList, bossPassVo)
        end
    end
    return bossPassVoList
end


--- 是否 社团Boss 中的禁用猫
---@param catId integer
---@return boolean
function ClubUtils.IsBossLimitCat(catId)
    local bossDojo = ClubUtils.GetClubComp():GetBossDojo()
    if not isNull(bossDojo) then
        local catDisable = bossDojo:GetCatDisable()
        for i, v in pairs(catDisable) do
            if v == catId then
                return true
            end
        end
    end
    return false
end


--- 是否 社团Boss 中的禁用卡
---@param cardId integer
---@return boolean
function ClubUtils.IsBossLimitCard(cardId)
    local bossDojo = ClubUtils.GetClubComp():GetBossDojo()
    if not isNull(bossDojo) then
        local cardDisable = bossDojo:GetCardDisable()
        for i, v in pairs(cardDisable) do
            if v == cardId then
                return true
            end
        end
    end
    return false
end


--- 排序 社团Boss 挑战记录数据
---@param records table[] @ 挑战记录数据
---@param sortType Constants.SortType @ 排序方式
---@param asc boolean @ 是否升序
---@param UIType Constants.UISortType
---@return table[]
function ClubUtils.SortBossChallengeRecord(records, sortType, asc, UIType)
    records = checkTable(records)

    local fieldNames = nil
    if sortType == Constants.SortType.Time then
        fieldNames = {"time", "hurt", "round", "playerId"  }
        asc = not asc
    elseif sortType == Constants.SortType.Round then
        fieldNames = {"round", "time", "hurt", "playerId"  }
    elseif sortType == Constants.SortType.Hurt then
        fieldNames = {"hurt", "time", "round", "playerId" }
    end

    if fieldNames then
        table.sort(records, function(a, b)
            return CommonChecker(a, b, fieldNames,  asc)
        end)
    end
    return records
end


return ClubUtils
