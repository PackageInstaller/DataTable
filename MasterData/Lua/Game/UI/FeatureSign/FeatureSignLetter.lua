---
--- Created by Eric.
--- DateTime: 2022/7/5 18:19
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
---@type SDKService
local SDKService = import('Game.Entry.SDKService')
local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)

------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/DailyCheck/ThankLetter.prefab
---@class FeatureSignLetter
---@field Env                           	FeatureSignLetter
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field FontStyleButton3              	UnityEngine.RectTransform
---@field Back                          	UnityEngine.RectTransform
---@field FontStyleButton2              	UnityEngine.RectTransform
---@field FontStyleButton1              	UnityEngine.RectTransform
---@field Choose                        	UnityEngine.RectTransform
---@field TxtContent                    	UnityEngine.UI.Text
---@field TxtTitle                      	UnityEngine.UI.Text
---@field TxtName                       	TMPro.TextMeshProUGUI
---@field ImgRole                       	Engine.UI.RawImageAlterable
local FeatureSignLetter = Class("FeatureSignLetter")
function FeatureSignLetter:__init()
    self.data = {}
    self.cb = nil


end

function FeatureSignLetter:__delete()
    self.data = nil
    self.cb = nil


    self.controller = nil
end

function FeatureSignLetter:Awake()
    local parameters  = self.controller.Argument.parameters
    if parameters then
        local giftData = parameters.giftData
        self.cb = parameters.cb
        self.data = CfUtils.GetCfVo(AutoIds.IdSetting961, "LetterVo", giftData.letter)
        self:FreshBaseUI()
    end

end

function FeatureSignLetter:FreshBaseUI()
    --print("------>>"..table.dump(self.data, nil, 3))
    self.ImgRole:LoadSprite(self.data.picture)
    local roleVo = CfUtils.GetCfVo(AutoIds.IdSetting19, "RolesVo", self.data.characterId)
    self.TxtName.text = roleVo.englishName
    self.TxtTitle.text = self.data.title
    local desc = string.fmt(self.data.desc, { _name_ = playerComponent.playerDojo.playerName })
    self.TxtContent.text = desc
    SetButtonAction(self.FontStyleButton1, function () --好评
        local SDKCenter = CS.Game.Native.MobileSDK.SDKCenter
        local ProxyPluginName = "PlatformProxy"
        local kTool = CS.Engine.Lib.KTool
        SDKService:GetInstance():ScoreForApp()
        GameUtils.Toast(localize("感谢调查官的肯定，我们会继续努力的"))
        KTool.SetActive(self.Choose, false)
        KTool.SetActive(self.Back, true)
    end)
    SetButtonAction(self.FontStyleButton2, function () --吐槽
        UIModule.OpenDialog({ id = Constants.UITypeIds.FeatureSignRoast, parameters = { confirmCB = function ()
            GameUtils.Toast(localize("已收到您的意见，感谢您的支持"))
            KTool.SetActive(self.Choose, false)
            KTool.SetActive(self.Back, true)
        end }},
                {
                    --{ id = Constants.UITypeIds.UIHomeView },
                })

    end)
    SetButtonAction(self.FontStyleButton3, function () --返回
        if self.cb then
            self.cb()
        end
        UIModule.BackDialog()
    end)
end


function FeatureSignLetter:OnFocus(focus)
end

function FeatureSignLetter:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function FeatureSignLetter:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return FeatureSignLetter