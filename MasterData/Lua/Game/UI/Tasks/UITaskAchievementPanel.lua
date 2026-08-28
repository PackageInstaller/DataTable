-------------------------------------------------------------------------------
-- 任务界面 - 成就面板
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-02-18 15:05:42
-------------------------------------------------------------------------------

---@type CriWareUtils
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
---@type GoodsConfMgr
local goodsConfMgr = GoodsConfMgr:GetInstance()
---@type TaskComponent
local taskComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TaskComponent)


--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaTasksDialog.prefab
---@class UITaskAchievementPanel
---@field Env                           	UITaskAchievementPanel                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field FontStyleButton               	UnityEngine.RectTransform               @ 一键领取按钮
---@field ListView                      	SuperScrollView.LoopListView2           @ 任务列表
---@field CanReceive                    	UnityEngine.RectTransform               @ 礼盒节点-领取提示
---@field Normal                        	UnityEngine.RectTransform               @ 礼盒节点-待领取
---@field ToBeContinued                 	UnityEngine.RectTransform               @ 礼盒节点-收集中
---@field GiftbagGroup                  	UnityEngine.RectTransform               @ 礼盒节点
---@field Text                          	UnityEngine.RectTransform               @ 顶部点数进度文本
---@field IconImg                       	UnityEngine.RectTransform               @ 顶部成就图标图片
---@field Icon                          	UnityEngine.RectTransform               @ 顶部成就图标节点
---@field Slider                        	UnityEngine.UI.Slider                   @ 顶部点数进度条
local UITaskAchievementPanel = Class('UITaskAchievementPanel')

-- 全部成就类型
local ALL_ACHIEVEMENT_TYPE = 0

local TaskCellNodeLuaPath = "Game.UI.Tasks.UITaskAchievementTaskCell"


function UITaskAchievementPanel:__init()
    ---@type integer | nil @ 领取奖励前的总积分，记录下来用于做过度动画
    self.oldAchievementPoint_ = nil

    ---@type fun():void
    self.redPointChangeCB_ = nil

    ---@type table<string, AchievementTaskVo>
    self.achievementTypeMap_ = {}

    ---@type AchievementTaskVo[]
    self.selectTypeDataList_ = {}

    ---@type table<string, boolean> @ 单元可领取的动画map（key：任务id，是否已经播过动画）
    self.cellCanDrawAnimMap_ = {}
end


function UITaskAchievementPanel:__delete()
    self.oldAchievementPoint_ = nil
    self.redPointChangeCB_    = nil
    self.achievementTypeMap_  = nil
    self.selectTypeDataList_  = nil
    self.cellCanDrawAnimMap_  = nil
end


function UITaskAchievementPanel:OnInit()
    ---@type AchievementTaskVo[]
    local allAchievementTaskVo = CfUtils.GetWholeVo(AutoIds.IdSetting255, "AchievementTaskVo")
    for _, achievementTaskVo in ipairs(allAchievementTaskVo) do
        -- add all type
        if not self.achievementTypeMap_[tostring(ALL_ACHIEVEMENT_TYPE)] then
            self.achievementTypeMap_[tostring(ALL_ACHIEVEMENT_TYPE)] = {}
        end
        table.insert(self.achievementTypeMap_[tostring(ALL_ACHIEVEMENT_TYPE)], achievementTaskVo)

        -- add target type
        local achievementType = checkInt(achievementTaskVo.reputationType)
        if achievementType > 0 then
            if not self.achievementTypeMap_[tostring(achievementType)] then
                self.achievementTypeMap_[tostring(achievementType)] = {}
            end
            table.insert(self.achievementTypeMap_[tostring(achievementType)], achievementTaskVo)
        end
    end
end


function UITaskAchievementPanel:Start()
    self:OnInit()

    -- update achievement icon
    local iconPath = goodsConfMgr:GetPhotoPathById(Constants.Currency.AchievementPoint)
    CfUtils.FillImage(self.IconImg, iconPath)

    -- binding giftBox click
    SetButtonAction(self.GiftbagGroup, Bind(self, self.OnClickGiftBoxHandler_))
    
    -- binding batchDraw click
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBatchDrawHandler_))
end


function UITaskAchievementPanel:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UITaskAchievementPanel:GetSelectType()
    return checkInt(self.selectType_)
end
function UITaskAchievementPanel:SetSelectType(type)
    self.selectType_ = checkInt(type)
    self:UpdateSelectType_()
end


---@return fun():void
function UITaskAchievementPanel:GetRedPointChangeCB()
    return self.redPointChangeCB_
end
function UITaskAchievementPanel:SetRedPointChangeCB(callback)
    self.redPointChangeCB_ = callback
end


-------------------------------------------------
-- public

function UITaskAchievementPanel:RefreshAll()
    self:UpdateGiftBoxUI_()
    CfUtils.PlayAnimator(self.CanReceive, "Idle")

    -- default all type
    self:SetSelectType(ALL_ACHIEVEMENT_TYPE)
    
    self:UpdateRedPoint()
end


function UITaskAchievementPanel:UpdateRedPoint()
    local isOpenRedPoint1 = false
    local isOpenRedPoint2 = false

    -- 检测 是否宝箱可领态
    local isGetAll     = checkInt(taskComponent.achievementBoxId) == 0
    local currentPoint = checkInt(taskComponent.achievementPoint)
    local targetPoint  = checkInt(taskComponent.achievementBoxPoint)
    if not isGetAll and currentPoint >= targetPoint then
        isOpenRedPoint1 = true
    end

    -- 检测 是否有未领取的任务
    if self:CheckTaskTypeHasReward_(ALL_ACHIEVEMENT_TYPE) then
        isOpenRedPoint2 = true
    end

    -- 更新成就红点值
    GameUtils.SetRedPointNum(Constants.RedPointConst.AchievementTask, isOpenRedPoint1 and 1 or 0)
    GameUtils.SetRedPointNum(Constants.RedPointConst.AchievementTaskBox, isOpenRedPoint2 and 1 or 0)

    -- do callback
    if self:GetRedPointChangeCB() then
        self:GetRedPointChangeCB()()
    end
end


-------------------------------------------------
--- private

function UITaskAchievementPanel:UpdateGiftBoxUI_()
    local isGetAll = checkInt(taskComponent.achievementBoxId) == 0
    CfUtils.SetActive(self.ToBeContinued, isGetAll)
    CfUtils.SetActive(self.CanReceive, not isGetAll)
    CfUtils.SetActive(self.Normal, not isGetAll)

    -- update progress text
    local currentPoint = checkInt(taskComponent.achievementPoint)
    local targetPoint  = checkInt(taskComponent.achievementBoxPoint)
    CfUtils.FillText(self.Text, string.format("<size=50><color=#ffffff>%s</color></size>/%s", currentPoint, targetPoint))

    -- update progress slider
    self.Slider.value = targetPoint > 0 and currentPoint / targetPoint or 0

    if not isGetAll then
        local isCanGet = currentPoint >= targetPoint
        CfUtils.SetActive(self.CanReceive, isCanGet)
        CfUtils.SetActive(self.Normal, not isCanGet)

        if isNull(self.oldAchievementPoint_) then
        else
            -- 领取奖励后的过度动画
            CfUtils.PlayAnimator(self.Icon, "Hit")
            CriWareUtils.PlaySe(UISheets.UI_Menu.path, UISheets.UI_Menu.ui_achievement_get)
        end

        -- 宝箱动画
        local curAnimInfo = CfUtils.GetAnimatorStateInfo(self.CanReceive)
        if not isNull(curAnimInfo) and not curAnimInfo:IsName("Change") then
            CfUtils.PlayAnimator(self.CanReceive, isCanGet and "Change" or "Idle")
        end
    end
end


function UITaskAchievementPanel:UpdateSelectType_()
    -- update selectTypeDataList
    self.selectTypeDataList_ = {}
    local selectTypeDataList = self.achievementTypeMap_[tostring(self:GetSelectType())] or {}
    ---@param achievementTaskVo AchievementTaskVo
    for _, achievementTaskVo in ipairs(selectTypeDataList) do
        local taskId   = checkInt(achievementTaskVo.taskAchId)
        local taskData = taskComponent:GetAchievementTaskData(taskId)
        if next(taskData) ~= nil then
            table.insert(self.selectTypeDataList_, achievementTaskVo)
        end
    end

    ---@param aAchievementTaskVo AchievementTaskVo
    ---@param bAchievementTaskVo AchievementTaskVo
    table.sort(self.selectTypeDataList_, function(aAchievementTaskVo, bAchievementTaskVo)
        local aTaskId     = checkInt(aAchievementTaskVo.taskAchId)
        local bTaskId     = checkInt(bAchievementTaskVo.taskAchId)
        local aIsDrawn    = taskComponent:IsDrawnAchievementTask(aTaskId)
        local bIsDrawn    = taskComponent:IsDrawnAchievementTask(bTaskId)
        local aTaskData   = taskComponent:GetAchievementTaskData(aTaskId)
        local bTaskData   = taskComponent:GetAchievementTaskData(bTaskId)
        local aTaskStatus = aIsDrawn and -1 or checkInt(aTaskData.status)
        local bTaskStatus = bIsDrawn and -1 or checkInt(bTaskData.status)
        if aTaskStatus ~= bTaskStatus then
            return aTaskStatus > bTaskStatus  -- 从高到低（1:可领取，0:进行中, -1:已完成）
        else
            -- 进行中的：按照进度排序
            if aTaskStatus == 0 and bTaskStatus == 0 then
                local aTargetNum   = checkInt(aAchievementTaskVo.taskContenNum)
                local bTargetNum   = checkInt(bAchievementTaskVo.taskContenNum)
                local aCurrentNum  = checkInt(aTaskData.progress)
                local bCurrentNum  = checkInt(bTaskData.progress)
                local aProgressNum = aCurrentNum / aTargetNum
                local bProgressNum = bCurrentNum / bTargetNum
                if aProgressNum ~= bProgressNum then
                    return aProgressNum > bProgressNum
                else
                    return aTaskId < bTaskId
                end
            else
                return aTaskId < bTaskId
            end
        end
    end)

    -- update taskList
    self:UpdateTaskList_()
end


function UITaskAchievementPanel:UpdateTaskList_()
    if not self.ListView.IsListViewInit then
        self.ListView:InitListView(#self.selectTypeDataList_, Bind(self, self.OnUpdateTaskListCellHandler_))
    else
        GameUtils.ReloadData(self.ListView, #self.selectTypeDataList_)
    end

    -- 一键领取按钮：有可领取的奖励时才显示
    CfUtils.SetActive(self.BtnQuickGet, self:CheckTaskTypeHasReward_())
end


--- 指定分类 是否 拥有未领取的奖励
---@param taskType integer
---@return boolean
function UITaskAchievementPanel:CheckTaskTypeHasReward_(taskType)
    local hasReward    = false
    local checkType    = taskType == nil and ALL_ACHIEVEMENT_TYPE or self:GetSelectType()
    local typeDataList = self.achievementTypeMap_[tostring(checkType)] or {}
    ---@param achievementTaskVo AchievementTaskVo
    for _, achievementTaskVo in ipairs(typeDataList) do
        local taskId   = checkInt(achievementTaskVo.taskAchId)
        local taskData = taskComponent:GetAchievementTaskData(taskId)
        if checkInt(taskData.status) == 1 then  -- 1：可领取
            hasReward = true
            break
        end
    end
    return hasReward
end


---@param responseData table
---@param drawTaskVo AchievementTaskVo
function UITaskAchievementPanel:doDrawTaskRewards_(responseData, drawTaskVo)
    local drawnIdList = {}
    local rewardsData = checkTable(responseData.rewards)
    
    if drawTaskVo then
        drawnIdList = { checkInt(drawTaskVo.taskAchId) }
    else
        local allDataList = self.achievementTypeMap_[tostring(ALL_ACHIEVEMENT_TYPE)] or {}
        ---@param achievementTaskVo AchievementTaskVo
        for _, achievementTaskVo in ipairs(allDataList) do
            local taskId   = checkInt(achievementTaskVo.taskAchId)
            local taskData = taskComponent:GetAchievementTaskData(taskId)
            if checkInt(taskData.status) == 1 then  -- 1：可领取
                table.insert(drawnIdList, taskId)
            end
        end
    end
    
    -- save oldAchievementPoint
    local oldPoint = checkInt(taskComponent.achievementPoint)
    local newPoint = checkInt(responseData.point)
    local addPoint = newPoint - oldPoint
    self.oldAchievementPoint_ = oldPoint
    
    -- draw rewards
    local rewardList = checkTable(rewardsData)
    table.insert(rewardList, {goodsId  = Constants.Currency.AchievementPoint, num = addPoint})
    GoodsUtils.DrawRewards(rewardList)

    -- 这边需要在关闭通用领取奖励后播放动画
    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList, cb = function()
        self:UpdateGiftBoxUI_()
    end})

    -- refresh cache data
    taskComponent.achievementPoint = newPoint
    for _, taskId in pairs(drawnIdList) do
        taskComponent:SetDrawnAchievementTask(taskId)
    end
end


-------------------------------------------------
-- handler

function UITaskAchievementPanel:OnClickGiftBoxHandler_()
    local isGetAll     = checkInt(taskComponent.achievementBoxId) == 0
    local currentPoint = checkInt(taskComponent.achievementPoint)
    local targetPoint  = checkInt(taskComponent.achievementBoxPoint)
    if isGetAll then
        GameUtils.Toast(localize('新的宝箱即将送到，敬请期待'))
        return
    end

    -- 是否可领取
    if currentPoint >= targetPoint then
        GameUtils.Request(Interfaces.AchievementBoxDraw, {id = taskComponent.achievementBoxId}, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)

                -- update cache data
                taskComponent.achievementBoxId    = checkInt(responseData.boxId)
                taskComponent.achievementBoxPoint = checkInt(responseData.boxPoint)
                self:UpdateGiftBoxUI_()

                --- update rewards
                local rewardList = checkTable(responseData.rewards)
                GoodsUtils.DrawRewards(rewardList)
                CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})
                
                -- update red point
                self:UpdateRedPoint()
            end
        end)

    else
        -- 显示预览
        local rewardBoxData = taskComponent:GetRewardBoxData(taskComponent.achievementBoxId)
        GameUtils.ShowCommonTipsBoardRewardPreview(self.GiftbagGroup, rewardBoxData.rewards, localize('奖励预览:'), false)
    end
end


function UITaskAchievementPanel:OnClickBatchDrawHandler_()
    if not self:CheckTaskTypeHasReward_() then
        GameUtils.Toast(localize('没有可领取的奖励'))
        return
    end

    GameUtils.Request(Interfaces.AchievementDraw, {}, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            
            -- draw task rewards
            self:doDrawTaskRewards_(responseData)

            -- refresh all task
            taskComponent:SyncAchievementTaskData(function()
                
                -- refresh all cell
                self:UpdateSelectType_()

                -- update red point
                self:UpdateRedPoint()
            end)
        end
    end)
end


function UITaskAchievementPanel:OnUpdateTaskListCellHandler_(listView, listIndex)
    if listIndex < 0 then return end
    local cell = listView:NewListViewItem("AchievementTasksCell")
    ---@type UITaskAchievementTaskCell
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, TaskCellNodeLuaPath)
    if not isNull(nodeEnv) then
        local luaIndex = listIndex + 1
        ---@type AchievementTaskVo
        local taskVo   = checkTable(self.selectTypeDataList_[luaIndex])
        local taskId   = checkInt(taskVo.taskAchId)
        local cellData = {
            taskId   = taskId,
            taskVo   = taskVo,
            taskData = taskComponent:GetAchievementTaskData(taskId),
            isDrawn  = taskComponent:IsDrawnAchievementTask(taskId),
        }

        -- init cell
        nodeEnv:SetLuaIndex(luaIndex)
        nodeEnv:SetCellData(cellData, function()
            -- enter anime
            ---@type AchievementTaskVo
            local taskData  = checkTable(cellData.taskData)
            local isDrawn   = taskComponent:IsDrawnAchievementTask(taskId)
            local isCanDraw = not isDrawn and checkInt(taskData.status) == 1
            if isCanDraw then 
                if not self.cellCanDrawAnimMap_[tostring(taskId)] then
                    nodeEnv:PlayCompleteAnim()
                    self.cellCanDrawAnimMap_[tostring(taskId)] = true
                else
                    nodeEnv:ResetCompleteAnim()
                end
            end
        end)
        nodeEnv:SetClickCB(Bind(self, self.OnClickTaskListCellCallback_))
    end
    return cell
end


function UITaskAchievementPanel:OnClickTaskListCellCallback_(luaIndex)
    local taskVo    = checkTable(self.selectTypeDataList_[luaIndex])
    local taskId    = checkInt(taskVo.taskAchId)
    local taskData  = taskComponent:GetAchievementTaskData(taskId)
    local isDrawn   = taskComponent:IsDrawnAchievementTask(taskId)
    local isCanDraw = not isDrawn and checkInt(taskData.status) == 1
    if isCanDraw then
        GameUtils.Request(Interfaces.AchievementDraw, {id = taskId}, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)

                -- append new task
                for _, taskDataDojo in ipairs(responseData.task or {}) do
                    taskComponent:AppendAchievementTaskData(taskDataDojo)
                end

                -- draw task rewards
                self:doDrawTaskRewards_(responseData, taskVo)

                -- refresh all cell
                self:UpdateSelectType_()

                -- update red point
                self:UpdateRedPoint()
            end
        end)
    end
end


return UITaskAchievementPanel
