---
--- Created by Eric.
--- DateTime: 2022/3/22 15:40
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
------------ import ------------

------------ define ------------

------------ define ------------


---@class UIFightChooseCardsCatTrainAdditionCell
---@field UIFX_CatHouseTrainActivate    	UnityEngine.RectTransform
---@field TextDescripe                  	UnityEngine.UI.Text
---@field ImgIcon                       	Engine.UI.RawImageAlterable
---@field ImgBg                         	UnityEngine.RectTransform
---@field TextNumber                    	TMPro.TextMeshProUGUI
local UIFightChooseCardsCatTrainAdditionCell = Class("UIFightChooseCardsCatTrainAdditionCell")
function UIFightChooseCardsCatTrainAdditionCell:__init()
    --self.btnAction = nil

end

function UIFightChooseCardsCatTrainAdditionCell:__delete()
    --self.btnAction = nil

    self.controller = nil
end

-----SetCallBack
-----设置单击回调函数
--function UIFightChooseCardsCatTrainAdditionCell:SetBtnCallBack(cb)
--    self.btnAction = cb
--end

function UIFightChooseCardsCatTrainAdditionCell:Awake()
    --KTool.GetOrAddComponent(self.controller.gameObject, typeof(UIEventProxy)).onPointerClick = function()
    --    if type(self.btnAction) == 'function' then
    --        self.btnAction()
    --    end
    --end
end

function UIFightChooseCardsCatTrainAdditionCell:FreshBaseUI(data, cardData, catData)
    local cardData = cardComponent:GetCardById(cardComponent:GetIdByCardId(cardData.refId))
    self.TextNumber.text = data.starLv
    local isUnlock = checkNumber(cardData.star) >= checkNumber(data.starLv)
    local skillVo = CfUtils.GetCfVo(AutoIds.IdSetting1917, "CatTrainSkillVo", data.additionId)
    local isMatchingCat = checkNumber(skillVo.catId) == 0 or checkNumber(skillVo.catId) == checkNumber(catData.catId) --全部生效 or 对指定猫种生效
    KTool.SetActive(self.ImgBg, isUnlock)
    KTool.SetActive(self.UIFX_CatHouseTrainActivate, isUnlock and isMatchingCat)
    local skillVo = CfUtils.GetCfVo(AutoIds.IdSetting1917, "CatTrainSkillVo", data.additionId)
    local attrVo =  CfUtils.GetCfVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo", skillVo.attributeId)
    self.ImgIcon:LoadSprite(attrVo.picture)
    local isShowPercentage = skillVo.percentage == 1
    local targetNum = isShowPercentage and math.tointeger(data.additionNum * 100) or data.additionNum
    local text = string.gsub(skillVo.decr, "_target_num_", targetNum)
    if isShowPercentage then
        text = text.."%"
    end
    self.TextDescripe.text = text
end

function UIFightChooseCardsCatTrainAdditionCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return UIFightChooseCardsCatTrainAdditionCell