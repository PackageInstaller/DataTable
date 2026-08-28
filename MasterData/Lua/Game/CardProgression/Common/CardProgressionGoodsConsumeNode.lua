
------------ import ------------
---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------
local GoodNodeMB                          =  "Game.Behaviours.GoodNodeMB"
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaGoodsConsumeNode.prefab
---@class CardProgressionGoodsConsumeNode
---@field Env                           	CardProgressionGoodsConsumeNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field AnimationCompBtnReduce        	UnityEngine.Animation                   
---@field PressCompBtnReduce            	Engine.UI.ButtonLongPress               
---@field SelectNode                    	UnityEngine.CanvasGroup                 
---@field TxtPlusNumber                 	TMPro.TextMeshProUGUI                   
---@field GoodNode                      	UnityEngine.RectTransform               
---@field AnimationComp                 	UnityEngine.Animation                   
---@field PressComp                     	Engine.UI.ButtonLongPress               
local CardProgressionGoodsConsumeNode = Class('CardProgressionGoodsConsumeNode')

function CardProgressionGoodsConsumeNode:__init()
    
end


function CardProgressionGoodsConsumeNode:__delete()

end


function CardProgressionGoodsConsumeNode:Awake()
    KTool.SetActive(self.SelectNode.gameObject, true)
end


function CardProgressionGoodsConsumeNode:Start()
    self:InitPressComp()
end


function CardProgressionGoodsConsumeNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionGoodsConsumeNode:InitPressComp()
    local PressComp = self.PressComp
    PressComp.onPointerDown = function()
        self.AnimationComp:Play("UI_Common_ButtonPressed")
        if self._downCallback then
            self._downCallback()
        end
    end
    PressComp.onPointerUp = function()
        self.AnimationComp:Play("UI_Common_ButtonIdle")
    end
    PressComp.onPointerExit = function()
        self.AnimationComp:Play("UI_Common_ButtonIdle")
    end
    PressComp.onClick = function()
        if self._clickCallback then
            self._clickCallback()
        end
    end
    PressComp.onLongPress = function(durationSeconds)
        if self._longPressCallback then
            self._longPressCallback(PressComp, durationSeconds)
        end
    end
    
    PressComp = self.PressCompBtnReduce
    PressComp.onPointerDown = function()
        self.AnimationCompBtnReduce:Play("UI_Common_ButtonPressed")
    end
    PressComp.onPointerUp = function()
        self.AnimationCompBtnReduce:Play("UI_Common_ButtonIdle")
    end
    PressComp.onPointerExit = function()
        self.AnimationCompBtnReduce:Play("UI_Common_ButtonIdle")
        if self._pointerExitCallback then
            self._pointerExitCallback()
        end
    end
    PressComp.onClick = function()
        if self._clickCallbackReduce then
            self._clickCallbackReduce()
        end
    end
    PressComp.onLongPress = function(durationSeconds)
        if self._longPressCallbackReduce then
            self._longPressCallbackReduce(PressComp, durationSeconds)
        end
    end
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshGoodsConsumeNode
---@param consumeData table{
---    ownNum: number      道具拥有数量
---    selectNum: number   道具选择数量
---    index: number       _consumeGoodsList 或 _goodsConsumeNodes 所对应的下标
---    goodsId: number     道具id
---}
function CardProgressionGoodsConsumeNode:FreshUI(consumeData)
    self:FreshGoodNode(consumeData)

    self:FreshSelectNode(consumeData)
end

function CardProgressionGoodsConsumeNode:FreshGoodNode(consumeNodeData)
    ---@type GoodNodeMB
    local env = CfUtils.GetLuaScr(self.GoodNode.gameObject, GoodNodeMB)
    if isNull(env) then return end
    env:Reload({
        goodsId = consumeNodeData.goodsId,
        isShowNo = true,
        text = consumeNodeData.ownNum
    })

end

function CardProgressionGoodsConsumeNode:FreshSelectNode(consumeData)
    local selectNum = consumeData.selectNum
    local isSelect  = selectNum > 0
    GameUtils.UpdateUIShowStateByCanvasGroup(self.SelectNode, isSelect)
    if isSelect then
        self.TxtPlusNumber.text = selectNum    

    end

end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionGoodsConsumeNode:SetDownCallback(callback)
    self._downCallback = callback
end
function CardProgressionGoodsConsumeNode:SetClickCallback(callback)
    self._clickCallback = callback
end
function CardProgressionGoodsConsumeNode:SetLongPressCallback(callback)
    self._longPressCallback = callback
end
function CardProgressionGoodsConsumeNode:SetClickCallbackReduce(callback)
    self._clickCallbackReduce = callback
end
function CardProgressionGoodsConsumeNode:SetLongPressCallbackReduce(callback)
    self._longPressCallbackReduce = callback
end

function CardProgressionGoodsConsumeNode:SetPointerExitCallback(callback)
    self._pointerExitCallback = callback
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


return CardProgressionGoodsConsumeNode
