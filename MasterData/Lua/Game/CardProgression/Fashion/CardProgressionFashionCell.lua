
------------ import ------------
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardSkinComponent
local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
local IdolLive3D_Utils = import('Game.IdolLive3D.IdolLive3D_Utils')
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFashion.prefab > name: Cell
---@class CardProgressionFashionCell
---@field Env                           	CardProgressionFashionCell              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgInteract                   	UnityEngine.RectTransform               	@ 0    可交互标识
---@field ImgNew                        	UnityEngine.RectTransform               	@ 1    
---@field CurrentSelectSymbol           	UnityEngine.Animation                   	@ 2    
---@field TextNumberLevel               	TMPro.TextMeshProUGUI                   	@ 3    
---@field Level                         	UnityEngine.RectTransform               	@ 4    
---@field HasWornSymbol                 	UnityEngine.RectTransform               	@ 5    
---@field RareLineImg                   	UnityEngine.RectTransform               	@ 6    
---@field BrandImg                      	UnityEngine.RectTransform               	@ 7    
---@field ImgRare2                      	Game.Native.Common.UISwitchImage        	@ 8    
---@field RareNode                      	UnityEngine.RectTransform               	@ 9    
---@field TextFashionName               	UnityEngine.UI.Text                     	@ 10   
---@field ImgLock                       	UnityEngine.RectTransform               	@ 11   
---@field StatusNotGet                  	UnityEngine.RectTransform               	@ 12   
---@field ImgRole                       	Engine.UI.RawImageAlterable             	@ 13   
---@field Group                         	UnityEngine.Animation                   	@ 14   
---@field UIFX_Skin_Up                  	UnityEngine.RectTransform               	@ 15   
---@field UIFX_Skin_Down                	UnityEngine.RectTransform               	@ 16   
local CardProgressionFashionCell = Class('CardProgressionFashionCell')

function CardProgressionFashionCell:__init()

end


function CardProgressionFashionCell:__delete()

end


function CardProgressionFashionCell:Start()
    SetButtonAction(self.Group, Bind(self, self.OnClickGroupAction))
end


function CardProgressionFashionCell:OnDestroy()
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

--- FreshUI
---@param data table{
---@    skinVo: CardSkinVo
---@    isUnlock: boolean
---@}
function CardProgressionFashionCell:FreshUI(data, index, equippedIndex)
    self._index  = index
    ---@type CardSkinVo
    local skinVo = data.skinVo
    self._skinVo = skinVo
    self.TextFashionName.text = skinVo.name

    CfUtils.FillImage(self.ImgRole, tostring(skinVo.cardHeadList))
    CardUtils.RefreshCardSkinEffectHead(skinVo, self.ImgRole, self.UIFX_Skin_Up, self.UIFX_Skin_Down)

    local isUnlock = data.isUnlock
    self._isUnlock = isUnlock
    CfUtils.SetActive(self.StatusNotGet, not isUnlock)

    -- update skin rare
    local skinRare = skinVo:GetRare()
    CfUtils.SetUISwitchImage(self.ImgRare2, skinRare)
    CfUtils.SetUISwitchImage(self.RareLineImg, skinRare)

    -- update skin brand
    if string.isEmpty(skinVo.version) then
        CfUtils.SetActive(self.BrandImg, false)
    else
        CfUtils.SetActive(self.BrandImg, true)
        CfUtils.FillImage(self.BrandImg, skinVo.version)
    end

    local isInteractive = IdolLive3D_Utils.GetLive3DCardVoRow(skinVo.skinId)
    CfUtils.SetActive(self.ImgInteract, isInteractive)
    
    CfUtils.SetActive(self.HasWornSymbol, equippedIndex == index)
    self:FreshImgNewShowState(skinVo.skinId)
    self:FreshLevel(skinVo, isUnlock)
end


function CardProgressionFashionCell:FreshSelectState(isSelect)
    self.Group:Play(isSelect and "CultivateOverseaFashionScrollSelect" or "CultivateOverseaFashionScrollDefault")
    CfUtils.SetActive(self.CurrentSelectSymbol, isSelect)
    if isSelect then
        local skinMaxLevel = self._skinVo.skinMaxLevel
        local isShowLv = skinMaxLevel > 0 and self._isUnlock == true
        self.CurrentSelectSymbol:Play(isShowLv and "CultivateOverseaFashionScrollLevelSelect" or "CultivateOverseaFashionScrollLevelDefault")
    
    end
end

function CardProgressionFashionCell:FreshLevel(skinVo, isUnlock)
    local skinMaxLevel = skinVo.skinMaxLevel
    local isShowLv = isUnlock and skinMaxLevel > 0
    CfUtils.SetActive(self.Level, isShowLv)
    if isShowLv then
        self:FreshLevelNumber(skinVo)
    end
end


function CardProgressionFashionCell:FreshLevelNumber(skinVo)
    local level = cardSkinComponent:GetSkinLevelById(skinVo.skinId, skinVo.skinMaxLevel)
    self.TextNumberLevel.text = string.format("Lv.%s", level)
end

function CardProgressionFashionCell:FreshImgNewShowState(skinId)
    if self.ImgNew then
        CfUtils.SetActive(self.ImgNew, cardSkinComponent:GetIsNewBySkinId(skinId))
    end
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionFashionCell:SetCallback(callback)
    self._callback = callback
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionFashionCell:OnClickGroupAction()
    if self._callback then
        local isSelect = self._callback(self._index)
        if isSelect then
            self:FreshSelectState(isSelect)
        end
    end
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionFashionCell
