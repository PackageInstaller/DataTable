---
--- Created by Eric.
--- DateTime: 2022/2/24 10:23
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule

------------ import ------------

------------ define ------------

------------ define ------------


---@class SettingCDKExchange
---@field InputField                    	UnityEngine.UI.InputField
---@field BtnSure                       	UnityEngine.RectTransform
---@field BtnClose                      	UnityEngine.RectTransform
local SettingCDKExchange = Class("SettingCDKExchange")
function SettingCDKExchange:__init()

end

function SettingCDKExchange:__delete()
    self.controller = nil
end

function SettingCDKExchange:Awake()
    SetButtonAction(self.BtnClose, function ()
        UIModule.BackDialog()
    end)
    SetButtonAction(self.BtnSure, function ()
        local txtInput = self.InputField.text
        if txtInput == '' then
            GameUtils.Toast(localize("礼包码不能为空"))
            return
        end
        GameUtils.Request(
                Interfaces.PlayerExchangeCode,
                {
                    code = checkString(txtInput)
                },
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        --入包
                        GoodsUtils.DrawRewards(response.data.rewards)
                        --打开通用获取UI
                        UIModule.OpenDialog(
                                {
                                    id = Constants.UITypeIds.UICommonRewardPop,
                                    parameters = { rewards = response.data.rewards }
                                }
                        )
                    end
                end
        )
    end)
end

function SettingCDKExchange:OnFocus(focus)
end

function SettingCDKExchange:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function SettingCDKExchange:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return SettingCDKExchange