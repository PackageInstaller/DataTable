---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarBossSettlementDialog.prefab > name: OverseaClubCatCarBossSettlementDialog
---@class OverseaClubCatCarBossSettlementDialog
---@field Env                           	OverseaClubCatCarBossSettlementDialog   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field txtMyPoints                   	UnityEngine.RectTransform               	@ 0    
---@field TxtTicketNum                  	UnityEngine.RectTransform               	@ 1    
---@field BtnStart                      	UnityEngine.RectTransform               	@ 2    
local OverseaClubCatCarBossSettlementDialog = Class("OverseaClubCatCarBossSettlementDialog")

function OverseaClubCatCarBossSettlementDialog:__init()
    self.controller = nil
end

function OverseaClubCatCarBossSettlementDialog:__delete()
    self.controller = nil
end

function OverseaClubCatCarBossSettlementDialog:Awake()
    SetButtonAction(self.BtnStart,Bind(self,self.OnStartClick))
end

function OverseaClubCatCarBossSettlementDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.scrapePanel = initParams.scrapePanel
        self:RefreshUI()
    end)
end


function OverseaClubCatCarBossSettlementDialog:RefreshUI()
    local dojo = Mgr.Server.dojo
    CfUtils.FillText(self.txtMyPoints, dojo.playerScore)
    CfUtils.FillText(self.TxtTicketNum, dojo.convertCallNum)
end

function OverseaClubCatCarBossSettlementDialog:OnFinalize()
    if self.scrapePanel then
        CfUtils.SetActive(self.scrapePanel.gameObject, true)
    end
end

function OverseaClubCatCarBossSettlementDialog:OnStartClick()
    self.controller:Close()
end

return OverseaClubCatCarBossSettlementDialog