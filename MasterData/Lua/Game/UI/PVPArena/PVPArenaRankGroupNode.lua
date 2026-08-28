
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/PVP/PVPRankGroupNode.prefab
---@class PVPArenaRankGroupNode
---@field Env                           	PVPArenaRankGroupNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field NormalGroupTxtRanking         	TMPro.TextMeshProUGUI                   
---@field NormalGroup                   	UnityEngine.RectTransform               
---@field SuperGroupTxtRanking          	TMPro.TextMeshProUGUI                   
---@field SuperGroupTxtRankingShadow    	TMPro.TextMeshProUGUI                   
---@field SuperGroup                    	UnityEngine.RectTransform               
---@field ImgDecorate                   	Game.Native.Common.UISwitchImage        
local PVPArenaRankGroupNode = Class('PVPArenaRankGroupNode')

function PVPArenaRankGroupNode:__init()

end


function PVPArenaRankGroupNode:__delete()

end


function PVPArenaRankGroupNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function PVPArenaRankGroupNode:FreshUI(rank)
    local isSuper = rank <= 3
    self.ImgDecorate.Status = isSuper and 1 or 2

    KTool.SetActive(self.SuperGroup.gameObject,  isSuper)
    KTool.SetActive(self.NormalGroup.gameObject, not isSuper)
    if isSuper then
        self.SuperGroupTxtRanking.text = rank
        self.SuperGroupTxtRankingShadow.text = rank
    else
        self.NormalGroupTxtRanking.text = rank
    end
end

---------------------------------------------------
--- ui logic end --
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


return PVPArenaRankGroupNode
