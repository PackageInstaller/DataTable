--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{jialei}
    time:2019-11-21 21:21:43
]]

local util = require 'XLua.util'
local UINavigationBarRoot = CS.UINavigationBarRoot
local CoWait = CS.Engine.Lib.CoWait
local KTool = CS.Engine.Lib.KTool
local InputField = CS.UnityEngine.UI.InputField
local UIModule = CS.Engine.UI.UIModule

---@class UIRealAuthenticationDialog
---@field InputIdNum                    	UnityEngine.UI.InputField               
---@field InputName                     	UnityEngine.UI.InputField               
---@field AuthenticationBtn             	UnityEngine.UI.Button                   
local UIRealAuthenticationDialog = Class("UIRealAuthenticationDialog")

function UIRealAuthenticationDialog:__init()
end

function UIRealAuthenticationDialog:__delete()
end


function UIRealAuthenticationDialog:Awake()
    printInfo("This is UIRealAuthenticationDialog.lua")
    SetButtonAction(self.AuthenticationBtn, Bind(self, self.OnAuthenticationBtnClick))
end

function UIRealAuthenticationDialog:OnAuthenticationBtnClick()

    local realName = self.InputName:GetComponent(typeof(InputField)).text
    local IdNum = self.InputIdNum:GetComponent(typeof(InputField)).text

    if realName == nil or IdNum == nil then
        return
    end

    if  realName == "" or IdNum == ""  then
        GameUtils.Toast(localize("请完整输入您的 姓名 和 身份证号码"), 1.2)
        return
    end

    local realNameNotRightful = false
    for i = 1 , #realName do
        if string.byte(realName, i) <= 127 then
            realNameNotRightful = true
        end
    end
    if realNameNotRightful then-- 验证 姓名中是否有其他字符
        GameUtils.Toast(localize("请核对您输入的姓名"), 1.2)
        return
    end

    GameUtils.Request(Interfaces.UserRealAuthenticationPass, {
        realName = realName,
        numId =  IdNum },
    function(request, response)
        if checkNumber(response.errCode) == 0 then
            ---传过去的参数临时写死 --19/11/22--jialei
            Events.Broadcast(Constants.EventNames.ChangeAuthenticationValue, 1)
            UIModule.BackDialog()
        end
        end, function(exception)
        self:ShakeError(exception.Message)
    end)
end

function UIRealAuthenticationDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
    end))
    return coWait
end

function UIRealAuthenticationDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local CoWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --C#托管堆GC
        self:Delete()
        self = nil
    end))
    return CoWait
end

return UIRealAuthenticationDialog
