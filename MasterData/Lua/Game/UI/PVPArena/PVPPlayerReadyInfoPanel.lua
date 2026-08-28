
------------ import ------------
---@type PVPArenaUtils
local PVPArenaUtils = import('Game.Utils.PVPArenaUtils')
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/PVP/PVPPlayerReadyDialog.prefab
---@class PVPPlayerReadyInfoPanel
---@field Env                           	PVPPlayerReadyInfoPanel                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ReadyGroup                    	UnityEngine.RectTransform               
---@field ButtonReady                   	UnityEngine.RectTransform               
---@field TxtLV                         	TMPro.TextMeshProUGUI                   
---@field PlayerName                    	UnityEngine.UI.Text                     
---@field PlayerHeadNode                	UnityEngine.RectTransform               
local PVPPlayerReadyInfoPanel = Class('PVPPlayerReadyInfoPanel')

function PVPPlayerReadyInfoPanel:__init()

end


function PVPPlayerReadyInfoPanel:__delete()

end

function PVPPlayerReadyInfoPanel:Awake()
    
end

function PVPPlayerReadyInfoPanel:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

--- FreshUI
---@param info table  {
---     @field name        string      玩家名称
---     @field avatar      integer     玩家头像
---     @field level       integer     玩家等级
---     @field avatarFrame integer     玩家头像框
---     @field quizzedNum  integer     被竞猜数量
---}
---@param playerId number
function PVPPlayerReadyInfoPanel:FreshUI(info, playerId, isSelf, isReady)
    PVPArenaUtils.RefreshPlayerHeadNode(self.PlayerHeadNode.gameObject, playerId, info, nil, nil, true)

    if isSelf then
        SetButtonAction(self.ButtonReady, Bind(self, self.OnClickButtonReadyAction))
    end

    self.PlayerName.text = info.name
    self.TxtLV.text = info.level

    self:FreshBottomUI(isReady)
end

function PVPPlayerReadyInfoPanel:FreshBottomUI(isReady)
    KTool.SetActive(self.ButtonReady.gameObject, not isReady)
    KTool.SetActive(self.ReadyGroup.gameObject, isReady)
end

---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function PVPPlayerReadyInfoPanel:SetCallback(cb)
    self.callback = cb
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function PVPPlayerReadyInfoPanel:OnClickButtonReadyAction()
    self:FreshBottomUI(true)
    if self.callback then
        self.callback()
    end
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return PVPPlayerReadyInfoPanel
