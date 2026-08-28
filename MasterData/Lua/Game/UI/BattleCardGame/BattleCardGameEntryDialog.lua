-------------------------------------------------------------------------------
-- 和风战牌 - 入口界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-17 16:06:37
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

local QuestListCellPath = 'Game.UI.BattleCardGame.BattleCardGameEntryQuestCell'
local QuestListCellName = 'ActivityJapanesePokerEntryNode'

local RootNodeAnimName = {
    SHOW = 'ActivityJapanesePokerEntryDialog_Entry',
    IDLE = 'ActivityJapanesePokerEntryDialog_Idle',
}

local FilterTypes = {
    ALL = 0,  -- 全部的
}

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerEntryDialog.prefab > name: ActivityJapanesePokerEntryDialog
---@class BattleCardGameEntryDialog
---@field Env                           	BattleCardGameEntryDialog               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field BgNode                        	UnityEngine.RectTransform               	@ 1    背景节点
---@field BtnShop                       	UnityEngine.RectTransform               	@ 2    牌店按钮
---@field BtnAlbum                      	UnityEngine.RectTransform               	@ 3    牌册按钮
---@field BtnAlbumRedPoint              	UnityEngine.RectTransform               	@ 4    牌册按钮红点
---@field CardsNumTxt                   	UnityEngine.RectTransform               	@ 5    卡牌数文本
---@field DecorCradRoot                 	UnityEngine.RectTransform               	@ 6    装饰卡牌跟节点
---@field TypeFilterNode                	UnityEngine.RectTransform               	@ 7    类型筛选节点
---@field QuestLoopView                 	SuperScrollView.LoopListView2           	@ 8    关卡列表
local BattleCardGameEntryDialog = Class('BattleCardGameEntryDialog')


function BattleCardGameEntryDialog:__init()
    ---@type UICommonFilterMB @ 类型过滤按钮
    self.typeFilterEnv_ = nil

    ---@type table<integer, BattleCardGameEntryDialog.QuestCellData[]> @ 类型分组数据（key：类型id，value：数据列表）
    self.typeGroupMap_ = {}

    ---@type BattleCardGameEntryDialog.QuestCellData[] @ 过滤数据列表
    self.filterDataList_ = {}
end


function BattleCardGameEntryDialog:__delete()
    self.typeFilterEnv_  = nil
    self.typeGroupMap_   = nil
    self.filterDataList_ = nil
end


function BattleCardGameEntryDialog:Awake()
    self.typeFilterEnv_ = CfUtils.GetLuaScr(self.TypeFilterNode, Constants.UILuaTablePath.ComFilterMB)
    self.typeFilterEnv_:SetPageType(Constants.UIFilterPageType.DropDown)
    self.typeFilterEnv_:SetStyleType(Constants.UIFilterStyleType.White)
    self.typeFilterEnv_:SetCallback({}, function()
        local selectIndex  = self.typeFilterEnv_.selectIndex
        local sortTypeData = self.typeFilterEnv_.sortTypeList[selectIndex]
        self:SetFilterType(sortTypeData.conditionType)
    end)

    SetButtonAction(self.BtnShop, Bind(self, self.OnClickShopButtonHandler_))
    SetButtonAction(self.BtnAlbum, Bind(self, self.OnClickAlbumButtonHandler_))
    SetListViewAction(self.QuestLoopView, Bind(self, self.OnUpdateQuestListCellHandler_), QuestListCellName)

    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [BattleCardGameUtils.EventsName.HAVE_CARDS_CHANGE] = Bind(self, self.OnHaveCardsChangeHandler_)
    })

    GameUtils.BindRedPoint(Constants.RedPointConst.BattleCardAlbum, self.BtnAlbum, true)
end


function BattleCardGameEntryDialog:OnFocus(focus)
    if focus then
        CfUtils.RefreshTopGoods({ BattleCardGameUtils.GetHpGoodsId() })
        battleCardGameComp:CheckCollectionRed()
    end
end


function BattleCardGameEntryDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams  = CfUtils.DialogSafeParameters(self.controller)
        local isBackMode  = checkBool(initParams.isBackMode_)
        local filterIndex = checkInt(initParams.filterIndex_)

        -- init views
        local initViewFunc = function()
            self:InitTypeGroupMap_()
            self:UpdateDecorCrads_()
            self:UpdateCardsNum_()
            
            -- create filter datas
            local filterDatas = self:CreateFilterDatas_()
            self.typeFilterEnv_:InitSortTypeData(filterDatas)
            self.typeFilterEnv_.selectIndex = filterIndex > 0 and filterIndex or 1  -- 全部
            self.typeFilterEnv_:RefreshUI()

            CfUtils.SetActive(self.TypeFilterNode, table.count(self.typeGroupMap_) > 1)
        end

        if isBackMode then
            CfUtils.PlayAnimation(self.RootNode, RootNodeAnimName.IDLE)
            initViewFunc()
        else
            BattleCardGameUtils.BgNodePlayEnterAnim(self.BgNode)
            CfUtils.SetActive(self.RootNode, false)
            
            -- request home
            battleCardGameComp:SyncHomeData(function()
                CfUtils.SetActive(self.RootNode, true)
                CfUtils.PlayAnimation(self.RootNode, RootNodeAnimName.SHOW)
                initViewFunc()
            end)
        end
    end)
end


function BattleCardGameEntryDialog:OnFinalize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        initParams.questListState_ = CfUtils.GuiLoopListStateSave(self.QuestLoopView)
        initParams.filterIndex_    = self.typeFilterEnv_.selectIndex
        initParams.isBackMode_     = true

        CfUtils.EventsUndecorated(self.eventsDecorated_)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameEntryDialog:GetFilterType()
    return checkInt(self.filterType_)
end
function BattleCardGameEntryDialog:SetFilterType(type)
    self.filterType_ = checkInt(type)
    self:UpdateFilterType_()
end


---@return BattleCardGameEntryDialog.QuestCellData[]
function BattleCardGameEntryDialog:GetFilterDataList()
    return checkTable(self.filterDataList_)
end


-------------------------------------------------
-- private

function BattleCardGameEntryDialog:InitTypeGroupMap_()
    -- create quest datas
    self.typeGroupMap_ = {
        [FilterTypes.ALL] = {}
    }
    local hasCardsNum = battleCardGameComp:GetHomeDojo():GetCardsCount()
    for _, questDojo in pairs(battleCardGameComp:GetHomeDojo().questDojoMap) do
        local questId   = questDojo.questId
        local questVo   = BattleCardGameUtils.GetNpcQuestVo(questId)
        local questType = questVo:GetQuestType()
        ---@class BattleCardGameEntryDialog.QuestCellData
        ---@field questId integer
        ---@field questVo BattleCardGameNpcQuestVo
        ---@field questDojo BattleCardGameQuestDojo
        ---@field isClean boolean @ 是否领取光全部奖励
        ---@field isUnlock boolean @ 是否解锁
        local questData = {
            questId   = questId,
            questVo   = questVo,
            questDojo = questDojo,
            isClean   = questDojo.leftRewardTimes == 0,
            isUnlock  = hasCardsNum >= questVo.unlockCount,
        }
        -- 0为副本关卡，入口界面列表需过滤掉
        local isNeedShow = questVo.costGoodsNum > 0
        -- 编辑器上才可以看到测试用NPC
        if CfUtils.IsRealDebug() and questVo:IsTestQuest() then
            isNeedShow = true
        end
        if isNeedShow then  
            if not self.typeGroupMap_[questType] then
                self.typeGroupMap_[questType] = {}
            end
            table.insert(self.typeGroupMap_[questType], questData)
            if questType > 0 then
                table.insert(self.typeGroupMap_[FilterTypes.ALL], questData)
            end
        end
    end

    -- sort quest data
    for _, questDataList in pairs(self.typeGroupMap_) do
        ---@param aQuestData BattleCardGameEntryDialog.QuestCellData
        ---@param bQuestData BattleCardGameEntryDialog.QuestCellData
        table.sort(questDataList, function(aQuestData, bQuestData)
            local aPriority = 0
            local bPriority = 0
            aPriority = aPriority + (aQuestData.isUnlock and 100 or 0)
            bPriority = bPriority + (bQuestData.isUnlock and 100 or 0)
            aPriority = aPriority + (not aQuestData.isClean and 10 or 0)
            bPriority = bPriority + (not bQuestData.isClean and 10 or 0)
            aPriority = aPriority + (aQuestData.questId < bQuestData.questId and 1 or 0)
            bPriority = bPriority + (bQuestData.questId < aQuestData.questId and 1 or 0)
            return aPriority > bPriority
        end)
    end
end


---@return table[]
function BattleCardGameEntryDialog:CreateFilterDatas_()
    local filterDatas = {
        {conditionType = FilterTypes.ALL, typeDesc = localize('全部')},
    }
    for filterType, _ in pairs(self.typeGroupMap_) do
        if filterType ~= FilterTypes.ALL then
            local cardKindVo = BattleCardGameUtils.GetCardKindVo(filterType)
            table.insert(filterDatas, {conditionType = filterType, typeDesc = tostring(cardKindVo.kindName)})
        end
    end
    table.sort(filterDatas, function(aFilterData, bFilterData)
        return aFilterData.conditionType < bFilterData.conditionType
    end)
    return filterDatas
end


function BattleCardGameEntryDialog:UpdateFilterType_()
    local filterType     = self:GetFilterType()
    self.filterDataList_ = checkTable(self.typeGroupMap_[filterType])

    -- update quest list
    self:UpdateQuestList_()
end


function BattleCardGameEntryDialog:UpdateDecorCrads_()
    for showCardIndex = 1, 3 do
        local battleCardId   = checkInt(battleCardGameComp:GetHomeDojo().homeShowCards[showCardIndex])
        local battleCardNode = self.DecorCradRoot:Find(string.fmt('Card%1/ActivityJapanesePokerCardNode', showCardIndex))
        CfUtils.SetActive(battleCardNode, battleCardId > 0)
        if battleCardId > 0 then
            ---@type BattleCardGamePlayCardNode
            local battleCardLua = CfUtils.GetLuaScr(battleCardNode, BattleCardGameUtils.LuaSrcPath.PlayCardNode)
            battleCardLua:GetCardNode():SetBattleCardId(battleCardId)
            battleCardLua:SetLayerDepth(true)
        end
    end
end


function BattleCardGameEntryDialog:UpdateCardsNum_()
    local allCardsNum = #BattleCardGameUtils.GetAllCardInfoVo()
    local hasCardsNum = battleCardGameComp:GetHomeDojo():GetCardsCount()
    CfUtils.FillText(self.CardsNumTxt, string.fmt('%1/%2', hasCardsNum, allCardsNum))
end


function BattleCardGameEntryDialog:UpdateQuestList_()
    local initParams     = CfUtils.DialogSafeParameters(self.controller)
    local questListState = initParams.questListState_
    local listDataLength = #self:GetFilterDataList()

    if questListState ~= nil then
        self.QuestLoopView.DisplayItemNumber = self.QuestLoopView.DisplayItemCount
        GameUtils.ReloadData(self.QuestLoopView, listDataLength)
        CfUtils.GuiLoopListStateLoad(self.QuestLoopView, questListState)
        initParams.questListState_ = nil

    else
        self.QuestLoopView.DisplayItemNumber = 0
        GameUtils.ReloadData(self.QuestLoopView, listDataLength)
    end
end


-------------------------------------------------
-- handler

function BattleCardGameEntryDialog:OnClickShopButtonHandler_()
    local ActivityConstants = import('Game.Activity.ActivityConstants')
    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityCommonShopTabUpDialog, {
        mallBgImage  = 'Arts/Textures/ActivityJapaneseLevel/Entry/activity_hefeng_task_bg.png',
        activityUuid = battleCardGameComp:GetHomeDojo().activityUuid,
        customType   = ActivityConstants.ActivityType.BattleCardGame,
        topGoods     = { BattleCardGameUtils.GetMallCurrencyId() },
    }, { UIArgs(self.controller.Argument.id) })
end


function BattleCardGameEntryDialog:OnClickAlbumButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerCollectDialog)
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function BattleCardGameEntryDialog:OnUpdateQuestListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(QuestListCellName)
    local cellData = self:GetFilterDataList()[luaIndex]
    ---@type BattleCardGameEntryQuestCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, QuestListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickRoleDetailCB(Bind(self, self.OnClickQuestCellRoleDetailCallback_))
        cellEnv:SetClickEnterQuestCB(Bind(self, self.OnClickQuestCellEnterQuestCallback_))
        -- play anim
        if listView.DisplayItemNumber < listView.DisplayItemCount then
            cellEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            cellEnv:PlayAnimByIdle()
        end
    end
    return cellNode
end


--- 点击 关卡列表节点 的 查看关卡详情 按钮
---@param luaIndex integer
function BattleCardGameEntryDialog:OnClickQuestCellRoleDetailCallback_(luaIndex)
    local cellData = self:GetFilterDataList()[luaIndex]
    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerCradRulePopup, {questId = cellData.questId})
end


--- 点击 关卡列表节点 的 进入关卡按钮 按钮
---@param luaIndex integer
function BattleCardGameEntryDialog:OnClickQuestCellEnterQuestCallback_(luaIndex)
    local cellData = self:GetFilterDataList()[luaIndex]

    -- check unlock
    if not cellData.isUnlock then
        GameUtils.Toast(localize('暂未解锁'))
        return
    end

    -- check clean
    if cellData.isClean and not cellData.questVo:IsTestQuest() then
        GameUtils.Toast(localize('奖励次数已用完'))
        return
    end

    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerChooseDialog, {
        npcId       = cellData.questId,
        isFromEntry = true,
    }, { UIArgs(self.controller.Argument.id) })
end


function BattleCardGameEntryDialog:OnHaveCardsChangeHandler_(eventData)
    self:UpdateCardsNum_()
end


return BattleCardGameEntryDialog
