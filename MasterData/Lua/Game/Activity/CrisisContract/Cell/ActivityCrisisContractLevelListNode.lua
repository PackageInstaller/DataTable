--- from: Assets/BundleResources/Prefabs/ActivityCrisisContract120015/ActivityCrisisContractLevelListNode.prefab > name: ActivityCrisisContractLevelListNode
---@class ActivityCrisisContractLevelListNode
---@field Env                           	ActivityCrisisContractLevelListNode     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Selected                      	UnityEngine.RectTransform               	@ 0    
---@field Normal                        	UnityEngine.RectTransform               	@ 1    
---@field Activate                      	UnityEngine.RectTransform               	@ 2    
---@field Fight                         	UnityEngine.RectTransform               	@ 3    
---@field Locked                        	UnityEngine.RectTransform               	@ 4    
---@field TimeNode                      	UnityEngine.RectTransform               	@ 5    
---@field NorImgIcon                    	UnityEngine.RectTransform               	@ 6    
---@field ActivateImgIcon               	UnityEngine.RectTransform               	@ 7    
---@field LockedImgIcon                 	UnityEngine.RectTransform               	@ 8    
local ActivityCrisisContractLevelListNode = Class('ActivityCrisisContractLevelListNode')
---@type ActivityCrisisUtils
local ActivityCrisisUtils = import('Game.Activity.CrisisContract.ActivityCrisisUtils')
local KTool = CS.Engine.Lib.KTool
function ActivityCrisisContractLevelListNode:__init()
    self.CrisisEventEntryVo = nil
    self.questGroupVo = nil
end


function ActivityCrisisContractLevelListNode:__delete()
end


function ActivityCrisisContractLevelListNode:Awake()

end


---@param questGroupVo CrisisEventEntryPosVo
function ActivityCrisisContractLevelListNode:RefreshNode(questGroupVo, selectGroupCirLine)
    self.questGroupVo  = questGroupVo
    SetButtonAction(self.controller.gameObject , function ()
        self:BtnClick(questGroupVo, selectGroupCirLine)
    end) 
    if isNull(self.CrisisEventEntryVo) then
        self.CrisisEventEntryVo = self:GetCrisisEventEntryVo(questGroupVo, selectGroupCirLine)
        if  isNull(self.CrisisEventEntryVo) then
            return nil
        end
    end
    -- 获取当前groupId 数据
    local oneselectGroupCirLine = selectGroupCirLine[tostring(questGroupVo.groupId)]
    local tagId = oneselectGroupCirLine.selectCircleIdToTagId[tostring(questGroupVo.id)]
    if checkInt(selectGroupCirLine.selectTagId) > 0 then
        if checkInt(selectGroupCirLine.selectTagId) == checkInt(questGroupVo.tagId) then
            self:SetSelected(true)
        else
            self:SetSelected(false)
        end
    end
    -- 已经激活
    if isNotNull(tagId) then
        -- 激活 
        self:SetActive(false)
        return 
    end
    -- 如果是未选中  并且存在冲突id 
    if checkInt(self.CrisisEventEntryVo.tagClash) > 0 then
        local tagClashIds =  selectGroupCirLine.tagClash[self.CrisisEventEntryVo.tagClash]
        local isSelect = false
        for circleId, tagInfo in pairs(tagClashIds) do
            local oneSelectGroupCirLine = selectGroupCirLine[tostring(tagInfo.groupId)]
            if oneSelectGroupCirLine  then
                if oneSelectGroupCirLine.selectCircleIdToTagId[tostring(circleId)] then
                    isSelect = true
                    break
                end
            end 
        end
        if isSelect then
            self:SetFight()
            return
        end
    end
    self:SetNormal()
    -- print("selectGroupCirLine.selectTagId =>" , checkInt(selectGroupCirLine.selectTagId)  ,  checkInt(questGroupVo.tagId))
   
end

function ActivityCrisisContractLevelListNode:GenTagToTagSorce(oneselectGroupCirLine)
    local tagId = tostring(self.CrisisEventEntryVo.id ) 
    oneselectGroupCirLine.tagToTagSorce[tagId] = self.CrisisEventEntryVo.tagScore 
end
---@param questGroupVo CrisisEventEntryPosVo
function ActivityCrisisContractLevelListNode:BtnClick(questGroupVo, selectGroupCirLine)
    local oneselectGroupCirLine = selectGroupCirLine[tostring(questGroupVo.groupId)]
    local selectCircleIdToTagId = oneselectGroupCirLine.selectCircleIdToTagId 
    local circleId = questGroupVo.id
    if selectCircleIdToTagId[tostring(circleId)] then
        if checkInt(selectGroupCirLine.selectTagId) == checkInt(questGroupVo.tagId) then
            Events.Broadcast(Constants.EventNames.ContractLevelClickEvent,{circleId = questGroupVo.id ,groupId = questGroupVo.groupId ,event ="cancel" ,tagOr = questGroupVo.tagOr , tagId = questGroupVo.tagId , tagClash = self.CrisisEventEntryVo.tagClash})    
            return
        end
        --取消圆 
        Events.Broadcast(Constants.EventNames.ContractLevelClickEvent,{circleId = questGroupVo.id ,groupId = questGroupVo.groupId ,event =  "actived" ,tagOr = questGroupVo.tagOr , tagId = questGroupVo.tagId})    
        return
    end
    local isCanSelect = self:isCanSelectClick(questGroupVo , selectGroupCirLine)
    if checkInt(self.CrisisEventEntryVo.tagClash) > 0 then
        local tagClashIds =  selectGroupCirLine.tagClash[self.CrisisEventEntryVo.tagClash]
        local isSelect = false
        local selectTagInfo = nil
        for circleId, tagInfo in pairs(tagClashIds) do
            local oneSelectGroupCirLine = selectGroupCirLine[tostring(tagInfo.groupId)]
            if oneSelectGroupCirLine  then
                if oneSelectGroupCirLine.selectCircleIdToTagId[tostring(circleId)] then
                    isSelect = true
                    selectTagInfo = tagInfo
                    break
                end
            end 
        end
        if isSelect then
            Events.Broadcast(Constants.EventNames.ContractLevelClickEvent,{circleId = selectTagInfo.circleId ,groupId = selectTagInfo.groupId ,event =  "fightUI" , tagId = selectTagInfo.tagId})    
            return
        end
    end

    --选中圆
    if  isCanSelect == -1 then
        GameUtils.Toast(localize("当前节点不能选择"))
        return
    end
    if isCanSelect > 0 then
        Events.Broadcast(Constants.EventNames.ContractLevelClickEvent,{circleId = questGroupVo.id ,groupId = questGroupVo.groupId , tagOr = questGroupVo.tagOr ,  tagId = questGroupVo.tagId,event = "select"})        
    end
end

function ActivityCrisisContractLevelListNode:GetCrisisEventEntryVo(questGroupVo ,selectGroupCirLine )
    if checkInt(questGroupVo.tagId) > 0 then
        ---@type CrisisEventEntryVo
        local CrisisEventEntryVo = CfUtils.GetCfVo(AutoIds.IdSetting6416 , "CrisisEventEntryVo" ,questGroupVo.tagId)
        local tagClash =  checkInt(CrisisEventEntryVo.tagClash ) 
        if tagClash > 0 then
            if isNull(selectGroupCirLine.tagClash[tostring(tagClash)])  then
                selectGroupCirLine.tagClash[tostring(tagClash)] = {}
            end
            selectGroupCirLine.tagClash[tostring(tagClash)][tostring(questGroupVo.id)] = {circleId =questGroupVo.id , tagId = questGroupVo.tagId , groupId = CrisisEventEntryVo.groupId}  
        end
        return CrisisEventEntryVo 
    end
    return nil
end

function ActivityCrisisContractLevelListNode:GenLastAndNext(questGroupVo, selectGroupCirLine)
    -- 说明是第一列 ， 除任务外 不需要解锁条件
    local oneselectGroupCirLine = selectGroupCirLine[tostring(questGroupVo.groupId)]
    ---@type CrisisEventEntryVo
    local CrisisEventEntryVo = self.CrisisEventEntryVo
    local nextTag = CrisisEventEntryVo.nextTag 
         -- 点击填充前置数据
    for k, v in pairs(nextTag) do 
        v = tostring(v)
        if isNull(oneselectGroupCirLine.tagLastIds[v]) then
            oneselectGroupCirLine.tagLastIds[v] = {}
        end
        local tagLastIds = oneselectGroupCirLine.tagLastIds[v]
        if not tagLastIds[questGroupVo.tagId] then
            tagLastIds[questGroupVo.tagId] = questGroupVo.tagId    
        end
    end
    local tagId = tostring(CrisisEventEntryVo.id)
    if isNull(oneselectGroupCirLine.tagNextIds[tagId]) then
        oneselectGroupCirLine.tagNextIds[tagId] = {}
        local tagNextIds = oneselectGroupCirLine.tagNextIds[tagId]
        for k, v in pairs(nextTag) do
            tagNextIds[v] = v 
        end
    end
end
---@param questGroupVo CrisisEventEntryPosVo
function ActivityCrisisContractLevelListNode:isCanSelectClick(questGroupVo, selectGroupCirLine)
    
    -- 说明是第一列 ， 除任务外 不需要解锁条件
    local oneselectGroupCirLine = selectGroupCirLine[tostring(questGroupVo.groupId)]
    ---@type CrisisEventEntryVo
    local CrisisEventEntryVo = self.CrisisEventEntryVo
    local selectCircleIdToTagId = oneselectGroupCirLine.selectCircleIdToTagId
    -- 1.是否需要前置解锁
    local isLast = false
    local isPassTask = false
    local isTagOr =  true
    self:GenLastAndNext(questGroupVo ,selectGroupCirLine)
    if not self:CheckPassUnlock(questGroupVo.questId) then
        GameUtils.ShowCommonEntryLockTips(self.controller.gameObject, self.CrisisEventEntryVo.id, questGroupVo.questId, nil)
        return 0
    end
    if CrisisEventEntryVo.unlockTag < 0 then
        -- 1. 是否需任务解锁
        isLast = true
    else 
        -- 判断前置词条是否激活
        local tagId = questGroupVo.tagId
        local tagLastIds =  oneselectGroupCirLine.tagLastIds[tagId]
        local tagIdToCircleId = oneselectGroupCirLine.tagIdToCircleId
        if isNotNull(tagLastIds) then
            for k, v in pairs(tagLastIds) do
                local circleId = tagIdToCircleId[v]
                if selectCircleIdToTagId[circleId] then
                    isLast = true 
                    break  
                end
            end
        end
    end
    if not isLast then
        return -1
    end
    return 1  
end
function ActivityCrisisContractLevelListNode:CheckPassUnlock(questId) 
    local isPassTask = false
    local CrisisEventEntryVo = self.CrisisEventEntryVo
    if checkInt(CrisisEventEntryVo.unlockTask) == 0 then
        isPassTask = true  
    else 
        isPassTask = ActivityCrisisUtils.IsFinishCrisisQuest(questId ,CrisisEventEntryVo.unlockTask)
    end
    return isPassTask
end
function ActivityCrisisContractLevelListNode:SetSelected(isSelected)
    print("isSelected =>" , isSelected)
    KTool.SetActive(self.Selected , isSelected)
end
function ActivityCrisisContractLevelListNode:SetNormal()
    local iconPath = CfUtils.GetImageFullPath(self.CrisisEventEntryVo.iconId) 
    CfUtils.FillImage(self.NorImgIcon ,iconPath)
    KTool.SetActive(self.Normal, true)
    KTool.SetActive(self.Fight, false)
    KTool.SetActive(self.Activate, false)
    KTool.SetActive(self.Selected, false)
    local isUnlock = self:CheckPassUnlock(self.questGroupVo.questId)
    KTool.SetActive(self.Locked , not isUnlock)
    if isUnlock then
        KTool.SetActive(self.TimeNode , true)
        self:SetTimeNode()
    end
    -- KTool.SetActive(self.TimeNode , isUnlock)
end

function ActivityCrisisContractLevelListNode:SetActive(isAnimation)
    if isNull(isAnimation) then
        isAnimation = true
    end
    if isAnimation then
        CfUtils.PlayAnimation(self.Activate ,"ActivityCrisisContractLevelListNode_Activate")
    end
    local iconPath = CfUtils.GetImageFullPath(self.CrisisEventEntryVo.iconId) 
    CfUtils.FillImage(self.ActivateImgIcon ,iconPath)
    KTool.SetActive(self.Normal, false)
    KTool.SetActive(self.Fight, false)
    KTool.SetActive(self.Activate, true)
    -- KTool.SetActive(self.Selected, false)
    KTool.SetActive(self.TimeNode , true)
    local isUnlock = self:CheckPassUnlock(self.questGroupVo.questId)
    KTool.SetActive(self.Locked , not isUnlock)
    if isUnlock then
        KTool.SetActive(self.TimeNode , true)
        self:SetTimeNode()
    end
end

function ActivityCrisisContractLevelListNode:SetFight()
    local iconPath = CfUtils.GetImageFullPath(self.CrisisEventEntryVo.iconId) 
    CfUtils.FillImage(self.ActivateImgIcon ,iconPath)
    KTool.SetActive(self.Normal, false)
    KTool.SetActive(self.Fight, true)
    KTool.SetActive(self.Activate, false)
    KTool.SetActive(self.Selected, false)
    KTool.SetActive(self.TimeNode , true)
    local isUnlock = self:CheckPassUnlock(self.questGroupVo.questId)
    KTool.SetActive(self.Locked , not isUnlock)
    if isUnlock then
        KTool.SetActive(self.TimeNode , true)
        self:SetTimeNode()
    end
end

function ActivityCrisisContractLevelListNode:SetLock(isViisble)
    KTool.SetActive(self.Locked , isViisble)
end
function ActivityCrisisContractLevelListNode:SetTimeNode()
    local tagSocre = self.CrisisEventEntryVo.tagScore
    CfUtils.FillText(self.TxtTime ,tagSocre) 
end

function ActivityCrisisContractLevelListNode:RefreshCommonShow(vo)
    CfUtils.FillText(self.TxtTime ,vo.tagScore)
    local iconPath = CfUtils.GetImageFullPath(vo.iconId)
    CfUtils.FillImage(self.NorImgIcon ,iconPath)
end

function ActivityCrisisContractLevelListNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityCrisisContractLevelListNode
