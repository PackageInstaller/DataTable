------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local UIModule = CS.Engine.UI.UIModule
local util = require "XLua.util"
local CoWait = CS.Engine.Lib.CoWait
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
------------ import ------------

--- from: Assets/BundleResources/Prefabs/UIBattling/UIBattlingAttributeCircleDialog.prefab
---@class UIBattlingAttributeCircleDialog
---@field Env                           	UIBattlingAttributeCircleDialog         
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Txt_D2                        	UnityEngine.UI.Text                     
---@field Txt_D1                        	UnityEngine.UI.Text                     
---@field Txt_L2                        	UnityEngine.UI.Text                     
---@field Txt_L1                        	UnityEngine.UI.Text                     
---@field Txt_RGB2                      	UnityEngine.UI.Text                     
---@field Txt_RGB1                      	UnityEngine.UI.Text                     
---@field ButtonClose                   	UnityEngine.UI.Button                   
---@field CapturedImg                   	UGUI.Effects.UIEffectCapturedImage      
---@field Btn_ClosePanel                	UnityEngine.RectTransform               
local UIBattlingAttributeCircleDialog = Class("UIBattlingAttributeCircleDialog")

function UIBattlingAttributeCircleDialog:__init()
end

function UIBattlingAttributeCircleDialog:__delete()
    self.controller = nil
    self = nil
end

function UIBattlingAttributeCircleDialog:Awake()
    UIEventProxy.Create(self.Btn_ClosePanel.gameObject).onPointerClick = function()
        UIModule.BackDialog()
    end
    SetButtonAction(self.ButtonClose, function()
        UIModule.BackDialog()
    end)
end

function UIBattlingAttributeCircleDialog:OnInitialize()
end

function UIBattlingAttributeCircleDialog:OnShow()
    xTry(function()
        self:SetDialogDescription()
        self:SetCapturedShowState()
    end)
end

function UIBattlingAttributeCircleDialog:OnFinalize()
    xTry(function()
        UIBattlingCtrlMgr:GetInstance():SetBooleanOpenDetection(true)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end)
end

function UIBattlingAttributeCircleDialog:SetDialogDescription()
    local desc_1_1, desc_1_2, desc_4_1, desc_4_2, desc_5_1 = CardConfMgr:GetInstance():GetCardAttrTipsDesc()
    
    self.Txt_RGB1.text = desc_1_1
    self.Txt_RGB2.text = desc_1_2
    
    self.Txt_L1.text = desc_4_1
    self.Txt_L2.text = desc_4_2
    
    -- self.Txt_D1.text = desc_5_1
    self.Txt_D2.text = desc_5_1
end

---SetCapturedShowState
---设置背景虚化开启状态
function UIBattlingAttributeCircleDialog:SetCapturedShowState()
    local argument
    local isCloseCapture
    if not IsNull(self.controller.Argument)
            and not IsNull(self.controller.Argument.parameters) then
        argument = self.controller.Argument.parameters
        isCloseCapture = argument.isCloseCapture
    end
    if IsNull(isCloseCapture) or not isCloseCapture then
        if self.CapturedImg then
            self.CapturedImg.enabled = true
        end
    end
end

return UIBattlingAttributeCircleDialog
