
------------ import ------------

------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaStarup.prefab
---@class CardProgressionListCell
---@field Env                           	CardProgressionListCell                 
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CellAnimation                 	UnityEngine.Animation                   
---@field Node                          	UnityEngine.RectTransform               
local CardProgressionListCell = Class('CardProgressionListCell')

function CardProgressionListCell:__init()

end


function CardProgressionListCell:__delete()

end


function CardProgressionListCell:Awake()
end


function CardProgressionListCell:Start()
end


function CardProgressionListCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionListCell:InitLuaEnvPath(luaEnvPath)
    self._luaEnvPath = luaEnvPath
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionListCell:FreshUI(...)
    local env = CfUtils.GetLuaScr(self.Node, self._luaEnvPath)
    self._env = env
    if not isNull(env) then
        env:FreshUI(...)
    end
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------
function CardProgressionListCell:GetCellAnimation()
    return self.CellAnimation
end
function CardProgressionListCell:GetRealEnvCell()
    return self._env
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


return CardProgressionListCell
