
--region global define

--endregion

--region import

---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CatBallUtils
local CatBallUtils = import("Game.CatBall.CatBallUtils")
---@type TeamComponent
local teamComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.TeamComponent)
--endregion

--region define

local CatBallType = Constants.CatBallType

local SkillStatus = {
    Lock   = 1,
    Add    = 2,
    Normal = 3,
    Limit  = 4,
}

--endregion

--- from: Assets/BundleResources/Prefabs/FightTeam/FightTeamDialog.prefab > name: SkillInfo
---@class UIFightChooseCatBallSkillNode
---@field Env                           	UIFightChooseCatBallSkillNode           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field UIFXPassiveSkill              	UnityEngine.RectTransform               
---@field UIFXActiveSkill               	UnityEngine.RectTransform               
---@field LimitedUsePassiveSkill        	UnityEngine.RectTransform               
---@field LimitedUseActiveSkill         	UnityEngine.RectTransform               
---@field LockPassiveSkill              	UnityEngine.RectTransform               
---@field AddPassiveSkill               	UnityEngine.RectTransform               
---@field ImgCardPassiveSkill           	Engine.UI.ImageAlterable                
---@field NormalPassiveSkill            	UnityEngine.RectTransform               
---@field PassiveSkill                  	UnityEngine.RectTransform               
---@field LockActiveSkill               	UnityEngine.RectTransform               
---@field AddActiveSkill                	UnityEngine.RectTransform               
---@field ImgCardActiveSkill            	Engine.UI.ImageAlterable                
---@field NormalActiveSkill             	UnityEngine.RectTransform               
---@field BtnActiveSkill                	UnityEngine.RectTransform               
local UIFightChooseCatBallSkillNode = Class('UIFightChooseCatBallSkillNode')

function UIFightChooseCatBallSkillNode:__init()

end


function UIFightChooseCatBallSkillNode:__delete()

end


function UIFightChooseCatBallSkillNode:Awake()
    local skillType2StatusComponent = {
        [CatBallType.Active] = {
            [SkillStatus.Lock]   = self.LockActiveSkill,
            [SkillStatus.Add]    = self.AddActiveSkill,
            [SkillStatus.Normal] = self.NormalActiveSkill,
            [SkillStatus.Limit] = self.LimitedUseActiveSkill,
        },
        [CatBallType.Passive] = {
            [SkillStatus.Lock]   = self.LockPassiveSkill,
            [SkillStatus.Add]    = self.AddPassiveSkill,
            [SkillStatus.Normal] = self.NormalPassiveSkill,
            [SkillStatus.Limit] = self.LimitedUsePassiveSkill,
        },
    }

    local skillType2Icon = {
        [CatBallType.Active]  = self.ImgCardActiveSkill,
        [CatBallType.Passive] = self.ImgCardPassiveSkill
    }

    self._skillType2StatusComponent = skillType2StatusComponent
    self._skillType2Icon = skillType2Icon

end

function UIFightChooseCatBallSkillNode:Start()
    SetButtonAction(self.BtnActiveSkill, Bind(self, self.OnClickBtnActiveSkillAction))
    SetButtonAction(self.PassiveSkill,   Bind(self, self.OnClickBtnPassiveSkillAction))
end


function UIFightChooseCatBallSkillNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param teamCats TeamCatBallDojo[]
function UIFightChooseCatBallSkillNode:FreshUI(curLevelId, teamIndex, levelType)
    local teamCats = teamComponent:GetTeamCatByQuestId(curLevelId, teamIndex)
    local isUnlock = GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id3007)
    -- print("FreshUI", curLevelId, teamIndex, table.toString(teamCats))
    self._isUnlock = isUnlock
    self._curLevelId = curLevelId
    self._teamIndex = teamIndex
    self.levelType = levelType
    local catBallLimit = BattleHelperConfMgr:IsCatBallLimit(curLevelId)
    for index, value in ipairs(teamCats) do
        local skillType = value.catType
        local status = self:GetStatus(value, isUnlock)
        local statusComponent = self._skillType2StatusComponent[skillType]
        local isLimitCat = self:IsCatLimitByCatType(levelType, skillType)
        if catBallLimit or isLimitCat then
            CfUtils.SetActive(statusComponent[SkillStatus.Lock].gameObject, false)
            CfUtils.SetActive(statusComponent[SkillStatus.Add].gameObject, false)
            CfUtils.SetActive(statusComponent[SkillStatus.Normal].gameObject, true)
            CfUtils.SetActive(statusComponent[SkillStatus.Limit].gameObject, true)
            if skillType == CatBallType.Active then
                CfUtils.SetActive(self.UIFXActiveSkill, false)
            elseif skillType == CatBallType.Passive then
                CfUtils.SetActive(self.UIFXPassiveSkill, false)
            end
        else
            for key, component in pairs(statusComponent) do
                KTool.SetActive(component.gameObject, key == status)
            end

            if status == SkillStatus.Normal then
                local catId = value.catId
                ---@type CatBallVo
                local vo   = CatBallUtils.GetCatBallVo(catId)
                local icon = self._skillType2Icon[skillType]
                icon:LoadSprite(vo.picture)
                local isLimitCat = GameUtils.IsLimitCat(self._curLevelId, value.playerCatId,self._teamIndex)
                if skillType == CatBallType.Active then
                    CfUtils.SetActive(self.UIFXActiveSkill, not isLimitCat)
                elseif skillType == CatBallType.Passive then
                    CfUtils.SetActive(self.UIFXPassiveSkill, not isLimitCat)
                end
                if isLimitCat then
                    CfUtils.SetActive(statusComponent[SkillStatus.Limit].gameObject, true)
                end
            end
        end
    end
end

function UIFightChooseCatBallSkillNode:IsCatLimitByCatType(levelType,skillType)
    if levelType == Constants.IDType.ActivityCrisis then
        local ActivityCrisisUtils = import('Game.Activity.CrisisContract.ActivityCrisisUtils')
        local entryData = ActivityCrisisUtils.GetActivityCrisisMgr():GetEntryData()
        local isLimitCat = ActivityCrisisUtils.IsEntryLimitCat(entryData,skillType)
        return isLimitCat
    end

    return false
end


function UIFightChooseCatBallSkillNode:ToChooseCat(catBallType)
    if BattleHelperConfMgr:GetInstance():IsCatBallLimit(self._curLevelId) then return end

    local isLimitCat = self:IsCatLimitByCatType(self.levelType, catBallType)
    if isLimitCat then
        return
    end

    CfUtils.DialogOpen(
            Constants.UITypeIds.CatBallChooseCardsDialog,
            {levelId = self._curLevelId, teamIndex = self._teamIndex, teamType = Constants.EditTeamCatType.PreFight, catBallType = catBallType},
            {{id = Constants.UITypeIds.UIFightTeamChoose}}, true
    )
end

--endregion 


--region get/set 

---GetStatus
---@param dojo TeamCatBallDojo
function UIFightChooseCatBallSkillNode:GetStatus(dojo, isUnlock)
    if not isUnlock then
        return SkillStatus.Lock
    end
    if checkNumber(dojo.playerCatId) > 0 then
        return SkillStatus.Normal
    end
    return SkillStatus.Add
end

---endregion 


--region handler 

function UIFightChooseCatBallSkillNode:OnClickBtnActiveSkillAction()
    if not self._isUnlock then
        GameUtils.Toast(GameUtils.GetUnlockDescrBySystemTogId(Constants.SystemToggleIds.Id3007))
        return
    end

    self:ToChooseCat(Constants.CatBallType.Active)
    
end

function UIFightChooseCatBallSkillNode:OnClickBtnPassiveSkillAction()
    if not self._isUnlock then
        GameUtils.Toast(GameUtils.GetUnlockDescrBySystemTogId(Constants.SystemToggleIds.Id3007))
        return
    end

    self:ToChooseCat(Constants.CatBallType.Passive)
    
end


---endregion 


return UIFightChooseCatBallSkillNode
