
------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaBreakPreview.prefab
---@class CardProgressionBreakPreview
---@field Env                           	CardProgressionBreakPreview
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field BtnClose                      	UnityEngine.RectTransform
---@field ScrollView                    	SuperScrollView.LoopGridView
local CardProgressionBreakPreview = Class('CardProgressionBreakPreview')


function CardProgressionBreakPreview:__init()
end


function CardProgressionBreakPreview:__delete()
    self.controller = nil
end


function CardProgressionBreakPreview:Awake()
end


function CardProgressionBreakPreview:OnFocus(focus)

end


function CardProgressionBreakPreview:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        SetButtonAction(self.BtnClose, function()
            UIModule.CloseDialog(self.controller)
        end)
        self:InitData()
        self:FreshScrollView()
    end))
    return coWait
end


function CardProgressionBreakPreview:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionBreakPreview:InitData()
    local parameters = self.controller.Argument.parameters
    local cardId   = parameters.cardId
    self._cardId    = cardId

    self._maxBreakTimes = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxBreakTimes))
    -- local cardConfMgr = CardConfMgr:GetInstance()
    -- ---@type CardAwakenVo[]
    -- local vos = cardConfMgr:GetCardAwakenVosByCardId(cardId)

end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------
--- FreshScrollView
--- 刷新所有标签
function CardProgressionBreakPreview:FreshScrollView()
    local ScrollView = self.ScrollView
    local count      = self._maxBreakTimes - 1
    if not ScrollView.IsListViewInit then
        ScrollView:InitGridView(count, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end

end

function CardProgressionBreakPreview:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(CardProgressionConstants.NodeNames.Cell)
    local node = GetLuaBehaviour(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionListCell)
    
    ---@type CardProgressionBreakNode
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
        nodeEnv:InitLuaEnvPath(CardProgressionConstants.EnvPath.CardProgressionBreakNode)
    else
        nodeEnv = node.Env
    end
    
    if nodeEnv then
        local level = index + 1
        nodeEnv:FreshUI(self._cardId, level + 1, 2)
    end

    return cell
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionBreakPreview
