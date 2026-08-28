---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarSpeedDialog.prefab > name: BossOnRoad
---@class OverseaClubCatCarBossPanel
---@field Env                            OverseaClubCatCarBossPanel
---@field controller                        Engine.Modules.LuaBehaviour
---@field OverseaClubCatCarOnRoadNode    UnityEngine.RectTransform                @ 0    
---@field ImgBoss                        UnityEngine.RectTransform                @ 1    
---@field BubbleNode                        UnityEngine.RectTransform                @ 2    
---@field BubbleAnim                        UnityEngine.RectTransform                @ 3    
---@field TxtBossTalk                    UnityEngine.RectTransform                @ 4    
---@field TxtBossHealth                    UnityEngine.RectTransform                @ 5    
---@field BloodGroup                        UnityEngine.RectTransform                @ 6    
---@field BtnNowScore                    UnityEngine.RectTransform                @ 7    
---@field ImgScore                        UnityEngine.RectTransform                @ 8    
---@field TxtClubPoints                    UnityEngine.RectTransform                @ 9    
---@field TxtSelfPoints                    UnityEngine.RectTransform                @ 10   
---@field BtnTeam                        UnityEngine.RectTransform                @ 11   
---@field TxtRemainTimes                    UnityEngine.RectTransform                @ 12   
local OverseaClubCatCarBossPanel = Class("OverseaClubCatCarBossPanel")

---@class OverseaClubCatCarBossPanel.InputData

function OverseaClubCatCarBossPanel:__init()
    self.controller = nil
end

function OverseaClubCatCarBossPanel:__delete()
    self.controller = nil
end

function OverseaClubCatCarBossPanel:Awake()
    
    SetButtonAction(self.BtnNowScore, Bind(self, self.OnNowScoreClick))
    SetButtonAction(self.BtnTeam, Bind(self, self.OnBossFightClick))
end

---@param inData OverseaClubCatCarBossPanel.InputData
function OverseaClubCatCarBossPanel:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end

    if checkNumber(Mgr.Server.dojo.catCarBoss.isFirstJoin) ~=0 then
        CfUtils.SetActive(self.controller.transform.parent, false)
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubCatCarMileageSettlementDialog,{bossPanel = self.controller.transform.parent})
    end
end

function OverseaClubCatCarBossPanel:RefreshUI()
    local carBossDojo = Mgr.Server.dojo.catCarBoss
    local bossDialog = self:GetBossText()
    if bossDialog then
        CfUtils.PlayAnimation(self.BubbleAnim, "OverseaClubHallBubbleNode_Go")
        CfUtils.FillText(self.TxtBossTalk, bossDialog)
    else
        CfUtils.SetActive(self.BubbleNode.gameObject, false)
    end

    local bloodPercent = checkNumber(carBossDojo.remainingHp / carBossDojo.totalHp)
    CfUtils.FillText(self.TxtBossHealth, string.format("%d%%", math.floor(bloodPercent * 100)))

    local bloodNum = math.floor(bloodPercent * 10)
    ---@type CommonList
    local bloods = CfUtils.GetLuaScr(self.BloodGroup, "Game.Behaviours.CommonList")
    bloods:Initialize(10, function(commonList, go, index)
        if index <= bloodNum then
            CfUtils.SetUISwitchImage(go, 2)
        else
            CfUtils.SetUISwitchImage(go, 1)
        end
    end)

    CfUtils.SetUISwitchImage(self.ImgScore,Mgr.Server.dojo.clubCatCarLevel)
    CfUtils.FillText(self.TxtClubPoints, Mgr.Server.dojo.clubScore)
    CfUtils.FillText(self.TxtSelfPoints, Mgr.Server.dojo.playerScore)
    local remainTimes,totalTimes = self:GetBossRemainTotalTime()
    CfUtils.FillText(self.TxtRemainTimes, string.format("%d/%d", remainTimes, totalTimes))
    
    ---@type OverseaClubCatCarNode.InputData
    local carData = {}
    carData.clubCatCatInfo = {}
    carData.clubCatCatInfo.playerInfo = carBossDojo.playerInfo
    --carData.clubCatCatInfo.clubName = carBossDojo.clubName
    carData.bubbleText = carBossDojo.bossText
    ---@type OverseaClubCatCarNode
    local carNode = CfUtils.GetLuaScr(self.OverseaClubCatCarOnRoadNode, "Game.UI.Club.CatCar.Speed.OverseaClubCatCarNode")
    carNode:RefreshData(carData)
end

function OverseaClubCatCarBossPanel:OnNowScoreClick()
    CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubCatCarTrackRewardPopup,{grade = Mgr.Server.dojo.clubCatCarLevel })
end

function OverseaClubCatCarBossPanel:OnBossFightClick()
    local remainTimes, _ = self:GetBossRemainTotalTime()
    if remainTimes <= 0 then
        GameUtils.Toast(localize("挑战次数不足"))
        return
    end
    ---@type ClubCatCarSpeedGradeVo
    local curGradeVo = CfUtils.GetCfVo(AutoIds.IdSetting6281,"ClubCatCarSpeedGradeVo",Mgr.Server.dojo.clubCatCarLevel)
    CfUtils.DialogOpen(Constants.UITypeIds.UIFightTeamChoose,{levelId = curGradeVo.questId }, { { id = Constants.UITypeIds.OverseaClubCatCarBackgroundDialog } })
end

function OverseaClubCatCarBossPanel:GetBossRemainTotalTime()
    local carBossDojo = Mgr.Server.dojo.catCarBoss
    local totalTimes = checkNumber(ClubUtils.GetParamValue(ClubUtils.ParamsId.Boss_Limit_Fight_Count))
    local remainTimes = totalTimes - checkNumber(carBossDojo.atTimes)
    return remainTimes,totalTimes
end

function OverseaClubCatCarBossPanel:GetBossText()
    local row = CfUtils.GetCfLine(AutoIds.IdSetting6286,6)
    if row then
        return CfUtils.GetCfDataByLine(row,"text1",Constants.DataType.LocalString)
    end
    return nil
end

return OverseaClubCatCarBossPanel