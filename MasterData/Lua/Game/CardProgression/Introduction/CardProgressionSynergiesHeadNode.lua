
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type GoodsConfMgr
local goodsConfMgr     = GoodsConfMgr:GetInstance()
---@type CardConfMgr
local cardConfMgr      = CardConfMgr:GetInstance()
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFetterHeadNode.prefab
---@class CardProgressionSynergiesHeadNode
---@field Env                           	CardProgressionSynergiesHeadNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Lock                          	UnityEngine.RectTransform               
---@field UnLock                        	UnityEngine.RectTransform               
---@field ImgHeadIcon                   	Engine.UI.ImageAlterable                
---@field HasObtained                   	UnityEngine.RectTransform               
---@field NotObtain                     	UnityEngine.RectTransform               
local CardProgressionSynergiesHeadNode = Class('CardProgressionSynergiesHeadNode')

function CardProgressionSynergiesHeadNode:__init()

end


function CardProgressionSynergiesHeadNode:__delete()

end


function CardProgressionSynergiesHeadNode:Awake()
end


function CardProgressionSynergiesHeadNode:Start()
end


function CardProgressionSynergiesHeadNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionSynergiesHeadNode:FreshUI(cardId, isUnlock, vo)
    local isOwnSynergies = cardId ~= nil
    KTool.SetActive(self.NotObtain.gameObject, not isOwnSynergies)
    KTool.SetActive(self.HasObtained.gameObject, isOwnSynergies)
    if isOwnSynergies then
        ---@type CardVo
        local cardVo = cardConfMgr:GetCardByRefId(cardId)
        ---@type CardSkinVo
        local skinVo = cardConfMgr:GetCardSkinBySkinId(cardVo.defaultSkin)
        -----@type GoodsVo
        --local vo = goodsConfMgr:GetGoodsVoById(cardId)
        self.ImgHeadIcon:LoadSprite(skinVo.buffHead)

        KTool.SetActive(self.UnLock.gameObject, isUnlock)
        KTool.SetActive(self.Lock.gameObject,   not isUnlock)
    end

    if vo then
        SetButtonAction(self.controller.gameObject, function ()
            CardProgressionUtils.OpenDialog(Constants.UITypeIds.CardProgressionSynergiesTips, {cardId = cardId, vo = vo, isUnlock = isUnlock})
        end)
    end
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


return CardProgressionSynergiesHeadNode
