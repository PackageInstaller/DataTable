

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
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils     = import("Game.CardProgression.CardProgressionSkillUtils")
------------ import ------------


------------ define ------------
local CfUtils          = CfUtils
local checkNumber      = checkNumber
local attribute_format = attribute_format

local RightChangeAnimName   = "CultivateOverseaStarup_RightChange"
local RoleChangeAnimName  = "CultivateOverseaStarup_RoleChange"

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaStarup.prefab > name: CultivateOverseaStarup
---@class CardProgressionStarUp
---@field Env                           	CardProgressionStarUp                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Root                          	UnityEngine.Animation                   
---@field TextDesc                      	UnityEngine.UI.Text               
---@field Finish                        	UnityEngine.RectTransform               
---@field TextRemind                    	UnityEngine.UI.Text                     
---@field Lock                          	UnityEngine.RectTransform
---@field redPoint                      	UnityEngine.RectTransform               
---@field CommonBtnConsumePop           	UnityEngine.RectTransform
---@field FontStyleButton               	UnityEngine.RectTransform
---@field Unlock                        	UnityEngine.RectTransform
---@field GoodNode                      	UnityEngine.RectTransform
---@field StarUpDemand                  	UnityEngine.RectTransform               
---@field StarUpSkillInfoNode           	UnityEngine.RectTransform               
---@field CurrentStarUpEffect           	UnityEngine.RectTransform               
---@field CultivateOverseaAttributeNode 	UnityEngine.RectTransform               
---@field CurrentStarUp                 	UnityEngine.CanvasGroup               
---@field AttributeNode                 	UnityEngine.RectTransform               
---@field GridLayout                    	UnityEngine.RectTransform               
---@field BgNode                        	UnityEngine.RectTransform                   
---@field BtnPreview                    	UnityEngine.RectTransform
---@field StarLevelNode                 	UnityEngine.RectTransform
---@field DrawingNode                   	Game.Native.Common.DrawingNode               
local CardProgressionStarUp = Class('CardProgressionStarUp')

function CardProgressionStarUp:__init()
    self._isInitialize = false

    self._starNodeEnvs  = {}
    self._attributeEnvs = {}
    self._skillNodeEnvs = {}

    self._combatEffNodeEnv      = nil
    

    self._breakNodeEnv = nil
    --- 用于存储所有满星 breakNode
    self._breakNodeEnvs = nil
end

function CardProgressionStarUp:__delete()

end

function CardProgressionStarUp:Awake()
    CfUtils.SetActive(self.AttributeNode, true)
    self._maxStar = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxStar))
    
end

function CardProgressionStarUp:Start()
    local Bind            = Bind
    local SetButtonAction = SetButtonAction
    SetButtonAction(self.BtnPreview, function ()
        CardProgressionUtils.OpenDialog(Constants.UITypeIds.CardProgressionStarUpPreview, {dojo = self._cardDojo})
    end)

    -- SetButtonAction(self.BtnSkill,        Bind(self, self.OnClickBtnSkillAction))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAction))

    CardProgressionUtils.RegRoleSwipeRegion(self.controller)
end

function CardProgressionStarUp:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

--- OnInitialize
---@param entity CardProgressionEntity
function CardProgressionStarUp:OnInitialize(entity)
    if self._isInitialize then return end
    self._isInitialize = false

    self._entity    = entity

    self:FreshUI(entity, true)
end

--- 养成-升星界面

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param entity CardProgressionEntity
function CardProgressionStarUp:FreshUI(entity, isInitialize)
    local isChangeCardId = self:InitData(entity)
    if isChangeCardId then
        self:FreshDrawingNode()
    end

    self:ShowUI(isInitialize)

end

function CardProgressionStarUp:InitData(entity)
    if self._cardDojo and checkNumber(self._cardDojo.id) ~= entity.playerCardId then
        self._preCombatEffectiveness = nil
    end
    ---@type CardDojo
    local cardDojo          = entity.cardDojo
    local star              = checkNumber(cardDojo.star)
    local isMaxStar         = star >= self._maxStar
    local nextStar          = math.min(self._maxStar, star + 1)
    local cardId            = cardDojo.cardId
    local isChangeCardId    = cardId ~= self.carId

    self._originStar        = star
    self._originSuperStar   = checkNumber(cardDojo.superStar)
    self._cardId            = cardId
    self._isMaxStar         = isMaxStar
    self._cardDojo          = cardDojo
    self._nextStar          = nextStar
    self._customNextStar    = nextStar

    return isChangeCardId

end


function CardProgressionStarUp:FreshDrawingNode()
    -- self.DrawingNode:Execute(self._cardDojo.cardSkin)
    UICommonUtils.ShowSkin(self.DrawingNode.gameObject, self._cardDojo.cardSkin)

end

function CardProgressionStarUp:ShowUI(isInitialize, customNextStar)
    if not customNextStar then
        ---刷新星星
        self:FreshStarNodes(isInitialize)
    else
        self:SwitchStarSelectStatus(customNextStar)
    end
    
    ---刷新属性
    self:FreshAttributes()

    ---刷新技能节点
    self:FreshSkillNodes()

    ---刷新底部节点
    self:FreshBottom()

end

---FreshStarNodes
---刷新星级节点列表
function CardProgressionStarUp:FreshStarNodes(isInitialize)
    for star = 1, self._maxStar do
        ---@type CardProgressionStarUpSpecialNode
        local env = self:GetStarNodeEnvByIndex(star)
        self:FreshStarNode(env, star)
    end
   
end

---FreshStarNode
---刷新星级节点
---@param env CardProgressionStarUpSpecialNode
function CardProgressionStarUp:FreshStarNode(env, star)
    if isNull(env) then
        return
    end

    env:FreshUI(self._nextStar, star, self._isMaxStar, self._cardId)
    env:FreshSelectState(self._customNextStar == star and not self._isMaxStar)
    env:SetCallback(Bind(self, self.OnClickStarNodeAction))
end

---SwitchStarSelectStatus
---切换星级节点选中
---@param newStar number
function CardProgressionStarUp:SwitchStarSelectStatus(newStar)
    local oldStar = self._customNextStar
    self:FreshStarNodeSelectStatus(oldStar, false)
    self:FreshStarNodeSelectStatus(newStar, true)
    self._customNextStar = newStar

end

---FreshStarNodeSelectStatus
---刷新星级节点选中
---@param star number
---@param isSelect boolean
function CardProgressionStarUp:FreshStarNodeSelectStatus(star, isSelect)
    ---@type CardProgressionStarUpSpecialNode
    local env = self:GetStarNodeEnvByIndex(star)
    if isNull(env) then return end
    env:FreshSelectState(isSelect)

end

---FreshAttributes
---刷新属性
function CardProgressionStarUp:FreshAttributes()
    local t, combatEffectivenessConf, curCombatEffectiveness = self:GetAttributes()
    if self._isStarUp and self._preCombatEffectiveness and self._preCombatEffectiveness ~= curCombatEffectiveness then
        self._isStarUp = false
        CardProgressionUtils.ChangePointToast(curCombatEffectiveness - self._preCombatEffectiveness)
    end
    self._preCombatEffectiveness = curCombatEffectiveness

    local isShow = combatEffectivenessConf ~= nil
    KTool.SetActive(self.CultivateOverseaAttributeNode.gameObject, isShow)
    if isShow then
        ---@type CardProgressionAttributeNode
        local attributeNodeEnv = self:GetCombatEffNodeEnv()
        if isNotNull(attributeNodeEnv) then
            attributeNodeEnv:FreshUI(combatEffectivenessConf)
        end
    end

    self:FreshAttributeGroup(t)

end

---FreshAttributeGroup
---刷新属性列表
---@param attributes table
function CardProgressionStarUp:FreshAttributeGroup(attributes)
    for index, attribute in ipairs(attributes) do
        ---@type CardProgressionAttributeNode
        local env = self:GetAttributeEnv(index)
        if isNotNull(env) then
            env:FreshUI(attribute)
        end
    end
end

---FreshSkillNodes
---刷新技能列表
function CardProgressionStarUp:FreshSkillNodes()
    local isFull  = self._isMaxStar and self._originStar == self._customNextStar
    local skillDataList = CardProgressionSkillUtils.GetStarUpSkillDataList(self._cardId, self._customNextStar, isFull)
    
    local forTimes      = math.max(#skillDataList, #self._skillNodeEnvs)
    for i = 1, forTimes do
        ---@type CardProgressionStarUpSkillInfoNode
        local env =  self:GetSkillNodeEnv(i)
        if isNotNull(env) then
            local data = skillDataList[i]
            local isShow = data ~= nil
            env:SetActive(isShow)
            if isShow then
                env:FreshUI(skillDataList[i], self._customNextStar, self._cardId, self._originStar, isFull)
            end
        end
    end    

end

---FreshBottom
---刷新底部
function CardProgressionStarUp:FreshBottom()
    local isMaxStar      = self._originStar >= self._maxStar
    local isPreviewStar = self._customNextStar > self._nextStar 
    local isUnlock      = self._nextStar == self._customNextStar and not isMaxStar
    local isFinish      = self._customNextStar < self._nextStar or isMaxStar

    CfUtils.SetActive(self.StarUpDemand.gameObject, isUnlock)
    CfUtils.SetActive(self.Unlock.gameObject,       isUnlock)
    -- CfUtils.SetActive(self.Lock.gameObject,         isPreviewStar)
    CfUtils.SetActive(self.Finish.gameObject,       isFinish or isPreviewStar)


    if isUnlock then
        self:FreshGoodsConsume(isUnlock)
        -- if isPreviewStar then
        --     self.TextRemind.text = localize("请先解锁前置星级")
        -- end

    end

    if isFinish or isPreviewStar then
        self.TextDesc.text = isPreviewStar and localize("请先解锁前置星级") or localize("已激活")
    end
   
end

---FreshGoodsConsume
---刷新道具消耗
---@param isUnlock boolean @ 是否解锁
function CardProgressionStarUp:FreshGoodsConsume(isUnlock)
     ---@type CardStarVo
    local starVo   = cardConfMgr:GetCardStarInfo(self._cardId, self._customNextStar)
    local consumes = starVo:GetConsumes()
    local t, goodsNum = GoodsUtils.SpiltGold(consumes)
    local goodsConsume = t[1]
    CfUtils.RefeshGoodGo(self.GoodNode, goodsConsume.goodsId, GoodsUtils.GetGoodsText(goodsConsume.goodsId, goodsConsume.goodsNum, 1), 0.55, nil, function()
        GameUtils.ShowCommonGoodsTipsBoard(self.GoodNode, goodsConsume.goodsId, true)
    end)

    CfUtils.SetActive(self.CommonBtnConsumePop.gameObject, goodsNum > 0)
    if goodsNum ~= nil then
        UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, Constants.Currency.GoldId, goodsNum)
    end

    if isUnlock then
        CfUtils.SetActive(self.redPoint.gameObject, CardProgressionUtils.IsCanStarUp(self._cardDojo))
    end

end

--- OnEnter
--- 进入时调用
function CardProgressionStarUp:OnEnter()
    
    
end

--- OnEnter
--- 离开时时调用
function CardProgressionStarUp:OnLeave()
    
    
end

--- OnReload
---@param entity CardProgressionEntity
function CardProgressionStarUp:OnReload(entity, localData, interface, isSwitchCard)
    self._entity = entity
    
    if localData and localData.isStarUp then
        self._isStarUp = true
        ---@type CardDojo
        local dojo = localData.dojo
        ---@type CardVo
        local cardVo = cardConfMgr:GetCardByRefId(dojo.cardId)
        ---@type RolesVo
        local rolesVo = cardConfMgr:GetRolesVo(cardVo.characterId)
        CardProgressionUtils.PlayStarUpTimeline(dojo.cardSkin, rolesVo.timeLineName, localData)

    end

    if isSwitchCard then
        self.Root:Play(RoleChangeAnimName)
    end

    self:FreshUI(entity)
end


---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

---GetStarNodeEnvByIndex
---通关下标获取星级节点lua脚本
---@param index number
---@return CardProgressionStarUpSpecialNode
function CardProgressionStarUp:GetStarNodeEnvByIndex(index)
    local env = self._starNodeEnvs[index]
    if isNotNull(env) then
        return env
    end
    local node = self.StarLevelNode:Find(string.format("BtnStarupSpecialNode%d", index))
    env = self:GetStarNodeEnv(node)
    self._starNodeEnvs[index] = env
    return env
    
end

---GetStarNodeEnv
---获取星级节点lua脚本
---@param node UnityEngine.RectTransform
---@return CardProgressionStarUpSpecialNode
function CardProgressionStarUp:GetStarNodeEnv(node)
    ---@type CardProgressionStarGroupNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionStarUpSpecialNode)    
    return env
    
end

---GetCombatEffNodeEnv
---获取战力节点lua脚本
---@return CardProgressionAttributeNode
function CardProgressionStarUp:GetCombatEffNodeEnv()
    if isNull(self._combatEffNodeEnv) then
        ---@type CardProgressionAttributeNode
        local env = self:GetAttributeNodeEnvByNode(self.CultivateOverseaAttributeNode)
        self._combatEffNodeEnv = env
    end
    
    return self._combatEffNodeEnv
end

---GetAttributeEnv
---@return CardProgressionAttributeNode
function CardProgressionStarUp:GetAttributeEnv(index)
    local env = self._attributeEnvs[index]
    if env == nil then
        local child = self.AttributeNode.gameObject
        local node = index == 1 and child or (self.GridLayout.gameObject:AddChild(child))
        env  = self:GetAttributeNodeEnvByNode(node)
        self._attributeEnvs[index] = env
    end
    return env
end

---GetAttributeNodeEnvByNode
---@return CardProgressionAttributeNode
function CardProgressionStarUp:GetAttributeNodeEnvByNode(node)
    ---@type CardProgressionAttributeNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionAttributeNode)
    return env
end


---GetSkillNodeEnv
---@return CardProgressionStarUpSkillInfoNode
function CardProgressionStarUp:GetSkillNodeEnv(index)
    local env = self._skillNodeEnvs[index]
    if isNull(env) then
        local child = self.StarUpSkillInfoNode.gameObject
        local node  = index == 1 and child or (self.CurrentStarUpEffect.gameObject:AddChild(child))
        ---@type CardProgressionStarUpSkillInfoNode
        env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionStarUpSkillInfoNode)
        self._skillNodeEnvs[index] = env
    end
    return env
end

function CardProgressionStarUp:GetAttributes()

    local isMaxStar = self._isMaxStar
    local customNextStar = self._customNextStar

    local t, combatEffectivenessConf = {}, nil

    local curCombatEffectiveness
    if false then

        ---@type CardStarVo
        local starVo     = cardConfMgr:GetCardStarInfo(self._cardId, self._originStar)
        local attrAddId2V = starVo:GetAttributes()
        local attributeId2Res = {}
        for addrAddId, _ in pairs(attrAddId2V) do
            local attrId = cardConfMgr:GetBasicAttrIdByBasicAttrAdditionId(addrAddId)
            attributeId2Res[attrId] = true
        end
        -- print(table.toString(attributeId2Res))
        curCombatEffectiveness = FormulaUtils.CalcCardCombatEffectiveness(self._entity, nil, function(vo, baseV, i)
            if attributeId2Res[vo.id] then
                local text    = attribute_format(vo.isConversion, baseV)
                table.insert(t, {
                    icon = vo.icon,
                    name = vo.name,
                    attrNum = text,
                    viewType = CardProgressionConstants.AttrNodeType.Single,
                })
            end
        end)
        -- local star = checkNumber(self._originStar + 1)
        local rate = cardConfMgr:GetSynergiesGeneralAddNum(self._originStar, self._cardId)
        table.insert(t, {
            icon = CardProgressionConstants.AssetPath.Synergies,
            name = localize("羁绊属性加成"),
            attrNum = attribute_format(1, rate),
            viewType = CardProgressionConstants.AttrNodeType.Single,
        })
        
        combatEffectivenessConf = {
            name        = localize("战斗力"),
            attrNum     = curCombatEffectiveness,
            viewType    = CardProgressionConstants.AttrNodeType.Single,
        }
    else
        local star     = customNextStar - 1
        local nextStar = customNextStar
        
        local preCombatEffectiveness, combatEffectiveness = FormulaUtils.CalcCardCombatEffectivenessAndCompareAttr(self._entity, self._entity, function (vo, preAttrV, attrV, i)
            if preAttrV ~= attrV then
                -- local preText = attribute_format(vo.isConversion, preAttrV)
                local text    = attribute_format(vo.isConversion, attrV)
                table.insert(t, {
                    icon = vo.icon,
                    name = vo.name,
                    -- attrNum = preText,
                    -- plusAttrNum = text,
                    attrNum = text,
                    viewType = CardProgressionConstants.AttrNodeType.Single,
                })
            end
        end,{star = star}, {star = nextStar})

        combatEffectivenessConf = {
            name        = localize("战斗力"),
            -- attrNum     = preCombatEffectiveness,
            attrNum = combatEffectiveness,
            viewType    = CardProgressionConstants.AttrNodeType.Single,
        }

        curCombatEffectiveness = isMaxStar and combatEffectiveness or preCombatEffectiveness
        -- local rate     = cardConfMgr:GetSynergiesGeneralAddNum(star, self._cardId)
        local nextRate = cardConfMgr:GetSynergiesGeneralAddNum(nextStar, self._cardId)
        table.insert(t, {
            icon = CardProgressionConstants.AssetPath.Synergies,
            name = localize("羁绊属性加成"),
            -- attrNum = attribute_format(1, rate),
            attrNum = attribute_format(1, nextRate),
            -- plusAttrNum = attribute_format(1, nextRate),
            viewType = CardProgressionConstants.AttrNodeType.Single,
        })
    end

    return t, combatEffectivenessConf, curCombatEffectiveness
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionStarUp:OnClickStarNodeAction(customNextStar)
    if customNextStar == self._customNextStar then
        return
    end

    if not self._isMaxStar then
        self.Root:Play(RightChangeAnimName)
    end

    self:ShowUI(false, customNextStar)
    
end


function CardProgressionStarUp:OnClickBtnAction()
    -- if true then
    --     ---@type CardDojo
    --     local dojo = clone(self._entity.cardDojo)
    --     local oldDojo = clone(self._entity.cardDojo)
    --     dojo.star = checkNumber(dojo.star) + 1
    --     -- dojo.star = self._maxStar
    --     ---@type CardStarVo
    --     local starVo = cardConfMgr:GetCardStarInfo(self._cardId, dojo.star)
    --     if starVo.passiveLevel > 0 then
    --         dojo.awakeningLevel = starVo.passiveLevel
    --     end
    --     if starVo.spLevel > 0 then
    --         dojo.finalSkillLevel = cardConfMgr:GetFinalSkillDisplayLevel(starVo.spLevel)
    --     end

    --     local data = {dojo = dojo, isStarUp = true, oldDojo = oldDojo}
    --     Events.Broadcast(CardProgressionConstants.EventNames.RequestSuccess, Interfaces.CardStarUp, data)
     
    --     return
    -- end

    if self._customNextStar > self._nextStar then
        GameUtils.Toast(localize("请先解锁前置星级"))
        return 
    end

    ---@type CardStarVo
    local starVo = cardConfMgr:GetCardStarInfo(self._cardId, self._nextStar)
    local consumes = starVo:GetConsumes()
    local t, goldNum = GoodsUtils.SpiltGold(consumes)
    if goldNum > 0 then
        local goldConsume = {goodsId = Constants.Currency.GoldId, num = goldNum}
        if not GoodsUtils.CheckConsumeDataCondition({goldConsume}) then
            return
        end
    end
    
    local rewards, errorTip = GoodsUtils.CheckGoodConsume(consumes)
    if errorTip then
        GameUtils.Toast(errorTip)
        return
    end
    CardProgressionMgr:GetInstance():RequestOverseaCardStarUp({playerCardId = self._entity.cardDojo.id}, rewards, self._cardDojo)
    
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionStarUp
