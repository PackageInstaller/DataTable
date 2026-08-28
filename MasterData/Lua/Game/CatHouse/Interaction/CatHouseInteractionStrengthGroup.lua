---
--- Created by Eric.
--- DateTime: 2022/1/5 10:23
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local ConstantsCatHouse = import("Game.CatHouse.ConstantsCatHouse")
------------ import ------------

------------ define ------------
local CatHouseComponent

------------ define ------------


---@class CatHouseInteractionStrengthGroup
---@field Full                          	UnityEngine.RectTransform
---@field TextNumberSecond              	TMPro.TextMeshProUGUI
---@field ImgIconStrength2              	Engine.UI.RawImageAlterable
---@field Recover                       	UnityEngine.RectTransform
---@field Explore                       	UnityEngine.RectTransform
---@field Tips                          	UnityEngine.RectTransform
---@field TextNumber                    	TMPro.TextMeshProUGUI
---@field BtnStrength                   	UnityEngine.RectTransform
---@field ImgIconStrength               	Engine.UI.RawImageAlterable
local CatHouseInteractionStrengthGroup = Class("CatHouseInteractionStrengthGroup")
function CatHouseInteractionStrengthGroup:__init()
    self.btnAction = nil
    self.isShowTimeTips = false
    self.data = {}
    self.strengthAttrId = nil
    self.subjoinAttrMap = {}


end

function CatHouseInteractionStrengthGroup:__delete()
    self.btnAction = nil
    self.isShowTimeTips = nil

    self.data = nil
    self.strengthAttrId = nil
    self.subjoinAttrMap = nil

    self.controller = nil
end

function CatHouseInteractionStrengthGroup:Awake()
    self.EventAttrPreview = Events.AddListener(Constants.EventNames.CatHouseCatAttrPreview, Bind(self, self.FreshAttrPreview))
    self.EventTimeChange = Events.AddListener(Constants.EventNames.CatHouseTimeChange, Bind(self, self.HpTimeChange))

    CatHouseComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)
    self.strengthAttrId = CatHouseComponent:GetStrengthAttrId()
    --KTool.GetOrAddComponent(self.controller.gameObject, typeof(UIEventProxy)).onPointerClick = function()
    --    if type(self.btnAction) == 'function' then
    --        self.btnAction()
    --    end
    --end
    SetButtonAction(self.BtnStrength, function ()
        self.isShowTimeTips = not self.isShowTimeTips
        --KTool.SetActive(self.Tips, self.isShowTimeTips)
        CfUtils.PlayAnimator(self.Tips, self.isShowTimeTips and "TipsEnter" or "TipsExit")
    end)
end

-----SetCallBack
-----设置单击回调函数
--function CatHouseInteractionStrengthGroup:SetBtnCallBack(cb)
--    self.btnAction = cb
--end

---@param data table 猫数据
function CatHouseInteractionStrengthGroup:FreshBaseUI(data)
    self.data = data
    local strengthVo = CfUtils.GetCfVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo", self.strengthAttrId)
    self.ImgIconStrength:LoadSprite(strengthVo.picture)
    self.ImgIconStrength2:LoadSprite(strengthVo.picture)
    self.TextNumber.text = string.format("%s/%s", self.data.hp, self.data.hpLimit)

end

---@param data table id,num  id为选中道具的id  num为选中的数量
function CatHouseInteractionStrengthGroup:FreshAttrPreview(data)
    if isNull(data) then
        return
    end
    local subjoinAttrMap = CatHouseComponent:GetSubjoinAttr(data)
    self.subjoinAttrMap = subjoinAttrMap
    if subjoinAttrMap[self.strengthAttrId] > 0 then
        self.TextNumber.text = string.format("%s+%s/%s", self.data.hp, subjoinAttrMap[self.strengthAttrId], self.data.hpLimit)
    else
        self.TextNumber.text = string.format("%s/%s", self.data.hp, self.data.hpLimit)
    end

end

---实时刷新体力
function CatHouseInteractionStrengthGroup:HpTimeChange()
    if isNull(self.data) then
        return
    end

    local deltaCatData = CatHouseComponent:GetCatDataById(self.data.id)
    if isNull(deltaCatData) then
        return
    end
    self.data = deltaCatData
    if not isNull(self.subjoinAttrMap[self.strengthAttrId]) then
        if self.subjoinAttrMap[self.strengthAttrId] > 0 then
            self.TextNumber.text = string.format("%s+%s/%s", self.data.hp, self.subjoinAttrMap[self.strengthAttrId], self.data.hpLimit)
        else
            self.TextNumber.text = string.format("%s/%s", self.data.hp, self.data.hpLimit)
        end
    else
        self.TextNumber.text = string.format("%s/%s", self.data.hp, self.data.hpLimit)
    end

    if self.isShowTimeTips then
        local isFull = checkNumber(self.data.hp) >= checkNumber(self.data.hpLimit)
        KTool.SetActive(self.Full, isFull)
        if not isFull then
            local catCDData = CatHouseComponent:GetCDDataById(self.data.id)
            local isInExplore = catCDData~= nil and catCDData[ConstantsCatHouse.CatStatus.Exploring] ~= nil
            KTool.SetActive(self.Explore, isInExplore)
            KTool.SetActive(self.Recover, not isInExplore)
            if not isInExplore then
                self.TextNumberSecond.text = self.data.nextHpSeconds
            end
        end
    end
end


function CatHouseInteractionStrengthGroup:OnDestroy()
    Events.RemoveListener(Constants.EventNames.CatHouseCatAttrPreview, self.EventAttrPreview)
    CatHouseComponent = nil
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseInteractionStrengthGroup