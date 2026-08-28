
--region global define
local isNull    = isNull
local isNotNull = isNotNull



--endregion

--region import

---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")

--endregion

--region define
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--- from: Assets/BundleResources/Prefabs/Common/CatballSkillCardNode.prefab
---@class CatBallSkillCardNode
---@field Env                           	CatBallSkillCardNode                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field SkillType                     	Engine.UI.ImageAlterable                
---@field SkillTypeBG                   	Engine.UI.ImageAlterable                
---@field CardNodeFrame                 	Engine.UI.ImageAlterable                
---@field SkillIcon                     	Engine.UI.ImageAlterable                
---@field BattleSkill                   	UnityEngine.Transform                   
---@field ImgSkillIcon                  	Engine.UI.ImageAlterable                
---@field ManageSkill                   	UnityEngine.RectTransform               
---@field CardNodeBG                    	Engine.UI.ImageAlterable                
local CatBallSkillCardNode = Class('CatBallSkillCardNode')

function CatBallSkillCardNode:__init()

end


function CatBallSkillCardNode:__delete()

end


function CatBallSkillCardNode:Awake()
end


function CatBallSkillCardNode:Start()
    SetButtonAction(self.controller.gameObject, Bind(self, self.OnClickNodeAction))
end


function CatBallSkillCardNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshCatBallSkill
---@param skillVo CatBallSkillVo | MaidCoffeeSkillVo
function CatBallSkillCardNode:FreshCatBallSkill(skillVo, catType)

    if catType == Constants.CatBallType.Operates then
        self:FreshCatBallOperatesSkill(skillVo)

    else
        self:FreshCatBallBattleSkill(skillVo)
    end


end

---FreshCatBallOperatesSkill
---刷新猫球经营技能
---@param skillVo MaidCoffeeSkillVo
function CatBallSkillCardNode:FreshCatBallOperatesSkill(skillVo)
    KTool.SetActive(self.ManageSkill.gameObject,   true)
    KTool.SetActive(self.BattleSkill.gameObject,   false)

    self.ImgSkillIcon:LoadSprite(skillVo.icon)
    self.CardNodeBG:LoadSprite("UIAtlas/CultivateOversea/AttributeIcon/cat_img_skill_bg.png")
end

---FreshCatBallBattleSkill
---刷新猫球战斗技能
---@param skillVo CatBallSkillVo
function CatBallSkillCardNode:FreshCatBallBattleSkill(skillVo)
    local skillType = skillVo.skillType
    local isBuff    = skillType == 2
    KTool.SetActive(self.ManageSkill.gameObject,   false)
    KTool.SetActive(self.BattleSkill.gameObject,   true)
    KTool.SetActive(self.CardNodeFrame.gameObject, not isBuff)
    KTool.SetActive(self.SkillTypeBG.gameObject,   not isBuff)

    local skillGroupType = isBuff and CardProgressionConstants.SkillGroupType.Buff or CardProgressionConstants.SkillGroupType.Normal
    self.CardNodeBG:LoadSprite(CardProgressionSkillUtils.GetSkillBg(skillGroupType, 1))
    self.SkillIcon:LoadSprite(skillVo.icon)
    if not isBuff then
        local framePath = CardProgressionSkillUtils.GetNormalSkillFrame(skillGroupType, 1)
        if framePath then
            self.CardNodeFrame:LoadSprite(framePath)
        end
        
        local skillId = skillVo.addSkillId
        ---@type SkillCardVo
        local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillId, skillGroupType)
        local showLabel = CardProgressionSkillUtils.GetSkillShowLabelWithStar(vo.showLabel, 1)
        self.SkillType:LoadSprite(CardProgressionSkillUtils.GetCardSkillAttrIcon(showLabel, 0, true, vo.isAoe))
        self.SkillTypeBG:LoadSprite(CardProgressionSkillUtils.GetSkillTypeAttrBG(skillGroupType, 1))
        

    end

end

--endregion 


--region get/set 
function CatBallSkillCardNode:SetCallback(cb)
    self._callback = cb
end

---endregion 


--region handler 

function CatBallSkillCardNode:OnClickNodeAction()
    if self._callback then
        self._callback()
        return
    end

    
end

---endregion 


return CatBallSkillCardNode
