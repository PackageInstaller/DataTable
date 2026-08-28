--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingSkinMember.prefab > name: OverseaClubFeedingSkinMember
---@class OverseaClubFeedingSkinMember
---@field Env                           	OverseaClubFeedingSkinMember            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CloseEmpty                    	UnityEngine.RectTransform               	@ 0    
---@field TxtDesc                       	UnityEngine.RectTransform               	@ 1    
---@field TxtSSRNum                     	UnityEngine.RectTransform               	@ 2    
---@field TxtSRNum                      	UnityEngine.RectTransform               	@ 3    
---@field TxtRNum                       	UnityEngine.RectTransform               	@ 4    
---@field MemberGroup                   	UnityEngine.RectTransform               	@ 5    
---@field MemberBlock1                  	UnityEngine.RectTransform               	@ 6    
---@field MemberBlock2                  	UnityEngine.RectTransform               	@ 7    
---@field MemberBlock3                  	UnityEngine.RectTransform               	@ 8    
---@field ButtonClose                   	UnityEngine.RectTransform               	@ 9    
local OverseaClubFeedingSkinMember = Class("OverseaClubFeedingSkinMember")

---@class OverseaClubFeedingSkinMember.InputData

function OverseaClubFeedingSkinMember:__init()
    self.controller = nil
end

function OverseaClubFeedingSkinMember:__delete()
    self.controller = nil
end

function OverseaClubFeedingSkinMember:Awake()
    SetButtonAction(self.CloseEmpty, function()
        self.controller:Close()
    end)
    
    SetButtonAction(self.ButtonClose, function()
        self.controller:Close()
    end)
end

function OverseaClubFeedingSkinMember:OnInitialize()
    return CoWaitDo(function()
        --local initParams = self.controller.Argument.parameters or {}
        self:RefreshUI()
    end)
end

---@param inData OverseaClubFeedingSkinMember.InputData
function OverseaClubFeedingSkinMember:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubFeedingSkinMember:RefreshUI()
    for i = 1, 3 do
        ---@type OverseaClubFeedingSkinMemberCell
        local cell = CfUtils.GetLuaScr(self["MemberBlock" .. i],"Game.UI.Club.FeedCat.Skin.OverseaClubFeedingSkinMemberCell")
        cell:RefreshData({
            partType = i
        })
    end
    CfUtils.FillText(self.TxtDesc,GameUtils.GetFunctionRuleDesc(Constants.UITypeIds.OverseaClubFeedingSkinMember))
end

return OverseaClubFeedingSkinMember