--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/MenuDialog.prefab > name: MenuDialog
---@class DmmMenuItemDialog
---@field Env                           	DmmMenuItemDialog                       
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               	@ 0    
---@field DmmStoreBtn                   	UnityEngine.RectTransform               	@ 1    
---@field PurchaseBtn                   	UnityEngine.RectTransform               	@ 2    
---@field AgreementBtn                  	UnityEngine.RectTransform               	@ 3    
---@field ConnectBtn                    	UnityEngine.RectTransform               	@ 4    
local DmmMenuItemDialog = Class('DmmMenuItemDialog')
function DmmMenuItemDialog:__init()
end


function DmmMenuItemDialog:__delete()

end


function DmmMenuItemDialog:Awake()
end


function DmmMenuItemDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        ---@type SDKService
        local SDKService = import('Game.Entry.SDKService'):GetInstance()
        SetButtonAction(self.DmmStoreBtn , function ()
            SDKService:DmmMenuItem("DMM_GAMES_STORE")
        end)
        
        SetButtonAction(self.PurchaseBtn , function ()
            SDKService:DmmMenuItem("POINT_CHARGE")
        end)

        SetButtonAction(self.AgreementBtn , function ()
            SDKService:DmmMenuItem("TERM")
        end)

        SetButtonAction(self.ConnectBtn , function ()
            SDKService:DmmMenuItem("INQUIRY")
        end)

        SetButtonAction(self.BtnClose , function ()
            CS.Engine.UI.UIModule.CloseDialog(self.controller)
        end)
    end)
end


function DmmMenuItemDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return DmmMenuItemDialog
