
-- 跑酷主游戏 完成一个关卡后 弹出的结算界面, 无限探索模式


--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourEvaluateEndlessPopup12001801.prefab > name: OverseaParkourEvaluateEndlessPopup12001801
---@class ParkourGameInfiniteFinishDialog
---@field Env                           	ParkourGameInfiniteFinishDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Title                         	UnityEngine.RectTransform               	@ 0    左上角主题
---@field DescNode1                     	UnityEngine.RectTransform               	@ 1    描述, 行 1 左
---@field DescNode2                     	UnityEngine.RectTransform               	@ 2    描述, 行 1 右
---@field DescNode3                     	UnityEngine.RectTransform               	@ 3    描述, 行 2 左
---@field DescNode4                     	UnityEngine.RectTransform               	@ 4    描述, 行 2 右
---@field DescNode5                     	UnityEngine.RectTransform               	@ 5    描述, 行 3 左
---@field DescNode6                     	UnityEngine.RectTransform               	@ 6    描述, 行 3 右
---@field TextScore                     	UnityEngine.RectTransform               	@ 7    总积分
---@field BtnAgain                      	UnityEngine.RectTransform               	@ 8    "再次探索"
---@field BtnExit                       	UnityEngine.RectTransform               	@ 9    "退出地图"
local ParkourGameInfiniteFinishDialog = Class("ParkourGameInfiniteFinishDialog")


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






-- =========================================================


function ParkourGameInfiniteFinishDialog:__init()
    self.controller = nil
end

function ParkourGameInfiniteFinishDialog:__delete()
    self.controller = nil
    self:Delete()
    self = nil --lua层的gc需要
end





function ParkourGameInfiniteFinishDialog:Init( reStartGame_, exitCB_, responseData_ )
    self.reStartGame = reStartGame_
    self.exitCB = exitCB_


    local CommonBtnConsumePop = self.BtnAgain:Find("CommonBtnConsumePop")
    CfUtils.SetActive( CommonBtnConsumePop, false ) -- 用不到了

    self.playAgainNumTF = self.BtnAgain:Find("RemainNumber/TextNumber")


    self.btnAgain = self.BtnAgain:Find("FontStyleButton")
    self.btnAgainRemainNumber = self.BtnAgain:Find("RemainNumber")
    self.btnExit  = self.BtnExit:Find("FontStyleButton")
    SetButtonAction(self.btnAgain.gameObject,       Bind(self,self._OnClickBtnPlayAgain) )
    SetButtonAction(self.btnExit.gameObject,        Bind(self,self._OnClickBtnExit) )

    CfUtils.SetActive(self.btnAgainRemainNumber, false) -- 不需要了

    self.canvas = KTool.GetComponent(self.controller.gameObject, typeof(Canvas))

    self:RefreshUI( responseData_ )



    --- 领取奖励 
    local rewards = responseData_.rewards
    if isTable(rewards) and table.count(rewards) > 0 then 
        GoodsUtils.DrawRewards(rewards)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards, cb = function()
            --printError(" 领奖结束 ")
        end } })
    end
end



function ParkourGameInfiniteFinishDialog:RefreshUI(  responseData_ )


    self:_DrawDescNode( self.DescNode1, localize("地图货币"), Mgr.scores.coinScore )
    self:_DrawDescNode( self.DescNode2, localize("跑酷距离"), Mgr.scores.moveScore )

    self:_DrawDescNode( self.DescNode3, localize("消灭敌人"), Mgr.scores.beatTrapScore )
    self:_DrawDescNode( self.DescNode4, localize("击退八哥"), Mgr.scores.bossScore )

    self:_DrawDescNode( self.DescNode5, localize("触发增益"), Mgr.scores.gainGoodScore )
    self:_DrawDescNode( self.DescNode6, localize("触发隐身"), Mgr.scores.invisibleScore )


    --- 总积分:
    CfUtils.FillText( self.TextScore.gameObject, Mgr.scores.score )

    --- 再次挑战次数:
    CfUtils.FillText( self.playAgainNumTF.gameObject, 33 ) -- todo:
end



function ParkourGameInfiniteFinishDialog:_OnClickBtnPlayAgain()
    self:reStartGame()
end



function ParkourGameInfiniteFinishDialog:_OnClickBtnExit()
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


function ParkourGameInfiniteFinishDialog:Show()
    CfUtils.SetActive(self.controller.gameObject, true)
end

function ParkourGameInfiniteFinishDialog:Hide()
    CfUtils.SetActive(self.controller.gameObject, false)
end




function ParkourGameInfiniteFinishDialog:_DrawDescNode( descNode_, desc_, num_ )
    CfUtils.FillText( descNode_:Find("TextDesc").gameObject, desc_ )
    CfUtils.FillText( descNode_:Find("TextNumber").gameObject, num_ )
end





return ParkourGameInfiniteFinishDialog