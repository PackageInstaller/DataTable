-------------------------------------------------------------------------------
-- 三方卡牌预览弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-04-06 14:53:41
-------------------------------------------------------------------------------

---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
-- ---@type CardProgressionSkillUtils
-- local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
-- ---@type MaidCoffeeUtils
-- local MaidCoffeeUtils = import("Game.MaidCoffee.MaidCoffeeUtils")
-- ---@type FishingUtils
-- local FishingUtils = import('Game.UI.Fishing.FishingUtils')
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
---@type SceneManagement
local SceneManagementIns = SceneManagement:GetInstance()

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaPreviewThirdParty.prefab > name: CultivateOverseaPreviewThirdParty
---@class CommonCardThirdPreviewDialog
---@field Env                           	CommonCardThirdPreviewDialog            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field handbookPanel                 	UnityEngine.RectTransform               	@ 0    图鉴信息面板
---@field cardInfoPanel                 	UnityEngine.RectTransform               	@ 1    
---@field RightPanel                    	UnityEngine.RectTransform               	@ 2    右侧信息面板
local CommonCardThirdPreviewDialog = Class("CommonCardThirdPreviewDialog")


function CommonCardThirdPreviewDialog:__init()
    ---@type table @ 之前的ui相机的状态
    self.oldUICameraState_ = nil
    ---@type table<integer, boolean> @ 之前的场景状态
    self.oldScenesState_ = nil
    ---@type CardProgressionControllerRole
    self.roleController_ = nil
    ---@type UnityEngine.Transform[] @ 角色技能节点集合
    self.cardSkillNodes_ = {}
    ---@type boolean
    self.isHandbookMode_ = false
    ---@type boolean
    self.isHideHomeBtn_  = false
end


function CommonCardThirdPreviewDialog:__delete()
    self.oldUICameraState_ = nil
    self.oldScenesState_   = nil
    self.roleController_   = nil
    self.cardSkillNodes_   = nil
    self.isHandbookMode_   = nil
    self.isHideHomeBtn_    = nil
end


function CommonCardThirdPreviewDialog:Awake()
end


function CommonCardThirdPreviewDialog:OnFocus(isFocus)
    if isFocus then
        -- set uiCamera state
        CfUtils.SetUICameraProjection(false, 12)
        if self.isHideHomeBtn_ then
            CfUtils.SetNavHomeShow(false)
        end
    end
end


function CommonCardThirdPreviewDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        
        self.isPureCard_     = checkBool(initParams.isPureCard)
        self.additionMap_    = checkTable(initParams.additionMap)
        self.isHandbookMode_ = checkBool(initParams.handbookMode)
        self.showJumpBtn_    = checkBool(initParams.showJumpBtn)
        self.isHideHomeBtn_  = checkBool(initParams.isHideHomeBtn)
        self.closeMainSceneOnFinalize_ = initParams.closeMainSceneOnFinalize or false

        -- save uiCamera state
        self.oldUICameraState_ = CfUtils.GetUICameraProjectionState()

        -- save scene state
        self.oldScenesState_ = SceneManagementIns:GetShowLoadedScenesState()

        ---@type CardProgressionControllerRole
        self.roleController_ = CardProgressionUtils.GetRoleControllerEnv()

        -- save old role state data 
        -- if not isNull(self.roleController_) then
        --     self.roleController_:StoreRoleState()
        -- end

        -- init scene status
        Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, false)  -- 人关，猫关 交给 镜头显示来开
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = true})
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)
        CoYield() -- wait event invoke

        -- regist role swipe
        CardProgressionUtils.RegRoleSwipeRegion(self.controller)

        -- set preview cardDojo
        self:SetPreviewCardDojo(initParams.cardDojo)
    end)
end


function CommonCardThirdPreviewDialog:OnHide()
    return CoWaitDo(function()
        -- recover uiCamera state
        CfUtils.SetUICameraProjectionState(self.oldUICameraState_)

        --Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)  -- 人开，猫关
        --Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = false})
        --Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)
        --CoYield() -- wait event invoke
        
        -- recover scene state
        if next(checkTable(self.oldScenesState_)) then
            SceneManagementIns:RefreshScenesState(self.oldScenesState_)
        end

        -- recover role state
        -- if not isNull(self.roleController_) then
        --     self.roleController_:RecoveryRoleState()
        -- end
    end)
end


function CommonCardThirdPreviewDialog:OnFinalize()
    return CoWaitDo(function()
        if self.closeMainSceneOnFinalize_ then
            Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)
        end
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
    end)
end


function CommonCardThirdPreviewDialog:OnBackAction()
    CfUtils.SetActive(self.RightPanel, false)
end


-------------------------------------------------
-- get / set

---@return CardDojo
function CommonCardThirdPreviewDialog:GetPreviewCardDojo()
    return self.previewCardDojo_
end
function CommonCardThirdPreviewDialog:SetPreviewCardDojo(cardDojo)
    self.previewCardDojo_ = cardDojo
    self:UpdatePreviewInfo_()
end


---@return integer
function CommonCardThirdPreviewDialog:GetPreviewCardConfId()
    return checkInt(self:GetPreviewCardDojo().cardId)
end


---@return integer
function CommonCardThirdPreviewDialog:GetPreviewCardSkinId()
    return checkInt(self:GetPreviewCardDojo().cardSkin)
end


---@return CardVo
function CommonCardThirdPreviewDialog:GetPreviewCardVo()
    return cardConfMgr:GetCardByRefId(self:GetPreviewCardConfId())
end


-------------------------------------------------
-- private

function CommonCardThirdPreviewDialog:UpdatePreviewInfo_()
    -- update panelInfo
    CfUtils.SetActive(self.handbookPanel, self.isHandbookMode_)
    CfUtils.SetActive(self.RightPanel, not self.isHandbookMode_)
    if self.isHandbookMode_ then
        self:UpdateHandbookPanel_()
    else
        self:UpdateCardInfoPanel_()
        local cardSkinId  = self:GetPreviewCardSkinId()
        local cameraState = CardProgressionConstants.CameraState.CultivateRoleFull
        self.roleController_:LoadRole(cardSkinId, false, {cameraState, true}, false, nil, true)
    
    end

    -------------------------------------------------
    -- load role model
    
    local jumpBtn = self.RightPanel:Find("FontStyleButton")
    if isNotNull(jumpBtn) then
        CfUtils.SetActive(jumpBtn, self.showJumpBtn_)
        if self.showJumpBtn_ then
            SetButtonAction(jumpBtn, function ()
                local gachaponUtils = import('Game.Gachapon.GachaponUtils')
                gachaponUtils.OpenGachapon(nil, { { id = Constants.UITypeIds.UIHomeView } })
                CfUtils.DialogClose(self.controller)
            end)
        end
    end
end


function CommonCardThirdPreviewDialog:UpdateCardInfoPanel_()
    local cardDojo  = self:GetPreviewCardDojo()
    local entity    = CardProgressionUtils.GenerateEntityByRobot(cardDojo)

    if self.isPureCard_ then
        entity:FillPureCard(true)
    end
    if self.additionMap_ then
        entity:FillAdditionMap(self.additionMap_)
    end

    ---@type CardProgressionIntelligence
    local env      = CfUtils.GetLuaScr(self.cardInfoPanel, CardProgressionConstants.EnvPath.CardProgressionIntelligence)
    if isNotNull(env) then
        env:OnInitialize(entity, true)
        -- env:FreshUI(entity)
    end
    -- local cardVo   = self:GetPreviewCardVo()
    -- local cardId   = self:GetPreviewCardConfId()
    -- local skinId   = self:GetPreviewCardSkinId()

    -- -------------------------------------------------
    -- -- update rare node
    -- ---@type CardProgressionRoleRareNode
    -- local cardRareNode = CfUtils.GetLuaScr(self.RoleRareNode, CardProgressionConstants.EnvPath.CardProgressionRoleRareNode)
    -- if not isNull(cardRareNode) then
    --     cardRareNode:FreshUI(cardDojo:GetRare(), cardId)
    -- end

    -- -------------------------------------------------
    -- -- update attr group
    -- ---@type CardProgressionAttributeGroupNode
    -- local cardAttrNode = CfUtils.GetLuaScr(self.MaskRoot, CardProgressionConstants.EnvPath.CardProgressionAttributeGroupNode)
    -- if not isNull(cardAttrNode) then
    --     local typeName  = cardConfMgr:GetCatTypeNameById(cardVo.catType)
    --     local AssetPath = CardProgressionConstants.AssetPath
    --     local AssetType = CardProgressionConstants.AttrNodeType
    --     local attrDatas = {
    --         {order = -3, icon = AssetPath.Attribute, name = localize("属性"), viewType = AssetType.CardAttr, cardAttrId = cardVo.attributeType},
    --         {order = -2, icon = AssetPath.Race,      name = localize("阵营"), viewType = AssetType.Race,     raceId     = cardVo.race},
    --         {order = -1, icon = AssetPath.CatType,   name = localize("血统"), viewType = AssetType.CatType,  desc       = typeName},
    --     }
    --     table.sort(attrDatas, function(a, b) return a.order < b.order end)
    --     cardAttrNode:SetTargetNode(self.RightPanel)
    --     cardAttrNode:FreshUI(attrDatas)
    -- end

    -- -------------------------------------------------
    -- -- update skill info
    -- local skillInfoList = CardProgressionSkillUtils.InitSkills(cardVo, checkInt(cardDojo.awakeningLevel), checkInt(cardDojo.finalSkillLevel))
    -- for skillIndex, skillInfo in ipairs(skillInfoList) do
    --     local skillNode = self.cardSkillNodes_[skillIndex]
    --     if isNull(skillNode) then
    --         skillNode = self.SkillNode:GetChild(skillIndex - 1)
    --         skillNode = skillNode:Find("SkillCardNode")
    --         self.cardSkillNodes_[skillIndex] = skillNode
    --     end
    --     ---@type CardProgressionSkillNode
    --     local cardSkillNode = CfUtils.GetLuaScr(skillNode, CardProgressionConstants.EnvPath.CardProgressionSkillNode)
    --     if not isNull(cardSkillNode) then
    --         cardSkillNode:FreshUI(skillInfo, cardVo)
    --         cardSkillNode:SetTargetNode(self.RightPanel)
    --     end
    -- end

    -- -------------------------------------------------
    -- -- update life skill : takeaway
    -- local isShowTakeaway = false
    -- ---@type MaidCoffeeCardInfoVo
    -- local managerInfoVo = MaidCoffeeUtils.GetCardManagerInfoVo(cardId)
    -- if managerInfoVo then
    --     -- update icon
    --     self.ImgIconTakeaway.Status = managerInfoVo.job
    --     ---存在经营技能
    --     ---@type MaidCoffeeSkillVo
    --     local coffeeSkillVo = MaidCoffeeUtils.GetMaidCoffeeSkillInfoVo(managerInfoVo.additionId)
    --     if coffeeSkillVo then
    --         isShowTakeaway = true
    --         local coffeeSkillDesc = MaidCoffeeUtils.FillCoffeeSkillDescription(coffeeSkillVo.decr, managerInfoVo.additionNum,nil,managerInfoVo.percentage)
    --         -- update descr
    --         self.TextDescTakeaway.text = coffeeSkillDesc
    --         self.TextTitleTakeaway.text = coffeeSkillVo.name
    --     else
    --         self.TextDescTakeaway.text = localize("暂无经营技能")
    --         self.TextTitleTakeaway.text = localize("外卖员")
    --     end
    -- else
    --     self.TextDescTakeaway.text = localize("暂无经营技能")
    --     self.TextTitleTakeaway.text = localize("外卖员")
    -- end
    

    -- -------------------------------------------------
    -- -- update life skill : fishing
    -- local isShowFish = false
    -- ---@type FishingCardBonusVo
    -- local fishingBonusVo = FishingUtils.GetFishingCardBonusVo(cardId)
    -- if fishingBonusVo then
    --     ---@type FishingBonusEffectVo
    --     local effectVo = FishingUtils.GetFishingBonusEffectVo(fishingBonusVo.additionType1)
    --     if effectVo then
    --         -- update icon
    --         self.ImgIconFishing.Status = effectVo.additionPic
    --         -- update descr
    --         local buffDataList = FishingUtils.GetFishCardBuffData(cardId, Constants.ChooseCardStatus.FishAccompany)
    --         local descList = {}
    --         for _, buffData in ipairs(buffDataList) do
    --              table.insert(descList, FishingUtils.GetAdditionDesc(buffData.buffData)) 
    --         end
    --         self.TextDescFishing.text = table.concat(descList, "\n")
    --         isShowFish = true
    --     else
    --         self.TextDescFishing.text = localize("暂无垂钓技能")    
    --     end
    -- else
    --     self.TextDescFishing.text = localize("暂无垂钓技能")
    -- end
    
    -- CfUtils.SetActive(self.LifeSkillNode, isShowFish or isShowTakeaway)
end


function CommonCardThirdPreviewDialog:UpdateHandbookPanel_()
    ---@type CardComponent
    local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    local cardId   = self:GetPreviewCardConfId()
    local cardDojo = cardComp:GetCardByConfId(cardId)

    ---@type CardProgressionIllustrated
    local handbookPanelEnv = CfUtils.GetLuaScr(self.handbookPanel, CardProgressionConstants.EnvPath.CardProgressionIllustrated)
    if isNotNull(handbookPanelEnv) then
        handbookPanelEnv:SetFavorLv(cardDojo and cardDojo.favorabilityLevel or 0)
        handbookPanelEnv:FreshUI(cardId)
    end
end


return CommonCardThirdPreviewDialog
