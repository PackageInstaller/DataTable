------------ import ------------
local KTool = CS.Engine.Lib.KTool
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
------------ import ------------

------------ define ------------
------------ define ------------

--- from: Assets/BundleResources/Prefabs/UIBattling/EnemyCardNode.prefab
---@class UIBattlingEnemySkillCardsNode
---@field Env                           	UIBattlingEnemySkillCardsNode           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CardImg                       	UnityEngine.UI.RawImage                
local UIBattlingEnemySkillCardsNode = Class("UIBattlingEnemySkillCardsNode")

function UIBattlingEnemySkillCardsNode:__init()
   self:CleanProperty()
end

function UIBattlingEnemySkillCardsNode:__delete()
    self:CleanProperty()
    self.controller = nil
    self = nil
end

function UIBattlingEnemySkillCardsNode:CleanProperty()
    self.skillCardData = nil -- 技能卡数据
    self.skillCardRoleId = nil -- 技能卡角色Id
    self.skillCardSkillId = nil -- 技能卡技能Id
    self.skillCardStarLevel = nil -- 技能卡星级
    self.showLabel = nil -- 技能卡技能类型
    self.skillCardTypeIconPath = nil -- 技能卡 技能Icon路径
    self.skillHomeRoot = nil
    self.canvasGroup = nil
end

function UIBattlingEnemySkillCardsNode:Awake()
end

function UIBattlingEnemySkillCardsNode:OnDestroy()
    self.controller = nil
    self:Delete()
    self = nil
end

---SetSkillCardInfo
---设置技能卡信息
---@param cardData table @ { skillIndex = data[i].skillIndex, targetId = data[i].targetId, star = data[i].star, roleId =  data[i].roleId, combo = data[i].combo }
function UIBattlingEnemySkillCardsNode:SetSkillCardInfo(cardData, isBuffCard)
    isBuffCard = checkBool(isBuffCard)
    self.skillCardData = cardData
    self.skillCardRoleId = cardData.roleId
    local skillData = UIBattlingDataMgr:GetSkillIdByRoleIdAndSkillIndex(cardData.roleId, cardData.skillIndex)
    if not IsNull(skillData) then
        self.skillCardSkillId = skillData.skillId
    end
    local skillIndex = self.skillCardData.skillIndex
    local isSPSkill = skillIndex == 0
    self.skillCardStarLevel = isSPSkill and 0 or cardData.star
    if isBuffCard or (not isSPSkill) then -- 非 SP 技能
        local skillVo = UIBattlingTools.GetSkillCardInfoByTwoParam(self.skillCardSkillId, self.skillCardStarLevel)
        local label = skillVo.showLabel
        self.showLabel = UICommonUtils:GetSkillShowLabelWithStar(label, cardData.star)
        local isAoe = checkBool(checkNumber(skillVo.isAoe) > 0)
        local condition = self.showLabel >= 1 and self.showLabel <= 6 and isAoe
        self.skillCardTypeIconPath = condition and UIBattlingTools.GetEnemySkillTypeAOEIconPath_1(self.showLabel) or 
                UIBattlingTools.GetEnemySkillTypeIconPath_1(self.showLabel)
        UIBattlingCtrlMgr:GetInstance():SetImgByDynamicAtlas(self.CardImg, self.skillCardTypeIconPath)
        local isPowerful = UIBattlingTools.GetSkillCardInfoByTwoParam(self.skillCardSkillId, self.skillCardStarLevel).isPowerful
        if not IsNull(self.ImgRed) and isPowerful then
            KTool.SetActive(self.ImgRed.gameObject, checkInt(isPowerful) > 0)
        end
    else -- SP 技能
        if not IsNull(self.ImgRed) then
            KTool.SetActive(self.ImgRed.gameObject, false)
        end
        UIBattlingCtrlMgr:GetInstance():SetImgByDynamicAtlas(self.CardImg, "UIBattlingDynamicAtlas/battle_icon_sp.png")
    end
end

---RecycleSelf
---回收节点
function UIBattlingEnemySkillCardsNode:RecycleSelf()
    if self.controller then
        UIBattlingTools.RecyclePoolObj(self.controller.gameObject)
    end
end

function UIBattlingEnemySkillCardsNode:GetSkillCardRoleId()
    return self.skillCardRoleId
end

return UIBattlingEnemySkillCardsNode
