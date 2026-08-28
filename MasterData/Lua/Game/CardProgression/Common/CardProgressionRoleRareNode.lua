
------------ import ------------

------------ import ------------


------------ define ------------
---@type CardConfMgr
local cardConfMgr        = CardConfMgr:GetInstance()
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaRoleRareNode.prefab > name: CultivateOverseaRoleRareNode
---@class CardProgressionRoleRareNode
---@field Env                           	CardProgressionRoleRareNode             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgIcon                       	Engine.UI.ImageAlterable                	@ 0    
---@field BtnCareer                     	UnityEngine.RectTransform               	@ 1    
---@field TextEnglish                   	TMPro.TextMeshProUGUI                   	@ 2    
---@field TextNameRole                  	CustomText                              	@ 3    
---@field TextName                      	CustomText                              	@ 4    
---@field TxtCV                         	UnityEngine.UI.Text                     	@ 5    
---@field ImgRareIcon2                  	Game.Native.Common.UISwitchImage        	@ 6    
---@field Brush                         	Game.Native.Common.UISwitchImage        	@ 7    
---@field ImgRareIcon                   	Game.Native.Common.UISwitchImage        	@ 8    
local CardProgressionRoleRareNode = Class('CardProgressionRoleRareNode')

function CardProgressionRoleRareNode:__init()

end


function CardProgressionRoleRareNode:__delete()

end


function CardProgressionRoleRareNode:Awake()
end


function CardProgressionRoleRareNode:Start()
    SetButtonAction(self.BtnCareer, Bind(self, self.OnClickBtnCareerAction))
end


function CardProgressionRoleRareNode:OnDestroy()
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

function CardProgressionRoleRareNode:FreshUI(rare, cardId, skinId)
    self.ImgRareIcon2.Status = rare
    self.Brush.Status        = rare
    self.ImgRareIcon.Status  = rare

    local name, roleName, cardVo
    if skinId then
        ---@type CardSkinVo
        local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
        name, roleName = cardSkinVo.name, cardSkinVo.desc
        ---@type CardVo
        cardVo = cardConfMgr:GetCardByRefId(cardSkinVo.roleId)
    else
        ---@type CardVo
        cardVo = cardConfMgr:GetCardByRefId(cardId)
        name, roleName = cardVo.name, cardVo.descr
    end
    self._cardVo = cardVo

    ---@type RolesVo
    local roleVo = cardConfMgr:GetRolesVo(cardVo.characterId)
    self.TextName.text     = roleName
    self.TextNameRole.text = name
    self.TextEnglish.text  = roleVo.englishName

    ---@type JobVo
    local jobVo = cardConfMgr:GetCardCareerRowByType(cardVo.career)
    self.ImgIcon:LoadSprite(jobVo.largeIcon)
end

function CardProgressionRoleRareNode:FreshCV()
    local cardCvName = self._cardVo.cv
    local isEmptyCv  = string.isEmpty(cardCvName)
    CfUtils.SetActive(self.TxtCV, not isEmptyCv)
    if not isEmptyCv then
        CfUtils.FillText(self.TxtCV, localize('CV: _name_', {_name_ = cardCvName}))
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

function CardProgressionRoleRareNode:OnClickBtnCareerAction()
    CfUtils.DialogOpen(Constants.UITypeIds.CardProgressionCareerPreview)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionRoleRareNode
