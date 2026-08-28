
------------ import ------------
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
---@type Engine.Lib.KTool
local KTool                     = CS.Engine.Lib.KTool
---@type CardConfMgr
local cardConfMgr               = CardConfMgr:GetInstance()
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/Common/SkillCardNode.prefab > name: SkillCardNode
---@class CardProgressionSkillNode
---@field Env                           	CardProgressionSkillNode                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field GiftIcon                      	Engine.UI.RawImageAlterable             
---@field SkillType                     	Engine.UI.ImageAlterable                
---@field SkillTypeBG                   	Engine.UI.ImageAlterable                
---@field CardNodeFrame                 	Engine.UI.ImageAlterable                
---@field SkillIndex                    	Engine.UI.ImageAlterable                
---@field TextNumberLevel               	Game.Native.Common.UISwitchTextMeshPro                   
---@field TextLv                        	Game.Native.Common.UISwitchTextMeshPro  
---@field Level                         	UnityEngine.RectTransform               
---@field SkillIcon                     	Engine.UI.RawImageAlterable             
---@field CardNodeBG                    	Engine.UI.ImageAlterable                
local CardProgressionSkillNode = Class('CardProgressionSkillNode')

function CardProgressionSkillNode:__init()

end


function CardProgressionSkillNode:__delete()

end


function CardProgressionSkillNode:Awake()
    --- 默认隐藏LV 11.22版本内容 去掉大招和被动lv显示
    KTool.SetActive(self.Level.gameObject, false)
end


function CardProgressionSkillNode:Start()
    SetButtonAction(self.controller.gameObject, Bind(self, self.OnClickNodeAction))

end


function CardProgressionSkillNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param skillData table ---{ skillId,    cardAwakeVo.openLevel,  skillGroupType }
---@param cardVo CardVo
---@param isHideLv boolean
function CardProgressionSkillNode:FreshUI(skillData, cardVo, isHideLv, isPreview)
    self._skillData, self._cardVo = skillData, cardVo
    local skillId, skillLevel, skillGroupType = SafeUnpack(skillData)
    local attributeType = cardVo.attributeType
    self.CardNodeBG:LoadSprite(CardProgressionSkillUtils.GetSkillBg(skillGroupType, skillLevel))

    ---@type SkillCardVo | TalentVo
    local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillId, skillGroupType)
    local isNormal = skillGroupType == CardProgressionConstants.SkillGroupType.Normal
    local isFinal  = skillGroupType == CardProgressionConstants.SkillGroupType.Final
    local isBuff   = skillGroupType == CardProgressionConstants.SkillGroupType.Buff

    KTool.SetActive(self.CardNodeFrame.gameObject, not isBuff)
    KTool.SetActive(self.GiftIcon.gameObject,      isBuff)
    KTool.SetActive(self.SkillIcon.gameObject,     not isBuff)
    KTool.SetActive(self.SkillIndex.gameObject,    isNormal)
    KTool.SetActive(self.SkillTypeBG.gameObject,   not isBuff)
    -- KTool.SetActive(self.Level.gameObject, not isNormal and not isHideLv)
    
    local path
    if isBuff then
        path = vo.iconPath
        self.GiftIcon:LoadSprite(path)
        if not isHideLv then
            self:FreshSkillLevel(skillLevel, isPreview)
        end
    else
        ---是大招 则 大招等级 -> 大招展示等级
        if isFinal and not isHideLv then
            self:FreshSkillLevel(skillLevel, isPreview)
        end
        
        local framePath = CardProgressionSkillUtils.GetNormalSkillFrame(skillGroupType, skillLevel)
        if framePath then
            self.CardNodeFrame:LoadSprite(framePath)
        end

        self.SkillIndex:LoadSprite(CardProgressionSkillUtils.GetSkillIndex(skillGroupType, vo.skillType, skillLevel))
        
        local showLabel = CardProgressionSkillUtils.GetSkillShowLabelWithStar(vo.showLabel, skillLevel)
        self.SkillType:LoadSprite(CardProgressionSkillUtils.GetCardSkillAttrIcon(showLabel, attributeType, true, vo.isAoe))
        self.SkillTypeBG:LoadSprite(CardProgressionSkillUtils.GetSkillTypeAttrBG(skillGroupType, 1))
        local listSkillCardImgPath = vo.skillIconPath
        path = listSkillCardImgPath[skillLevel] or listSkillCardImgPath[1] -- 技能卡卡面 Icon 的图片路径
        self.SkillIcon:LoadSprite(path)

    end

    
end

function CardProgressionSkillNode:FreshSkillLevel(skillLevel, isPreview)
    self.TextNumberLevel.text = skillLevel
    self.TextNumberLevel.Status = isPreview and 2 or 1
    self.TextLv.Status = isPreview and 2 or 1
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionSkillNode:SetTargetNode(node)
    self._targetNode = node
end

function CardProgressionSkillNode:SetCallback(cb)
    self._callback = cb
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionSkillNode:OnClickNodeAction()
    if self._callback then
        self._callback({skillData = self._skillData, cardVo = self._cardVo})
        return
    end

    if isNull(self._targetNode) then
       return 
    end
    CardProgressionSkillUtils.LoadSkillDescNode(
        self._targetNode, 
        {skillData = self._skillData, cardVo = self._cardVo}
    )
    
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionSkillNode
