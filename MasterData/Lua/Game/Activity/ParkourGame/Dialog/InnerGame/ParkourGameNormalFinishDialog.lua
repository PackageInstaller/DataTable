
-- 跑酷主游戏 完成一个关卡后 弹出的结算界面, 普通模式

--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourEvaluateStoryStarLevelPopup12001801.prefab > name: OverseaParkourEvaluateStoryStarLevelPopup12001801
---@class ParkourGameNormalFinishDialog
---@field Env                           	ParkourGameNormalFinishDialog           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Title                         	UnityEngine.RectTransform               	@ 0    左上角主题
---@field taskNode1                     	UnityEngine.RectTransform               	@ 1    三星任务节点 1
---@field taskNode2                     	UnityEngine.RectTransform               	@ 2    三星任务节点 2
---@field taskNode3                     	UnityEngine.RectTransform               	@ 3    三星任务节点 3
---@field CommonGoodsListLight          	UnityEngine.RectTransform               	@ 4    奖励
---@field BtnAgain                      	UnityEngine.RectTransform               	@ 5    "再次探索"
---@field BtnExit                       	UnityEngine.RectTransform               	@ 6    "退出地图"
---@field RewardDisplay                 	UnityEngine.RectTransform               	@ 7    奖励区域
local ParkourGameNormalFinishDialog = Class("ParkourGameNormalFinishDialog")


-- =========================================================

---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
---@type ParkourGameUtil
local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")
local ResourceModule = CS.Engine.Modules.ResourceModule
local UIModule = CS.Engine.UI.UIModule

--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程

local GameUtils = import('Game.Utils.GameUtils')
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Random = CS.UnityEngine.Random
local Canvas = CS.UnityEngine.Canvas
local Physics = CS.UnityEngine.Physics
local KTool = CS.Engine.Lib.KTool



---@class ParkourGameNormalFinishDialog.InputData


-- =========================================================


function ParkourGameNormalFinishDialog:__init()
    self.controller = nil
end

function ParkourGameNormalFinishDialog:__delete()
    self.controller = nil
    self:Delete()
    self = nil --lua层的gc需要
end


function ParkourGameNormalFinishDialog:Init( reStartGame_, exitCB_, responseData_ )
    self.reStartGame = reStartGame_
    self.exitCB = exitCB_

    self.taskNodes = { self.taskNode1, self.taskNode2, self.taskNode3 }
    self.againCommonBtnConsumePop = self.BtnAgain:Find("CommonBtnConsumePop") -- 再次挑战的消耗
    CfUtils.SetActive(self.againCommonBtnConsumePop, false ) -- 20241206: 不需要显示了

    local rewardTextDesc = self.RewardDisplay:Find("Title/TextDesc")
    CfUtils.FillText(rewardTextDesc  , localize("收集一览"))

    self.btnAgain = self.BtnAgain:Find("FontStyleButton")
    self.btnExit  = self.BtnExit:Find("FontStyleButton")

    self.titles = {
        TextNumber = self.Title:Find("TextNumber"),
        TextDesc   = self.Title:Find("TextDesc"),
    }

    SetButtonAction(self.btnAgain.gameObject,       Bind(self,self._OnClickBtnPlayAgain) )
    SetButtonAction(self.btnExit.gameObject,        Bind(self,self._OnClickBtnExit) )

    self.canvas = KTool.GetComponent(self.controller.gameObject, typeof(Canvas))

    self:RefreshUI( responseData_ )

    --- 领取 活动货币:
    -- local activityGoodsNum = Mgr:GetActivityGoodsNum()
    -- if activityGoodsNum > 0 then 
    --     GoodsUtils.DrawRewards({{ goodsId = ParkourGameUtil.activityGoodsId, num = activityGoodsNum }})
    -- end 

    -- print("activityGoodsId = " ..tostring(ParkourGameUtil.activityGoodsId))
    -- print("activityGoodsNum = " ..tostring(activityGoodsNum))

    --- 领取奖励 
    local rewards = responseData_.rewards
    if isTable(rewards) and table.count(rewards) > 0 then 
        GoodsUtils.DrawRewards(rewards)

        -- 20241206: 只需偷偷领取, 不用显示给玩家了
        --[[
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards, cb = function()
            --printError(" 领奖结束 ")
        end } })
        ]]
    end
end




function ParkourGameNormalFinishDialog:RefreshUI(  responseData_ )

    local mainlineVO = ParkourGameUtil.GetMiniWorldParkourLevelVo( Mgr.currentLevelId )

    -- title
    --local titleDatas = string.split( mainlineVO.name, " " )
    if isNotNull(mainlineVO.title)  then
        CfUtils.FillText( self.titles.TextNumber.gameObject, tostring(mainlineVO.title) )
        CfUtils.SetActive(self.titles.TextNumber.gameObject , true)
    else 
        CfUtils.SetActive(self.titles.TextNumber.gameObject , false)        
    end
    CfUtils.FillText( self.titles.TextDesc.gameObject, tostring(mainlineVO.name) )

    
    for i=1,3 do 
        local starTask = responseData_.starTask[i]
        local threeStarVO = ParkourGameUtil.GetMiniWorldThreeStarsConditionVO( checkInt(starTask.id) ) -- 微缩世界三星条件表
        local node = self.taskNodes[i]
        if isNotNull(threeStarVO) then 
            local isFinish_ = checkInt(starTask.status) > 0
            ParkourGameUtil.DawTaskLine( node, isFinish_, threeStarVO.taskTitle )
        else 
            printError("微缩世界三星条件表 条目丢失, i = "..tostring(i)  )
        end
    end 
    

    UICommonUtils.FillCommonBtnConsumePop(self.againCommonBtnConsumePop, mainlineVO.costItem, mainlineVO.costNum) -- 再次探索的物资

    -- 奖励
    local rewards = responseData_.rewards
    if isTable(rewards) and table.count(rewards) > 0 then 
        ---@type CommonGoodsListLight
        local goodsLua = CfUtils.GetLuaScr(self.CommonGoodsListLight, "Game.Behaviours.CommonGoodsListLight")
        if goodsLua then
            goodsLua:FreshBaseUI(rewards)
        end
    end

end



function ParkourGameNormalFinishDialog:_OnClickBtnPlayAgain()
    --printError( "play again" )
    self:reStartGame()
end


function ParkourGameNormalFinishDialog:_OnClickBtnExit()
    --printError( "exit" )
    GameUtils.ShowBlackOverlay(nil,function()

        self.canvas.enabled = false
        self.exitCB()

        while (Mgr.isMainlineDialogFocus == true and Mgr.isParkourDialogFocus == false) == false do 
            --printError("等待")
            coroutine.yield(Yielders.EndOfFrame)
        end 
        
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 1 )) -- !!!! 粗暴的方式, 确保黑幕足够长

    end)
end


function ParkourGameNormalFinishDialog:Show()
    CfUtils.SetActive(self.controller.gameObject, true)
end

function ParkourGameNormalFinishDialog:Hide()
    CfUtils.SetActive(self.controller.gameObject, false)
end



return ParkourGameNormalFinishDialog