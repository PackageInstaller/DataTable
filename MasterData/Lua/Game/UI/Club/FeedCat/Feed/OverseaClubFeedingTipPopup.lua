---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingTipPopup.prefab > name: OverseaClubFeedingTipPopup
---@class OverseaClubFeedingTipPopup
---@field Env                           	OverseaClubFeedingTipPopup              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnClose                      	UnityEngine.RectTransform               	@ 0    
---@field TxtCurSatiety                 	UnityEngine.RectTransform               	@ 1    
---@field TxtTips                       	UnityEngine.RectTransform               	@ 2    
---@field Satiety                       	UnityEngine.RectTransform               	@ 3    
---@field TxtSatietyNum                 	UnityEngine.RectTransform               	@ 4    
---@field TxtSatietyNumNext             	UnityEngine.RectTransform               	@ 5    
---@field attack                        	UnityEngine.RectTransform               	@ 6    
---@field TxtAttackNum                  	UnityEngine.RectTransform               	@ 7    
---@field TxtAttackNumNext              	UnityEngine.RectTransform               	@ 8    
local OverseaClubFeedingTipPopup = Class("OverseaClubFeedingTipPopup")

---@class OverseaClubFeedingTipPopup.InputData

function OverseaClubFeedingTipPopup:__init()
    self.controller = nil
end

function OverseaClubFeedingTipPopup:__delete()
    self.controller = nil
end

function OverseaClubFeedingTipPopup:Awake()
    SetButtonAction(self.BtnClose, function()
        CfUtils.SetActive(self.controller, false)
    end)
end

function OverseaClubFeedingTipPopup:Start()
    self:RefreshUI()
end

function OverseaClubFeedingTipPopup:OnEnable()
    self:RefreshUI()
end

---@param inData OverseaClubFeedingTipPopup.InputData
function OverseaClubFeedingTipPopup:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubFeedingTipPopup:RefreshUI()
    CfUtils.FillText(self.TxtCurSatiety, Mgr.Server.dojo.petsSatiety)
    local petsLevelRow = Utils.GetExpVo(Mgr.Server.dojo.petsLevel)
    if petsLevelRow then
        local nextPetslevelRow = Utils.GetExpVo(Mgr.Server.dojo.petsLevel + 1)
        nextPetslevelRow = nextPetslevelRow ~= nil and nextPetslevelRow or petsLevelRow
        CfUtils.FillText(self.TxtSatietyNum, petsLevelRow.catSatiety)
        CfUtils.FillText(self.TxtSatietyNumNext, nextPetslevelRow.catSatiety)

        local row = CardConfMgr:GetInstance():GetBuffEffectUpgradeInfoByRefId(petsLevelRow.buff)
        if row then
            ---@type CardProgressionSkillUtils
            local CardProgressionSkillUtils = Class('CardProgressionSkillUtils')
            local effectNum = CardProgressionSkillUtils.GetEffectUpgradeEffectNum(row,1)

            local nextRow = CardConfMgr:GetInstance():GetBuffEffectUpgradeInfoByRefId(nextPetslevelRow.buff)
            nextRow = nextRow ~= nil and nextRow or row
            local nextEffectNum = CardProgressionSkillUtils.GetEffectUpgradeEffectNum(nextRow,1)
            CfUtils.FillText(self.TxtAttackNum, effectNum)
            CfUtils.FillText(self.TxtAttackNumNext, nextEffectNum)
        end
    end
end

return OverseaClubFeedingTipPopup