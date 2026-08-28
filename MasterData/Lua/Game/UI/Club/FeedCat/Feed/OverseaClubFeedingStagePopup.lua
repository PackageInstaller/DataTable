--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingStagePopup.prefab > name: OverseaClubFeedingStagePopup
---@class OverseaClubFeedingStagePopup
---@field Env                            OverseaClubFeedingStagePopup
---@field controller                        Engine.Modules.LuaBehaviour
---@field ClickClose                        UnityEngine.RectTransform                @ 0    
---@field Root                            UnityEngine.Animator                        @ 1    
---@field CommonPopupBoardDialog            UnityEngine.RectTransform                @ 2    
---@field CommonList                        UnityEngine.RectTransform                @ 3    
---@field ButtonClose                    UnityEngine.RectTransform                @ 4    
local OverseaClubFeedingStagePopup = Class("OverseaClubFeedingStagePopup")

---@class OverseaClubFeedingStagePopup.InputData

function OverseaClubFeedingStagePopup:__init()
    self.controller = nil
end

function OverseaClubFeedingStagePopup:__delete()
    self.controller = nil
end

function OverseaClubFeedingStagePopup:Awake()
    SetButtonAction(self.ClickClose, function()
        self.controller:Close()
    end)
    SetButtonAction(self.ButtonClose, function()
        self.controller:Close()
    end)
end

function OverseaClubFeedingStagePopup:OnInitialize()
    return CoWaitDo(function()
        --local initParams = self.controller.Argument.parameters or {}
        ---@type CommonList
        self.commonListLua = CfUtils.GetLuaScr(self.CommonList, "Game.Behaviours.CommonList")
        self.phase = {1,2,3,4}
        self:RefreshUI()
    end)
end

---@param inData OverseaClubFeedingStagePopup.InputData
function OverseaClubFeedingStagePopup:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubFeedingStagePopup:RefreshUI()
    if not self.commonListLua.inited then
        self.commonListLua:Initialize(#self.phase, Bind(self, self.OnGetItemByIndex))
    else
        self.commonListLua:RefreshUI(#self.phase)
    end
end

function OverseaClubFeedingStagePopup:OnGetItemByIndex(commonList, go, index)
    local data = self.phase[index]
    ---@type OverseaClubFeedingStageNode
    local lua = CfUtils.GetLuaScr(go, "Game.UI.Club.FeedCat.Feed.OverseaClubFeedingStageNode")
    lua:RefreshData(data)
end

return OverseaClubFeedingStagePopup