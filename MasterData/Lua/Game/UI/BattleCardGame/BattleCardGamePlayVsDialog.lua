-------------------------------------------------------------------------------
-- 和风战牌 - 打牌开场vs动画
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-09-06 10:10:48
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

local ENTER_ANIM_NAME = {
    SHOW = 'ActivityJapanesePokerCard_Entry',
    HIDE = 'ActivityJapanesePokerCard_Out',
}


--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerBattle/ActivityJapanesePokerCardVs.prefab > name: ActivityJapanesePokerCardVs
---@class BattleCardGamePlayVsDialog
---@field Env                           	BattleCardGamePlayVsDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field AnimNode                      	UnityEngine.RectTransform               	@ 1    动画节点
---@field RedFirstNode                  	UnityEngine.RectTransform               	@ 2    红方-先手节点
---@field RedTitleTxt                   	UnityEngine.RectTransform               	@ 3    红方 标题
---@field RedNameTxt                    	UnityEngine.RectTransform               	@ 4    红方 名字
---@field RedHeadNode                   	UnityEngine.RectTransform               	@ 5    红方 头像
---@field RedCardParent                 	UnityEngine.RectTransform               	@ 6    红方 卡牌父节点
---@field BlueFirstNode                 	UnityEngine.RectTransform               	@ 7    蓝方-先手节点
---@field BlueTitleTxt                  	UnityEngine.RectTransform               	@ 8    蓝方 标题
---@field BlueNameTxt                   	UnityEngine.RectTransform               	@ 9    蓝方 名字
---@field BlueHeadNode                  	UnityEngine.RectTransform               	@ 10   蓝方 头像
---@field BlueCardParent                	UnityEngine.RectTransform               	@ 11   蓝方 卡牌父节点
local BattleCardGamePlayVsDialog = Class('BattleCardGamePlayVsDialog')


function BattleCardGamePlayVsDialog:__init()
    ---@type fun():void @ 关闭回调
    self.closeCallback_ = nil

    ---@type UnityEngine.Coroutine @ 播放动画协程
    self.playEnterAnimCo_ = nil
end


function BattleCardGamePlayVsDialog:__delete()
    self.closeCallback_   = nil
    self.playEnterAnimCo_ = nil
end


function BattleCardGamePlayVsDialog:Awake()
end


function BattleCardGamePlayVsDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams    = CfUtils.DialogSafeParameters(self.controller)
        self.closeCallback_ = initParams.closeCb
        self:UpdateViewInfo_()
        
        self.playEnterAnimCo_ = CoStart(function()
            -- wait show anim
            local showAnimTime = CfUtils.GetAnimationTime(self.AnimNode, ENTER_ANIM_NAME.SHOW)
            CoYield(showAnimTime)
            
            -- play hide anim
            CfUtils.PlayAnimation(self.AnimNode, ENTER_ANIM_NAME.HIDE)
            
            -- wait hide anim
            local hideAnimTime = CfUtils.GetAnimationTime(self.AnimNode, ENTER_ANIM_NAME.HIDE)
            CoYield(hideAnimTime)

            -- close
            if self.closeCallback_ then
                self.closeCallback_()
            end
            self:Close()
        end)
    end)
end


function BattleCardGamePlayVsDialog:OnFinalize()
    return CoWaitDo(function()
        CoStop(self.playEnterAnimCo_)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- public

function BattleCardGamePlayVsDialog:Close()
    CfUtils.DialogClose(self.controller)
end


-------------------------------------------------
-- private

function BattleCardGamePlayVsDialog:UpdateViewInfo_()
    local roundPlayerId = battleCardGameComp:GetPlayDojo().roundPlayerId
    local npcQuestId    = battleCardGameComp:GetPlayDojo().npcQuestId

    -- update opponent info
    local opponentDojo = battleCardGameComp:GetPlayDojo().opponentDojo
    CfUtils.SetActive(self.RedFirstNode, opponentDojo.playerId == roundPlayerId)
    CfUtils.FillText(self.RedTitleTxt, localize('挑战者'))
    CfUtils.FillText(self.RedNameTxt, opponentDojo.playerName)

    if npcQuestId > 0 then
        local npcQuestVo = BattleCardGameUtils.GetNpcQuestVo(npcQuestId)
        CfUtils.FillText(self.RedTitleTxt, npcQuestVo.npcTitle)
    end

    ---@type CommonPlayerHeadNode
    local operatorPlayerNode = CfUtils.GetLuaScr(self.RedHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    operatorPlayerNode:FreshAvatarFrame(opponentDojo.avatarId, opponentDojo.frameId)
    
    for cardIndex, battleCardId in ipairs(opponentDojo.handCards) do
        ---@type UnityEngine.RectTransform
        local cardParentNode = self.RedCardParent:Find(string.fmt('Card%1', cardIndex))
        BattleCardGameUtils.UpcateBattleCardNode(cardParentNode:Find('PokerCardNode'), battleCardId, {isRed = true, isBack = true})
    end

    -------------------------------------------------
    -- update player info
    local operatorDojo = battleCardGameComp:GetPlayDojo().operatorDojo
    CfUtils.SetActive(self.BlueFirstNode, operatorDojo.playerId == roundPlayerId)
    CfUtils.FillText(self.BlueTitleTxt, localize('挑战者'))
    CfUtils.FillText(self.BlueNameTxt, operatorDojo.playerName)

    ---@type CommonPlayerHeadNode
    local opponentPlayerNode = CfUtils.GetLuaScr(self.BlueHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    opponentPlayerNode:FreshAvatarFrame(operatorDojo.avatarId, operatorDojo.frameId)

    for cardIndex, battleCardId in ipairs(operatorDojo.handCards) do
        ---@type UnityEngine.RectTransform
        local cardParentNode = self.BlueCardParent:Find(string.fmt('Card%1', cardIndex))
        BattleCardGameUtils.UpcateBattleCardNode(cardParentNode:Find('PokerCardNode'), battleCardId, {isBlue = true})
    end
end


return BattleCardGamePlayVsDialog
