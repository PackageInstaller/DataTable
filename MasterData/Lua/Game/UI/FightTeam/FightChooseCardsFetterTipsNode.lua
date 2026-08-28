
------------ import ------------
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaRaceTips.prefab
---@class FightChooseCardsFetterTipsNode
---@field Env                           	FightChooseCardsFetterTipsNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TextDesc                      	UnityEngine.UI.Text                     
---@field TextTitle                     	UnityEngine.UI.Text                     
---@field ImgRace                       	Engine.UI.RawImageAlterable             
---@field Arrow                         	UnityEngine.RectTransform               
---@field Bg                            	UnityEngine.RectTransform               
local FightChooseCardsFetterTipsNode = Class('FightChooseCardsFetterTipsNode', CommonTipsBoard)

function FightChooseCardsFetterTipsNode:__init()
    CommonTipsBoard.__init(self)
end

function FightChooseCardsFetterTipsNode:__delete()
    CommonTipsBoard.__delete(self)
end

function FightChooseCardsFetterTipsNode:Awake()
    CommonTipsBoard.Awake(self)
end

function FightChooseCardsFetterTipsNode:Start()
    CommonTipsBoard.Start(self)
end

function FightChooseCardsFetterTipsNode:OnDestroy()
    CommonTipsBoard.OnDestroy(self)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end

function FightChooseCardsFetterTipsNode:RefreshBoardByContent(title, desc)
    CfUtils.FillText(self.TextTitlem, title)
    CfUtils.FillText(self.TextDesc, desc)
end

return FightChooseCardsFetterTipsNode
