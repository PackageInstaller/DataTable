---@class InstructionsPanel_Generate_teachBox_teachTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class InstructionsPanel_Generate_teachBox_titleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class InstructionsPanel_Generate_teachBox
---@field public gameObject UnityEngine.GameObject
---@field public titleTxt InstructionsPanel_Generate_teachBox_titleTxt
---@field public teachTxt InstructionsPanel_Generate_teachBox_teachTxt
---@field public iconView UnityEngine.GameObject
---@field public msgView UnityEngine.GameObject

---@class InstructionsPanel_Generate_gachaMsgBox_msgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class InstructionsPanel_Generate_gachaMsgBox_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class InstructionsPanel_Generate_gachaMsgBox_roleBox_rankFarmeImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class InstructionsPanel_Generate_gachaMsgBox_roleBox_roleIconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class InstructionsPanel_Generate_gachaMsgBox_roleBox
---@field public gameObject UnityEngine.GameObject
---@field public roleIconImg InstructionsPanel_Generate_gachaMsgBox_roleBox_roleIconImg
---@field public rankFarmeImg InstructionsPanel_Generate_gachaMsgBox_roleBox_rankFarmeImg

---@class InstructionsPanel_Generate_gachaMsgBox
---@field public gameObject UnityEngine.GameObject
---@field public roleBox InstructionsPanel_Generate_gachaMsgBox_roleBox
---@field public nameTxt InstructionsPanel_Generate_gachaMsgBox_nameTxt
---@field public msgTxt InstructionsPanel_Generate_gachaMsgBox_msgTxt

---@class InstructionsPanel_Generate_iconMsgBox_iconExplainTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class InstructionsPanel_Generate_iconMsgBox_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class InstructionsPanel_Generate_iconMsgBox
---@field public gameObject UnityEngine.GameObject
---@field public iconImg InstructionsPanel_Generate_iconMsgBox_iconImg
---@field public iconExplainTxt InstructionsPanel_Generate_iconMsgBox_iconExplainTxt

---@class InstructionsPanel_Generate_toggleBox
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public isOn UnityEngine.GameObject

---@class InstructionsPanel_Generate_msgTips_msgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class InstructionsPanel_Generate_msgTips
---@field public gameObject UnityEngine.GameObject
---@field public msgTxt InstructionsPanel_Generate_msgTips_msgTxt

---@class InstructionsPanel_Generate_lastBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class InstructionsPanel_Generate_nextBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class InstructionsPanel_Generate_msgImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class InstructionsPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class InstructionsPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask InstructionsPanel_Generate_mask
---@field public msgImg InstructionsPanel_Generate_msgImg
---@field public listView UnityEngine.GameObject
---@field public teachList UnityEngine.GameObject
---@field public nextBtn InstructionsPanel_Generate_nextBtn
---@field public lastBtn InstructionsPanel_Generate_lastBtn
---@field public msgTipsList UnityEngine.GameObject
---@field public toggleList UnityEngine.GameObject
---@field public msgTips InstructionsPanel_Generate_msgTips
---@field public toggleBox InstructionsPanel_Generate_toggleBox
---@field public iconMsgBox InstructionsPanel_Generate_iconMsgBox
---@field public gachaMsgBox InstructionsPanel_Generate_gachaMsgBox
---@field public teachBox InstructionsPanel_Generate_teachBox
local InstructionsPanel = class("InstructionsPanel", require("WndBase"))

function InstructionsPanel:ctor(data)
end

---@private
function InstructionsPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("InstructionsPanel")

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
	self:InitGenerate__26(Root,data)
	self:InitGenerate__27(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function InstructionsPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function InstructionsPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("InstructionsPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function InstructionsPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/Mask/MsgImg
--]]
	local tmp = Root:Find("BoxBg/Mask/MsgImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function InstructionsPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/Mask/ListView
--]]
	local tmp = Root:Find("BoxBg/Mask/ListView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.listView = tmp


end

---@private
function InstructionsPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/Mask/ListView/Scroll View/Viewport/TeachList
--]]
	local tmp = Root:Find("BoxBg/Mask/ListView/Scroll View/Viewport/TeachList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teachList = tmp


end

---@private
function InstructionsPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/NextBtn
--]]
	local tmp = Root:Find("BoxBg/NextBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nextBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("InstructionsPanel_nextBtn")
			if self.nextBtn_ScaleButton_onClick then
				self:nextBtn_ScaleButton_onClick(self.nextBtn)
			end
		end)


end

---@private
function InstructionsPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/LastBtn
--]]
	local tmp = Root:Find("BoxBg/LastBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lastBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("InstructionsPanel_lastBtn")
			if self.lastBtn_ScaleButton_onClick then
				self:lastBtn_ScaleButton_onClick(self.lastBtn)
			end
		end)


end

---@private
function InstructionsPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/MsgTipsList
--]]
	local tmp = Root:Find("BoxBg/MsgTipsList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgTipsList = tmp


end

---@private
function InstructionsPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/toggleList
--]]
	local tmp = Root:Find("BoxBg/toggleList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleList = tmp


end

---@private
function InstructionsPanel:InitGenerate__10(Root, data)
--[[
	Custom/MsgTips
--]]
	local tmp = Root:Find("Custom/MsgTips").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgTips = tmp


end

---@private
function InstructionsPanel:InitGenerate__11(Root, data)
--[[
	Custom/MsgTips/MsgTxt
--]]
	local tmp = Root:Find("Custom/MsgTips/MsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgTips.msgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function InstructionsPanel:InitGenerate__12(Root, data)
--[[
	Custom/toggleBox
--]]
	local tmp = Root:Find("Custom/toggleBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBox = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("InstructionsPanel_toggleBox")
			if self.toggleBox_Button_onClick then
				self:toggleBox_Button_onClick(self.toggleBox)
			end
		end)


end

---@private
function InstructionsPanel:InitGenerate__13(Root, data)
--[[
	Custom/toggleBox/bg/IsOn
--]]
	local tmp = Root:Find("Custom/toggleBox/bg/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBox.isOn = tmp


end

---@private
function InstructionsPanel:InitGenerate__14(Root, data)
--[[
	Custom/IconMsgBox
--]]
	local tmp = Root:Find("Custom/IconMsgBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.iconMsgBox = tmp


end

---@private
function InstructionsPanel:InitGenerate__15(Root, data)
--[[
	Custom/IconMsgBox/IconImg
--]]
	local tmp = Root:Find("Custom/IconMsgBox/IconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.iconMsgBox.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function InstructionsPanel:InitGenerate__16(Root, data)
--[[
	Custom/IconMsgBox/IconExplainTxt
--]]
	local tmp = Root:Find("Custom/IconMsgBox/IconExplainTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.iconMsgBox.iconExplainTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function InstructionsPanel:InitGenerate__17(Root, data)
--[[
	Custom/GachaMsgBox
--]]
	local tmp = Root:Find("Custom/GachaMsgBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox = tmp


end

---@private
function InstructionsPanel:InitGenerate__18(Root, data)
--[[
	Custom/GachaMsgBox/RoleBox
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/RoleBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.roleBox = tmp


end

---@private
function InstructionsPanel:InitGenerate__19(Root, data)
--[[
	Custom/GachaMsgBox/RoleBox/Mask/RoleIconImg
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/RoleBox/Mask/RoleIconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.roleBox.roleIconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function InstructionsPanel:InitGenerate__20(Root, data)
--[[
	Custom/GachaMsgBox/RoleBox/RankFarmeImg
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/RoleBox/RankFarmeImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.roleBox.rankFarmeImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function InstructionsPanel:InitGenerate__21(Root, data)
--[[
	Custom/GachaMsgBox/NameTxt
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function InstructionsPanel:InitGenerate__22(Root, data)
--[[
	Custom/GachaMsgBox/MsgTxt
--]]
	local tmp = Root:Find("Custom/GachaMsgBox/MsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gachaMsgBox.msgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function InstructionsPanel:InitGenerate__23(Root, data)
--[[
	Custom/TeachBox
--]]
	local tmp = Root:Find("Custom/TeachBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teachBox = tmp


end

---@private
function InstructionsPanel:InitGenerate__24(Root, data)
--[[
	Custom/TeachBox/TxtTitleBg/TitleTxt
--]]
	local tmp = Root:Find("Custom/TeachBox/TxtTitleBg/TitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teachBox.titleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function InstructionsPanel:InitGenerate__25(Root, data)
--[[
	Custom/TeachBox/TeachTxt
--]]
	local tmp = Root:Find("Custom/TeachBox/TeachTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teachBox.teachTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function InstructionsPanel:InitGenerate__26(Root, data)
--[[
	Custom/TeachBox/IconView
--]]
	local tmp = Root:Find("Custom/TeachBox/IconView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teachBox.iconView = tmp


end

---@private
function InstructionsPanel:InitGenerate__27(Root, data)
--[[
	Custom/TeachBox/MsgView
--]]
	local tmp = Root:Find("Custom/TeachBox/MsgView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teachBox.msgView = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function InstructionsPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return InstructionsPanel