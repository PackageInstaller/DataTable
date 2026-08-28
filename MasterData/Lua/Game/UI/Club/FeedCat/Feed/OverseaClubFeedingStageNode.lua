---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingStagePopup.prefab > name: Cell
---@class OverseaClubFeedingStageNode
---@field Env                           	OverseaClubFeedingStageNode             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Imglv                         	Game.Native.Common.UISwitchImage        	@ 0    
---@field ImgIcon                       	Game.Native.Common.UISwitchImage        	@ 1    
---@field TxtTitle                      	UnityEngine.RectTransform               	@ 2    
---@field TxtDesc                       	UnityEngine.RectTransform               	@ 3    
---@field Cell                          	UnityEngine.RectTransform               	@ 4    
---@field ImgArrow                      	UnityEngine.RectTransform               	@ 5    
---@field Txtlock                       	UnityEngine.RectTransform               	@ 6    
local OverseaClubFeedingStageNode = Class("OverseaClubFeedingStageNode")

function OverseaClubFeedingStageNode:__init()
    self.controller = nil
end

function OverseaClubFeedingStageNode:__delete()
    self.controller = nil
end

function OverseaClubFeedingStageNode:Awake()
    CfUtils.SetActive(self.Cell, false)
end

function OverseaClubFeedingStageNode:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self:RefreshUI()
    end)
end

function OverseaClubFeedingStageNode:RefreshData(phase)
    self.phase = phase --number phase
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubFeedingStageNode:RefreshUI()
    ---@type ClubFeedCatPhaseVo
    local phaseVo = CfUtils.GetCfVo(AutoIds.IdSetting6313, "ClubFeedCatPhaseVo" ,self.phase)
    if phaseVo == nil then
        CfUtils.SetActive(self.ImgArrow, true)
        return
    end

    local curPhase = Utils.CalPetPhase(Mgr.Server.dojo.petsLevel)
    
    --CfUtils.SetUISwitchImage(self.Imglv, self.phase)
    --CfUtils.SetUISwitchImage(self.ImgIcon, self.phase)
    CfUtils.FillText(self.TxtTitle, phaseVo.title)
    CfUtils.FillText(self.TxtDesc, phaseVo.catText)

    if curPhase >= self.phase then
        for i = 1, 4 do
            self:SetText(self.Cell, phaseVo["text" .. i])
        end
        CfUtils.SetActive(self.Txtlock, false)
    else
        CfUtils.SetActive(self.Txtlock, true)
        local ids = CfUtils.GetIdGroupData(AutoIds.IdSetting6311,self.phase,"ids")
        ids = checkTable(ids)
        local id = ids[1]
        if id then
            CfUtils.FillText(self.Txtlock,localize("该阶段达到_level_等级解锁",{_level_ = id}))
        end
    end
    
    if self.phase == 4 then
        CfUtils.SetActive(self.ImgArrow, false)
    end
end

function OverseaClubFeedingStageNode:SetText(template, text)
    if not string.isEmpty(text) then
        local go = CfUtils.InstantiateGo(template, template.parent)
        CfUtils.SetActive(go, true)
        local TxtDesc = go.transform:Find("TxtDesc")
        CfUtils.FillText(TxtDesc, text)
    end
end

return OverseaClubFeedingStageNode