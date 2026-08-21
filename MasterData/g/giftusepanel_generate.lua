---@class GiftUsePanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public normal UnityEngine.GameObject
---@field public gray UnityEngine.GameObject

---@class GiftUsePanel_Generate_setNumView_numSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class GiftUsePanel_Generate_setNumView_maxText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftUsePanel_Generate_setNumView_minText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftUsePanel_Generate_setNumView_maxBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GiftUsePanel_Generate_setNumView_plusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GiftUsePanel_Generate_setNumView_minusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GiftUsePanel_Generate_setNumView_curNumText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftUsePanel_Generate_setNumView_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftUsePanel_Generate_setNumView
---@field public gameObject UnityEngine.GameObject
---@field public titleText GiftUsePanel_Generate_setNumView_titleText
---@field public curNumText GiftUsePanel_Generate_setNumView_curNumText
---@field public minusBtn GiftUsePanel_Generate_setNumView_minusBtn
---@field public plusBtn GiftUsePanel_Generate_setNumView_plusBtn
---@field public maxBtn GiftUsePanel_Generate_setNumView_maxBtn
---@field public minText GiftUsePanel_Generate_setNumView_minText
---@field public maxText GiftUsePanel_Generate_setNumView_maxText
---@field public numSlider GiftUsePanel_Generate_setNumView_numSlider

---@class GiftUsePanel_Generate_getItem_limitCountText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftUsePanel_Generate_getItem_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class GiftUsePanel_Generate_getItem_qualityImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class GiftUsePanel_Generate_getItem_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftUsePanel_Generate_getItem
---@field public gameObject UnityEngine.GameObject
---@field public nameText GiftUsePanel_Generate_getItem_nameText
---@field public qualityImg GiftUsePanel_Generate_getItem_qualityImg
---@field public iconImg GiftUsePanel_Generate_getItem_iconImg
---@field public limitCountText GiftUsePanel_Generate_getItem_limitCountText

---@class GiftUsePanel_Generate_giftItem_limitCountText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftUsePanel_Generate_giftItem_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class GiftUsePanel_Generate_giftItem_qualityImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class GiftUsePanel_Generate_giftItem_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class GiftUsePanel_Generate_giftItem
---@field public gameObject UnityEngine.GameObject
---@field public nameText GiftUsePanel_Generate_giftItem_nameText
---@field public qualityImg GiftUsePanel_Generate_giftItem_qualityImg
---@field public iconImg GiftUsePanel_Generate_giftItem_iconImg
---@field public limitCountText GiftUsePanel_Generate_giftItem_limitCountText

---@class GiftUsePanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class GiftUsePanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class GiftUsePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask GiftUsePanel_Generate_mask
---@field public closeBtn GiftUsePanel_Generate_closeBtn
---@field public giftItem GiftUsePanel_Generate_giftItem
---@field public getItem GiftUsePanel_Generate_getItem
---@field public setNumView GiftUsePanel_Generate_setNumView
---@field public okBtn GiftUsePanel_Generate_okBtn
local GiftUsePanel = class("GiftUsePanel", require("WndBase"))

function GiftUsePanel:ctor(data)
end

---@private
function GiftUsePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("GiftUsePanel")

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
	self:InitGenerate__21(Root,data)
	self:InitGenerate__22(Root,data)
	self:InitGenerate__23(Root,data)
	self:InitGenerate__24(Root,data)
	self:InitGenerate__25(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function GiftUsePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function GiftUsePanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("GiftUsePanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function GiftUsePanel:InitGenerate__3(Root, data)
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
		UIMgr:SendUiUseMessage("GiftUsePanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function GiftUsePanel:InitGenerate__4(Root, data)
--[[
	BoxBg/GiftItem
--]]
	local tmp = Root:Find("BoxBg/GiftItem").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftItem = tmp


end

---@private
function GiftUsePanel:InitGenerate__5(Root, data)
--[[
	BoxBg/GiftItem/NameText
--]]
	local tmp = Root:Find("BoxBg/GiftItem/NameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftItem.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GiftUsePanel:InitGenerate__6(Root, data)
--[[
	BoxBg/GiftItem/QualityImg
--]]
	local tmp = Root:Find("BoxBg/GiftItem/QualityImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftItem.qualityImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function GiftUsePanel:InitGenerate__7(Root, data)
--[[
	BoxBg/GiftItem/IconImg
--]]
	local tmp = Root:Find("BoxBg/GiftItem/IconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftItem.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function GiftUsePanel:InitGenerate__8(Root, data)
--[[
	BoxBg/GiftItem/limitCountText
--]]
	local tmp = Root:Find("BoxBg/GiftItem/limitCountText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.giftItem.limitCountText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GiftUsePanel:InitGenerate__9(Root, data)
--[[
	BoxBg/GetItem
--]]
	local tmp = Root:Find("BoxBg/GetItem").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.getItem = tmp


end

---@private
function GiftUsePanel:InitGenerate__10(Root, data)
--[[
	BoxBg/GetItem/NameText
--]]
	local tmp = Root:Find("BoxBg/GetItem/NameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.getItem.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GiftUsePanel:InitGenerate__11(Root, data)
--[[
	BoxBg/GetItem/QualityImg
--]]
	local tmp = Root:Find("BoxBg/GetItem/QualityImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.getItem.qualityImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function GiftUsePanel:InitGenerate__12(Root, data)
--[[
	BoxBg/GetItem/IconImg
--]]
	local tmp = Root:Find("BoxBg/GetItem/IconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.getItem.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function GiftUsePanel:InitGenerate__13(Root, data)
--[[
	BoxBg/GetItem/limitCountText
--]]
	local tmp = Root:Find("BoxBg/GetItem/limitCountText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.getItem.limitCountText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function GiftUsePanel:InitGenerate__14(Root, data)
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
function GiftUsePanel:InitGenerate__15(Root, data)
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
function GiftUsePanel:InitGenerate__16(Root, data)
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
function GiftUsePanel:InitGenerate__17(Root, data)
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
		UIMgr:SendUiUseMessage("GiftUsePanel_minusBtn")
			if self.minusBtn_ScaleButton_onClick then
				self:minusBtn_ScaleButton_onClick(self.setNumView.minusBtn)
			end
		end)


end

---@private
function GiftUsePanel:InitGenerate__18(Root, data)
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
		UIMgr:SendUiUseMessage("GiftUsePanel_plusBtn")
			if self.plusBtn_ScaleButton_onClick then
				self:plusBtn_ScaleButton_onClick(self.setNumView.plusBtn)
			end
		end)


end

---@private
function GiftUsePanel:InitGenerate__19(Root, data)
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
		UIMgr:SendUiUseMessage("GiftUsePanel_maxBtn")
			if self.maxBtn_ScaleButton_onClick then
				self:maxBtn_ScaleButton_onClick(self.setNumView.maxBtn)
			end
		end)


end

---@private
function GiftUsePanel:InitGenerate__20(Root, data)
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
function GiftUsePanel:InitGenerate__21(Root, data)
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
function GiftUsePanel:InitGenerate__22(Root, data)
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
function GiftUsePanel:InitGenerate__23(Root, data)
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
		UIMgr:SendUiUseMessage("GiftUsePanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function GiftUsePanel:InitGenerate__24(Root, data)
--[[
	BoxBg/OkBtn/Normal
--]]
	local tmp = Root:Find("BoxBg/OkBtn/Normal").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn.normal = tmp


end

---@private
function GiftUsePanel:InitGenerate__25(Root, data)
--[[
	BoxBg/OkBtn/Gray
--]]
	local tmp = Root:Find("BoxBg/OkBtn/Gray").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn.gray = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function GiftUsePanel:SetLocalizedText(Root)

    local locObj_GiftUsePanel_TitleText2 = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText2")
    if locObj_GiftUsePanel_TitleText2 then
        locObj_GiftUsePanel_TitleText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GiftUsePanel_TitleText2
    end

    local locObj_GiftUsePanel_TitleText = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText")
    if locObj_GiftUsePanel_TitleText then
        locObj_GiftUsePanel_TitleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GiftUsePanel_TitleText
    end

    local locObj_GiftUsePanel_txt = Root:Find("BoxBg/OkBtn/Normal/txt")
    if locObj_GiftUsePanel_txt then
        locObj_GiftUsePanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GiftUsePanel_txt
    end

    local locObj_GiftUsePanel_Gy_txt = Root:Find("BoxBg/OkBtn/Gray/txt")
    if locObj_GiftUsePanel_Gy_txt then
        locObj_GiftUsePanel_Gy_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.GiftUsePanel_Gy_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return GiftUsePanel