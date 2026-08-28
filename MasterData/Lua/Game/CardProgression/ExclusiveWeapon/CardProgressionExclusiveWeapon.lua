--- 养成-专武界面

------------ import ------------
---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionMgr
local CardProgressionMgr       = import("Game.CardProgression.CardProgressionMgr")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type CardProgressionCombatEffUtils
local CardProgressionCombatEffUtils     = import("Game.CardProgression.CardProgressionCombatEffUtils")
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaSpecialWeapon.prefab > name: CultivateOverseaSpecialWeapon
---@class CardProgressionExclusiveWeapon
---@field Env                           	CardProgressionExclusiveWeapon          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Max                           	UnityEngine.RectTransform               
---@field TextRemind                    	UnityEngine.UI.Text
---@field FontStyleButton               	Game.Native.Common.FontStyleButton
---@field ButtonGroup2                  	UnityEngine.RectTransform
---@field Normal                        	UnityEngine.RectTransform               
---@field FinalWeaponEffect             	UnityEngine.RectTransform               
---@field ScrollView                    	SuperScrollView.LoopListView2           
---@field ItemAttribute                 	UnityEngine.RectTransform
---@field TextDesc                      	UnityEngine.RectTransform
---@field TextName                      	UnityEngine.UI.Text
---@field RoleRareNode                  	UnityEngine.RectTransform
local CardProgressionExclusiveWeapon = Class('CardProgressionExclusiveWeapon')

function CardProgressionExclusiveWeapon:__init()
    self._isInitialize = false
    self._maxLv  = nil
    self._nextLv = nil
    self._cardId = nil
end

function CardProgressionExclusiveWeapon:__delete()

end

-- function CardProgressionExclusiveWeapon:Awake()
-- end

function CardProgressionExclusiveWeapon:Start()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAction))
end

function CardProgressionExclusiveWeapon:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

--- OnInitialize
---@param entity CardProgressionEntity
function CardProgressionExclusiveWeapon:OnInitialize(entity)
    if self._isInitialize then return end
    self._isInitialize = false

    self._conditionLv   = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.ExclusiveWeaponConditionLv))
    self._conditionStar = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.ExclusiveWeaponConditionStar))
    self._entity = entity

    ---@type CardProgressionControllerRole
    self._controllerEnv = CardProgressionUtils.GetRoleControllerEnv()
    
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
function CardProgressionExclusiveWeapon:FreshUI(entity)
    ---@type CardDojo
    local cardDojo = entity.cardDojo
    local cardId   = cardDojo.cardId
    local isChangeCardId = self._cardId ~= cardId

    -- ---@type CardVo
    -- local cardVo = cardConfMgr:GetCardByRefId(cardId)
    local maxLv  = cardConfMgr:GetMaxCardExclusiveWeaponLv(cardId)
    local weaponLv = checkNumber(cardDojo.weaponUnlocked)
    local nextLv   = math.min(weaponLv + 1, maxLv)
    ---@type RoleCardExclusiveWeaponVo
    local vo = cardConfMgr:GetRoleCardExclusiveWeaponVo(cardId, nextLv)
    self._maxLv  = maxLv
    self._nextLv = nextLv
    self._weaponLv = weaponLv
    self._cardId = cardId
    
    self._isPreview = false

    if isChangeCardId then
        self:FreshRoleRareNode(cardDojo:GetRare(), cardId)
        self._lvDescList, self._finalLvDesc = self:GetLvDescList(maxLv, cardId)
        self.TextName.text = vo.name
        -- self.TextDesc.text = vo.desc
        
    end
    self:FreshLvDescList(isChangeCardId)

    self:FreshFinalLvDesc()

    self:FreshBottom(cardDojo, vo)

end

function CardProgressionExclusiveWeapon:FreshRoleRareNode(rare, cardId)
    ---@type CardProgressionRoleRareNode
    local env = CfUtils.GetLuaScr(self.RoleRareNode, CardProgressionConstants.EnvPath.CardProgressionRoleRareNode)
    if isNull(env) then return end
    env:FreshUI(rare, cardId)
        
end

function CardProgressionExclusiveWeapon:FreshLvDescList()
    local count      = #self._lvDescList
    local ScrollView = self.ScrollView
    if not ScrollView.IsListViewInit then
        ScrollView:InitListView(count, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end
    local index = self._weaponLv >= count and (count - 1) or self._weaponLv
    ScrollView:MovePanelToItemIndex(index)

end


function CardProgressionExclusiveWeapon:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(CardProgressionConstants.NodeNames.Cell)
    local node = GetLuaBehaviour(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionExclusiveWeaponCell)
    
    ---@type CardProgressionExclusiveWeaponCell
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end
    
    if nodeEnv then
        local level = index + 1
        nodeEnv:FreshUI(self._lvDescList[level], self._weaponLv)
    end

    return cell
end

function CardProgressionExclusiveWeapon:FreshFinalLvDesc()
    local data = self._finalLvDesc
    ---@type CardProgressionExclusiveWeaponCell
    local env  = CfUtils.GetLuaScr(self.FinalWeaponEffect, CardProgressionConstants.EnvPath.CardProgressionExclusiveWeaponCell)
    if isNotNull(env) then
        env:FreshUI(data, self._weaponLv)
        env:SetCallback(Bind(self, self.OnClickBtnPreviewAction))
    end
end

-- function CardProgressionExclusiveWeapon:FreshRewards(consumes)
--     -- UICommonUtils.FillCommonGoodsList(self.CommonGoodsList, consumes, nil, nil, nil, true, true)
-- end

--- FreshBottom
---@param dojo CardDojo
---@param vo RoleCardExclusiveWeaponVo
function CardProgressionExclusiveWeapon:FreshBottom(dojo, vo)
    local isMax = checkNumber(dojo.weaponUnlocked) == self._maxLv
    KTool.SetActive(self.Max.gameObject, isMax)
    KTool.SetActive(self.Normal.gameObject, not isMax)

    if not isMax then
        local isUnlock = checkNumber(dojo.cardLevel) >= self._conditionLv and checkNumber(dojo.star) >= self._conditionStar
        KTool.SetActive(self.TextRemind.gameObject, not isUnlock)
        self.FontStyleButton:ResetFontStyle(isUnlock and "B1" or "B17")
    end
    
    
end

--- OnEnter
--- 进入时调用
function CardProgressionExclusiveWeapon:OnEnter()
    
    
end

--- OnEnter
--- 离开时时调用
function CardProgressionExclusiveWeapon:OnLeave()
    
    
end

--- OnReload
--- 重载时调用
---@param entity CardProgressionEntity
function CardProgressionExclusiveWeapon:OnReload(entity)
    self._entity = entity
    self:FreshUI(entity)
    
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionExclusiveWeapon:GetLvDescList(maxLv, cardId)
    local ids        = cardConfMgr:GetRoleCardExclusiveWeaponIds(cardId)
    local t          = {}
    local finalLvDesc = nil
    for index, id in ipairs(ids) do
        ---@type RoleCardExclusiveWeaponVo
        local vo        = cardConfMgr:GetRoleCardExclusiveWeaponVoById(id)
        local upgrade = vo.upgrade
        local data = {level = index}
        if not string.isEmpty(upgrade) then
            data.desc = upgrade

        end
        if index == maxLv then
            finalLvDesc = data
        else
            table.insert(t, data)
        end
    end
    return t, finalLvDesc
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionExclusiveWeapon:OnClickBtnAction()
    ---@type CardDojo
    local dojo     = self._entity.cardDojo
    local isUnlock = checkNumber(dojo.cardLevel) >= self._conditionLv and checkNumber(dojo.star) >= self._conditionStar
    if not isUnlock then
        GameUtils.Toast(self.TextRemind.text)
        return
    end
    
    CfUtils.DialogOpen(Constants.UITypeIds.CardProgressionExclusiveWeaponLevelUp, {playerCardId = self._entity.cardDojo.id})

    -- if true then
    --     ---@type CardProgressionEntity
    --     local entity = self._entity
    --     local dojo = clone(entity.cardDojo)
    --     dojo.weaponUnlocked = 1
    --     Events.Broadcast(CardProgressionConstants.EventNames.RequestSuccess, Interfaces.OverseaCardWeaponUnlock, {dojo = dojo, isReloadModel = true})
    --    return 
    -- end
    
    -- if not self._isCanUnLock then
    --     GameUtils.Toast(localize("请先将角色进阶到UR且觉醒6哦~"))
    --     return
    -- end
    
    -- ---@type CardProgressionEntity
    -- local entity = self._entity
    -- local cardDojo = entity.cardDojo
    -- local realConsumes, errorTip = GoodsUtils.CheckGoodConsume(self._consumes)
    -- if errorTip then
    --     GameUtils.Toast(errorTip)
    --     return
    -- end
    -- CardProgressionMgr:RequestOverseaCardWeaponUnlock({playerCardId = cardDojo.id}, realConsumes)
end

function CardProgressionExclusiveWeapon:OnClickBtnPreviewAction()
    if self._isPreview  then
        return
    end
    self._isPreview = true
    ---@type CardDojo
    local dojo     = self._entity.cardDojo
    self._controllerEnv:FreshCameraStateByParams({CardProgressionConstants.CameraState.ExclusiveWeapon}, nil, true)
    self._controllerEnv:SetWeaponShowStateByDojo(dojo, false, true)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionExclusiveWeapon
