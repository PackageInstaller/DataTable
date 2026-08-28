
------------ import ------------
---@type Engine.Lib.KTool
local KTool         = CS.Engine.Lib.KTool
---@type PVPArenaUtils
local PVPArenaUtils = import('Game.Utils.PVPArenaUtils')
------------ import ------------


------------ define ------------
local PVPArenaRankGroupNodeEnvPath = "Game.UI.PVPArena.PVPArenaRankGroupNode"
------------ define ------------

--- from: Assets/BundleResources/Prefabs/PVP/PVPPlayerInfoDialog.prefab
---@class PVPArenaPlayerMatcherInfoCell
---@field Env                           	PVPArenaPlayerMatcherInfoCell                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TxtNumber1                    	UnityEngine.UI.Text                     
---@field TxtNumber                     	TMPro.TextMeshProUGUI                   
---@field TxtHonor                      	UnityEngine.UI.Text                     
---@field PVPRankGroupNode              	UnityEngine.RectTransform               
local PVPArenaPlayerMatcherInfoCell = Class('PVPArenaPlayerMatcherInfoCell')

function PVPArenaPlayerMatcherInfoCell:__init()

end


function PVPArenaPlayerMatcherInfoCell:__delete()

end


-- function PVPArenaPlayerMatcherInfoCell:Awake()
-- end


-- function PVPArenaPlayerMatcherInfoCell:Start()
-- end


function PVPArenaPlayerMatcherInfoCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function PVPArenaPlayerMatcherInfoCell:FreshUI(data)
    local rank  = data.rank
    local count = data.count

    self:FreshRankGroupNode(rank)

    local honorText   = PVPArenaUtils.GetRankResultTitleByRank(rank)
    local isShowHonor = honorText ~= nil
    KTool.SetActive(self.TxtHonor.gameObject, isShowHonor)
    if isShowHonor then
        self.TxtHonor.text = honorText
    end

    self.TxtNumber.text = string.format("%02d", count)
    
end

function PVPArenaPlayerMatcherInfoCell:FreshRankGroupNode(rank)
    ---@type PVPArenaRankGroupNode
    local env = CfUtils.GetLuaScr(self.PVPRankGroupNode, PVPArenaRankGroupNodeEnvPath) 
    if IsNull(env) then
        return
    end

    env:FreshUI(rank)
    
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


return PVPArenaPlayerMatcherInfoCell
