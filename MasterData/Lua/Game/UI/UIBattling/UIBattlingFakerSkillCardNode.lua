
------------ import ------------
local CanvasGroup = CS.UnityEngine.CanvasGroup
------------ import ------------

---@type UIBattlingSkillCardsNodeBase
local base = import("Game.UI.UIBattling.UIBattlingSkillCardsNodeBase")
---@class UIBattlingFakerSkillCardNode
local UIBattlingFakerSkillCardNode = Class("UIBattlingFakerSkillCardNode", base)

function UIBattlingFakerSkillCardNode:__init()
    base.__init(self)
    self.curGOCanvasGroup = nil
    self.curSelectSkillCardData = nil -- 当前 玩家选中 技能牌信息
end

function UIBattlingFakerSkillCardNode:__delete()
    base.__delete(self)
    self.curGOCanvasGroup = nil
    self.curSelectSkillCardData = nil
end

function UIBattlingFakerSkillCardNode:Awake()
    base.Awake(self)
    self.curGOCanvasGroup = self.controller:GetComponent(typeof(CanvasGroup))
end

function UIBattlingFakerSkillCardNode:Start()
end

function UIBattlingFakerSkillCardNode:OnDestroy()
    base.OnDestroy(self)
    self.controller = nil
    self:Delete()
    self = nil
end

---SetFakerSkillCardShowState
---设置残影牌显示状态
function UIBattlingFakerSkillCardNode:SetFakerSkillCardShowState(boolean)
    if IsNull(self.curGOCanvasGroup) then return end
    self.curGOCanvasGroup.alpha = boolean and 0.2 or 0
end

---SetSkillCardInfo
---设置残影牌信息
function UIBattlingFakerSkillCardNode:SetSkillCardInfo(cardData)
    base.SetSkillCardInfo(self, cardData)
    base.ReloadCardInfo(self)
end

---SetFakerSkillCardOnPlayerSelect
---玩家 选择 技能卡时保存数据 && 卡牌设置信息
function UIBattlingFakerSkillCardNode:SetFakerSkillCardOnPlayerSelect(cardData)
    self.curSelectSkillCardData = cardData
    self:SetSkillCardInfo(cardData)
end

---ReSetSelectSkillCardInfo
---还原设置玩家选择技能卡信息
function UIBattlingFakerSkillCardNode:ReSetSelectSkillCardInfo()
    if not IsNull(self.curSelectSkillCardData) then
        self:SetSkillCardInfo(self.curSelectSkillCardData)
    end
end

return UIBattlingFakerSkillCardNode
