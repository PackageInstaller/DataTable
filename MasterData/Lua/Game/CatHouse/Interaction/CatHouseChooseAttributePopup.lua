---
--- Created by Eric.
--- DateTime: 2022/3/16 14:36
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local CatHouseComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)

------------ import ------------

------------ define ------------

------------ define ------------


---@class CatHouseChooseAttributePopup
---@field BtnClose                      	UnityEngine.RectTransform
---@field BtnNode                       	UnityEngine.RectTransform
---@field LayoutBtnAttribute            	UnityEngine.RectTransform
local CatHouseChooseAttributePopup = Class("CatHouseChooseAttributePopup")
function CatHouseChooseAttributePopup:__init()

end

function CatHouseChooseAttributePopup:__delete()
    self.controller = nil
end

function CatHouseChooseAttributePopup:Awake()
    self.catData = self.controller.Argument.parameters.catData
    SetButtonAction(self.BtnClose, function()
        UIModule.BackDialog()
    end)
    self.catAttrVo = CfUtils.GetWholeVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo")
    for i, v in pairs(self.catAttrVo) do
        local go = CfUtils.InstantiateGo(self.BtnNode, self.LayoutBtnAttribute)
        local goEnv = CfUtils.GetLuaScr(go, "Game.CatHouse.Interaction.CatHouseChooseAttributeCell")
        goEnv:FreshBaseUI(v)
        goEnv:SetBtnCallBack(function ()
            local rolesData = CatHouseComponent:GetTrainCardsTeamByAttrId(v.id, self.catData)
            local isEmpty = true
            for i, v in pairs(rolesData) do
                if table.count(v) ~= 0 then
                    isEmpty = false
                    break
                end
            end
            if isEmpty then
                GameUtils.Toast(localize("没有符合要求的训练师"))
                return
            else
                Events.Broadcast(Constants.EventNames.CatHouseCatTrainRolesSet, rolesData)
                Events.Broadcast(Constants.EventNames.CatHouseCatAttrPreview, rolesData)
                UIModule.BackDialog()
            end
        end)
        KTool.SetActive(go, true)
    end
end

function CatHouseChooseAttributePopup:OnFocus(focus)
end

function CatHouseChooseAttributePopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function CatHouseChooseAttributePopup:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return CatHouseChooseAttributePopup