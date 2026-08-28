---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarMileageSettlementDialog.prefab > name: OverseaClubCatCarMileageSettlementDialog
---@class OverseaClubCatCarMileageSettlementDialog
---@field Env                           	OverseaClubCatCarMileageSettlementDialog
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TextNumber                    	UnityEngine.RectTransform               	@ 0    
---@field Root                          	UnityEngine.RectTransform               	@ 1    
---@field ImgScore                      	UnityEngine.RectTransform               	@ 2    
---@field TextRemind                    	UnityEngine.RectTransform               	@ 3    
---@field OverseaClubCatCarOnRoadNode   	UnityEngine.RectTransform               	@ 4    
local OverseaClubCatCarMileageSettlementDialog = Class("OverseaClubCatCarMileageSettlementDialog")

function OverseaClubCatCarMileageSettlementDialog:__init()
    self.controller = nil
end

function OverseaClubCatCarMileageSettlementDialog:__delete()
    self.controller = nil
end

function OverseaClubCatCarMileageSettlementDialog:Awake()
    SetButtonAction(self.Root,function() 
        self.controller:Close()
    end)
end

function OverseaClubCatCarMileageSettlementDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.bossPanel = initParams.bossPanel
        Events.Broadcast(ClubUtils.EventName.MileageSettlement_Open)
        self:RefreshUI()
    end)
end

function OverseaClubCatCarMileageSettlementDialog:RefreshUI()
    local dojo = Mgr.Server.dojo
    local carBossDojo = Mgr.Server.dojo.catCarBoss
    CfUtils.FillText(self.TextNumber, dojo.clubScore)
    CfUtils.SetUISwitchImage(self.ImgScore, dojo.clubCatCarLevel)
    CfUtils.FillText(self.TextRemind, localize("击败怪可获得_grade_级奖池的丰厚奖励", {_grade_ = OverseaClubCatCarUtils:GetNumToLetter(dojo.clubCatCarLevel,true)}))

    ---@type OverseaClubCatCarNode.InputData
    local carData = {}
    carData.clubCatCatInfo = {}
    carData.clubCatCatInfo.playerInfo = carBossDojo.playerInfo
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    carData.clubCatCatInfo.clubName = clubHomeDojo.name
    carData.clubCatCatInfo.ranking = carBossDojo.ranking
    ---@type OverseaClubCatCarNode
    local carNode = CfUtils.GetLuaScr(self.OverseaClubCatCarOnRoadNode, "Game.UI.Club.CatCar.Speed.OverseaClubCatCarNode")
    carNode:RefreshData(carData)
    carNode:SetRun()
end

function OverseaClubCatCarMileageSettlementDialog:OnFinalize()
    if self.bossPanel then
        CfUtils.SetActive(self.bossPanel.gameObject, true)
        Events.Broadcast(ClubUtils.EventName.MileageSettlement_Close)
    end
end

return OverseaClubCatCarMileageSettlementDialog