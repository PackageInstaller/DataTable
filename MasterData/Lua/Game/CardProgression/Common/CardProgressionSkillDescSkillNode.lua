
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
------------ import ------------


------------ define ------------
local SelectScale = Vector3.New(0.8, 0.8, 1)
local NormalScale = Vector3.New(0.7, 0.7, 1)
------------ define ------------

--- from: Assets/BundleResources/Prefabs/Common/CommonCardSkillDesc.prefab
---@class CardProgressionSkillDescSkillNode
---@field Env                           	CardProgressionSkillDescSkillNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgArrow                      	UnityEngine.RectTransform               
---@field ImgSelect                     	UnityEngine.RectTransform               
---@field SkillCardNode                 	UnityEngine.RectTransform               
local CardProgressionSkillDescSkillNode = Class('CardProgressionSkillDescSkillNode')

function CardProgressionSkillDescSkillNode:__init()

end


function CardProgressionSkillDescSkillNode:__delete()

end


function CardProgressionSkillDescSkillNode:Awake()
    self.Scale = self.controller.transform:Find("Scale")
end


function CardProgressionSkillDescSkillNode:Start()
end


function CardProgressionSkillDescSkillNode:OnDestroy()
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
---@param data table {}
function CardProgressionSkillDescSkillNode:FreshUI(data, cardVo, isHideLv)
    self:FreshSkillCardNode(data, cardVo, isHideLv)
end

function CardProgressionSkillDescSkillNode:FreshSkillCardNode(data, cardVo, isHideLv)
    ---@type CardProgressionSkillNode
    local env = CfUtils.GetLuaScr(self.SkillCardNode, CardProgressionConstants.EnvPath.CardProgressionSkillNode)
    if not isNull(env) then
        env:FreshUI(data, cardVo, isHideLv)
        env:SetCallback(Bind(self, self.OnClickSkillNodeAction))
    end
end

function CardProgressionSkillDescSkillNode:FreshSelectState(isSelect)
    KTool.SetActive(self.ImgSelect.gameObject, isSelect)
    KTool.SetActive(self.ImgArrow.gameObject, isSelect)
    if not isNull(self.Scale) then
        self.Scale.localScale = isSelect and SelectScale or NormalScale
    end
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------
function CardProgressionSkillDescSkillNode:SetCallback(cb)
    self._callback = cb
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionSkillDescSkillNode:OnClickSkillNodeAction(data)
    if self._callback then
        self._callback()
    end
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionSkillDescSkillNode

