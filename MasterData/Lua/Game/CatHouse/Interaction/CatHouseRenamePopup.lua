---
--- Created by Eric.
--- DateTime: 2021/12/8 18:06
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local CatHouseMgr = import('Game.CatHouse.CatHouseMgr'):GetInstance()

------------ import ------------

------------ define ------------
local MAX_NAME_LENGTH = 7
------------ define ------------


---@class CatHouseRenamePopup
---@field Confirm                       	UnityEngine.RectTransform
---@field Cancel                        	UnityEngine.RectTransform
---@field InputField                    	UnityEngine.UI.InputField
local CatHouseRenamePopup = Class("CatHouseRenamePopup")
function CatHouseRenamePopup:__init()
    self.catId = nil--猫唯一id

end

function CatHouseRenamePopup:__delete()
    self.catId = nil


    self.controller = nil
end

function CatHouseRenamePopup:Awake()

end

function CatHouseRenamePopup:OnFocus(focus)
end

function CatHouseRenamePopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.catId = self.controller.Argument.parameters.catId--猫唯一id
        self:SetBtnAction()
    end))
    return coWait
end

function CatHouseRenamePopup:SetBtnAction()
    SetButtonAction(self.Confirm, function ()
        --GameUtils.SecondConfirm(
        --        localize("确认将猫名设置为_m_月_d_日吗？",{ _m_ = self.selectedMonth , _d_ = self.selectedDay }),
        --        function()
        --            if self.InputField.text == '' then
        --                GameUtils.Toast(localize("输入不能为空"))
        --                return
        --            end
        --            GameUtils.Request(
        --                    Interfaces.PlayerSetBirthday,
        --                    { birthday = birthdayData },
        --                    function(request, response)
        --                        if checkInt(response.errCode) == 0 then
        --                            ---维护数据，刷新下层界面的信息
        --                            --local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        --                            --playerComponent.playerDojo.birthday = birthdayData
        --                            --PlayerInfoUtils.ChangePlayerInfo()
        --                            UIModule.BackDialog()
        --                            GameUtils.Toast(localize("设置成功"))
        --                        end
        --                    end
        --            )
        --        end
        --)
        local length = utf8.len(self.InputField.text)
        local confirmSucceed = length <= MAX_NAME_LENGTH
        if confirmSucceed then
            GameUtils.Request(
                    Interfaces.CatHouseRename,
                    {
                        playerCatId = self.catId,
                        name = self.InputField.text
                    },
                    function(request, response)
                        if checkInt(response.errCode) == 0 then
                            ---维护数据，刷新下层界面的信息
                            local catData = CatHouseMgr:GetCatDataById()
                            catData.name = self.InputField.text
                            CatHouseMgr:SetCatDataById(catData.id, catData)
                            --Events.Broadcast(Constants.EventNames.CatHouseCatRename)
                            --PlayerInfoUtils.ChangePlayerInfo()
                            UIModule.BackDialog()
                            GameUtils.Toast(localize("设置成功"))
                        end
                    end
            )
        else
            GameUtils.Toast(localize("昵称最长7个字"))
        end
    end)

    SetButtonAction(self.Cancel, function ()
        UIModule.BackDialog()
    end)
end

function CatHouseRenamePopup:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return CatHouseRenamePopup