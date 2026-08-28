
--region global define
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
---@type CatBallUtils
local CatBallUtils                = import("Game.CatBall.CatBallUtils")
--endregion

--region define
local UISwitchImageType           = typeof(CS.Game.Native.Common.UISwitchImage)

local SkillAndAttributeEnvPath    = "Game.CatBall.CatBallChooseCardsSkillAndAttributeNode"
--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballCultivateDialog.prefab
---@class CatBallCultivateInformationPanel
---@field Env                           	CatBallCultivateInformationPanel        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field SkillAndAttributeNode         	UnityEngine.RectTransform               
---@field TextName                      	UnityEngine.UI.Text                     
---@field ImgAttributeIcon              	Engine.UI.ImageAlterable                
---@field BtnAttribute                  	UnityEngine.RectTransform               
---@field StarNode                      	UnityEngine.RectTransform               
---@field ImgRareIcon                   	Game.Native.Common.UISwitchImage        
---@field ImgRareBg2                    	Game.Native.Common.UISwitchImage        
local CatBallCultivateInformationPanel = Class('CatBallCultivateInformationPanel')

function CatBallCultivateInformationPanel:__init()
    self._starNodes = {}
end


function CatBallCultivateInformationPanel:__delete()

end


function CatBallCultivateInformationPanel:Awake()
    -- local starNodes = {}
    -- local parent = self.StarNode
    
    -- for index, value in ipairs() do
    --     -- body
    -- end
end


function CatBallCultivateInformationPanel:Start()
    SetButtonAction(self.BtnAttribute, Bind(self, self.OnClickBtnAttributeAction))
end


function CatBallCultivateInformationPanel:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param dojo CatEggDojo
---@param panelEnv CatBallCultivateDialog
function CatBallCultivateInformationPanel:FreshUI(dojo, panelEnv)
    self._panelEnv = panelEnv
    ---@type CatBallVo
    local vo = CatBallUtils.GetCatBallVo(dojo.catId)
    local rare = vo.rare

    self.ImgRareBg2.Status = rare
    self.ImgRareIcon.Status = rare

    self:FreshStarNodes(dojo.star, vo.starMax) 

    self.ImgAttributeIcon:LoadSprite(CatBallUtils.GetAttributeIcon(vo.types, vo.subtype))

    self.TextName.text = vo.name

    self:FreshSkillAndAttribute(dojo)
end

function CatBallCultivateInformationPanel:FreshStarNodes(star, maxStar)
    for i = 1, maxStar do
        ---@type Game.Native.Common.UISwitchImage
        local node = self._starNodes[i]
        if isNull(node) then
            local trans = self.StarNode:Find(string.format("ImgStar%s", i))
            if isNotNull(trans) then
                node = trans.gameObject:GetComponent(UISwitchImageType)
                self._starNodes[i] = node
            end
        end

        if isNotNull(node) then
            node.Status = i > star and 1 or 2
        end
    end
end

function CatBallCultivateInformationPanel:FreshSkillAndAttribute(catEggDojo)
    local skillAndAttributeEnv = self:GetSkillAndAttributeEnv()
    if isNull(skillAndAttributeEnv) then return end
    skillAndAttributeEnv:FreshUI(catEggDojo) 
end

--endregion 


--region get/set 

---GetSkillAndAttributeEnv
---@return CatBallChooseCardsSkillAndAttributeNode
function CatBallCultivateInformationPanel:GetSkillAndAttributeEnv()
    if isNull(self._skillAndAttributeEnv) then
        self._skillAndAttributeEnv = CfUtils.GetLuaScr(self.SkillAndAttributeNode.gameObject, SkillAndAttributeEnvPath)
    end
    return self._skillAndAttributeEnv
end

---endregion 


--region handler 

function CatBallCultivateInformationPanel:OnClickBtnAttributeAction()
    if isNotNull(self._panelEnv) then
        self._panelEnv:SetIsRestCameraState(true)
    end
    CfUtils.DialogOpen(Constants.UITypeIds.CatBallAttributeIconPreview, nil, nil, true)
end

---endregion 


return CatBallCultivateInformationPanel
