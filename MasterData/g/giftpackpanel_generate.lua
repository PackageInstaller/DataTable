---@class GiftPackPanel_Generate_noBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GiftPackPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GiftPackPanel_Generate_setNumView_numSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class GiftPackPanel_Generate_setNumView_maxText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftPackPanel_Generate_setNumView_minText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftPackPanel_Generate_setNumView_maxBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GiftPackPanel_Generate_setNumView_plusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GiftPackPanel_Generate_setNumView_minusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GiftPackPanel_Generate_setNumView_curNumText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftPackPanel_Generate_setNumView_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftPackPanel_Generate_setNumView
---@field public gameObject UnityEngine.GameObject
---@field public titleText GiftPackPanel_Generate_setNumView_titleText
---@field public curNumText GiftPackPanel_Generate_setNumView_curNumText
---@field public minusBtn GiftPackPanel_Generate_setNumView_minusBtn
---@field public plusBtn GiftPackPanel_Generate_setNumView_plusBtn
---@field public maxBtn GiftPackPanel_Generate_setNumView_maxBtn
---@field public minText GiftPackPanel_Generate_setNumView_minText
---@field public maxText GiftPackPanel_Generate_setNumView_maxText
---@field public numSlider GiftPackPanel_Generate_setNumView_numSlider

---@class GiftPackPanel_Generate_giftBox_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class GiftPackPanel_Generate_giftBox_haveNumTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftPackPanel_Generate_giftBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public clickLongPressListener ClickLongPressListener
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public isSelectGift UnityEngine.GameObject
---@field public haveNumTxt GiftPackPanel_Generate_giftBox_haveNumTxt
---@field public customBox GiftPackPanel_Generate_giftBox_customBox

---@class GiftPackPanel_Generate_haveNumTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftPackPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GiftPackPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class GiftPackPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask GiftPackPanel_Generate_mask
---@field public closeBtn GiftPackPanel_Generate_closeBtn
---@field public haveNumTxt GiftPackPanel_Generate_haveNumTxt
---@field public content UnityEngine.GameObject
---@field public giftBox GiftPackPanel_Generate_giftBox
---@field public setNumView GiftPackPanel_Generate_setNumView
---@field public okBtn GiftPackPanel_Generate_okBtn
---@field public noBtn GiftPackPanel_Generate_noBtn
local GiftPackPanel = class("GiftPackPanel", require("WndBase"))

function GiftPackPanel:ctor(data)
end

---@private
function GiftPackPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("GiftPackPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)
	self:InitGenerate__7(Root,data)
	self:InitGenerate__8(Root,data)
	self:InitGenerate__9(Root,data)
	self:InitGenerate__10(Root,data)
	self:InitGenerate__11(Root,data)
	self:InitGenerate__12(Root,data)
	self:InitGenerate__13(Root,data)
	self:InitGenerate__14(Root,data)
	self:InitGenerate__15(Root,data)
	self:InitGenerate__16(Root,data)
	self:InitGenerate__17(Root,data)
	self:InitGenerate__18(Root,data)
	self:InitGenerate__19(Root,data)
	self:InitGenerate__20(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function GiftPackPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function GiftPackPanel:InitGenerate__2(Root, data)
--[[
	Mask
--]]
	local tmp = Root:Find("Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GiftPackPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function GiftPackPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/TitleSideBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GiftPackPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function GiftPackPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/MsgList/HaveNumBg/HaveNumTxt
--]]
	local tmp = Root:Find("BoxBg/MsgList/HaveNumBg/HaveNumTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.haveNumTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GiftPackPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/ScrollView/Viewport/Content
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp


end

---@private
function GiftPackPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/ScrollView/Viewport/Content/GiftBox
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/Content/GiftBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.clickLongPressListener = tmp:GetComponent(TypeInfo.ClickLongPressListener)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function GiftPackPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/ScrollView/Viewport/Content/GiftBox/IsSelectGift
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/Content/GiftBox/IsSelectGift").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftBox.isSelectGift = tmp


end

---@private
function GiftPackPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/ScrollView/Viewport/Content/GiftBox/HaveNumTxt
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/Content/GiftBox/HaveNumTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftBox.haveNumTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GiftPackPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/ScrollView/Viewport/Content/GiftBox/CustomBox
--]]
	local tmp = Root:Find("BoxBg/ScrollView/Viewport/Content/GiftBox/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftBox.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function GiftPackPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/SetNumView
--]]
	local tmp = Root:Find("BoxBg/SetNumView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView = tmp


end

---@private
function GiftPackPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/SetNumView/titleText
--]]
	local tmp = Root:Find("BoxBg/SetNumView/titleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GiftPackPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/SetNumView/curNumInfo/curNumText
--]]
	local tmp = Root:Find("BoxBg/SetNumView/curNumInfo/curNumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.curNumText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GiftPackPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/SetNumView/minusBtn
--]]
	local tmp = Root:Find("BoxBg/SetNumView/minusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.minusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GiftPackPanel_minusBtn")
			if self.minusBtn_ScaleButton_onClick then
				self:minusBtn_ScaleButton_onClick(self.setNumView.minusBtn)
			end
		end)


end

---@private
function GiftPackPanel:InitGenerate__14(Root, data)
--[[
	BoxBg/SetNumView/plusBtn
--]]
	local tmp = Root:Find("BoxBg/SetNumView/plusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.plusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GiftPackPanel_plusBtn")
			if self.plusBtn_ScaleButton_onClick then
				self:plusBtn_ScaleButton_onClick(self.setNumView.plusBtn)
			end
		end)


end

---@private
function GiftPackPanel:InitGenerate__15(Root, data)
--[[
	BoxBg/SetNumView/maxBtn
--]]
	local tmp = Root:Find("BoxBg/SetNumView/maxBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.maxBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GiftPackPanel_maxBtn")
			if self.maxBtn_ScaleButton_onClick then
				self:maxBtn_ScaleButton_onClick(self.setNumView.maxBtn)
			end
		end)


end

---@private
function GiftPackPanel:InitGenerate__16(Root, data)
--[[
	BoxBg/SetNumView/minText
--]]
	local tmp = Root:Find("BoxBg/SetNumView/minText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.minText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GiftPackPanel:InitGenerate__17(Root, data)
--[[
	BoxBg/SetNumView/maxText
--]]
	local tmp = Root:Find("BoxBg/SetNumView/maxText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.maxText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GiftPackPanel:InitGenerate__18(Root, data)
--[[
	BoxBg/SetNumView/numSlider
--]]
	local tmp = Root:Find("BoxBg/SetNumView/numSlider").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.numSlider = tmp

	tmp.slider = tmp:GetComponent(TypeInfo.Slider)
	tmp.slider.onValueChanged:RemoveAllListeners()
	tmp.slider.onValueChanged:AddListener(function (value)
			if self.numSlider_Slider_onValueChanged then
				self:numSlider_Slider_onValueChanged(self.setNumView.numSlider,value)
			end
		end)


end

---@private
function GiftPackPanel:InitGenerate__19(Root, data)
--[[
	BoxBg/OkBtn
--]]
	local tmp = Root:Find("BoxBg/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GiftPackPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function GiftPackPanel:InitGenerate__20(Root, data)
--[[
	BoxBg/NoBtn
--]]
	local tmp = Root:Find("BoxBg/NoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("GiftPackPanel_noBtn")
			if self.noBtn_ScaleButton_onClick then
				self:noBtn_ScaleButton_onClick(self.noBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function GiftPackPanel:SetLocalizedText(Root)

    local locObj_GiftPackPanel_TitleText2 = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText2")
    if locObj_GiftPackPanel_TitleText2 then
        locObj_GiftPackPanel_TitleText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GiftPackPanel_TitleText2
    end

    local locObj_GiftPackPanel_TitleText = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText")
    if locObj_GiftPackPanel_TitleText then
        locObj_GiftPackPanel_TitleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GiftPackPanel_TitleText
    end

    local locObj_GiftPackPanel_GiftTips1 = Root:Find("BoxBg/MsgList/GiftTips1")
    if locObj_GiftPackPanel_GiftTips1 then
        locObj_GiftPackPanel_GiftTips1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GiftPackPanel_GiftTips1
    end

    local locObj_GiftPackPanel_txt = Root:Find("BoxBg/OkBtn/txt")
    if locObj_GiftPackPanel_txt then
        locObj_GiftPackPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GiftPackPanel_txt
    end

    local locObj_GiftPackPanel_Nn_txt = Root:Find("BoxBg/NoBtn/txt")
    if locObj_GiftPackPanel_Nn_txt then
        locObj_GiftPackPanel_Nn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GiftPackPanel_Nn_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return GiftPackPanel