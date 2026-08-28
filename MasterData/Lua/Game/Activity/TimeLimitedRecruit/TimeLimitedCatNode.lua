

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
local ImageAlterable = CS.Engine.UI.ImageAlterable
local Transform = CS.UnityEngine.Transform
local RectTransform = CS.UnityEngine.RectTransform
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local Time = CS.UnityEngine.Time
local CanvasGroup = CS.UnityEngine.CanvasGroup

local SkeletonGraphic = CS.Spine.Unity.SkeletonGraphic
local SkeletonAnimation = CS.Spine.Unity.SkeletonAnimation

---@type TimeLimitedRecruitUtil
local TimeLimitedRecruitUtil = import("Game.Activity.TimeLimitedRecruit.TimeLimitedRecruitUtil")

local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

---@type TimeLimitedMgr
local Mgr = import("Game.Activity.TimeLimitedRecruit.TimeLimitedMgr"):GetInstance()

--[[
        运动的猫节点
]]


--- from: Assets/BundleResources/Prefabs/ActivityDK12003501/ActivityDKCatAnimNode.prefab > name: ActivityDKCatAnimNode
---@class TimeLimitedCatNode
---@field Env                           	TimeLimitedCatNode                      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field SmallGroup                    	UnityEngine.RectTransform               	@ 0    
---@field BigGroup                      	UnityEngine.RectTransform               	@ 1    
---@field SpineCat                      	UnityEngine.RectTransform               	@ 2    
local TimeLimitedCatNode = Class("TimeLimitedCatNode")
---------------------------------------------


local CatInterval = 300 -- 300
local CatMoveSpeed = 530 -- 290 -- 程菲:需要提速

local RobotStartupTime = 0.45 -- 机器人打飞动作前摇时长
local CatHideSpeed = 3


---------------------------------------------
function TimeLimitedCatNode:__init()
    self.recruitmentDojo = nil
end


function TimeLimitedCatNode:__delete()
    self.recruitmentDojo = nil
end



---@param mainGameDialog_ UIActivityTimeLimitedMainGameDialog @ 
---@param previousCatNode_ TimeLimitedCatNode | nil @ 前一个 
---@param rewardData_ table 
---@param initPoint_ UnityEngine.Transform 
---@param beHitPoint_ UnityEngine.Transform       @ 被机器人打飞的点
---@param disappearPoint_ UnityEngine.Transform   @ 消失的点
---@param doorReactPoint_ UnityEngine.Transform   @ 门反应的点
function TimeLimitedCatNode:Init( mainGameDialog_, rewardData_, previousCatNode_, initPoint_, beHitPoint_, disappearPoint_, doorReactPoint_ )
    self.transform = self.controller.gameObject.transform
    --self.transform.position = initPoint_.position
    self.transform.anchoredPosition = initPoint_.anchoredPosition
    self.canvasGroup = self.transform:GetComponent(typeof(CanvasGroup))

    self.rootTF = self.transform:Find("root")
    
    self.mainGameDialog = mainGameDialog_
    self.catState = TimeLimitedRecruitUtil.CatState.Prepare
    self.previousCatNode = previousCatNode_ -- maybe nil
    
    ---
    self.rewardData = rewardData_
    self.isGrand = checkInt(self.rewardData.isGrand) == 1 -- 是否是大奖
    self.isGet = checkInt(self.rewardData.called) == 1

    self.initPoint = initPoint_
    self.beHitPoint = beHitPoint_
    self.disappearPoint = disappearPoint_
    self.doorReactPoint = doorReactPoint_

    CfUtils.SetActive( self.SmallGroup, self.isGrand == false )
    CfUtils.SetActive( self.BigGroup, self.isGrand == true )

    local Icon   = self.isGrand == true and self.BigGroup:Find("ImgIcon") or self.SmallGroup:Find("ImgIcon")
    local TxtNum = self.isGrand == true and self.BigGroup:Find("TxtNum") or self.SmallGroup:Find("TxtNum")
    assert( isNotNull(Icon) or isNotNull(TxtNum) )

    ---@type GoodsConfMgr
    local goodsConfMgr = GoodsConfMgr:GetInstance()
    ---@type GoodsVo
    local goodsVo = goodsConfMgr:GetGoodsVoById(self.rewardData.goodsId)
    if isTable(goodsVo) then
        CfUtils.FillImage( Icon, goodsVo.photoPath )
        ---
        CfUtils.FillText( TxtNum, string.format("x%d", checkInt(self.rewardData.num) ) )
    else 
        printError(string.format(" 找不到 goodsId: %d", checkInt(self.rewardData.goodsId) ))
    end

    self.isDoorReact = false
    self.robotAnimStartTime = 0

    -- 选择显示不同的猫:
    local catName = nil
    if self.isGrand == true then 
        -- 大奖猫
        catName = TimeLimitedRecruitUtil.GetVoParamValue(TimeLimitedRecruitUtil.VoParamsId.BigRewardCatName, Constants.DataType.String)
    else 
        -- 其它猫:
        local namesStr = TimeLimitedRecruitUtil.GetVoParamValue(TimeLimitedRecruitUtil.VoParamsId.OthCatNames, Constants.DataType.String)
        local names = string.split(namesStr, ';')
        assert( isNotNull(names) and #names > 0 )
        local nameIdx = math.random(1, #names)
        catName = names[nameIdx]
    end 
    self:_CatRefresh( catName )
end




function TimeLimitedCatNode:SelfUpdate( deltaTime_ ) 

    if self.catState == TimeLimitedRecruitUtil.CatState.Prepare then 
        assert( isNotNull(self.previousCatNode) )

        if Mathf.Abs(self.previousCatNode.transform.anchoredPosition.x - self.transform.anchoredPosition.x) >= CatInterval then 
            self.catState = TimeLimitedRecruitUtil.CatState.Walk
            -- todo: 走路音效已经在 UIActivityTimeLimitedMainGameDialog:OnInitialize() 中手动触发
        end 

    elseif self.catState == TimeLimitedRecruitUtil.CatState.Walk then 

        --- 移动:
        self.transform.anchoredPosition = self.transform.anchoredPosition + Vector2(CatMoveSpeed,0) * deltaTime_

        if self.isGet == true then 

            -- 触发门的交互:
            if self.transform.anchoredPosition.x > self.doorReactPoint.anchoredPosition.x and self.isDoorReact == false  then 
                self.isDoorReact = true
                self.mainGameDialog.door:AddEnt()
                CriWareUtils.PlaySe( "Audio/sfx_theater", "ui_theater_door_open" )
            end

            -- 走到门终点:
            if self.transform.anchoredPosition.x > self.disappearPoint.anchoredPosition.x  then 
                self.catState = TimeLimitedRecruitUtil.CatState.Hiding
                self.mainGameDialog:_AddGoodNode( self.rewardData.goodsId, self.rewardData.num )
                self.mainGameDialog:AddSuccessCat() 
                self.mainGameDialog:RefreshSchedule()

                Mgr.walkingCatNum = Mgr.walkingCatNum - 1
                if Mgr.walkingCatNum == 0 then 
                    CriWareUtils.Stop("Audio/sfx_theater", "ui_theater_cat_walk")
                end     

            end
        else 
            if self.transform.anchoredPosition.x > self.beHitPoint.anchoredPosition.x then 
                self.mainGameDialog:_RobotAttack() -- 机器人打飞动作
                self.robotAnimStartTime = Time.time
                self.catState = TimeLimitedRecruitUtil.CatState.StartRobotHit
            end 
        end 

    elseif self.catState == TimeLimitedRecruitUtil.CatState.StartRobotHit then 

        --- 移动:
        self.transform.anchoredPosition = self.transform.anchoredPosition + Vector2(CatMoveSpeed,0) * deltaTime_

        -- 等到 机器人打飞动作 前摇结束
        if (Time.time - self.robotAnimStartTime) > RobotStartupTime  then 
            self.catState = TimeLimitedRecruitUtil.CatState.KnockedFlying

            Mgr.walkingCatNum = Mgr.walkingCatNum - 1
            if Mgr.walkingCatNum == 0 then 
                CriWareUtils.Stop("Audio/sfx_theater", "ui_theater_cat_walk")
            end  

            CriWareUtils.PlaySe( "Audio/sfx_theater", "ui_theater_cat_flyaway" )

            local animaName = "ActivityDKCatAnimNode_Attacked"

            CfUtils.WaitPlayAnimationTo( self.rootTF, animaName, function()
                CfUtils.SetActive( self.rootTF, false )
                self.catState = TimeLimitedRecruitUtil.CatState.Finish
            end )
        end 
    
    elseif self.catState == TimeLimitedRecruitUtil.CatState.KnockedFlying then 


    elseif self.catState == TimeLimitedRecruitUtil.CatState.Hiding then 

        if self.canvasGroup.alpha > 0.0001 then 
            CfUtils.SetCanvasGroupAlpha( self.canvasGroup, self.canvasGroup.alpha - deltaTime_ * CatHideSpeed )
        else 
            self.catState = TimeLimitedRecruitUtil.CatState.Finish
            CfUtils.SetActive( self.rootTF, false )
            self.mainGameDialog.door:RemoveEnt()
        end 

    elseif self.catState == TimeLimitedRecruitUtil.CatState.Finish then 

    else 
        printError("catState 值异常: " ..tostring(self.catState))
    end 
end



function TimeLimitedCatNode:_CatRefresh( catName_ ) 
    if string.isEmpty(catName_) then 
        printError("参数异常, catName_ = " .. tostring(catName_))
        return
    end 

    if isNull(self.catSpine) then 
        self.catSpine = self.SpineCat.gameObject:GetComponent(typeof(SkeletonGraphic))
    end
    if isNull(self.catSpine) then 
        printError("没找到 SpineMonster 的 SkeletonGraphic 组件")
        return
    end 
    ---
    self.catSpine.Skeleton:SetSkin( catName_ )
    self.catSpine.AnimationState:SetAnimation(0, "cat", true)
end





return TimeLimitedCatNode
