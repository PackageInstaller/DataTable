--- from: Assets/BundleResources/Prefabs/ActivityCrisisContract120015/ActivityCrisisContractLevelListDialog.prefab > name: Cell
---@class ActivityCrisisContractLevelListCell
---@field Env                           	ActivityCrisisContractLevelListCell     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Entry                         	UnityEngine.UI.LayoutElement            	@ 0    
---@field Switch                        	UnityEngine.RectTransform               	@ 1    
---@field On                            	UnityEngine.RectTransform               	@ 2    
---@field OFF                           	UnityEngine.RectTransform               	@ 3    
---@field TxtNum                        	UnityEngine.RectTransform               	@ 4    
---@field TxtTile                       	UnityEngine.RectTransform               	@ 5    
---@field TxtTask                       	UnityEngine.RectTransform               	@ 6    
---@field IntegralTxtTile               	UnityEngine.RectTransform               	@ 7    
---@field IntegralTxtNum                	UnityEngine.RectTransform               	@ 8    
---@field Integral                      	UnityEngine.RectTransform               	@ 9    
---@field Container                     	UnityEngine.RectTransform               	@ 10   
local ActivityCrisisContractLevelListCell = Class('ActivityCrisisContractLevelListCell')
---@type ActivityCrisisUtils
local ActivityCrisisUtils = import('Game.Activity.CrisisContract.ActivityCrisisUtils')
local KTool = CS.Engine.Lib.KTool
function ActivityCrisisContractLevelListCell:__init()
    self.lineGameOjects = {}
    self.circleGameObject = {}
end


function ActivityCrisisContractLevelListCell:__delete()
end


function ActivityCrisisContractLevelListCell:Awake()
    
end

function ActivityCrisisContractLevelListCell:Start()
end
---@param questGroupVos CrisisEventEntryPosVo[]
function ActivityCrisisContractLevelListCell:RefreshData(index , questGroupVos , cellUIData ,selectGroupCirLine)
    self.circleGameObject = {}
    self.lineGameOjects = {}
    SetButtonAction(self.Switch , function ()
        self:SelectAllClick(questGroupVos ,selectGroupCirLine )
    end)
    local high = ActivityCrisisUtils.GetMaxHigh(questGroupVos)
    local bh = (600 - high)/2 
    self.Entry.minHeight = 600
    KTool.DestroyGameObjectChildren(self.Container.gameObject)
    for k, v in pairs(questGroupVos) do
        if checkInt(v.siteType)  == 1 then
            local pos =  ActivityCrisisUtils.GetCirePosition(v.tagLoc)
            ---@type UnityEngine.GameObject
            local BtnEntry = KTool.Instantiate(self.Container.gameObject,cellUIData.BtnEntry.gameObject) 
            BtnEntry.transform:SetLocalX(pos.x)
            BtnEntry.transform:SetLocalY(pos.y+bh)
            KTool.SetActive(BtnEntry.gameObject , true)
            ---@type Engine.Modules.LuaBehaviour 
            local LuaBehaviour =  KTool.GetComponent(BtnEntry,typeof(CS.Engine.Modules.LuaBehaviour))
            LuaBehaviour.Env:RefreshNode(v, selectGroupCirLine)
            self.circleGameObject[tostring(v.id)] = LuaBehaviour.Env
        elseif checkInt(v.siteType) == 2 then
            local ImgArrowLine =  cellUIData["ImgArrowLine".. v.lineType]
            if isNotNull(ImgArrowLine) then
                ---@type UnityEngine.GameObject
                local oneImgArrowLine = KTool.Instantiate(self.Container.gameObject,ImgArrowLine.gameObject) 
                KTool.SetActive(oneImgArrowLine , true)
                local lineStruct = ActivityCrisisUtils.GetLineStructure(v.startLoc ,v.endLoc)
                if lineStruct.isSprite9 then
                    ---@type UnityEngine.RectTransform
                    local transform = KTool.GetComponent(oneImgArrowLine , typeof(CS.UnityEngine.RectTransform))
                    if lineStruct.high > 0 then
                        transform.sizeDelta = Vector2(transform.sizeDelta.x ,lineStruct.high )
                    else 
                        transform.sizeDelta = Vector2(lineStruct.width ,transform.sizeDelta.y)
                    end
                end
                oneImgArrowLine.transform:SetLocalX(lineStruct.x)
                oneImgArrowLine.transform:SetLocalY(lineStruct.y+bh)
                self.lineGameOjects[tostring(v.id)] = oneImgArrowLine
            end
        end
    end
    local tagsOrs = self:GetOrCirLinePosMap(questGroupVos)
    for k, v in pairs(tagsOrs) do
        local posStruct = ActivityCrisisUtils.GetOrCircleLineStruct(v)
        ---@type UnityEngine.GameObject
        local EntryList = KTool.Instantiate(self.Container.gameObject,cellUIData.EntryList.gameObject) 
        EntryList.transform:SetLocalX(posStruct.x)
        EntryList.transform:SetLocalY(posStruct.y+bh)
        KTool.SetActive(EntryList.gameObject , true)
        ---@type UnityEngine.RectTransform
        local transform = KTool.GetComponent(EntryList , typeof(CS.UnityEngine.RectTransform))
        transform.sizeDelta = Vector2(transform.sizeDelta.x ,posStruct.high )
        transform:SetAsFirstSibling()
    end
    if #questGroupVos > 0 then
        local activeLines = {}
        local oneSelectGroupCirLine  = selectGroupCirLine[questGroupVos[1].groupId]
        local circleIdToLines = oneSelectGroupCirLine.circleIdToLine
        local selectCircleIdToTagId = oneSelectGroupCirLine.selectCircleIdToTagId
        for k, v in pairs(selectCircleIdToTagId) do
            local circleIdToLine =  circleIdToLines[tostring(k)] or {}
            for lineId, lineId2 in pairs(circleIdToLine) do
                activeLines[lineId] = lineId2
            end
        end
        self:UpdateLines(activeLines)
        local CrisisEventEntryGatherVo = CfUtils.GetCfVo(AutoIds.IdSetting6417 , "CrisisEventEntryGatherVo" , questGroupVos[1].groupId)
        if not isNull(CrisisEventEntryGatherVo) then
            CfUtils.FillText(self.TxtTile,CrisisEventEntryGatherVo.name)
        end
    end
    self:UpdateTagScore(questGroupVos ,selectGroupCirLine)


end 
---@param questGroupVos CrisisEventEntryPosVo[]
function ActivityCrisisContractLevelListCell:SelectAllClick(questGroupVos ,selectGroupCirLine )
    local groupId = tostring(questGroupVos[1].groupId)
    local oneSelectGroupCirLine = selectGroupCirLine[groupId]
    local questGroupVo = questGroupVos[1]
    if not oneSelectGroupCirLine.isAllSelect then
        
        if questGroupVo and checkInt(questGroupVo.groupId) > 0 then
            Events.Broadcast(Constants.EventNames.ContractLevelClickEvent,{circleId = questGroupVo.id ,groupId = questGroupVo.groupId , tagId = questGroupVo.tagId,event = "selectAll"})
        end
    else 
        if questGroupVo and checkInt(questGroupVo.groupId) > 0 then
            Events.Broadcast(Constants.EventNames.ContractLevelClickEvent,{circleId = questGroupVo.id ,groupId = questGroupVo.groupId , tagId = questGroupVo.tagId,event = "resetSelectAll"})
        end
    end
end

--- 更新所有线的状态
function ActivityCrisisContractLevelListCell:UpdateLines(activeLines)
    for k, v in pairs(self.lineGameOjects) do
        -- 当前激活的线
        if activeLines[tostring(k)] then
            CfUtils.SetUISwitchImage(v.gameObject , 2)
        else 
            -- 当前未激活的线
            CfUtils.SetUISwitchImage(v.gameObject , 1)
        end
    end
end
-- 更新要变为未激活状态的线圈
function ActivityCrisisContractLevelListCell:UpdateNoActiveLines(activeToNoActives)
    for k, v in pairs(activeToNoActives) do
        local line = self.lineGameOjects[tostring(k)]
        if isNotNull(line) then
            CfUtils.SetUISwitchImage(line.gameObject , 1)
        end
    end
end

--- 设置所有的线为未激活状态
function ActivityCrisisContractLevelListCell:UpdateAllNoActiveLines()
    for k, v in pairs(self.lineGameOjects) do
        CfUtils.SetUISwitchImage(v.gameObject , 1)
    end
end

-- 更新要变为激活状态的线圈
function ActivityCrisisContractLevelListCell:UpdateActiveLines(activeLines)
    for k, v in pairs(activeLines) do
        local line = self.lineGameOjects[tostring(k)]
        if isNotNull(line) then
            CfUtils.SetUISwitchImage(line.gameObject , 2)
        end
    end
end

--- func desc  刷新取消圆
---@param circleIds any
---@param questGroupVos CrisisEventEntryPosVo[]
---@param selectGroupCirLine any
function ActivityCrisisContractLevelListCell:RefreshCircleIdsCancel(circleIds, questGroupVos ,selectGroupCirLine )
   for k, v in pairs(questGroupVos) do
        if isNotNull(circleIds[tostring(v.id)]) then
            ---@type ActivityCrisisContractLevelListNode 
            local node = self.circleGameObject[tostring(v.id)]
            if isNotNull(node) then
                node:SetNormal()
                node:SetSelected(false)
            end
        end
   end
   self:UpdateTagScore(questGroupVos ,selectGroupCirLine)
end

function ActivityCrisisContractLevelListCell:RefreshOneCircleIdFight(circleId, questGroupVos ,selectGroupCirLine )
    for k, v in pairs(questGroupVos) do
        if checkInt(v.id) == checkInt(circleId) then
            ---@type ActivityCrisisContractLevelListNode 
            local node = self.circleGameObject[tostring(v.id)]
            if isNotNull(node) then
               node:SetFight()
            end
        end
   end
end

function ActivityCrisisContractLevelListCell:RefreshOneCircleIdSelectActive(circleId, questGroupVos ,selectGroupCirLine , isSelected )
    for k, v in pairs(questGroupVos) do
        if checkInt(v.id) == checkInt(circleId) then
            ---@type ActivityCrisisContractLevelListNode 
            local node = self.circleGameObject[tostring(v.id)]
            if isNotNull(node) then
               node:SetSelected(isSelected)
            end
        end
   end
end

--- func desc  刷新选中圆
---@param circleIds any
---@param questGroupVos CrisisEventEntryPosVo[]
---@param selectGroupCirLine any
function ActivityCrisisContractLevelListCell:RefreshOneCircleIdSelect(circleId, questGroupVos ,selectGroupCirLine )
    for k, v in pairs(questGroupVos) do
         if checkInt(v.id) == checkInt(circleId) then
             ---@type ActivityCrisisContractLevelListNode 
             local node = self.circleGameObject[tostring(v.id)]
             if isNotNull(node) then
                node:SetActive()
             end
         end
    end
    self:UpdateTagScore(questGroupVos , selectGroupCirLine)
end
--- func desc 更新当前的积分
---@param questGroupVos CrisisEventEntryPosVo[]
---@param selectGroupCirLine any
function ActivityCrisisContractLevelListCell:UpdateTagScore(questGroupVos , selectGroupCirLine)
    local groupId = tostring(questGroupVos[1].groupId)
    local oneSelectGroupCirLine = selectGroupCirLine[groupId]
    local selectCircleIdToTagId =  oneSelectGroupCirLine.selectCircleIdToTagId
    local needCount  = table.count(selectCircleIdToTagId)
    local tagSource = 0
    for k, v in pairs(selectCircleIdToTagId) do
        ---@type ActivityCrisisContractLevelListNode
        local Env = self.circleGameObject[k]
        if isNotNull(Env) and isNotNull(Env.CrisisEventEntryVo) then
            tagSource = checkInt(Env.CrisisEventEntryVo.tagScore) + tagSource
        end
    end
    CfUtils.FillText(self.TxtNum , tagSource)
    if needCount == oneSelectGroupCirLine.allSectCountNum then
        ---@type CrisisEventEntryGatherVo
        local CrisisEventEntryGatherVo = CfUtils.GetCfVo(AutoIds.IdSetting6417 , "CrisisEventEntryGatherVo" , groupId)
        local extraScore =  CrisisEventEntryGatherVo.extraScore
        KTool.SetActive(self.Integral , true)
        CfUtils.FillText(self.IntegralTxtNum , extraScore)
        oneSelectGroupCirLine.isAllSelect = true
        KTool.SetActive(self.OFF , false)
        KTool.SetActive(self.On , true)
    else 
        KTool.SetActive(self.Integral , false)
        oneSelectGroupCirLine.isAllSelect = false
        KTool.SetActive(self.OFF , true)
        KTool.SetActive(self.On , false)
    end
end
--- func desc  选中所有圆圈
---@param circleIds any
---@param questGroupVos CrisisEventEntryPosVo[]
function ActivityCrisisContractLevelListCell:RefreshAllCircleIdSelect( questGroupVos, selectGroupCirLine)
    local groupId = tostring(questGroupVos[1].groupId)
    local oneSelectGroupCirLine = selectGroupCirLine[groupId]
    local selectCircleIdToTagId = oneSelectGroupCirLine.selectCircleIdToTagId
    for k, v in pairs(questGroupVos) do
        if selectCircleIdToTagId[tostring(v.id)] then
            ---@type ActivityCrisisContractLevelListNode
            local node = self.circleGameObject[tostring(v.id)]
            if isNotNull(node) then
                node:SetActive()
                node:GenLastAndNext(v , selectGroupCirLine)
            end
        end
    end
    self:UpdateTagScore(questGroupVos, selectGroupCirLine)
end

---@param questGroupVos CrisisEventEntryPosVo[]
function ActivityCrisisContractLevelListCell:GetOrCirLinePosMap(questGroupVos)
    local tagsOrs = {}
    for k, v in pairs(questGroupVos) do
        local tagOr = checkInt(v.tagOr)
        if checkInt(v.siteType) == 1 and tagOr > 0  then
            local tagOrStr = tostring(tagOr)
            if isNull(tagsOrs[tagOrStr]) then
                tagsOrs[tagOrStr] = {}
            end
            tagsOrs[tagOrStr][#tagsOrs[tagOrStr]+1] = v.tagLoc
        end
    end     
    return tagsOrs
end     
    

function ActivityCrisisContractLevelListCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityCrisisContractLevelListCell
