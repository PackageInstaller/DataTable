
------------ import ------------

------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/Common/CommonCardSkillDesc.prefab
---@class CardProgressionSkillDescKeywordCell
---@field Env                           	CardProgressionSkillDescKeywordCell                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgBg                         	UnityEngine.RectTransform               
---@field Text                          	UnityEngine.UI.Text                     
local CardProgressionSkillDescKeywordCell = Class('CardProgressionSkillDescKeywordCell')

function CardProgressionSkillDescKeywordCell:__init()

end


function CardProgressionSkillDescKeywordCell:__delete()

end


function CardProgressionSkillDescKeywordCell:Awake()
end


function CardProgressionSkillDescKeywordCell:Start()
end


function CardProgressionSkillDescKeywordCell:OnDestroy()
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

function CardProgressionSkillDescKeywordCell:FreshUI(text)
    self.Text.text = text
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


return CardProgressionSkillDescKeywordCell
