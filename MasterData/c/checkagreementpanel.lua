---@class CheckAgreementPanel : CheckAgreementPanel__Generate
---##################### 【CheckAgreementPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【CheckAgreementPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local CheckAgreementPanel = require "CheckAgreementPanel_Generate"

function CheckAgreementPanel:InitLogic(data)

end

--function CheckAgreementPanel:StartCreating(time)
--
--end

--function CheckAgreementPanel:StartEnter(time)
--
--end

--function CheckAgreementPanel:StartRemoving(time)
--
--end

--function CheckAgreementPanel:StartExit(time)
--
--end

function CheckAgreementPanel:OnOpen(data, initiative)
    self.scrollbar.scrollbar.size = 0
    self.label.textLink:SetCallback(self.label.text, function(linkID, linkData)
        LuaLogger.ds("linkID", linkID)
        LuaLogger.ds("linkData", linkData)
        if linkID == "UserAgreement" then
            Application.OpenURL("http://www.moefantasy.com/")
        elseif linkID == "PrivacyPolicy" then
            Application.OpenURL("http://www.moefantasy.com/")
        end
    end)
end

function CheckAgreementPanel:Cheak()
    LuaLogger.ds(self.cheakToggle.isOn)
    if not self.cheakToggle.toggle.isOn then
        UICommonUtils.PopToast("请先阅读并同意《用户协议》和《隐私条款》")
        return
    end
    --TODO: 保存逻辑待确认
    PlayerPrefs.SetInt("CheakAgreement", 1)
    UIMgr:closeUI(self)
end

--function CheckAgreementPanel:OnClose(initiative)
--
--end

--function CheckAgreementPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function CheckAgreementPanel:OnRefresh(data)
--
--end

--[[
/MaskBg onClick 
--]]
function CheckAgreementPanel:maskBg_Button_onClick(maskBg)
    self.animator.enabled = true
    self.animator:SetTrigger("out")
    self.maskBg.button.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.maskBg.button.interactable = true
        UIMgr:closeUI(self)
    end)
end

--[[
/CheakToggle onValueChanged 
--]]
function CheckAgreementPanel:cheakToggle_Toggle_onValueChanged(cheakToggle,isOn)

end

--[[
/PanelBg/OkBtn onClick 
--]]
function CheckAgreementPanel:okBtn_ScaleButton_onClick(okBtn)
    self:Cheak()
end

--[[
/PanelBg/RefuseBtn onClick 
--]]
function CheckAgreementPanel:refuseBtn_ScaleButton_onClick(refuseBtn)
    --TODO: 拒绝直接关闭游戏
    Application.Quit()
    --UIMgr:closeUI(self)
end

--[[
/PanelBg/Scroll View/Scrollbar onValueChanged 
--]]
function CheckAgreementPanel:scrollbar_Scrollbar_onValueChanged(scrollbar,value)

end

--[[
/PanelBg/EnterBtn onClick 
--]]
function CheckAgreementPanel:enterBtn_ScaleButton_onClick(enterBtn)
    self.animator.enabled = true
    self.animator:SetTrigger("out")
    self.enterBtn.scaleButton.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.enterBtn.scaleButton.interactable = true
        UIMgr:closeUI(self)
    end)
end

return CheckAgreementPanel
