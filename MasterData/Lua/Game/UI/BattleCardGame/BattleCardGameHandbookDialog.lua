-------------------------------------------------------------------------------
-- 和风副本 - 指南界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-09-26 20:13:50
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')

local AnimatoName = {
    ToPage2 = 'Rule1ToRule2',
    ToPage1 = 'Rule2ToRule1',
}
local AnimationName = {
    ToPage2 = 'ActivityJapanesePokerRule_Rule1ToRule2',
    ToPage1 = 'ActivityJapanesePokerRule_Rule2ToRule1',
}

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerBattle/ActivityJapanesePokerRule.prefab > name: ActivityJapanesePokerRule
---@class BattleCardGameHandbookDialog
---@field Env                           	BattleCardGameHandbookDialog            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field AnimNode                      	UnityEngine.RectTransform               	@ 1    动画节点
---@field BtnClose                      	UnityEngine.RectTransform               	@ 2    关闭按钮
---@field BtnArrowLeft                  	UnityEngine.RectTransform               	@ 3    向左按钮
---@field BtnArrowRight                 	UnityEngine.RectTransform               	@ 4    向右按钮
---@field Rule1                         	UnityEngine.RectTransform               	@ 5    规则内页1
---@field Rule2                         	UnityEngine.RectTransform               	@ 6    规则内页2
local BattleCardGameHandbookDialog = Class('BattleCardGameHandbookDialog')


function BattleCardGameHandbookDialog:__init()
    ---@type fun():void
    self.closeCallback_ = nil
end


function BattleCardGameHandbookDialog:__delete()
    self.closeCallback_ = nil
end


function BattleCardGameHandbookDialog:Awake()
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickCloseButtonHnadler_))
    SetButtonAction(self.BtnArrowLeft, Bind(self, self.OnClickLeftButtonHnadler_))
    SetButtonAction(self.BtnArrowRight, Bind(self, self.OnClickRightButtonHnadler_))
end


function BattleCardGameHandbookDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        self.closeCallback_ = initParams.closeCb
    end)
end


function BattleCardGameHandbookDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- handler

function BattleCardGameHandbookDialog:OnClickCloseButtonHnadler_()
    CfUtils.WriteLocalData(BattleCardGameUtils.PlayerPrefsKey.GamePlayHandbook, 1)
    if self.closeCallback_ then
        self.closeCallback_()
    end
    CfUtils.DialogClose(self.controller)
end


function BattleCardGameHandbookDialog:OnClickLeftButtonHnadler_()
    CfUtils.WaitCallbackSafeTo(function()
        local animTime = CfUtils.GetAnimatorTime(self.AnimNode, AnimationName.ToPage1)
        CfUtils.PlayAnimator(self.AnimNode, AnimatoName.ToPage1)
        CoYield(animTime)
    end)
end


function BattleCardGameHandbookDialog:OnClickRightButtonHnadler_()
    CfUtils.WaitCallbackSafeTo(function()
        local animTime = CfUtils.GetAnimatorTime(self.AnimNode, AnimationName.ToPage2)
        CfUtils.PlayAnimator(self.AnimNode, AnimatoName.ToPage2)
        CoYield(animTime)
    end)
end


return BattleCardGameHandbookDialog
