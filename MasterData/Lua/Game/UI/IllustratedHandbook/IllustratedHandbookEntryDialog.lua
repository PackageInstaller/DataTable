-------------------------------------------------------------------------------
-- 海外图鉴 - 入口主界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-20 21:47:05
-------------------------------------------------------------------------------

---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)

local ENTRY_TYPE = {
    CARD_ARCHIVES = 1, -- 卡牌档案
    CAT_BALL_LIST = 2, -- 猫球列表
    AREA_INTRO    = 3, -- 区域介绍
    CAMP_ENCY     = 4, -- 阵营百科
    KEYWORD_ENCY  = 5, -- 名词百科
}

local ENTRY_NODE_LUA_PATH = 'Game.UI.IllustratedHandbook.IllustratedHandbookEntryOptionNode'

local ROOT_ANIM_NAME = {
    IDLE = 'IllustbookEntryDialog_Idle',
    SHOW = 'IllustbookEntryDialog_Entry',
}

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustbookEntryDialog.prefab
---@class IllustratedHandbookEntryDialog
---@field Env                           	IllustratedHandbookEntryDialog          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field animRoot                      	UnityEngine.RectTransform               @ 动画根节点
---@field keywordEncyLight              	UnityEngine.RectTransform               @ 名词百科光效
---@field campEncyLight                 	UnityEngine.RectTransform               @ 阵营百科光效
---@field areaIntroLight                	UnityEngine.RectTransform               @ 地区介绍光效
---@field catBallLight                  	UnityEngine.RectTransform               @ 猫球列表光效
---@field archivesLight                 	UnityEngine.RectTransform               @ 成员档案光效
---@field keywordEncyNode               	UnityEngine.RectTransform               @ 名词百科节点
---@field campEncyNode                  	UnityEngine.RectTransform               @ 阵营百科节点
---@field areaIntroNode                 	UnityEngine.RectTransform               @ 地区介绍节点
---@field catBallNode                   	UnityEngine.RectTransform               @ 猫球列表节点
---@field archivesNode                  	UnityEngine.RectTransform               @ 成员档案节点
local IllustratedHandbookEntryDialog = Class('IllustratedHandbookEntryDialog')


function IllustratedHandbookEntryDialog:__init()
    ---@type table<integer, UnityEngine.RectTransform> @ 入口光效map
    self.entryLightMap_ = {}
    ---@type table<integer, UnityEngine.RectTransform> @ 入口节点map
    self.entryNodeMap_  = {}
    ---@type table<integer, boolean> @ 入口节点禁用map
    self.disableEntryMap_ = {}
    ---@type table<integer, IllustratedHandbookEntryOptionNode> @ 入口节点lua map
    self.entryLuaEnvMap_ = {}
end


function IllustratedHandbookEntryDialog:__delete()
    self.entryLightMap_   = nil
    self.entryNodeMap_    = nil
    self.disableEntryMap_ = nil
    self.entryLuaEnvMap_  = nil
end


function IllustratedHandbookEntryDialog:Awake()
    SetButtonAction(self.archivesNode, Bind(self, self.OnClickCardArchivesEntryNodeHandler_))
    SetButtonAction(self.catBallNode, Bind(self, self.OnClickEntryCatBallNodeHandler_))
    SetButtonAction(self.areaIntroNode, Bind(self, self.OnClickAreaIntroEntryNodeHandler_))
    SetButtonAction(self.campEncyNode, Bind(self, self.OnClickCampEncyEntryNodeHandler_))
    SetButtonAction(self.keywordEncyNode, Bind(self, self.OnClickKeywordEncyEntryNodeHandler_))
end


function IllustratedHandbookEntryDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        self.entryLightMap_ = {
            [ENTRY_TYPE.CARD_ARCHIVES] = self.archivesLight,
            [ENTRY_TYPE.CAT_BALL_LIST] = self.catBallLight,
            [ENTRY_TYPE.AREA_INTRO]    = self.areaIntroLight,
            [ENTRY_TYPE.CAMP_ENCY]     = self.campEncyLight,
            [ENTRY_TYPE.KEYWORD_ENCY]  = self.keywordEncyLight,
        }

        self.entryNodeMap_ = {
            [ENTRY_TYPE.CARD_ARCHIVES] = self.archivesNode,
            [ENTRY_TYPE.CAT_BALL_LIST] = self.catBallNode,
            [ENTRY_TYPE.AREA_INTRO]    = self.areaIntroNode,
            [ENTRY_TYPE.CAMP_ENCY]     = self.campEncyNode,
            [ENTRY_TYPE.KEYWORD_ENCY]  = self.keywordEncyNode,
        }

        for entryType, entryNode in pairs(self.entryNodeMap_) do
            self.entryLuaEnvMap_[entryType] = CfUtils.GetLuaScr(entryNode, ENTRY_NODE_LUA_PATH)
            self:UpdateEntryNodeState_(entryType)
        end

        if checkBool(initParams.isReturn) then
            CfUtils.PlayAnimation(self.animRoot, ROOT_ANIM_NAME.IDLE)
        else
            CfUtils.PlayAnimation(self.animRoot, ROOT_ANIM_NAME.SHOW)
        end
    end)
end


function IllustratedHandbookEntryDialog:OnFinalize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        initParams.isReturn = true

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@param entryType integer @see ENTRY_TYPE
---@return boolean
function IllustratedHandbookEntryDialog:IsDisableEntry(entryType)
    return checkBool(self.disableEntryMap_[checkInt(entryType)])
end

---@param entryType integer @see ENTRY_TYPE
---@param isDisable boolean
function IllustratedHandbookEntryDialog:SetDisableEntry(entryType, isDisable)
    self.disableEntryMap_[checkInt(entryType)] = checkBool(isDisable)
    local isEnableEntry = self:IsDisableEntry(entryType) == false
    CfUtils.SetActive(self.entryNodeMap_[checkInt(entryType)], isEnableEntry)
    CfUtils.SetActive(self.entryLightMap_[checkInt(entryType)], isEnableEntry)
end


-------------------------------------------------
-- private

---@param entryType integer @see ENTRY_TYPE
function IllustratedHandbookEntryDialog:UpdateEntryNodeState_(entryType)
    ---@type IllustratedHandbookEntryOptionNode
    local entryLuaEnv = self.entryLuaEnvMap_[entryType]
    local isShowRed   = false
    local isShowNew   = false
    local targetNum   = 0
    local currentNum  = 0

    ------------------------------------------------- [卡牌档案]
    if entryType == ENTRY_TYPE.CARD_ARCHIVES then
        local roleTypeDojo = illustratedHandbookComp:GetHandbookCollectDojo(Constants.HandbookCollectionType.ROLE)
        local skinTypeDojo = illustratedHandbookComp:GetHandbookCollectDojo(Constants.HandbookCollectionType.SKIN)
        local catTypeDojo  = illustratedHandbookComp:GetHandbookCollectDojo(Constants.HandbookCollectionType.CAT)
        targetNum  = table.count(roleTypeDojo.totalMap or {}) + table.count(skinTypeDojo.totalMap or {}) + table.count(catTypeDojo.totalMap or {})
        currentNum = table.count(roleTypeDojo.ownedMap or {}) + table.count(skinTypeDojo.ownedMap or {}) + table.count(catTypeDojo.ownedMap or {})
        if isShowNew == false and illustratedHandbookComp:CheckHandbookRoleRedPoint() then
            isShowNew = true
        end
        if isShowNew == false and illustratedHandbookComp:CheckHandbookSkinRedPoint() then
            isShowNew = true
        end
        if isShowNew == false and illustratedHandbookComp:CheckHandbookCatRedPoint() then
            isShowNew = true
        end
        
    ------------------------------------------------- [猫球档案]
    elseif entryType == ENTRY_TYPE.CAT_BALL_LIST then
        local catBallTypeDojo  = illustratedHandbookComp:GetHandbookCollectDojo(Constants.HandbookCollectionType.CAT_BALL)
        targetNum  = table.count(catBallTypeDojo.totalMap)
        currentNum = table.count(catBallTypeDojo.ownedMap)
        isShowNew  = illustratedHandbookComp:CheckHandbookCatBallRedPoint()
        
    ------------------------------------------------- [区域介绍]
    elseif entryType == ENTRY_TYPE.AREA_INTRO then
        for _, encyDojo in pairs(illustratedHandbookComp:GetRegionMapEncyDojoMap()) do
            targetNum = targetNum + 1

            if encyDojo.isUnlock then
                currentNum = currentNum + 1
            end

            if encyDojo.isNewMark then
                isShowNew = true
            end
        end
        
    ------------------------------------------------- [组织百科]
    elseif entryType == ENTRY_TYPE.CAMP_ENCY then
        for _, encyDojo in pairs(illustratedHandbookComp:GetKeywordsEncyDojoMap()) do
            if encyDojo.encyVo.encyTag == Constants.HandbookEncyclopediaTag.CAMP then
                targetNum = targetNum + 1

                if encyDojo.isUnlock then
                    currentNum = currentNum + 1
                end

                if encyDojo.isNewMark then
                    isShowNew = true
                end
            end
        end
        
    ------------------------------------------------- [名词百科]
    elseif entryType == ENTRY_TYPE.KEYWORD_ENCY then
        for _, encyDojo in pairs(illustratedHandbookComp:GetKeywordsEncyDojoMap()) do
            if encyDojo.encyVo.encyTag == Constants.HandbookEncyclopediaTag.WORD then
                targetNum = targetNum + 1

                if encyDojo.isUnlock then
                    currentNum = currentNum + 1
                end

                if encyDojo.isNewMark then
                    isShowNew = true
                end
            end
        end
    end

    entryLuaEnv:SetTotalNum(targetNum)
    entryLuaEnv:SetCurrentNum(currentNum)
    entryLuaEnv:SetShowNewMark(isShowNew)
    entryLuaEnv:SetShowRedPoint(isShowRed)
end


-------------------------------------------------
-- handler

function IllustratedHandbookEntryDialog:OnClickCardArchivesEntryNodeHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.IllustratedHandbookMainDialog, nil, {
        UIArgs(Constants.UITypeIds.IllustratedHandbookEntryDialog)
    }, true)
end


function IllustratedHandbookEntryDialog:OnClickEntryCatBallNodeHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.IllustratedHandbookCatballListDialog, nil, {
        UIArgs(Constants.UITypeIds.IllustratedHandbookEntryDialog)
    }, true)
end


function IllustratedHandbookEntryDialog:OnClickAreaIntroEntryNodeHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIActionPrimaryMapDialog, {introMode = true}, {
        UIArgs(Constants.UITypeIds.IllustratedHandbookEntryDialog)
    }, true)
end


function IllustratedHandbookEntryDialog:OnClickCampEncyEntryNodeHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.IllustratedHandbookProperNounDialog, {encyTag = Constants.HandbookEncyclopediaTag.CAMP}, {
        UIArgs(Constants.UITypeIds.IllustratedHandbookEntryDialog)
    }, true)
end


function IllustratedHandbookEntryDialog:OnClickKeywordEncyEntryNodeHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.IllustratedHandbookProperNounDialog, {encyTag = Constants.HandbookEncyclopediaTag.WORD}, {
        UIArgs(Constants.UITypeIds.IllustratedHandbookEntryDialog)
    }, true)
end


return IllustratedHandbookEntryDialog
