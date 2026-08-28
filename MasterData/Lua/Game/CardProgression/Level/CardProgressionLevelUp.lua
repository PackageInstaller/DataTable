--- 养成-升级界面

------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaLevelupAndEvolution.prefab
---@class CardProgressionLevelUp
---@field Env                           	CardProgressionLevelUp                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field LevelUpPanel                  	UnityEngine.RectTransform               
local CardProgressionLevelUp = Class('CardProgressionLevelUp')

function CardProgressionLevelUp:__init()
    self._isInitialize = false
end

function CardProgressionLevelUp:__delete()

end

function CardProgressionLevelUp:Awake()
end

function CardProgressionLevelUp:Start()
    CardProgressionUtils.RegRoleSwipeRegion(self.controller)
end

function CardProgressionLevelUp:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

--- OnInitialize
---@param entity CardProgressionEntity
function CardProgressionLevelUp:OnInitialize(entity)
    if self._isInitialize then return end
    self._isInitialize = true
    self._maxAdvanceLevel = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxAdvanceLevel))
    self._freeSkinRareLimit = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.FreeSkinRareLimit))

    if Config.DEBUG then
        local vo = cardConfMgr:GetRoleAdvanceLevelLimitVo(self._maxAdvanceLevel)
        if vo == nil then
            printError("角色升阶等级上限表 与 养成参数表 最大阶级不匹配")
        end
    end
    
    self._entity = entity
    self:FreshUI(entity)
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param entity CardProgressionEntity
function CardProgressionLevelUp:FreshUI(entity, isLevelUp, oldDojo)
    ---@type CardDojo
    local cardDojo        = entity.cardDojo
    local cardLevel       = checkNumber(cardDojo.cardLevel)
    local advanceLevel    = checkNumber(cardDojo.advanceLevel)
    
    local isCanAdvanceLevelUp = CardProgressionUtils.CheckIsCanAdvanceLevelUp(cardLevel, advanceLevel)
    self._isCanAdvanceLevelUp = isCanAdvanceLevelUp
    
    self:FreshLevelUpPanel(entity, isCanAdvanceLevelUp, oldDojo)
    -- self:FreshBtnStylePreviewShowState()

end

--- FreshLevelUpPanel
---@param entity CardProgressionEntity
function CardProgressionLevelUp:FreshLevelUpPanel(entity, isCanAdvanceLevelUp, oldDojo)
    ---@type CardProgressionLevelUpPanel
    local env = self:GetLevelUpPanelEnv()
    if isNull(env) then return end
    if oldDojo then
        env:ShowCombatEffectivenessTips(oldDojo)
    end
    env:FreshUI(entity, isCanAdvanceLevelUp)

end



--- OnEnter
--- 进入时调用
function CardProgressionLevelUp:OnEnter()

end


--- OnLeave
--- 离开时时调用
function CardProgressionLevelUp:OnLeave()
    
    
end

--- OnReload
--- 
function CardProgressionLevelUp:OnReload(entity, localData)
    self._entity = entity
    if localData and localData.isLevelUp and checkNumber(localData.oldDojo.cardLevel) ~= checkNumber(localData.dojo.cardLevel) then
        local blockerName = "CardProgressionLevelUp.LevelUP"
        CardProgressionUtils.BlockerAndStartCo(blockerName, function()
            Events.Broadcast(CardProgressionConstants.EventNames.SetCultivateMainShowState, false)
            coroutine.yield(CardProgressionUtils.OpenDialog(Constants.UITypeIds.CardProgressionLevelUpSuccess, localData))
            self:FreshUI(entity, true, localData.oldDojo)
        end)
        return
        
    end
    self:FreshUI(entity)

end


---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionLevelUp:GetIsCanAdvanceLevelUp()
    return self._isCanAdvanceLevelUp
end

function CardProgressionLevelUp:GetLevelUpPanelEnv()
    if isNull(self._levelUpPanelEnv) then
        ---@type CardProgressionLevelUpPanel
        self._levelUpPanelEnv = CfUtils.GetLuaScr(self.LevelUpPanel, CardProgressionConstants.EnvPath.CardProgressionLevelUpPanel)
    end
    return self._levelUpPanelEnv
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionLevelUp
