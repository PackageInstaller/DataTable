---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()

---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

local textAnimName = "OverseaClubFeedingUpDialog_Cell_Show"

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingUpDialog.prefab > name: OverseaClubFeedingUpDialog
---@class OverseaClubFeedingUpDialog
---@field Env                           	OverseaClubFeedingUpDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ClickClose                    	UnityEngine.RectTransform               	@ 0    
---@field TxtCat                        	UnityEngine.RectTransform               	@ 1    
---@field desc                          	UnityEngine.RectTransform               	@ 2    
---@field Cell                          	UnityEngine.RectTransform               	@ 3    
---@field BtnJump                       	UnityEngine.RectTransform               	@ 4    
local OverseaClubFeedingUpDialog = Class("OverseaClubFeedingUpDialog")

---@class OverseaClubFeedingUpDialog.InputData
---@field onClose function

function OverseaClubFeedingUpDialog:__init()
    self.controller = nil
end

function OverseaClubFeedingUpDialog:__delete()
    self.controller = nil
end

function OverseaClubFeedingUpDialog:Awake()
    SetButtonAction(self.ClickClose, function()
        self.controller:Close()
    end)
    SetButtonAction(self.BtnJump, function()
        self.controller:Close()
    end)
end

function OverseaClubFeedingUpDialog:OnInitialize()
    return CoWaitDo(function()
        ---@type OverseaClubFeedingUpDialog.InputData
        self.inData = self.controller.Argument.parameters or {}
        self:RefreshUI()
    end)
end

function OverseaClubFeedingUpDialog:OnFinalize()
    if self.inData.onClose then
        self.inData.onClose()
    end
    Mgr.cat:SetVcamToCenter(false)
    self:Delete()
end

function OverseaClubFeedingUpDialog:RefreshUI()
    local phase = Utils.CalPetPhase(Mgr.Server.dojo.petsLevel)
    local phaseVo = Utils.GetPhaseVo(phase)
    
    CfUtils.SetUISwitchText(self.TxtCat, phase)
    CfUtils.FillText(self.desc, phaseVo.name)
    CoStart(function()
        for i = 1, 4 do
            CoYield(0.2)
            self:SetText(self.Cell, phaseVo["text" .. i])
        end
    end)
end

function OverseaClubFeedingUpDialog:SetText(template, text)
    if not string.isEmpty(text) then
        local go = CfUtils.InstantiateGo(template, template.parent)
        CfUtils.SetActive(go, true)
        local TxtDesc = go.transform:Find("Root/TxtDesc")
        CfUtils.FillText(TxtDesc, text)
        CfUtils.PlayAnimation(go, textAnimName)
    end
end
return OverseaClubFeedingUpDialog