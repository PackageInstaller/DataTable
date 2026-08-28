
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
local KCookie = CS.Engine.Lib.KCookie
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local Time = CS.UnityEngine.Time

local SkeletonGraphic = CS.Spine.Unity.SkeletonGraphic
local SkeletonAnimation = CS.Spine.Unity.SkeletonAnimation

---@type TimeLimitedRecruitUtil
local TimeLimitedRecruitUtil = import("Game.Activity.TimeLimitedRecruit.TimeLimitedRecruitUtil")

---@type TimeLimitedDoor
local TimeLimitedDoor = import("Game.Activity.TimeLimitedRecruit.TimeLimitedDoor")

---@type TimeLimitedMgr
local Mgr = import("Game.Activity.TimeLimitedRecruit.TimeLimitedMgr"):GetInstance()

local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

--[[
        限时招募玩法 主游戏页面
]]


--- from: Assets/BundleResources/Prefabs/ActivityDK12003501/ActivityDKRecruitDialog.prefab > name: ActivityDKRecruitDialog
---@class UIActivityTimeLimitedMainGameDialog
---@field Env                           	UIActivityTimeLimitedMainGameDialog     
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TitleGroup                    	UnityEngine.RectTransform               	@ 0    顶部标题
---@field PointCatStart                 	UnityEngine.RectTransform               	@ 1    pos点
---@field PointCatBattle                	UnityEngine.RectTransform               	@ 2    pos点
---@field PointCatDisappear             	UnityEngine.RectTransform               	@ 3    pos点
---@field SpineMonster                  	UnityEngine.RectTransform               	@ 4    机器人
---@field GoodsList                     	UnityEngine.RectTransform               	@ 5    
---@field ImgHouse                      	UnityEngine.RectTransform               	@ 6    屋子root
---@field BaseCatNode                   	UnityEngine.RectTransform               	@ 7    CatNode 基础件 
---@field MiddleGroup                   	UnityEngine.RectTransform               	@ 8    放 CatNodes 的parent
---@field PointDoorReact                	UnityEngine.RectTransform               	@ 9    pos点: 门被触发的点, 要早于 PointCatDisappear
---@field ScheduleGroup                 	UnityEngine.RectTransform               	@ 10   
local UIActivityTimeLimitedMainGameDialog = Class("UIActivityTimeLimitedMainGameDialog")
---------------------------------------------


---------------------------------------------
function UIActivityTimeLimitedMainGameDialog:__init()
    self.recruitmentCallDojo = nil
end


function UIActivityTimeLimitedMainGameDialog:__delete()
    self.recruitmentCallDojo = nil 
end


function UIActivityTimeLimitedMainGameDialog:Awake()

    self.titleTxtName = self.TitleGroup:Find("TxtName") -- 写 "十倍招募!!"

    self.scheduleTxtSchedule = self.ScheduleGroup:Find("TxtSchedule") -- "当前进度"
    self.scheduleTxtNum = self.ScheduleGroup:Find("TxtNum1") -- "当前进度:X/5" 的 X
    self.scheduleBaseTxtNum = self.ScheduleGroup:Find("TxtNum1/TxtNum2") -- 分母



    self.house = 
    {
        leftDoor  = self.ImgHouse:Find("ImgDoor2"),
        rightDoor = self.ImgHouse:Find("ImgDoor1"),
        uifx      = self.ImgHouse:Find("UIFX_Pass"),
    }
    CfUtils.SetActive( self.house.uifx, false )
    ---
    self.door = TimeLimitedDoor.New( 
        self.house.leftDoor, self.house.rightDoor,
        self.house.leftDoor.anchoredPosition, self.house.leftDoor.anchoredPosition - Vector2(100,0),
        self.house.rightDoor.anchoredPosition, self.house.rightDoor.anchoredPosition + Vector2(100,0),
        8,
        function()
            CfUtils.SetActive( self.house.uifx, true )
        end,
        function()
            CfUtils.SetActive( self.house.uifx, false )
        end
    )

    self.goodNodes = 
    {
        interval = 180,
        baseGoodNodeTF = self.GoodsList:Find("GoodNodeGroup"), -- 基础件
        --[[
            tgtPos2 
            tf
        ]]
        list = {},
        initPos2 = nil,
    }
    self.goodNodes.initPos2 = self.goodNodes.baseGoodNodeTF.anchoredPosition
    CfUtils.SetActive(self.goodNodes.baseGoodNodeTF, false)


    self.catNodes = 
    {
        list = {},
        isAllFinish = false,
    }
end


function UIActivityTimeLimitedMainGameDialog:OnFocus(focus)
end


function UIActivityTimeLimitedMainGameDialog:OnInitialize()

    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        --local parameters = checkTable(self.controller.Argument.parameters)

        local success = false
        GameUtils.Request("Activity2/recruitmentCall", { activityUuid = Mgr.activityUuid, times = Mgr.times }, function(request, response)
            success = true
            if checkNumber(response.errCode) == 0 then

                self.recruitmentCallDojo = checkTable(response.data)
                

                if #self.recruitmentCallDojo.rewards == 0 then 
                    printError("rewards 为空容器")
                end 

                for i=1, #self.recruitmentCallDojo.rewards do 
                    local rewardData = self.recruitmentCallDojo.rewards[i]

                    local newCatGo = CfUtils.InstantiateGo( self.BaseCatNode, self.MiddleGroup )
                    local newCatTF = newCatGo.transform
                    CfUtils.SetActive( newCatGo, true )

                    local previousCatNode = #self.catNodes.list==0 and nil or self.catNodes.list[#self.catNodes.list]

                    local catNodeEnv = CfUtils.GetLuaScr(newCatGo, "Game.Activity.TimeLimitedRecruit.TimeLimitedCatNode")
                    catNodeEnv:Init( self, rewardData, previousCatNode, self.PointCatStart, self.PointCatBattle, self.PointCatDisappear, self.PointDoorReact )

                    table.insert( self.catNodes.list, catNodeEnv )


                    if checkInt(rewardData.called) == 1 then 
                        Mgr:AddReward( rewardData.goodsId, rewardData.num )
                    end 

                end
                
                -- 手动配置第一个 catNode:
                self.catNodes.list[1].catState = TimeLimitedRecruitUtil.CatState.Walk
                Mgr.walkingCatNum = #self.recruitmentCallDojo.rewards
                CriWareUtils.PlaySe( "Audio/sfx_theater", "ui_theater_cat_walk" )

                self.successCatNum = 0

                -- 是否到达了配表条件列表上的最后一个, 和dojo数据无关
                self.isLastRoundInConditionList = Mgr:IsLastRound() 
                --printError("isLastRound = " ..tostring(self.isLastRoundInConditionList))

                self:_Refresh()

            end
        end)

        while not success do
            coroutine.yield()
        end

        CriWareUtils.PlaySe( "Audio/sfx_theater", "ui_theater_cat_robot" )

        -- ==============================
        -- 绑定 Update() 函数:
        local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
        if behaviourAction then
            behaviourAction.UpdateAction = function(behaviourAction)
                self:Update()
            end
        end

    end))
    return coWait
end


function UIActivityTimeLimitedMainGameDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end


function UIActivityTimeLimitedMainGameDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end


-- =============================================================

function UIActivityTimeLimitedMainGameDialog:_Refresh()

    -- title:
    local titleTxt = Mgr.times == 1 and localize("一倍招募!!") or localize("十倍招募!!")
    CfUtils.FillText( self.titleTxtName, titleTxt )

    self:RefreshSchedule()
end



function UIActivityTimeLimitedMainGameDialog:RefreshSchedule()
    if self.isLastRoundInConditionList == true then 
        --CfUtils.SetActive( self.ScheduleGroup, false )
        CfUtils.FillText( self.scheduleTxtSchedule, localize("最终回") )
        CfUtils.FillText( self.scheduleBaseTxtNum, "" )
        CfUtils.FillText( self.scheduleTxtNum, "" )
        return
    end 

    local currentRoundConditionNum = Mgr:GetCurrentRoundConditionNum() -- 分母
    CfUtils.FillText( self.scheduleBaseTxtNum, "/" .. tostring( currentRoundConditionNum ) )
    CfUtils.FillText( self.scheduleTxtNum, checkInt(self.successCatNum) )
    local isEnough = checkInt(self.successCatNum) >= currentRoundConditionNum
    CfUtils.SetUISwitchText( self.scheduleTxtNum, isEnough and 2 or 1  )
end


function UIActivityTimeLimitedMainGameDialog:AddSuccessCat()
    self.successCatNum = self.successCatNum + 1
end



function UIActivityTimeLimitedMainGameDialog:Update()
    if self.catNodes.isAllFinish == true then 
        return
    end 

    local deltaTime = Time.deltaTime

    if Input.GetKeyDown(KeyCode.R) then
        self:_RobotAttack()
    elseif Input.GetKeyDown(KeyCode.T) then
        self:_AddGoodNode( 4101002, 99 )
    end 


    for i=1, #self.goodNodes.list do 
        local node = self.goodNodes.list[i]
        node.tf.anchoredPosition = Vector2.Lerp( node.tf.anchoredPosition, node.tgtPos2, deltaTime * 10 )
    end

    self.door:SelfUpdate(deltaTime)

   
    local finishCatNodeNum = 0
    for i=1, #self.catNodes.list do 
        local catNode = self.catNodes.list[i]
        catNode:SelfUpdate(deltaTime)

        if catNode.catState == TimeLimitedRecruitUtil.CatState.Finish then 
            finishCatNodeNum = finishCatNodeNum + 1
        end 
    end 

    self.catNodes.isAllFinish = finishCatNodeNum == #self.catNodes.list

    -- 所有 catNode 都播放结束:
    if self.catNodes.isAllFinish == true then 
        self:_HandleFinish()
    end 
end



function UIActivityTimeLimitedMainGameDialog:_RobotAttack()

    if isNull(self.robotSpine) then 
        self.robotSpine = self.SpineMonster.gameObject:GetComponent(typeof(SkeletonGraphic))
    end
    if isNull(self.robotSpine) then 
        printError("没找到 SpineMonster 的 SkeletonGraphic 组件")
        return
    end 
    self.robotSpine.AnimationState:SetAnimation(0, "attack", false)
    self.robotSpine.AnimationState:AddAnimation(0, "idle", true, 0) -- 播放完毕后回到 idle
end




function UIActivityTimeLimitedMainGameDialog:_AddGoodNode( goodsId_, num_ )

    for i=1, #self.goodNodes.list do 
        local node = self.goodNodes.list[i]
        node.tgtPos2 = node.tgtPos2 + Vector2( self.goodNodes.interval ,0)
    end 

    local newNodeGo = CfUtils.InstantiateGo( self.goodNodes.baseGoodNodeTF, self.GoodsList )
    local newTF = newNodeGo.transform
    newTF.anchoredPosition = self.goodNodes.initPos2
    local GoodNode = newTF:Find("GoodNode")
    ---@type GoodNodeMB
    local goodNodeMB = CfUtils.GetLuaScr(GoodNode, "Game.Behaviours.GoodNodeMB")
    goodNodeMB:Reload({ isShowNo = true , goodsId = goodsId_, num = num_, text = "x"..num_})
    goodNodeMB:SetClickCallback(function()
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId_)
        if isTable(vo) then
            GameUtils.ShowCommonTipsBoard(GoodNode, vo.name, vo.desc, vo.quality, vo.id)
        end
    end)
    ---
    CfUtils.SetActive(newNodeGo, true)
    table.insert( self.goodNodes.list, {
        tgtPos2 = newTF.anchoredPosition,
        tf = newTF,
    } )
end





function UIActivityTimeLimitedMainGameDialog:_HandleFinish()

    --local isDebug = true 
    -- if isDebug then 
    --     -- 进入免费招募
    --     CfUtils.DialogOpen(
    --         Constants.UITypeIds.UIActivityTimeLimitedObtainedFreePanel, 
    --         {
    --         },
    --         { { id = Constants.UITypeIds.UIActivityTimeLimitedMainGameDialog } }
    --     )
    --     return
    -- end 

    local isIntoNextFree = false
    if self.isLastRoundInConditionList == false then 
        local currentRoundConditionNum = Mgr:GetCurrentRoundConditionNum() -- 分母
        isIntoNextFree = checkInt(self.successCatNum) >= currentRoundConditionNum
    end 

    -- if isDebug then 
    --     isIntoNextFree = false
    -- end

    if isIntoNextFree then 
        -- 进入免费招募
        CfUtils.DialogOpen(
            Constants.UITypeIds.UIActivityTimeLimitedObtainedFreePanel, 
            {
            },
            { { id = Constants.UITypeIds.UIActivityTimeLimitedMainGameDialog } }
        )
    else 
        -- 没能进入免费招募
        local rewards = Mgr:GetTotalRewards() 
        --assert( #rewards > 0 )

        if #rewards > 0 then
            
            GoodsUtils.DrawRewards(rewards)
            UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards, cb = function()
                --printError(" 领奖结束 ")

                Mgr:Clear()
                Mgr.isIntoMainDialog = false
                GameUtils.ShowBlackOverlay(nil,function()
                    CfUtils.DialogBack()
                    while Mgr.isIntoMainDialog == false do 
                        --print("等待")
                        coroutine.yield(Yielders.EndOfFrame)
                    end 
                    cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.2 )) -- !!!! 确保黑幕足够长
                end)

            end } })

        else
            printError("异常, rewards 为空")

            Mgr:Clear()
            Mgr.isIntoMainDialog = false
            GameUtils.ShowBlackOverlay(nil,function()
                CfUtils.DialogBack()
                while Mgr.isIntoMainDialog == false do 
                    --print("等待")
                    coroutine.yield(Yielders.EndOfFrame)
                end 
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.2 )) -- !!!! 确保黑幕足够长
            end)

        end 
    end
end




return UIActivityTimeLimitedMainGameDialog