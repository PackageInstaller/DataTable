---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

local NormalRoad = "Game.UI.Club.CatCar.Speed.OverseaClubCatCarSpeedNormalPanel"
local BossOnRoad = "Game.UI.Club.CatCar.Speed.OverseaClubCatCarBossPanel"

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarSpeedDialog.prefab > name: OverseaClubCatCarSpeedDialog
---@class OverseaClubCatCarSpeedDialog
---@field Env                           	OverseaClubCatCarSpeedDialog            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Root                          	UnityEngine.RectTransform               	@ 0    
---@field TextTime                      	UnityEngine.RectTransform               	@ 1    
---@field BtnRank                       	UnityEngine.RectTransform               	@ 2    
---@field NormalRoad                    	UnityEngine.RectTransform               	@ 3    
---@field BossOnRoad                    	UnityEngine.RectTransform               	@ 4    
---@field OverseaClubCatCarTimeTablePopup	UnityEngine.RectTransform               	@ 5    
---@field BtnTimeTable                  	UnityEngine.RectTransform               	@ 6    
local OverseaClubCatCarSpeedDialog = Class("OverseaClubCatCarSpeedDialog")

---@class OverseaClubCatCarSpeedDialog.InputData

function OverseaClubCatCarSpeedDialog:__init()
    self.controller = nil
    self.events = {}
    self.events[ClubUtils.EventName.Loading_End] = Events.AddListener(ClubUtils.EventName.Loading_End,function()
        CfUtils.PlayAnimation(self.Root, "OverseaClubCatCarSpeedDialog_Entry")
    end)
end

function OverseaClubCatCarSpeedDialog:__delete()
    self.controller = nil
    for i, v in pairs(self.events) do
        Events.RemoveListener(i,v)
    end
end

function OverseaClubCatCarSpeedDialog:Awake()
    SetButtonAction(self.BtnRank,Bind(self,self.OnRankClick))
    SetButtonAction(self.BtnTimeTable,Bind(self,self.OnTimeTableClick))
    
    CfUtils.SetActive(self.OverseaClubCatCarTimeTablePopup, false)
end

---@param inData OverseaClubCatCarSpeedDialog.InputData
function OverseaClubCatCarSpeedDialog:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubCatCarSpeedDialog:RefreshUI()
    CfUtils.FillText(self.TextTime, OverseaClubCatCarUtils:GetActivityDurationTime())
    if Mgr.Server.dojo.scheduleType == 1 then
        CfUtils.SetActive(self.NormalRoad.gameObject, true)
        CfUtils.SetActive(self.BossOnRoad.gameObject, false)
        ---@type OverseaClubCatCarSpeedNormalPanel
        local normalPanel = CfUtils.GetLuaScr(self.NormalRoad, NormalRoad)
        local normalData = {}
        normalPanel:RefreshData(normalData)
    elseif Mgr.Server.dojo.scheduleType == 2 then
        CfUtils.SetActive(self.NormalRoad.gameObject, false)
        CfUtils.SetActive(self.BossOnRoad.gameObject, true)

        ---@type OverseaClubCatCarBossPanel
        local bossPanel = CfUtils.GetLuaScr(self.BossOnRoad, BossOnRoad)
        local bossData = {}
        bossPanel:RefreshData(bossData)
    end
end

function OverseaClubCatCarSpeedDialog:OnRankClick()
    CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubCatCarRankDialog)
end

function OverseaClubCatCarSpeedDialog:OnTimeTableClick()
    CfUtils.SetActive(self.OverseaClubCatCarTimeTablePopup.gameObject, true)
    ---@type OverseaClubCatCarTimeTablePopup
    local timeTablePopup = CfUtils.GetLuaScr(self.OverseaClubCatCarTimeTablePopup, "Game.UI.Club.CatCar.Speed.OverseaClubCatCarTimeTablePopup")
    timeTablePopup:RefreshUI()
end

function OverseaClubCatCarSpeedDialog:OnDestroy()
    self:Delete()
end

return OverseaClubCatCarSpeedDialog