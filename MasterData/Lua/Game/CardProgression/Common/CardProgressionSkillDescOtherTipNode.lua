
------------ import ------------

------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/Common/CommonCardSkillDesc.prefab
---@class CardProgressionSkillDescOtherTipNode
---@field Env                           	CardProgressionSkillDescOtherTipNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TxtDescribe                   	UnityEngine.UI.Text                     
---@field TxtTitle                      	UnityEngine.UI.Text                     
local CardProgressionSkillDescOtherTipNode = Class('CardProgressionSkillDescOtherTipNode')

function CardProgressionSkillDescOtherTipNode:__init()

end


function CardProgressionSkillDescOtherTipNode:__delete()

end


function CardProgressionSkillDescOtherTipNode:Awake()
end


function CardProgressionSkillDescOtherTipNode:Start()
end


function CardProgressionSkillDescOtherTipNode:OnDestroy()
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

function CardProgressionSkillDescOtherTipNode:FreshUI(data)
    self.TxtTitle.text    = data.name
    self.TxtDescribe.text = data.skillDesc
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


return CardProgressionSkillDescOtherTipNode

