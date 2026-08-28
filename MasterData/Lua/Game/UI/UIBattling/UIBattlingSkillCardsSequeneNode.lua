------------ import ------------
local cs_coroutine = require("XLua.cs_coroutine")
local DOTween = CS.DG.Tweening
local KTool = CS.Engine.Lib.KTool
local RectTransform = CS.UnityEngine.RectTransform
local Animation = CS.UnityEngine.Animation
local RawImage = CS.UnityEngine.UI.RawImage
local Yielders = CS.Engine.Lib.Yielders
local ParseUtils = CS.ParseUtils
------------ import ------------

------------ define ------------
local SKILL_CARD_SEQUENE_POSY_OFFSET = 20 -- 技能序列牌展示偏移量
local ANIMATION_SKILL_CARD_SHOW = "UIBattlingSkillCardShow"
local ANIMATION_SKILL_CARD_OUT = "UIBattlingSkillCardOut"
local ANIMATION_SKILL_CARD_END = "UIBattlingSkillCardEnd"
local ANIMATION_SKILL_CARD_WAIT = "UIBattlingSkillCardWait"
local ANIMATION_SKILL_CARD_Move = "UIBattlingSkillCardMove"
local ANIMATION_SKILL_CARD_USED = "Card_Prepare"
local ANIMATION_SKILL_CARD_DEFAULT = "UIBattlingSkillCardDefault"
local ANIMATION_SKILL_CARD_DESTROY = "UIBattlingSkillCardDestroy"
local ANIMATION_SKILL_CARD_USED_MOVE = "UIBattlingSkillCardEject"
local ANIMATION_SKILL_CARD_CAT_SHOW = "UIBattlingSkillCardCatGo"
------------ define ------------

--- from: Assets/BundleResources/Prefabs/UIBattling/SkillCardNodeSmall.prefab
---@class UIBattlingSkillCardsSequeneNode
---@field Env                           	UIBattlingSkillCardsSequeneNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ParticalRoot                  	UnityEngine.RectTransform               
---@field MoveRoot                      	UnityEngine.RectTransform               
---@field CanvasGroup                   	UnityEngine.CanvasGroup                 
---@field SkillType                     	UnityEngine.RectTransform               
---@field CardNodeBG                    	UnityEngine.RectTransform   
---@field UnitCardPTC                       UnityEngine.RectTransform     
---@field Animation_AnimRoot                UnityEngine.Animation     
---@field RT_TeammeatIcon                   UnityEngine.RectTransform

local base = import("Game.UI.UIBattling.UIBattlingSkillCardsNodeBase")
local UIBattlingSkillCardsSequeneNode = Class("UIBattlingSkillCardsSequeneNode", base)

function UIBattlingSkillCardsSequeneNode:__init()
    base.__init(self)
    self:CleanProperty()
end

function UIBattlingSkillCardsSequeneNode:__delete()
    base.__delete(self)
    self:CleanProperty()
    self.controller = nil
    self = nil
end

function UIBattlingSkillCardsSequeneNode:CleanProperty()
    self.rectTransform = nil
    self.skillTargetId = nil
    self.isUsed = nil
    self.isLock = nil
    self.sequenceCardType = nil
    self.ptcShowEffect = nil
    self.indexSequence = nil
    self.typeOnSkillShow = nil
    self.animatorPlayer = nil
    self.ptcCardLock = nil
    self.originLocalPosition = nil
    self.ptcDead = nil
    self.ptcDestroy = nil
end

function UIBattlingSkillCardsSequeneNode:Awake()
    self:GetUnityComponent()
    self.isUsed = false
    self.sequenceCardType = 0 -- 0:未赋值值 1: 常规技能牌 2:移动牌
    self.indexSequence = 0 -- 序列卡的序列位置
    self.typeOnSkillShow = Constants.SequenceSkillCardShowType.Default -- 序列卡在技能展示时的状态
    
    self.rectTransform = self.controller.gameObject:GetComponent(typeof(RectTransform))
    --- 选择添加动画播放器
    self.animatorPlayer = self.controller.gameObject:GetComponent(typeof(Animation))

    self.originLocalPosition = self.controller.transform.localPosition
end

function UIBattlingSkillCardsSequeneNode:OnDestroy()
    base.OnDestroy(self)
    self.controller = nil --luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

function UIBattlingSkillCardsSequeneNode:GetUnityComponent()
    xTry(function()
        local goCardIcon = self.controller.transform:Find("AnimRoot/SkillIcon")
        if not IsNull(goCardIcon) then
            self.cardIcon = goCardIcon.gameObject:GetComponent(typeof(RawImage))
            self.rectIcon = goCardIcon.gameObject:GetComponent(typeof(RectTransform))
        end
        local goCardBG = self.controller.transform:Find("AnimRoot/CardNodeBG")
        if not IsNull(goCardBG) then
            self.cardBG = goCardBG.gameObject:GetComponent(typeof(RawImage))
            self.rectCardBG = goCardBG.gameObject:GetComponent(typeof(RectTransform))
        end
        local goCardNodeFrame = self.controller.transform:Find("AnimRoot/CardNodeFrame")
        if not IsNull(goCardNodeFrame) then
            self.cardFrame = goCardNodeFrame.gameObject:GetComponent(typeof(RawImage))
        end
        local goCardIndex = self.controller.transform:Find("AnimRoot/SkillIndex")
        if not IsNull(goCardIndex) then
            self.cardIndex = goCardIndex.gameObject:GetComponent(typeof(RawImage))
        end
        local goCardTypeIcon = self.controller.transform:Find("AnimRoot/SkillTypeBG/SkillType")
        if not IsNull(goCardTypeIcon) then
            self.cardTypeIcon = goCardTypeIcon.gameObject:GetComponent(typeof(RawImage))
        end
        local goCardTypeBG = self.controller.transform:Find("AnimRoot/SkillTypeBG")
        if not IsNull(goCardTypeBG) then
            self.cardTypeBG = goCardTypeBG.gameObject:GetComponent(typeof(RawImage)) -- 技能卡类型图标背景
        end
        local goImgLvBlack = self.controller.transform:Find("AnimRoot/ImgLvBlack")
        if not IsNull(goImgLvBlack) then
            self.cardLvBG = goImgLvBlack.gameObject
        end
        local txtLv = self.controller.transform:Find("AnimRoot/ImgLvBlack/Text")
        if not IsNull(txtLv) then
            self.cardLvTxt = txtLv.gameObject:GetComponent(typeof(CS.TMPro.TextMeshProUGUI))
        end
    end)
end

---GetSequenceIndex
---获取技能 序列 Id
function UIBattlingSkillCardsSequeneNode:GetSequenceIndex()
    return self.indexSequence
end

---SetTargetId
---设置技能目标
---@param value integer @ 角色战场ID
function UIBattlingSkillCardsSequeneNode:SetTargetId(value)
    self.skillTargetId = value
end

---SetSequeneSkillCardShowState
---设置 技能序列牌 显示状态
function UIBattlingSkillCardsSequeneNode:SetSequeneSkillCardShowState()
    self.rectTransform.anchoredPosition = Vector2(self.rectTransform.anchoredPosition.x, self.rectTransform.anchoredPosition.y + SKILL_CARD_SEQUENE_POSY_OFFSET)
    self.typeOnSkillShow = Constants.SequenceSkillCardShowType.Show
end

---SetShowStateDefault
---设置序列牌为默认状态
function UIBattlingSkillCardsSequeneNode:SetShowStateFinish()
    self.rectTransform.anchoredPosition = Vector2(self.rectTransform.anchoredPosition.x, self.rectTransform.anchoredPosition.y - SKILL_CARD_SEQUENE_POSY_OFFSET)
    self.typeOnSkillShow = Constants.SequenceSkillCardShowType.ShowFinish
end

---GetTypeOnShow
---获取序列牌的展示状态字段
function UIBattlingSkillCardsSequeneNode:GetTypeOnShow()
    return self.typeOnSkillShow
end

---SetTypeOnShow
---@param value Constants.SequenceSkillCardShowType
function UIBattlingSkillCardsSequeneNode:SetTypeOnShow(value)
    self.typeOnSkillShow = value
end

function UIBattlingSkillCardsSequeneNode:GetSkillCardSequenceType()
    return self.sequenceCardType
end

---GetCardUseState
---获取 卡牌使用状态
function UIBattlingSkillCardsSequeneNode:GetCardUseState()
    return self.isUsed
end

---GetSkillCardData
---获取 技能卡数据
function UIBattlingSkillCardsSequeneNode:GetSkillCardData()
    return { data = self.skillCardData, isLock = self.isLock }
end

---SetSkillCardShowState
---设置 SkillCard 子节点 的显示状态
---@param boolean boolean 显示状态
function UIBattlingSkillCardsSequeneNode:SetSkillCardShowState(boolean)
    xTry(function()
        KTool.SetActive(self.cardIcon.gameObject, boolean)
        KTool.SetActive(self.cardBG.gameObject, boolean)
        KTool.SetActive(self.cardFrame.gameObject, boolean)
        KTool.SetActive(self.cardIndex.gameObject, boolean)
        KTool.SetActive(self.cardTypeIcon.gameObject, boolean)
        KTool.SetActive(self.cardTypeBG.gameObject, boolean)
    end)
end

---ShowSequeneSkillCardMove
---设置 移动效果 占位牌
function UIBattlingSkillCardsSequeneNode:ShowSequeneSkillCardMove()
    self:SetSkillCardShowState(false)
    self:ShowSequeneSkillCardEffect()
    self.isUsed = true
    self.sequenceCardType = 2
end

--- 播放可以合卡的提示
function UIBattlingSkillCardsSequeneNode:ShowSequeneSkillCardCanUnit()
    self.CanvasGroup.alpha = 1
    self:SetSkillCardShowState(false)
    if self.UnitCardPTC then
        KTool.SetActive(self.UnitCardPTC.gameObject, true)
    end
end

--- 隐藏可以合卡的提示
function UIBattlingSkillCardsSequeneNode:HideSequeneSkillCardCanUnit()
    self.CanvasGroup.alpha = 0
    if self.UnitCardPTC then
        KTool.SetActive(self.UnitCardPTC.gameObject, false)
    end
end

---ShowSequeneSkillCardOnSkillShow
---对技能显示 panel 的 GO 赋值
---@param data table
function UIBattlingSkillCardsSequeneNode:ShowSequeneSkillCardOnSkillShow(data)
    if data.catId then
        self:SetSkillCatCardInfo(data)
    else
        base.SetSkillCardInfo(self, data)
    end
    base.ReloadCardInfo(self)
    self.isUsed = false
end

function UIBattlingSkillCardsSequeneNode:SetSkillCardData(data)
    base.SetSkillCardInfo(self, data)
end

---ShowSequeneSkillCard
---@param sequeneCardData SkillCardSequenceVo @ UIBattlingDialog.SkillCardSequeneVo
---@param position Vector3 出卡的位置
function UIBattlingSkillCardsSequeneNode:ShowSequeneSkillCard(sequeneCardData, position)
    self:SetSkillCardShowState(true)
    local isCatCard = false
    if sequeneCardData then
        if sequeneCardData and sequeneCardData.cardData.catId then
            isCatCard = true
            self:SetSkillCatCardInfo(sequeneCardData.cardData)
        else
            base.SetSkillCardInfo(self, sequeneCardData.cardData)
        end
        base.ReloadCardInfo(self)
        self.indexSequence = sequeneCardData.sequenceId
        self.skillTargetId = sequeneCardData.targetId
        self.isLock = sequeneCardData.isLock
    end
    self:ShowSequeneSkillCardEffect(function()
        if self.isLock then
            self.ptcCardLock = UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_SKILLCARD_LOCKED, self.ParticalRoot.gameObject, 9999,true)
        end
    end, position, isCatCard)
    self.isUsed = true
    self.sequenceCardType = 1
end

function UIBattlingSkillCardsSequeneNode:SetSkillCatCardInfo(cardData)
    self.skillCardRoleId = checkNumber(cardData.roleId)
    self.skillCardData = cardData
    self.skillCardSkillId = checkInt(cardData.skillId)
    self.skillCardStarLevel = checkInt(cardData.star)
    self.attributeType = checkInt(cardData.attributeType)
    self.cardSkillLv = checkInt(cardData.skillLv)
    self.skillIndex = 1 -- 猫卡不按大招卡显示
    local skillCardVo = UIBattlingTools.GetSkillCardInfoByTwoParam(self.skillCardSkillId, 1)
    if not IsNull(skillCardVo) then
        self.skillType = skillCardVo.skillType
        self.isSPSkill = false  -- 猫卡不按大招卡显示
    end
    if not IsNull(self.skillCardSkillId) then
        local showLabel = UIBattlingTools.GetSkillCardInfoByTwoParam(self.skillCardSkillId, self.skillCardStarLevel).showLabel
        self.cardType = UICommonUtils:GetSkillShowLabelWithStar(showLabel, self.skillCardStarLevel)
    end
    self.isAoe = checkBool(checkNumber(skillCardVo.isAoe) > 0)
    self.hideIndex = true   -- 隐藏星
end

---ShowSequeneSkillCardEffect
---展示 出牌序列占位牌 动效
function UIBattlingSkillCardsSequeneNode:ShowSequeneSkillCardEffect(cb, position, isCatCard)
    self.CanvasGroup.alpha = 1
    local fx = isCatCard and Constants.UIBattlingObjPoolPTC.SKILL_CARD_CAT_APPEAR_EFFECT or Constants.UIBattlingObjPoolPTC.SKILL_CARD_SEQUENCE_APPEAR_EFFECT
    self.ptcShowEffect = UIBattlingTools.ReloadPTCOfBattling(fx, self.ParticalRoot.gameObject, 9999, true)
    self.animatorPlayer:Play(isCatCard and ANIMATION_SKILL_CARD_CAT_SHOW or ANIMATION_SKILL_CARD_USED_MOVE)
    if not isNull(position) then
        local trans = self.controller.transform
        local targetPos = trans.position
        trans.position = position
        trans:DOMove(targetPos, 0.2, false):OnComplete(function()
           if cb then cb() end
        end)
    else
        if cb then cb() end
    end
end

---SetSequeneSkillCardDefaut
---设置出牌序列为初始状态
function UIBattlingSkillCardsSequeneNode:SetSequeneSkillCardDefaut()
    self.isUsed = false
    self.CanvasGroup.alpha = 0
    self.sequenceCardType = 0
    self.indexSequence = 0
    self.isLock = false
    if not IsNull(self.ptcShowEffect) then
        UIBattlingTools.RecyclePoolObj(self.ptcShowEffect)
        self.ptcShowEffect = nil
    end
    if not IsNull(self.ptcCardLock) then
        UIBattlingTools.RecyclePoolObj(self.ptcCardLock)
        self.ptcCardLock = nil
    end
    self:ResetDeadState()
    self:PlayAnimationDefault()
    -- 复原position
    self.controller.transform.localPosition = self.originLocalPosition
    self:SetTeammeatIconState(false)
end

---GetSkillCardRoleId
---获取技能卡持有者 Id
function UIBattlingSkillCardsSequeneNode:GetSkillCardRoleId()
    return self.skillCardRoleId
end

---ResetCardAttributeType
---重新设置技能卡技能属性类型
function UIBattlingSkillCardsSequeneNode:ResetCardAttributeType(attributeType)
    base.GetSkillTypeImg(self, attributeType)
    base.SetSkillCardTypeIcon(self)
end

function UIBattlingSkillCardsSequeneNode:PlayAnimationShow()
    if not IsNull(self.animatorPlayer) then
        self.animatorPlayer:Play(ANIMATION_SKILL_CARD_SHOW)
    end
end

--- 这个应该是没有用了
function UIBattlingSkillCardsSequeneNode:PlayAnimationOut()
    if not IsNull(self.animatorPlayer) then
        self.animatorPlayer:Play(ANIMATION_SKILL_CARD_OUT)
    end
end

function UIBattlingSkillCardsSequeneNode:PlayAnimationEnd()
    if not IsNull(self.animatorPlayer) then
        self.animatorPlayer:Play(ANIMATION_SKILL_CARD_END)
    end
end

function UIBattlingSkillCardsSequeneNode:PlayAnimationNormal()
    if not IsNull(self.animatorPlayer) then
        self.animatorPlayer:Play(ANIMATION_SKILL_CARD_WAIT)
    end
end

--- 出牌完成以后，行动点界面消失的时候，行动点界面里的卡牌播放一个move的飞出效果
function UIBattlingSkillCardsSequeneNode:PlayAnimationMove()
    if not IsNull(self.animatorPlayer) then
        self.animatorPlayer:Play(ANIMATION_SKILL_CARD_Move)
    end
end

function UIBattlingSkillCardsSequeneNode:SetDeadState()
    if IsNull(self.ptcDead) then
        self.ptcDead = UIBattlingTools.ReloadPoolObjGO(Constants.UIBattlingObjPoolPrefabs.SkillCardStateDead, self.ParticalRoot.gameObject)
    end
end

function UIBattlingSkillCardsSequeneNode:ResetDeadState()
    if not IsNull(self.ptcDead) then
        UIBattlingTools.RecyclePoolObj(self.ptcDead)
        self.ptcDead = nil
    end
end

--- 还原消失动画
function UIBattlingSkillCardsSequeneNode:PlayAnimationDefault()
    self.Animation_AnimRoot:Play(ANIMATION_SKILL_CARD_DEFAULT)
    if not IsNull(self.ptcDestroy) then
        UIBattlingTools.RecyclePoolObj(self.ptcDestroy)
        self.ptcDestroy = nil
    end

    if not isNull(self.coDestroy) then
        cs_coroutine.stop(self.coDestroy)
        self.coDestroy = nil
    end
end

--- 播放消失动画
function UIBattlingSkillCardsSequeneNode:PlayAnimationDestroy()
    self.Animation_AnimRoot:Play(ANIMATION_SKILL_CARD_DESTROY)
    if IsNull(self.ptcDestroy) then
        self.ptcDestroy = UIBattlingTools.ReloadPoolObjGO(Constants.UIBattlingObjPoolPrefabs.SkillCardDestroy, self.ParticalRoot.gameObject)
    end

    if not isNull(self.coDestroy) then return end
    self.coDestroy = cs_coroutine.start(function()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.34))
        KTool.SetActive(self.controller.gameObject, false)
        self.coDestroy = nil
    end)
end

--- 改变卡牌星级
---@param from integer
---@param to integer
---@param cardData SkillDataVo
function UIBattlingSkillCardsSequeneNode:ChangeCardStar(from, to, cardData)
    local isUpgrad = from < to
    if isUpgrad then
        if to == 2 then
            UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_UPGRADE_NAME_122, self.ParticalRoot.gameObject, 3, true)
        elseif to == 3 then
            UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_UPGRADE_NAME_223, self.ParticalRoot.gameObject, 3, true)
        end
    else
        if to == 2 then
            UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_DOWNGRADE_NAME_322, self.ParticalRoot.gameObject, 3, true)
        elseif to == 1 then
            UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_DOWNGRADE_NAME_221, self.ParticalRoot.gameObject, 3, true)
        end
    end

    base.SetSkillCardInfo(self, cardData)
    base.ReloadCardInfo(self)
end

--- 设置队友标记的显示状态
---@param state boolean 开关
function UIBattlingSkillCardsSequeneNode:SetTeammeatIconState(state)
    KTool.SetActive(self.RT_TeammeatIcon.gameObject, state)
end

return UIBattlingSkillCardsSequeneNode
