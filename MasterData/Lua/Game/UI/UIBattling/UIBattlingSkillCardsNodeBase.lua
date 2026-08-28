------------ import ------------
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
local KTool = CS.Engine.Lib.KTool
local RawImage = CS.UnityEngine.UI.RawImage
local Image = CS.UnityEngine.UI.Image
local RectTransform = CS.UnityEngine.RectTransform
------------ import ------------

------------ define ------------
------------ define ------------

---@class UIBattlingSkillCardsNodeBase
local base = import("Game.UI.UIBattling.SkillCardsNodeBase")
local UIBattlingSkillCardsNodeBase = Class("UIBattlingSkillCardsNodeBase", base)

------------ LifeCycle ------------

function UIBattlingSkillCardsNodeBase:__init()
    base.__init(self)
    self:CleanProperty()
end

function UIBattlingSkillCardsNodeBase:__delete()
    base.__delete(self)
    self:CleanProperty()
    self.controller = nil
    self = nil
end

function UIBattlingSkillCardsNodeBase:CleanProperty()
    self.skillCardRoleId = nil -- 技能卡 角色ID
    self.cardIcon = nil
    self.rectIcon = nil
    self.cardBG = nil
    self.rectCardBG = nil
    self.cardFrame = nil
    self.cardIndex = nil
    self.cardTypeIcon = nil
    self.cardTypeBG = nil
end

function UIBattlingSkillCardsNodeBase:Awake()
    base.Awake(self)
    xTry(function()
        local goCardIcon = self.controller.transform:Find("SkillIcon")
        if not IsNull(goCardIcon) then
            self.cardIcon = goCardIcon.gameObject:GetComponent(typeof(RawImage))
            self.rectIcon = goCardIcon.gameObject:GetComponent(typeof(RectTransform))
        end
        local goCardBG = self.controller.transform:Find("CardNodeBG")
        if not IsNull(goCardBG) then
            self.cardBG = goCardBG.gameObject:GetComponent(typeof(RawImage))
            self.rectCardBG = goCardBG.gameObject:GetComponent(typeof(RectTransform))
        end
        local goCardNodeFrame = self.controller.transform:Find("CardNodeFrame")
        if not IsNull(goCardNodeFrame) then
            self.cardFrame = goCardNodeFrame.gameObject:GetComponent(typeof(RawImage))
        end
        local goCardIndex = self.controller.transform:Find("SkillIndex")
        if not IsNull(goCardIndex) then
            self.cardIndex = goCardIndex.gameObject:GetComponent(typeof(RawImage))
        end
        local goCardTypeIcon = self.controller.transform:Find("SkillTypeBG/SkillType")
        if not IsNull(goCardTypeIcon) then
            self.cardTypeIcon = goCardTypeIcon.gameObject:GetComponent(typeof(RawImage))
        end
        local goCardTypeBG = self.controller.transform:Find("SkillTypeBG")
        if not IsNull(goCardTypeBG) then
            self.cardTypeBG = goCardTypeBG.gameObject:GetComponent(typeof(RawImage)) -- 技能卡类型图标背景
        end
        local shadow = self.controller.transform:Find("CardShadow")
        if not isNull(shadow) then
            self.shadow = shadow.gameObject:GetComponent(typeof(RawImage))
        end
    end)
end

function UIBattlingSkillCardsNodeBase:OnDestroy()
    base.OnDestroy(self)
    self.controller = nil
    self:Delete()
    self = nil
end

------------ LifeCycle ------------

------------ Function ------------

---SetSkillCardInfo
---设置卡牌数据
---@param cardData table 卡牌数据 skillId = xxx, star = xxx, roleId = xxx
function UIBattlingSkillCardsNodeBase:SetSkillCardInfo(cardData)
    base.SetSkillCardInfo(self, cardData)
    self.skillCardRoleId = checkNumber(cardData.roleId)
end

---ReloadCardInfo
---重新加载技能牌资源
function UIBattlingSkillCardsNodeBase:ReloadCardInfo()
    xTry(function()
        self:SetCardBG()
        self:SetSkillCardFrame()
        self:SetSkillCardIcon()
        self:SetCardTypeBG()
        self:SetSkillCardTypeIcon()
        self:SetSkillCardIndex()
        base.SetSkillCardLv(self)
        if not isNull(self.shadow) then
            UIBattlingCtrlMgr:GetInstance():SetImgByDynamicAtlas(self.shadow, Constants.SkillCardShadow)
        end
    end)
end

function UIBattlingSkillCardsNodeBase:SetSkillCardIndex()
    if IsNull(self.cardIndex) then return end
    if self.hideIndex == true then
        KTool.SetActive(self.cardIndex.gameObject, false)
        return
    end
    if self.isSPSkill then
        KTool.SetActive(self.cardIndex.gameObject, false)
        return 
    end
    KTool.SetActive(self.cardIndex.gameObject, true)
    local pathIndex = Constants.SkillCardIndex[self.skillCardStarLevel]
    UIBattlingCtrlMgr:GetInstance():SetImgByDynamicAtlas(self.cardIndex, pathIndex)
end

function UIBattlingSkillCardsNodeBase:SetCardTypeBG()
    if IsNull(self.cardTypeBG) then return end
    local pathIndex = self.isSPSkill 
            and Constants.SkillCardTypeBG.SP or Constants.SkillCardTypeBG.Common[self.skillCardStarLevel]
    UIBattlingCtrlMgr:GetInstance():SetImgByDynamicAtlas(self.cardTypeBG, pathIndex)
    --self.cardTypeBG.enabled = not self.isSPSkill
end

function UIBattlingSkillCardsNodeBase:SetCardBG()
    if IsNull(self.cardBG) then return end
    local pathBG = self.isSPSkill and Constants.SkillCardBG.SP or Constants.SkillCardBG.Common[self.skillCardStarLevel]
    UIBattlingCtrlMgr:GetInstance():SetImgByDynamicAtlas(self.cardBG, pathBG, self.rectCardBG)
end

function UIBattlingSkillCardsNodeBase:SetSkillCardFrame()
    if IsNull(self.cardFrame) then return end
    -- KTool.SetActive(self.cardFrame.gameObject, not self.isSPSkill)
    local pathFrame = self.isSPSkill and Constants.SkillCardFrame.SP or Constants.SkillCardFrame.Common[checkInt(self.skillCardStarLevel)]
    UIBattlingCtrlMgr:GetInstance():SetImgByDynamicAtlas(self.cardFrame, pathFrame)
end

function UIBattlingSkillCardsNodeBase:SetSkillCardTypeIcon()
    if IsNull(self.cardTypeIcon) then return end
    local condition = self.cardType >= 1 and self.cardType <= 6 and self.isAoe
    self.skillCardTypeIconPath = condition and UIBattlingTools.GetSkillTypeAOEIconPath(self.cardType) or
            UIBattlingTools.GetSkillTypeIconPath(self.cardType)
    KTool.SetActive(self.cardTypeIcon.gameObject, not IsNull(self.skillCardTypeIconPath))
    UIBattlingCtrlMgr:GetInstance():SetImgByDynamicAtlas(self.cardTypeIcon, self.skillCardTypeIconPath) -- 设置图片 Icon
end

function UIBattlingSkillCardsNodeBase:SetSkillCardIcon()
    if IsNull(self.skillCardSkillId) then return end
    if not self.overrideIcon then
        base.GetSkillCardIconPath(self)
    end
    if not IsNull(self.cardIcon) and not IsNull(self.skillCardImgPath) then
        UIBattlingCtrlMgr:GetInstance():SetImgByDynamicAtlas(self.cardIcon, self.skillCardImgPath, self.rectIcon)
    end
end

------------ Function ------------

return UIBattlingSkillCardsNodeBase
