--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityCrisisContract120015/ActivityCrisisContractLevelListDialog.prefab > name: ActivityCrisisContractLevelListDialog
---@class ActivityCrisisContractLevelListDialog
---@field Env                           	ActivityCrisisContractLevelListDialog   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ImgArrowLine2                 	Game.Native.Common.UISwitchImage        	@ 0    
---@field ImgArrowLine4                 	Game.Native.Common.UISwitchImage        	@ 1    
---@field ImgArrowLine1                 	Game.Native.Common.UISwitchImage        	@ 2    
---@field ImgArrowLine3                 	Game.Native.Common.UISwitchImage        	@ 3    
---@field ImgArrowLine5                 	Game.Native.Common.UISwitchImage        	@ 4    
---@field BtnEntry                      	UnityEngine.RectTransform               	@ 5    
---@field EntryList                     	UnityEngine.RectTransform               	@ 6    
---@field EntryLoopView                 	SuperScrollView.LoopListView2           	@ 7    
---@field RewardLoopView                	SuperScrollView.LoopListView2           	@ 8    
---@field FontStyleButton1              	UnityEngine.RectTransform               	@ 9    
---@field Integral                      	UnityEngine.RectTransform               	@ 10   
---@field BtnMonster                    	UnityEngine.RectTransform               	@ 11   
---@field BtnTask                       	UnityEngine.RectTransform               	@ 12   
---@field TxtTask                       	UnityEngine.RectTransform               	@ 13   
---@field TxtNum                        	UnityEngine.RectTransform               	@ 14   
---@field BtnRank                       	UnityEngine.RectTransform               	@ 15   
---@field CurLevel                      	UnityEngine.RectTransform               	@ 16   
---@field HistoryLevel                  	UnityEngine.RectTransform               	@ 17   
---@field BtnDel                        	UnityEngine.RectTransform               	@ 18   
---@field EmptyNode                     	UnityEngine.RectTransform               	@ 19   
local ActivityCrisisContractLevelListDialog = Class('ActivityCrisisContractLevelListDialog')
---@type ActivityCrisisUtils
local ActivityCrisisUtils = import('Game.Activity.CrisisContract.ActivityCrisisUtils')
local CellNodeLuaPath = "Game.Activity.CrisisContract.Cell.ActivityCrisisContractLevelListCell"
local EntryNodeLuaPath = "Game.Activity.CrisisContract.Cell.ActivityCrisisContractLevelListRewardNodeCell"
local UIModule = CS.Engine.UI.UIModule

function ActivityCrisisContractLevelListDialog:__init()
    self.eventHandler = Events.AddListener(Constants.EventNames.ContractLevelClickEvent , Bind(self, self.CircleClick))
    self.refreshHandler = Events.AddListener(Constants.EventNames.CrisisLevelRefreshEvent , Bind(self, self.GoToNewQuestId))

    self.aniData = {}

    self.questId = nil
    self.questVos = {}
    self.questGroupIds = {

    }
    self.tagList = {}
    self.groupGroupCirLineStruct = {
        -- 线id 映射到词条id 
        selectCircleIdToTagId = {

        },
        -- 词条id 映射到原线id 
        tagIdToCircleId = {

        },
        -- 记录词条的前置id  
        tagLastIds = {

        },
        -- 记录词条的后置 
        tagNextIds = {

        },
        -- 记录 tagOrId 
        tagOr = {
            
        },
        -- 线坐标被哪些圆解锁
        circleIdToLine = {
            
        },
        -- 词条对应的分数 在 ActivityCrisisContractLevelListNode 中的 GenTagToTagSorce 生成
        tagToTagSorce = {

        },
        allSectCountNum = 0,
        isAllSelect = false
    }
    self.selectGroupCirLine = {
        tagClash = {},
        selectTagId =  nil ,
        selectGroupId = nil
    }
    self.isShowRank = false
end


function ActivityCrisisContractLevelListDialog:__delete()
    if isNotNull(self.eventHandler) then
        Events.RemoveListener(Constants.EventNames.ContractLevelClickEvent , self.eventHandler)
        self.eventHandler = nil 
    end

    if isNotNull(self.refreshHandler) then
        Events.RemoveListener(Constants.EventNames.CrisisLevelRefreshEvent , self.refreshHandler)
        self.refreshHandler = nil
    end

    self.aniData = nil
    self.questVos = nil
    self.questGroupIds  = nil
    self.selectGroupCirLine = nil 
    self.groupGroupCirLineStruct = nil
    self.selectData = nil
end
---@return table<string, CrisisEventEntryPosVo[]> 
function ActivityCrisisContractLevelListDialog:GetQuestVos(questId)
    local CrisisEventEntryPosVos = ActivityCrisisUtils.GetWholeCrisisEventEntryPosVos()
    local questId = checkInt(questId) 
    local questVos = {}
    local questGroupIds = {}
    local isStart = false
    for k, v in ipairs(CrisisEventEntryPosVos) do
        if checkInt(v.questId) == questId then
            isStart = true
            local groupId = tostring(v.groupId)
            if isNull(questVos[groupId]) then
                questVos[groupId] = {}
                questGroupIds[#questGroupIds+1] = groupId
            end
            questVos[groupId][#questVos[groupId]+1] = v
        else 
            if isStart then
                break
            end    
        end
    end
    return questVos , questGroupIds
end

function ActivityCrisisContractLevelListDialog:Awake()
    SetButtonAction(self.FontStyleButton1 , Bind(self, self.EnterBattle))
    SetButtonAction(self.BtnMonster , Bind(self, self.OnBtnMonsterClick))
    SetButtonAction(self.BtnTask , Bind(self, self.OnBtnTaskClick))
    SetButtonAction(self.BtnRank , Bind(self, self.OnBtnRankClick))
    SetButtonAction(self.BtnDel,Bind(self,self.OnBtnDelAllClick))
end


function ActivityCrisisContractLevelListDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        local questId = initParams.questId
        local preQuest = true 
        if isSet(initParams,"preQuest") then
            if initParams.preQuest == false then
                preQuest = false
                initParams.preQuest = true
            end
        end
        print("preQuest" , preQuest)
        if isSet(initParams,"isRank") then
            self.isShowRank = initParams.isRank
        end
        CfUtils.SetActive(self.BtnRank.gameObject,self.isShowRank)
        self.questId = questId
        self.questVos , self.questGroupIds = self:GetQuestVos(questId)
        self.cloneCellUIData = {
            ImgArrowLine1 = self.ImgArrowLine1 , 
            ImgArrowLine2 = self.ImgArrowLine2 , 
            ImgArrowLine3 = self.ImgArrowLine3 , 
            ImgArrowLine4 = self.ImgArrowLine4 , 
            ImgArrowLine5 = self.ImgArrowLine5 , 
            EntryList = self.EntryList , 
            BtnEntry = self.BtnEntry ,
        }
        if preQuest then
            local ActivityCrisisUtils = import('Game.Activity.CrisisContract.ActivityCrisisUtils')
            local preQuestData = ActivityCrisisUtils.GetActivityCrisisMgr():GetPreQuestData()
            if checkInt(preQuestData.questId) == checkInt(questId)  then
                self.selectGroupCirLine = preQuestData.selectGroupCirLine
                self.selectData = preQuestData.selectData
            end
        end
        self:InitRightShow()
    end)
end

function ActivityCrisisContractLevelListDialog:OnShow()
    return CoWaitDo(function()
        self:ReloadList()
        self:ReloadEntryList()
        printInfo('--enter this')
    end)
end
function ActivityCrisisContractLevelListDialog:ReloadList()
    if not self.EntryLoopView.IsListViewInit then
        self.EntryLoopView:InitListView(#self.questGroupIds, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.EntryLoopView, #self.questGroupIds)
    end
end


function ActivityCrisisContractLevelListDialog:OnGetItemByIndex(listView, listIndex)
    if listIndex < 0 then return end
    local cell = listView:NewListViewItem("Cell")
    ---@type ActivityCrisisContractLevelListCell
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, CellNodeLuaPath)
    if nodeEnv then
        listIndex = listIndex + 1
        local groupId = tostring(self.questGroupIds[listIndex]) 
        local questgroupVos = self.questVos[groupId]
        print("groupId ==>" ,groupId)
        if isNull(self.selectGroupCirLine[groupId]) then
           local groupGroupCirLineStruct = clone(self.groupGroupCirLineStruct)
            self.selectGroupCirLine[groupId] = groupGroupCirLineStruct
            groupGroupCirLineStruct.tagIdToCircleId , groupGroupCirLineStruct.tagOr ,groupGroupCirLineStruct.circleIdToLine , groupGroupCirLineStruct.allSectCountNum = self:GenGroupGroupCirLineStruct(questgroupVos)
        end
        nodeEnv:RefreshData(listIndex , questgroupVos , self.cloneCellUIData ,self.selectGroupCirLine)
    end
    return cell
end

function ActivityCrisisContractLevelListDialog:OnTipsAction()
    local activityData = ActivityCrisisUtils.GetActivityCrisisMgr():GetActivityData()
    ---@type ActivityCrisisUtils
    local vo = ActivityCrisisUtils.GetActivityVo(activityData.activityContentId)
    if isNotNull(vo) and isNotNull(vo.ruleID)then
        CfUtils.ShowModuleToast(vo.ruleID)
    end
end

function ActivityCrisisContractLevelListDialog:ReloadEntryList(tagId)
    self.aniData = {}
    if isNotNull(self.selectData) and table.count(self.selectData) > 0 then
        for i, v in pairs(self.selectData) do
            self.aniData[tostring(v.circleId)] = true
        end
    end

    self.selectData = {}
    local isIn = false
    local addScore = 0
    for k, v in pairs(self.selectGroupCirLine) do
        if type(v) == "table" and v.selectCircleIdToTagId then
            local selectCircleIdToTagId = v.selectCircleIdToTagId
            if v.selectCircleIdToTagId then
                local tempData = {}
                if v.isAllSelect then
                    local vo = ActivityCrisisUtils.GetCrisisEventEntryGatherVo(k)
                    addScore = addScore + vo.extraScore
                end
                if isNotNull(selectCircleIdToTagId)  and table.count(selectCircleIdToTagId) > 0 then
                    for i, j in pairs(selectCircleIdToTagId) do
                        table.insert(tempData,j)
                    end
                    table.sort(tempData,function(a,b) return a < b  end)

                    for i, j in ipairs(tempData) do
                        local vo = ActivityCrisisUtils.GetCrisisEventEntryVo(j)
                        if isNotNull(vo) then
                            addScore = addScore + vo.tagScore
                            local isPlayAni = true
                            if self.aniData[tostring(j)] then
                                isPlayAni = false
                            end

                            table.insert(self.selectData,{circleId = j, isShowTitle = (i == 1), vo = vo ,isPlayAni = isPlayAni})

                            if not isNull(self.entryId) and checkNumber(j) == checkNumber(self.entryId) then
                                isIn = true
                            end
                        end
                    end
                end
            end
        end
    end

    if not isIn then
        self.entryId = nil
        self.entryIndex = nil
    end

    table.sort(self.selectData,function(a,b) return a.circleId < b.circleId  end)

    if checkNumber(tagId) > 0 then
        for i, v in pairs(self.selectData) do
            if v.circleId == tagId then
                self.entryIndex = i
                self.entryId = tagId
                break
            end
        end
    end

    local count = #self.selectData
    if count > 0 then
        CfUtils.SetActive(self.RewardLoopView.gameObject,true)
        if not self.RewardLoopView.IsListViewInit then
            self.RewardLoopView:InitListView(count, Bind(self, self.OnGetEntryItemByIndex))
        else
            GameUtils.ReloadData(self.RewardLoopView, count)
        end
    end
    self:RefreshScoreShow(addScore)
end

function ActivityCrisisContractLevelListDialog:GoToNewQuestId(questId , isRank)
    self.questId = questId
    self.questVos  = {}
    self.questGroupIds = {}
    self.isShowRank = isRank
    self.selectGroupCirLine = {
        tagClash = {},
        selectTagId =  nil ,
        selectGroupId = nil
    }
    self.controller.Argument.parameters.questId = questId
    self.controller.Argument.parameters.isRank = isRank
    self.questVos , self.questGroupIds = self:GetQuestVos(questId)
    self:InitRightShow()
    self:ReloadEntryList()
    self:ReloadList()
    CfUtils.SetActive(self.BtnRank.gameObject,self.isShowRank)
end

function ActivityCrisisContractLevelListDialog:OnGetEntryItemByIndex(listView, listIndex)
    if listIndex < 0 then return end
    local cell = listView:NewListViewItem("ActivityCrisisContractLevelListRewardNode")
    ---@type ActivityCrisisContractLevelListCell
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, EntryNodeLuaPath)
    if nodeEnv then
        listIndex = listIndex + 1
        local data = self.selectData[listIndex]
        nodeEnv:SetCallBackAndIndex(Bind(self,self.OnRightCellClick),listIndex)
        nodeEnv:RefreshData(data)
        if not isNull(self.entryId) and self.entryId == data.circleId then
            nodeEnv:OnSelect()
        else
            nodeEnv:DoSelect()
        end
        nodeEnv:PlayAni(data.isPlayAni)
    end
    return cell
end



function ActivityCrisisContractLevelListDialog:CircleClick(param)
    local eventName = param.event 
    local circleId = tostring(param.circleId) 
    local tagId = tostring(param.tagId) 
    local groupId = param.groupId
    local tagOr = checkInt(param.tagOr) 
    local tagClash = checkInt(param.tagClash) 
    if eventName == "cancel" then
        self:CancelCircId(circleId ,groupId , tagId ,tagClash )
        self:ReloadEntryList()
    elseif eventName == "select" then
        self:SelectCirceId(circleId , groupId , tagId , tagOr)     
    elseif eventName == "selectAll" then
        self:SelectAllCircle(groupId)
        self.selectData = {}
        self:ReloadEntryList()
    elseif eventName == "resetSelectAll" then
        self:ResetSelectAllCircle(groupId)      
        self:ReloadEntryList()    
    elseif eventName == "actived" then
        self:ReloadEntryList(tagId)
        self:CircleActived(circleId ,groupId , tagId)
    elseif eventName == "fightUI" then
        self:ReloadEntryList(tagId)
        self:CircleActived(circleId , groupId , tagId )   
        GameUtils.Toast(localize("词条冲突"))
    end
    
    -- if eventName == "select" then
    --     self:CircleActived(circleId ,groupId , tagId)
    -- end
end
--- func desc 设置冲突词条
-- function ActivityCrisisContractLevelListDialog:SetFight(circleId ,groupId , tagId)
--     groupId = tostring(groupId)
--     local oneSelectGroupCirLine = self.selectGroupCirLine[groupId]  
--     local index = 1
--     for k, v in pairs(self.questGroupIds) do
--         if tostring(v) == groupId then
--             index = k 
--             break
--         end
--     end
--     local selectCircleIdToTagId = oneSelectGroupCirLine.selectCircleIdToTagId
--     local cell = self.EntryLoopView:GetShownItemByItemIndex(index -1)
--     if isNotNull(cell)  then
--         local questGroupVos = self.questVos[tostring(groupId)]
--         ---@type ActivityCrisisContractLevelListCell
--         local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
--         scr:RefreshOneCircleIdFight(circleId,questGroupVos,self.selectGroupCirLine)
--     end
-- end

function ActivityCrisisContractLevelListDialog:CircleActived(circleId , groupId ,tagId)
    local preSlectGrounpId = checkInt(self.selectGroupCirLine.selectGroupId)
    if preSlectGrounpId > 0 then
        local index = 1 
        for k, v in pairs(self.questGroupIds) do
            if checkInt(v) == preSlectGrounpId  then
                index = k 
                break
            end
        end 
        local oneSelectGroupCirLine  = self.selectGroupCirLine[tostring(preSlectGrounpId)] 
        local preCircleId = oneSelectGroupCirLine.tagIdToCircleId[tostring(self.selectGroupCirLine.selectTagId)]
        local cell = self.EntryLoopView:GetShownItemByItemIndex(index -1)
        if isNotNull(cell)  then
            local questgroupVos = self.questVos[tostring(preSlectGrounpId)]
            ---@type ActivityCrisisContractLevelListCell
            local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
            scr:RefreshOneCircleIdSelectActive(preCircleId ,questgroupVos,self.selectGroupCirLine , false)
        end     
    end
    groupId = tostring(groupId)
    local index = 1
    for k, v in pairs(self.questGroupIds) do
        if tostring(v) == groupId then
            index = k 
            break
        end
    end
    self.selectGroupCirLine.selectGroupId = groupId
    self.selectGroupCirLine.selectTagId = tagId
    local cell = self.EntryLoopView:GetShownItemByItemIndex(index -1)
    if isNotNull(cell)  then
        local questGroupVos = self.questVos[tostring(groupId)]
        ---@type ActivityCrisisContractLevelListCell
        local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
        scr:RefreshOneCircleIdSelectActive(circleId,questGroupVos,self.selectGroupCirLine , true)
    end
    self:ReloadList()
    self:MoveRightPanelByIndex(tagId)
end
function ActivityCrisisContractLevelListDialog:ResetSelectAllCircle(groupId)
    local oneSelectGroupCirLine = self.selectGroupCirLine[groupId]
    local selectCircleIdToTagId = clone(oneSelectGroupCirLine.selectCircleIdToTagId)
    local keys =  table.keys(selectCircleIdToTagId)
    for k, v in pairs(keys) do
        oneSelectGroupCirLine.selectCircleIdToTagId[v] = nil
    end
    local index = 1
    for k, v in pairs(self.questGroupIds) do
        if tostring(v) == groupId then
            index = k 
            break
        end
    end
    local cell = self.EntryLoopView:GetShownItemByItemIndex(index -1)
    if isNotNull(cell)  then
        local questgroupVos = self.questVos[groupId]
        ---@type ActivityCrisisContractLevelListCell
        local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
        scr:RefreshCircleIdsCancel(selectCircleIdToTagId ,questgroupVos,self.selectGroupCirLine)
        scr:UpdateAllNoActiveLines()
    end
     --  全选后处理冲突词条
     local tagClash = self.selectGroupCirLine.tagClash
     for oneTagClashId , tagInfos in pairs(tagClash) do
         for circleId , tagInfo in pairs(tagInfos) do
             if selectCircleIdToTagId[tostring(circleId)] then
                 for k, tagInfo in pairs(tagInfos) do
                     if checkInt(circleId) ~= checkInt(tagInfo.circleId)  then
                         local tagClashIndex = 1
                         local groupId = tostring(tagInfo.groupId) 
                         for kk, vv in pairs(self.questGroupIds) do
                             if tostring(vv) == groupId then
                                 tagClashIndex = kk
                                 break
                             end
                         end
                         local cell = self.EntryLoopView:GetShownItemByItemIndex(tagClashIndex -1)
                         if isNotNull(cell) then
                             local questGroupVos = self.questVos[tostring(groupId)]
                             ---@type ActivityCrisisContractLevelListCell
                             local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
                             scr:RefreshCircleIdsCancel({  [tostring(tagInfo.circleId)] =  tagInfo.circleId},questGroupVos,self.selectGroupCirLine , false) 
                         end    
                     end
                 end
                 break
             end
         end
    end  
end

function ActivityCrisisContractLevelListDialog:SelectCirceId(CircleId , groupId , tagId ,tagOr)
    groupId = tostring(groupId)
    local oneSelectGroupCirLine = self.selectGroupCirLine[groupId]
    local activeLins = {}
    local circleIdToLines = oneSelectGroupCirLine.circleIdToLine
    local circleIdToLine =  circleIdToLines[tostring(CircleId)] or {}
    -- 插入选中词条
  
    local index = 1
    for k, v in pairs(self.questGroupIds) do
        if tostring(v) == groupId then
            index = k 
            break
        end
    end
    ---@type CrisisEventEntryVo
    local CrisisEventEntryVo = CfUtils.GetCfVo(AutoIds.IdSetting6416 , "CrisisEventEntryVo" ,tagId)
    if checkInt(CrisisEventEntryVo.tagClash) > 0 then
        local tagClashTagId = checkInt(CrisisEventEntryVo.tagClash) 
        if tagClashTagId > 0 then
            local tagClashTagIds =  self.selectGroupCirLine.tagClash[tostring(tagClashTagId)]
            if isNotNull(tagClashTagIds) then
                for k, v in pairs(tagClashTagIds) do
                    if checkInt(v.circleId) ~= checkInt(CircleId)  then
                        local oneSelectGroupCirLine = self.selectGroupCirLine[tostring(v.groupId)]
                        if oneSelectGroupCirLine then
                            local oneSelectCircleIdToTagId = oneSelectGroupCirLine.selectCircleIdToTagId
                            if oneSelectCircleIdToTagId and oneSelectCircleIdToTagId[tostring(v.circleId)] then
                                self:CircleActived(v.circleId , v.groupId , v.tagId)
                                GameUtils.Toast(localize("词条冲突"))
                                return
                            else 
                                -- 词条冲突 存在冲突 没有选中操作
                                if v.circleId then
                                    local tagClashIndex = 1
                                    local groupId = tostring(v.groupId) 
                                    for kk, vv in pairs(self.questGroupIds) do
                                        if tostring(vv) == groupId then
                                            tagClashIndex = kk
                                            break
                                        end
                                    end
                                    local cell = self.EntryLoopView:GetShownItemByItemIndex(tagClashIndex -1)
                                    if isNotNull(cell) then
                                        local questGroupVos = self.questVos[tostring(groupId)]
                                        ---@type ActivityCrisisContractLevelListCell
                                        local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
                                        scr:RefreshOneCircleIdFight(v.circleId,questGroupVos,self.selectGroupCirLine)
                                    end    
                                end  
                            end
                        end
                    end
                end
                
            end 
        end
    end
    oneSelectGroupCirLine.selectCircleIdToTagId[tostring(CircleId)] = tagId
    for lineId, lineId2 in pairs(circleIdToLine) do
        activeLins[lineId] = lineId2
    end
    local selectCircleIdToTagId = oneSelectGroupCirLine.selectCircleIdToTagId
    local cell = self.EntryLoopView:GetShownItemByItemIndex(index -1)
    if isNotNull(cell)  then
        local questGroupVos = self.questVos[tostring(groupId)]
        ---@type ActivityCrisisContractLevelListCell
        local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
        scr:RefreshOneCircleIdSelect(CircleId,questGroupVos,self.selectGroupCirLine)
        scr:UpdateActiveLines(activeLins)
        if checkInt(tagOr) > 0 then
            local oneTagOrs =  oneSelectGroupCirLine.tagOr 
            local tagOrs = oneTagOrs[tostring(tagOr)]
            local oneCircleId = tostring(CircleId)
            if tagOrs then
                for k, v in pairs(tagOrs) do
                    v = tostring(v)
                    if v ~= oneCircleId then
                        if selectCircleIdToTagId[v]  then
                            selectCircleIdToTagId[v] = nil
                            scr:RefreshCircleIdsCancel({[tostring(v)] = tostring(k)},questGroupVos,self.selectGroupCirLine)
                        end 
                    end
                end
            end
        end
    end



    self:ReloadEntryList(tagId)
    self:CircleActived(CircleId , groupId, tagId)
end
---@param CircleId string 原点id
---@param groupId  string 组的ID
---@descr  取消某个圆 
function ActivityCrisisContractLevelListDialog:CancelCircId(CircleId , groupId , tagId , tagClash)
    groupId = tostring(groupId)
    local index = 1
    for k, v in pairs(self.questGroupIds) do
        if tostring(v) == groupId then
            index = k 
            break
        end
    end 
    if checkInt(self.selectGroupCirLine.selectTagId) == checkInt(tagId) then
        self.selectGroupCirLine.selectTagId = nil
        self.selectGroupCirLine.selectGroupId = nil
    end
    local oneSelectGroupCirLine = self.selectGroupCirLine[groupId]
    local tagNextIds = oneSelectGroupCirLine.tagNextIds[tagId] 
    local excludeCirecleIds = {[tostring(CircleId)] = CircleId}
    self:GetNoActiveCircleId(excludeCirecleIds ,tagNextIds ,groupId)
    -- 之前激活的线
    local preLineIds = self:GetActiveLineCicle(groupId)
    for k, v in pairs(excludeCirecleIds) do
        oneSelectGroupCirLine.selectCircleIdToTagId[tostring(k)] = nil
    end
    -- 当前激活的线
    local currentLines = self:GetActiveLineCicle(groupId)
    -- 从激活的线变为激活的线
    local activeToNoActives = {} 
    for k, v in pairs(preLineIds) do
        if isNull(activeToNoActives[tostring(k)]) then
            activeToNoActives[k] = k 
        end
    end
    local cell = self.EntryLoopView:GetShownItemByItemIndex(index -1)
    if isNotNull(cell)  then
        local questgroupVos = self.questVos[groupId]
        ---@type ActivityCrisisContractLevelListCell
        local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
        scr:RefreshCircleIdsCancel(excludeCirecleIds ,questgroupVos,self.selectGroupCirLine)
        scr:UpdateNoActiveLines(activeToNoActives)
    end
    local tagClashs ={}
    for tagClashId, tagInfos in pairs(self.selectGroupCirLine.tagClash) do
        for tagId, tagInfo in pairs(tagInfos) do
            if excludeCirecleIds[tostring(tagInfo.circleId)] then
                tagClashs[#tagClashs+1] = tagInfos
                break
            end
        end
    end
    for index , tagInfos in pairs(tagClashs) do
        for k, tagInfo in pairs(tagInfos) do
            if checkInt(tagInfo.circleId) ~= checkInt(CircleId)then
                local circleId = tagInfo.circleId 
                if circleId then
                    local tagClashIndex = 1
                    local groupId = tostring(tagInfo.groupId) 
                    for kk, vv in pairs(self.questGroupIds) do
                        if tostring(vv) == groupId then
                            tagClashIndex = kk
                            break
                        end
                    end
                    local cell = self.EntryLoopView:GetShownItemByItemIndex(tagClashIndex -1)
                    if isNotNull(cell) then
                        local questGroupVos = self.questVos[tostring(groupId)]
                        ---@type ActivityCrisisContractLevelListCell
                        local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
                        scr:RefreshCircleIdsCancel({ [tostring(circleId)] = circleId },questGroupVos,self.selectGroupCirLine)
                    end    
                end  
            end
        end
    end
end

function ActivityCrisisContractLevelListDialog:GetNoActiveCircleId(excludeCirecleIds , tagNextIds ,groupId )
    if isNull(tagNextIds) or table.count(tagNextIds) == 0 then
        return
    end
    local oneSelectGroupCirLine = self.selectGroupCirLine[groupId]
    local tagIdToCircleId = oneSelectGroupCirLine.tagIdToCircleId
    local selectCircleIdToTagId = oneSelectGroupCirLine.selectCircleIdToTagId
    local tagLastIds = oneSelectGroupCirLine.tagLastIds
    for kk, vv in pairs(tagNextIds) do
        local tagId = tostring(vv)
        -- 判断当前对象是否排除
        local circleId = tagIdToCircleId[tagId]
        local tagId = selectCircleIdToTagId[tostring(circleId)]
        if isNotNull(tagId) then
            -- 获取到前置id 
            local lastTags = tagLastIds[tostring(tagId)]
            if isNotNull(lastTags) then
                -- 在前置id 中找寻是否有激活的, 如果前置id 没有被激活 那么这个对象就没有被激活
                local isHave = false
                for tagId , tagId in pairs(lastTags) do
                    local lsatCircleId = tagIdToCircleId[tostring(tagId)] 
                    local tagId = selectCircleIdToTagId[tostring(lsatCircleId)] 
                    if isNotNull(tagId) and (not excludeCirecleIds[tostring(lsatCircleId)]) then
                        isHave = true
                        break
                    end
                end
                if not isHave then
                    excludeCirecleIds[tostring(circleId)] = circleId
                    local tagNextIds = oneSelectGroupCirLine.tagNextIds[tostring(tagId)]
                    self:GetNoActiveCircleId(excludeCirecleIds , tagNextIds ,groupId)    
                end
            end
        end
    end
end


--- func desc 获取到激活的线圈
---@param groupId string 群组id
function ActivityCrisisContractLevelListDialog:GetActiveLineCicle(groupId)
    groupId = tostring(groupId)
    local oneSelectGroupCirLine = self.selectGroupCirLine[groupId]
    local circleIdToLines = oneSelectGroupCirLine.circleIdToLine
    local selectCircleIdToTagId = oneSelectGroupCirLine.selectCircleIdToTagId
    local activeLins = {}
    for k, v in pairs(selectCircleIdToTagId) do
        local circleIdToLine =  circleIdToLines[tostring(k)] or {}
        for lineId, lineId2 in pairs(circleIdToLine) do
            activeLins[tostring(lineId)] = tostring(lineId2) 
        end
    end
    return activeLins
end

function ActivityCrisisContractLevelListDialog:EnterBattle()
    local isHaveTag =  false
    local buffData = {}
    for k, v in pairs(self.selectGroupCirLine) do
        if type(v) == "table" and v.selectCircleIdToTagId then
            local selectCircleIdToTagId = v.selectCircleIdToTagId
            if isNotNull(selectCircleIdToTagId)  and table.count(selectCircleIdToTagId) > 0 then
                local array =  table.values(selectCircleIdToTagId)
                if table.count(array) > 0 then
                    isHaveTag = true
                    buffData[tostring(k)] = array
                end
            end
        end
    end
    if not isHaveTag then
        GameUtils.Toast(localize("请至少选择一个节点"))
        return
    end
    ActivityCrisisUtils.EnterBattleTeam(self.questId,buffData)
end

function ActivityCrisisContractLevelListDialog:InsertCircles(tagIds)
    table.insertto(self.tagList , tagIds)
end
--- func desc
---@param tagIds table 删除圆
function ActivityCrisisContractLevelListDialog:RemoveCircles(tagIds)
    for i = #self.tagList , 1 , -1 do 
        local tagData = self.tagList[i]
        local tagId = tagData.tagId 
        if tagIds[tostring(tagId)]  then
            table.remove(self.tagList , i)
        end
    end 
end

--- func desc 全选所有群组的圆坐标
---@param groupId number 群组id
function ActivityCrisisContractLevelListDialog:SelectAllCircle(groupId)
    ---@type CrisisEventEntryPosVo[]
    local questgroupVos = self.questVos[tostring(groupId)]
    local oneSelectGroupCirLine = self.selectGroupCirLine[tostring(groupId)]
    local tagIdToCircleId = oneSelectGroupCirLine.tagIdToCircleId
    local selectCircleIdToTagId = oneSelectGroupCirLine.selectCircleIdToTagId
    local isSelectAll = true 
    local allSelectTags = {}
    local score = 0
    for k, v in pairs(questgroupVos) do
        if checkInt(v.siteType) == 1  then
            if checkInt(v.tagOr) == 0 then
                ---@type CrisisEventEntryVo
                local CrisisEventEntryVo = CfUtils.GetCfVo(AutoIds.IdSetting6416 , "CrisisEventEntryVo" ,v.tagId)
                -- 检测任务是否解锁
                if checkInt(CrisisEventEntryVo.unlockTask) > 0 then
                    local isPass = ActivityCrisisUtils.IsFinishCrisisQuest(self.questId,CrisisEventEntryVo.unlockTask)
                    if not isPass then
                        isSelectAll = false
                        GameUtils.Toast(localize("任务未完成，不能全选"))
                        break
                    end
                end
                -- 检测是否有冲突词条
                if checkInt(CrisisEventEntryVo.tagClash) > 0 then
                    local tagClashTagId = checkInt(CrisisEventEntryVo.tagClash)
                    if tagClashTagId > 0 then
                        local tagClashTagIds = self.selectGroupCirLine.tagClash[tostring(tagClashTagId)]
                        for kk, tagInfo in pairs(tagClashTagIds) do
                            if  checkInt(tagInfo.circleId) ~= checkInt(v.id) then
                                local oneSelectGroupCirLine = self.selectGroupCirLine[tostring(tagInfo.groupId)]
                                if oneSelectGroupCirLine and oneSelectGroupCirLine.selectCircleIdToTagId[tostring(tagInfo.circleId)] then
                                    isSelectAll = false 
                                    break
                                elseif oneSelectGroupCirLine and allSelectTags[tostring(tagInfo.circleId)] then
                                    isSelectAll = false 
                                    break
                                end
                            end
                        end
                    end
                    if not isSelectAll then
                        GameUtils.Toast(localize("词条冲突"))
                        break
                    end
                end
                score = score + checkInt(CrisisEventEntryVo.tagScore)
                allSelectTags[tostring(v.id)] = v.tagId
            end 
        end
    end
    if not isSelectAll then
        return
    end
    for k, oneTags in pairs(oneSelectGroupCirLine.tagOr) do
        local isSelectOne = false
        local maxTagId = 0 
        local maxScore = 0
        local maxCircleId = 0
        local isNotSelectType = 1
        for tagId , circleId in pairs(oneTags) do
            ---@type CrisisEventEntryVo
            local CrisisEventEntryVo = CfUtils.GetCfVo(AutoIds.IdSetting6416 , "CrisisEventEntryVo" ,tagId)
            local isPass = true 
            if checkInt(CrisisEventEntryVo.unlockTask) > 0 then
                local isPass = ActivityCrisisUtils.IsFinishCrisisQuest(self.questId,CrisisEventEntryVo.unlockTask)
                if not isPass then
                    isNotSelectType = 1
                    isPass = false
                end
            end
            local isTagClash = false
            if isPass then
                if checkInt(CrisisEventEntryVo.tagClash) > 0 then
                    local tagClashTagId = checkInt(CrisisEventEntryVo.tagClash)
                    local tagClashTagIds = self.selectGroupCirLine.tagClash[tostring(CrisisEventEntryVo.tagClash)]
                    for k, tagInfo in pairs(tagClashTagIds) do
                        if checkInt(tagInfo.tagId) ~= checkInt(tagId)  then
                            local oneSelectGroupCirLine = self.selectGroupCirLine[tostring(tagInfo.groupId)]
                            if oneSelectGroupCirLine and oneSelectGroupCirLine.selectCircleIdToTagId[tostring(tagInfo.circleId)] then
                                isNotSelectType = 2
                                isTagClash = true 
                                break
                            elseif oneSelectGroupCirLine and allSelectTags[tostring(tagInfo.circleId)] then
                                isNotSelectType = 2
                                isTagClash = true 
                                break
                            end
                        end
                    end
                end
            end
            if (not isTagClash) and isPass then
                isSelectOne = true 
                local tagScore = checkInt(CrisisEventEntryVo.tagScore) 
                -- 如果or 关系有选中的直接选中
                if selectCircleIdToTagId[tostring(circleId)] then
                    maxTagId = tagId
                    maxScore = tagScore
                    maxCircleId = circleId
                    break
                end
                if tagScore > maxScore then
                    maxTagId = tagId
                    maxScore = tagScore
                    maxCircleId = circleId
                end
            end
        end
        if not isSelectOne then
            if isNotSelectType == 1 then
                GameUtils.Toast(localize("任务未完成，不能全选"))
                break
            end
            if isNotSelectType == 2 then
                GameUtils.Toast(localize("词条冲突"))
                break
            end
            isSelectAll = false 
            break
         else 
            allSelectTags[tostring(maxCircleId)] = maxTagId
            score = score + maxScore    
         end
    end
    if not isSelectAll then
        return
    end
    table.merge(selectCircleIdToTagId , allSelectTags)
    local index = 1
    for k, v in pairs(self.questGroupIds) do
        if tostring(v) == groupId then
            index = k 
            break
        end
    end
    local cell = self.EntryLoopView:GetShownItemByItemIndex(index -1)
    if isNotNull(cell)  then
        local questgroupVos = self.questVos[groupId]
        ---@type ActivityCrisisContractLevelListCell
        local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
        local activeLines = self:GetActiveLineCicle( groupId)
        scr:UpdateLines(activeLines)
        scr:RefreshAllCircleIdSelect(questgroupVos , self.selectGroupCirLine)
    end
    --  全选后处理冲突词条
    local tagClash = self.selectGroupCirLine.tagClash
    for oneTagClashId , tagInfos in pairs(tagClash) do
        for circleId , tagInfo in pairs(tagInfos) do
            if selectCircleIdToTagId[tostring(circleId)] then
                for k, tagInfo in pairs(tagInfos) do
                    if circleId ~= k then
                        local tagClashIndex = 1
                        local groupId = tostring(tagInfo.groupId) 
                        for kk, vv in pairs(self.questGroupIds) do
                            if tostring(vv) == groupId then
                                tagClashIndex = kk
                                break
                            end
                        end
                        local cell = self.EntryLoopView:GetShownItemByItemIndex(tagClashIndex -1)
                        if isNotNull(cell) then
                            local questGroupVos = self.questVos[tostring(groupId)]
                            ---@type ActivityCrisisContractLevelListCell
                            local scr = CfUtils.GetLuaScr(cell, CellNodeLuaPath)
                            scr:RefreshOneCircleIdFight(tagInfo.circleId,questGroupVos,self.selectGroupCirLine)
                        end    
                    end
                end 
                break 
            end
        end
    end
end

---@param questgroupVos CrisisEventEntryPosVo[]
function ActivityCrisisContractLevelListDialog:GenGroupGroupCirLineStruct(questgroupVos)
    local tagIdToCircleId = {}
    local tagOr = {}
    local circleIdToLine = {}
    local allSelectCount = 0
    for k, v in pairs(questgroupVos) do
        local Id = tostring(v.id) 
        if v.siteType == 1 then
            tagIdToCircleId[tostring(v.tagId)] = Id
            if checkInt(v.tagOr) > 0 then
                if isNull(tagOr[v.tagOr]) then
                    tagOr[v.tagOr] = {}
                end
                local oneTag = tagOr[v.tagOr]
                oneTag[v.tagId] = v.id 
            else 
                allSelectCount = allSelectCount + 1    
            end
        elseif v.siteType == 2 then
            for kk, vv in pairs(v.lightTag) do
                if isNull(circleIdToLine[vv]) then
                    circleIdToLine[vv] = {}
                end
                circleIdToLine[vv][tostring(v.id) ] = tostring(v.id) 
            end   
        end
    end
    allSelectCount = allSelectCount + table.count(tagOr)
    return tagIdToCircleId , tagOr , circleIdToLine , allSelectCount
end

function ActivityCrisisContractLevelListDialog:OnFinalize()
    return CoWaitDo(function()
        local ActivityCrisisUtils = import('Game.Activity.CrisisContract.ActivityCrisisUtils')
        ActivityCrisisUtils.GetActivityCrisisMgr():SetPreQuestData(self.questId , self.selectGroupCirLine ,self.selectData)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end

function ActivityCrisisContractLevelListDialog:OnBtnMonsterClick()
    UIModule.OpenDialog({ id = Constants.UITypeIds.UIBossDetailDialog, parameters = { levelId = self.questId } })
end

function ActivityCrisisContractLevelListDialog:OnBtnTaskClick()
    UIModule.OpenDialog({ id = Constants.UITypeIds.ActivityCrisisContractTaskDialog,parameters = { questId = self.questId }},{{ id = Constants.UITypeIds.ActivityCrisisContractLevelListDialog}})
end

function ActivityCrisisContractLevelListDialog:OnBtnRankClick()
    UIModule.OpenDialog({ id = Constants.UITypeIds.ActivityCrisisContractRankDialog})
end

function ActivityCrisisContractLevelListDialog:OnRightCellClick(entryId, groupId, index)
    local lastIndex = self.entryIndex
    if not isNull(lastIndex) and lastIndex ~= index then
        local oldEntry = self.RewardLoopView:GetShownItemByItemIndex(self.entryIndex - 1)
        if not isNull(oldEntry) then
            local nodeEnv = CfUtils.GetLuaScr(oldEntry,EntryNodeLuaPath)
            if isNotNull(nodeEnv) then
                nodeEnv:DoSelect()
            end
        end
    end

    self.entryIndex = index
    self.entryId = entryId
    local entry = self.RewardLoopView:GetShownItemByItemIndex(self.entryIndex - 1)
    if not isNull(entry) then
        local nodeEnv = CfUtils.GetLuaScr(entry,EntryNodeLuaPath)
        if isNotNull(nodeEnv) then
            nodeEnv:OnSelect()
        end
    end

    local groupId = checkNumber(groupId)
    local index = 0
    for i, v in pairs(self.questGroupIds) do
        if checkNumber(v) == groupId then
            index = i - 1
            break
        end
    end
    self.selectGroupCirLine.selectGroupId = groupId
    self.selectGroupCirLine.selectTagId = entryId
    self.EntryLoopView:MovePanelToItemIndex(index)
end

function ActivityCrisisContractLevelListDialog:MoveRightPanelByIndex(entryId)
    self.RewardLoopView:MovePanelToItemIndex(self.entryIndex - 1)

--[[    if not isNull(self.entryIndex) then
        if self.entryIndex == index then
            self.RewardLoopView:MovePanelToItemIndex(index - 1)
        else
            local oldEntry = self.RewardLoopView:GetShownItemByItemIndex(self.entryIndex - 1)
            if not isNull(oldEntry) then
                local nodeEnv = CfUtils.GetLuaScr(oldEntry,EntryNodeLuaPath)
                if isNotNull(nodeEnv) then
                    nodeEnv:DoSelect()
                end
            end
            self.entryIndex = index
            self.entryId = entryId

            local nowEntry = self.RewardLoopView:GetShownItemByItemIndex(self.entryIndex - 1)
            if isNotNull(nowEntry) then
                local nodeEnv = CfUtils.GetLuaScr(nowEntry,EntryNodeLuaPath)
                if isNotNull(nodeEnv) then
                    nodeEnv:OnSelect()
                end
            else
                self.RewardLoopView:MovePanelToItemIndex(index - 1)
            end
        end
    else
        self.entryId = entryId
        self.entryIndex = index
        self.RewardLoopView:MovePanelToItemIndex(index - 1)
    end]]
end

function ActivityCrisisContractLevelListDialog:InitRightShow()
    CfUtils.SetActive(self.EmptyNode.gameObject,true)
    CfUtils.SetActive(self.RewardLoopView.gameObject,false)
    CfUtils.FillText(self.CurLevel,0)

    local historyScore = ActivityCrisisUtils.GetHistoryScore(self.questId)
    CfUtils.FillText(self.HistoryLevel,localize("历史最高 _num_",{_num_ = historyScore}))

    local taskRemainTime = ActivityCrisisUtils.GetTaskLimitTimeByQuestId(self.questId)
    CfUtils.SetActive(self.ImgCutTime.gameObject,taskRemainTime > 0)
    if taskRemainTime > 0 then
        CfUtils.FillText(self.TxtTime,CfUtils.GetTimeHMS10(taskRemainTime))
    end

    self.entryId = nil
    self.entryIndex = nil
end

function ActivityCrisisContractLevelListDialog:RefreshScoreShow(addScore)
    if table.count(self.selectData) > 0 then
        CfUtils.SetActive(self.EmptyNode.gameObject,false)
        CfUtils.FillText(self.CurLevel,addScore)
    else
        CfUtils.SetActive(self.EmptyNode.gameObject,true)
        CfUtils.SetActive(self.RewardLoopView.gameObject,false)
        CfUtils.FillText(self.CurLevel,0)
    end
end

function ActivityCrisisContractLevelListDialog:OnBtnDelAllClick()
    for k, v in pairs(self.selectGroupCirLine) do
        if type(v) == "table" and v.selectCircleIdToTagId then
            v.selectCircleIdToTagId = {}    
        end
    end
    self.selectData = {}
    self:ReloadList()
    self:InitRightShow()
end


return ActivityCrisisContractLevelListDialog
