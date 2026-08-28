-------------------------------------------------------------------------------
-- 和风战牌 - 主容器背景
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-18 18:27:00
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerEnterBgDialog.prefab > name: ActivityJapanesePokerEnterBgDialog
---@class BattleCardGameMainBgNode
---@field Env                           	BattleCardGameMainBgNode                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BgContainer                   	UnityEngine.RectTransform               	@ 0    背景容器
local BattleCardGameMainBgNode = Class('BattleCardGameMainBgNode')


function BattleCardGameMainBgNode:__init()
end


function BattleCardGameMainBgNode:__delete()
end


function BattleCardGameMainBgNode:Awake()
end


function BattleCardGameMainBgNode:Start()
end


function BattleCardGameMainBgNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- public

function BattleCardGameMainBgNode:PlayEnterAnim()
    CfUtils.PlayAnimation(self.BgContainer, 'ActivityJapanesePokerDialog_Entry')
end


return BattleCardGameMainBgNode
