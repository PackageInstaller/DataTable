---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
---@type ParkourGameUtil
local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")
local ResourceModule = CS.Engine.Modules.ResourceModule
local ChapterUtils = import('Game.Chapter.ChapterUtils')


--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程
local UIModule = CS.Engine.UI.UIModule

local GameUtils = import('Game.Utils.GameUtils')
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Random = CS.UnityEngine.Random
local Canvas = CS.UnityEngine.Canvas
local Physics = CS.UnityEngine.Physics
local KTool = CS.Engine.Lib.KTool


local Parkour_Loader = import('Game.Activity.ParkourGame.Parkour_Loader')


--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourMainlineDialog12001801.prefab > name: OverseaParkourMainlineDialog12001801
---@class OverseaParkourMainlineDialog
---@field Env                           	OverseaParkourMainlineDialog            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ScrollView                    	SuperScrollView.LoopListView2           	@ 0    一组气泡
---@field BtnArrowL                     	UnityEngine.RectTransform               	@ 1    
---@field BtnArrowR                     	UnityEngine.RectTransform               	@ 2    
---@field BtnRank                       	UnityEngine.RectTransform               	@ 3    "排行榜"
---@field BtnParkour                    	UnityEngine.RectTransform               	@ 4    "自由探索"
local OverseaParkourMainlineDialog = Class("OverseaParkourMainlineDialog")


function OverseaParkourMainlineDialog:__init()
    self.controller = nil
    self.prex = nil -- init is nil
    self.itemCount = 0
    self.levelDatas = nil
    self.isFocus = false
end

function OverseaParkourMainlineDialog:__delete()
    self.controller = nil
end


function OverseaParkourMainlineDialog:Awake()
    --printError("OverseaParkourMainlineDialog : Awake")

    -- todo: 无限模式暂未实现, 先关闭相关按钮
    CfUtils.SetActive( self.BtnRank.gameObject, false )
    CfUtils.SetActive( self.BtnParkour.gameObject, false )

    SetButtonAction(self.BtnArrowL, Bind(self, self.OnClickArrowL))
    SetButtonAction(self.BtnArrowR, Bind(self, self.OnClickArrowR))
    SetButtonAction(self.BtnRank, Bind(self, self.OnClickRank))
    
    self.EventNavigatorBack = Events.AddListener(Constants.EventNames.EventUINavigatorBackBar, Bind(self, self.OnNavigatorBack))
    
    --self.ScrollView.mOnDragingAction = function()
    --    Events.Broadcast(ParkourGameUtil.Events.SelectLevelDraging)
    --end
    self.scrollRect = self.ScrollView:GetComponent("ScrollRect")
    self.scrollRect.onValueChanged:AddListener(Bind(self, self.OnScrollValueChanged))
end


function OverseaParkourMainlineDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        --printError("OnInitialize")

        self.isFocus = true
        Physics.autoSimulation = false

        ---@type ParkourInput
        local parkourInput = import("Game.Activity.ParkourGame.MainGame.ParkourInput"):GetInstance()
        parkourInput:Reset()

        local parkour_Loader = Parkour_Loader.GetInstance()
        self.selectLevelGo = parkour_Loader:TryInstanceGO("gameSelect")
        assert( self.selectLevelGo )

        local PlayerRootTF = self.selectLevelGo.transform:Find("Track3/PlayerRoot")
        local roleTF, roleEnv = parkour_Loader:InstanceRole( PlayerRootTF )
        roleTF.localPosition = Vector3( -5.4, -2.5, 0 ) -- !! 手写初始位置
        roleEnv:Init()
        Mgr.player = roleEnv

        -- =================================
        -- 不管从任何地方进入 选关界面, 都强行调用 home 接口; 以确保数据一定是最新的;
        local homeRet = {}
        cs_coroutine.yield_return( ParkourGameUtil.CallHome(Mgr.activityUuid, homeRet ) )
        Mgr:SetHomeDojoData(homeRet.responseData)
        self:RefreshUI()

        self:SetCurrentBubbleToCenter()

        --- 界面右上角两个道具:
        self.topGoods = { Constants.Currency.MiniWorldConsume, Constants.Currency.MiniWorldHp }
        if self.topGoods then
            CfUtils.RefreshTopGoods(self.topGoods)
        end

        -- =================================
        
        coroutine.yield(Yielders.EndOfFrame)
        Events.Broadcast(ParkourGameUtil.Events.SelectUIInitDone, nil)

        -- "重玩跑酷关卡" 功能: 从跑酷关卡退回到 选关页面, 然后再自动进入这一关;
        if Mgr.isBackFromMainDialogForResume == true then 
            CoStop(self.co_resume)
            self.co_resume = CoStart(function()
                -- coroutine.yield(Yielders.EndOfFrame)
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.5 )) --  !!! 这里有待完善

                UIModule.OpenDialog(
                    { 
                        id = Constants.UITypeIds.ParkourGameMainDialog, 
                        parameters = 
                        {
                            levelId = Mgr.currentLevelId,
                            gameType = ParkourGameUtil.GameType.Normal
                        }
                    },
                    { {id = Constants.UITypeIds.OverseaParkourMainlineDialog } }
                )
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 1 ))
            end)
        end 

        self:_DrawRewards() -- 没被用到
        ---
    end))
    return coWait
end



function OverseaParkourMainlineDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        print("!!!!!! 离开 跑酷 选关 UI 界面 !!!!!! ")

        CoStop(self.co_1)
        CoStop(self.co_2)
        CoStop(self.co_plot)
        CoStop(self.co_resume)

        if isNotNull(self.selectLevelGo) then
            GameObject.Destroy(self.selectLevelGo)
        end
        if self.EventNavigatorBack then
            Events.RemoveListener(Constants.EventNames.EventUINavigatorBackBar, self.EventNavigatorBack)
        end
        ---
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end


function OverseaParkourMainlineDialog:OnFocus(focus)
    --printError("focus = " .. tostring(focus))
    Mgr.isMainlineDialogFocus = focus

    --- 界面右上角两个道具:
    if focus then 
        if self.topGoods then
            CfUtils.RefreshTopGoods(self.topGoods)
        end
    else 
        local UINavigationBarRoot = CS.UINavigationBarRoot
        ---@type UINavigatorBar
        local navigatorScr = CfUtils.GetLuaScr(UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar")
        navigatorScr:SetRightShow(false, self.topGoods)
    end 

    --printError("focus = " .. tostring(focus))
    if self.isFocus ~= focus then 
        self.isFocus = focus
        if focus then 
            print("is focus = " .. tostring(focus))
            self:RefreshUI()
            self:_DrawRewards()
        end 
    end 
end


-- 领取奖励
function OverseaParkourMainlineDialog:_DrawRewards()
    if isTable(Mgr.rewards) and table.count(Mgr.rewards) > 0 then 
        GoodsUtils.DrawRewards(Mgr.rewards)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = Mgr.rewards, cb = function()
            --printError(" 领奖结束 ")
            Mgr.rewards = nil
        end } })
    end
end



function OverseaParkourMainlineDialog:RefreshUI()
    self.levelDatas = nil -- 强制清空下
    self.itemCount = #self:GetLevelData()
    self:RefreshList()

    

end

function OverseaParkourMainlineDialog:RefreshList()
    if not self.ScrollView.IsListViewInit then
        local initParam = CS.SuperScrollView.LoopListViewInitParam.CopyDefaultInitParam()
        initParam.mItemDefaultWithPaddingSize = 311
        self.ScrollView:InitListView(#self:GetLevelData(),Bind(self,self.OnGetItemByIndex),initParam)
    else
        GameUtils.ReloadData(self.ScrollView, #self:GetLevelData())
    end
end



function OverseaParkourMainlineDialog:SetCurrentBubbleToCenter()

    local currentLevelId = Mgr:GetCurrentLevelId() 
    local tgtIdx = nil -- 1-based
    for i=1, #self:GetLevelData() do 
        local data = self:GetLevelData()[i]
        if checkInt(data.homeDojo.questId) == checkInt(currentLevelId) then
            tgtIdx = i
        end 
    end 

    if isNotNull(tgtIdx) then 
        self.ScrollView:MovePanelToItemIndex( checkInt(tgtIdx)-1, 0 )
    else 
        printError("异常, 没找到 currentLevelId 的 idx")
    end 
end



function OverseaParkourMainlineDialog:GetLevelData()
    if isNull(self.levelDatas) then  
        if isNull(Mgr.homeDojo) then 
            printError("调用时机异常")
            return {}
        end 
        self.levelDatas = {}
        for _,dojo in pairs(Mgr.homeDojo.mainQuestMap ) do 
            local levelId = checkInt(dojo.questId)
            local vo = ParkourGameUtil.GetMiniWorldMainLevelVo( levelId )
            table.insert( self.levelDatas, {homeDojo = dojo, vo = vo} )
        end 
    end
    return self.levelDatas
end



---@param index number @ 0-based
function OverseaParkourMainlineDialog:OnGetItemByIndex(listView, index)
    local levelData = self:GetLevelData()[index + 1]
    local mainlineVO = levelData.vo -- 主线关卡表vo raw
    local itemList = self.ScrollView.ItemList
    if itemList and itemList.Count > 0 then
        --print("index - targetIndex:"..index,self.ScrollView.ItemList[0].ItemIndex)    
    end
    local cell = listView:NewListViewItem("OverseaParkourMainlineCell12001801")
    local cellEnv = GetLuaBehaviour(cell.gameObject, "Game.Activity.ParkourGame.Dialog.SelectLevel.OverseaParkourMainlineCell").Env
    
    ---
    local currentLevelId = Mgr:GetCurrentLevelId() 
    local questId = checkInt(levelData.homeDojo.questId) -- 本 cell 指向的 关卡id
    ---
    local levelType = ParkourGameUtil.GetMiniWorldMainLevelVoLevelType( mainlineVO )
    local isLocked,lockText = self:GetUnlockInfo(levelData.homeDojo)

    local isFinish = ParkourGameUtil.IsLevelPassed(questId)
    local starTask = checkTable(levelData.homeDojo.starTask)
    local isCurrentLevel = currentLevelId == questId

    ---
    cellEnv:RefreshData({
        index0Based = checkInt(index),
        isCurrentLevel = isCurrentLevel,
        levelType = levelType,
        isLocked = isLocked,
        isFinish = isFinish,
        starTask = starTask,
        mainlineVo = mainlineVO,
    })

    local cellBtnTF = cell.transform:Find("AnimRoot/BtnNode")
    SetButtonAction(cellBtnTF.gameObject, function()
        if self.isFocus ~= true then 
            return
        end 

        --- 是否解锁:
        if isLocked == true then 
            GameUtils.Toast( lockText ) -- 飘字
            return
        end

        CoStop(self.co_1)
        self.co_1 = CoStart(function()
            Mgr.currentLevelId = questId
            ---
            if levelType == ParkourGameUtil.LevelType.Parkour then 
                print("选中 跑酷; ")
                UIModule.OpenDialog({ id = Constants.UITypeIds.ParkourGameSelectParkourDialog, parameters = {
                    mainlineDialog = self,
                    homeDojo = levelData.homeDojo,
                    vo = levelData.vo,
                } })

            elseif levelType == ParkourGameUtil.LevelType.Story then 
                print("选中 剧情; ")
                UIModule.OpenDialog({ id = Constants.UITypeIds.ParkourGameSelectStoyDialog, parameters = {
                    mainlineDialog = self,
                    homeDojo = levelData.homeDojo,
                    vo = levelData.vo,
                } })

            elseif levelType == ParkourGameUtil.LevelType.Battle then 
                print("选中 战斗; ")
                self:_EnterBattle(questId, mainlineVO, levelData.homeDojo, isFinish)
            else 
                printError("levelType 值异常: " .. tostring(levelType))
            end 
        end)
    end)
    
    return cell
end


---@return boolean, string
function OverseaParkourMainlineDialog:GetUnlockInfo( homeDojo_ ) 
    local unlockCountdown = checkInt(homeDojo_.unlockCountdown) 
    if unlockCountdown > 0 then
        local countDownText = string.format(localize("距离开放：_num_", {_num_ =CfUtils.GetTimeHMS10(checkInt(unlockCountdown + Mgr.enterTime - os.time()))}))
        return true, countDownText

    elseif homeDojo_.status == 0 then 
        local countDownText = string.format(localize("请完成前置关卡"))
        return true, countDownText
    else
        return false, ""
    end
end



function OverseaParkourMainlineDialog:_EnterBattle( questId_, mainlineVO_, homeDojo_, isFinish_ )

    Mgr.battleEndCB = function()
        -- 成功时消耗的道具:
        GoodsUtils.ConsumeGoods({
            { goodsId = checkInt(mainlineVO_.costItem), num = checkInt(mainlineVO_.costNum) }
        }, false)
    end

    -- local endCB = function()
    --     -- 成功时消耗的道具:
    --     GoodsUtils.ConsumeGoods({
    --         { goodsId = checkInt(mainlineVO_.costItem), num = checkInt(mainlineVO_.costNum) }
    --     }, false)
    -- end
    
    --------
    local EnterFightTeam = function()
        CfUtils.DialogOpen(Constants.UITypeIds.UIFightTeamChoose, 
            { activityUuid = Mgr.activityUuid, levelId = questId_ }, 
            { { id = Constants.UITypeIds.OverseaParkourMainlineDialog } })
    end 
    -------
    local canReplay = mainlineVO_.repeatButton > 0
    local plotVo = ParkourGameUtil.GetMiniWorldMainChapterVo( questId_ )

    if isFinish_ and canReplay==false then 
        -- 已经打过了的页面如果不支持复刷, 直接把前后两段剧情播放一下
        self:_PlayingPlot(plotVo.plotIdWave, function ()
            self:_PlayingPlot(plotVo.plotIdEndWave)
        end)
    else
        local costNumLose = checkInt(mainlineVO_.costNumLose)
        -- 进入时消耗的道具:
        GoodsUtils.ConsumeGoods({
            { goodsId = checkInt(mainlineVO_.costItem), num = costNumLose }
        }, false)

        EnterFightTeam()
    end
end 


--- 手动播放剧情
function OverseaParkourMainlineDialog:_PlayingPlot(plotId_, endCb)
    local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
    local UINavigationBarRoot = CS.UINavigationBarRoot

    CoStop(self.co_plot)
    self.co_plot = CoStart(function()
        
        local wait = true
        local plotGo = nil
        local lastDialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.OverseaParkourMainlineDialog)
        ChapterUtils.ProcessChapter(checkNumber(plotId_), function(go)
            if isNotNull(lastDialog) then
                lastDialog.transform.localPosition = Vector3(9999, 9999, 9999)
            end
            URPCameraController:SetMainCameraActive(false)
            UINavigationBarRoot.Instance:SetActive(false)
            plotGo = go
        end, function()
            --所有的播完结束
            if isNotNull(lastDialog) then
                lastDialog.transform.localPosition = Vector3(0, 0, 0)
            end
            URPCameraController:SetMainCameraActive(true)
            UINavigationBarRoot.Instance:SetActive(true)
            wait = false
        end)

        while wait do
            coroutine.yield()
        end

        KTool.SafeDelete(plotGo)

        coroutine.yield()
        
        -- todo: PlayBGM

        if endCb then
            endCb()
        end
    end)
end



function OverseaParkourMainlineDialog:OnClickArrowL()
    if self.isFocus ~= true then 
        return
    end 

    local itemList = self.ScrollView.ItemList
    if itemList and itemList.Count > 0 then
        local startIndex = self.ScrollView.ItemList[0].ItemIndex
        startIndex = Mathf.Max(0,startIndex - 5)
        self.ScrollView:MovePanelToItemIndex(startIndex)    
    end
end

function OverseaParkourMainlineDialog:OnClickArrowR()
    if self.isFocus ~= true then 
        return
    end 

    local itemList = self.ScrollView.ItemList
    if itemList and itemList.Count > 0 then
        local startIndex = self.ScrollView.ItemList[0].ItemIndex 
        self.ScrollView:MovePanelToItemIndex(startIndex + 5)    
    end
end


-- 左右拖动屏幕
function OverseaParkourMainlineDialog:OnScrollValueChanged(normalizedPosition)
    if isNull(self.prex) then 
        self.prex = checkNumber(normalizedPosition.x)
        return
    end 
    ---
    local dis = checkNumber(normalizedPosition.x - self.prex)
    if Mathf.Abs(dis) > 0.002 then
        Events.Broadcast(ParkourGameUtil.Events.SelectLevelDraging, dis * self.itemCount)
        self.prex = self.prex +  dis
    end
end


function OverseaParkourMainlineDialog:OnClickRank()
    print("OnClickRank")
    return

    --[[ -- 先屏蔽此功能
    UIModule.OpenDialog({ id = Constants.UITypeIds.OverseaParkourRankDialog, parameters = {
        -- mainDialog = self,
        --homeDojo = levelData.homeDojo,
        -- vo = levelData.vo,
    } })
    ]]--
end



---@param levelId_ number
---@param gameType_ ParkourGameUtil.GameType
function OverseaParkourMainlineDialog:_EnterLevel( levelId_, gameType_ )
    GameObject.Destroy(self.selectLevelGo)
    GameUtils.ShowBlackOverlay(nil,function()

        CfUtils.DialogOpen(
            Constants.UITypeIds.ParkourGameMainDialog, 
            {
                levelId = levelId_,
                gameType = gameType_
            }, 
            {UIArgs(Constants.UITypeIds.OverseaParkourMainlineDialog)}
        )
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 1 )) -- !!!! 
    end)
end




function OverseaParkourMainlineDialog:OnNavigatorBack()
    --printError("OnNavigatorBack")
    Parkour_Loader.DeleteInstance() -- !!! 确保只有在点击本界面 左上角 返回按钮时, 才释放 Parkour_Loader
end




return OverseaParkourMainlineDialog