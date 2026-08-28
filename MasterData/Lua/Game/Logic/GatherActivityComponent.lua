---
--- Created by Eric.
--- DateTime: 2022/6/11 14:01
---

------------ import ------------
local ECSComponent = import("Frame.ECS.ECSComponent")
local ChapterUtils = import('Game.Chapter.ChapterUtils')
local ParseUtils = CS.ParseUtils
local KTool = CS.Engine.Lib.KTool
local ACTIVITY_STATUS = {
    FINISH = -1 ,   --完成
    LOCK = 0  ,     --锁定
    NORMAL = 1      --正常开起
}

------------ import ------------

------------ define ------------

------------ define ------------


---@class GatherActivityComponent
local GatherActivityComponent = Class("GatherActivityComponent", ECSComponent)
function GatherActivityComponent:__init()
    self.isDrawReward = 0
    self.cardExperienceTips = -1  --小红点 0点亮 -1不点亮
    self.startTime = 0
    self.closeTime = 0
    self.endTime = 0
    self.activityNames = {}
    self.activityUuid = 0
    self.resource = ""
    self.consume = nil
    self.rewards = nil
    self.openType = {}
    self.openParameter = {}
    self.cardExperienceQuestId = nil
    self.handbookId = nil
    self.relatedActivity = nil
    self.moduleId = nil
    self.activityType = {}
    self.unlockStatus = {1,1,1,1,1}    --判断模块在配表中是否解锁
    self.id = 0
    self.name = "GatherActivityComponent"
end

function GatherActivityComponent:FillData(data)
    self.isDrawReward = checkInt(data.isDrawReward)
    self.cardExperienceTips = data.cardExperienceTips
    local curtime = os.time()
    -- 将倒计时转化为本地的时间戳
    if isSet(data, "starTime") then
        self.startTime = checkNumber(data.starTime) + curtime
    elseif isSet(data, "startTime") then
        self.startTime = checkNumber(data.startTime) + curtime
    end
    
    self.closeTime = data.closeTime + curtime
    self.endTime = data.endTime + curtime
    self.activityNames = data.name or ""
    self.resource = data.resource
    self.rewards =data.rewards
    self.openType =data.openType
    self.consume = data.consume
    self.openParameter = data.openParameter
    self.cardExperienceQuestId = data.cardExperienceQuestId
    self.handbookId = data.handbookId
    self.activityUuid = data.activityUuid
    self.moduleId = checkInt(data.moduleId)
    self.id = data.id
    self.relatedActivity = data.relatedActivity
    self.activityType = data.activityType
    self.unlockStatus = data.unlockStatus or self.unlockStatus
    self:ChangeOpenParameter()
    self:SetRewardsRedPointNum()
    self:GetFirstOpen()
end

function GatherActivityComponent:GetActivityName()
    local lang = CS.Engine.I18N.I18NModule.Lang
    local sLang = CfUtils.GetSLangByCLang(lang)  
    return self.activityNames[sLang] or "" 
end

function GatherActivityComponent:GetFirstOpen()
    local isOpen = CfUtils.GetLocalData("GatherFirstOpen_" .. self.activityUuid , "0" )
    if checkInt(isOpen) == 0  then
       GameUtils.SetRedPointNum(Constants.RedPointConst.GatherActivityFirstOpen ,1)
    end
end
function GatherActivityComponent:SetFirstOpen()
    CfUtils.WriteLocalData("GatherFirstOpen_" .. self.activityUuid , "1" )
end
--- 获取模块的解锁状态 ，用于控制跨区间集合页活动
function GatherActivityComponent:GetUnlockStatus()
    return self.unlockStatus
end
function GatherActivityComponent:ChangeOpenParameter()
    local index = 1
    for i, v in pairs(self.activityType) do
        if checkInt(v) > 0 then
            self.openParameter[i] = checkInt(self.relatedActivity[index])
            index = index+1
        end
    end
end

function GatherActivityComponent:GetLeftSecondTime()
    local leftSecondTime = self.closeTime - os.time()
    return leftSecondTime
end
function GatherActivityComponent:GetOpenType()
    return self.openType
end



function GatherActivityComponent:GetOpenParameters()
    return self.openParameter
end

--- 获取打开方式是否解锁
function GatherActivityComponent:GetOpenTypeUnlocks()
    local openType = self.openType
    local goodsConfMgr = GoodsConfMgr:GetInstance()
    local unLocks = {
        1,1,1,1,1
    }
    for i, moduleId in pairs(openType) do
        if checkInt(moduleId) < 12070100 then
            local row = goodsConfMgr:GetJumpModuleRow(moduleId)
            if not goodsConfMgr:CheckIsCanJump(row , false) then
                unLocks[i] = 0
            end
        end
    end
    return unLocks
end

function GatherActivityComponent:SetRewardsRedPointNum()
    if checkInt(self.isDrawReward ) == 1 then
        GameUtils.SetRedPointNum(Constants.RedPointConst.GatherActivityRewards , 0)
        GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.GatherActivityRewards )
    else
        local _ , isCan = self:isCanRewards()
        if isCan == true then
            GameUtils.SetRedPointNum(Constants.RedPointConst.GatherActivityRewards , 1)
            GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.GatherActivityRewards )
        else
            GameUtils.SetRedPointNum(Constants.RedPointConst.GatherActivityRewards , 0)
            GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.GatherActivityRewards)
        end
    end
end

--- 获取状态的node 名称
function GatherActivityComponent:GetUnlockStatusNodeName(index)
    local unlockStatus = self.unlockStatus
    local status = checkInt(unlockStatus[index])
    if status == ACTIVITY_STATUS.FINISH then
        return "Finish"
    elseif status == ACTIVITY_STATUS.NORMAL then
        return "Normal"
    elseif status == ACTIVITY_STATUS.LOCK then
        return "Lock"
    end
    return "Normal"
end


function GatherActivityComponent:isCanRewards()
    if  isNull(self.consume) or #self.consume == 0  then
        return false
    end
    local consume = self.consume
    local rewards, isCan = GoodsUtils.CheckGoodConsume(consume)
    isCan = isNull(isCan)
    return rewards , isCan
end

function GatherActivityComponent:__delete()
    self.isDrawReward = nil
    self.cardExperienceTips = nil  --小红点 0点亮 -1不点亮
    self.startTime = nil
    self.closeTime = nil
    self.endTime = nil
    self.activityNames = nil
    self.activityUuid = nil
    self.resource = nil
    self.consume = nil
    self.openType = nil
    self.openParameter = nil
    self.cardExperienceQuestId = nil
    self.handbookId = nil
    self.relatedActivity = nil
    self.activityType = nil
    self.rewards = nil
    self.moduleId = nil
    self.unlockStatus = nil
    self.id = 0
    self.name = "GatherActivityComponent"
end

return GatherActivityComponent