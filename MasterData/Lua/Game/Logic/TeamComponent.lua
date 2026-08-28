---
--- Created by THL.
--- TeamComponent 
--- 

local ECSComponent = import("Frame.ECS.ECSComponent")

local EntrustTeamDojo = import('Game.Dojo.EntrustTeamDojo')
local EntrustBattleTeamUnlockVo = import("Game.Setting.Vo.EntrustBattleTeamUnlockVo")
local TimeZoneUtils = CS.Engine.Http.TimeZoneUtils
local UIModule = CS.Engine.UI.UIModule
local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
local AnnihilationUtils = import('Game.UI.FightReady.UIMainChapter.AnnihilationUtils')

---@class TeamComponent
local TeamComponent = Class("TeamComponent", ECSComponent)

function TeamComponent:__init()
    ---@type table<string, table>
    self._serverBufferTeamTab = {}         --服务器缓存信息
    ---@type table<string, table>
    self._teamTab = {}                      --所有编队信息
    ---@type TeamMemberDojo[]
    self._bufferTeamTab = nil               --快速编队时候的缓存信息
    self._tempTeamTab = {}                 --临时编队

    --主线和副本部分用到
    ---@type EntrustTeamDojo[]
    self.entrustQueues = {}                --服务器委托队列信息 全部的
    ---@type integer[]
    self.entrustTeam = {}                  --委托队伍 一次性的用完即清空
    self.entrustNum = 1                    --委托次数缓存

    self.callCopyCardInfos = {}            --抽卡副本人物血量和能量信息
    self.MaxNum = 4                        --队伍队员最大数量

    self._maxCatNum = 2                    -- 队伍猫球最大数量

    ---@type table<string, integer>
    self._allUnlockMergeSkill = {}          --所有解锁得信息

    self._isOpenContinue = false            --是否开启连续
    self._curContinueState = false              --当前开启状态
    self._continueType = 0                  --连续类型
    self._continueNum = 0                   --连续次数
    self._curContinueNum = 0                --当前连续次数
    self._isAutoUseConsume = false          --自动使用道具
    self._exchangeItemCostNum = 0           --兑换道具消耗数量
    self._continueFightRewards = {}         --连续作战期间获得的奖励
    self._continueFightExtraRewards = {}    --连续作战期间获得的固定奖励
    self._hasFirstRewards = false           --是否有首通奖励
end

function TeamComponent:__delete()
    self._serverBufferTeamTab = nil         --服务器缓存信息
    self._teamTab = {}                      --服务器保存的编队信息
    self._bufferTeamTab = nil               --快速编队时候的缓存信息

    --主线和副本部分用到
    self.entrustQueues = {}                --服务器委托队列信息 全部的
    self.entrustTeam = {}                  --委托队伍 一次性的用完即清空
    self.entrustNum = 1                    --委托次数缓存

    --抽卡副本用到
    self.callCopyCardInfos = {}            --抽卡副本人物血量和能量信息
    self.MaxNum = 4                        --队伍队员最大数量

    self._allUnlockMergeSkill = nil        --所有解锁得信息

    self._isOpenContinue = false            --是否开启连续
    self._curContinueState = false              --当前开启状态
    self._continueType = 0                  --连续类型
    self._continueNum = 0                   --连续次数
    self._curContinueNum = 0                --当前连续次数
    self._isAutoUseConsume = false          --自动使用道具
    self._exchangeItemCostNum = 0           --兑换道具消耗数量
    self._continueFightRewards = {}         --连续作战期间获得的奖励
    self._continueFightExtraRewards = {}    --连续作战期间获得的固定奖励
    self._hasFirstRewards = false           --是否有首通奖励
end

--初始化编队信息
function TeamComponent:Initial(jsonData, oldTeams)
    local pairs       = pairs
    local next        = next
    local checkTable  = checkTable
    local checkNumber = checkNumber
    local GetTeamMemberDojo = CfUtils.GetTeamMemberDojo
    local GetTeamCatDojo    = CfUtils.GetTeamCatDojo
    -- local data = checkTable(jsonData)
    self._serverBufferTeamTab = {}
    self._serverBufferTeamTab.selectedFourPersonTeam = jsonData.selectedFourPersonTeam or 1
    self._serverBufferTeamTab.selectedFivePersonTeam = jsonData.selectedFivePersonTeam or 1
    
    local function initTeamData(teams)
        local data = {}
        teams = checkTable(teams)
        for _teamKey, teamData in pairs(teams) do
            local t = {}
            t.cardsInfo = {}
            teamData = checkTable(teamData)
            if teamData.cardsInfo then
                for _k, memberData in pairs(teamData.cardsInfo) do
                    local dojo = GetTeamMemberDojo(memberData)
                    table.insert(t.cardsInfo, dojo)
                end
                data[checkNumber(_teamKey)] = t
            end

            --- 初始化猫编队数据
            local catsInfo = {}
            if teamData.catsInfo then
                local temp = checkTable(teamData.catsInfo)

                for key, value in pairs(temp) do
                    ---@type TeamCatBallDojo
                    local dojo = GetTeamCatDojo(value, true, key)
                    table.insert(catsInfo, dojo)
                end
            end
            t.catsInfo = catsInfo
            t.name = teamData.name or self:GetEmptyTeamName(_teamKey)
        end
        return data
    end
    --{
    --    fourPersonTeam = {},
    --    fivePersonTeam = {},
    --    selectedFourPersonTeam = 1,
    --    selectedFivePersonTeam = 2,
    --}
    
    local myOldTeams = {}
    for k, v in pairs(oldTeams) do
        myOldTeams[k] = initTeamData(v)
    end
    self._serverBufferTeamTab.oldTeams = myOldTeams
    self._serverBufferTeamTab.fourPersonTeam = initTeamData(jsonData.fourPersonTeam)
    self._serverBufferTeamTab.fivePersonTeam = initTeamData(jsonData.fivePersonTeam)
    self._serverBufferTeamTab.tempTeams = {}
    
    --服务器数据同步
    self._teamTab = clone(self._serverBufferTeamTab)

    self._isOpenContinue = checkInt(CfUtils.GetLocalData("BattleContinueIsTrue")) == 1
    self._continueType = checkNumber(CfUtils.GetLocalData("BattleContinueType"))
    self._continueNum = checkNumber(CfUtils.GetLocalData("BattleContinueNum"))
    self._isAutoUseConsume = checkInt(CfUtils.GetLocalData("BattleContinueIsUse")) == 1 
end

-------------------------------------------------------------------------------合卡技部分--------------------------------------------------
---GetCurSkillCompoundId 获取编队合卡技
---@param questId integer @ 关卡id
---@param teamIndex integer @ 队伍下标
---@return integer
function TeamComponent:GetCurSkillCompoundId(questId, teamIndex)
    teamIndex = checkNumber(teamIndex)
    if teamIndex == 0 then
        teamIndex = 1
    end

    local mergeSkillId = 0
    local systemId = self:GetSystemId(questId)
    local t = self._teamTab.oldTeams[systemId]
    if t then
        if t[teamIndex] then
            mergeSkillId = checkNumber(t[teamIndex].mergeSkill)
        end
    end

    --r如果为0 取默认
    if mergeSkillId == 0 then
        mergeSkillId = QuestConfMgr:GetInstance():GetAutoMergeSkillId()
    end
    return mergeSkillId
end

---SetTeamMergeSkillId 修改编队合卡技
---@param skillId string
---@param questId string @ 关卡id
---@param teamIndex integer @ 队伍下标
function TeamComponent:SetTeamMergeSkillId(skillId, questId, teamIndex)
    if not skillId or not questId then
        return
    end

    local type = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    local systemId = self:GetSystemId(questId)
    teamIndex = checkNumber(teamIndex)
    if teamIndex == 0 then
        teamIndex = 1
    end
    skillId = checkNumber(skillId)

    local t = self._teamTab.oldTeams[systemId]
    if t then
        if t[teamIndex] then
            t[teamIndex].mergeSkill = skillId
        else
            t[teamIndex] = {
                mergeSkill = skillId,
                cardsInfo = self:GetEmptyTeam()
            }
        end
    else
        t = {
            [teamIndex] = {
                mergeSkill = skillId,
                cardsInfo = self:GetEmptyTeam()
            } 
        }
        self._teamTab.oldTeams[systemId] = t
    end
    Events.Broadcast(Constants.EventNames.SkillCompoundChange, nil)
end


----------------------------------------------------------------------------队伍设置部分--------------------------------------------------------------
--- 修改编队请求
---@param questId integer @ 关卡id
---@param cardTab table @ 队伍表
---@param status string @ 委托/正常
---@param teamIndex integer @ 队伍下标
---@param entrustId integer @ 队列id
---@param cb fun():void
function TeamComponent:SetTeamByQuestId(questId, cardTab, status, teamIndex, entrustId, cb, skipAnim)
    if not cardTab then
        return
    end
    status = checkNumber(status)
    --如果是委托
    if status == Constants.ChooseCardStatus.Entrust then
        self:ChangeEntrustTeamReq(entrustId, cardTab, function()
            UIModule.BackDialog()
        end)
    else
        local systemId = self:GetSystemId(questId)
        --特殊的一些关卡处理 留个接口
        if checkNumber(questId) == Constants.SpecialQuestId.PlayerInfoId then
        elseif self:IsUseOldTeams(questId) then
            local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
            if levelType == Constants.IDType.QuestChaoticRecall then
                ---@type ChaoticRecallMgr
                local ChaoticRecallMgr = import('Game.UI.FightReady.ChaoticRecall.ChaoticRecallMgr')
                ChaoticRecallMgr:GetInstance():UpdateTeamCardsInfo(questId,cardTab,teamIndex,function()
                    if cb then
                        cb()
                    end
                    Events.Broadcast(Constants.EventNames.RefeshTeamMember, {skipAnim = skipAnim})
                end)
            elseif levelType == Constants.IDType.QuestPatrolMaze then
                local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
                local patrolMazeComp  = PatrolMazeUtils.GetComp()
                local mazeAreaId      = checkInt(teamIndex)
                local mazeAreaDojo    = patrolMazeComp:GetHomeDojo():GetAreaDojo(mazeAreaId)
                patrolMazeComp:SyncMazeAreaTeam(mazeAreaId, cardTab, function()
                    if cb then
                        cb()
                    end
                    Events.Broadcast(Constants.EventNames.RefeshTeamMember, {skipAnim = skipAnim})
                end)
            else
                self:SetTeamBySystemId(systemId, cardTab, teamIndex, function()
                    if cb then
                        cb()
                    end
                end, skipAnim, questId)
            end

        elseif self:IsUseTempTeam(questId) then
            self:SetTempTeam(questId, cardTab, cb, skipAnim)
        else

            cardTab = checkTable(cardTab)
            if table.count(cardTab) < self:GetMaxTeamMemberNum() then
                GameUtils.Toast(localize("设置无效的队伍"))
                return
            end

            systemId = checkString(systemId)
            teamIndex = checkNumber(teamIndex)
            if teamIndex == 0 then
                teamIndex = self:GetSelectedTeamIndexByQuestId()
            end

            --直接覆盖
            local t = self:GetTeamInfoByQuestId(questId)
            if t then
                if t[teamIndex] then
                    t[teamIndex].cardsInfo = cardTab
                else
                    t[teamIndex] = {
                        cardsInfo = cardTab
                    }
                end
            else
                t = {
                    [teamIndex] ={
                        cardsInfo = cardTab
                    }
                }
                self:SetTeamInfoByQuestId(questId, t)
            end

            Events.Broadcast(Constants.EventNames.RefeshTeamMember, {skipAnim = skipAnim})
            if cb then
                cb()
            end
        end
    end
end

---通过关卡ID获取选中编队序号
---@param questId integer
function TeamComponent:GetSelectedTeamIndexByQuestId(questId)
    local numType = self:GetMaxTeamMemberNum(questId)
    local teamIndex = nil
    if numType == Constants.TeamMemberNumType.FOUR then
        teamIndex = self._teamTab.selectedFourPersonTeam
    elseif numType == Constants.TeamMemberNumType.FIVE then
        teamIndex = self._teamTab.selectedFivePersonTeam
    end
    if self:IsUseOldTeams(questId) then
        teamIndex = self:ConvertOldTeamsTeamIndex(questId, teamIndex)
    end
    return teamIndex
end

---通过关卡ID设置选中的编队序号
---@param index integer
---@param questId integer
function TeamComponent:SetSelectedTeamIndexByQuestId(index, questId)
    local numType = self:GetMaxTeamMemberNum(questId)
    if numType == Constants.TeamMemberNumType.FOUR then
        self._teamTab.selectedFourPersonTeam = checkInt(index or 1)
    elseif numType == Constants.TeamMemberNumType.FIVE then
        self._teamTab.selectedFivePersonTeam = checkInt(index or 1)
    end
end

---SetTeamBySystemId 修改编队
---@param systemId integer @ 模块id
---@param cardTab table @ 队伍表
---@param teamIndex integer 队伍下标
---@param cb fun():void
function TeamComponent:SetTeamBySystemId(systemId, cardTab, teamIndex, cb, skipAnim, questId)
    if not cardTab then
        return
    end
    cardTab = checkTable(cardTab)
    if table.count(cardTab) < self:GetMaxTeamMemberNum(questId) then
        GameUtils.Toast(localize("设置无效的队伍"))
        return
    end

    systemId = checkString(systemId)
    teamIndex = checkNumber(teamIndex)
    if teamIndex == 0 then
        teamIndex = 1
    end

    --直接覆盖
    local t = self._teamTab.oldTeams[systemId]
    if t then
        if t[teamIndex] then
            t[teamIndex].cardsInfo = cardTab
        else
            t[teamIndex] = {
                cardsInfo = cardTab
            }
        end
    else
        t = {
            [teamIndex] ={
                cardsInfo = cardTab
            } 
        }
        self._teamTab.oldTeams[systemId] = t
    end

    Events.Broadcast(Constants.EventNames.RefeshTeamMember, {skipAnim = skipAnim})
    if cb then
        cb()
    end
end

---根据关卡id团队猫
---@param questId number 关卡id
---@param catsInfo table 队伍猫信息
---@param teamIndex number 队伍下标
---@param cb fun():void 设置完成回调
function TeamComponent:SetTeamCatByQuestId(questId, catsInfo, teamIndex, cb)
    if not catsInfo then
        return
    end

    if self:IsUseOldTeams(questId) then
        local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
        if levelType == Constants.IDType.QuestChaoticRecall then
            local ChaoticRecallMgr = import('Game.UI.FightReady.ChaoticRecall.ChaoticRecallMgr')
            ChaoticRecallMgr:GetInstance():UpdateTeamCatsInfo(questId,catsInfo,teamIndex,function()
                if cb then
                    cb()
                end
                Events.Broadcast(Constants.EventNames.RefreshTeamCat)
            end)
        else
            local systemId = self:GetSystemId(questId)
            self:SetTeamCatBySystemId(systemId, catsInfo, teamIndex, cb)
        end

        return
    elseif self:IsUseTempTeam(questId) then
        self:SetTempTeamCat(questId, catsInfo, cb)
        return 
    end
    
    catsInfo = checkTable(catsInfo)
    if #catsInfo < self:GetMaxTeamCatNum() then
        GameUtils.Toast(localize("设置无效的猫球"))
        return
    end
    teamIndex = teamIndex and checkNumber(teamIndex) or self:GetSelectedTeamIndexByQuestId(questId)

    --直接覆盖
    local t = self:GetTeamInfoByQuestId(questId) or {}
    t[teamIndex] = t[teamIndex] or {}
    t[teamIndex].catsInfo = catsInfo
    self:SetTeamInfoByQuestId(questId, t)

    Events.Broadcast(Constants.EventNames.RefreshTeamCat)
    if cb then
        cb()
    end
end

---SetTeamCatBySystemId
---根据系统模块id团队猫
---@param systemId number 系统模块id
---@param catsInfo table 队伍猫信息
---@param teamIndex number 队伍下标
---@param cb fun():void 设置完成回调
function TeamComponent:SetTeamCatBySystemId(systemId, catsInfo, teamIndex, cb)
    if not catsInfo then
        return
    end

    catsInfo = checkTable(catsInfo)
    if #catsInfo < self:GetMaxTeamCatNum() then
        GameUtils.Toast(localize("设置无效的猫球"))
        return
    end
    systemId  = checkString(systemId)
    teamIndex = teamIndex and checkNumber(teamIndex) or 1

    --直接覆盖
    local t = self._teamTab.oldTeams[systemId] or {}
    t[teamIndex] = t[teamIndex] or {}
    t[teamIndex].catsInfo = catsInfo
    t[teamIndex].cardsInfo = t[teamIndex].cardsInfo or self:GetEmptyTeam()
    self._teamTab.oldTeams[systemId] = t

    Events.Broadcast(Constants.EventNames.RefreshTeamCat)
    if cb then
        cb()
    end
end


---SetTeamReq 修改编队请求
---@param questId integer @ 模块id/副本类型
---@param cb fun():void
function TeamComponent:SetTeamReq(questId, cb, skipAnim)
    local systemId = checkInt(self:GetSystemId(questId))
    if (systemId == Constants.SystemToggleIds.Id1208 or
        systemId == Constants.SystemToggleIds.Id1217) then
        cb()
        return
    end
    
    local function req()
        if self:IsSameTeamInfo(questId) then
            cb()
            return
        end
        local teamInfo = self._teamTab
        local t = clone(teamInfo)
        local isUnlock = GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id3007)
        for i, v in ipairs(t.fourPersonTeam) do
            v.cardsInfo = self:GetAllCardId(v.cardsInfo, true)
            if isUnlock then
                v.catsInfo  = self:GetAllCatId(v.catsInfo, true)
            else
                v.catsInfo  = nil
            end
            v.name = v.name or self:GetEmptyTeamName(i)
        end
        for i, v in ipairs(t.fivePersonTeam) do
            v.cardsInfo = self:GetAllCardId(v.cardsInfo, true)
            if isUnlock then
                v.catsInfo  = self:GetAllCatId(v.catsInfo, true)
            else
                v.catsInfo  = nil
            end
            v.name = v.name or self:GetEmptyTeamName(i)
        end
        t.oldTeams = nil -- 老数据不在此处处理
        t.tempTeams = nil -- 临时数据不在此处处理
        
        GameUtils.Request(Interfaces.OverseaSetTeam, {teams = table.serialize(t)}, function(request, response)
            if checkNumber(response.errCode) ~= 0 then
                if cb then
                    cb()
                end
                return
            end
            --直接覆盖
            self._serverBufferTeamTab = clone(teamInfo)

            local function dispose(data)
                local _t = {}
                for _teamKey, teamData in pairs(data) do
                    local t = {}
                    t.cardsInfo = {}
                    for _k, memberData in pairs(teamData.cardsInfo) do
                        if checkNumber(memberData.type) == Constants.TeamMemberType.QuestLockHelperCard then
                            table.insert(t.cardsInfo, {})
                        else
                            local dojo = CfUtils.GetTeamMemberDojo(memberData)
                            table.insert(t.cardsInfo, dojo)
                        end
                    end
                    --数据下沉
                    for i = 1,  #t.cardsInfo - 1 do
                        for j = i + 1,  #t.cardsInfo do
                            local isChange = false
                            if checkNumber(t.cardsInfo[i].refId) == 0 and checkNumber(t.cardsInfo[j].refId) ~= 0 then
                                isChange = true
                            end
                            if isChange then
                                local data = t.cardsInfo[j]
                                t.cardsInfo[j] = t .cardsInfo[i]
                                t.cardsInfo[i] =  data
                            end
                        end
                    end
                    t.catsInfo = {}
                    if teamData.catsInfo then
                        for _k, memberData in pairs(teamData.catsInfo) do
                            -- ---@type TeamCatBallDojo
                            -- local dojo = CfUtils.GetTeamCatDojo(memberData, false, memberData.catType)
                            table.insert(t.catsInfo, clone(memberData))
                        end
                    end
                    -- t.mergeSkill = checkNumber(teamData.mergeSkill)
                    t.name = teamData.name
                    _t[checkNumber(_teamKey)] = t
                end
                return _t
            end
            local oldTeams = self._teamTab.oldTeams
            self._teamTab = clone(teamInfo)
            self._teamTab.oldTeams = oldTeams
            self._teamTab.fourPersonTeam = dispose(teamInfo.fourPersonTeam)
            self._teamTab.fivePersonTeam = dispose(teamInfo.fivePersonTeam)
            self._teamTab.tempTeams = clone(self._tempTeamTab)

            Events.Broadcast(Constants.EventNames.RefeshTeamMember, {skipAnim = skipAnim})
            if cb then
                cb()
            end
        end)
    end

    if checkInt(systemId) == 0 then
        req()
    else
        --判断一下队伍是否有修改
        if self:IsSameCopyTeamInfo(questId) then
            req()
        else
            self:SetCopyTeamReq(questId, function ()
                req()
            end)
        end
    end
end

---为了兼容老逻辑, 要走一次老的编队请求
---@param questId integer @ 模块id/副本类型
---@param cb fun():void
function TeamComponent:SetCopyTeamReq(questId, cb)
    local systemId = self:GetSystemId(questId)
    systemId = checkString(systemId)
    local teamInfo = {}
    local t = {}
    if self:IsUseOldTeams(questId) then
        teamInfo = self:GetTeamInfoByQuestId(questId)
    elseif self:IsUseTempTeam(questId) then
        teamInfo = self:GetTeamInfoByQuestId(questId)
    else
        teamInfo = self:GetTeamInfoByQuestId(questId, self:GetSelectedTeamIndexByQuestId(questId))
        teamInfo = {teamInfo}
    end
    t = clone(teamInfo)
    if t then
        local isUnlock = GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id3007)
        for i = 1, #t do
            t[i].name = nil
            t[i].cardsInfo = self:GetAllCardId(t[i].cardsInfo, true)
            if isUnlock then
                t[i].catsInfo  = self:GetAllCatId(t[i].catsInfo, true)
            else
                t[i].catsInfo  = nil
            end
        end
    end

    local reqData = {copyType = systemId, cardIds = table.serialize(t)}
    if systemId == tostring(Constants.SystemToggleIds.Id110005) then
        local FairylandUtils = import("Game.Fairyland.FairylandUtils")
        reqData.copyId = FairylandUtils.CurrentEnterQuestId
    end

    GameUtils.Request(Interfaces.PlayerSetCopyTeam, reqData, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            if cb then
                cb()
            end
            return
        end
        --直接覆盖
        self._serverBufferTeamTab.oldTeams[systemId] = clone(teamInfo)
        self._teamTab.oldTeams[systemId] = {}
        local _t = self._teamTab.oldTeams[systemId]
        for _teamKey, teamData in pairs(teamInfo) do
            local t = {}
            t.cardsInfo = {}
            for _k, memberData in pairs(teamData.cardsInfo) do
                if checkNumber(memberData.type) == Constants.TeamMemberType.QuestLockHelperCard then
                    table.insert(t.cardsInfo, {})
                else
                    local dojo = CfUtils.GetTeamMemberDojo(memberData)
                    table.insert(t.cardsInfo, dojo)
                end
            end
            --数据下沉
            for i = 1,  #t.cardsInfo - 1 do
                for j = i + 1,  #t.cardsInfo do
                    local isChange = false
                    if checkNumber(t.cardsInfo[i].refId) == 0 and checkNumber(t.cardsInfo[j].refId) ~= 0 then
                        isChange = true
                    end
                    if isChange then
                        local data = t.cardsInfo[j]
                        t.cardsInfo[j] = t .cardsInfo[i]
                        t.cardsInfo[i] =  data
                    end
                end
            end
            t.catsInfo = {}
            if teamData.catsInfo then
                for _k, memberData in pairs(teamData.catsInfo) do
                    -- ---@type TeamCatBallDojo
                    -- local dojo = CfUtils.GetTeamCatDojo(memberData, false, memberData.catType)
                    table.insert(t.catsInfo, clone(memberData))
                end
            end
            -- t.mergeSkill = checkNumber(teamData.mergeSkill)
            _t[checkNumber(_teamKey)] = t
        end
        
        if self:IsUseTempTeam(questId) then
            -- 保留临时编队
            self._teamTab.tempTeams[tostring(questId)] = _t[1]
        end
        if cb then
            cb()
        end
    end)
end

--- 是否相同的队伍信息
---@return boolean
function TeamComponent:IsSameTeamInfo(questId)
    local teamInfo1 = clone(self._serverBufferTeamTab)
    local teamInfo2 = clone(self._teamTab)

    -- 判断选择的编队是否相同
    if checkInt(teamInfo1.selectedFourPersonTeam) ~= checkInt(teamInfo1.selectedFourPersonTeam) then
        return false
    elseif checkInt(teamInfo1.selectedFivePersonTeam) ~= checkInt(teamInfo2.selectedFivePersonTeam) then
        return false
    end

    if not self:IsSameTeams(teamInfo1.fourPersonTeam, teamInfo2.fourPersonTeam) then
        return false
    end

    if not self:IsSameTeams(teamInfo1.fivePersonTeam, teamInfo2.fivePersonTeam) then
        return false
    end

    return true
end

function TeamComponent:IsSameCopyTeamInfo(questId)
    local systemId = self:GetSystemId(questId)
    if checkNumber(systemId) == 0 then
        return true
    end

    -- oldTeams
    if self:IsUseOldTeams(questId) then
        if not self:IsSameTeams(self._serverBufferTeamTab.oldTeams[systemId], self._teamTab.oldTeams[systemId]) then
            return false
        end
    elseif self:IsUseTempTeam(questId) then
        if not self:IsSameTeams({self:GetTempTeam(questId)}, {self._teamTab.tempTeams[tostring(questId)]}) then
            return false
        end
    else
        if not self:IsSameTeams(self._serverBufferTeamTab.oldTeams[systemId], {self:GetTeamInfoByQuestId(questId, self:GetSelectedTeamIndexByQuestId(questId))}) then
            return false
        end
    end
    return true
end

-- 判断队伍阵容是否相同
function TeamComponent:IsSameTeams(teamsA, teamsB)
    teamsA = checkTable(teamsA)
    teamsB = checkTable(teamsB)
    local num = math.max(table.count(teamsA), table.count(teamsB))
    for i = 1, num do
        local teamInfoData1 = teamsA[i]
        local teamInfoData2 = teamsB[i]

        if not teamInfoData1 and not teamInfoData2 then
            return true
        elseif teamInfoData1 and not teamInfoData2 then
            return false
        elseif teamInfoData2 and not teamInfoData1 then
            return false
        end

        -- --先判断合卡技
        -- if checkNumber(teamInfoData1.mergeSkill) ~= checkNumber(teamInfoData2.mergeSkill) then
        --     return false
        -- end

        -- 判断编队名
        if teamInfoData1.name ~= teamInfoData2.name then
            return false
        end

        -- 判断猫球光环技
        local catsInfo1 = checkTable(teamInfoData1.catsInfo)
        local catsInfo2 = checkTable(teamInfoData2.catsInfo)
        local catsInfo1Count = #catsInfo1
        local catsInfo2Count = #catsInfo2
        if catsInfo1Count ~= catsInfo2Count then
            return false
        end
        for j = 1, catsInfo1Count do
            ---@type TeamCatBallDojo
            local teamCatBallDojo1 = catsInfo1[j]
            ---@type TeamCatBallDojo
            local teamCatBallDojo2 = catsInfo2[j]
            if checkNumber(teamCatBallDojo1.playerCatId) ~= checkNumber(teamCatBallDojo2.playerCatId) then
                return false
            end
        end

        local cardData1 = checkTable(teamInfoData1.cardsInfo)
        local cardData2 = checkTable(teamInfoData2.cardsInfo)
        local maxNum = math.max(table.count(cardData1), table.count(cardData2))

        for j = 1, maxNum do
            local tmDojo1 = checkTable(cardData1[j])
            local tmDojo2 = checkTable(cardData2[j])
            if checkNumber(tmDojo1.refId) ~= checkNumber(tmDojo2.refId) then
                return false
            elseif checkNumber(tmDojo1.fettersId) ~= checkNumber(tmDojo2.fettersId) then
                return false
            end
        end
    end
    return true
end

---ChangeTeamWithBattleEnd 战斗结束后没血的队员下阵
---@param questId integer @ 模块id/副本类型
---@param cardInfo table @ 卡牌数据
---@param teamIndex integer
function TeamComponent:ChangeTeamWithBattleEnd(questId, cardInfo, teamIndex)
    if not questId or not cardInfo then
        return
    end
    
    local systemId = self:GetSystemId(questId)
    if checkNumber(systemId) == 0 then
        printError("无效的关卡id")
        return
    end
    systemId = checkString(systemId)
    cardInfo = checkTable(cardInfo)

    local t = self:GetTeamByQuestId(questId, teamIndex)
    local _t = {}
    for i = 1, #t do
        local a = t[i].refId
        local info = cardInfo[checkString(t[i].refId)]
        if info then
            if checkNumber(info.hpPercent) > 0 then
                table.insert(_t, t[i])
            else
                --table.insert(_t, {})
            end
        else
            table.insert(_t, t[i])
        end
    end 

    for i = table.count(_t) + 1, self:GetMaxTeamMemberNum(questId) do
        table.insert(_t, {})
    end

    if table.count(_t) ~= 4 then
        printError("设置队伍错误")
    end

    --双端规则下阵队员不走协议
    self:SetTeamByQuestId(questId, clone(_t), Constants.ChooseCardStatus.Normal, teamIndex)
    
    local teamInfo = self:GetTeamInfoByQuestId(questId)
    self:SetServerTeamInfoByQuestId(questId, teamInfo)
    
    --self:SetServerTeamInfoByQuestId(systemId, teamIndex, clone(_t))
    --self._teamTab[systemId] = _t
end

---ClearTeamBySystemId 队伍重置 !!某些队伍在周期结束后会清空队伍，不与服务器通讯(弃用)
---@param systemId integer @ 模块id
---@param teamIndex integer @ 队伍下标   不传直接所有队伍置空
function TeamComponent:ClearTeamBySystemId(systemId, teamIndex)
    systemId = checkString(systemId)
    --迷宫   ！！加层保护防止其他误删
    if checkNumber(systemId) == Constants.SystemToggleIds.Id8 or checkNumber(systemId) == Constants.SystemToggleIds.Id18 or checkNumber(systemId) == Constants.SystemToggleIds.Id11 
     or checkNumber(systemId) == Constants.SystemToggleIds.Id22 then
        if teamIndex then
            local t = self._teamTab.oldTeams[systemId]
            if t then
                t[checkNumber(teamIndex)] = nil
            end

            local serverT = self._serverBufferTeamTab[systemId]
            if serverT then
                serverT[checkNumber(teamIndex)] = nil
            end
        else
            self._teamTab.oldTeams[systemId] = nil
            self._serverBufferTeamTab[systemId] = nil
        end
    end
end

--服务器的队伍数据
---@param questId integer
---@return table
function TeamComponent:GetServerTeamInfoByQuestId(questId)
    local numType = self:GetMaxTeamMemberNum(questId)
    if numType == Constants.TeamMemberNumType.FOUR then
        return self._serverBufferTeamTab.fourPersonTeam
    elseif numType == Constants.TeamMemberNumType.FIVE then
        return self._serverBufferTeamTab.fivePersonTeam
    end
end

--设置服务器的队伍数据
---@param questId integer
---@param teamInfo table
function TeamComponent:SetServerTeamInfoByQuestId(questId, teamInfo)
    local numType = self:GetMaxTeamMemberNum(questId)
    if numType == Constants.TeamMemberNumType.FOUR then
        self._serverBufferTeamTab.fourPersonTeam = clone(teamInfo)
    elseif numType == Constants.TeamMemberNumType.FIVE then
        self._serverBufferTeamTab.fivePersonTeam = clone(teamInfo)
    end
end

--- 获取关卡的队伍信息
---@param questId integer @ 关卡id
---@param teamIndex integer @ 队伍下标 不传返回全部数据
---@return table
function TeamComponent:GetTeamInfoByQuestId(questId, teamIndex)
    local numType = self:GetMaxTeamMemberNum(questId)
    local t = nil
    if self:IsUseOldTeams(questId) then
        local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
        if levelType == Constants.IDType.QuestChaoticRecall then
            local ChaoticRecallUtils = import("Game.UI.FightReady.ChaoticRecall.ChaoticRecallUtils")
            t = ChaoticRecallUtils.GetChaoticRecallMgr():GetTeamInfoByQuestId(questId,teamIndex)
            if isNull(t) then
                if not t then
                    t = {
                        cardsInfo = self:GetEmptyTeam(),
                        catsInfo  = self:GetEmptyTeamCat(),
                    }
                else
                    if not t.cardsInfo then
                        t.cardsInfo = self:GetEmptyTeam()
                    end
                    if not t.catsInfo then
                        t.catsInfo = self:GetEmptyTeamCat()
                    end
                end
            end
            return t
        else
            local systemId = self:GetSystemId(questId)
            t = self:GetTeamInfoBySystemId(systemId)
        end
    elseif self:IsUseTempTeam(questId) then
        t = self:GetTempTeam(questId)
        if not t then
            t = {
                cardsInfo = self:GetEmptyTeam(),
                catsInfo  = self:GetEmptyTeamCat(),
            }
        else
            if not t.cardsInfo then
                t.cardsInfo = self:GetEmptyTeam()
            end
            if not t.catsInfo then
                t.catsInfo = self:GetEmptyTeamCat()
            end
        end

        if teamIndex then
            return t
        else
            return {t}
        end
    else
        if numType == Constants.TeamMemberNumType.FOUR then
            t = self._teamTab.fourPersonTeam
        elseif numType == Constants.TeamMemberNumType.FIVE then
            t = self._teamTab.fivePersonTeam
        end
    end
    --该模块没设置队伍
    if not t then
        --取单个队伍数据
        if teamIndex then
            return {
                cardsInfo = self:GetEmptyTeam(),
                catsInfo  = self:GetEmptyTeamCat(),
                name      = self:GetEmptyTeamName(teamIndex)
                -- mergeSkill = QuestConfMgr:GetInstance():GetAutoMergeSkillId()
            }
        else
            t = {}
            local teamNum = Constants.TeamsUpLimit
            if self:IsUseOldTeams(questId) then
                teamNum = QuestConfMgr:GetInstance():GetQuestTeamNum(questId)
            end
            for i = 1, teamNum do
                t[i] = {
                    cardsInfo = self:GetEmptyTeam(questId),
                    catsInfo  = self:GetEmptyTeamCat(questId), 
                    name      = self:GetEmptyTeamName(i)
                    -- mergeSkill = QuestConfMgr:GetInstance():GetAutoMergeSkillId()
                }
            end
            return t
        end
    else
        if teamIndex then
            local data = t[checkNumber(teamIndex)]
            if not data then
                return {
                    cardsInfo = self:GetEmptyTeam(),
                    catsInfo  = self:GetEmptyTeamCat(),
                    name      = self:GetEmptyTeamName(teamIndex)
                    -- mergeSkill = QuestConfMgr:GetInstance():GetAutoMergeSkillId()
                }
            else
                return data
            end
        else
            local teamNum = Constants.TeamsUpLimit
            if self:IsUseOldTeams(questId) then
                teamNum = QuestConfMgr:GetInstance():GetQuestTeamNum(questId)
            end
            for i = 1, teamNum do
                if not t[i] then
                    t[i] = {
                        cardsInfo = self:GetEmptyTeam(questId),
                        catsInfo  = self:GetEmptyTeamCat(questId),
                        name      = self:GetEmptyTeamName(i)
                        -- mergeSkill = QuestConfMgr:GetInstance():GetAutoMergeSkillId()
                    }
                end
            end
            return t
        end
    end

    --不会到这里
    return nil
end

---SetTeamInfoByQuestId 获取关卡的队伍信息
---@param questId integer @ 关卡id
function TeamComponent:SetTeamInfoByQuestId(questId, teamInfo)
    local numType = self:GetMaxTeamMemberNum(questId)
    if numType == Constants.TeamMemberNumType.FOUR then
        self._teamTab.fourPersonTeam = clone(teamInfo)
    elseif numType == Constants.TeamMemberNumType.FIVE then
        self._teamTab.fivePersonTeam = clone(teamInfo)
    end
end

---@param systemId integer
---@return table
function TeamComponent:GetTeamInfoBySystemId(systemId)
    if checkNumber(systemId) == 0 then
        return nil
    end

    systemId = checkString(systemId)
    return self._teamTab.oldTeams[systemId]
end

--获取羁绊Id 0无羁绊  cardId卡牌id
function TeamComponent:GetTeamFettersId(teamData, cardId)
    teamData = checkTable(teamData)
    if checkNumber(cardId) <= 0 then
        return 0
    end
    for k, v in pairs(teamData) do
        if checkNumber(v.cardId) == checkNumber(cardId) then
            return checkNumber(v.fettersId)
        end
    end
    return 0
end

--- 获取关卡id对应的队伍
---@param questId integer @ 关卡id
---@param teamIndex integer @ 队伍下标
---@param arg table @ 扩展参数  isDontNeedHelper/是否不包含助战卡牌
---@return table
function TeamComponent:GetTeamByQuestId(questId, teamIndex, arg)
    local ind = checkNumber(teamIndex)
    local t = {}
    if self:IsUseOldTeams(questId) then
        local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
        if levelType == Constants.IDType.QuestChaoticRecall then
            local ChaoticRecallUtils = import("Game.UI.FightReady.ChaoticRecall.ChaoticRecallUtils")
            local teamInfo = ChaoticRecallUtils.GetChaoticRecallMgr():GetTeamInfoByQuestId(questId,ind)
            if isNull(teamInfo) or isNull(teamInfo.cardsInfo) then
                t = self:GetEmptyTeam()
            else
                t = teamInfo.cardsInfo
            end
        elseif levelType == Constants.IDType.QuestPatrolMaze then
            local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
            local patrolMazeComp  = PatrolMazeUtils.GetComp()
            local mazeAreaId      = checkInt(teamIndex)
            local mazeAreaDojo    = patrolMazeComp:GetHomeDojo():GetAreaDojo(mazeAreaId)
            if #mazeAreaDojo.teamMemberDojoList == 0 then
                t = self:GetEmptyTeam()
            else
                t = mazeAreaDojo.teamMemberDojoList
            end
        elseif levelType == Constants.IDType.ActivityCrisis then
            local systemId = self:GetSystemId(questId)
            t = self:GetTeamBySystemId(systemId, teamIndex)
            local vo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
            for i = #t, 1, -1 do
                if next(t[i]) then
                    local isLimitCard = QuestConfMgr:GetInstance():CheckCardByTeamLimitId(vo.roleRestrictions, Constants.TeamLimitType.Limit, t[i].cardId)
                    if isLimitCard then
                        table.remove(t, i)
                    end
                end
            end
        else
            local systemId = self:GetSystemId(questId)
            t = self:GetTeamBySystemId(systemId, teamIndex)
        end
    elseif self:IsUseTempTeam(questId) then
        t = self:GetTempTeam(questId)
        if t then
            t = t.cardsInfo
        else
            t = self:GetEmptyTeam()
        end
    else
        if ind == 0 then
            ind = self:GetSelectedTeamIndexByQuestId(questId)
        end
        t = self:GetTeamInfoByQuestId(questId)
        if not t then
            t = self:GetEmptyTeam()
        else
            t = t[ind]
            if not t or table.count(t) <= 0 then
                t = self:GetEmptyTeam()
            else
                t = t.cardsInfo
            end
        end
    end
    local isHasBattleHelper = QuestConfMgr:GetInstance():IsQuestHasHelper(questId)
    --如果有机器人
    if isHasBattleHelper then
        local helperTeam = QuestConfMgr:GetInstance():GetQuestHelpers(questId)
        local count = 0

        local _t = {}
        for i = 1, self:GetMaxTeamMemberNum(questId) do
            if not helperTeam[i] or table.count(helperTeam[i]) <= 0 then
                count = count + 1
                table.insert(_t, self:GetFirstTeamMember(t, helperTeam, count))
            else
                --助战角色添加判断
                if not arg or not checkBool(arg.isDontNeedHelper) then
                    table.insert(_t, helperTeam[i])
                end
            end
        end

        t = _t
    end

    local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
    if questVo and questVo.roleNun then
        for i, v in ipairs(t) do
            if i > checkInt(questVo.roleNun) then 
                v = {}
            end
        end
    end
    
    --保证四个数据
    if t then
        if #t < self:GetMaxTeamMemberNum(questId) then
            for i = #t + 1, self:GetMaxTeamMemberNum(questId) do
                table.insert(t, {})
            end
        end
    end
    return t
end

---GetTeamBySystemId 获取模块id对应的队伍
---@param systemId integer @ 模块id
---@param teamIndex integer 队伍下标
---@return table
function TeamComponent:GetTeamBySystemId(systemId, teamIndex)
    local ind = checkNumber(teamIndex)
    --默认都是取第一队列
    if ind == 0 then
        ind = 1
    end
    systemId = checkString(systemId)
    local t = self._teamTab.oldTeams[systemId]
    if isNull(t) then
        return self:GetEmptyTeam()
    else
        t = t[ind]
        if isNull(t) or isNull(t.cardsInfo) then
            return self:GetEmptyTeam()
        else
            t = t.cardsInfo
        end
    end

    if tonumber(systemId) == Constants.SystemToggleIds.Id4004 then
        for i = #t, 1, -1 do
            local isLimitCard = ClubUtils.IsBossLimitCard(t[i].refId)
            if isLimitCard then
                table.remove(t, i)
            end
        end
    elseif tonumber(systemId) == Constants.SystemToggleIds.Id110005 then
        local FairylandUtils = import("Game.Fairyland.FairylandUtils")
        for i = #t, 1, -1 do
            local isLimitCard = FairylandUtils.IsLimitCard(FairylandUtils.CurrentEnterQuestId, t[i].refId)
            if isLimitCard then
                table.remove(t, i)
            end
        end
    end

    return t
end

---获取临时编队
function TeamComponent:GetTempTeam(questId)
    local team = checkTable(self._tempTeamTab)[tostring(questId)]
    if team then
        return team
    else
        -- 默认用第一编队填充，目前临时编队只有4人队，后续有其他类型再改
        team = clone(self:GetTeamInfoByTeamType(Constants.TeamMemberNumType.FOUR, 1))
        if BattleHelperConfMgr:GetInstance():IsCatBallLimit(questId) then
            team.catsInfo = self:GetEmptyTeamCat()
        end
        self._tempTeamTab[tostring(questId)] = team
        return team
    end
end

---设置临时编队
function TeamComponent:SetTempTeam(questId, cardTab, cb, skipAnim)
    if not cardTab then return end

    --直接覆盖
    local t = self:GetTempTeam(questId)
    if t then
        if t then
            t.cardsInfo = cardTab
        else
            t = {
                cardsInfo = cardTab
            }
        end
    else
        t = {
            cardsInfo = cardTab
        }
        checkTable(self._tempTeamTab)[tostring(questId)] = t
    end

    Events.Broadcast(Constants.EventNames.RefeshTeamMember, {skipAnim = skipAnim})
    
    if cb then
        cb()
    end
end

---清空临时编队
function TeamComponent:ClearTempTeam()
    self._tempTeamTab = {}
end

---设置临时编队猫球数据
---@param questId integer 关卡id
---@param catsInfo table 队伍猫信息
---@param cb fun():void 设置完成回调
function TeamComponent:SetTempTeamCat(questId, catsInfo, cb)
    if not catsInfo then return end

    catsInfo = checkTable(catsInfo)
    if #catsInfo < self:GetMaxTeamCatNum() then
        GameUtils.Toast(localize("设置无效的猫球"))
        return
    end

    --直接覆盖
    local t = self:GetTempTeam(questId) or {}
    t.catsInfo = catsInfo
    self._tempTeamTab[tostring(questId)] = t

    Events.Broadcast(Constants.EventNames.RefreshTeamCat)
    if cb then
        cb()
    end
end


--获取一支空的队伍
---@return TeamMemberDojo[]
function TeamComponent:GetEmptyTeam(questId)
    local t = {}
    for i = 1, self:GetMaxTeamMemberNum(questId) do
        local dojo = CfUtils.GetTeamMemberDojo()
        t[i] = dojo
    end
    return t
end

---GetTeamCatByQuestId 获取关卡id对应的猫
---@param questId integer @ 关卡id
---@param teamIndex integer @ 队伍下标
---@param arg table @ 扩展参数  isDontNeedHelper/是否不包含助战卡牌
---@return TeamCatBallDojo[]
function TeamComponent:GetTeamCatByQuestId(questId, teamIndex, arg)
    local ind = teamIndex and checkNumber(teamIndex) or self:GetSelectedTeamIndexByQuestId(questId)

    local t = self:GetTeamInfoByQuestId(questId)

    if self:IsUseOldTeams(questId) then
        local questType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
        if questType ~= Constants.IDType.QuestChaoticRecall  then
            ind = 1
        end
    elseif self:IsUseTempTeam(questId) then
        ind = 1
    end

    if not t then
        t = self:GetEmptyTeamCat()
    else
        t = t[ind]
        if t == nil or next(t) == nil then
            t = self:GetEmptyTeamCat()
        else
            t = t.catsInfo
            if t == nil or next(t) == nil then
                t = self:GetEmptyTeamCat()
            end
        end
    end

    if BattleHelperConfMgr:GetInstance():IsCatBallLimit(questId) then
        t = self:GetEmptyTeamCat()
    end
    
    --保证最大数量个数据
    if t then
        local num = self:GetMaxTeamCatNum(questId)
        if #t < num then
            local GetTeamCatDojo = CfUtils.GetTeamCatDojo
            for i = #t + 1, num do
                ---@type TeamCatBallDojo
                local teamCatDojo = GetTeamCatDojo()
                teamCatDojo:SetCatType(i)
                table.insert(t, teamCatDojo)
            end
        end

        local levelType =  GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
        if not isNull(levelType) then
            if levelType == Constants.IDType.ClubBoss then
              for i = 1, #t do
                  local isLimitCat = ClubUtils.IsBossLimitCat(t[i].playerCatId)
                  if isLimitCat then
                      local teamCatDojo =  CfUtils.GetTeamCatDojo()
                      teamCatDojo:SetCatType(i)
                      t[i] = teamCatDojo
                  end
              end
            elseif levelType == Constants.IDType.Fairyland then
                local FairylandUtils = import("Game.Fairyland.FairylandUtils")
                for i = 1, #t do
                    local isLimitCat = FairylandUtils.IsLimitCat(FairylandUtils.CurrentEnterQuestId, t[i].playerCatId)
                    if isLimitCat then
                        local teamCatDojo =  CfUtils.GetTeamCatDojo()
                        teamCatDojo:SetCatType(i)
                        t[i] = teamCatDojo
                    end
                end
            elseif levelType == Constants.IDType.ActivityCrisis then
                for i = 1, #t do
                    local ActivityCrisisUtils = import('Game.Activity.CrisisContract.ActivityCrisisUtils')
                    local entryData = ActivityCrisisUtils.GetActivityCrisisMgr():GetEntryData()
                    local isLimitCat = ActivityCrisisUtils.IsEntryLimitCat(entryData,t[i].catType)
                    if isLimitCat then
                        local teamCatDojo =  CfUtils.GetTeamCatDojo()
                        teamCatDojo:SetCatType(i)
                        t[i] = teamCatDojo
                    end
                end
            end
        end
    end
    return t
end

---GetTeamCatBySystemId 获取模块id对应的猫(弃用)
---@param systemId integer @ 模块id
---@param teamIndex integer 队伍下标
---@return table
function TeamComponent:GetTeamCatBySystemId(systemId, teamIndex)
    --默认都是取第一队列
    local ind = teamIndex and checkNumber(teamIndex) or 1
    
    systemId = checkString(systemId)
    local t = self._teamTab.oldTeams[systemId]

    if not t then
        return self:GetEmptyTeamCat()
    else
        t = t[ind]
        if t == nil or next(t) == nil then
            return self:GetEmptyTeamCat()
        else
            t = t.catsInfo
            if t == nil or next(t) == nil then
                return self:GetEmptyTeamCat() 
            end
        end
    end

    return t
end
--获取一支空的队伍猫
---@return TeamMemberDojo[]
function TeamComponent:GetEmptyTeamCat(questId)
    local t = {}
    local GetTeamCatDojo = CfUtils.GetTeamCatDojo
    for i = 1, self:GetMaxTeamCatNum(questId) do
        ---@type TeamCatBallDojo
        local dojo = GetTeamCatDojo()
        dojo:SetCatType(i)
        table.insert(t, dojo)
    end
    return t
end

---获取空编队名称
---@param index integer 编队序号
function TeamComponent:GetEmptyTeamName(index)
    return "TEAM" .. index
end

--设置快速编队时的缓冲队伍
---@param questId integer @ 关卡id
---@param status string @ 委托/正常
---@param teamIndex integer @ 队伍下标
---@param entrustId integer @ 队列id
---@param cb fun():void
function TeamComponent:SetBufferTeamToTeam(questId, status, teamIndex, entrustId, cb)
    local t = self:GetBufferTeam()
    if not t then
        return
    end
    self:SetTeamByQuestId(questId, t, status, teamIndex, entrustId, function()
        if cb then
            cb()
        end
    end)
end

--初始化一个缓存队伍
---@param t TeamMemberDojo[]
function TeamComponent:InitBufferTeam(t, questId)
    if not t then
        self._bufferTeamTab = {}
        for i = 1, self:GetMaxTeamMemberNum(questId) do
            local dojo = CfUtils.GetTeamMemberDojo()
            self._bufferTeamTab[i] = dojo
        end
    else
        self._bufferTeamTab = checkTable(clone(t))
    end
end

--初始化一个缓存队伍
---@param t TeamMemberDojo[]
function TeamComponent:InitBufferTeamByTeamType(t, teamType)
    if not t then
        self._bufferTeamTab = {}
        for i = 1, checkInt(teamType) do
            local dojo = CfUtils.GetTeamMemberDojo()
            self._bufferTeamTab[i] = dojo
        end
    else
        self._bufferTeamTab = checkTable(clone(t))
    end
end

--初始化一个初始队伍给ui用
function TeamComponent:InitDefaultTeam(t)
    self._defaultTeam = checkTable(t)
end
function TeamComponent:GetDefaultTeam()
    return checkTable(self._defaultTeam)
end

--获取缓存队伍
---@return TeamMemberDojo[]
function TeamComponent:GetBufferTeam()
    return self._bufferTeamTab
end

--清除缓存队伍
function TeamComponent:ClearBufferTeam()
    self._bufferTeamTab = nil
end

---AddTeamMember 增加一名队员  ！！缓存队伍操作
---@param t table
---@param dojo TeamMemberDojo @ 队员
function TeamComponent:AddTeamMember(t, dojo)
    if not t or not dojo then
        return
    end

    for k, v in pairs(t) do
        if checkNumber(v.fettersId) == checkNumber(dojo.refId) then
            v.fettersId = 0
        end
    end

    local t = checkTable(t)
    for k, v in pairs(t) do
        if table.count(v) <= 0 then
            t[k] = dojo
            return
        end
    end
end

---DelTeamMember 下阵一名队员  ！！缓存队伍操作
---@param t table
---@param dojo TeamMemberDojo
function TeamComponent:DelTeamMember(t, dojo)
    if not t or not dojo then
        return
    end

    local t = checkTable(t)
    for i = 1, #t do
        if t[i] and checkNumber(t[i].refId) == checkNumber(dojo.refId) then
            t[i] = {}
        end

        if t[i] and table.count(t[i]) <= 0 and i < #t then
            for j = i + 1, #t do
                if t[j] and table.count(t[j]) > 0 then
                    t[i] = t[j]
                    t[j] = {}
                    break 
                end    
            end
        end
    end
end

---AddTeamMemberByPos 增加一名队员通过位置  ！！缓存队伍操作
---@param t table 
---@param pos number @ 位置
---@param dojo TeamMemberDojo
function TeamComponent:AddTeamMemberByPos(t, pos, dojo)
    if not t or not dojo then
        return
    end
    pos = checkNumber(pos)
    if pos <= 0 then
        return
    end

    local t = checkTable(t)
    t[pos] = dojo
end

---DelTeamMemberByPos 下阵一名队员通过位置  ！！缓存队伍操作
---@param t table 
---@param pos number @ 位置
---@param dojo TeamMemberDojo
function TeamComponent:DelTeamMemberByPos(t, pos, dojo)
    if not t or not dojo then
        return
    end
    pos = checkNumber(pos)
    if pos <= 0 then
        return
    end

    local t = checkTable(t)
    for i = 1, #t do
        if t[i] and checkNumber(t[i].refId) == checkNumber(dojo.refId) then
            t[i] = {}
            return
        end
    end
end

---DelTeamMemberByPos  修改羁绊位置  ！！缓存队伍操作
--fettersId 唯一id
function TeamComponent:ChangeTeamFettersByCardId(t, tagetCardId, fettersId)
    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)

    tagetCardId = checkNumber(tagetCardId)
    fettersId = checkNumber(fettersId)
    local targetDojo = cardComponent:GetCardById(fettersId)

    if not t then
        return
    elseif tagetCardId <= 0 then
        return
    end
    local t = checkTable(t)

    if fettersId == 0 then
        for k, v in pairs(t) do
            if checkNumber(v.cardId) == checkNumber(tagetCardId) then
                v.fettersId = fettersId
                v.fettersCardId = 0
            end
        end
        return 
    end

    local targetVo = CardConfMgr:GetInstance():GetCardByRefId(targetDojo.cardId)
    for k, v in pairs(t) do
        --自己的卡才能换
        if checkNumber(v.type) == Constants.TeamMemberType.PlayerCard
        or checkNumber(v.type) == Constants.TeamMemberType.PlayerCardWithoutEquip then
            if checkNumber(v.cardId) > 0 then
                if checkNumber(v.fettersId) > 0 then
                    local dojo = cardComponent:GetCardById(v.fettersId)
                    local vo = CardConfMgr:GetInstance():GetCardByRefId(dojo.cardId)
                    if checkNumber(vo.characterId) == checkNumber(targetVo.characterId) then
                        v.fettersId = 0
                    end
                end
    
                if checkNumber(v.cardId) == checkNumber(tagetCardId) then
                    v.fettersId = fettersId
                    v.fettersCardId = targetDojo.cardId
                end
            end 
        end
    end
end

---GetTeamCardKey 获取卡牌id再队伍中的key
---@param t table
---@param cardId integer @ 卡牌id
---@return integer | nil
function TeamComponent:GetTeamCardKey(t, cardId)
    if not t or checkNumber(cardId) == 0 then
        return nil
    end

    local t = checkTable(t)
    if t then
        for k, v in pairs(t) do
            if checkNumber(v.refId) == checkNumber(cardId) then
                return checkNumber(k)
            end
        end
    end
    return nil
end

--是否是机器人羁绊
function TeamComponent:IsHelpFettersCardUse(t, cardId)
    if not t or checkNumber(cardId) <= 0 then
        return false
    end

    for k, v in pairs(t) do
        --不是自己的卡才判断
        print("[羁绊] ", v.type)
        if checkNumber(v.type) ~= Constants.TeamMemberType.PlayerCard
        and checkNumber(v.type) ~= Constants.TeamMemberType.PlayerCardWithoutEquip then
            if checkNumber(v.fettersId) > 0 then
                local vo1 = CardConfMgr:GetInstance():GetCardByRefId(v.fettersId)
                local vo2 = CardConfMgr:GetInstance():GetCardByRefId(cardId)
                if checkNumber(vo1.characterId) == checkNumber(vo2.characterId) then
                    return true
                end
            end
        end
    end
    return false
end

--是否可以更换羁绊
function TeamComponent:IsCanChangeTeamFettersCard(t, cardId)
    if not t or checkNumber(cardId) <= 0 then
        return false
    end

    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)

    local t = checkTable(t)
    for k, v in pairs(t) do
        if checkNumber(v.fettersId) > 0 then
            local dojo = cardComponent:GetCardById(v.fettersId)
            if dojo then
                local vo1 = CardConfMgr:GetInstance():GetCardByRefId(dojo.cardId)
                local vo2 = CardConfMgr:GetInstance():GetCardByRefId(cardId)
                if checkNumber(vo1.characterId) == checkNumber(vo2.characterId) then
                    return false
                end
            end
        end
    end
    return true
end

--获取羁绊卡牌id再队伍中的key
function TeamComponent:GetTeamFettersCardKey(t, cardId)
    if not t or checkNumber(cardId) <= 0 then
        return nil
    end
    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    local id = cardComponent:GetIdByCardId(cardId)

    local t = checkTable(t)
    if t then
        for k, v in pairs(t) do
            if checkNumber(v.fettersId) == checkNumber(id) then
                return checkNumber(k)
            end
        end
    end
    return nil
end

---GetTeamCardData 获取卡牌id再队伍中的数据
---@param t table
---@param cardId integer @ 卡牌id
---@return table | nil
function TeamComponent:GetTeamCardData(t, cardId)
    if not t or checkNumber(cardId) == 0 then
        return nil
    end

    local t = checkTable(t)
    if t then
        for k, v in pairs(t) do
            if checkNumber(v.refId) == checkNumber(cardId) then
                return v
            end
        end
    end
    return nil
end

--获取队伍中按顺序读到的第count个卡牌id
---@param team table
---@param targetTeam table
---@param count integer
---@return table
function TeamComponent:GetFirstTeamMember(team, targetTeam, count)
    if not team then return {} end
    team = checkTable(team)
    count = checkNumber(count)
    for i = 1, #team do
        if self:IsCanJoinTeam(targetTeam, team[i]) then
            count = count - 1
            if count <= 0 then
                return checkTable(team[i])
            end
        end
    end
    return {}
end

---IsCanJoinTeam 是否可以加入队伍
---@param team CardDojo[]
---@param data CardDojo @ 需要有key：cardId
---@return boolean
function TeamComponent:IsCanJoinTeam(team, data)
    if not team or not data then
        return false
    end
    if checkNumber(data.cardId) <= 0 then
        return false
    end

    for k, v in pairs(team) do
        if checkNumber(v.cardId) == checkNumber(data.cardId) then
            return false
        end

        --相同角色也不能
        if checkNumber(v.cardId) > 0 then
            local vo1 = CardConfMgr:GetInstance():GetCardByRefId(v.cardId)
            local vo2 = CardConfMgr:GetInstance():GetCardByRefId(data.cardId)
            if checkNumber(vo1.characterId) == checkNumber(vo2.characterId) then
                return false
            end
        end
    end

    return true
end

--获取队伍队员数量
---@param t table
---@return integer
function TeamComponent:GetTeamMemberCount(t)
    local count = 0
    if not t then
        return count
    end
    for k, tmDojo in pairs(t) do
        tmDojo = checkTable(tmDojo)
        if checkNumber(tmDojo.refId) > 0 then
            count = count + 1
        end
    end
    return count
end

--判断该卡是否再对应队伍中
---@param questId integer
---@param id integer
---@param teamIndex integer
---@return boolean
function TeamComponent:IsCardInTeam(questId, id, teamIndex)
    questId = checkNumber(questId)
    id = checkNumber(id)
    local t = self:GetTeamByQuestId(questId, teamIndex)
    if not t then
        return false
    end

    --判断玩家手动选择的
    for k, v in pairs(t) do
        if id then
            if self:IsCardInBattleHelpTeam(questId, id) or checkNumber(v) == checkNumber(id) then
                return true
            end
        end
    end
end

---GetCardTeamIndex 判断该卡是否在某个模块的队伍中
---@param questId integer
---@param id integer @ 卡牌唯一id
---@return boolean, integer
function TeamComponent:IsCardInAllTeam(questId, id)
    local t = self:GetTeamInfoByQuestId(questId)
    if not t then
        return false
    end
    for k, v in pairs(t) do 
        local cards = checkTable(v.cardsInfo)
        for _, tmDojo in pairs(cards) do
            if checkNumber(tmDojo.refId) == checkNumber(id) then
                return true, checkNumber(k)
            else
                if checkNumber(tmDojo.fettersId) == checkNumber(id) then
                    return true, checkNumber(k)
                end
            end
        end
    end
    return false
end

---GetCardTeamIndex 判断该卡是否在某个模块的队伍中
---@param teamType integer
---@param id integer @ 卡牌唯一id
---@return boolean, integer
function TeamComponent:IsCardInAllTeamByTeamType(teamType, id)
    local t = self:GetTeamInfoByTeamType(teamType)
    if not t then
        return false
    end
    for k, v in pairs(t) do
        local cards = checkTable(v.cardsInfo)
        for _, tmDojo in pairs(cards) do
            if checkNumber(tmDojo.refId) == checkNumber(id) then
                return true, checkNumber(k)
            else
                if checkNumber(tmDojo.fettersId) == checkNumber(id) then
                    return true, checkNumber(k)
                end
            end
        end
    end
    return false
end

---IsCardFetterInAllTeam
---用于检查羁绊卡是否存在于编队中
---@param questId number 关卡Id
---@param id number 卡牌id
function TeamComponent:IsCardFetterInAllTeam(questId, id)
    local t = self:GetTeamInfoByQuestId(questId)
    if not t then
        return false
    end
    local checkTable  = checkTable
    local checkNumber = checkNumber
    id = checkNumber(id)
    for k, v in pairs(t) do 
        local cards = checkTable(v.cardsInfo)
        for _, tmDojo in pairs(cards) do
            if checkNumber(tmDojo.fettersId) == id then
                return true, checkNumber(k)
            end
        end
    end
    return false
end

---IsCardFetterInAllTeamByTeamType 
---用于检查羁绊卡是否存在于编队中
---@param teamType integer
---@param id integer @ 卡牌唯一id
---@return boolean, integer
function TeamComponent:IsCardFetterInAllTeamByTeamType(teamType, id)
    local t = self:GetTeamInfoByTeamType(teamType)
    if not t then
        return false
    end
    local checkTable  = checkTable
    local checkNumber = checkNumber
    id = checkNumber(id)
    for k, v in pairs(t) do 
        local cards = checkTable(v.cardsInfo)
        for _, tmDojo in pairs(cards) do
            if checkNumber(tmDojo.fettersId) == id then
                return true, checkNumber(k)
            end
        end
    end
    return false
end

---IsCardInTeamByTeam 判断俩个队伍是否有相同的卡
---@param teamTab1 table 一个队伍数据
---@param teamTab2 table 一个队伍数据
---@return boolean
function TeamComponent:IsCardRepeatInTeam(teamTab1, teamTab2)
    if not teamTab1 or not teamTab2 then
        return false
    end

    for i, dojo in pairs(teamTab1) do
        --如果队伍中有这张卡
        if self:GetTeamCardKey(teamTab2, dojo.refId) then
            return true
        end
    end
    return false
end

--判断该卡是否再配置机器人中
---@param questId integer
---@param id integer
---@return boolean
function TeamComponent:IsCardInBattleHelpTeam(questId, id)
    questId = checkNumber(questId)
    id = checkNumber(id)
    local isHasBattleHelper = QuestConfMgr:GetInstance():IsQuestHasHelper(questId)
    if isHasBattleHelper then
        local helperTeam = QuestConfMgr:GetInstance():GetQuestHelpers(questId)
        for i = 1, #helperTeam do
            if checkTable(helperTeam[i].refId) == id then
                return true
            end
        end
    end
    return false
end

--获取队伍最大的队员数量
---无法统一使用下方读取配表配置的数目，会有问题，不知道怎么改。目前5人本还需在此配置才能生效
---@return integer
function TeamComponent:GetMaxTeamMemberNum(questId)
    local type = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    --世界boss五个
    if type == Constants.IDType.QuestWorldBoss then
        return Constants.WorldBossTeamCount
    elseif type == Constants.IDType.ActivityCrisis then
        local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
        if questVo and checkNumber(questVo.roleNun) > 0 then
            return checkNumber(questVo.roleNun)
        end
    end
    return checkNumber(self.MaxNum)
end

function TeamComponent:GetMaxTeamMemberNumByQuestId(questId)
    if not questId or checkInt(questId) == 0 then return checkNumber(self.MaxNum) end
    
    local type = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    --世界boss五个
    if type == Constants.IDType.QuestWorldBoss then
        return Constants.WorldBossTeamCount
    end

    local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
    if questVo and checkNumber(questVo.roleNun) > 0 then
        return checkNumber(questVo.roleNun)
    end

    return checkNumber(self.MaxNum)
end

--获取队伍猫球最大数量
---@return integer
function TeamComponent:GetMaxTeamCatNum(questId)
    return self._maxCatNum
end

--获取最多选择队员数量
---@param questId integer
---@param status integer
---@param teamIndex integer
---@return integer
function TeamComponent:GetMaxSelectNum(questId, status, teamIndex)
    --特殊的一些关卡处理
    if checkNumber(questId) == Constants.SpecialQuestId.PlayerInfoId or
       checkNumber(questId) == Constants.SpecialQuestId.PVPArenaId or
       checkNumber(questId) == Constants.SpecialQuestId.LadderId then
        return self:GetMaxTeamMemberNum(questId)
    end

    status = checkNumber(status)
    --[[
    --如果不是委托
    if status == Constants.ChooseCardStatus.Normal then
        local questTeammemberCount = QuestConfMgr:GetInstance():GetTeamMemberNum(questId)
        local isHasBattleHelper = QuestConfMgr:GetInstance():IsQuestHasHelper(questId)
        --如果有机器人
        if isHasBattleHelper then
            local helperTeam = QuestConfMgr:GetInstance():GetQuestHelpers(questId)
            local count = 0
            for i = 1, #helperTeam do
                if table.count(helperTeam[i]) > 0 then
                    count = count + 1
                end
            end
            return questTeammemberCount - count
        end
    end
    ]]
    return self:GetMaxTeamMemberNum(questId)
end

function TeamComponent:GetMaxSelectNumByQuestId(questId)
    return self:GetMaxTeamMemberNumByQuestId(questId)
end

---GetSystemId 获取关卡对应的模块id
---@param questId integer @ 关卡id
---@return integer
function TeamComponent:GetSystemId(questId)
    questId = checkNumber(questId)
    --特殊的一些关卡处理
    if questId == Constants.SpecialQuestId.PlayerInfoId then
        return checkString(Constants.SystemToggleIds.Id99999)
    elseif questId == Constants.SpecialQuestId.PVPArenaId then
        return checkString(Constants.SystemToggleIds.Id16)
    elseif questId == Constants.SpecialQuestId.LadderId then
        return checkString(Constants.SystemToggleIds.Id2008)
    elseif questId == Constants.SpecialQuestId.LadderStruggleId then
        return checkString(Constants.SystemToggleIds.Id2007)
    elseif questId == Constants.SpecialQuestId.LadderStruggleSingleId then
        return checkString(Constants.SystemToggleIds.Id2017)
    elseif questId == Constants.SpecialQuestId.Mirror then
        return checkString(Constants.SystemToggleIds.Id110005)
    elseif questId == Constants.SpecialQuestId.ClubGVGId then
        return checkString(Constants.SystemToggleIds.Id4006)
    elseif questId == Constants.SpecialQuestId.FriendPVPId then
        return checkString(Constants.SystemToggleIds.Id271)
    end

    local questType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    return self:GetSystemIdByQuestType(questType, questId)
end

---GetSystemIdByQuestType 获取关卡对应的模块id
---@param questType Constants.IDType @ 关卡类型
---@param questId integer
---@return string
function TeamComponent:GetSystemIdByQuestType(questType, questId)
    local systemId = 0
    if questType == Constants.IDType.QuestMain or questType == Constants.IDType.QuestPrologues then
        systemId = Constants.SystemToggleIds.Id2
    elseif questType == Constants.IDType.QuestMainChallenge then
        systemId = Constants.SystemToggleIds.Id245
    elseif questType == Constants.IDType.QuestCoinsCopy then
        systemId = Constants.SystemToggleIds.Id4
    elseif questType == Constants.IDType.QuestDaily then
        systemId = Constants.SystemToggleIds.Id2001
    elseif questType == Constants.IDType.QuestExpCopy then
        systemId = Constants.SystemToggleIds.Id5
    elseif questType == Constants.IDType.QuestUpStarCopy then
        systemId = Constants.SystemToggleIds.Id6
    elseif questType == Constants.IDType.QuestMaze then
        systemId = Constants.SystemToggleIds.Id8
    elseif questType == Constants.IDType.QuestPatrolMaze then
        systemId = Constants.SystemToggleIds.Id1217
    elseif questType == Constants.IDType.QuestTrail then
        systemId = Constants.SystemToggleIds.Id9
    elseif questType == Constants.IDType.QuestGachaCoin then
        systemId = Constants.SystemToggleIds.Id11
    elseif questType == Constants.IDType.QuestGachaCoinChallenge then
        systemId = Constants.SystemToggleIds.Id25
    elseif questType == Constants.IDType.QuestPrimaryEquipCopy then
        systemId = Constants.SystemToggleIds.Id10
    elseif questType == Constants.IDType.QuestSeniorEquipCopy then
        local questConfMgr = QuestConfMgr:GetInstance()
        local questVo = questConfMgr:GetQuestVoById(questId)
        if not isNull(questVo) then
            if checkNumber(questVo.type) == 1 then
                systemId = Constants.SystemToggleIds.Id402
            elseif checkNumber(questVo.type) == 2 then
                systemId = Constants.SystemToggleIds.Id403
            elseif checkNumber(questVo.type) == 3 then
                systemId = Constants.SystemToggleIds.Id404
            elseif checkNumber(questVo.type) == 4 then
                systemId = Constants.SystemToggleIds.Id405
            end
        end
    elseif questType == Constants.IDType.QuestRoleStoryCopy then
        systemId = Constants.SystemToggleIds.Id13
    elseif questType == Constants.IDType.QuestTower then
        local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
        if not isNull(questVo) then
            ---type跟着定时副本类型表的id一一对应
            if checkNumber(questVo.type) == 1 then
                systemId = Constants.SystemToggleIds.Id2011
            elseif checkNumber(questVo.type) == 2 then
                systemId = Constants.SystemToggleIds.Id2012
            elseif checkNumber(questVo.type) == 3 then
                systemId = Constants.SystemToggleIds.Id2014
            elseif checkNumber(questVo.type) == 4 then
                systemId = Constants.SystemToggleIds.Id2013
            end
        end
    elseif questType == Constants.IDType.QuestWorldBoss then
        systemId = Constants.SystemToggleIds.Id14
    elseif questType == Constants.IDType.QuestBambooChanllenge then
        systemId = Constants.SystemToggleIds.Id1201
    elseif questType == Constants.IDType.QuestDirectionalFight then
        local questConfMgr = QuestConfMgr:GetInstance()
        local questVo = questConfMgr:GetQuestVoById(questId)
        if not isNull(questVo) then
            ---type跟着定时副本类型表的id一一对应
            if checkNumber(questVo.type) == 1 then
                systemId = Constants.SystemToggleIds.Id55
            elseif checkNumber(questVo.type) == 2 then
                systemId = Constants.SystemToggleIds.Id56
            elseif checkNumber(questVo.type) == 3 then
                systemId = Constants.SystemToggleIds.Id57
            elseif checkNumber(questVo.type) == 4 then
                systemId = Constants.SystemToggleIds.Id58
            elseif checkNumber(questVo.type) == 5 then
                systemId = Constants.SystemToggleIds.Id59
            end
        end
    elseif questType == Constants.IDType.QuestTrainField then
        local questConfMgr = QuestConfMgr:GetInstance()
        local questVo = questConfMgr:GetQuestVoById(questId)
        if not isNull(questVo) then
            if checkNumber(questVo.group) == 1 then
                systemId = Constants.SystemToggleIds.Id30
            elseif checkNumber(questVo.group) == 2 then
                systemId = Constants.SystemToggleIds.Id31
            elseif checkNumber(questVo.group) == 3 then
                systemId = Constants.SystemToggleIds.Id32
            end
        end
    elseif questType == Constants.IDType.QuestForging then
        systemId = Constants.SystemToggleIds.Id21
    elseif questType == Constants.IDType.QuestTalent then
        systemId = Constants.SystemToggleIds.Id22
    elseif questType == Constants.IDType.QuestMediumPT then
        systemId = Constants.SystemToggleIds.Id1202
    elseif questType == Constants.IDType.QuestCardExperience then
        systemId = Constants.SystemToggleIds.Id1208
    elseif questType == Constants.IDType.ActivityQuestSkinExperience then
        systemId = Constants.SystemToggleIds.Id1210
    elseif questType == Constants.IDType.QuestAdvancedTraining then
        systemId = Constants.SystemToggleIds.Id23
    elseif questType == Constants.IDType.QuestNightCatTower then
        systemId = Constants.SystemToggleIds.Id1206
    elseif questType == Constants.IDType.QuestNightCatBoss then
        systemId = Constants.SystemToggleIds.Id1216
    elseif questType == Constants.IDType.MournTower then
        systemId = Constants.SystemToggleIds.Id12002501
    elseif questType == Constants.IDType.MournBoss then
        systemId = Constants.SystemToggleIds.Id12002502
    elseif questType == Constants.IDType.MournPlot then
        systemId = Constants.SystemToggleIds.Id120025
    elseif questType == Constants.IDType.QuestBossChallenge then
        systemId = Constants.SystemToggleIds.Id1205
    elseif questType == Constants.IDType.QuestHalloween then
        systemId = Constants.SystemToggleIds.Id1209
    elseif questType == Constants.IDType.QuestMapDecryptionTracking or questType == Constants.IDType.QuestMapDecryptionMap then
        systemId = Constants.SystemToggleIds.Id1214
    elseif questType == Constants.IDType.QuestAnnihilation then
        systemId = Constants.SystemToggleIds.Id2003
    elseif questType == Constants.IDType.QuestRegion then
        systemId = Constants.SystemToggleIds.Id2001
    elseif questType == Constants.IDType.QuestLadderStruggle then
        systemId = Constants.SystemToggleIds.Id2007
    elseif questType == Constants.IDType.QuestChapterEvent then
        systemId = Constants.SystemToggleIds.Id3016
    elseif questType == Constants.IDType.ClubBoss then
        systemId = Constants.SystemToggleIds.Id4004
    elseif questType == Constants.IDType.QuestMidFestivalStory then
        systemId = Constants.SystemToggleIds.Id5002
    elseif questType == Constants.IDType.QuestMidFestivalRecord then
        systemId = Constants.SystemToggleIds.Id5003
    elseif questType == Constants.IDType.QuestMidFestivalBoss then
        systemId = Constants.SystemToggleIds.Id5004
    elseif questType == Constants.IDType.QuestChaoticRecall then
        systemId = Constants.SystemToggleIds.Id2019
    elseif questType == Constants.IDType.Fairyland then
        systemId = Constants.SystemToggleIds.Id110005
    elseif questType == Constants.IDType.DreamAdventuresPlot or questType == Constants.IDType.DreamAdventuresLuby then
        systemId = Constants.SystemToggleIds.Id120008
    elseif questType == Constants.IDType.ClubCatCarBoss then
        systemId = Constants.SystemToggleIds.Id4005
    elseif questType == Constants.IDType.ActivityCakeQuest then
        systemId = Constants.SystemToggleIds.Id5005
    elseif questType == Constants.IDType.ActivityCakeBoss then
        systemId = Constants.SystemToggleIds.Id5007
    elseif questType == Constants.IDType.QuestClubGVG then
        systemId = Constants.SystemToggleIds.Id4006
    elseif questType == Constants.IDType.ActivityCrisis then
        systemId = Constants.SystemToggleIds.Id120015
    elseif questType == Constants.IDType.ActivityWorldMiniQuestBoss then
        systemId = Constants.SystemToggleIds.Id12001802 ---boss
    elseif questType == Constants.IDType.ActivityWorldMiniQuest then
        systemId = Constants.SystemToggleIds.Id12001801 ---微缩世界普通战斗
    elseif questType == Constants.IDType.JapaneseStoryPlot then
        systemId = Constants.SystemToggleIds.Id5008
    elseif questType == Constants.IDType.JapaneseStoryBoss then
        systemId = Constants.SystemToggleIds.Id5009
    elseif questType == Constants.IDType.CustomTrain then
        systemId = Constants.SystemToggleIds.Id120036
    elseif questType == Constants.IDType.BeginnerBoss then
        systemId = Constants.SystemToggleIds.Id5015
    end
    return checkString(systemId)
end


--------------------------------------------------------------------------抽卡副本部分血量信息------------------------------------------------------
--- 获取队伍的战斗力
---@param teamTab table[] @ 队伍格式
---@param teamCats TeamCatBallDojo[] @ 队伍上阵的猫球
---@param vo QuestMainVo
---@return integer
function TeamComponent:GetTeamFightingPower(teamTab, teamCats, vo)
    local fightPower = 0
    if not teamTab then
        return fightPower
    end

    ---@type CardComponent
    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    for i, v in pairs(teamTab) do
        ---@type CardDojo
        local cardData = nil
        if v.type == Constants.TeamMemberType.HelperCard then
            ---@type MazeTeamComponent
            local mazeTeamComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MazeTeamComponent, Constants.MazeTeamEntityId)
            cardData = mazeTeamComp:GetFakeRoleData(v.refId)
            fightPower = fightPower + FormulaUtils.GetCardFightingStrengthen(cardData, nil, true)

        elseif v.type == Constants.TeamMemberType.PatrolMazeCard then
            local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
            local patrolMazeComp  = PatrolMazeUtils.GetComp()
            local mazeAreaDojo    = patrolMazeComp:GetHomeDojo():GetAreaDojo(v.areaId)
            local mazeCardDojo    = mazeAreaDojo:GetMazeCard(v.refId)
            cardData = mazeCardDojo:GetCardDojo()

            ---@type CardProgressionUtils
            local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
            local entity = CardProgressionUtils.GenerateEntityByRobot(cardData)
            entity:FillPureCard(true)
            if mazeCardDojo.isAssist then
                local assistVo = PatrolMazeUtils.GetAssistCardVo(mazeCardDojo.assistId)
                entity:FillAdditionMap(assistVo.additionMap)
            end
            fightPower = fightPower + FormulaUtils.CalcCardCombatEffectiveness(entity, nil, nil)

        elseif v.type == Constants.TeamMemberType.QuestLockHelperCard and vo then
            cardData = BattleHelperConfMgr:GetInstance():GetMainLevelHelper(vo.petLineup, v.cardId)
            fightPower = fightPower + FormulaUtils.GetCardFightingStrengthen(cardData, {teamCats = teamCats}, true)

        elseif v.type == Constants.TeamMemberType.PlayerCardWithoutEquip then
            cardData = cardComponent:GetCardById(v.refId)
            cardData = clone(cardData)
            for i = 1, 6 do
                cardData["equipment" .. tostring(i)] = 0
            end
            ---@type CardProgressionUtils
            local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
            local entity = CardProgressionUtils.GenerateEntityByRobot(cardData)
            entity.isIgnoreGlobal = true

            local synergiesId, synergiesDojo
                if checkNumber(v.fettersId) > 0 then
                    local dojo = cardComponent:GetCardById(v.fettersId)
                    synergiesId = CardConfMgr:GetInstance():GetRoleCardSynergiesId(cardData.cardId, dojo.cardId)
                    synergiesDojo = dojo
                end

            fightPower = fightPower + FormulaUtils.CalcCardCombatEffectiveness(entity, {synergiesId = synergiesId, synergiesDojo = synergiesDojo, teamCats = teamCats}, nil)
        else
            local cardData = cardComponent:GetCardById(v.refId)
            if cardData then
                local synergiesId, synergiesDojo
                if checkNumber(v.fettersId) > 0 then
                    local dojo = cardComponent:GetCardById(v.fettersId)
                    synergiesId = CardConfMgr:GetInstance():GetRoleCardSynergiesId(cardData.cardId, dojo.cardId)
                    synergiesDojo = dojo
                end

                fightPower = fightPower + FormulaUtils.GetCardFightingStrengthen(cardData, {synergiesId = synergiesId, synergiesDojo = synergiesDojo, teamCats = teamCats}, false)
            end
        end
    end
    return fightPower
end 

--------------------------------------------------------------------------------委托部分-----------------------------------------------------------
--初始化委托战斗信息
function TeamComponent:InitialEntrustData(jsonData)
    if not self.entrustQueues then 
        self.entrustQueues = {}
    end
    self:InitEntrustTeam()

    local data = checkTable(jsonData)
    for k, v in pairs(data) do
        local dojo = EntrustTeamDojo.New()
        dojo:Fill(v)
        dojo.cardsId = (table.deserialize(dojo.cardsId) and table.deserialize(dojo.cardsId) or {})
        self.entrustQueues[dojo.id] = dojo
    end

    self:RefeshEntrustRedPointNum()
    --print("InitialEntrustData"..table.dump(jsonData, nil, 3))
end

--初始化委托的一次性列表
function TeamComponent:InitEntrustTeam()
    for i = 1, self:GetMaxTeamMemberNum() do
        self.entrustTeam[i] = 0
    end
    self.entrustNum = 1
end

---EntrustReq  委托请求
---@param questId integer @ 关卡(配表)
---@param questSum integer @ 委托次数
---@param questVo any
---@param entrustId integer @ 队列id
---@param unusedGoods table @ 不使用的道具idLsit
function TeamComponent:EntrustReq(questId, questSum, questVo, entrustId, unusedGoods)
    --使用的所有物品
    local useItems, isCanPay = CfUtils.GetUseItemByStrenth((questVo.costNum + questVo.costNumLose) * questSum, nil, unusedGoods)
    if not isCanPay then
        for k, v in pairs(useItems) do 
            if GoodsUtils.GetThingNo(v.goodsId) < checkNumber(v.num) then
                local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(v.goodsId)
                if vo then
                    GameUtils.Toast(localize("_name_不足", {_name_ = vo.name}))
                end
                break
            end

        end
        return
    end
    local isConsumeDiamond = #unusedGoods > 0 and 0 or 1
    GameUtils.Request(Interfaces.EntrustBattle, {questId = questId, teamId = entrustId, questSum = questSum, consume = table.serialize(useItems), isConsumeDiamond = isConsumeDiamond}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        for k, v in pairs(useItems) do
            if checkNumber(v.goodsId) == Constants.Currency.FreeDiamondId then--消耗体力兑换次数
                local changeData = CfUtils.GetCfVo(AutoIds.IdSetting302, "ExchangeStrengthVo", Constants.Currency.FreeDiamondId)
                local number = v.num / checkNumber(changeData.itemIdCost)
                local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
                playerComponent.playerDojo.buyHpNum = checkNumber(playerComponent.playerDojo.buyHpNum) + number
            end
        end
        local jsonData = response.data
        self:InitEntrustTeam()
        local entrustQueue = self:GetEntrustQueueData(entrustId)
        if entrustQueue then
            local StoreConstants = import('Game.UI.Store.StoreConstants')
            local storeComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.StoreComponent)
            -- 海外月卡没有特权
            local monthCardNum = 1
            --checkNumber(storeComp:GetMonthCardPrivilege(StoreConstants.MonthCardPrivileges.AutoTimes))
            --local monthCardNum = checkNumber(storeComp:GetMonthCardPrivilege(StoreConstants.MonthCardPrivileges.AutoTimes))
            --if monthCardNum == 0 then--没开月卡
            --    monthCardNum = 1
            --    entrustQueue.isMonthCard = 0
            --else--开了月卡
            --    entrustQueue.isMonthCard = 1
            --end

            entrustQueue.questId = questId
            entrustQueue.expirationTime = TimeZoneUtils.UtcSeconds + checkNumber(questVo.time * monthCardNum * questSum)
            entrustQueue.questSum = questSum
        end

        local hpInfo = jsonData.hpInfo
        if hpInfo then
            local strength = {
                [1] = {
                    goodsId = Constants.Currency.HpId,
                    num = checkNumber(hpInfo.hp) - GoodsUtils.GetThingNo(Constants.Currency.HpId)
                }
            } 
            GoodsUtils.DrawRewards(strength)
        end
        --扣除使用道具
        GoodsUtils.ConsumeGoods(useItems)

        Events.Broadcast(Constants.EventNames.UIEntrustBattleSuccess, nil)
    end)
end

---EntrustGetRewardReq  委托结算
---@param id integer @ 队列id
function TeamComponent:EntrustGetRewardReq(id)
    GameUtils.Request(Interfaces.EntrustGetReward, {id = id}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end

        local jsonData = response.data
        local entrustQueue = self:GetEntrustQueueData(id)
        GoodsUtils.DrawRewards(jsonData.rewards)
        --更新经验
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        playerComponent:UpdatePlayerLvMainExp(jsonData.playerLv, jsonData.mainExp)
        --更新卡牌
        local cards = jsonData.cardExp
        ---@type CardComponent
        local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
        for k, v in pairs(cards) do
            cardComponent:UpdateCardDojo(k, v)
        end
        if not isNull(jsonData.hp) then
            GoodsUtils.DrawRewards({
                {
                num = checkNumber(jsonData.hp) - GoodsUtils.GetThingNo(Constants.Currency.HpId),
                goodsId = Constants.Currency.HpId
                }
            })
        end

        if not entrustQueue then
            return
        end
        local energyPoint = checkNumber(jsonData.energyPoint)
        --能源点大于0
        if energyPoint > 0 then
            local type = GoodsUtils.GetIdType(entrustQueue.questId, Constants.IDArea.Quests)     --关卡类型
            --副本才有能源点
            if type == Constants.IDType.QuestCoinsCopy or type == Constants.IDType.QuestExpCopy or type == Constants.IDType.QuestUpStarCopy then
                local questVo = QuestConfMgr:GetInstance():GetQuestVoById(entrustQueue.questId)
                if questVo then
                    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.DailyQuestComponent)
                    local dailyQuestDojo = comp:GetDailyQuestDojoByType(questVo.type)
                    if dailyQuestDojo then
                        local lastEnergyPoint = checkNumber(dailyQuestDojo.energyPoint)
                        comp:UpdateDailyPoint(questVo.type, lastEnergyPoint + energyPoint)
                        local dailyTypeVo = CfUtils.GetCfVo(AutoIds.IdSetting310, "DailyTypeVo", dailyQuestDojo.type)
                        if dailyTypeVo and jsonData.rewards then
                            table.insert(jsonData.rewards, {
                                goodsId = dailyTypeVo.energyPointItem,
                                num = energyPoint
                            })
                        end
                    end
                end
            end
        end
        UIModule.OpenDialog({id = Constants.UITypeIds.UIEntrustEndDialog, parameters = {rewards = jsonData.rewards, entrustQueueData = clone(entrustQueue)}})

        --更新队列信息
        entrustQueue:RefeshDojo()

        local t = self:GetEntrustQueueData(id)
        print(table.dump(t))
        entrustQueue.unlock = checkNumber(jsonData.isOpen)
        Events.Broadcast(Constants.EventNames.EntrustRewardGet, id)
    end)
end

---ChangeEntrustTeamReq  委托更改队伍
---@param entrustId integer @ 队列id
---@param cardTab table @ 队伍
---@param cb fun():void
function TeamComponent:ChangeEntrustTeamReq(entrustId, cardTab, cb)
    if not cardTab then
        return
    end
    local allCards = self:GetEntrustTeamChange(entrustId, cardTab)

    local t = {}
    for k, _cards in pairs(allCards) do
        t[checkString(k)] = self:GetAllCardId(_cards)
    end
    print(table.dump(t))
    GameUtils.Request(Interfaces.EntrustSetTeam, {team = table.serialize(t)}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        for k, v in pairs(allCards) do
            local dojo = self:GetEntrustQueueData(k)
            if dojo then
                dojo.cardsId = v
            end
        end
        Events.Broadcast(Constants.EventNames.EntrustDataRefesh, nil) 
        if cb then
            cb()
        end
    end)
end

---ChangeEntrustTeamHander  委托更改队伍完成后下阵其他队列中的同样卡牌
---@param entrustId integer 队列id
---@param cardTab table @ 队伍
function TeamComponent:ChangeEntrustTeamHander(entrustId, cardTab)
    if not entrustId or not cardTab then
        return
    end
    if not self.entrustQueues then 
        return
    end
    local maxCount = self:GetMaxTeamMemberNum()

    for k, v in pairs(self.entrustQueues) do
        --不是改变队列的才下阵
        if checkNumber(k) ~= checkNumber(entrustId) then
            local cards = v.cardsId
            --如果俩个队伍有相同的成员
            if self:IsCardRepeatInTeam(cardTab, cards) then
                local t = {}
                for i, teamMember in pairs(cards) do
                    --如果队伍中有这张卡
                    if not self:GetTeamCardKey(cardTab, teamMember.refId) then
                        table.insert(t, teamMember)
                    end
                end
                if table.count(t) < maxCount then
                    for i = table.count(t) + 1, maxCount do
                        table.insert(t, {})
                    end
                end
                v.cardsId = t
            end
        end
    end
end

---GetEntrustTeamChange  获取委托更改队伍后其他的队伍情况
---@param entrustId integer @ 队列id
---@param cardTab table @ 队伍
---@return table<string, table>
function TeamComponent:GetEntrustTeamChange(entrustId, cardTab)
    if not entrustId or not cardTab then
        return
    end
    if not self.entrustQueues then 
        return
    end
    local maxCount = self:GetMaxTeamMemberNum()

    local _t = {}
    for k, v in pairs(self.entrustQueues) do
        --不是改变队列的才下阵
        if checkNumber(k) ~= checkNumber(entrustId) then
            local cards = v.cardsId
            --如果俩个队伍有相同的成员
            if self:IsCardRepeatInTeam(cardTab, cards) then
                local t = {}
                for i, teamMember in pairs(cards) do
                    --如果队伍中有这张卡
                    if not self:GetTeamCardKey(cardTab, teamMember.refId) then
                        table.insert(t, teamMember)
                    end
                end
                if table.count(t) < maxCount then
                    for i = table.count(t) + 1, maxCount do
                        table.insert(t, {})
                    end
                end
                _t[checkString(k)] = t
            end
        else
            _t[checkString(k)] = cardTab
        end
        
    end
    return _t
end

---BuyEntrustRequeueReq  委托购买
---@param id integer 队列id
function TeamComponent:BuyEntrustRequeueReq(id)
    GameUtils.Request(Interfaces.EntrustBuy, {id = id}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local vo = CfUtils.GetCfVo(AutoIds.IdSetting610, "EntrustBattleTeamUnlockVo", id)
        if vo then
            local consume = {
                {
                    goodsId = checkString(vo.unlockId),
                    num = -checkNumber(vo.unlockNum),
                }
            }
            GoodsUtils.DrawRewards(consume)
        end
        self:UnlockEntrustRequeue(id)
        Events.Broadcast(Constants.EventNames.EntrustDataRefesh, nil)   
    end)
end

---UpdateEntrustRequeueData 根据解锁条件更新队列信息
function TeamComponent:UpdateEntrustRequeueData()
    for k, v in pairs(self.entrustQueues) do
        --未解锁的才去判断
        if checkNumber(v.unlock) == 0 then
            local vo = CfUtils.GetCfVo(AutoIds.IdSetting610, "EntrustBattleTeamUnlockVo", k)
            if vo then
                if GameUtils.IsUnlocked(checkString(vo.unlockType), checkString(vo.unlockNum)) then
                    v.unlock = 1
                end
            end
        end
    end
end

---UnlockEntrustRequeue 解锁一条队列
---@param id integer @ 队列id
function TeamComponent:UnlockEntrustRequeue(id)
    local eq = self:GetEntrustQueueData(id)
    if not eq then
        return
    end
    eq.unlock = 1
end

--设置委托次数
---@param num integer
function TeamComponent:SetEntrustNum(num)
    if not num then return end
    self.entrustNum = checkNumber(num)
end

--获取委托次数
---@return integer
function TeamComponent:GetEntrustNum()
    return checkNumber(self.entrustNum)
end

---GetAllEntrustArr  获取所有委托战斗队列，数组
---@return EntrustTeamDojo[]
function TeamComponent:GetAllEntrustArr()
    local t = {}
    for k, v in pairs(self.entrustQueues) do
        table.insert(t, v)
    end
    return t
end

---GetEntrustQueueData  获取一个委托队列数据
---@param entrustId integer @ 队列id
---@return EntrustTeamDojo | nil
function TeamComponent:GetEntrustQueueData(entrustId)
    if not self.entrustQueues then
        return nil
    end
    for k, v in pairs(self.entrustQueues) do
        if checkNumber(k) == checkNumber(entrustId) then
            return v
        end
    end
    return nil
end

---GetEntrustTeamData  获取一个委托队列的队伍
---@param entrustId integer @ 队列id
---@return table
function TeamComponent:GetEntrustTeamData(entrustId)
    local dojo = self:GetEntrustQueueData(entrustId)
    if not dojo then
        return nil
    end

    local t = dojo.cardsId
    if table.count(t) < self:GetMaxTeamMemberNum() then
        for i = table.count(t) + 1, self:GetMaxTeamMemberNum() do
            table.insert(t, {})
        end
    end
    return t
end

---GetEntrustQueueDataByQuestId  通过关卡id 获取一个委托队列数据 如果有则这个关卡在委托中
---@param questId integer @ 关卡id
---@return EntrustTeamDojo | nil
function TeamComponent:GetEntrustQueueDataByQuestId(questId)
    if not questId then return end

    for k, v in pairs(self.entrustQueues) do
        if checkNumber(v.questId) == checkNumber(questId) then
            return v
        end
    end
    return nil
end

---GetCardEntrustData  获取卡牌所在队列的信息， 没有为nil
---@param cardId integer @ 卡牌id
---@return EntrustTeamDojo | nil
function TeamComponent:GetCardEntrustData(cardId)
    if not cardId then return end

    if not self.entrustQueues then
        return nil
    end

    for k, v in pairs(self.entrustQueues) do
        local cardsId = v.cardsId
        if cardsId then
            --local t = CfUtils.Split(cardsId, ",")
            for m, n in pairs(cardsId) do
                if checkNumber(n.refId) == checkNumber(cardId) then
                    return v
                end
            end
        end
    end
    return nil
end

---IsCardEntrusting  卡牌是否在委托中
---@param cardId integer @ 卡牌id
---@return boolean
function TeamComponent:IsCardEntrusting(cardId)
    local dojo = self:GetCardEntrustData(cardId)
    if not dojo then
        return false
    end

    return self:IsEntrustQueuesBusy(dojo.id)
end

---GetAllEntrustTime  结算时候计算总共委托了多少场
---@param entrustId integer
---@return integer
function TeamComponent:GetAllEntrustTime(entrustId)
    local curEntrustTime = 0
    local entrustData = self:GetEntrustQueueData(checkNumber(entrustId))
    if not entrustData then
        return curEntrustTime
    end

    local storeComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.StoreComponent)
    local StoreConstants = import('Game.UI.Store.StoreConstants')
    local monthCardNum = 0
    if checkNumber(entrustData.isMonthCard) == 1 then
        --monthCardNum = checkNumber(storeComp:GetMonthCardPrivilege(StoreConstants.MonthCardPrivileges.AutoTimes))
        --由于月卡过期后无法取得月卡数据，跟策划商量确认后取月卡奖励表第一行的数据
        monthCardNum = CfUtils.GetWholeVo(AutoIds.IdSetting602, "MonthCardRewardVo")[1].privilege["autoTime"]
    end
    if monthCardNum == 0 then
        monthCardNum = 1
    end
    if checkNumber(entrustData.questId) ~= 0 then  
        local questData = QuestConfMgr:GetInstance():GetQuestVoById(entrustData.questId)
        if not questData then
            return curEntrustTime
        end

        if TimeZoneUtils.UtcSeconds >= checkNumber(entrustData.expirationTime) then
            curEntrustTime = entrustData.questSum
        else
            local time = checkNumber(entrustData.expirationTime) - TimeZoneUtils.UtcSeconds
            curEntrustTime = entrustData.questSum - (math.ceil(time / checkNumber(questData.time * monthCardNum)))
        end
    end 
    return curEntrustTime
end

---GetEntrustRemainTime  获取该委托的剩余时间
---@param entrustId integer
---@return integer
function TeamComponent:GetEntrustRemainTime(entrustId)
    --如果不在委托中
    if not self:IsEntrustQueuesBusy(entrustId) then
        return 0
    end
    local dojo = self:GetEntrustQueueData(entrustId)
    if not dojo then
        return 0 
    end

    return checkNumber(dojo.expirationTime) - TimeZoneUtils.UtcSeconds
end

---IsEntrustingEnd  队列是否结束了任务
---@param entrustId integer @ 队列id
---@return boolean
function TeamComponent:IsEntrustingEnd(entrustId)
    local dojo = self:GetEntrustQueueData(entrustId)
    if not dojo then
        return false
    end

    return self:GetEntrustRemainTime(entrustId) <= 0
end

---IsEntrustQueuesBusy  队列是否有任务在执行， 如果传id 判断当前id队列是否有任务， 如果不传判断所有队列
---@param id integer @ 队列id
---@return boolean
function TeamComponent:IsEntrustQueuesBusy(id)
    if not id then 
        for k, v in pairs(self.entrustQueues) do
            if self:IsEntrustQueuesBusy(v.id) then
                return true
            end
        end
    else
        local eq = self:GetEntrustQueueData(id)
        if eq and checkNumber(eq.questId) ~= 0 then
            return true        
        end
    end
    return false
end

--获取上一次选择的队列 ui用
---@return string
function TeamComponent:GetLastSelectEntrustQueue()
    local t = self._lastSelectQueueId
    self._lastSelectQueueId = nil
    return t
end

--设置上一次选择的队列 ui用
---@param id string
function TeamComponent:SetLastSelectEntrustQueue(id)
    self._lastSelectQueueId = checkString(id)
end

--是否有空闲队列
---@return boolean
function TeamComponent:IsHasFreeEntrustQueues()
    if not self.entrustQueues then
        return false
    end
    for k, v in pairs(self.entrustQueues) do
        if checkNumber(v.unlock) == 1 and not self:IsEntrustQueuesBusy(v.id) then
            return true
        end
    end
    return false
end

---RefeshEntrustRedPointNum  队列是否有奖励可领取
---@return integer
function TeamComponent:RefeshEntrustRedPointNum()
    if not self.entrustQueues then
        GameUtils.SetRedPointNum(Constants.RedPointConst.Entrust, 0)
        return -1
    end

    local _time
    for k, v in pairs(self.entrustQueues) do
        if self:IsEntrustQueuesBusy(v.id) then
            --有待领取的 直接亮
            if self:IsEntrustingEnd(v.id) then
                GameUtils.SetRedPointNum(Constants.RedPointConst.Entrust, 1)
                return 0
            else
                local activeTime = checkNumber((checkNumber(v.expirationTime) - TimeZoneUtils.UtcSeconds))
                activeTime = (activeTime > 0 and activeTime or 0)
                if _time and activeTime < _time then
                    _time = activeTime
                elseif not _time then
                    _time = activeTime
                end
            end
        end
    end
    if _time then
        local comp = self.entity:GetOrAddComp(ECSComponentType.Constants.RedPointMgrComponent)
        comp:UpdateRedPointData({
            unReceivedConsign = checkNumber(_time)
        })
    else
        GameUtils.SetRedPointNum(Constants.RedPointConst.Entrust, 0)
    end
    
    return checkNumber(_time)
end

--红点状态
---@return integer
function TeamComponent:GetRedPointStatus()
    local status = 3
    if not self.entrustQueues then
        return status
    end

    for k, v in pairs(self.entrustQueues) do
        if self:IsEntrustQueuesBusy(v.id) then
            --有待领取的
            if self:IsEntrustingEnd(v.id) then
                status = 2
                return status
            else
                status = 1
            end
        end
    end

    return status
end

--序列化服务器的格式
---@param cardTab table
---@param isNoSerialize boolean
---@return table[] | string
function TeamComponent:GetAllCardId(cardTab, isNoSerialize)
    if not cardTab then
        return nil
    end
    cardTab = checkTable(cardTab)

    local t = {}
    for k, v in pairs(cardTab) do
        if checkNumber(v.type) ~= Constants.TeamMemberType.QuestLockHelperCard then
            if checkNumber(v.refId) == 0 then
                table.insert(t, {})
            else
                table.insert(t, {
                    type = (checkNumber(v.type) == Constants.TeamMemberType.PlayerCard and Constants.TeamMemberType.PlayerCard or Constants.TeamMemberType.HelperCard),
                    refId = checkNumber(v.refId),
                    fettersId = checkNumber(v.fettersId),
                    fettersCardId = checkNumber(v.fettersCardId)
                })
            end
        end
    end

    if table.count(t) < self:GetMaxTeamMemberNum() then
        for i = table.count(t) + 1, self:GetMaxTeamMemberNum() do
            table.insert(t, {})
        end
    end

    --如果不需要序列化
    if isNoSerialize then
        return t
    end
    return table.serialize(t)
end

--序列化服务器的格式
---@param teamCatBallDojos TeamCatBallDojo[]
---@param isNoSerialize boolean
---@return table[] | string
function TeamComponent:GetAllCatId(teamCatBallDojos, isNoSerialize)
    if not teamCatBallDojos then
        return nil
    end

    local t = {}
    for index, teamCatBallDojo in ipairs(teamCatBallDojos) do
        local playerCatId = teamCatBallDojo.playerCatId
        if checkNumber(playerCatId) > 0 then
            table.insert(t, {
                catType = teamCatBallDojo.catType,
                playerCatId = playerCatId,
                catId = teamCatBallDojo.catId,
            })
        else
            table.insert(t, {})
        end
    end
    if isNoSerialize then
        return t
    end
    return table.serialize(t)

end

--后去当前队伍使用的协力值
---@param teamTab table
---@return integer
function TeamComponent:GetCurTeamXielizhi(teamTab)
    local count = 0
    if not teamTab then
        return count
    end
    for k, v in pairs(teamTab) do
        count = count + CardUtils.GetCardXielizhi(v.cardId)
    end
    return count
end

---@param teamTab table
---@return string
function TeamComponent:GetTeamStr(teamTab)
    local str = ""
    if not teamTab then
        return str
    end

    for i = 1, #teamTab do
        local data = teamTab[i]
        if data then
            if checkNumber(data.refId) > 0 then
                if str == "" then
                    str = str..checkString(data.refId)
                else
                    str = str..","..checkString(data.refId)
                end
            end
        end
    end
    return str
end

---SwapTeam
---交换团队
---@param questId integer      @ 关卡id
---@param curTeamIndex integer @ 当前团队下标
---@param swapIndex integer    @ 当前团队 要去 的下标
function TeamComponent:SwapTeam(questId, curTeamIndex, swapIndex)
    local curData  = self:GetTeamInfoByQuestId(questId, curTeamIndex)
    local swapData = self:GetTeamInfoByQuestId(questId, swapIndex)
    swapData.cardsInfo, curData.cardsInfo = curData.cardsInfo, swapData.cardsInfo
    swapData.catsInfo,  curData.catsInfo  = curData.catsInfo,  swapData.catsInfo
end

---PlayerOneKeyEditTeam
---根据关卡id 进行玩家一键编队
---@param levelId integer @ 关卡id
---@param teamNum integer @ 团队个数
---@param status Constants.ChooseCardStatus 选卡状态
function TeamComponent:PlayerOneKeyEditTeam(levelId, teamNum, status)
    ---@type CardComponent
    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    local cards         = cardComponent:GetAllCardTable()
    local t             = CardUtils.SortCardBySortType(cards, Constants.SortType.CombatPower, true)
    local cardCount     = #t
    teamNum             = teamNum or QuestConfMgr:GetInstance():GetQuestTeamNum(levelId)

    local cardIndex = 1   --选人的下标
    local memberNum = self:GetMaxSelectNum(levelId, status) --初始空位数量
    for i = 1, teamNum do
        local cardsInfo = {}
        if cardIndex <= cardCount then
            local count = 0
            for idx = cardIndex, cardCount do
                local cardData = t[idx]
                --添加到编队中
                table.insert(cardsInfo, CfUtils.GetTeamMemberDojo{
                    type = Constants.TeamMemberType.PlayerCard,
                    refId = cardData.id
                })
                count = count + 1
                cardIndex = cardIndex + 1
                if count >= memberNum then
                    break
                end
            end
            if count < memberNum then
                for j = count + 1, memberNum do
                    table.insert(cardsInfo, {})
                end
            end
        else
            for j = 1, memberNum do
                table.insert(cardsInfo, {})
            end
        end
        self:SetTeamByQuestId(levelId, cardsInfo, status, i)
    end
end

---PlayerResetAllTeam
---@param levelId integer @ 关卡id
---@param teamNum integer @ 团队个数
---@param status  Constants.ChooseCardStatus
function TeamComponent:ResetAllTeam(levelId, teamNum, status)
    teamNum             = teamNum or QuestConfMgr:GetInstance():GetQuestTeamNum(levelId)
    local memberNum = self:GetMaxSelectNum(levelId, status) --初始空位数量
    for i = 1, teamNum do
        self:ResetOneTeam(memberNum, levelId, status, i)
    end
end

---ResetOneTeam
---重置一个团队
---@param memberNum integer @ 团队个数
---@param levelId integer   @ 关卡id
---@param status Constants.ChooseCardStatus @ 选择卡牌状态
---@param teamIndex integer @ 团队下标
function TeamComponent:ResetOneTeam(memberNum, levelId, status, teamIndex)
    local cardsInfo = {}
    for j = 1, memberNum do
        table.insert(cardsInfo, {})
    end
    self:SetTeamByQuestId(levelId, cardsInfo, status, teamIndex)
end

---CheckTeamInfoIsHaveEmptyNode
---检查团队信息是否有空节点
---@param questId integer
---@param teamIndex integer
---@return boolean
function TeamComponent:CheckTeamInfoIsHaveEmptyNode(questId, teamIndex)
    local data = self:GetTeamInfoByQuestId(questId, teamIndex)
    local cardInfo = data.cardsInfo
    for i = 1, self:GetMaxTeamMemberNum() do
        ---@type TeamMemberDojo
        local teamMemberDojo = cardInfo[i]
        if checkNumber(teamMemberDojo.refId) <= 0 then
            return true
        end
    end
    return false
end

--获取卡牌在第几列队伍中
---@param questId integer
---@param cardId integer
---@return integer
function TeamComponent:GetTeamIndexById(questId, cardId)
    local t = self:GetTeamInfoByQuestId(questId)
    if not t then
        return 0
    end
    for k, v in pairs(t) do
        if v.cardsInfo then
            for _, data in pairs(v.cardsInfo) do
                if checkNumber(data.refId) == checkNumber(cardId) then
                    return k
                end
            end
        end
    end
    return 0
end

-- --合卡技请求
-- ---@param cb fun():void
-- function TeamComponent:PlayerMergeSkillReq(cb)
--     self._allUnlockMergeSkill = {}
--     GameUtils.Request(Interfaces.PlayerMergeSkill, {}, function(request, response)
--         if checkNumber(response.errCode) ~= 0 then
--             return
--         end
--         local jsonData = response.data
--         for k, v in pairs(jsonData.mergeSkillInfo) do
--             self._allUnlockMergeSkill[checkString(v)] = 1
--         end 

--         if cb then
--             cb()
--         end
--     end)
-- end

-- --是否解锁合卡技
-- ---@param skillId integer
-- ---@return integer
-- function TeamComponent:IsUnlockMergeSkillId(skillId)
--     return checkNumber(self._allUnlockMergeSkill[checkString(skillId)]) == 1
-- end

--- 判断关卡类型是否可以使用连续作战
---@param questType any
function TeamComponent:CanUseContinueFight(questId)
    local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
    if isNull(questVo) then
        return false
    end
    return checkNumber(questVo.showContinueBtn) == 1
end

--是否连续战斗
function TeamComponent:GetIsOpenContinue()
    return self._isOpenContinue
end

--设置是否开启了连续战斗
function TeamComponent:SetIsOpenContinueState(state)
    self._isOpenContinue = state
end

--当前连续战斗状态
function TeamComponent:GetCurContinueState()
    return self._curContinueState
end

--设置当前连续作战状态
function TeamComponent:SetCurContinueState(state)
    self._curContinueState = state
end

function TeamComponent:SetIsOpenContinue(isTrue, type, isUse, num)
    if checkBool(isTrue) then
        self._isOpenContinue = checkBool(isTrue)
        self._curContinueState = checkBool(isTrue)
        self._continueType = type
        self._continueNum = num
        self._curContinueNum = 0
        self._isAutoUseConsume = checkBool(isUse)
        self._exchangeItemCostNum = 0
        self._continueFightRewards = {}
        self._continueFightExtraRewards = {}
        self._hasFirstRewards = false
    else
        self:ResetContinueState()
    end

    CfUtils.WriteLocalData("BattleContinueIsTrue", checkBool(isTrue) and 1 or 0)
    CfUtils.WriteLocalData("BattleContinueType", checkInt(type))
    CfUtils.WriteLocalData("BattleContinueIsUse", checkBool(isUse) and 1 or 0)
    CfUtils.WriteLocalData("BattleContinueNum", checkInt(num))
end

function TeamComponent:ResetContinueState()
    self._isOpenContinue = false
    self._curContinueState = false
    self._continueType = 0
    self._continueNum = 0
    self._curContinueNum = 0
    self._isAutoUseConsume = false
    self._exchangeItemCostNum = 0
    self._continueFightRewards = {}
    self._continueFightExtraRewards = {}
    self._hasFirstRewards = false
end

--是否自动使用道具
function TeamComponent:GetIsAutoUseComsume()
    return self._isAutoUseConsume
end

--连续类型
function TeamComponent:GetContinueType()
    return self._continueType
end

--设置连续类型
function TeamComponent:SetContinueType(type)
    self._continueType = type
end

--连续次数
function TeamComponent:GetContinueNum()
    return self._continueNum
end

--当前连续次数
function TeamComponent:GetCurContinueNum()
    return self._curContinueNum
end

--增加连续作战次数
function TeamComponent:AddCurContinueNum(num)
    self._curContinueNum = self._curContinueNum + num
end

--设置连续作战次数
function TeamComponent:SetCurContinueNum(num)
    self._curContinueNum = num
end

--获取消耗了多少兑换道具
function TeamComponent:GetExchangeItemCostNum()
    return self._exchangeItemCostNum
end

--增加消耗的兑换道具
function TeamComponent:AddExchangeItemCostNum(num)
    self._exchangeItemCostNum = self._exchangeItemCostNum + num
end

--- 是否达到最大次数
function TeamComponent:IsReachMaxTimes()
    if self._continueType == Constants.ContinueBattleType.NoLimit then
        return false
    else
        return self._curContinueNum >= self._continueNum
    end
end

--- 添加连续作战的奖励
---@param rewards any
function TeamComponent:AddContinueFightRewards(rewards, extraRewards)
    if not (next(rewards) == nil) then
        table.insert(self._continueFightRewards, rewards)
    end
    if not (next(extraRewards) == nil) then
        table.insert(self._continueFightExtraRewards, extraRewards)
    end
end

--- 获取连续作战的奖励
function TeamComponent:GetContinueFightRewards()
    return self._continueFightRewards
end

--- 获取连续作战的固定奖励
function TeamComponent:GetContinueFightExtraRewards()
    return self._continueFightExtraRewards
end

--- 设置有无首通奖励
function TeamComponent:SetHasFirstRewards(state)
    self._hasFirstRewards = state
end

--- 获取是否有首通奖励
function TeamComponent:GetHasFirstRewards()
    return self._hasFirstRewards
end

---通过编队类型获取编队数据
---@param teamType Constants.TeamMemberNumType
---@param teamIndex integer 用法和GetTeamInfoByQuestId保持一致, 传值返回指定数据, 为空则返回全部
function TeamComponent:GetTeamInfoByTeamType(teamType, teamIndex)
    local t = nil
    local teamNum = Constants.TeamsUpLimit
    if teamType == Constants.TeamMemberNumType.FOUR then
        t = self._teamTab.fourPersonTeam
    elseif teamType == Constants.TeamMemberNumType.FIVE then
        t = self._teamTab.fivePersonTeam
    end
    --该模块没设置队伍
    if not t then
        --取单个队伍数据
        if teamIndex then
            return {
                cardsInfo = self:GetEmptyTeamByTeamType(teamType),
                catsInfo  = self:GetEmptyTeamCatByTeamType(teamType),
                name      = self:GetEmptyTeamName(teamIndex)
            }
        else
            t = {}
            for i = 1, teamNum do
                t[i] = {
                    cardsInfo = self:GetEmptyTeamByTeamType(teamType),
                    catsInfo  = self:GetEmptyTeamCatByTeamType(teamType),
                    name      = self:GetEmptyTeamName(i)
                }
            end
            return t
        end
    else
        if teamIndex then
            local data = t[checkNumber(teamIndex)]
            if not data then
                return {
                    cardsInfo = self:GetEmptyTeamByTeamType(teamType),
                    catsInfo  = self:GetEmptyTeamCatByTeamType(teamType),
                    name      = self:GetEmptyTeamName(teamIndex)
                }
            else
                return data
            end
        else
            for i = 1, teamNum do
                if not t[i] then
                    t[i] = {
                        cardsInfo = self:GetEmptyTeamByTeamType(teamType),
                        catsInfo  = self:GetEmptyTeamCatByTeamType(teamType),
                        name      = self:GetEmptyTeamName(i)
                    }
                end
            end
            return t
        end
    end

    --不会到这里
    return nil
end

---通过编队类型获取编队
---@param teamType Constants.TeamMemberNumType
function TeamComponent:GetTeamByTeamType(teamType, teamIndex)
    local t = self:GetTeamInfoByTeamType(teamType, teamIndex)
    return t.cardsInfo
end

---通过编队类型获取空队伍
---@param teamType Constants.TeamMemberNumType
function TeamComponent:GetEmptyTeamByTeamType(teamType)
    local t = {}
    for i = 1, teamType do
        local dojo = CfUtils.GetTeamMemberDojo()
        t[i] = dojo
    end
    return t
end

---通过编队类型获取空队伍猫
---@param teamType Constants.TeamMemberNumType
function TeamComponent:GetEmptyTeamCatByTeamType(teamType)
    local t = {}
    local GetTeamCatDojo = CfUtils.GetTeamCatDojo
    for i = 1, self:GetMaxTeamCatNum() do
        ---@type TeamCatBallDojo
        local dojo = GetTeamCatDojo()
        dojo:SetCatType(i)
        table.insert(t, dojo)
    end
    return t
end

---通过编队类型获取选中的编队序号
---@param teamType Constants.TeamMemberNumType
function TeamComponent:GetSelectedTeamIndexByTeamType(teamType)
    if teamType == Constants.TeamMemberNumType.FOUR then
        return self._teamTab.selectedFourPersonTeam
    elseif teamType == Constants.TeamMemberNumType.FIVE then
        return self._teamTab.selectedFivePersonTeam
    end
end

---通过编队类型设置选中的编队序号
---@param index integer
---@param teamType Constants.TeamMemberNumType
function TeamComponent:SetSelectedTeamIndexByTeamType(index, teamType)
    if teamType == Constants.TeamMemberNumType.FOUR then
        self._teamTab.selectedFourPersonTeam = checkInt(index or 1)
    elseif teamType == Constants.TeamMemberNumType.FIVE then
        self._teamTab.selectedFivePersonTeam = checkInt(index or 1)
    end
end

---根据编队类型获取选中的编队数据
---@param teamType Constants.TeamMemberNumType
function TeamComponent:GetSelectedTeamInfoByTeamType(teamType)
    return self:GetTeamInfoByTeamType(teamType, self:GetSelectedTeamIndexByTeamType(teamType))
end

---获取编队类型对应的猫
---@param teamType Constants.TeamMemberNumType
---@param teamIndex integer @ 队伍下标
---@return TeamCatBallDojo[]
function TeamComponent:GetTeamCatByTeamType(teamType, teamIndex)
    local ind = teamIndex and checkNumber(teamIndex) or self:GetSelectedTeamIndexByTeamType(teamType)

    local t = self:GetTeamInfoByTeamType(teamType)

    if not t then
        return self:GetEmptyTeamCatByTeamType(teamType)
    else
        t = t[ind]
        if t == nil or next(t) == nil then
            return self:GetEmptyTeamCatByTeamType(teamType)
        else
            t = t.catsInfo
            if t == nil or next(t) == nil then
                return self:GetEmptyTeamCatByTeamType(teamType)
            end
        end
    end

    --保证最大数量个数据
    if t then
        local num = self:GetMaxTeamCatNum()
        if #t < num then
            local GetTeamCatDojo = CfUtils.GetTeamCatDojo
            for i = #t + 1, num do
                ---@type TeamCatBallDojo
                local teamCatDojo = GetTeamCatDojo()
                teamCatDojo:SetCatType(i)
                table.insert(t, teamCatDojo)
            end
        end
    end
    return t
end

--判断该卡是否再对应队伍中
---@param teamType integer
---@param id integer
---@param teamIndex integer
---@return boolean
function TeamComponent:IsCardInTeamByTeamType(teamType, id, teamIndex)
    id = checkNumber(id)
    local t = self:GetTeamByTeamType(teamType, teamIndex)
    if not t then
        return false
    end

    --判断玩家手动选择的
    for k, v in pairs(t) do
        if id then
            if checkNumber(v) == checkNumber(id) then
                return true
            end
        end
    end
end

--设置快速编队时的缓冲队伍
---@param teamType integer @ 编队类型
---@param status string @ 委托/正常
---@param teamIndex integer @ 队伍下标
---@param entrustId integer @ 队列id
---@param cb fun():void
function TeamComponent:SetBufferTeamToTeamByTeamType(teamType, status, teamIndex, entrustId, cb)
    local t = self:GetBufferTeam()
    if not t then
        return
    end
    self:SetTeamByTeamType(teamType, t, status, teamIndex, entrustId, function()
        if cb then
            cb()
        end
    end)
end

--- 修改编队请求
---@param teamType integer @ 编队类型
---@param cardTab table @ 队伍表
---@param status string @ 委托/正常
---@param teamIndex integer @ 队伍下标
---@param entrustId integer @ 队列id
---@param cb fun():void
function TeamComponent:SetTeamByTeamType(teamType, cardTab, status, teamIndex, entrustId, cb)
    if not cardTab then
        return
    end
    status = checkNumber(status)
    --如果是委托
    if status == Constants.ChooseCardStatus.Entrust then
        self:ChangeEntrustTeamReq(entrustId, cardTab, function()
            UIModule.BackDialog()
        end)
    else
        cardTab = checkTable(cardTab)
        if table.count(cardTab) < teamType then
            GameUtils.Toast(localize("设置无效的队伍"))
            return
        end
    
        teamIndex = checkNumber(teamIndex)
        if teamIndex == 0 then
            teamIndex = self:GetSelectedTeamIndexByTeamType(teamType)
        end

        --直接覆盖
        local t = self:GetTeamInfoByTeamType(teamType)
        if t then
            if t[teamIndex] then
                t[teamIndex].cardsInfo = cardTab
            else
                t[teamIndex] = {
                    cardsInfo = cardTab
                }
            end
        else
            t = {
                [teamIndex] ={
                    cardsInfo = cardTab
                }
            }
            self:SetTeamInfoByTeamType(teamType, t)
        end

        Events.Broadcast(Constants.EventNames.RefeshTeamMember, nil)
        if cb then
            cb()
        end
    end
end

---SetTeamInfoByQuestId 设置关卡的队伍信息
---@param teamType integer @ 关卡id
function TeamComponent:SetTeamInfoByTeamType(teamType, teamInfo)
    local numType = teamType
    if numType == Constants.TeamMemberNumType.FOUR then
        self._teamTab.fourPersonTeam = clone(teamInfo)
    elseif numType == Constants.TeamMemberNumType.FIVE then
        self._teamTab.fivePersonTeam = clone(teamInfo)
    end
end

---是否使用老编队逻辑
function TeamComponent:IsUseOldTeams(questId)
    local questType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    if AnnihilationUtils.QuestTypeIsAnnihilation(questType) then   -- 歼灭战
        return true
    elseif questId == Constants.SpecialQuestId.LadderStruggleId then -- 大乱斗(异步PVP)
        return true
    elseif questId == Constants.SpecialQuestId.LadderStruggleSingleId then -- 大乱斗(异步PVP)
        return true
    elseif questId == Constants.SpecialQuestId.LadderId then -- 天梯竞技场
        return true
    elseif questId == Constants.SpecialQuestId.ClubGVGId then -- 社团GVG
        return true
    elseif questId == Constants.SpecialQuestId.FriendPVPId then -- 好友PVP
        return true
    elseif questType == Constants.IDType.QuestTower then -- 爬塔
        local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
        if not isNull(questVo) then
            if checkNumber(questVo.type) == 2 or 
            checkNumber(questVo.type) == 3 or
            checkNumber(questVo.type) == 4 then
                return true
            end
        end
    elseif questType == Constants.IDType.ClubBoss or 
        questType == Constants.IDType.QuestChaoticRecall or
        questType == Constants.IDType.QuestPatrolMaze or
        questType == Constants.IDType.Fairyland or
        questType == Constants.IDType.ActivityCrisis then
        return true
    end
    return false
end

---是否使用临时编队
function TeamComponent:IsUseTempTeam(questId)
    local questType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    if questType == Constants.IDType.QuestMain then
        -- 关卡中存在机器人或者限制卡牌的时候使用临时编队
        local isHasBattleHelper = QuestConfMgr:GetInstance():IsQuestHasHelper(questId)
        local isHasTeamLimit = QuestConfMgr:GetInstance():IsQuestHasTeamLimit(questId)
        if isHasBattleHelper or isHasTeamLimit then
            return true
        end
    elseif questType == Constants.IDType.QuestCardExperience then
        return true
    elseif questType == Constants.IDType.QuestMidFestivalStory then
        return false
    end
    
    return false
end

---转换老编队队伍下标
function TeamComponent:ConvertOldTeamsTeamIndex(questId, teamIndex)
    local questType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    if questType == Constants.IDType.QuestTower then -- 爬塔
        return 1
    elseif questType == Constants.IDType.ClubBoss or questType == Constants.IDType.Fairyland then
        return 1
    else
        return teamIndex
    end
end

---根据关卡id团队猫
---@param teamType integer
---@param catsInfo table 队伍猫信息
---@param teamIndex number 队伍下标
---@param cb fun():void 设置完成回调
function TeamComponent:SetTeamCatByTeamType(teamType, catsInfo, teamIndex, cb)
    if not catsInfo then
        return
    end

    catsInfo = checkTable(catsInfo)
    if #catsInfo < self:GetMaxTeamCatNum() then
        GameUtils.Toast(localize("设置无效的猫球"))
        return
    end
    teamIndex = teamIndex and checkNumber(teamIndex) or self:GetSelectedTeamIndexByTeamType(teamType)

    --直接覆盖
    local t = self:GetTeamInfoByTeamType(teamType) or {}
    t[teamIndex] = t[teamIndex] or {}
    t[teamIndex].catsInfo = catsInfo
    self:SetTeamInfoByTeamType(teamType, t)

    Events.Broadcast(Constants.EventNames.RefreshTeamCat)
    if cb then
        cb()
    end
end

---获取编队最大选中数量
---@param teamType integer
function TeamComponent:GetMaxSelectNumByTeamType(teamType)
    return teamType
end

---设置编队名称
---@param teamType integer
---@param name string
---@param teamIndex integer
function TeamComponent:SetTeamNameByTeamType(teamType, name, teamIndex)
    teamIndex = teamIndex and checkNumber(teamIndex) or self:GetSelectedTeamIndexByTeamType(teamType)
    local t = self:GetTeamInfoByTeamType(teamType) or {}
    t[teamIndex] = t[teamIndex] or {}
    t[teamIndex].name = name
    self:SetTeamInfoByTeamType(teamType, t)
end

---获取预设编队参数
function TeamComponent:GetPresetTeamParams(key)
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6061, "TeamPresetParamsVo", key) or {}
    return vo.num
end

---清除一下编队里的相同卡牌 因为只有2个编队 所以只要取
function TeamComponent:CleanSameCardAndCatInTeams()
    local teamInfo = self:GetTeamInfoBySystemId(Constants.SystemToggleIds.Id2019)
    if not isNull(teamInfo) then
        local cardsInfo = teamInfo[1].cardsInfo
        local nextInfo = teamInfo[2]
        if not isNull(cardsInfo) and not isNull(nextInfo) and not isNull(nextInfo.cardsInfo)then
            for k, v in pairs(cardsInfo) do
                local isSame,index = self:IsNextTeamHaveSameCards(v.cardId,nextInfo.cardsInfo)
                if isSame then
                    teamInfo[2].cardsInfo[index] = nil
                end
            end
        end
        local catInfo = teamInfo[1].catsInfo
        local nextInfo = teamInfo[2]
        if not isNull(catInfo) and not isNull(nextInfo) and not isNull(nextInfo.catsInfo)then
            for k, v in pairs(catInfo) do
                local isSame,index = self:IsNextTeamHaveSameCats(v.catId,nextInfo.catsInfo)
                if isSame then
                    teamInfo[2].catsInfo[index] = nil
                end
            end
        end
    end
end

function TeamComponent:IsNextTeamHaveSameCards(cardId,nextData)
    for i, v in pairs(nextData) do
        if not isNull(v) and v.cardId == cardId then
            return true,i
        end
    end
    return false
end

function TeamComponent:IsNextTeamHaveSameCats(catId,nextData)
    for i, v in pairs(nextData) do
        if not isNull(v) and v.catId == catId then
            return true,i
        end
    end
    return false
end

function TeamComponent:CleanTeamTabBySystemId(systemId)
    if self._teamTab.oldTeams[tostring(systemId)] then
        self._teamTab.oldTeams[tostring(systemId)] = {}
    end
end

return TeamComponent