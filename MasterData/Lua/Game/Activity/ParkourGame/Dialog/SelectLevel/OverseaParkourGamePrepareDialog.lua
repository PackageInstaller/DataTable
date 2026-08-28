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
local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Random = CS.UnityEngine.Random
local Canvas = CS.UnityEngine.Canvas
local Physics = CS.UnityEngine.Physics
local KTool = CS.Engine.Lib.KTool


local Parkour_Loader = import('Game.Activity.ParkourGame.Parkour_Loader')


--[[
    微缩世界 第二版 选关界面:  跑酷关卡专用界面

]]
--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourStartRunFightDialog.prefab > name: OverseaParkourStartRunFightDialog
---@class OverseaParkourGamePrepareDialog
---@field Env                           	OverseaParkourGamePrepareDialog         
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnRank                       	UnityEngine.RectTransform               	@ 0    按钮 - 排行榜
---@field EntryButtonNode               	UnityEngine.RectTransform               	@ 1    按钮 - 进入(外层)
---@field ScrollView                    	SuperScrollView.LoopListView2           	@ 2    左侧 - 关卡列表
---@field EndlessLevel                  	UnityEngine.RectTransform               	@ 3    左侧 - 无尽模式
---@field NormalStatus                  	UnityEngine.RectTransform               	@ 4    右侧 - 关卡说明块 - 普通模式
---@field EndlessStatus                 	UnityEngine.RectTransform               	@ 5    右侧 - 关卡说明块 - 无尽模式
---@field BottomButton                  	UnityEngine.RectTransform               	@ 6    右下角 - "进入" 按钮块
---@field BuffStatus                    	UnityEngine.RectTransform               	@ 7    右侧 - 增益/陷阱 图标
local OverseaParkourGamePrepareDialog = Class("OverseaParkourGamePrepareDialog")



function OverseaParkourGamePrepareDialog:__init()
    self.levelDatas = nil
    self.itemCount = 0
    self.selectedLevelIdx1Based = 1 -- 选中了哪一关
    self.btnHandler = nil
end



function OverseaParkourGamePrepareDialog:__delete()
    self.btnHandler = nil
end


function OverseaParkourGamePrepareDialog:Awake()
    self.EventNavigatorBack = Events.AddListener(Constants.EventNames.EventUINavigatorBackBar, Bind(self, self.OnNavigatorBack))

    --- 
    self.buffs = 
    {
        buffItem  = self.BuffStatus:Find("LayoutIcon2/Item"),  -- 增益道具 item
        debuffItem = self.BuffStatus:Find("LayoutIcon1/Item"), -- 陷阱道具 item
    }
    CfUtils.SetActive( self.buffs.buffItem, false )
    CfUtils.SetActive( self.buffs.debuffItem, false )

    ---
    self.enterBtn = self.BottomButton:Find("FontStyleButton")
    self.enterBtnConsumePop = self.BottomButton:Find("CommonBtnConsumePop")
    CfUtils.SetActive( self.enterBtnConsumePop, false ) -- 弃用了

    --- 三个任务条
    self.taskNodes = {
        self.NormalStatus:Find("DescNode1"),
        self.NormalStatus:Find("DescNode2"),
        self.NormalStatus:Find("DescNode3"),
    }

    ---
    self.endless = 
    {
        btnTF = self.EndlessLevel:Find("Root"), -- 按钮
        ImgBg = self.EndlessLevel:Find("Root/ImgBg/ImgBg"), -- UI Switch Image 选中后变白; 2:变白
        numTF = self.EndlessLevel:Find("Root/ImgBg/StarGroup/TextDesc"),  -- star >= 多少个时开启 无限模式
        --star  = self.EndlessLevel:Find("Root/ImgBg/StarGroup/TextDesc/ImgStar"), -- star; -- !! 好像不用设置, 它始终是蓝色的
        word = self.EndlessLevel:Find("Root/ImgBg/Title/TextDesc"), -- "无限模式"
        lock  = self.EndlessLevel:Find("Root/ImgBg/Title/TextDesc/ImgSymbol"), -- 锁标志
        NumberOfFloor = self.EndlessLevel:Find("Root/ImgBg/NumberOfFloor"), -- UI Switch Image, 2:选中后
        selectBird      = self.EndlessLevel:Find("Root/ImgBg/NumberOfFloor/SelectBird"), -- 鸟, 选中后
        selectBrackets  = self.EndlessLevel:Find("Root/ImgBg/Select"), -- 选中的 方括号
    }

    --- 右侧面板描述
    self.endlessDesc = self.EndlessStatus:Find("TextDesc") 
end




function OverseaParkourGamePrepareDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        CfUtils.SetActive( self.EndlessStatus, false ) -- !! 先隐藏起来


        SetButtonAction( self.BtnRank, Bind(self, self._OnClickBtnRank))

        SetButtonAction( self.endless.btnTF, Bind(self, self._OnClickInfiniteItem))
        ---
        self.btnHandler = nil
        SetButtonAction( self.enterBtn, function()
            if isNotNull(self.btnHandler) and type(self.btnHandler) == "function" then 
                self.btnHandler()
            end 
        end)
        
        -- =================================
        -- 调用 parkourHome 接口; 刷新一部分数据; (剩余数据使用 home 的)
        local homeRet = {}
        cs_coroutine.yield_return( ParkourGameUtil.CallParkourHome(Mgr.activityUuid, homeRet ) )
        Mgr:SetParkourHomeDojoData(homeRet.responseData)

        -- 找出 selectedLevelIdx1Based:
        self.selectedLevelIdx1Based = 1
        if Mgr.toWhichParkourLevel == nil then 
            -- 手动寻找:
            if Mgr.homeDojo.mainQuestId == 0 then
                -- 说明 玩家还没开始玩
                self.selectedLevelIdx1Based = 1 
            else
                for i=1, #Mgr.homeDojo.mainQuestMap do 
                    local e = Mgr.homeDojo.mainQuestMap[i]
                    if checkInt(e.questId) == Mgr.homeDojo.mainQuestId then 
                        self.selectedLevelIdx1Based = i
                    end 
                end 
            end 
        else 
            self.selectedLevelIdx1Based = checkInt(Mgr.toWhichParkourLevel)
        end

        ---
        self:RefreshUI()        
        self:_WhenChooseNormalItem(self.selectedLevelIdx1Based)
        self:_RefreshInfiniteItem() -- 渲染 无限模式 item:


        if Mgr.toWhichParkourLevel == -1 then 
            self:_OnClickInfiniteItem()
        end 

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
            CoStop(self.co_resume_1)
            self.co_resume_1 = CoStart(function()
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
                    { {id = Constants.UITypeIds.OverseaParkourGamePrepareDialog } }
                )
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 1 ))
            end)
        end 


        -- "重玩跑酷关卡" 功能: 从跑酷关卡退回到 选关页面, 然后再自动进入这一关;
        -- 无限模式的:
        if Mgr.isBackFromMainDialogForResumeForInfinity == true then 
            CoStop(self.co_resume)
            self.co_resume = CoStart(function()
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.5 )) --  !!! 这里有待完善

                local mapVos = ParkourGameUtil.GetRandomInfiniteMapList() -- 一组 map vo 数据;
                UIModule.OpenDialog(
                    { 
                        id = Constants.UITypeIds.ParkourGameMainDialog, 
                        parameters = 
                        {
                            gameType = ParkourGameUtil.GameType.Infinite, 
                            mapVos = mapVos,
                        }
                    },
                    { {id = Constants.UITypeIds.OverseaParkourGamePrepareDialog } }
                )

                cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 1 ))
            end)
        end 
        ---
    end))
    return coWait
end


function OverseaParkourGamePrepareDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self.btnHandler = nil

        if self.EventNavigatorBack then
            Events.RemoveListener(Constants.EventNames.EventUINavigatorBackBar, self.EventNavigatorBack)
        end

        CoStop(self.co_resume_1)
        CoStop(self.co_resume)
  
        ---
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end



function OverseaParkourGamePrepareDialog:OnFocus(focus)
    Mgr.isMainlineDialogFocus = focus     -- !!!! 也许要换

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

    if self.isFocus ~= focus then 
        self.isFocus = focus
        if focus then 
            print("is focus = " .. tostring(focus))
            self:RefreshUI()
            self:_DrawRewards()
        end 
    end 
end



-- ============================================================================================



function OverseaParkourGamePrepareDialog:RefreshUI()
    self.levelDatas = nil -- 强制清空下
    self.itemCount = #self:GetLevelData()
    self:RefreshList()
end 


function OverseaParkourGamePrepareDialog:RefreshList()    
    if not self.ScrollView.IsListViewInit then
        self.ScrollView:InitListView(#self:GetLevelData(), Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.ScrollView, #self:GetLevelData())
    end
end



---@param index0based number @ 0-based
function OverseaParkourGamePrepareDialog:OnGetItemByIndex(listView, index0based)
    local idx1based = index0based + 1
    local levelData = self:GetLevelData()[idx1based]

    local cell = listView:NewListViewItem("OverseaParkourStartRunCell")
    local cellEnv = GetLuaBehaviour(cell.gameObject, "Game.Activity.ParkourGame.Dialog.SelectLevel.OverseaParkourGamePrepareLevelNode").Env

    --
    local starNum = 0
    for _,st in pairs(levelData.homeDojo.starTask) do 
        if checkInt(st.status) > 0 then 
            starNum = starNum + 1
        end 
    end 
    --
    local isLock = checkInt(levelData.homeDojo.status)==0
    --
    cellEnv:Refresh( idx1based, starNum, isLock, idx1based == self.selectedLevelIdx1Based, function(idx1based_)

        CfUtils.SetActive( self.NormalStatus, true )
        CfUtils.SetActive( self.EndlessStatus, false )

        self:_WhenChooseNormalItem(idx1based_)
    end)
    return cell    
end



function OverseaParkourGamePrepareDialog:_WhenChooseNormalItem( idx1based_ )
    self.selectedLevelIdx1Based = idx1based_
    if self.selectedLevelIdx1Based < 1 then 
        return
    end 
    ---
    local levelData = self:GetLevelData()[self.selectedLevelIdx1Based]
    local isUnlock = checkInt(levelData.homeDojo.status) > 0

    -- 刷新 select 效果:
    self:_FillSelectInfiniteItem(false)
    Events.Broadcast('Parkour_ChangeSelect', self.selectedLevelIdx1Based )
    
    -- 渲染 右侧面板:
    self:_RefreshNormalStatus()

    -- 按钮样式:
    CfUtils.SetButtonStyle(self.enterBtn , isUnlock and "B3" or "B4" ) 

    Mgr.toWhichParkourLevel = self.selectedLevelIdx1Based
    -- 绑定按钮: 
    self.btnHandler = function()
        self:_EnterNormalParkour( isUnlock )
    end
end



-- 绘制 无限模式 item 时:
function OverseaParkourGamePrepareDialog:_RefreshInfiniteItem()

    local UnlockStarNum = checkInt(ParkourGameUtil.GetVoParamValue(ParkourGameUtil.VoParamsId.InfiniteMode_UnlockStarNums))

    local obtainedTaskStarNum = self:_GetObtainedTaskStarNum()
    local isUnlock = obtainedTaskStarNum >= UnlockStarNum

    CfUtils.FillText( self.endless.numTF, "<size=60>≥</size> " .. tostring(UnlockStarNum) ) -- star >= 多少个时开启 无限模式
    CfUtils.SetActive( self.endless.lock.gameObject, not isUnlock ) -- 锁标志

    -- 刷新 select 效果:
    self:_FillSelectInfiniteItem(false) -- 默认为不选
end



-- 选中 无限模式 item 时:
function OverseaParkourGamePrepareDialog:_OnClickInfiniteItem()

    local UnlockStarNum = checkInt(ParkourGameUtil.GetVoParamValue(ParkourGameUtil.VoParamsId.InfiniteMode_UnlockStarNums))

    local obtainedTaskStarNum = self:_GetObtainedTaskStarNum()
    local isUnlock = obtainedTaskStarNum >= UnlockStarNum

    -- 刷新 select 效果:
    self:_FillSelectInfiniteItem(true)
    Events.Broadcast('Parkour_ChangeSelect', -1 ) -- 每个都不选

    -- 渲染右侧:
    CfUtils.SetActive( self.NormalStatus, false )
    --CfUtils.SetActive( self.EndlessStatus, true )  -- !! 暂时先隐藏
    self:_RefreshInfiniteStatus()

    -- 按钮样式:
    CfUtils.SetButtonStyle(self.enterBtn , isUnlock and "B3" or "B4" ) 

    Mgr.toWhichParkourLevel = -1
    -- 绑定按钮: 
    self.btnHandler = function()
        self:_EnterInfiniteParkour( isUnlock )
    end
end




function OverseaParkourGamePrepareDialog:_RefreshNormalStatus()

    local levelData = self:GetLevelData()[self.selectedLevelIdx1Based]
    local mainlineVO = levelData.vo -- 微缩世界主线跑酷关卡表 vo raw

    local levelId = mainlineVO.id
    local threeStarsConditionVOs = ParkourGameUtil.GetNeededMiniWorldThreeStarsConditionVOs( levelId ) -- MiniWorldThreeStarsConditionVO[]    

    --- tasks:
    for i=1,3 do 
        local vo = threeStarsConditionVOs[i]
        local nodeTF = self.taskNodes[i]
        if isNotNull(vo) then 
            local isFinish_ = (levelData.homeDojo.starTask[i].status > 0)
            ParkourGameUtil.DawTaskLine2( nodeTF, isFinish_, vo.taskTitle, vo.rewardId, vo.rewardNum )
        else 
            printError("微缩世界三星条件表 条目丢失, i = "..tostring(i)  )
        end
    end 

    -- 增益组
    ParkourGameUtil.DestroyAllChildren( self.buffs.buffItem.parent,     {"Item"} )
    local buffIds = string.split(mainlineVO.gainId, ";")
    for k,id in pairs(buffIds) do 
        local gainVO = ParkourGameUtil.GetMiniWorldBuffItemVo( checkInt(id) )
        self:DrawBuffNode( self.buffs.buffItem, gainVO.icon, gainVO.name, gainVO.desc )
    end 
    -- 陷阱组
    ParkourGameUtil.DestroyAllChildren( self.buffs.debuffItem.parent,   {"Item"} )
    local debuffIds = string.split(mainlineVO.trapId, ";")
    for k,id in pairs(debuffIds) do 
        local trapVO = ParkourGameUtil.GetMiniWorldTrapVo( checkInt(id) )
        self:DrawBuffNode( self.buffs.debuffItem, trapVO.icon, trapVO.name, trapVO.desc )
    end 
end




function OverseaParkourGamePrepareDialog:_RefreshInfiniteStatus()

    --- 描述
    CfUtils.FillText( self.endlessDesc, "kokoko" )

    --- 
    local trapIds = string.split( tostring(ParkourGameUtil.GetVoParamValue(ParkourGameUtil.VoParamsId.InfiniteMode_TrapIds, Constants.DataType.String)), ';' ) -- {}
    local gainIds = string.split( tostring(ParkourGameUtil.GetVoParamValue(ParkourGameUtil.VoParamsId.InfiniteMode_GainBuffIds, Constants.DataType.String)), ';' ) -- {}
    -- 增益组
    ParkourGameUtil.DestroyAllChildren( self.buffs.buffItem.parent,     {"Item"} )
    for k,id in pairs(gainIds) do 
        local gainVO = ParkourGameUtil.GetMiniWorldBuffItemVo( checkInt(id) )
        if isNull(gainVO) then 
            printError( "gainVO nil, id = " .. tostring(id) )
        else 
            self:DrawBuffNode( self.buffs.buffItem, gainVO.icon, gainVO.name, gainVO.desc )
        end 
    end 
    -- 陷阱组
    ParkourGameUtil.DestroyAllChildren( self.buffs.debuffItem.parent,   {"Item"} )
    for k,id in pairs(trapIds) do 
        local trapVO = ParkourGameUtil.GetMiniWorldTrapVo( checkInt(id) )
        if isNull(trapVO) then 
            printError( "trapVO nil, id = " .. tostring(id) )
        else 
            self:DrawBuffNode( self.buffs.debuffItem, trapVO.icon, trapVO.name, trapVO.desc )
        end 
    end 
end




function OverseaParkourGamePrepareDialog:DrawBuffNode( baseNode_, imgPath_, title_, desc_ )
    local newTF = GameObject.Instantiate( baseNode_, baseNode_.parent )
    local ImgIcon = newTF:Find("ImgIcon")
    CfUtils.FillImage( ImgIcon, imgPath_ )
    CfUtils.SetActive( newTF.gameObject, true )
    ---
    SetButtonAction(newTF.gameObject, function()
        GameUtils.ShowCommonTipsBoardAttribute(newTF.gameObject, title_, desc_ )
    end)
end





-- 和 ParkourGameSelectParkourDialog:_OnClickBtnEnter() 相似的按钮
function OverseaParkourGamePrepareDialog:_EnterNormalParkour( isUnlock_ )
    print(" 普通 跑酷关卡探索 ")
    if isUnlock_ ~= true then 
        GameUtils.Toast( localize("本关卡尚未解锁") ) -- 飘字
        return
    end 

    local levelData = self:GetLevelData()[self.selectedLevelIdx1Based]
    local mainlineVO = levelData.vo -- 微缩世界主线跑酷关卡表 vo raw
    local levelId = mainlineVO.id

    Mgr.currentLevelId = levelId

    GameUtils.ShowBlackOverlay(nil,function()
        Mgr.isMainDialogInitDone = false
        UIModule.OpenDialog(
            { 
                id = Constants.UITypeIds.ParkourGameMainDialog, 
                parameters = 
                {
                    gameType = ParkourGameUtil.GameType.Normal, 
                    levelId = levelId,
                }
            },
            { {id = Constants.UITypeIds.OverseaParkourGamePrepareDialog } }
        )
        ---
        while Mgr.isMainDialogInitDone == false do 
            coroutine.yield(Yielders.EndOfFrame)
        end 
        Mgr.isMainDialogInitDone = false
        --cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 1 )) -- !!!! 粗暴的方式, 确保黑幕足够长
    end)

end



-- 自由探索模式
function OverseaParkourGamePrepareDialog:_EnterInfiniteParkour( isUnlock_ )
    if isUnlock_ ~= true then 
        GameUtils.Toast( localize("无限模式尚未解锁") ) -- 飘字
        return
    end 

    local mapVos = ParkourGameUtil.GetRandomInfiniteMapList() -- 一组 map vo 数据;

    GameUtils.ShowBlackOverlay(nil,function()
        Mgr.isMainDialogInitDone = false
        UIModule.OpenDialog(
            { 
                id = Constants.UITypeIds.ParkourGameMainDialog, 
                parameters = 
                {
                    gameType = ParkourGameUtil.GameType.Infinite, 
                    mapVos = mapVos,
                }
            },
            { {id = Constants.UITypeIds.OverseaParkourGamePrepareDialog } }
        )
        ---
        while Mgr.isMainDialogInitDone == false do 
            coroutine.yield(Yielders.EndOfFrame)
        end 
        Mgr.isMainDialogInitDone = false
        --cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 1 )) -- !!!! 粗暴的方式, 确保黑幕足够长
    end)
end




-- 领取奖励
function OverseaParkourGamePrepareDialog:_DrawRewards()
    if isTable(Mgr.rewards) and table.count(Mgr.rewards) > 0 then 
        GoodsUtils.DrawRewards(Mgr.rewards)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = Mgr.rewards, cb = function()
            --printError(" 领奖结束 ")
            Mgr.rewards = nil
        end } })
    end
end


function OverseaParkourGamePrepareDialog:OnNavigatorBack()
    Parkour_Loader.DeleteInstance() -- !!! 确保只有在点击本界面 左上角 返回按钮时, 才释放 Parkour_Loader
end



function OverseaParkourGamePrepareDialog:GetLevelData()
    if isNull(self.levelDatas) then  
        if isNull(Mgr.homeDojo) then 
            printError("调用时机异常")
            return {}
        end 
        self.levelDatas = {}
        for _,dojo in pairs(Mgr.homeDojo.mainQuestMap ) do 
            local levelId = checkInt(dojo.questId)
            local vo = ParkourGameUtil.GetMiniWorldParkourLevelVo( levelId ) -- MiniWorldParkourLevelVo
            table.insert( self.levelDatas, {homeDojo = dojo, vo = vo} )
        end 
    end
    return self.levelDatas
end



-- 计算 目前为止, 玩家得到了 几颗星
function OverseaParkourGamePrepareDialog:_GetObtainedTaskStarNum()  -- !!! 未来优化
    local num = 0
    for i=1, #Mgr.homeDojo.mainQuestMap do 
        local starTask = Mgr.homeDojo.mainQuestMap[i].starTask
        for j=1, #starTask do 
            local e = starTask[j]
            if checkInt(e.status) > 0 then 
                num = num + 1
            end 
        end 
    end 
    return num
end



function OverseaParkourGamePrepareDialog:_FillSelectInfiniteItem( isSelect )    
    isSelect = isSelect==true
    ---
    CfUtils.SetUISwitchImage( self.endless.ImgBg, isSelect and 2 or 1 )
    CfUtils.SetUISwitchText( self.endless.numTF, isSelect and 2 or 1 )
    CfUtils.SetUISwitchText( self.endless.word, isSelect and 2 or 1 )
    CfUtils.SetUISwitchImage( self.endless.lock, isSelect and 2 or 1 )
    CfUtils.SetUISwitchImage( self.endless.NumberOfFloor, isSelect and 2 or 1 ) 
    CfUtils.SetActive( self.endless.selectBird, isSelect )
    CfUtils.SetActive( self.endless.selectBrackets, isSelect )
end


function OverseaParkourGamePrepareDialog:_OnClickBtnRank()     
    UIModule.OpenDialog({ id = Constants.UITypeIds.OverseaParkourRankDialog, parameters = {
        --mainDialog = self,
        --homeDojo = levelData.homeDojo,
        -- vo = levelData.vo,
    } })
end




return OverseaParkourGamePrepareDialog
