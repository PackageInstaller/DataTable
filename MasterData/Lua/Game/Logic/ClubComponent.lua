-------------------------------------------------------------------------------
-- 社团 - 社团组件
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-26 20:06:11
-------------------------------------------------------------------------------

local ClubHomeDojo   = import('Game.Dojo.Club.ClubHomeDojo')
local ClubMemberDojo = import('Game.Dojo.Club.ClubMemberDojo')
local ClubBossDojo   = import('Game.Dojo.Club.ClubBossDojo')
local ECSComponent   = import("Frame.ECS.ECSComponent")

---@class ClubComponent : ECSComponent
local ClubComponent = Class("ClubComponent", ECSComponent)


function ClubComponent:__init()
    ---@type string
    self.name = "ClubComponent"

    ---@type ClubHomeDojo
    self.homeDojo_ = nil

    ---@type ClubBossDojo
    self.bossDojo_ = nil

    self.scenePositionData = {}

    ---gvg结束时间
    self._clubGvgEndTime = 0
end


function ClubComponent:__delete()
    self.homeDojo_ = nil
    self.bossDojo_ = nil
end


--- 退出社团的时间戳
---@return integer
function ClubComponent:GetQuitTimestamp()
    return checkInt(self.quitTimestamp_)
end
function ClubComponent:SetQuitTimestamp(timestamp)
    self.quitTimestamp_ = checkInt(timestamp)
end


--- 是否加入社团
---@return boolean
function ClubComponent:IsJoinClub()
    return self.homeDojo_ ~= nil
end


--- 获取社团数据
---@return ClubHomeDojo
function ClubComponent:GetHomeDojo()
    return checkTable(self.homeDojo_)
end


-- 清空社团数据
function ClubComponent:CleanClubData()
    self:CloseDonationRedPoint()
    self.homeDojo_ = nil
    local social = AppService:GetInstance():GetSocialLine()
    if social then
        social:ExitClubRoom()
    end
end


--- 初始化社团数据
---@param jsonData table
function ClubComponent:InitialClubData(jsonData)
    local tableData = checkTable(jsonData)
    if next(tableData) == nil then return end

    self.homeDojo_ = ClubHomeDojo.New()
    self:UpdateClubData(jsonData)
    local social = AppService:GetInstance():GetSocialLine()
    if social then
        print('--->>', self.homeDojo_.clubId)
        social:EnterClubRoom(checkNumber(self.homeDojo_.clubId))
    end
end


--- 更新社团数据
function ClubComponent:UpdateClubData(jsonData)
    self.homeDojo_:Fill(jsonData)
end

function ClubComponent:ExitScene()
    if AppService then  -- 处于大厅中，注销登录（比如账号另外登录被挤）会报错 AppService 为空
        AppService:GetInstance():SendTcpData(Constants.Packets.OverseaClubExit)
    end
end

function ClubComponent:UpdateScenePositionData(packetData)
    local positionData = packetData.clubHallInfo

    for playerId, value in pairs(positionData) do
        self.scenePositionData[playerId] = value
    end
end

-------------------------------------------------------------------------------
-- about club exp
-------------------------------------------------------------------------------

--- 增加社团经验
---@param addExp integer
function ClubComponent:AddClubExp(addExp)
    if not self:IsJoinClub() then return end

    local clubHomeDojo = self:GetHomeDojo()
    clubHomeDojo.contributionPoint = clubHomeDojo.contributionPoint + checkInt(addExp)

    -- check levelUp
    if clubHomeDojo.level < ClubUtils.GetLevelMax() then
        local newClubLevel = 0
        local nextLevelExp = ClubUtils.GetLevelExp(clubHomeDojo.level + 1)
        if clubHomeDojo.contributionPoint >= nextLevelExp then
            for clubLevel = clubHomeDojo.level + 1, ClubUtils.GetLevelMax() do
                local levelExp = ClubUtils.GetLevelExp(clubLevel + 1)
                if clubHomeDojo.contributionPoint < levelExp then
                    newClubLevel = clubLevel
                    break
                end
            end
            clubHomeDojo.level = newClubLevel > 0 and newClubLevel or ClubUtils.GetLevelMax()
        end
    end

    Events.Broadcast(ClubUtils.EventName.UPDATE_EXP)
end


-------------------------------------------------------------------------------
-- about member list
-------------------------------------------------------------------------------

--- 通过玩家id 查找社团成员
---@param playerId integer
---@return ClubMemberDojo
function ClubComponent:ClubMemberFind(playerId)
    if not self:IsJoinClub() then return nil end

    local findMemberDojo = nil
    local findMemberId = checkInt(playerId)
    for _, memberDojo in ipairs(self:GetHomeDojo().memberList) do
        if checkInt(memberDojo.playerId) == findMemberId then
            findMemberDojo = memberDojo
            break
        end
    end
    return findMemberDojo
end


--- 通过玩家id 移除社团成员
---@param playerId integer
function ClubComponent:ClubMemberRemove(playerId)
    if not self:IsJoinClub() then return end

    local removePlayerId = checkInt(playerId)
    for memberIndex = #self:GetHomeDojo().memberList, 1, -1 do
        local memberDojo = self:GetHomeDojo().memberList[memberIndex]
        if checkInt(memberDojo.playerId) == removePlayerId then
            table.remove(self:GetHomeDojo().memberList, memberIndex)
            break
        end
    end

    Events.Broadcast(ClubUtils.EventName.UPDATE_MEMBERS, {removePlayerId = removePlayerId})
end


--- 通过玩家id 移除社团成员
---@param playerData table
function ClubComponent:ClubMemberAppend(playerData)
    if not self:IsJoinClub() then return end
    if not playerData then return end

    local newMemberDojo = ClubMemberDojo.New()
    newMemberDojo:Fill(playerData)
    table.insert(self:GetHomeDojo().memberList, newMemberDojo)
    Events.Broadcast(ClubUtils.EventName.UPDATE_MEMBERS, {newMemberDojo = newMemberDojo})
end


-------------------------------------------------------------------------------
-- about member job
-------------------------------------------------------------------------------

--- 通过玩家id 更改团员职位
---@param playerId integer
---@param jobType ClubUtils.JobType
function ClubComponent:ClubMemberChangeJob(playerId, jobType)
    if not self:IsJoinClub() then return end
    local memberDojo = self:ClubMemberFind(playerId)
    if memberDojo then
        memberDojo.job = jobType
        Events.Broadcast(ClubUtils.EventName.UPDATE_MEMBER_JOB, {memberId = playerId})
    end
end


--- 通过社团职位 查找玩家数量
---@param jobType ClubUtils.JobType
function ClubComponent:ClubMembersJobFind(jobType)
    if not self:IsJoinClub() then return 0 end

    local memberNum = 0
    for _, memberDojo in ipairs(self:GetHomeDojo().memberList) do
        if checkInt(memberDojo.job) == checkInt(jobType) then
            memberNum = memberNum + 1
        end
    end
    return memberNum
end


-------------------------------------------------------------------------------
-- about applyList
-------------------------------------------------------------------------------

--- 获取 申请列表 红点状态
---@return boolean
function ClubComponent:HasApplyListRedPoint()
    return GameUtils.GetRedPointNum(Constants.RedPointConst.ClubApplyList) > 0
end


--- 设置 申请列表 红点状态
---@param hasRedPoint boolean
function ClubComponent:SetApplyListRedPoint(hasRedPoint)
    GameUtils.SetRedPointNum(Constants.RedPointConst.ClubApplyList, hasRedPoint and 1 or 0)
end


-------------------------------------------------------------------------------
-- about donation
-------------------------------------------------------------------------------

--- 获取 捐献 红点状态
---@return boolean
function ClubComponent:HasDonationRedPoint()
    return GameUtils.GetRedPointNum(Constants.RedPointConst.ClubDonation) > 0
end


--- 设置 捐献 红点状态
---@param hasRedPoint boolean
function ClubComponent:SetDonationRedPoint(hasRedPoint)
    GameUtils.SetRedPointNum(Constants.RedPointConst.ClubDonation, hasRedPoint and 1 or 0)
end


--- 检测 捐献 红点状态
function ClubComponent:CheckDonationRedPoint()
    if not self:IsJoinClub() then return end

    ---@type OverseaClubFeedCatMgr
    local OverseaClubFeedCatMgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
    ---@type OverseaClubFeedCatUtils
    local OverseaClubFeedCatUtils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")
    local maxFeedNum = checkNumber(OverseaClubFeedCatUtils.GetParamValue(OverseaClubFeedCatUtils.ParamsId.MaxFeedCount))
    local remainFeedNum = maxFeedNum - OverseaClubFeedCatMgr.Server.dojo.petsFeedTimes
    if remainFeedNum > 0 then
        self:SetDonationRedPoint(true)
    else
        self:SetDonationRedPoint(false)
    end
end


--- 关闭 捐献 红点状态
function ClubComponent:CloseDonationRedPoint()
    if not self:IsJoinClub() then return end
    
    self:SetDonationRedPoint(false)
end


-------------------------------------------------------------------------------
-- about boss
-------------------------------------------------------------------------------

--- 初始化 社团Boss数据
---@param jsonData table
function ClubComponent:InitialClubBossData(jsonData)
    local tableData = checkTable(jsonData)
    if next(tableData) == nil then return end

    if isNull(self.bossDojo_) then
        self.bossDojo_ = ClubBossDojo.New()
    end
    self:UpdateBossClubData(jsonData)
end


--- 更新 社团boss数据
---@param jsonData table
function ClubComponent:UpdateBossClubData(jsonData)
    self.bossDojo_:Fill(jsonData)
    self:GetHomeDojo().bossLeftTimes = self.bossDojo_:GetLeaveTimes()
end


--- 获取 社团boss数据
---@return ClubBossDojo
function ClubComponent:GetBossDojo()
    return self.bossDojo_
end


--- 获取 社团Boss 挑战总次数
---@return integer
function ClubComponent:GetTotalChallengeTime()
    return ClubUtils.GetParamValue(ClubUtils.ParamsId.BOSS_CHALLENGE_COUNT)
end


--- 获取 社团Boss 全体成员挑战次数
---@return integer
function ClubComponent:GetClubTotalChallengeTime()
    return ClubUtils.GetParamValue(ClubUtils.ParamsId.TOTAL_CHALLENGE_COUNT)
end


--- 处理 社团Boss 挑战结算数据
---@param responseData table
function ClubComponent:BattleEndUpdate(responseData)
    local data = {}

    if rawget(responseData,"bossHpInfo") then
        data.bossHpInfo = responseData.bossHpInfo
    end

    if rawget(responseData,"cardDisable") then
        if table.count(responseData.cardDisable) > 0 then
            data.cardDisable = responseData.cardDisable
        end
    end

    if rawget(responseData,"catDisable") then
        if table.count(responseData.catDisable) > 0 then
            data.catDisable = responseData.catDisable
        end
    end

    if rawget(responseData,"clubBossAtTimes") then
        if checkNumber(responseData.clubBossAtTimes) ~= 0 then
            local totalTime = ClubUtils.GetClubComp():GetClubTotalChallengeTime()
            data.dailyBossAtTimes = totalTime - responseData.clubBossAtTimes
        end
    end

    if rawget(responseData,"playerBossAtTimes") then
        if checkNumber(responseData.playerBossAtTimes) ~= 0 then
            local totalTime = ClubUtils.GetClubComp():GetTotalChallengeTime()
            data.dailyBossAtTimesLeft = totalTime - responseData.playerBossAtTimes
        end
    end

    self:UpdateBossClubData(data)

    if rawget(responseData,"logData") then
        if next(responseData.logData)then
            self:GetBossDojo():UpdateClubBossLog(responseData.logData)
        end
    end
end


-------------------------------------------------------------------------------
-- about gvg
-------------------------------------------------------------------------------

--- 检测 gvg 红点状态
function ClubComponent:CheckGvgRedPoint(nowServerTime)
    if not self:IsJoinClub() then 
        self:SetGvgRedPoint(false)
        return
     end

    --- 正式比赛期间，显示小红点
    local clubHomeDojo    = self:GetHomeDojo()
    local nowServerTime   = nowServerTime or GameUtils.GetServerTime()
    local battleStartTime = checkNumber(clubHomeDojo.gvgBattleStartTime)
    local battleEndTime   = checkNumber(clubHomeDojo.gvgEndTime)
    if clubHomeDojo:IsGvgApplied() and (nowServerTime >= battleStartTime and nowServerTime < battleEndTime) then 
        self:SetGvgRedPoint(true)
    else
        self:SetGvgRedPoint(false)
    end

end

--- 设置 gvg 红点状态
---@param hasRedPoint boolean
function ClubComponent:SetGvgRedPoint(hasRedPoint)
    if not self:IsJoinClub() then return end
    GameUtils.SetRedPointNum(Constants.RedPointConst.ClubGVG, hasRedPoint and 1 or 0)
end

--- 设置 gvg 红点状态
---@param clubGvgEndTime number
function ClubComponent:SetClubGvgEndTime(clubGvgEndTime)
    if not self:IsJoinClub() then return end
    self.homeDojo_:SetGVGEndTime(clubGvgEndTime)
end


return ClubComponent
