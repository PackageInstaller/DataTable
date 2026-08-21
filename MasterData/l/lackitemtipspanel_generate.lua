---@class LackItemTipsPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class LackItemTipsPanel_Generate_text
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LackItemTipsPanel_Generate_lackNumText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LackItemTipsPanel_Generate_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LackItemTipsPanel_Generate_textMask
---@field public gameObject UnityEngine.GameObject
---@field public marqueeText MarqueeText

---@class LackItemTipsPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public boxBg UnityEngine.GameObject
---@field public textMask LackItemTipsPanel_Generate_textMask
---@field public nameText LackItemTipsPanel_Generate_nameText
---@field public lackNumText LackItemTipsPanel_Generate_lackNumText
---@field public text LackItemTipsPanel_Generate_text
---@field public fullText UnityEngine.GameObject
---@field public customBox LackItemTipsPanel_Generate_customBox
local LackItemTipsPanel = class("LackItemTipsPanel", require("WndBase"))

function LackItemTipsPanel:ctor(data)
end

---@private
function LackItemTipsPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("LackItemTipsPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function LackItemTipsPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function LackItemTipsPanel:InitGenerate__2(Root, data)
--[[
	BoxBg
--]]
	local tmp = Root:Find("BoxBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.boxBg = tmp


end

---@private
function LackItemTipsPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/TextMask
--]]
	local tmp = Root:Find("BoxBg/TextMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.textMask = tmp

	tmp.marqueeText = tmp:GetComponent(TypeInfo.MarqueeText)


end

---@private
function LackItemTipsPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/TextMask/NameText
--]]
	local tmp = Root:Find("BoxBg/TextMask/NameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LackItemTipsPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/LackNumText
--]]
	local tmp = Root:Find("BoxBg/LackNumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lackNumText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LackItemTipsPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/LackNumText/Text
--]]
	local tmp = Root:Find("BoxBg/LackNumText/Text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.text = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LackItemTipsPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/FullText
--]]
	local tmp = Root:Find("BoxBg/FullText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.fullText = tmp


end

---@private
function LackItemTipsPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/CustomBox
--]]
	local tmp = Root:Find("BoxBg/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function LackItemTipsPanel:SetLocalizedText(Root)

    local locObj_LackItemTipsPanel_FullText = Root:Find("BoxBg/FullText")
    if locObj_LackItemTipsPanel_FullText then
        locObj_LackItemTipsPanel_FullText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LackItemTipsPanel_FullText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return LackItemTipsPanel