-------------------------------------------------------------------------------
-- 和风战牌 - 打牌结果界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-09-05 16:27:37
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

local EnterAnimName = 'ActivityJapanesePokerBattleResult_Entry'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerBattle/ActivityJapanesePokerBattleResult.prefab > name: ActivityJapanesePokerBattleResult
---@class BattleCardGamePlayResultDialog
---@field Env                           	BattleCardGamePlayResultDialog          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field AnimNode                      	UnityEngine.RectTransform               	@ 1    动画节点
---@field EmptyArea                     	UnityEngine.RectTransform               	@ 2    空白区域
---@field BlueCardNode                  	UnityEngine.RectTransform               	@ 3    蓝卡节点
---@field BlueCardTxt                   	UnityEngine.RectTransform               	@ 4    蓝卡分数
---@field RedCardNode                   	UnityEngine.RectTransform               	@ 5    红卡节点
---@field RedCardTxt                    	UnityEngine.RectTransform               	@ 6    红卡分数
---@field ResultTitleTxt                	UnityEngine.RectTransform               	@ 7    结果文字文本
---@field ResultTitleShadowTxt          	UnityEngine.RectTransform               	@ 8    结果阴影文本
local BattleCardGamePlayResultDialog = Class('BattleCardGamePlayResultDialog')


function BattleCardGamePlayResultDialog:__init()
    ---@type boolean @ 是否可接受操作
    self.isControllable_ = true

    ---@type UnityEngine.Coroutine @ 播放入场你动画协程
    self.enterAninmCo_ = nil

    ---@type fun():void @ 关闭回调
    self.closeCallback_ = nil
end


function BattleCardGamePlayResultDialog:__delete()
    self.isControllable_ = nil
    self.closeCallback_  = nil
    self.enterAninmCo_   = nil
end


function BattleCardGamePlayResultDialog:Awake()
    SetButtonAction(self.EmptyArea, Bind(self, self.OnClickEmptyAreaHandler_))
end


function BattleCardGamePlayResultDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams    = CfUtils.DialogSafeParameters(self.controller)
        self.closeCallback_ = initParams.closeCb
        self:UpdateViewInfo_()

        local enterAnimTime  = CfUtils.GetAnimationTime(self.AnimNode, EnterAnimName)
        self.isControllable_ = false
        self.enterAninmCo_   = CoStart(function()
            CoYield(enterAnimTime)
            self.enterAninmCo_   = nil
            self.isControllable_ = true
        end)
    end)
end


function BattleCardGamePlayResultDialog:OnFinalize()
    return CoWaitDo(function()
        CoStop(self.enterAninmCo_)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- private

function BattleCardGamePlayResultDialog:UpdateViewInfo_()
    local playDojo = battleCardGameComp:GetPlayDojo()

    -- update score
    CfUtils.FillText(self.BlueCardTxt, playDojo:GetOperatorScore())
    CfUtils.FillText(self.RedCardTxt, playDojo:GetOpponentScore())

    local resultTxt = ''
    if playDojo.resultType == BattleCardGameUtils.PlayResult.WIN then
        resultTxt = localize('胜利')
        CfUtils.SetUISwitchImage(self.RedCardNode, 2)
        CfUtils.SetUISwitchImage(self.BlueCardNode, 1)
    elseif playDojo.resultType == BattleCardGameUtils.PlayResult.FAIL then
        resultTxt = localize('失败')
        CfUtils.SetUISwitchImage(self.RedCardNode, 1)
        CfUtils.SetUISwitchImage(self.BlueCardNode, 2)
    elseif playDojo.resultType == BattleCardGameUtils.PlayResult.DRAW then
        resultTxt = localize('平局')
        CfUtils.SetUISwitchImage(self.RedCardNode, 1)
        CfUtils.SetUISwitchImage(self.BlueCardNode, 1)
    else
        CfUtils.SetUISwitchImage(self.RedCardNode, 2)
        CfUtils.SetUISwitchImage(self.BlueCardNode, 2)
    end

    -- update result text
    CfUtils.FillText(self.ResultTitleTxt, resultTxt)
    CfUtils.FillText(self.ResultTitleShadowTxt, resultTxt)
end


-------------------------------------------------
-- handler

function BattleCardGamePlayResultDialog:OnClickEmptyAreaHandler_()
    if not self.isControllable_ then return end

    if self.closeCallback_ then
        self.closeCallback_()
    end
    CfUtils.DialogClose(self.controller)
end


return BattleCardGamePlayResultDialog
