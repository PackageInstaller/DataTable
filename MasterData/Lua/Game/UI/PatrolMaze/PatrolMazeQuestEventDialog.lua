-------------------------------------------------------------------------------
-- 夜巡迷宫 - 关卡事件弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-06 17:53:57
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()
local questConfMgr    = QuestConfMgr:GetInstance()
local cardConfMgr     = CardConfMgr:GetInstance()

local RootAnimName = {
    SHOW = 'ChoiceEventDialog130201_Choose',
    HIDE = 'ChoiceEventDialog130201_Cancel',
}

local RootBlockName = {
    SHOW = 'PatrolMazeQuestEventDialog_Show',
    HIDE = 'PatrolMazeQuestEventDialog_Hide',
}

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Patrol/ChoiceEventDialog130201.prefab > name: ChoiceEventDialog130201
---@class PatrolMazeQuestEventDialog
---@field Env                           	PatrolMazeQuestEventDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field OtherOperateBtn               	Game.Native.Common.FontStyleButton      	@ 0    按钮 其他操作按钮
---@field ButtonOtherRoot               	UnityEngine.RectTransform               	@ 1    按钮 其他根节点
---@field HelpSelectBtn                 	Game.Native.Common.FontStyleButton      	@ 2    按钮 选择助战按钮
---@field HelpPreviewBtn                	Game.Native.Common.FontStyleButton      	@ 3    按钮 预览详情按钮
---@field ButtonHelpRoot                	UnityEngine.RectTransform               	@ 4    按钮 帮助根节点
---@field ButtonGroupNode               	UnityEngine.RectTransform               	@ 5    按钮-根节点
---@field StoryDescrTxt                 	UnityEngine.RectTransform               	@ 6    剧情 描述文本
---@field StoryGroupNode                	UnityEngine.RectTransform               	@ 7    剧情-根节点
---@field StoreDescrTxt                 	UnityEngine.RectTransform               	@ 8    商店 描述文本
---@field StoreGroupNode                	UnityEngine.RectTransform               	@ 9    商店-根节点
---@field HelpDescrTxt                  	UnityEngine.RectTransform               	@ 10   支援 描述文本
---@field HelpMembersNode               	UnityEngine.RectTransform               	@ 11   支援 阵容节点
---@field HelpGroupNode                 	UnityEngine.RectTransform               	@ 12   支援-根节点
---@field EnemyRewardsGoodsListLight    	UnityEngine.RectTransform               	@ 13   敌人 奖励道具列表
---@field EnemyRewardsScrollView        	UnityEngine.RectTransform               	@ 14   敌人 奖励滚动视图
---@field EnemyMembersNode              	UnityEngine.RectTransform               	@ 15   敌人 阵容节点
---@field EnemyGroupNode                	UnityEngine.RectTransform               	@ 16   敌人-根节点
---@field TitleNodeUIFX                 	UnityEngine.RectTransform               	@ 17   标题 特效节点
---@field TitleNameTxt                  	UnityEngine.RectTransform               	@ 18   标题 名字文本
---@field TitleFloorTxt                 	UnityEngine.RectTransform               	@ 19   标题 层数文本
---@field TitleIconImg                  	UnityEngine.RectTransform               	@ 20   标题 图标图片
---@field TitleFrameImg                 	UnityEngine.RectTransform               	@ 21   标题 框底图片
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 22   动画根节点
---@field ScoreGroupRoot                	UnityEngine.RectTransform               	@ 23   分数-根节点
---@field ScoreRewardIcon               	UnityEngine.RectTransform               	@ 24   分数 奖励图标
---@field ScoreRewardTxt                	UnityEngine.RectTransform               	@ 25   分数 奖励文本
local PatrolMazeQuestEventDialog = Class('PatrolMazeQuestEventDialog')


function PatrolMazeQuestEventDialog:__init()
    ---@type fun():void @ 后退关闭回调
    self.backCallback_ = nil

    ---@type PatrolMazeAreaDojo @ 当前所在区域dojo
    self.mapAreaDojo_ = nil

    ---@type PatrolMazeFloorPathDojo @ 路径节点dojo
    self.floorPathDojo_ = nil

    ---@type PatrolMazeFloorLevelDojo @ 层级节点dojo
    self.floorLevelDojo_ = nil

    ---@type UITeamMembersNode @ 支援阵容节点
    self.helpMembersNode_ = nil

    ---@type integer @ 支援阵容选择id
    self.helpMemberSelectId_ = 0

    ---@type UITeamMembersNode @ 敌人阵容节点
    self.enemyMembersNode_ = nil

    ---@type CommonGoodsListLight @ 敌人奖励列表
    self.enemyRewardsList_ = nil

    ---@type fun():void @ 操作的执行回调
    self.operateCallback_ = nil
end


function PatrolMazeQuestEventDialog:__delete()
    self.backCallback_       = nil
    self.mapAreaDojo_        = nil
    self.floorPathDojo_      = nil
    self.floorLevelDojo_     = nil
    self.helpMembersNode_    = nil
    self.helpMemberSelectId_ = nil
    self.enemyMembersNode_   = nil
    self.enemyRewardsList_   = nil
    self.operateCallback_    = nil
end


function PatrolMazeQuestEventDialog:Awake()
    self.helpMembersNode_  = CfUtils.GetLuaScr(self.HelpMembersNode, Constants.UILuaTablePath.TeamMembersNode)
    self.enemyMembersNode_ = CfUtils.GetLuaScr(self.EnemyMembersNode, Constants.UILuaTablePath.TeamMembersNode)
    self.enemyRewardsList_ = CfUtils.GetLuaScr(self.EnemyRewardsGoodsListLight, Constants.UILuaTablePath.ComGoodsList2)

    SetButtonAction(self.OtherOperateBtn, Bind(self, self.OnClickOtherOperateButtonHandler_))
    SetButtonAction(self.HelpPreviewBtn, Bind(self, self.OnClickHelpPreviewButtonHandler_))
    SetButtonAction(self.HelpSelectBtn, Bind(self, self.OnClickHelpSelectButtonHandler_))
end


function PatrolMazeQuestEventDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams   = self.controller.Argument.parameters or {}
        self.mapAreaDojo_  = initParams.areaDojo
        self.backCallback_ = initParams.backCb

        if initParams.extParams then
            local helpSelectId = checkInt(initParams.extParams.helpSelectId)
            if helpSelectId > 0 then
                self.helpMemberSelectId_ = helpSelectId
            end
        end

        self:RefreshQuestEvent(initParams.pathDojo, initParams.levelDojo)

        CfUtils.RefreshTopGoods({ PatrolMazeUtils.GetCurrencyId() })
    end)
end


function PatrolMazeQuestEventDialog:OnFinalize()
    return CoWaitDo(function()
        CfUtils.ConditionRemove(RootBlockName.SHOW)
        CfUtils.ConditionRemove(RootBlockName.HIDE)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function PatrolMazeQuestEventDialog:OnShow()
    return CoWaitDo(function()
        CfUtils.ConditionAppend(RootBlockName.SHOW)
        CfUtils.PlayAnimation(self.AnimRoot, RootAnimName.SHOW)
        CoYield(CfUtils.GetAnimationTime(self.AnimRoot, RootAnimName.SHOW))
        CfUtils.ConditionRemove(RootBlockName.SHOW)
    end)
end


function PatrolMazeQuestEventDialog:OnHide()
    return CoWaitDo(function()
        CfUtils.ConditionAppend(RootBlockName.HIDE)
        CfUtils.PlayAnimation(self.AnimRoot, RootAnimName.HIDE)
        CoYield(CfUtils.GetAnimationTime(self.AnimRoot, RootAnimName.HIDE))
        CfUtils.ConditionRemove(RootBlockName.HIDE)
    end)
end


function PatrolMazeQuestEventDialog:OnBackAction()
    if self.backCallback_ then
        self.backCallback_()
    end
end


-------------------------------------------------
-- public

---@param pathNode PatrolMazeMainFloorPathNode
---@param levelNode PatrolMazeMainFloorLevelNode
function PatrolMazeQuestEventDialog:RefreshQuestEvent(pathDojo, levelDojo)
    self.floorPathDojo_  = pathDojo
    self.floorLevelDojo_ = levelDojo
    self:UpdateQuestEventDialog_()
end


function PatrolMazeQuestEventDialog:Close()
    CfUtils.DialogBack()
end


-------------------------------------------------
-- private

function PatrolMazeQuestEventDialog:UpdateQuestEventDialog_()
    local floorNum    = checkInt(self.floorPathDojo_.floorNum)
    local questType   = checkInt(self.floorLevelDojo_.questType)
    local questTypeVo = PatrolMazeUtils.GetQuestTypeVo(questType)

    -- update button name
    self.OtherOperateBtn:ResetFontStyle(Constants.ButtonFontStyle.B3, questTypeVo.buttonName)

    -- update title group
    CfUtils.SetUISwitchText(self.TitleNameTxt, questType)
    CfUtils.SetUISwitchText(self.TitleFloorTxt, questType)
    CfUtils.SetUISwitchImage(self.TitleIconImg, questType)
    CfUtils.SetUISwitchImage(self.TitleFrameImg, questType)
    CfUtils.FillText(self.TitleNameTxt, questTypeVo.typeName or '???')
    CfUtils.FillText(self.TitleFloorTxt, string.format('%.2d', floorNum))
    local particleNodeList = {
        'UIFX_Common_TitleCloudEffect/LiZi',
        'UIFX_Common_TitleCloudEffect/YanWu1',
        'UIFX_Common_TitleCloudEffect/YanWu2',
        'UIFX_Common_TitleCloudEffect/YanWu3',
    }
    for _, particleNodePath in ipairs(particleNodeList) do
        local particleNodeTf = self.TitleNodeUIFX.transform:Find(particleNodePath)
        CfUtils.SetActive(particleNodeTf, false)
        CfUtils.SetUISwitchParticleSystem(particleNodeTf, questType)
        CfUtils.SetActive(particleNodeTf, true)
    end

    -- reset all group
    self.operateCallback_ = nil
    CfUtils.SetActive(self.ScoreGroupRoot, true)
    CfUtils.SetActive(self.HelpGroupNode, false)
    CfUtils.SetActive(self.EnemyGroupNode, false)
    CfUtils.SetActive(self.StoreGroupNode, false)
    CfUtils.SetActive(self.StoryGroupNode, false)
    CfUtils.SetActive(self.ButtonGroupNode, false)
    
    if (questType == PatrolMazeUtils.QuestType.EMPTY or 
        questType == PatrolMazeUtils.QuestType.MIDDLE or 
        questType == PatrolMazeUtils.QuestType.ELITE or 
        questType == PatrolMazeUtils.QuestType.BOSS) then
        self.operateCallback_ = Bind(self, self.OnClickOperateToBattleCallback_)
        self:UpdateQuestEnemyEventInfo_()

    elseif questType == PatrolMazeUtils.QuestType.SHOP then
        self.operateCallback_ = Bind(self, self.OnClickOperateOpenShopCallback_)
        self:UpdateQuestShopEventInfo_()

    elseif questType == PatrolMazeUtils.QuestType.STORY then
        self.operateCallback_ = Bind(self, self.OnClickOperatePlayStoryCallback_)
        self:UpdateQuestStoryEventInfo_()

    elseif questType == PatrolMazeUtils.QuestType.HELP then
        self:UpdateQuestHelpEventInfo_()
    end

    self:UpdateQuestTypeScoreInfo_()
end


--- 是否 可操作该事件
---@return boolean
function PatrolMazeQuestEventDialog:CheckEventOperability_()
    local canOperate = false
    if self.mapAreaDojo_ and self.floorPathDojo_ and self.floorLevelDojo_ then
        -- 只有当前所在层，才可能操作
        if self.mapAreaDojo_.floorPassed + 1 == self.floorPathDojo_.floorNum then
            -- 当前层，未作出选择时，都可以看到可操作
            if self.floorPathDojo_.selectLevel == 0 then
                canOperate = true
            else
                -- 否则，如果选择了层级，那么就只能选中的层级才能操作了
                if self.floorPathDojo_.selectLevel == self.floorLevelDojo_.floorLevel then
                    canOperate = true
                end
            end
        end
    end
    return canOperate
end


function PatrolMazeQuestEventDialog:UpdateQuestTypeScoreInfo_()
    local goodsId  = PatrolMazeUtils.GetScoreId()
    local iconPath = GoodsConfMgr:GetInstance():GetPhotoPathById(goodsId)
    CfUtils.FillImage(self.ScoreRewardIcon, iconPath)

    local areaId    = self.mapAreaDojo_.areaId
    local floorNum  = self.floorPathDojo_.floorNum
    local questType = self.floorLevelDojo_.questType
    local scoreNum  = PatrolMazeUtils.GetScoreNum(areaId, floorNum, questType)
    CfUtils.FillText(self.ScoreRewardTxt, scoreNum)
end


--- 更新 敌人事件信息
function PatrolMazeQuestEventDialog:UpdateQuestEnemyEventInfo_()
    CfUtils.SetActive(self.EnemyGroupNode, true)

    local areaId   = self.mapAreaDojo_.areaId
    local floorNum = self.floorPathDojo_.floorNum
    local levelNum = self.floorLevelDojo_.floorLevel

    -- all enemy data
    local mazeEventId     = checkInt(self.floorLevelDojo_.typeRefId)
    local mazeQuestVo     = PatrolMazeUtils.GetBattleLevelVo(mazeEventId)
    local allQuestWaveVo  = questConfMgr:GetAllQuestLineupVo(mazeQuestVo.commonQuestId)
    local memberDataList  = {}
    local memberAliveList = {}
    for _, waveVo in ipairs(allQuestWaveVo) do
        local wave1NpcType = waveVo.wave1NpcType
        local attrs        = waveVo.attribute
        local skinIds      = waveVo.skinId
        for monsterIndex, monsterId in ipairs(waveVo.wave1NpcId) do
            --- 克隆一份数据 直接覆盖需要修改的字段
            local monsterRare = 0
            local monsterData = {}
            ---@type MonsterTypeVo
            local monsterTypeVo = clone(cardConfMgr:GetMonsterTypeVoById(monsterId))
            -- override data
            monsterTypeVo.monsterClass = checkNumber(wave1NpcType[monsterIndex])
            if checkNumber(attrs[monsterIndex]) > 0 then
                monsterTypeVo.attribute = checkNumber(attrs[monsterIndex])
            elseif monsterTypeVo.role > 0 then
                local cardVo = cardConfMgr:GetCardBySkinRefId(monsterTypeVo.skinId)
                monsterTypeVo.attribute = cardVo.attributeType
            end
            if checkNumber(skinIds[monsterId]) > 0 then
                monsterTypeVo.skinId = checkNumber(skinIds[monsterId])
            end
            -- check rare
            if monsterTypeVo.role > 0 then
                local cardData = cardConfMgr:GetCardByRefId(monsterTypeVo.mode)
                monsterRare = cardData.rare
                -- monster data
                monsterData = {
                    id          = monsterId,
                    defaultSkin = monsterTypeVo.skinId,
                    rare        = monsterRare,
                    hpPercent   = 1,
                    energy      = 0,
                }
                table.insert(memberDataList, monsterData)
            else
                monsterData = monsterTypeVo
                local monsterClass = monsterTypeVo.monsterClass
                if monsterClass == Constants.RoleClass.Boss then
                    monsterData.rare = Constants.RareType.SSR
                elseif monsterClass == Constants.RoleClass.Elite then
                    monsterData.rare = Constants.RareType.SR
                else
                    monsterData.rare = Constants.RareType.R
                end
                table.insert(memberDataList, monsterData)
            end
            table.insert(memberAliveList, 1)
        end
    end

    -- 敌人的血量会有变化所以不做缓存，随时点随时请求最新的。除非战斗结束后也同步怪物的血量就可以缓存只请求一次了。
    local requestData = {areaId = areaId, floor = floorNum, level = levelNum, questId = mazeEventId}
    GameUtils.Request(Interfaces.OverseaMazeQuestMonster, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- update monsterInfo
            self.floorLevelDojo_:FillMonsterInfo(responseData)

            -- update memberData
            for monsterIndex, memberData in ipairs(memberDataList) do
                local monsterDojo = self.floorLevelDojo_.monsterDojoList[monsterIndex]
                if monsterDojo then
                    memberData.hpPercent = monsterDojo.hpPercent
                    memberData.energy    = monsterDojo.energy
                    if memberData.hpPercent == 0 then
                        memberAliveList[monsterIndex] = 0
                    end
                end
            end

            -- update membersNode
            self.enemyMembersNode_:ResetCells()
            self.enemyMembersNode_:FillMonsters(memberDataList, nil, function()
                CfUtils.DialogOpen(Constants.UITypeIds.UIBossDetailDialog, {levelId = mazeQuestVo.commonQuestId})
            end)
            self.enemyMembersNode_:FillCardAliveState(memberAliveList)
        end
    end)

    -- update rewards
    local showRewardData = PatrolMazeUtils.GetQuestShowRewardData(areaId, floorNum, mazeQuestVo.mazeRewardId)
    self.enemyRewardsList_:FreshBaseUI(showRewardData, nil, nil, nil, nil, nil, false)

    -- update button group
    if self:CheckEventOperability_() then
        CfUtils.SetActive(self.ButtonGroupNode, true)
        CfUtils.SetActive(self.ButtonHelpRoot, false)
        CfUtils.SetActive(self.ButtonOtherRoot, true)
    end
end


--- 更新 助战事件信息
function PatrolMazeQuestEventDialog:UpdateQuestHelpEventInfo_()
    CfUtils.SetActive(self.HelpGroupNode, true)

    local areaId   = self.mapAreaDojo_.areaId
    local floorNum = self.floorPathDojo_.floorNum
    local levelNum = self.floorLevelDojo_.floorLevel

    local showHelpMembersFunc = function()
        local assistIdList = self.floorLevelDojo_.assistIdList

        local selectAssistFunc = function(selectId)
            -- refresh select
            local selectStateData = {}
            for assistIndex, assistId in ipairs(assistIdList) do
                selectStateData[assistIndex] = selectId == assistId and 1 or 0
            end
            self.helpMembersNode_:FillCardSelectState(selectStateData)
            -- update tempSelect
            self.helpMemberSelectId_ = selectId
        end

        -- update memberData
        local memberDataList = {}
        for assistIndex, assistId in ipairs(assistIdList) do
            local monsterData = {
                id        = assistId,
                idType    = Constants.IDType.QuestPatrolMaze,
                hpPercent = 1,
                energy    = 0,
                clickCb   = function()
                    if self:CheckEventOperability_() then
                        selectAssistFunc(assistId)
                    end
                end
            }
            table.insert(memberDataList, monsterData)
        end
        self.helpMembersNode_:FillPatrolEventNode(memberDataList)

        -- auto select one
        if self:CheckEventOperability_() then
            if self.helpMemberSelectId_ > 0 then
                selectAssistFunc(self.helpMemberSelectId_)
            else
                selectAssistFunc(assistIdList[1])
            end
        end
    end
    
    -- 助战角色请求一次就可以缓存起来用了，不会有变化
    local assistIdList = self.floorLevelDojo_.assistIdList
    if #assistIdList > 0 then
        showHelpMembersFunc()
    else
        local requestData = {areaId = areaId, floor = floorNum, level = levelNum}
        GameUtils.Request(Interfaces.OverseaMazeAssistList, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)
    
                -- update assistsInfo
                self.floorLevelDojo_:FillAssistsInfo(responseData)
                
                showHelpMembersFunc()
            end
        end)
    end

    -- update descr
    local shopDescr = PatrolMazeUtils.GetParamDescr(PatrolMazeUtils.ParamsId.HELP_EVENT_DESCR)
    CfUtils.FillText(self.HelpDescrTxt, shopDescr)

    -- update button group
    if self:CheckEventOperability_() then
        CfUtils.SetActive(self.ButtonGroupNode, true)
        CfUtils.SetActive(self.ButtonHelpRoot, true)
        CfUtils.SetActive(self.ButtonOtherRoot, false)
    end
end


--- 更新 商店事件信息
function PatrolMazeQuestEventDialog:UpdateQuestShopEventInfo_()
    CfUtils.SetActive(self.StoreGroupNode, true)

    -- update descr
    local shopDescr = PatrolMazeUtils.GetParamDescr(PatrolMazeUtils.ParamsId.SHOP_EVENT_DESCR)
    CfUtils.FillText(self.StoreDescrTxt, shopDescr)

    -- update buttons
    if self:CheckEventOperability_() then
        CfUtils.SetActive(self.ButtonGroupNode, true)
        CfUtils.SetActive(self.ButtonHelpRoot, false)
        CfUtils.SetActive(self.ButtonOtherRoot, true)
    end
end


--- 更新 剧情事件信息
function PatrolMazeQuestEventDialog:UpdateQuestStoryEventInfo_()
    CfUtils.SetActive(self.StoryGroupNode, true)

    -- update descr
    local mazeEventId = checkInt(self.floorLevelDojo_.typeRefId)
    local mazeStoryVo = PatrolMazeUtils.GetStoryLevelVo(mazeEventId)
    CfUtils.FillText(self.StoryDescrTxt, mazeStoryVo.mazeStoryDescr)

    -- update buttons
    if self:CheckEventOperability_() then
        CfUtils.SetActive(self.ButtonGroupNode, true)
        CfUtils.SetActive(self.ButtonHelpRoot, false)
        CfUtils.SetActive(self.ButtonOtherRoot, true)
    end
end


---@param operateCb fun():void
function PatrolMazeQuestEventDialog:CheckConfirmSelectFloorLevel_(operateCb)
    if self.floorPathDojo_.selectLevel > 0 then
        if operateCb then
            operateCb()
        end
    else
        local areaId   = self.mapAreaDojo_.areaId
        local floorNum = self.floorPathDojo_.floorNum
        local levelNum = self.floorLevelDojo_.floorLevel
        patrolMazeComp:SaveMazeAreaSelect(areaId, floorNum, levelNum, function()
            if operateCb then
                operateCb()
            end
        end)
    end
end


-------------------------------------------------
-- handler

function PatrolMazeQuestEventDialog:OnClickOtherOperateButtonHandler_()
    -- 如果未作出楼层选择，那么点击操作时，就当做已做出选择
    self:CheckConfirmSelectFloorLevel_(function()
        if self.operateCallback_ then
            self.operateCallback_()
        else
            GameUtils.Toast('Debug：蜜汁类型的操作')
        end
    end)
end


function PatrolMazeQuestEventDialog:OnClickOperateToBattleCallback_()
    local mazeEventId = checkInt(self.floorLevelDojo_.typeRefId)
    local mazeQuestVo = PatrolMazeUtils.GetBattleLevelVo(mazeEventId)
    local teamParams  = {areaDojo = self.mapAreaDojo_, pathDojo = self.floorPathDojo_, levelDojo = self.floorLevelDojo_}
    if #self.mapAreaDojo_:GetAliveCardDojoList() > 0 then
        self:Close()
        CfUtils.DialogOpen(Constants.UITypeIds.UIFightTeamChoose, {levelId = mazeQuestVo.commonQuestId, teamIndex = self.mapAreaDojo_.areaId, patrolMaze = teamParams}, {
            UIArgs(Constants.UITypeIds.UIPatrolMazeMainDialog)
        })
    else
        GameUtils.Toast(localize('当前没有可出战成员，请使用复活道具'))
    end
end


function PatrolMazeQuestEventDialog:OnClickOperateOpenShopCallback_()
    self:Close()
    CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolMazeStoreEventDialog, {areaDojo = self.mapAreaDojo_, pathDojo = self.floorPathDojo_, levelDojo = self.floorLevelDojo_}, {
        UIArgs(Constants.UITypeIds.UIPatrolMazeMainDialog)
    })
end


function PatrolMazeQuestEventDialog:OnClickOperatePlayStoryCallback_()
    local mazeEventId = checkInt(self.floorLevelDojo_.typeRefId)
    local mazeStoryVo = PatrolMazeUtils.GetStoryLevelVo(mazeEventId)
    self:Close()
    local areaId   = self.mapAreaDojo_.areaId
    local floorNum = self.floorPathDojo_.floorNum
    local levelNum = self.floorLevelDojo_.floorLevel
    local storyId  = mazeStoryVo.mazePlotId
    CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolPlotEventDialog, {areaId = areaId, floorNum = floorNum, levelNum = levelNum, storyId = storyId}, {
        UIArgs(Constants.UITypeIds.UIPatrolMazeMainDialog)
    })
end


function PatrolMazeQuestEventDialog:OnClickHelpPreviewButtonHandler_()
    if self.helpMemberSelectId_ == 0 then
        GameUtils.Toast('Debug：你到是选一个预览啊')
        return
    end

    ---@type PatrolMazeMainDialog
    local patrolMazeMainDialog = CfUtils.DialogGet(Constants.UITypeIds.UIPatrolMazeMainDialog)
    if patrolMazeMainDialog then
        patrolMazeMainDialog.Argument.parameters.tempHelpSelectId = self.helpMemberSelectId_
    end
    self:Close()
    local assistCardVo   = PatrolMazeUtils.GetAssistCardVo(self.helpMemberSelectId_)
    local assistCardDojo = PatrolMazeUtils.GetAssistCardDojo(self.helpMemberSelectId_)
    CardUtils.ShowCardPreview({cardDojo = assistCardDojo, additionMap = assistCardVo.additionMap, isPureCard = true}, {
        UIArgs(Constants.UITypeIds.UIPatrolMazeMainDialog)
    })
end


function PatrolMazeQuestEventDialog:OnClickHelpSelectButtonHandler_()
    if self.helpMemberSelectId_ == 0 then
        GameUtils.Toast('Debug：你到是选一个助战啊')
        return
    end

    self:CheckConfirmSelectFloorLevel_(function()
        local areaId   = self.mapAreaDojo_.areaId
        local floorNum = self.floorPathDojo_.floorNum
        local levelNum = self.floorLevelDojo_.floorLevel
        local assistId = self.helpMemberSelectId_
        patrolMazeComp:MoveMazeByAssistSelect(areaId, floorNum, levelNum, assistId, function()
            local rewardList = { {goodsId = assistId, num = 1} }
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList, cb = function()
                self:Close()
                Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
            end})
        end)
    end)
end


return PatrolMazeQuestEventDialog
