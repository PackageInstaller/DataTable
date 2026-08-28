
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFeeling.prefab
---@class CardProgressionFavorConsumeNode
---@field Env                           	CardProgressionFavorConsumeNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgFavorite                  	    UnityEngine.RectTransform               
---@field GoodsConsumeNode              	UnityEngine.RectTransform               
local CardProgressionFavorConsumeNode = Class('CardProgressionFavorConsumeNode')

function CardProgressionFavorConsumeNode:__init()

end


function CardProgressionFavorConsumeNode:__delete()

end


function CardProgressionFavorConsumeNode:Awake()
end


function CardProgressionFavorConsumeNode:Start()
end


function CardProgressionFavorConsumeNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


function CardProgressionFavorConsumeNode:InitPressComp()
    ---@type CardProgressionGoodsConsumeNode
    local env = self:GetConsumeNodeEnv()
    if not isNull(env) then
        env:SetDownCallback(function()
            if self._downCallback then
                self._downCallback()
            end
        end)
        env:SetClickCallback(function ()
            if self._clickCallback then
                self._clickCallback()
            end
        end)
        env:SetLongPressCallback(function (pressComp, durationSeconds)
            if self._longPressCallback then
                self._longPressCallback(pressComp, durationSeconds)
            end
        end)
        env:SetClickCallbackReduce(function ()
            if self._clickCallbackReduce then
                self._clickCallbackReduce()
            end
        end)
        env:SetLongPressCallbackReduce(function (pressComp, durationSeconds)
            if self._longPressCallbackReduce then
                self._longPressCallbackReduce(pressComp, durationSeconds)
            end
        end)
    end
end


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
function CardProgressionFavorConsumeNode:FreshUI(consumeData, index)
    self:FreshConsumeNode(consumeData)
    KTool.SetActive(self.ImgFavorite.gameObject, index == 1)
end

function CardProgressionFavorConsumeNode:FreshConsumeNode(consumeData)
    ---@type CardProgressionGoodsConsumeNode
    local env = self:GetConsumeNodeEnv()
    if not isNull(env) then
        env:FreshUI(consumeData)
    end
end

function CardProgressionFavorConsumeNode:FreshSelectNode(consumeData)
    ---@type CardProgressionGoodsConsumeNode
    local env = self:GetConsumeNodeEnv()
    if not isNull(env) then
        env:FreshSelectNode(consumeData)
    end
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

--- GetConsumeNodeEnv
---@return CardProgressionGoodsConsumeNode
function CardProgressionFavorConsumeNode:GetConsumeNodeEnv()
    if self._consumeNodeEnv then
        return self._consumeNodeEnv
    end
    ---@type CardProgressionGoodsConsumeNode
    local env = CfUtils.GetLuaScr(self.GoodsConsumeNode, CardProgressionConstants.EnvPath.CardProgressionGoodsConsumeNode)
    self._consumeNodeEnv = env
    return env
end

function CardProgressionFavorConsumeNode:SetDownCallback(cb)
    self._downCallback = cb
end

function CardProgressionFavorConsumeNode:SetClickCallback(cb)
    self._clickCallback = cb
end

function CardProgressionFavorConsumeNode:SetLongPressCallback(cb)
    self._longPressCallback = cb
end

function CardProgressionFavorConsumeNode:SetClickCallbackReduce(cb)
    self._clickCallbackReduce = cb
end

function CardProgressionFavorConsumeNode:SetLongPressCallbackReduce(cb)
    self._longPressCallbackReduce = cb
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionFavorConsumeNode
