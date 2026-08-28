
------------ import ------------

------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/Common/CommonCardSkillDesc.prefab
---@class CardProgressionSkillDescBuffTipNode
---@field Env                           	CardProgressionSkillDescBuffTipNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TxtDescribe                   	UnityEngine.UI.Text                     
---@field ImgIcon                       	Engine.UI.ImageAlterable                
---@field IconNode                      	UnityEngine.RectTransform               
local CardProgressionSkillDescBuffTipNode = Class('CardProgressionSkillDescBuffTipNode')

function CardProgressionSkillDescBuffTipNode:__init()

end


function CardProgressionSkillDescBuffTipNode:__delete()

end


function CardProgressionSkillDescBuffTipNode:Awake()
end


function CardProgressionSkillDescBuffTipNode:Start()
end


function CardProgressionSkillDescBuffTipNode:OnDestroy()
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

function CardProgressionSkillDescBuffTipNode:FreshUI(photoPath, text)
    self.ImgIcon:LoadSprite(photoPath)
    self.TxtDescribe.text = text
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


return CardProgressionSkillDescBuffTipNode

