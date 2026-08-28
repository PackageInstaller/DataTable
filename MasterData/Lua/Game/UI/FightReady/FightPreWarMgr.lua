--- 战前管理类
--- Created by thl
---

local Singleton = import('Frame.Singleton')
local _UIModule = CS.Engine.UI.UIModule
local _KTool = CS.Engine.Lib.KTool
local cs_coroutine = require 'XLua.cs_coroutine'
local ChapterUtils = import('Game.Chapter.ChapterUtils')
local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
local AppEngine = CS.Engine.Lib.AppEngine
local UIModule = CS.Engine.UI.UIModule
local KCookie = CS.Engine.Lib.KCookie
local MaidCoffeeUtils     = import("Game.MaidCoffee.MaidCoffeeUtils")
local BattleRouter = import("Game.UI.FightReady.FightRouter")

---@class FightPreWarMgr
---@field GetInstance fun(self:FightPreWarMgr):FightPreWarMgr
local FightPreWarMgr = Class("FightPreWarMgr", Singleton)

JumpFromType = {
    JF_TeamChoose = 1,
    JF_TeamChoose2 = 2, --编队选人跳转
    JF_Maze = 3, --迷宫跳转
    JF_BattleEnd = 4, --结算跳转
}

function FightPreWarMgr:__init(...)
    self.fightdata = nil       --服务器返回的战斗数据
    self.args = nil            --战斗的一些缓存参数
    self.guideData = nil
    self.guideIndex = nil
    self.battleOverHandler = Events.AddListener(Constants.EventNames.BattleGameOverShow, Bind(self, self.BattleOver))
    self.isOnBack2FightPre = nil
end

function FightPreWarMgr:__delete()
    self.fightdata = nil
    self.args = nil
    self.guideData = nil
    self.guideIndex = nil
    Events.RemoveListener(Constants.EventNames.BattleGameOverShow, self.battleOverHandler)
    self.battleOverHandler = nil
    self.isOnBack2FightPre = nil
end

-- 暂时存储战斗返回数据
---@field serverData table 服务器返回的战斗数据
---@field args table 战斗的一些缓存参数
function FightPreWarMgr:SetFightData(serverData, args)
    self.fightdata = clone(serverData)     --克隆一下  防止被其他引用修改
    self.args = args
end

function FightPreWarMgr:SetArgs(args)
    self.args = args
end

function FightPreWarMgr:SetGuideData(serverData, index)
    self.guideData = serverData
    self.guideIndex = index
end

function FightPreWarMgr:GetGuideNextData()
    self.guideIndex = math.min(self.guideIndex + 1, #self.guideData)
    return self.guideData[self.guideIndex]
end

function FightPreWarMgr:GetFightData()
    return self.fightdata            --出去的也克隆
end

function FightPreWarMgr:GetBattleArgs()
    return self.args
end

--获取世界boss时的加载脚本
function FightPreWarMgr:GetWorldBossLoadingEnv()
    local t = self:GetBattleArgs()
    if not t then
        return nil
    end
    return t.loadingEnv
end

--清空战斗缓存
function FightPreWarMgr:ClearBattleBuff()
    self.args = nil
    self.fightdata = nil
end

---战斗回放
function FightPreWarMgr:FightReplay(battleData)
    if not battleData then
        return
    end
    print("Entrance 5")
    self:ClearBattleBuff()
    --回放数据写到xml数据磁盘中
    CS.Engine.Tools.PlayerPrefsUtility.SetEncryptedString("RecordData", battleData)
    --_G["RecordData"] = battleData
    BattleMgr = import('Game.Battle.Core.BattleMgr')
    ---@type BattleViewMgr
    BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
    BattleMgr.gameMode = Constants.GameMode.PVE
    BattleViewMgr.gameMode = Constants.GameMode.PVE
    BattleViewMgr.isReplay = true
    --进入战斗场景
    GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.BattleScene, parameters = {
    } }, nil, Constants.LoadingType.Battle)
end

function FightPreWarMgr:InitPVPParams(args)
    local server = string.slice(args.server, ':')
    BattleMgr = import('Game.Battle.Core.BattleMgr')
    BattleMgr.gameMode = Constants.GameMode.PVP
    BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
    BattleViewMgr.gameMode = Constants.GameMode.PVP
    BattleViewMgr.pvpMode = args.pvpMode
    BattleViewMgr.roomId = args.roomId
    BattleViewMgr.address = args.server
    BattleViewMgr.isReconnectOutside = args.isReconnectOutside or 0
    BattleViewMgr.port = checkInt(server[2])
end

function FightPreWarMgr:InitPPVEParams(args)
    local server = string.slice(args.server, ':')
    BattleMgr = import('Game.Battle.Core.BattleMgr')
    BattleMgr.gameMode = Constants.GameMode.PVP
    BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
    BattleViewMgr.gameMode = Constants.GameMode.OnlinePVE
    BattleViewMgr.pvpMode = args.pvpMode
    BattleViewMgr.roomId = args.roomId
    BattleViewMgr.address = server[1]
    BattleViewMgr.port = checkInt(server[2])
    BattleViewMgr.isReconnectOutside = args.isReconnectOutside or 0
end

---进入战斗总入口
---@field questId string 关卡ID
---@field args table 其他参数
---@field dialogArguments table 要关闭的弹出窗口
function FightPreWarMgr:FightEnter(questId, args, dialogArguments)
    -- Events.Broadcast(Constants.EventNames.FriendPVPPromptBeCancelled, true)
    args = checkTable(args)
    local gameMode = args.gameMode or Constants.GameMode.PVE
    -- if gameMode == Constants.GameMode.PVP then
    --     print("Entrance 1")
    --     -- self:SetArgs(args)
    --     local server = string.slice(args.server, ':')
    --     BattleMgr = import('Game.Battle.Core.BattleMgr')
    --     BattleMgr.gameMode = gameMode
    --     BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
    --     BattleViewMgr.gameMode = gameMode
    --     BattleViewMgr.address = args.server
    --     BattleViewMgr.port = checkInt(server[2])
    --     -- BattleViewMgr.loadingUI = args.loadingEnv
    --     -- args.loadingEnv = nil
    --     -- BattleViewMgr:Start()
    --     return
    -- end
    local routerType = args.routerType
    if BattleRouter:CheckRouterExists(Constants.BattleRequestType.Enter, routerType) then
        BattleRouter:FightEnter(routerType, questId, args, dialogArguments)
    else
        self:DoFightEnter(questId, args, dialogArguments)
    end
end

function FightPreWarMgr:DoFightEnter(questId, args, dialogArguments)
    local battleEnterReqId, battleEnterReqBody, battleEndReqId, battleEndReqBody, battleEndCb = self:GetFightEnterArgs(questId, args)
    --战斗开始和结束请求必须有
    local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    if not battleEnterReqId or not levelType == Constants.IDType.QuestTrail then
        return
    end

    GameUtils.Request(battleEnterReqId, battleEnterReqBody, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            self:SetArgs(args)
            self:BattleEnterErrorHandle(questId)
            return
        end

        --local comp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CookingComponent)
        ----使用就扣除
        --if comp:IsActiveBattleFood() then
        --    comp:DelUseBattleFoodTime(questId)
        --end

        local responseData = checkTable(response.data)
        self:BattleBeforHandle(questId, responseData)

        -- 清除主线提醒
        CfUtils.CookieSave(Constants.UICacheDataKeys.MAIN_QUEST_REMIND, 0)  

        responseData.isRecord = checkNumber(args.isRecord)
        --保存战斗数据
        self:SetFightData(responseData, args)

        local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
        if levelType == Constants.IDType.QuestWorldBoss then
            print("Entrance 2")

            BattleMgr = import('Game.Battle.Core.BattleMgr')
            BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
            BattleMgr.gameMode = Constants.GameMode.PVE
            BattleViewMgr.gameMode = Constants.GameMode.PVE
            --BattleViewMgr:Start()
            if checkBool(args.isWorldBossNext) then
                BattleViewMgr:RestartBattle(responseData.battleData)
            else
                --进入战斗场景
                GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.BattleScene, parameters = {
                    questId = questId, path = battleEndReqId, body = battleEndReqBody, callback = battleEndCb
                } }, dialogArguments, Constants.LoadingType.Battle)
            end
        elseif levelType == Constants.IDType.QuestTrail then
            print("Entrance QuestTrail")
            BattleMgr = import('Game.Battle.Core.BattleMgr')
            BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
            BattleMgr.gameMode = Constants.GameMode.PVE
            BattleViewMgr.gameMode = Constants.GameMode.PVE
            --BattleViewMgr:Start()
            if checkBool(args.isTrailChallengeNext) then
                BattleViewMgr:RestartBattle(responseData.battleData)
            else
                --进入战斗场景
                GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.BattleScene, parameters = {
                    questId = questId, path = battleEndReqId, body = battleEndReqBody, callback = battleEndCb
                } }, dialogArguments, Constants.LoadingType.Battle)
            end
        else
            -- 序章OP进入战斗指定的loading图id
            if questId == Constants.QUEST_OP_LEVEL[2] then
                local KCookie = CS.Engine.Lib.KCookie
                KCookie.Set(Constants.UICacheDataKeys.OP_LOADING_IMG_ID, 8)
                print("[loading] set", 8)
            elseif questId == Constants.QUEST_OP_LEVEL[3] then
                local KCookie = CS.Engine.Lib.KCookie
                KCookie.Set(Constants.UICacheDataKeys.OP_LOADING_IMG_ID, 9)
                print("[loading] set", 9)
            end
            print("Entrance 3")
            BattleMgr = import('Game.Battle.Core.BattleMgr')
            BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
            BattleMgr.gameMode = Constants.GameMode.PVE
            BattleViewMgr.gameMode = Constants.GameMode.PVE
            if checkNumber(args.index) > 1 then
                BattleViewMgr:RestartBattle(responseData.battleData)
            else
                --进入战斗场景
                GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.BattleScene, parameters = {
                   questId = questId, path = battleEndReqId, body = battleEndReqBody, callback = battleEndCb
                }}, dialogArguments, Constants.LoadingType.Battle)
            end
        end
    end)
end


function FightPreWarMgr:GuideFightEnter(id, arg)
    local co = cs_coroutine.start(function()
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)

        local ids = Constants.QUEST_DOUBLE_GUIDE
        local args = {}
        --暂存数据
        local guideData = {}
        --for i = 1, #ids do
        --    local questId = ids[i]
        --    local battleEnterReqId, battleEnterReqBody, battleEndReqId, battleEndReqBody, battleEndCb = self:GetFightEnterArgs(questId, args)
        --
        --    if battleEnterReqId and battleEndReqId then
        --        local op = GameUtils.Request(battleEnterReqId, battleEnterReqBody, function(request, response)
        --            if checkNumber(response.errCode) ~= 0 then
        --                return
        --            end
        --            local responseData = checkTable(response.data)
        --            table.insert(guideData, responseData)
        --        end)
        --        while not op.IsFinish do
        --            coroutine.yield()
        --        end
        --    end
        --end
        
        :: network ::
        
        --if QTETest then
        --    local str = "{\"data\":{\"battleData\":{\"questId\":10000,\"randomSeed\":\"624fe6fc6b943\",\"mapId\":10801,\"rounds\":3,\"settingId\":1,\"battleSkill\":[[]],\"playerTeam\":[[{\"id\":1,\"cardId\":101008,\"skinId\":10100801,\"playerCardId\":-1,\"level\":40,\"attr\":\"3=8444.4&1=1364&2=643.7&6=1.5&20=5&7=1&5=0.01\",\"generalSkills\":{\"1\":71101008,\"2\":72101008},\"finalSkills\":\"73101008=1\",\"passiveSkills\":\"110100891=1\",\"currentHp\":8444.4,\"currentEnergy\":0,\"maxSP\":4,\"ai\":\"\",\"career\":3,\"attribute\":1,\"weakId\":0,\"combatValue\":8056,\"star\":1,\"summons\":[]}]],\"enemyTeam\":[[{\"id\":1000,\"enemyId\":38001101,\"level\":1,\"type\":2,\"attr\":\"3=1452&1=290.4&2=392.7&7=1&6=1.5\",\"generalSkills\":{\"1\":510200701,\"2\":520200701,\"4\":540200701,\"6\":550200701},\"finalSkills\":\"570200701=1\",\"passiveSkills\":\"\",\"currentHp\":1452,\"currentEnergy\":0,\"maxSP\":6,\"ai\":\"zhuxian/10000_8001\",\"skinId\":30800101,\"career\":1,\"attribute\":2,\"weakId\":0,\"summons\":[]}]],\"callTeam\":[[]],\"specialTeam\":[[]],\"mergeSkillId\":[false],\"playerTeamSkill\":\"\",\"skillQueueLoop\":2,\"skillQueue\":\"1=2=1&1=1=2&1=2=1&1=1=2\",\"myPartyCat\":{\"id\":5000},\"enemyPartyCat\":[],\"first\":1}},\"timestamp\":1649403644,\"errCode\":0,\"errMsg\":\"\"}"
        --    local response = table.deserialize(str)
        --    table.insert(guideData, response.data)
        --else
            local success  = 0
            GameUtils.Request(Interfaces.QuestAt, {questId = id}, function(request, response)
                if checkNumber(response.errCode) ~= 0 then
                    return
                end
                success = 1
                table.insert(guideData, response.data)
                -- 进入关卡扣除体力
                if response.data and response.data.hp then
                    GoodsUtils.DrawRewards({{
                        num = checkNumber(response.data.hp) - GoodsUtils.GetThingNo(Constants.Currency.HpId),
                        goodsId = Constants.Currency.HpId
                    }}, true)
                end
            end)
            while success == 0 do
                coroutine.yield()
            end
        --end

        --- 这个等待关键  op的回调在 IsFinish 之后
        coroutine.yield()
        
        table.sort(guideData, function(a, b)
            return a.battleData.questId < b.battleData.questId
        end)

        for i = 1, #guideData do
            printInfo(guideData[i].battleData.questId)
        end
        
        if #guideData ~= #ids then
            printError("request count not equal ")
            
            local type = 0
            GameUtils.SecondConfirm(localize("获取网络数据失败"), function()
                type = 1
            end, function() 
                type = 2
            end)

            while type == 0 do
                coroutine.yield()
            end

            if type == 1 then
                goto network
            else
                CS.UnityEngine.Application.Quit()
            end
            
            return
        end

        self:SetGuideData(guideData, 1)
        --先第一场
        local questId = guideData[1].battleData.questId
        local responseData = guideData[1]
        
        local battleEnterReqId, battleEnterReqBody, battleEndReqId, battleEndReqBody, battleEndCb = self:GetFightEnterArgs(questId, args)
        self:BattleBeforHandle(questId, responseData)

        responseData.isRecord = checkNumber(args.isRecord)
        --保存战斗数据
        self:SetFightData(responseData, args)

        if questId == Constants.QUEST_OP_LEVEL[2] then
            local KCookie = CS.Engine.Lib.KCookie
            KCookie.Set(Constants.UICacheDataKeys.OP_LOADING_IMG_ID, 8)
            print("[loading] set", 8)
        elseif questId == Constants.QUEST_OP_LEVEL[3] then
            local KCookie = CS.Engine.Lib.KCookie
            KCookie.Set(Constants.UICacheDataKeys.OP_LOADING_IMG_ID, 9)
            print("[loading] set", 9)
        end
        print("Entrance 3")
        BattleMgr = import('Game.Battle.Core.BattleMgr')
        BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
        BattleMgr.gameMode = Constants.GameMode.PVE
        BattleViewMgr.gameMode = Constants.GameMode.PVE
        --BattleViewMgr.waitForStart = true
        if arg ~= nil and checkBool(arg.isContinue) then
            BattleViewMgr:RestartBattle(responseData.battleData)
        else 
        --进入战斗场景
            GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.BattleScene, parameters = {
                questId = questId, path = battleEndReqId, body = battleEndReqBody, callback = battleEndCb
            } }, nil, Constants.LoadingType.Battle)
    
            --_UIModule.CurrentScreen.Argument.parameters = {
            --    questId = questId, path = battleEndReqId, body = battleEndReqBody, callback = battleEndCb
            --}
        end
        local wait = true

        --放到qteentry
        --BattleViewMgr:Start(function()
        --    wait = false
        --end, true)
        --
        --while wait do
        --    coroutine.yield()
        --end
        --
        ----BattleViewMgr:FindLoadingUI(responseData)
        ----BattleViewMgr.loadingUI
        --
        --_KTool.SetActive(BattleViewMgr.loadingUI.controller.gameObject, false)
    end)
    
    return co
    
    
end

--错误处理
function FightPreWarMgr:BattleEnterErrorHandle(questId)
    --[[
    local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    --世界boss  卡点进入的时候
    if levelType == Constants.IDType.QuestWorldBoss then
        --清掉当前所有的ui
        local dialogs = CS.Engine.UI.UIModule.CurrentScreen.dialogs
        for i, dialog in pairs(dialogs) do
            CS.Engine.UI.UIModule.CloseDialog(dialog)
        end
        local loadUi = self:GetWorldBossLoadingEnv()
        if loadUi then
            loadUi:Close()
        end

        local WorldBossMgr = import('Game.UI.FightReady.UIWorldBoss.WorldBossMgr')
        WorldBossMgr:GetInstance():InitBossModel()

        CS.Engine.UI.UIModule.OpenDialog({ id = Constants.UITypeIds.UIWorldBossMainDialog }, {
        })
    end
    ]]
end

---BattleBeforHandle 战斗开始之前不需要服务器数据的不同关卡的特殊处理
---@field questId string 关卡ID
function FightPreWarMgr:BattleBeforHandle(questId, responseData)
    responseData = checkTable(responseData)
    -- 进入关卡扣除体力
    if responseData.hp then
        GoodsUtils.DrawRewards({{
            num = checkNumber(responseData.hp) - GoodsUtils.GetThingNo(Constants.Currency.HpId),
            goodsId = Constants.Currency.HpId
        }}, true)
    end
    -- 双旦关卡体力扣除
    if responseData.doubleDanHp then
        local midFestivalComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityMidFestivalComponent)
        local entryId = midFestivalComponent:GetActivityEnergyId()
        
        GoodsUtils.DrawRewards({
            {
                num = checkNumber(responseData.doubleDanHp) - GoodsUtils.GetThingNo(entryId),
                goodsId = entryId
            }
        })
        ---@type ActivityMidFestivalComponent
        local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityMidFestivalComponent)
        comp:GetHomeDojo():StartTimeDown()
    end
    --竹林扣除体力
    if responseData.ptQuestHp then
        GoodsUtils.DrawRewards({
            {
                num = checkNumber(responseData.ptQuestHp) - GoodsUtils.GetThingNo(Constants.Currency.BambooHp),
                goodsId = Constants.Currency.BambooHp
            }
        })
        ---@type BambooMgr
        local BambooMgr = import("Game.UI.FightReady.UIBamboo.BambooMgr")
        BambooMgr:GetInstance():StartTimer()
    end

    -- 梦境奇缘关卡体力扣除
    if responseData.linkageHp then
        ---@type DreamAdventuresMgr
        local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
        GoodsUtils.DrawRewards({
            {
                num = checkNumber(responseData.linkageHp) - GoodsUtils.GetThingNo(DreamAdventuresMgr:GetActivityHPId()),
                goodsId = DreamAdventuresMgr:GetActivityHPId()
            }
        })
        DreamAdventuresMgr:StartTimer()
    end

    -- 更新编队的最大战力
    if responseData.battleData then
        local power = self:GetMyPlayerTotalPower(responseData.battleData)
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        playerComponent.playerDojo:UpdateHistoryTeamsPower(power)
    end
end

---BattleOver 战斗结束回调
---@param args table {isWin = true}
function FightPreWarMgr:BattleOver(args)
    if BattleInfo and BattleInfo.gameMode == Constants.GameMode.PVP then return end
    if BattleInfo and BattleInfo.gameMode == Constants.GameMode.OnlinePVE then return end
    if BattleInfo and BattleInfo.playMode == Constants.PlayMode.Replay then return end
    if BattleInfo and BattleInfo.isSimulator then return end
    
    if QTETest then
        printInfo(_UIModule.CurrentScreen.gameObject.name)
        local QTEEntry = import("Game.QTE.QTEEntry")
        QTEEntry:AfterBattleQTE()
        return
    end
   
    args = checkTable(args)
    local argument = nil
    if BattleRouter:CheckRouterExists(Constants.BattleRequestType.GeneratorEndArgs, self.args.routerType) then
        argument = BattleRouter:GetFightEndArgs(self.args.routerType, args)
    else
        argument = self:GetFightEndArgs(args)
    end

    --[[
    --去一下战前数据记录的是否是回放
    local fightData = self:GetFightData()
    --如果是回放
    if fightData and checkNumber(fightData.isRecord) == 1 then
        _UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattleEndDialog, parameters = {
            questId = argument.questId,
            isPassed = (checkBool(args.isWin) and 1 or 0),
            callback = argument.callback,
        }})
        return
    end
    ]]

    print("->MineValue_isOnBack2FightPre_OnBattleOver", self.isOnBack2FightPre)
    if checkBool(self.isOnBack2FightPre) then return end

    if BattleRouter:CheckRouterExists(Constants.BattleRequestType.End, self.args.routerType) then
        BattleRouter:DoRequestBattleOver(self.args.routerType, args, argument)
    else
        self:DoRequestBattleOver(args, argument)
    end
end

---@param args table 战斗结算数据
---@param argument table 
function FightPreWarMgr:DoRequestBattleOver(args, argument)

    GameUtils.Request(argument.path, argument.body, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local questId = checkNumber(argument.questId)
            local st, tb = ChapterUtils.WillTriggerSpecialExits(questId)
            --print("arg ", table.dump(argument))
            --TODO 记录本地OP状态
            local IsOpenOp =  AppEngine.GetConfig("Engine.Dev", "IsOpenOp")
            if checkNumber(IsOpenOp) > 0 and table.indexof(Constants.QUEST_OP_LEVEL, questId) and QuestConfMgr:GetInstance():GetCurOpId() ~= 0 then
                ---直接回主界面
                local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.QuestComponent)
                comp:UpdateMainQuestInfo(questId, true)
                
                --local QTEEntry = import("Game.QTE.QTEEntry")
                --_UIModule.CloseDialogById(Constants.UITypeIds.UIBattlingDialog)
                --_UIModule.CurrentScreen.dialogs:Clear()
                --local dialogs = _UIModule.CurrentScreen.dialogs
                --for i, dialog in pairs(dialogs) do
                --    _UIModule.CloseDialog(dialog)
                --end
                --
                local curOp = QuestConfMgr:GetInstance():GetCurOpId()
                if (curOp ~= 0) then
                    MainQuestMapMgr:GetInstance():EnterQuestOp(QuestConfMgr:GetInstance():GetCurOpId(), {isContinue =true})
                else
                    GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome }, {}, Constants.LoadingType.MainHome, true)
                end
                --local AppEngine = CS.Engine.Lib.AppEngine
                --if Config.DEBUG then
                --    if AppEngine.ContainsConfigKey("Engine.Dev", "TestGuideFight") then
                --        local testGuideFight = AppEngine.GetConfig("Engine.Dev", "TestGuideFight")
                --        if checkNumber(testGuideFight) == 1 then
                --            QTEEntry:AfterBattleQTE()
                --            --用作标记 战斗跳转
                --            --AppEngine.SetConfig("Engine.Dev","TestGuideFight", "0")
                --            return
                --        end
                --    end
                --end
                --local IsOpenGuide = AppEngine.GetConfig("Engine.Dev", "IsOpenGuide")
                ----x_record_event('CHAPTER_STORE_END')
                ----CS.Engine.UI.UIModule.Clear()
                --if checkNumber(IsOpenGuide) == 1 or QTEReview == true then
                --    QTEEntry:AfterBattleQTE()
                --else
                --    CS.Engine.UI.UIModule.Clear()
                --    --GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome, hasExcluded = true }, nil, Constants.LoadingType.MainHome)
                --    QTEEntry:FinishBattle()
                --end
            else
                local showTimeCountDown = false
                local countDownCallback

                local responseData = checkTable(response.data)
                local levelType = GoodsUtils.GetIdType(argument.questId, Constants.IDArea.Quests)
                if levelType == Constants.IDType.QuestWorldBoss then
                    if checkNumber(responseData.next) ~= 0 then
                        --清掉当前所有的ui
                        --local dialogs = CS.Engine.UI.UIModule.CurrentScreen.dialogs
                        --for i, dialog in pairs(dialogs) do
                        --    CS.Engine.UI.UIModule.CloseDialog(dialog)
                        --end

                        --BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
                        --BattleViewMgr:OnDestroy()

                        --local worldBossComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.WorldBossComponent)
                        --worldBossComponent:WorldBossBattleBeging(argument.questId)
                        self:FightEnter(argument.questId, {isWorldBossNext = true})
                        return
                    end
                elseif levelType == Constants.IDType.QuestTrail then
                    local trailBattleMgr = import('Game.TrailBattle.TrailBattleMgr'):GetInstance()
                    local enterData = trailBattleMgr:GetEnterData()
                    local questIds = enterData.quests
                    local index = table.keyof(questIds, responseData.questId)
                    local nextIndex = index + 1
                    local isUnlockNext = trailBattleMgr:IsUnlockQuest(nextIndex)
                    if isUnlockNext then
                        self:FightEnter(questIds[nextIndex], {isTrailChallengeNext = true})
                        return
                    end
                elseif levelType == Constants.IDType.QuestChaoticRecall then
                    local isWin = checkNumber(responseData.isPassed) > 0
                    local tempArgs = clone(self.args)
                    if isWin and (tempArgs.index < table.count(tempArgs.levelList)) then
                        -- showTimeCountDown = checkNumber(responseData.isPassed) > 0
                        -- countDownCallback = Bind(self, function()
                        --     tempArgs.index = tempArgs.index + 1
                        --     self:FightEnter(tempArgs.levelList[tempArgs.index],tempArgs)
                        -- end)
                        tempArgs.index = tempArgs.index + 1
                        self:FightEnter(tempArgs.levelList[tempArgs.index],tempArgs)
                        return
                    end
                elseif levelType == Constants.IDType.ClubBoss then
                    responseData.isShowClubTip = false
                    if responseData.isPassed == 0 then
                        responseData.isPassed = 1
                        responseData.isShowClubTip = true
                    end
                elseif levelType == Constants.IDType.CustomTrain then
                    responseData.isShowClubTip = false
                    if responseData.isPassed == 0 then
                        responseData.isPassed = 1
                        responseData.isShowClubTip = false
                    end
                    ---@type CustomTrainComponent 
                    local CustomTrainComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CustomTrainComponent)
                    ---@type CustomDojo
                    local customDojo = CustomTrainComponent:GetDojo()
                    ---@type CustomTrainQuestVo
                    local CustomTrainQuestVo = CfUtils.GetCfVo(AutoIds.IdSetting8945 ,"CustomTrainQuestVo" , tostring(responseData.questId))
                    local areaId = tostring(CustomTrainQuestVo.areaId)
                    customDojo.damages = customDojo.damages or {} 
                    local value = checkInt(customDojo.damages[areaId])
                    if checkInt(responseData.hurt) > value  then
                        customDojo.damages[tostring(areaId)] = checkInt(responseData.hurt)
                    end
                end

                -- 双旦关卡体力扣除
                if responseData.doubleDanHp then
                    local midFestivalComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityMidFestivalComponent)
                    local entryId = midFestivalComponent:GetActivityEnergyId()
                    GoodsUtils.DrawRewards({
                        {
                            num = checkNumber(responseData.doubleDanHp) - GoodsUtils.GetThingNo(entryId),
                            goodsId = entryId
                        }
                    })
                    ---@type ActivityMidFestivalComponent
                    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityMidFestivalComponent)
                    comp:GetHomeDojo():StartTimeDown()
                end
                
                --竹林扣除体力
                if responseData.ptQuestHp then
                    GoodsUtils.DrawRewards({
                        {
                            num = checkNumber(responseData.ptQuestHp) - GoodsUtils.GetThingNo(Constants.Currency.BambooHp),
                            goodsId = Constants.Currency.BambooHp
                        }
                    })
                    ---@type BambooMgr
                    local BambooMgr = import("Game.UI.FightReady.UIBamboo.BambooMgr")
                    BambooMgr:GetInstance():StartTimer()
                end
                
                -- 梦境奇缘关卡体力扣除
                if responseData.linkageHp then
                    local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
                    GoodsUtils.DrawRewards({
                        {
                            num = checkNumber(responseData.linkageHp) - GoodsUtils.GetThingNo(DreamAdventuresMgr:GetActivityHPId()),
                            goodsId = DreamAdventuresMgr:GetActivityHPId()
                        }
                    })
                    DreamAdventuresMgr:StartTimer()
                end
                if responseData.tinyWorldHp and levelType == Constants.IDType.ActivityWorldMiniQuestBoss then
                    ---mini world boss的情况下
                    ---@type ParkourGameMgr
                    local parkourMgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
                    GoodsUtils.DrawRewards({
                        {
                            num = checkNumber(responseData.tinyWorldHp) - GoodsUtils.GetThingNo(parkourMgr:GetActivityHPId()),
                            goodsId = parkourMgr:GetActivityHPId()
                        }
                    })
                end

                -- 检查数据更新前，歼灭战的开启状态
                local needShowAnnihilationPopup = self:NeedShowAnnihilationPopup(argument.questId, responseData.regionalBossData)

                self:BattleEndHandle(responseData.questId, responseData, args, argument, levelType)


                
                -- 更新玩家奖励
                self:UpdateRewards(responseData)
                -- 更新玩家经验
                local playerOldLevel = self:UpdatePlayerExp(responseData)
                -- 更新卡牌经验
                local cardExpInfo = self:UpdateCardExp(responseData)

                if st and checkNumber(responseData.isPassed) > 0 then
                    ChapterUtils.TriggerSpecialExit(tb)
                    return
                end
                
                _UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattleEndDialog, parameters = {
                    questId = checkNumber(argument.questId),
                    isPassed = checkNumber(responseData.isPassed),
                    --(checkBool(args.isWin) and 1 or 0)),
                    starIds = checkString(argument.starIds),
                    response = responseData,
                    callback = function()
                        if argument.callback then
                            argument.callback(clone(responseData.rewards))
                        end
                    end,
                    startable = responseData.starInfo,
                    mazeArg = { pointStr = argument.body.pointStr, pointName = argument.body.pointName },
                    playerOldLv = playerOldLevel,
                    cardExpInfo = cardExpInfo,
                    needShowAnnihilationPopup = needShowAnnihilationPopup,
                    showTimeCountDown = showTimeCountDown,
                    countDownCallback = countDownCallback,
                } })
            end
        elseif checkNumber(response.errCode) == 101 then
            -- 超时，返回登陆
            local _funcBackToLogin = function()
                if BattleViewMgr then
                    BattleViewMgr:OnDestroy()
                    BattleViewMgr = nil
                end
                GameUtils.BackToGameStart()
            end
            GameUtils.SecondConfirm(localize('游戏超时，请退出游戏重新登录'), function()
                _funcBackToLogin()
            end, function()
                _funcBackToLogin()
            end)
        else
            -- 返回到战斗外面
            local IsInChapterOP = function(pQuestId)
                -- 序章OP关卡是否未全部通关
                local IsOpenOp = AppEngine.GetConfig("Engine.Dev", "IsOpenOp")
                local curOp = QuestConfMgr:GetInstance():GetCurOpId()
                return checkNumber(IsOpenOp) > 0 and curOp ~= 0
            end
            local _functionBackToFightReady = function()
                if IsInChapterOP() then
                    if BattleViewMgr then
                        BattleViewMgr:OnDestroy()
                        BattleViewMgr = nil
                    end
                    GameUtils.BackToGameStart()
                    return
                else
                    Events.Broadcast(Constants.EventNames.UIBattlingBackToFightReady)
                    local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
                    UIBattlingCtrlMgr:GetInstance():BackToFightReadyCommon()
                end
                --if levelType == Constants.IDType.QuestWorldBoss then -- 世界 Boss
                --    UIBattlingCtrlMgr:GetInstance():BackToFightReadyCommon()
                --else
                --    UIBattlingCtrlMgr:GetInstance():BackToFightReadyCommon()
                --end
            end
            local _getDescFromQuestType = function()
                if IsInChapterOP() then
                    return localize('游戏超时，请退出游戏重新登录')
                end
                local questId = argument.questId
                local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
                if levelType == Constants.IDType.QuestTrail then
                    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
                    local trialRemainTime = checkInt(playerComponent.playerDojo.trialRemainTime)
                    if trialRemainTime <= Constants.MIN_TRIAL_CAN_ENTER then
                        return localize('试炼已结束')
                    end
                end
                return checkString(response.errMsg) .. " T_T "
            end
            xTry(function()
                if checkString(response.errMsg) == "empty request params" then
                    printError(string.format("请求参数错误: %s path: %s body: %s", checkString(response.errMsg), checkString(argument.path), table.serialize(argument.body)))
                end
            end)
            GameUtils.SecondConfirm(_getDescFromQuestType(), function()
                _functionBackToFightReady()
            end, function()
                _functionBackToFightReady()
            end)
        end

        --剧情关卡用的
        CS.Engine.Lib.KCookie.Set(Constants.UICacheDataKeys.ROLE_PLOT_CACHE_RESULT, nil)
    end)
end

--- 更新奖励
---@param responseData any
function FightPreWarMgr:UpdateRewards(responseData)
    ---更新玩家货币信息
    local rewardsTable = clone(responseData.rewards)

    --- 定向作战会将体力配在奖励里.  下面会同步一次体力, 所以这里先移除
    local levelType = GoodsUtils.GetIdType(responseData.questId, Constants.IDArea.Quests)
    if levelType == Constants.IDType.QuestDirectionalFight then
        rewardsTable = checkTable(rewardsTable)
        for i, v in pairs(rewardsTable) do
            if v.goodsId == Constants.Currency.HpId then
                table.remove(rewardsTable, i)
                break
            end
        end
    end
    
    ---关卡结算更新玩家体力
    if not isNull(responseData.hp) then
        table.insert(rewardsTable, {
            num = checkNumber(responseData.hp) - GoodsUtils.GetThingNo(Constants.Currency.HpId),
            goodsId = Constants.Currency.HpId
        })
    end
    ---更新三星奖励
    if isSet(responseData, "starReward") and table.count(responseData.starReward) > 0 then
        for i = 1, #responseData.starReward do
            table.insert(rewardsTable, {
                num = responseData.starReward[i].num,
                goodsId = responseData.starReward[i].goodsId
            })
        end
    end
    GoodsUtils.DrawRewards(rewardsTable, true)
end

--- 更新玩家经验
---@param responseData any
function FightPreWarMgr:UpdatePlayerExp(responseData)
    local playerOldLevel = 1
    local playerOldExp = 0
    if not isNull(responseData.playerLv) and not isNull(responseData.mainExp) then
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        if UIBattlingDataMgr then
            if playerComponent and playerComponent.playerDojo then
                playerOldLevel = playerComponent.playerDojo.level
                UIBattlingDataMgr:SetValuePlayExpBeforeBattleEnd(playerComponent.playerDojo.mainExp)
            end
        end
        playerOldLevel = playerComponent.playerDojo.level
        playerComponent:UpdatePlayerLvMainExp(responseData.playerLv, responseData.mainExp, nil, false) -- 这里不显示经验提示了，改成延迟打脸显示了
        playerOldExp = playerComponent:GetExpBefore()
    end
    return playerOldLevel, playerOldExp
end

--- 更新卡牌经验
---@param responseData any
function FightPreWarMgr:UpdateCardExp(responseData)
    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    local cardExpInfo = {}
    local cardExp = responseData.cardExp
    if not isNull(cardExp) and table.count(cardExp) > 0 then
        for playerCardId, expInfo in pairs(cardExp) do
            local cardInfo = cardComponent:GetCardById(playerCardId)
            cardExpInfo[playerCardId] = {oldExp = {cardExp = cardInfo.cardExp, cardLevel = cardInfo.cardLevel}}
            cardExpInfo[playerCardId].newExp = expInfo
            cardComponent:UpdateCardDojo(playerCardId, expInfo)
        end
    end
    return cardExpInfo
end

---BattleEndHandle 战斗结束各关卡数据更新处理
---@field questId string 关卡ID
---@field responseData table 服务器返回数据
---@field battleData table 战斗数据
function FightPreWarMgr:BattleEndHandle(questId, responseData, battleData, args, levelType)
    local levelType = levelType --GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    --日常副本刷新
    if levelType == Constants.IDType.QuestDaily or levelType == Constants.IDType.QuestCoinsCopy or levelType == Constants.IDType.QuestExpCopy or levelType == Constants.IDType.QuestUpStarCopy then
        local comp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.DailyQuestComponent)
        if checkBool(battleData.isWin) then
            comp:UpdateNewDailyQuestID(questId, responseData.energyPoint)  -- 更新最近关卡
            --comp:UpdateDailyQuestStarInfo(questId, responseData.starInfo)  -- 更新三星信息
            local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
            local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
            if checkNumber(questVo.costItem) == ActionUtils.GetDailyQuestTicketId() then
                local comp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.DailyQuestComponent)
                comp:ConsumeTicket()
            end
        end
        --主线关卡刷新
    elseif levelType == Constants.IDType.QuestMain or levelType == Constants.IDType.QuestMainChallenge or levelType == Constants.IDType.QuestPrologues then
        if checkBool(battleData.isWin) then
            ActionUtils.HandleMainQuestPass(questId)

            local FishingUtils = import('Game.UI.Fishing.FishingUtils')
            FishingUtils.HandleMainQuestPass(questId)
            ---@type QuestComponent
            local comp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.QuestComponent)
            comp:UpdateMainQuestInfo(questId, false)
            --comp:UpdateQuestStarInfo(questId, responseData.starInfo)  -- 更新三星信息

            -- QuestConfMgr:GetInstance():CheckUnlockInfo(Constants.CommonUnlockType.PassQuest, questId)
        else
        end
        --抽卡普通副本 角色血量为0的队员下阵
    elseif levelType == Constants.IDType.QuestGachaCoin then
        local teamComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TeamComponent)
        --如果赢了队伍直接清空
        --if checkBool(battleData.isWin) then
        --    teamComponent:ClearTeamBySystemId(Constants.SystemToggleIds.Id11)
        --else
        --    teamComponent:ChangeTeamWithBattleEnd(questId, responseData.cardsInfo)
        --end

        --不管输赢全部下阵
        teamComponent:ClearTeamBySystemId(Constants.SystemToggleIds.Id11)
        --迷宫 角色血量为0的队员下阵
    elseif levelType == Constants.IDType.QuestMaze then
        ---@type TeamComponent
        local teamComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TeamComponent)
        teamComponent:ChangeTeamWithBattleEnd(questId, responseData.cardsInfo)
    -- 海外夜巡迷宫
    elseif levelType == Constants.IDType.QuestPatrolMaze then
        local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
        local patrolMazeComp  = PatrolMazeUtils.GetComp()
        if checkBool(battleData.isWin) then
            local mazeAreaDojo = patrolMazeComp:GetHomeDojo():GetAreaDojo(args.body.areaId)
            mazeAreaDojo.tempPassedQuestData = {
                areaId  = args.body.areaId,
                floor   = args.body.floor,
                level   = args.body.level,
                questId = args.body.questId,
            }
        end
    elseif levelType == Constants.IDType.QuestSeniorEquipCopy then
        --不管同没通关都要扣血
        local equipQuestComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.EquipQuestComponent)
        local teamComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TeamComponent)
        --equipQuestComp:UpdateCardHpEngyData(responseData.cardsInfo)
        --teamComponent:ChangeTeamWithBattleEnd(questId, responseData.cardsInfo)
        if checkBool(battleData.isWin) then
            equipQuestComp:UpdateSeniorEquipQuestInfo(questId, self:GetBattleArgs().isThreeTripleMode)
        end
        --初级装备副本
    elseif levelType == Constants.IDType.QuestPrimaryEquipCopy then
        if checkBool(battleData.isWin) then
            local equipQuestComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.EquipQuestComponent)
            equipQuestComp:UpdatePrimaryEquipQuestStarInfo(questId, responseData.starInfo)
        end
        --角色剧情副本
    elseif levelType == Constants.IDType.QuestRoleStoryCopy then
        if checkBool(battleData.isWin) then
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.RoleStoryQuestComponent)
            comp:UpdateRoleQuestInfo(questId)
        end
        --爬塔副本
    elseif levelType == Constants.IDType.QuestTower then
        if checkBool(battleData.isWin) then
            ---@type TowerQuestComponent
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TowerQuestComponent)
            comp:UpdateQuestProgress(questId)
        end
        --世界boss
    elseif levelType == Constants.IDType.QuestSnowFestival then
        if checkBool(battleData.isWin) then
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.SnowFestivalComponent)
            comp:UnlockBattlePlot(questId)
        end
        --冰雪节
    elseif levelType == Constants.IDType.QuestWorldBoss then
        local jsonData = responseData
        ---@type OverseaWorldBossComponent
        local overseaWorldBossComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.OverseaWorldBossComponent)
        local worldBossInitDojo = overseaWorldBossComponent:GetWorldBossInitDojo()
        worldBossInitDojo.historyMaxHurt = math.max(checkNumber(jsonData.oldMyRankInfo.hurt), checkNumber(jsonData.newMyRankInfo.hurt))

        local hasRedPoint = worldBossInitDojo:IsCanOneKeyDraw()
        GameUtils.SetRedPointNum(Constants.RedPointConst.ABWorldBossReward, hasRedPoint and 1 or 0)
        GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.ABWorldBossReward)
    elseif levelType == Constants.IDType.QuestBambooCommon then
        local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.BambooQuestComponent)
        comp:UpdateCardHpEngyData(responseData.cardsInfo)
        if checkBool(battleData.isWin) then
            if args then
                comp:ActivityQuestMoveReq(args.bambooArg.moveMap, args.bambooArg.eventId, args.bambooArg.activityUuid)
            else
                GameUtils.Toast(localize("竹林副本参数错误"))
            end
        end
    elseif levelType == Constants.IDType.QuestBambooChanllenge then
        if checkBool(battleData.isWin) then
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.BambooQuestComponent)
            comp:UpdateChallengeQuestInfo(questId, responseData.starInfo, responseData.rewards)
        end
    elseif levelType == Constants.IDType.QuestTalent then                --天赋副本
        if checkBool(battleData.isWin) then
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TalentQuestComponent)
            comp:UpdateQuestInfo(questId)
            local teamComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TeamComponent)
            teamComponent:ChangeTeamWithBattleEnd(questId, responseData.cardsInfo)
        end
    elseif levelType == Constants.IDType.QuestNightCatTower or levelType == Constants.IDType.QuestNightCatPlot then                --天赋副本
        if checkBool(battleData.isWin) then
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.NightCatQuestComponent)
            comp:UpdateCurTowerQuestId(questId)
        end
    elseif levelType == Constants.IDType.QuestCardExperience then                --武装体验
        if checkBool(battleData.isWin) then
            GameUtils.SetRedPointNum(Constants.RedPointConst.GatherActivityQuest, 0)
        end
    elseif levelType == Constants.IDType.QuestHalloween then                --万圣节
        if checkBool(battleData.isWin) then
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.HalloweenQuestComponent)
            comp:UpdateChallengeQuestInfo(questId, responseData.starInfo)

            local vo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
            local needNum = (checkNumber(vo.costNum) + checkNumber(vo.costNumLose))
            if checkNumber(self:GetBattleArgs().isThreeTripleMode) == 1 then
                needNum = needNum * 3
            end

            GoodsUtils.DrawRewards({
                {
                    goodsId = vo.costItem,
                    num = -checkNumber(needNum),
                }
            }, true)
        else
            local vo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
            local needNum = (checkNumber(vo.costNumLose))
            if checkNumber(self:GetBattleArgs().isThreeTripleMode) == 1 then
                needNum = needNum * 3
            end

            GoodsUtils.DrawRewards({
                {
                    goodsId = vo.costItem,
                    num = -checkNumber(needNum),
                }
            }, true)
            ---@type HalloweenQuestComponent
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.HalloweenQuestComponent)
            comp:StartTimer()
        end
    elseif levelType == Constants.IDType.QuestHalloweenPlot then                --万圣节
        if checkBool(battleData.isWin) then
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.HalloweenQuestComponent)
            comp:UpdateChallengeQuestInfo(questId)
        end

    elseif levelType == Constants.IDType.QuestMapDecryptionTracking then
        if checkBool(battleData.isWin) then
            ---@type MapDecryptionComponent
            local comp = MapDecryptionMgr:GetComponent()
            comp:UpdateTrackingQuestStar(questId, responseData.starInfo)
        end
    elseif levelType == Constants.IDType.QuestRegion then
        if checkBool(battleData.isWin) then
            ---@type ActionComponent
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActionComponent)
            comp:UpdateReginQuestInfo(questId, responseData.regionalBossData, responseData.consumeActivityResidueNum)
        end
    elseif levelType == Constants.IDType.QuestMapDecryptionMap then -- 春节 2D迷宫
        if checkBool(battleData.isWin) then
            --print( "tpr --6-- 战斗胜利" )
            ---@type Maze2DStates
            local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')
            assert( not isNull( Maze2DStates.CallServerRecordMapWhenBattleWin ) )
            Maze2DStates.CallServerRecordMapWhenBattleWin()
        end
    elseif levelType == Constants.IDType.QuestAnnihilation then
        -- 应该是不会走到这里来吧
        if checkBool(battleData.isWin) then
            ---@type ActionComponent
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActionComponent)
            comp:UpdateAnnihilationQuestInfo(questId, responseData.regionalBossData)
        end
    elseif levelType == Constants.IDType.QuestMidFestivalStory then
        if checkBool(battleData.isWin) then
            ---@type ActivityMidFestivalComponent
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityMidFestivalComponent)
            comp:UpdateMainQuestId(responseData.newMainQuestId)
            KCookie.Set(Constants.WayOfOpenMidFestivalMapKey, Constants.WayOfOpenMidFestivalMap.BATTLE_OVER)
        end
    elseif levelType == Constants.IDType.QuestMidFestivalRecord then
        if checkBool(battleData.isWin) then
            -- 关卡通关后，下一个关卡有两种状态：解锁还是主线锁定，取决于主线对应的主线关卡是否已经解锁

            ---@type ActivityMidFestivalComponent
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityMidFestivalComponent)
            local homeDojo = comp:GetHomeDojo()
            local repaintQuestList = homeDojo.repaintingQuest
            local nextUnlock = false
            for _, repaintQuest in ipairs(repaintQuestList) do
                if nextUnlock then
                    if comp:IsPassMainQuest(repaintQuest.questId) then
                        comp:UpdateRepaintQuestId(repaintQuest.questId, Constants.MidFestivalRecordStatus.UNLOCK) -- 复刷关卡通关
                    end
                    break
                end
                if responseData.newRepaintingQuestId == repaintQuest.questId then
                    repaintQuest.isPassed = 1
                    nextUnlock = true
                end
            end
            --KCookie.Set(Constants.WayOfOpenMidFestivalRecordKey, Constants.WayOfOpenMidFestivalRecord.BATTLE_OVER)
        end
    elseif levelType == Constants.IDType.QuestMidFestivalBoss then
        if checkNumber(responseData.isPassed) == 1 then
            ---@type ActivityMidFestivalUtils
            local ActivityMidFestivalUtils = import("Game.Activity.MidFestival.ActivityMidFestivalUtils")
            ActivityMidFestivalUtils.GetMidFestivalMgr():UpdateBattleInfo(responseData)
        end
    elseif levelType == Constants.IDType.MournTower or levelType == Constants.IDType.MournPlot or levelType == Constants.IDType.MournBoss then
        if checkBool(battleData.isWin) then
            local ActivityMournUtils = import('Game.Activity.Mourn.ActivityMournUtils')
            ActivityMournUtils.UpdateBattleInfo(levelType, questId, battleData)
        end
    elseif levelType == Constants.IDType.BeginnerBoss then
        local BeginnerUtils = import('Game.Activity.BeginnerAssemble.BeginnerUtils')
        BeginnerUtils.UpdateBattleInfo(levelType, questId, responseData)
    elseif levelType == Constants.IDType.QuestDirectionalFight then
        if checkBool(battleData.isWin) then
            ---@type DirectionalFightComponent
            local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.DirectionalFightComponent)
            comp:SetLastPassedQuestId(responseData.questId)
        end
    elseif levelType == Constants.IDType.QuestChapterEvent then
        GameUtils.Toast(localize("事件已经解决，客人离开了餐厅"))
    elseif levelType == Constants.IDType.ClubBoss then
        ---战斗结束 移除掉这个界面  回到社团那个界面
        UIModule.RemoveDialogRecord(Constants.UITypeIds.UIClubBossChallengeDialog)
        ClubUtils.GetClubComp():BattleEndUpdate(responseData)
    elseif levelType == Constants.IDType.ActivityCakeQuest then
        ---@type  ActivityCakeUtils
        local ActivityCakeUtils = import('Game.UI.ActivityCakeShopDialog.ActivityCakeUtils')
        ActivityCakeUtils.GetActivityCakeMgr():UpdateBattleInfo(responseData)
    elseif levelType == Constants.IDType.ActivityCakeBoss then
        ---@type  ActivityCakeUtils
        local ActivityCakeUtils = import('Game.UI.ActivityCakeShopDialog.ActivityCakeUtils')
        ActivityCakeUtils.GetActivityCakeMgr():UpdateBossBattleInfo(responseData)
    elseif levelType == Constants.IDType.ClubCatCarBoss then
        ---@type OverseaClubCatCarMgr
        local OverseaClubCatCarMgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
        OverseaClubCatCarMgr.Server:BattleEnd(responseData)
    elseif levelType == Constants.IDType.QuestChaoticRecall then ---混沌回忆结算
        if checkBool(battleData.isWin) then
            local ChaoticRecallUtils = import("Game.UI.FightReady.ChaoticRecall.ChaoticRecallUtils")
            local questVo = ChaoticRecallUtils.GetChaoticRecallLevelVo(responseData.questId)
            ChaoticRecallUtils.GetChaoticRecallMgr():SaveCurLevelNodeId(questVo.nodeId,responseData.questId)
            ChaoticRecallUtils.GetChaoticRecallMgr():SavePreReward(responseData.previewRewards)
        end
    elseif levelType == Constants.IDType.DreamAdventuresPlot then
        local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
        if checkBool(battleData.isWin) then
            DreamAdventuresMgr:SetMainQuestId(responseData.newMainQuestId)
        end
    elseif levelType == Constants.IDType.DreamAdventuresLuby then
        local DreamAdventuresMgr = import("Game.Activity.DreamAdventures.DreamAdventuresMgr"):GetInstance()
        if checkBool(battleData.isWin) then
            DreamAdventuresMgr:SetRupeeEvent(responseData.rupeeEvent)
        end
    elseif levelType == Constants.IDType.ActivityCrisis then
        ---战斗结束 移除掉这个界面  回到活动主界面 如果有任务奖励  要回到任务界面
        if checkBool(battleData.isWin) then
            UIModule.RemoveDialogRecord(Constants.UITypeIds.ActivityCrisisContractLevelListDialog)
        end
        local ActivityCrisisUtils = import('Game.Activity.CrisisContract.ActivityCrisisUtils')
        ActivityCrisisUtils.GetActivityCrisisMgr():BattleEndUpdate(responseData)
    elseif levelType == Constants.IDType.JapaneseStoryPlot then
        local JapaneseStoryMgr = import("Game.Activity.JapaneseStory.JapaneseStoryMgr"):GetInstance()
        if checkBool(battleData.isWin) then
            JapaneseStoryMgr:SetMainQuestId(responseData.newMainQuestId)
        end
    elseif levelType == Constants.IDType.ActivityWorldMiniQuest then
        print("跑酷 战斗: " .. (battleData.isWin==true and "胜利" or "失败" ) )
        if checkBool(battleData.isWin) then
            ---@type ParkourGameMgr
            local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
            if isNotNull(Mgr.battleEndCB) then
                Mgr.battleEndCB()
            end
        end
    end

    --如果战斗胜利更新信息
    if checkBool(battleData.isWin) then
        --跟在关卡信息刷新完之后
        self:UpdateUnlockData()
    end
end

---UpdateUnlockData 需要解锁的数据层刷新F
function FightPreWarMgr:UpdateUnlockData()
    --更新委托队列解锁数据
    local teamComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TeamComponent)
    teamComponent:UpdateEntrustRequeueData()
end


---GetFightEnterArgs 获取不同的战斗进入参数
---@field questId string 关卡ID
---@field args table 其他参数
function FightPreWarMgr:GetFightEnterArgs(questId, args)
    args = checkTable(args)

    local battleEnterReqId      --战斗请求id
    local battleEnterReqBody    --请求数据
    local battleEndReqId        --战斗结束请求id
    local battleEndReqBody      --结束请求数据
    local battleEndCb           --战斗结束回调/默认为返回主场景

    --关卡类型
    local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)

    printInfo( "levelType = " .. tostring(levelType) )

    if levelType == Constants.IDType.QuestMain or levelType == Constants.IDType.QuestPrologues then
        battleEnterReqId = Interfaces.FightEnter
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.FightBonus
    elseif levelType == Constants.IDType.QuestMainChallenge then
        battleEnterReqId = Interfaces.mainQuestDifficultAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.mainQuestDifficultGrade
    elseif levelType == Constants.IDType.QuestPrologues then

        battleEndReqId = Interfaces.QuestGrade
        battleEndReqBody = { questId = questId }
    elseif levelType == Constants.IDType.QuestDaily or levelType == Constants.IDType.QuestCoinsCopy or levelType == Constants.IDType.QuestExpCopy or levelType == Constants.IDType.QuestUpStarCopy then
        battleEnterReqId = Interfaces.OverseaRegionalMapDailyQuestAt
        battleEnterReqBody = { questId = questId, isThreeTripleMode = args.isThreeTripleMode }
        battleEndReqId = Interfaces.OverseaRegionalMapDailyQuestGrade
    elseif levelType == Constants.IDType.QuestMaze then
        battleEnterReqId = Interfaces.MazeMoveToBattle
        battleEnterReqBody = { position = args.point }
        battleEndReqId = Interfaces.MazeBattleGrade
        local MazeMgr = import('Game.Maze.MazeMgr')
        local pointStr, pointName = MazeMgr:GetInstance():GetCurPointAndName()
        battleEndReqBody = { pointStr = pointStr, pointName = pointName }
        --battleEndCb = function()
        --    local MazeMgr = import('Game.Maze.MazeMgr')
        --    MazeMgr:GetInstance():EnterMaze()
        --end
    elseif levelType == Constants.IDType.QuestPatrolMaze then
        battleEnterReqId   = Interfaces.OverseaMazeQuestAt
        battleEnterReqBody = { areaId = args.areaId, floor = args.floor, level = args.level, questId = args.questId }
        battleEndReqId     = Interfaces.OverseaMazeQuestGrade
        battleEndReqBody   = { areaId = args.areaId, floor = args.floor, level = args.level, questId = args.questId }
    elseif levelType == Constants.IDType.QuestGachaCoin then
        battleEnterReqId = Interfaces.CallCopyAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.CallCopyGrade
    elseif levelType == Constants.IDType.QuestGachaCoinChallenge then
        battleEnterReqId = Interfaces.CallCopyChallengeAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.CallCopyChallengeGrade
    elseif levelType == Constants.IDType.QuestTrail then
        battleEnterReqId = Interfaces.TrailQuestAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.TrailQuestGrade
    elseif levelType == Constants.IDType.QuestPrimaryEquipCopy then
        battleEnterReqId = Interfaces.EquipmentQuestAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.EquipmentQuestGrade
    elseif levelType == Constants.IDType.QuestSeniorEquipCopy then
        battleEnterReqId = Interfaces.EquipmentQuestSeniorEquipmentAt
        battleEnterReqBody = { questId = questId, isThreeTripleMode = args.isThreeTripleMode }
        battleEndReqId = Interfaces.EquipmentQuestSeniorEquipmentGrade
    elseif levelType == Constants.IDType.QuestRoleStoryCopy then
        battleEnterReqId = Interfaces.CatQuestAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.CatQuestGrade
    elseif levelType == Constants.IDType.QuestBeginnerEvent then
        battleEnterReqId = Interfaces.RookieTrainQuestAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.RookieTrainGrade
    elseif levelType == Constants.IDType.QuestTower then
        local OverseaTowerUtils = import('Game.UI.FightReady.OverseaTower.OverseaTowerUtils')
        local vo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
        if checkNumber(vo.type) == Constants.TowerType.Main then
            battleEnterReqId = Interfaces.OverseaClimbingTowerAt
            battleEnterReqBody = { questId = questId }
            battleEndReqId = Interfaces.OverseaClimbingTowerGrade
        else
            battleEnterReqId = Interfaces.OverseaClimbingTowerMoodAt
            battleEnterReqBody = { questId = questId }
            battleEndReqId = Interfaces.OverseaClimbingTowerMoodGrade
        end
    elseif levelType == Constants.IDType.QuestWorldBoss then
        battleEnterReqId = Interfaces.WorldBossAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.WorldBossGrade
    elseif levelType == Constants.IDType.QuestBambooCommon then
        battleEnterReqId = Interfaces.ActivityQuestAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid}
        battleEndReqId = Interfaces.ActivityQuestGrade
        battleEndReqBody = { activityUuid = args.activityUuid, moveMap = args.moveMap, eventId = args.eventId }
    elseif levelType == Constants.IDType.QuestBambooChanllenge then
        battleEnterReqId = Interfaces.ActivityQuestChallengeAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid, isThreeTripleMode = args.isThreeTripleMode }
        battleEndReqId = Interfaces.ActivityQuestChallengeGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestDirectionalFight then
        battleEnterReqId = Interfaces.TimedCopyAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.TimedCopyGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestTrainField then
        battleEnterReqId = Interfaces.WoodenDummyAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.WoodenDummyGrade
    elseif levelType == Constants.IDType.QuestForging then
        battleEnterReqId = Interfaces.MakeCallAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.MakeCallGrade
    elseif levelType == Constants.IDType.QuestTalent then
        battleEnterReqId = Interfaces.TalentQuestAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.TalentQuestGrade
    elseif levelType == Constants.IDType.QuestMediumPT then
        battleEnterReqId = Interfaces.ActivityPlotQuestAt
        battleEnterReqBody = { questId = questId, isThreeTripleMode = args.isThreeTripleMode, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.ActivityPlotQuestGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestNightCatTower then
        battleEnterReqId = Interfaces.ActivityNightCatClimbingTowerAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.ActivityNightCatClimbingTowerGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestNightCatBoss then
        battleEnterReqId = Interfaces.ActivityNightCatBossAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.ActivityNightCatBossGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestNightCatPlot then
        battleEnterReqId = Interfaces.ActivityNightCatQuestAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.ActivityNightCatQuestGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestCardExperience then
        battleEnterReqId = Interfaces.ActivityCardExperienceAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.ActivityCardExperienceGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.ActivityQuestSkinExperience then
        battleEnterReqId = "activity2/skinCardExperienceAt"
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = "activity2/skinCardExperienceGrade"
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestAdvancedTraining then
        battleEnterReqId = Interfaces.SeniorDungeonAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.SeniorDungeonGrade
    elseif levelType == Constants.IDType.QuestBossChallenge then
        battleEnterReqId = Interfaces.ActivityBossChallengeAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid, scheduleId = args.scheduleId }
        battleEndReqId = Interfaces.ActivityBossChallengeGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestSnowFestival then
        battleEnterReqId = Interfaces.ActivityIceSnowFestivalAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.ActivityIceSnowFestivalGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestHalloween then
        battleEnterReqId = Interfaces.ActivityGashaponQuestChallengeAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid, isThreeTripleMode = args.isThreeTripleMode }
        battleEndReqId = Interfaces.ActivityGashaponQuestChallengeGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestHalloweenPlot then
        battleEnterReqId = Interfaces.ActivityGashaponQuestAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.ActivityGashaponQuestGrade
        battleEndReqBody = { activityUuid = args.activityUuid }

    elseif levelType == Constants.IDType.QuestMapDecryptionMap then -- 新年活动 战斗事件关卡
        battleEnterReqId = Interfaces.ActivityMapDecryptionAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid, isThreeTripleMode = args.isThreeTripleMode }
        battleEndReqId = Interfaces.ActivityMapDecryptionGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestMapDecryptionTracking then -- 新年活动 追踪关卡
        battleEnterReqId = Interfaces.ActivityMapDecryptionChallengeAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid, isThreeTripleMode = args.isThreeTripleMode }
        battleEndReqId = Interfaces.ActivityMapDecryptionChallengeGrade
        battleEndReqBody = { activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestAnnihilation then -- 歼灭战

    elseif levelType == Constants.IDType.QuestRegion then -- 区域地图关卡
        battleEnterReqId = Interfaces.OverseaRegionalAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.OverseaRegionalGrade
    elseif levelType == Constants.IDType.QuestChapterEvent then
        battleEnterReqId = Interfaces.MaidCoffeeGuestEnterFight
        battleEnterReqBody = { questId = questId, visitorId = self.fightTeamArgs.visitorId,eventId = self.fightTeamArgs.eventId,storyId = self.fightTeamArgs.storyId }
        battleEndReqId = Interfaces.MaidCoffeeGuestEnterFightEnd
    elseif levelType == Constants.IDType.ClubBoss then
        battleEnterReqId = Interfaces.OverseaClubEnterBoss
        battleEnterReqBody = { questId = questId}
        battleEndReqId = Interfaces.OverseaClubBossGrade
    elseif levelType == Constants.IDType.QuestMidFestivalStory then
        battleEnterReqId = Interfaces.OverseaMidFestivalMainQuestFight
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.OverseaMidFestivalMainQuestGrade
        battleEndReqBody = { questId = questId, activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestMidFestivalRecord then
        battleEnterReqId = Interfaces.OverseaMidFestivalRepaintAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.OverseaMidFestivalRepaintGrade
        battleEndReqBody = { questId = questId, activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestMidFestivalBoss then
        battleEnterReqId = Interfaces.OverseaMidFestivalBossAt
        local times = checkInt(KCookie.Get(string.format("COMMON_BOSS_CONSUME_%s",self.fightTeamArgs.activityUuid)))
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid, times = times }
        battleEndReqId = Interfaces.OverseaMidFestivalBossGrade
        battleEndReqBody = { questId = questId, activityUuid = args.activityUuid, times = times }
    elseif levelType == Constants.IDType.MournBoss then
        battleEnterReqId = Interfaces.ActivityTowerChangeTowerBossAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.ActivityTowerChangeTowerBossGrade
        battleEndReqBody = { questId = questId, activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.MournTower then
        battleEnterReqId = Interfaces.ActivityTowerChangeTowerAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.ActivityTowerChangeTowerGrade
        battleEndReqBody = { questId = questId, activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.MournPlot then
        battleEnterReqId = Interfaces.ActivityTowerChangeBattleAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.ActivityTowerChangeBattleGrade
        battleEndReqBody = { questId = questId, activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.QuestChaoticRecall then
        battleEnterReqId = Interfaces.OverseaNightmareEnterFight
        battleEnterReqBody = { questId = questId, nodeId = args.nodeId, groupId = args.groupId,type = args.hardType}
        battleEndReqId = Interfaces.OverseaNightmareGrade
    elseif levelType == Constants.IDType.DreamAdventuresPlot then
        battleEnterReqId = Interfaces.DreamAdventuresQuestAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.DreamAdventuresQuestGrade
        battleEndReqBody = { questId = questId, activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.DreamAdventuresLuby then
        battleEnterReqId = Interfaces.DreamAdventuresRupeeQuestAt
        battleEnterReqBody = { questId = questId, eventId = self.fightTeamArgs.eventId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.DreamAdventuresRupeeQuestGrade
        battleEndReqBody = { questId = questId, eventId = self.fightTeamArgs.eventId, activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.ActivityCakeQuest then
        battleEnterReqId = Interfaces.OverseaActivityCatParadiseAt
        battleEnterReqBody = { questId = questId, activityUuid = self.fightTeamArgs.activityUuid }
        battleEndReqId = Interfaces.OverseaActivityCatParadiseGrade
        battleEndReqBody = { questId = questId, activityUuid = self.fightTeamArgs.activityUuid }
    elseif levelType == Constants.IDType.ActivityCakeBoss then
        battleEnterReqId = Interfaces.OverseaActivityCatParadiseBossAt
        local times = checkInt(KCookie.Get(string.format("COMMON_BOSS_CONSUME_%s",self.fightTeamArgs.activityUuid)))
        battleEnterReqBody = { questId = questId, activityUuid = self.fightTeamArgs.activityUuid, times = times}
        battleEndReqId = Interfaces.OverseaActivityCatParadiseBossGrade
        battleEndReqBody = { questId = questId, activityUuid = self.fightTeamArgs.activityUuid, times = times }
    elseif levelType == Constants.IDType.ClubCatCarBoss then
        battleEnterReqId = Interfaces.OverseaClubCatCarBossAt
        battleEnterReqBody = { questId = questId }
        battleEndReqId = Interfaces.OverseaClubBossGrade
    elseif levelType == Constants.IDType.ActivityCrisis then
        battleEnterReqId = Interfaces.ActivityStrangeTaleAt
        battleEnterReqBody = { questId = questId, activityUuid = self.fightTeamArgs.activityUuid, buffGroups = self.fightTeamArgs.buffGroups}
        battleEndReqId = Interfaces.ActivityStrangeTaleGrade
        battleEndReqBody = { questId = questId, activityUuid = self.fightTeamArgs.activityUuid }
    elseif levelType == Constants.IDType.ActivityWorldMiniQuestBoss then
        battleEnterReqId = "activityTinyWorld/bossAt"
        --KCookie.Set("MINI_BOSS_CONSUME", checkInt(self.times))
        local times = checkInt(KCookie.Get("MINI_BOSS_CONSUME"))
        battleEnterReqBody = { questId = questId, activityUuid = self.fightTeamArgs.activityUuid, times = times}
        battleEndReqId = "activityTinyWorld/bossGrade"
        battleEndReqBody = { questId = questId, activityUuid = self.fightTeamArgs.activityUuid, times = times}
    elseif levelType == Constants.IDType.ActivityWorldMiniQuest then
        battleEnterReqId = "activityTinyWorld/at"
        battleEnterReqBody = { questId = questId, activityUuid = self.fightTeamArgs.activityUuid}
        battleEndReqId = "activityTinyWorld/grade"
        battleEndReqBody = { questId = questId, activityUuid = self.fightTeamArgs.activityUuid }

        -- battleEndCb = function()
        --     local endCB = self:GetFightTeamArgs().endCB
        --     if isNotNull(endCB) then 
        --         printError("endcb")
        --         endCB()
        --     end 
        --     self:FightEndOpenUI()
        -- end
    elseif levelType == Constants.IDType.JapaneseStoryPlot then
        battleEnterReqId = Interfaces.JapaneseStoryQuestAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid }
        battleEndReqId = Interfaces.JapaneseStoryQuestGrade
        battleEndReqBody = { questId = questId, activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.JapaneseStoryBoss then
        battleEnterReqId = Interfaces.JapaneseStoryBossAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid}
        battleEndReqId = Interfaces.JapaneseStoryBossGrade
        battleEndReqBody = { questId = questId, activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.CustomTrain then
        battleEnterReqId = Interfaces.CustomizedTrainingAt
        battleEnterReqBody = { questId = questId, activityUuid = args.activityUuid}
        battleEndReqId = Interfaces.CustomizedTrainingGrade
        battleEndReqBody = { questId = questId, activityUuid = args.activityUuid }
    elseif levelType == Constants.IDType.BeginnerBoss then
        battleEnterReqId = Interfaces.ActivityBeginnerBossAt
        battleEnterReqBody = { questId = questId}
        battleEndReqId = Interfaces.ActivityBeginnerBossGrade
        battleEndReqBody = { questId = questId}
    end
    
    if not battleEnterReqBody then
        battleEnterReqBody = {}
    end
    if not battleEndReqBody then
        battleEndReqBody = {}
    end

    --默认为返回主场景
    if not battleEndCb then
        battleEndCb = self.FightEndOpenUI
    end

    return battleEnterReqId, battleEnterReqBody, battleEndReqId, battleEndReqBody, battleEndCb
end

---GetFightEndArgs 获取战斗结束的参数
---@field args table 战斗结果
function FightPreWarMgr:GetFightEndArgs(args)
    --打开战斗场景参数
    local argument = _UIModule.CurrentScreen.Argument.parameters
    argument = checkTable(argument)
    local battleBeforeArgs = clone(argument.body)

    --print("argument:", table.dump(argument))
    
    local questId
    local data = self:GetFightData()
    if data then
        data = data.battleData
        if data then
            questId = data.questId
        end
    else
        printError("战斗数据为空")
    end
    if not questId then
        questId = argument.questId
    end
    print("___BattleEndArgs:", table.dump(args))

    local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)     --关卡类型
    local isPassed = (checkBool(args.isWin) and 1 or 0)
    local questBattleData = checkString(args.recordData)
    argument.body = { isPassed = isPassed, questBattleData = questBattleData }
    argument.isRecord = checkNumber(args.isRecord)
    argument.questId = checkNumber(questId)

    if levelType == Constants.IDType.QuestMaze then
        -- 迷宫
        argument.body.energyData = args.energyData
        argument.body.healthData = args.healthData
    elseif levelType == Constants.IDType.QuestPatrolMaze then
        -- 海外夜巡迷宫
        argument.body.energyData = args.energyData
        argument.body.healthData = args.healthData
        if battleBeforeArgs then
            argument.body.areaId  = battleBeforeArgs.areaId
            argument.body.floor   = battleBeforeArgs.floor
            argument.body.level   = battleBeforeArgs.level
            argument.body.questId = battleBeforeArgs.questId
        end
    elseif levelType == Constants.IDType.QuestGachaCoin or
            levelType == Constants.IDType.QuestGachaCoinChallenge then
        -- 假想实战
        argument.body.energyData = args.energyData
        argument.body.healthData = args.healthData
    elseif levelType == Constants.IDType.QuestTrail then
        --- 试炼
        local strengthNo = 0
        local t = {}
        if argument.body.cardIds then
            ---@type CardComponent
            local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
            local cardIds = parse_strings(argument.body.cardIds, ",")
            if isTable(cardIds) then
                for i, playerCardId in pairs(cardIds) do
                    local cardDojo = cardComponent:GetCardById(playerCardId)
                    if cardDojo then
                        strengthNo = strengthNo + FormulaUtils.GetCardFightingStrengthen(cardDojo)
                    end
                end
            end
            table.insert(t, string.format('101=%d', strengthNo))
        end
        table.insert(t, string.format('151=%d', checkInt(args.totalUsedSp)))
        table.insert(t, string.format('111=%d', checkInt(args.totalUsedCard[1])))
        --- 1星使用次数
        table.insert(t, string.format('121=%d', checkInt(args.totalUsedCard[2])))
        ---2星使用次数
        table.insert(t, string.format('131=%d', checkInt(args.totalUsedCard[3])))
        table.insert(t, string.format('120=%d', checkInt(args.totalUnitedCard[2])))
        ---合成使用的2星
        table.insert(t, string.format('130=%d', checkInt(args.totalUnitedCard[3])))
        ---合成使用的3星 次数
        table.insert(t, string.format('102=%d', checkInt(args.totalGiveDamage)))
        ---总伤害
        local healthData = parse_strings(args.healthData, '&')
        local serverData = self:GetFightData()
        local playerTeam = checkTable(serverData.battleData.playerTeam)
        local function isPlayerTeam(id)
            local isInPlayerTeam = 0
            local cardDojo = nil
            for _, v in pairs(playerTeam) do
                if checkInt(v.id) == checkInt(id) then
                    isInPlayerTeam = 1
                    cardDojo = v
                    break
                end
            end
            return isInPlayerTeam, cardDojo
        end
        local health = 0
        local percent = 0
        for _, v in pairs(healthData) do
            local pv = parse_strings(v, '=')
            local id, num = pv[1], pv[2]
            local isIn, cardDojo = isPlayerTeam(id)
            if isIn == 1 then
                percent = percent + FormulaUtils.GetCardFightingStrengthen(cardDojo) * checkNumber(num) / checkNumber(cardDojo.currentHp)
                health = health + checkNumber(num)
            end
        end
        table.insert(t, string.format('104=%s', checkString(health)))
        ---血量
        table.insert(t, string.format('103=%s', checkString(percent)))---百分比

        argument.body.action = table.concat(t, '&')
        --高级装备副本
    elseif levelType == Constants.IDType.QuestSeniorEquipCopy then
        argument.body.energyData = args.energyData
        argument.body.healthData = args.healthData
    elseif levelType == Constants.IDType.QuestWorldBoss then
        --世界boss
        argument.path = Interfaces.WorldBossGrade
        --[[
        argument.callback = function()
            --清掉当前所有的ui
            local dialogs = CS.Engine.UI.UIModule.CurrentScreen.dialogs
            for i, dialog in pairs(dialogs) do
                CS.Engine.UI.UIModule.CloseDialog(dialog)
            end
            local WorldBossMgr = import('Game.UI.FightReady.UIWorldBoss.WorldBossMgr')
            WorldBossMgr:GetInstance():InitBossModel()

            BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
            BattleViewMgr:OnDestroy()

            CS.Engine.UI.UIModule.OpenDialog({ id = Constants.UITypeIds.UIWorldBossMainDialog }, {
            })
        end
        ]]
    elseif levelType == Constants.IDType.QuestBambooCommon then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
            argument.body.energyData = args.energyData
            argument.body.healthData = args.healthData
            argument.bambooArg = {
                moveMap = battleBeforeArgs.moveMap,
                eventId = battleBeforeArgs.eventId,
                activityUuid = battleBeforeArgs.activityUuid
            }
        end
    elseif levelType == Constants.IDType.QuestBambooChanllenge then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestMediumPT then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestDirectionalFight then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestCardExperience or levelType == Constants.IDType.ActivityQuestSkinExperience then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestSnowFestival then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestArena then
        argument.callback = self.FightEndOpenUI
    elseif levelType == Constants.IDType.QuestTalent then                --天赋副本
        argument.body.energyData = args.energyData
        argument.body.healthData = args.healthData
    elseif levelType == Constants.IDType.QuestPrologues then
        --argument = {questId = questId, isPassed = isPassed, }
        --argument.path = argument.path
        argument.body.questId = questId
    elseif levelType == Constants.IDType.QuestNightCatTower or levelType == Constants.IDType.QuestNightCatBoss then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestNightCatPlot then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestRoleStoryCopy then
        if isPassed == 1 then --胜利
            local t = CS.Engine.Lib.KCookie.Get(Constants.UICacheDataKeys.ROLE_PLOT_CACHE_RESULT)
            if not isNull(t) then
                local mood, str = 0, ""
                for k, v in pairs(t) do
                    mood = mood + checkNumber(v.Mood)
                    if k > 1 then
                        str = str..","
                    end
                    str = str..checkString(v.Options)
                end
                argument.body.mood = mood
                argument.body.plotIds = str
            end
        end
    elseif levelType == Constants.IDType.QuestHalloween then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestHalloweenPlot then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestBossChallenge then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestMapDecryptionMap or levelType == Constants.IDType.QuestMapDecryptionTracking then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.QuestChapterEvent then
        argument.path = Interfaces.MaidCoffeeGuestEnterFightEnd
        argument.callback = self.FightEndOpenUI
    elseif levelType == Constants.IDType.QuestMidFestivalStory then
        argument.path = Interfaces.OverseaMidFestivalMainQuestGrade
        argument.body.activityUuid = battleBeforeArgs.activityUuid
    elseif levelType == Constants.IDType.QuestMidFestivalRecord then
        argument.path = Interfaces.OverseaMidFestivalRepaintGrade
        argument.body.activityUuid = battleBeforeArgs.activityUuid
    elseif levelType == Constants.IDType.QuestMidFestivalBoss then
        argument.path = Interfaces.OverseaMidFestivalBossGrade
        argument.body.activityUuid = battleBeforeArgs.activityUuid
    elseif levelType == Constants.IDType.MournBoss then
        argument.path = Interfaces.ActivityTowerChangeTowerBossGrade
        argument.body.activityUuid = battleBeforeArgs.activityUuid
    elseif levelType == Constants.IDType.MournTower then
        argument.path = Interfaces.ActivityTowerChangeTowerGrade
        argument.body.activityUuid = battleBeforeArgs.activityUuid
    elseif levelType == Constants.IDType.MournPlot then
        argument.path = Interfaces.ActivityTowerChangeBattleGrade
        argument.body.activityUuid = battleBeforeArgs.activityUuid
    elseif levelType == Constants.IDType.DreamAdventuresPlot then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.DreamAdventuresLuby then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
            argument.body.eventId = battleBeforeArgs.eventId
        end
    elseif levelType == Constants.IDType.ActivityCakeBoss then
        if battleBeforeArgs then
            argument.path = Interfaces.OverseaActivityCatParadiseBossGrade
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.ActivityCakeQuest then
        if battleBeforeArgs then
            argument.path = Interfaces.OverseaActivityCatParadiseGrade
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.ActivityCrisis then
        if battleBeforeArgs then
            argument.path = Interfaces.ActivityStrangeTaleGrade
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.ActivityWorldMiniQuestBoss then
        if battleBeforeArgs then
            argument.path = "activityTinyWorld/bossGrade"
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.ActivityWorldMiniQuest then
        if battleBeforeArgs then
            argument.path = "activityTinyWorld/grade"
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.ClubCatCarBoss then
        if battleBeforeArgs then
            argument.path = Interfaces.OverseaClubCatCarBossGrade
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.JapaneseStoryPlot then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.JapaneseStoryBoss then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    elseif levelType == Constants.IDType.CustomTrain then
        if battleBeforeArgs then
            argument.body.activityUuid = battleBeforeArgs.activityUuid
        end
    end
    return argument
end

-- 战斗结算切场景
function FightPreWarMgr:FightEndOpenUI()
    -- 是否通关过的
    GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome }, nil, Constants.LoadingType.MainHome)
end

---编队跳转到养成  
function FightPreWarMgr:ShowPreUI(isshow)
    local uiname = { "FightMap", "FightReady", "FightChoose" }
    for i, v in pairs(_UIModule.CurrentScreen.dialogs) do
        for m, n in pairs(uiname) do
            if n == v.name then
                if n == "FightMap" then
                    v.Env:SetMapScene(isshow)
                end
                _KTool.SetActive(v.gameObject, isshow)
            end
        end
    end
end

function FightPreWarMgr:PVPBattleDataHandle(pvpMode, args)
    local battleNext = false
    if pvpMode == Constants.PVPMode.Arena then
        ---@type PVPArenaComponent
        local pvpArenaComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PVPArenaComponent)
        ---@type PVPArenaPlayerReadyDialog
        local loadingEnv = pvpArenaComponent:GetPVPArenaLoadingEnv()
        if not isNull(loadingEnv) then
            battleNext = loadingEnv:UpdateBattleRoundData(args)
        end
    end
    return battleNext
end

function FightPreWarMgr:GetFightTeamArgs()
    return checkTable(self.fightTeamArgs)
end

function FightPreWarMgr:SetFightTeamArgs(args)
    self.fightTeamArgs = checkTable(args)
end

--- 检查是否需要显示歼灭战打脸图
function FightPreWarMgr:NeedShowAnnihilationPopup(questId, newRegionalBossData)
    if isNull(newRegionalBossData) then return end
    local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
    if not questVo then
        return false
    end
    local vo = ActionUtils.GetRegionSecondaryMapVo(questVo.pointID)
    if not vo then
        return false
    end
    local beforeState = ActionUtils.IsOpenAnnihilation(vo.regionBelong)
    local afterState = newRegionalBossData.state == 1
    return (not beforeState) and afterState
end

--- 获取编队战力（排除机器人）
---@param initData any
function FightPreWarMgr:GetMyPlayerTotalPower(initData)
    local totalPower = 0
    local playerTeam = initData.playerTeam[1]
    for i, playerInfo in ipairs(playerTeam) do
        if checkNumber(playerInfo.playerCardId) > 0 then
            totalPower = totalPower + checkNumber(playerInfo.combatValue)
        end
    end
    return totalPower
end

---SetFightEndPreHandle
---设置战斗结束预处理方法 提供给 战斗返回到上一场景时启用
function FightPreWarMgr:SetFightEndPreHandle(cb)
    self._fightEndPreHandle = cb
end
---GetFightEndPreHandle
---设置战斗结束预处理方法 提供给 战斗返回到上一场景时启用
function FightPreWarMgr:GetFightEndPreHandle()
    return self._fightEndPreHandle
end

return FightPreWarMgr
