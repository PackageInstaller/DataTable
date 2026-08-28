
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')

---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Common/CommonTipsSkill.prefab > name: CommonTipsSkill
---@class CommonTipsSkill
---@field Env                           	CommonTipsSkill                         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Root                          	UnityEngine.RectTransform               
---@field PassivityAttribute            	UnityEngine.RectTransform               
---@field DescTxt                       	UnityEngine.UI.Text                     
---@field TitleText                     	UnityEngine.UI.Text                     
---@field Img_GiftIcon                  	UnityEngine.RectTransform               
---@field Arrow                         	UnityEngine.RectTransform               
---@field Bg                            	UnityEngine.RectTransform               
local CommonTipsSkill = Class('CommonTipsSkill', CommonTipsBoard)

function CommonTipsSkill:__init()
    CommonTipsBoard.__init(self)    
end


function CommonTipsSkill:__delete()
    CommonTipsBoard.__delete(self)
end


-- function CommonTipsSkill:Awake()
--     CommonTipsBoard.Awake(self)
--     CommonTipsBoard.Init(self)
-- end


-- function CommonTipsSkill:Start()
-- end

function CommonTipsSkill:OnDestroy()
    CommonTipsBoard.OnDestroy(self)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
function CommonTipsSkill:FreshUI(data)
    if data.isCustom then
        self:FreshUIByCustomData(data)
        return
    end
    ---@type number
    local skillId        = data.skillId
    ---@type CardProgressionConstants.SkillGroupType
    local skillGroupType = data.skillGroupType
    ---@type number | nil
    local skillLevel     = data.skillLevel or 1
    ---@type boolean | nil 是否是战斗描述
    local isSpecify      = data.isSpecify
    ---@type table | nil
    local otherDataList  = data.otherDataList

    ---@type TalentVo | SkillCardVo
    local desc, name, vo = CardProgressionSkillUtils.GetSkillInfo(skillId, skillLevel, skillGroupType, isSpecify)

    if skillGroupType == CardProgressionConstants.SkillGroupType.Buff then
        self.Img_GiftIcon:LoadSprite(vo.iconPath)
    end
    
    self.TitleText.text = name
    self.DescTxt.text   = desc

    if otherDataList then
        local parent = self.Bg.gameObject
        local child = self.PassivityAttribute.gameObject
        for index, value in ipairs(otherDataList) do
            local go
            if index == 1 then
                go = child
            else
                go = parent:AddChild(child)
            end
            if isNotNull(go) then
                local trans = go.transform
                local ImgIcon = trans:Find("ImgIcon")
                local TxtState = trans:Find("TxtState")

                CfUtils.FillText(TxtState, value.desc)
                CfUtils.FillImage(ImgIcon, value.iconPath)
            end
        end
    end
end

function CommonTipsSkill:FreshUIByCustomData(data)
    self.TitleText.text = data.name
    self.DescTxt.text   = data.desc
    local iconPath = data.iconPath
    if not string.isEmpty(iconPath) then
        self.Img_GiftIcon:LoadSprite(data.iconPath)
    end
    
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CommonTipsSkill
