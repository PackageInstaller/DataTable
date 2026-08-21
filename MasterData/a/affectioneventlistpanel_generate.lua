---@class AffectionEventListPanel_Generate_eventBox_roleImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class AffectionEventListPanel_Generate_eventBox_eventMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AffectionEventListPanel_Generate_eventBox_eventNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AffectionEventListPanel_Generate_eventBox_indexTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AffectionEventListPanel_Generate_eventBox_btn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class AffectionEventListPanel_Generate_eventBox
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public btn AffectionEventListPanel_Generate_eventBox_btn
---@field public indexTxt AffectionEventListPanel_Generate_eventBox_indexTxt
---@field public isOn UnityEngine.GameObject
---@field public eventNameTxt AffectionEventListPanel_Generate_eventBox_eventNameTxt
---@field public eventMsgTxt AffectionEventListPanel_Generate_eventBox_eventMsgTxt
---@field public roleImg AffectionEventListPanel_Generate_eventBox_roleImg
---@field public isOpen UnityEngine.GameObject
---@field public isComplete UnityEngine.GameObject
---@field public isNull UnityEngine.GameObject

---@class AffectionEventListPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class AffectionEventListPanel_Generate_eventView
---@field public gameObject UnityEngine.GameObject
---@field public scrollRect UnityEngine.UI.ScrollRect

---@class AffectionEventListPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class AffectionEventListPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask AffectionEventListPanel_Generate_mask
---@field public eventView AffectionEventListPanel_Generate_eventView
---@field public eventList UnityEngine.GameObject
---@field public customBox AffectionEventListPanel_Generate_customBox
---@field public eventBox AffectionEventListPanel_Generate_eventBox
local AffectionEventListPanel = class("AffectionEventListPanel", require("WndBase"))

function AffectionEventListPanel:ctor(data)
end

---@private
function AffectionEventListPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("AffectionEventListPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function AffectionEventListPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function AffectionEventListPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("AffectionEventListPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function AffectionEventListPanel:InitGenerate__3(Root, data)
--[[
	bg/EventView
--]]
	local tmp = Root:Find("bg/EventView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventView = tmp

	tmp.scrollRect = tmp:GetComponent(TypeInfo.ScrollRect)


end

---@private
function AffectionEventListPanel:InitGenerate__4(Root, data)
--[[
	bg/EventView/Viewport/EventList
--]]
	local tmp = Root:Find("bg/EventView/Viewport/EventList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventList = tmp


end

---@private
function AffectionEventListPanel:InitGenerate__5(Root, data)
--[[
	CustomBox
--]]
	local tmp = Root:Find("CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function AffectionEventListPanel:InitGenerate__6(Root, data)
--[[
	EventBox
--]]
	local tmp = Root:Find("EventBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBox = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventListPanel:InitGenerate__7(Root, data)
--[[
	EventBox/Btn
--]]
	local tmp = Root:Find("EventBox/Btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBox.btn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function AffectionEventListPanel:InitGenerate__8(Root, data)
--[[
	EventBox/Btn/IndexBg/IndexTxt
--]]
	local tmp = Root:Find("EventBox/Btn/IndexBg/IndexTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBox.indexTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AffectionEventListPanel:InitGenerate__9(Root, data)
--[[
	EventBox/Btn/IsOn
--]]
	local tmp = Root:Find("EventBox/Btn/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBox.isOn = tmp


end

---@private
function AffectionEventListPanel:InitGenerate__10(Root, data)
--[[
	EventBox/Btn/IsOn/EventNameTxt
--]]
	local tmp = Root:Find("EventBox/Btn/IsOn/EventNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBox.eventNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AffectionEventListPanel:InitGenerate__11(Root, data)
--[[
	EventBox/Btn/IsOn/EventMsgTxt
--]]
	local tmp = Root:Find("EventBox/Btn/IsOn/EventMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBox.eventMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AffectionEventListPanel:InitGenerate__12(Root, data)
--[[
	EventBox/Btn/IsOn/Mask/RoleImg
--]]
	local tmp = Root:Find("EventBox/Btn/IsOn/Mask/RoleImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBox.roleImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function AffectionEventListPanel:InitGenerate__13(Root, data)
--[[
	EventBox/Btn/IsOn/isOpen
--]]
	local tmp = Root:Find("EventBox/Btn/IsOn/isOpen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBox.isOpen = tmp


end

---@private
function AffectionEventListPanel:InitGenerate__14(Root, data)
--[[
	EventBox/Btn/IsOn/isComplete
--]]
	local tmp = Root:Find("EventBox/Btn/IsOn/isComplete").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBox.isComplete = tmp


end

---@private
function AffectionEventListPanel:InitGenerate__15(Root, data)
--[[
	EventBox/Btn/IsNull
--]]
	local tmp = Root:Find("EventBox/Btn/IsNull").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBox.isNull = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function AffectionEventListPanel:SetLocalizedText(Root)

    local locObj_AffectionEventListPanel_isNullTxt = Root:Find("EventBox/Btn/IsNull/isNullTxt")
    if locObj_AffectionEventListPanel_isNullTxt then
        locObj_AffectionEventListPanel_isNullTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AffectionEventListPanel_isNullTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return AffectionEventListPanel