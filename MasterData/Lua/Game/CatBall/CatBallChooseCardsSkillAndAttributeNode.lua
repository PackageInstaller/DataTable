
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local import = import
--endregion

--region import
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CatBallUtils
local CatBallUtils                = import("Game.CatBall.CatBallUtils")

--endregion

--region define 
local SkillNodeEnvPath     =      "Game.CatBall.CatBallSkillCardNode"
local SimpleAttributeNodeEnvPath  = "Game.Behaviours.SimpleAttributeNode"
--endregion

--- from: Assets/BundleResources/Prefabs/FightTeam/CatballChooseCardsDialog.prefab
---@class CatBallChooseCardsSkillAndAttributeNode
---@field Env                           	CatBallChooseCardsSkillAndAttributeNode 
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextDesc                      	CustomText                              
---@field TxtName                       	UnityEngine.UI.Text                     
---@field TxtStats                      	Game.Native.Common.UISwitchText         
---@field ImgSkillBg                    	Game.Native.Common.UISwitchImage        
---@field SkillCardNode                 	UnityEngine.RectTransform               
---@field TextTitle                     	UnityEngine.UI.Text                     
---@field AttributeLayout               	UnityEngine.RectTransform               
---@field AttributeDesGroup             	UnityEngine.RectTransform               
local CatBallChooseCardsSkillAndAttributeNode = Class('CatBallChooseCardsSkillAndAttributeNode')

function CatBallChooseCardsSkillAndAttributeNode:__init()
    self._attrNodes = {}
end


function CatBallChooseCardsSkillAndAttributeNode:__delete()

end


function CatBallChooseCardsSkillAndAttributeNode:Awake()
end


-- function CatBallChooseCardsSkillAndAttributeNode:Start()
-- end


function CatBallChooseCardsSkillAndAttributeNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 


function CatBallChooseCardsSkillAndAttributeNode:FreshUI(catEggDojo, customStar)
    local catId      = catEggDojo.catId
    ---@type CatBallVo
    local catBallVo  = CatBallUtils.GetCatBallVo(catId)
    local catType    = catBallVo.types
    local skillTitle
    KTool.SetActive(self.AttributeDesGroup.gameObject, catType ~= Constants.CatBallType.Operates)
    local isStarUp = customStar ~= nil
    local star = customStar or catEggDojo.star

    ---@type string
    local skillDesc
    ---@type string
    local skillName
    ---@type CatBallSkillVo | MaidCoffeeSkillVo
    local skillVo
    skillDesc, skillName, skillVo = CatBallUtils.GetCatBallSkillDesc(catId, star, catType, isStarUp)
    if catType == Constants.CatBallType.Operates then
        skillTitle = localize("经营技能")
        
    else
        self:FreshAttributeDesGroup(catId, star, isStarUp)
        
        skillTitle = localize("战斗技能")
        
    end

    self:FreshSkillCardNode(skillVo, catType)

    if self.ImgSkillBg then
        self.ImgSkillBg.Status = catType
    end
    if self.TxtStats then
        self.TxtStats.Status   = catType
    end
    if self.TxtName then
        self.TxtName.text      = skillName
    end
    if self.TextTitle then
        self.TextTitle.text    = skillTitle
    end
    self.TextDesc.text     = skillDesc
end

---FreshSkillCardNode
---@param skillVo CatBallSkillVo | MaidCoffeeSkillVo
---@param catType Constants.CatBallType
function CatBallChooseCardsSkillAndAttributeNode:FreshSkillCardNode(skillVo, catType)
    ---@type CatBallSkillCardNode
    local env = self:GetSkillNodeEnv()
    if isNull(env) then return end
    env:FreshCatBallSkill(skillVo, catType)

end


---FreshAttributeDesGroup
---@param catId number 猫球id
---@param star number 猫球星级
function CatBallChooseCardsSkillAndAttributeNode:FreshAttributeDesGroup(catId, star, isShowNextAttr)
    local attrDefineInfo
    if isShowNextAttr then
        attrDefineInfo = CatBallUtils.CompareCatBallStarAttrDefineInfo(catId, star - 1, star)
    else
        attrDefineInfo = CatBallUtils.GetCatBallAttrDefineInfoByStar(catId, star)
    end
    local parent        = self.AttributeLayout
    local childCount    = parent.childCount
    local attrNodes     = self._attrNodes
    local dataCount     = #attrDefineInfo
    local nodeCount     = #attrNodes
    local forTimes      = math.max(dataCount, nodeCount)

    for i = 1, forTimes do
        local node = attrNodes[i]
        if isNull(node) then
            if i > childCount then
                local parentGo = parent.gameObject
                local child = attrNodes[1].gameObject
                node = parentGo:AddChild(child)
            else
                node = parent:GetChild(i - 1).gameObject
            end
            attrNodes[i] = node
        end

        local attrData = attrDefineInfo[i]
        if attrData then
            KTool.SetActive(node, true)
            self:FreshAttributeNode(node, attrData, i)
        elseif isNotNull(node) then
            KTool.SetActive(node, false)
        end

    end
end


function CatBallChooseCardsSkillAndAttributeNode:FreshAttributeNode(node, attrData, index)
    ---@type SimpleAttributeNode
    local env = CfUtils.GetLuaScr(node, SimpleAttributeNodeEnvPath)
    if isNull(env) then
        return
    end
    env:FreshUIByAttrDefineInfo(attrData.vo, attrData.num, attrData.nextAttrNum, index)
end


--endregion 


--region get/set 

---GetSkillNodeEnv
---@return CatBallSkillCardNode
function CatBallChooseCardsSkillAndAttributeNode:GetSkillNodeEnv()
    if isNull(self._skillNodeEnv) then
        self._skillNodeEnv = CfUtils.GetLuaScr(self.SkillCardNode.gameObject, SkillNodeEnvPath)
    end
    return self._skillNodeEnv
end

---endregion 


--region handler 


---endregion 


return CatBallChooseCardsSkillAndAttributeNode
