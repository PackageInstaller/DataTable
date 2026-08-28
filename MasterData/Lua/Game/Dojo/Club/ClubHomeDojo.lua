-------------------------------------------------------------------------------
-- 社团 - 社团主界面数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-26 20:13:07
-------------------------------------------------------------------------------

local BaseDojo        = import('Game.Dojo.BaseDojo')
local ClubMemberDojo  = import('Game.Dojo.Club.ClubMemberDojo')
local ImpeachmentDojo = import('Game.Dojo.Club.ClubImpeachmentDojo')
local ClubGVGUtils    = import('Game.UI.Club.GVG.ClubGVGUtils')

---@class ClubHomeDojo : BaseDojo
---@field New fun():ClubHomeDojo
local ClubHomeDojo = Class('ClubHomeDojo', BaseDojo)


function ClubHomeDojo:__init()
    ---@type integer @ 社团id
    self.clubId = 0

    ---@type string @ 社团名字
    self.name = ''

    ---@type integer @ 社团等级
    self.level = 0

    ---@type integer @ 社团头像
    self.avatar = 0

    ---@type ClubUtils.ApplyType @ 申请类型
    self.applyType = ClubUtils.ApplyType.APPLY

    ---@type integer @ 申请等级
    self.applyLevel = 1

    ---@type string @ 社团公告
    self.notice = ''

    ---@type integer @ 社团捐献值
    self.contributionPoint = 0

    ---@type table<ClubUtils.BuildType, integer>
    self.leftBuildTimesMap = {}

    ---@type ClubMemberDojo[] 
    self.memberList = {}

    ---@type ClubMemberDojo
    self.myselfDojo = nil

    ---@type string[] @ 会长餐厅装扮
    self.presidentAvatars = {}

    ------------------------------------------------- [impeachment]

    ---@type ClubImpeachmentDojo @ 社团弹劾数据
    self.impeachmentDojo = ImpeachmentDojo.New()

    ---@type boolean @ 是否开启了弹劾
    self.isOpenImpeachment = false

    ------------------------------------------------- [boss]

    ---@type integer @ 社团Boss 当前排期Id
    self.bossScheduleId = 0

    ---@type integer @ 社团Boss 下一期ID
    self.nextScheduleId = 0
    
    ---@type integer @ 社团Boss 开始时间戳
    self.bossStartTime = 0

    ---@type integer @ 社团Boss 开始时间戳
    self.bossEndTime = 0

    ---@type integer @ 社团Boss 每日次数剩余次数
    self.bossLeftTimes = 0

    -- FIXME 最好转成dojo
    ---@type table @ 社团Boss 排名数据 { clubRanking : 社团排名, myRanking : 我的排名, rewards : 奖励 }
    self.bossResultInfo = {}

    ---@type integer @ 社团Boss 上一期排名
    self.bossLastRanking = 0

    ------------------------------------------------- [car]

    ---@type integer @ 社团喵车 当前排期Id
    self.carScheduleId = 0

    ---@type integer @ 社团喵车 下一期ID
    self.carNextScheduleId = 0
    
    ---@type integer @ 社团喵车 开始时间戳
    self.carStartTime = 0

    ---@type integer @ 社团喵车 开始时间戳
    self.carEndTime = 0

    ------------------------------------------------- [gvg]
    ---@type integer @ 社团GVG 本周期活跃度
    self.gvgActivityPoint = 0

    ---@type integer @ 社团GVG 当前排期Id
    self.gvgScheduleId = 0

    ---@type integer @ 社团GVG 下一期ID
    self.gvgNextScheduleId = 0

    ---@type integer @ 社团GVG 开始时间戳（GVG排期表 开始时间）
    self.gvgStartTime = 0

    ---@type integer @ 社团GVG 结束时间戳（GVG排期表 结束时间）
    self.gvgEndTime = 0

    ---@type integer @ 社团GVG 报名-开始时间戳（GVG参数表 ID25 + ID4）
    self.gvgApplyStartTime = 0

    ---@type integer @ 社团GVG 报名-结束时间戳（GVG参数表 ID25 + ID5 - ID12）
    self.gvgApplyEndTime = 0

    ---@type integer @ 社团GVG 战斗-进入时间戳（GVG参数表 ID11）
    self.gvgBattleEnterTime = 0

    ---@type integer @ 社团GVG 战斗-开始时间戳（GVG参数表 ID25 + ID5）
    self.gvgBattleStartTime = 0

    ---@type string @ 社团GVG 长连接address
    self.gvgHost = ""

    ---@type boolean @ 社团GVG 是否已报名
    self.isGvgApplied_ = false

    ---@type integer[] @ 社团GVG 参与成员id记录
    self.gvgSingPlayerMap = {}

    ---@type string @ 强更包链接地址
    self.gvgUpdateUrl = ""
end


function ClubHomeDojo:__delete()
    self.clubId             = nil
    self.name               = nil
    self.level              = nil
    self.avatar             = nil
    self.applyType          = nil
    self.applyLevel         = nil
    self.notice             = nil
    self.contributionPoint  = nil
    self.leftBuildTimesMap  = nil
    self.memberList         = nil
    self.myselfDojo         = nil
    self.presidentAvatars   = nil
    --                      = impeachment
    self.impeachmentDojo    = nil
    self.isOpenImpeachment  = nil
    --                      = boss
    self.bossScheduleId     = nil
    self.nextScheduleId     = nil
    self.bossResultInfo     = nil
    self.bossLastRanking    = nil
    self.bossLeftTimes      = nil
    self.bossStartTime      = nil
    self.bossEndTime        = nil
    --                      = car
    self.carScheduleId      = nil
    self.carNextScheduleId  = nil
    self.carStartTime       = nil
    self.carEndTime         = nil
    --                      = gvg
    self.gvgActivityPoint   = nil
    self.gvgScheduleId      = nil
    self.gvgNextScheduleId  = nil
    self.gvgStartTime       = nil
    self.gvgEndTime         = nil
    self.gvgApplyStartTime  = nil
    self.gvgApplyEndTime    = nil
    self.gvgBattleEnterTime = nil
    self.gvgBattleStartTime = nil
    self.isGvgApplied_      = nil
    self.gvgSingPlayerMap   = nil
end


function ClubHomeDojo:Fill(jsonData)
    BaseDojo.Fill(self, jsonData)
    
    -- 申请条件
    local applyData = checkTable(jsonData.applyPermission)
    self.applyType  = checkInt(applyData.type)
    self.applyLevel = checkInt(applyData.levelLimit)

    -- 成员列表
    self.myselfDojo = nil
    self.memberList = {}
    local myselfId  = checkInt(GameUtils.GetPlayerId())
    for memberIndex, memberData in ipairs(checkTable(jsonData.member)) do
        local memberDojo = ClubMemberDojo.New()
        memberDojo:Fill(memberData)
        self.memberList[memberIndex] = memberDojo

        if checkInt(memberDojo.playerId) == myselfId then
            self.myselfDojo = memberDojo
        end
    end

    -- 建造次数
    self.leftBuildTimesMap = {}
    for buildType, leftTimes in pairs(checkTable(jsonData.leftBuildTimes)) do
        self.leftBuildTimesMap[checkInt(buildType)] = checkInt(leftTimes)
    end

    -- 弹劾Dojo
    self.isOpenImpeachment = checkInt(jsonData.isOpenImpeachment) == 1
    self.impeachmentDojo:Fill(checkTable(jsonData.impeachmentData))

    -- 社团boss
    self.bossScheduleId  = checkInt(jsonData.bossScheduleId)
    self.nextScheduleId  = checkInt(jsonData.nextScheduleId)
    self.bossStartTime   = checkInt(jsonData.bossStartTime)
    self.bossEndTime     = checkInt(jsonData.bossEndTime)
    self.bossLeftTimes   = checkInt(jsonData.dailyBossAtTimesLeft)
    self.bossLastRanking = checkInt(jsonData.clubLastRanking)
    self.bossResultInfo  = checkTable(jsonData.clubRankInfo)

    -- 社团喵车
    self.carScheduleId     = checkInt(jsonData.carScheduleId)
    self.carNextScheduleId = checkInt(jsonData.carNextScheduleId)
    self.carStartTime      = checkInt(jsonData.carStartTime)
    self.carEndTime        = checkInt(jsonData.carEndTime)

    -- 社团GVG
    self.gvgActivityPoint  = checkInt(jsonData.gvgActivityPoint)
    self.gvgScheduleId     = checkInt(jsonData.gvgScheduleId)
    self.gvgNextScheduleId = checkInt(jsonData.gvgNextScheduleId)
    self.gvgStartTime      = checkInt(jsonData.gvgStartTime)
    self.gvgEndTime        = checkInt(jsonData.gvgEndTime)
    self.isGvgApplied_     = checkInt(jsonData.gvgApplyState) == 1  -- （0：未参与，1：已报名）
    self.gvgSingPlayerMap  = {}
    for _, playerId in ipairs(checkTable(jsonData.gvgSingPlayerIds)) do
        self.gvgSingPlayerMap[checkInt(playerId)] = true
    end
    if self.gvgStartTime > 0 then
        self.gvgUpdateUrl        = checkString(jsonData.gvgUpdateUrl)
        self.gvgHost             = checkString(jsonData.gvgHost)
        local openingDaySeconds  = ClubGVGUtils.GetParamValue(ClubGVGUtils.Constants.ParamsId.OpeningDayNum)
        local battleStartSeconds = ClubGVGUtils.GetParamValue(ClubGVGUtils.Constants.ParamsId.BattleStartSeconds)
        local applyStartSeconds  = checkInt(timestamp_to_time((self.gvgStartTime - GameUtils.ToClientTimestamp(0))).hour) * 3600
        self.gvgApplyStartTime   = self.gvgStartTime + openingDaySeconds
        self.gvgBattleStartTime  = self.gvgStartTime + openingDaySeconds - applyStartSeconds + battleStartSeconds
        self.gvgApplyEndTime     = self.gvgBattleStartTime - ClubGVGUtils.GetParamValue(ClubGVGUtils.Constants.ParamsId.ApplyEndOffsetSeconds)
        self.gvgBattleEnterTime  = self.gvgBattleStartTime - ClubGVGUtils.GetParamValue(ClubGVGUtils.Constants.ParamsId.BattleEnterOffsetSeconds)
        logs('>> GVG排期ID：', self.gvgScheduleId, 'next =', self.gvgNextScheduleId, 'hour =', applyStartSeconds / 3600)
        logs('>> 服务器时间：', os.date("%Y-%m-%d %H:%M:%S", GameUtils.GetServerTime()))
        logs('>> 排期开始时间：', os.date("%Y-%m-%d %H:%M:%S", self.gvgStartTime))
        logs('>> 报名开始时间：', os.date("%Y-%m-%d %H:%M:%S", self.gvgApplyStartTime))
        logs('>> 报名截止时间：', os.date("%Y-%m-%d %H:%M:%S", self.gvgApplyEndTime))
        logs('>> 战斗进入时间：', os.date("%Y-%m-%d %H:%M:%S", self.gvgBattleEnterTime))
        logs('>> 战斗开始时间：', os.date("%Y-%m-%d %H:%M:%S", self.gvgBattleStartTime))
        logs('>> 战斗结束时间：', os.date("%Y-%m-%d %H:%M:%S", self.gvgEndTime))
    end

end


--- 增加自己的贡献值
---@param addPoint integer
function ClubHomeDojo:AddMySelfPoint(addPoint)
    if self.myselfDojo then
        self.myselfDojo:AddPoint(addPoint)
    end
    self.gvgActivityPoint = self.gvgActivityPoint + checkInt(addPoint)
end


------------------------------------------------- [build]

--- 获取剩余建造次数
---@param buildType ClubUtils.BuildType
---@return integer
function ClubHomeDojo:GetBuildLeftTimes(buildType)
    return checkInt(self.leftBuildTimesMap[checkInt(buildType)])
end


--- 设置剩余建造次数
---@param buildType ClubUtils.BuildType
function ClubHomeDojo:SetBuildLeftTimes(buildType, leftTimes)
    self.leftBuildTimesMap[checkInt(buildType)] = checkInt(leftTimes)
end


------------------------------------------------- [boss]

--- 是否 开放社团boss入口
---@return boolean
function ClubHomeDojo:IsOpenedBossEntry()
    return GameUtils.IsSwitchedBySystemTogId(Constants.SystemToggleIds.Id4004) and self.bossScheduleId ~= 0 or self.nextScheduleId ~= 0
end


--- 是否 社团boss进行中
---@return boolean
function ClubHomeDojo:IsBossEntryOpening()
    return not (self.bossScheduleId == 0 and self.nextScheduleId ~= 0)
end


------------------------------------------------- [cat]

--- 是否 开放社团喵车入口
---@return boolean
function ClubHomeDojo:IsOpenedCarEntry()
    return GameUtils.IsSwitchedBySystemTogId(Constants.SystemToggleIds.Id4005) and (self.carScheduleId ~= 0 or self.carNextScheduleId ~= 0)
end


--- 是否 社团喵车进行中
---@return boolean
function ClubHomeDojo:IsCarEntryOpening()
    return not (self.carScheduleId == 0 and self.carNextScheduleId ~= 0)
end


------------------------------------------------- [gvg]

--- 是否 开放社团GVG入口
---@return boolean
function ClubHomeDojo:IsOpenedGvgEntry()
    return GameUtils.IsSwitchedBySystemTogId(Constants.SystemToggleIds.Id4006) and (self.gvgScheduleId ~= 0 or self.gvgNextScheduleId ~= 0)
end


--- 是否 社团GVG进行中
---@return boolean
function ClubHomeDojo:IsGvgEntryOpening()
    return not (self.gvgScheduleId == 0 and self.gvgNextScheduleId ~= 0)
end


--- 是否 社团GVG参与报名
---@return boolean
function ClubHomeDojo:IsGvgApplied()
    return self.isGvgApplied_  -- 先封装一下，以防改成多种状态
end


--- 更改 社团GVG报名状态
---@param isApplied boolean
function ClubHomeDojo:SetGvgApplyState(isApplied)
    self.isGvgApplied_ = checkBool(isApplied)
    Events.Broadcast(ClubUtils.EventName.GVG_APPLY_SUCCESS)
end


--- 是否 社团GVG足够捐献度
---@param playerId integer
---@return boolean
function ClubHomeDojo:IsGvgSingEnable(playerId)
    return checkBool(self.gvgSingPlayerMap[checkInt(playerId)])
end

---设置gvg长连接地址
function ClubHomeDojo:SetGVGHost(host)
    self.gvgHost = host
end

---设置gvg结束时间
function ClubHomeDojo:SetGVGEndTime(gvgEndTime)
    self.gvgEndTime = checkNumber(gvgEndTime)
end

return ClubHomeDojo
