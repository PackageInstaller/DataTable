
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Hotpoint/HotpointNewCombatantBtnHead.prefab > name: HotpointNewCombatantBtnHead
---@class HotPointCollectionNewCombatantBtnHead
---@field Env                           	HotPointCollectionNewCombatantBtnHead   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgSelect                     	UnityEngine.RectTransform               
---@field ImgHead                       	Engine.UI.ImageAlterable                
---@field ImgRound                      	Game.Native.Common.UISwitchImage        
local HotPointCollectionNewCombatantBtnHead = Class('HotPointCollectionNewCombatantBtnHead')

function HotPointCollectionNewCombatantBtnHead:__init()

end


function HotPointCollectionNewCombatantBtnHead:__delete()

end


-- function HotPointCollectionNewCombatantBtnHead:Awake()
-- end


function HotPointCollectionNewCombatantBtnHead:Start()
    SetButtonAction(self.controller, Bind(self, self.OnClickBtnHeadAction))
end


function HotPointCollectionNewCombatantBtnHead:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function HotPointCollectionNewCombatantBtnHead:FreshUI(data, i)
    local cardId = data.cardId
    ---@type CardVo
    local vo     = cardConfMgr:GetCardByRefId(cardId)
    if vo == nil then return end
    local skinId = data.skinId or vo.defaultSkin
    ---@type CardSkinVo
    local skinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
    if skinVo == nil then return end
    self.ImgHead:LoadSprite(skinVo.buffHead)

    self.ImgRound.Status = vo.rare == Constants.RareType.SR and 1 or 2

end

function HotPointCollectionNewCombatantBtnHead:FreshSelectState(isSelect)
    CfUtils.SetActive(self.ImgSelect, isSelect)

end

--endregion 


--region get/set 

function HotPointCollectionNewCombatantBtnHead:SetCallback(callback)
    self._callback = callback
end

---endregion 


--region handler 

function HotPointCollectionNewCombatantBtnHead:OnClickBtnHeadAction()
    if self._callback then
        self._callback()
    end
end

---endregion 


return HotPointCollectionNewCombatantBtnHead
