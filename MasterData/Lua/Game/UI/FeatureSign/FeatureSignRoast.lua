---
--- Created by Eric.
--- DateTime: 2022/7/6 15:31
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule

------------ import ------------

------------ define ------------
local MaxLength = 100
------------ define ------------


--- from: Assets/BundleResources/Prefabs/DailyCheck/ThankLetterFillPopUp.prefab
---@class FeatureSignRoast
---@field Env                           	FeatureSignRoast
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Confirm                       	UnityEngine.RectTransform
---@field Cancel                        	UnityEngine.RectTransform
---@field InputField                    	UnityEngine.UI.InputField
---@field BtnClose                      	UnityEngine.RectTransform
local FeatureSignRoast = Class("FeatureSignRoast")
function FeatureSignRoast:__init()
    self.confirmCB = nil
end

function FeatureSignRoast:__delete()
    self.confirmCB = nil


    self.controller = nil
end

function FeatureSignRoast:Awake()
    self.confirmCB = self.controller.Argument.parameters.confirmCB--猫唯一id
    self.InputField.onValueChanged:AddListener(function(txt)
        self.Content.text = txt
    end)
    self:SetBtnAction()

end

function FeatureSignRoast:SetBtnAction()
    SetButtonAction(self.Confirm, function ()
        local length = utf8.len(self.InputField.text)
        local confirmSucceed = length <= MaxLength--预留出字数限制
        confirmSucceed = true
        if confirmSucceed then
            GameUtils.Request(
                    Interfaces.PlayerEvaluation,
                    {
                        content = self.InputField.text
                    },
                    function(request, response)
                        if checkInt(response.errCode) == 0 then
                            ---维护数据，刷新下层界面的信息
                            if self.confirmCB then
                                self.confirmCB()
                            end
                            UIModule.BackDialog()
                        end
                    end
            )
        else
            GameUtils.Toast(localize("最多_length_个字", {_length_ = MaxLength}))
        end
    end)

    SetButtonAction(self.Cancel, function ()
        UIModule.BackDialog()
    end)
    SetButtonAction(self.BtnClose, function ()
        UIModule.BackDialog()
    end)
end

function FeatureSignRoast:OnFocus(focus)
end

function FeatureSignRoast:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function FeatureSignRoast:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return FeatureSignRoast