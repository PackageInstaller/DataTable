---@class CustomBackPanel_Generate_resBox_addBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CustomBackPanel_Generate_resBox_resNumTxt
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class CustomBackPanel_Generate_resBox_resIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public scaleButton ScaleButton

---@class CustomBackPanel_Generate_resBox
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public resIcon CustomBackPanel_Generate_resBox_resIcon
---@field public resNumTxt CustomBackPanel_Generate_resBox_resNumTxt
---@field public addBtn CustomBackPanel_Generate_resBox_addBtn

---@class CustomBackPanel_Generate_helpBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CustomBackPanel_Generate_backMainlBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CustomBackPanel_Generate_titleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CustomBackPanel_Generate_backBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CustomBackPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public back UnityEngine.GameObject
---@field public backBtn CustomBackPanel_Generate_backBtn
---@field public titleTxt CustomBackPanel_Generate_titleTxt
---@field public backMainlBtn CustomBackPanel_Generate_backMainlBtn
---@field public helpBtn CustomBackPanel_Generate_helpBtn
---@field public resource UnityEngine.GameObject
---@field public resBox CustomBackPanel_Generate_resBox
local CustomBackPanel = class("CustomBackPanel", require("CommonBase"))

function CustomBackPanel:ctor(data)
end

---@private
function CustomBackPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("CustomBackPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function CustomBackPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function CustomBackPanel:InitGenerate__2(Root, data)
--[[
	Back
--]]
	local tmp = Root:Find("Back").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.back = tmp


end

---@private
function CustomBackPanel:InitGenerate__3(Root, data)
--[[
	Back/BackBg/BackBtn
--]]
	local tmp = Root:Find("Back/BackBg/BackBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.backBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CustomBackPanel_backBtn")
			if self.backBtn_ScaleButton_onClick then
				self:backBtn_ScaleButton_onClick(self.backBtn)
			end
		end)


end

---@private
function CustomBackPanel:InitGenerate__4(Root, data)
--[[
	Back/BackBg/TitleBg/TitleTxt
--]]
	local tmp = Root:Find("Back/BackBg/TitleBg/TitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CustomBackPanel:InitGenerate__5(Root, data)
--[[
	Back/BackMainlBtn
--]]
	local tmp = Root:Find("Back/BackMainlBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.backMainlBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CustomBackPanel_backMainlBtn")
			if self.backMainlBtn_ScaleButton_onClick then
				self:backMainlBtn_ScaleButton_onClick(self.backMainlBtn)
			end
		end)


end

---@private
function CustomBackPanel:InitGenerate__6(Root, data)
--[[
	Back/HelpBtn
--]]
	local tmp = Root:Find("Back/HelpBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.helpBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CustomBackPanel_helpBtn")
			if self.helpBtn_ScaleButton_onClick then
				self:helpBtn_ScaleButton_onClick(self.helpBtn)
			end
		end)


end

---@private
function CustomBackPanel:InitGenerate__7(Root, data)
--[[
	Resource
--]]
	local tmp = Root:Find("Resource").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resource = tmp


end

---@private
function CustomBackPanel:InitGenerate__8(Root, data)
--[[
	Resource/ResBox
--]]
	local tmp = Root:Find("Resource/ResBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resBox = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CustomBackPanel:InitGenerate__9(Root, data)
--[[
	Resource/ResBox/ResIcon
--]]
	local tmp = Root:Find("Resource/ResBox/ResIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resBox.resIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CustomBackPanel_resIcon")
			if self.resIcon_ScaleButton_onClick then
				self:resIcon_ScaleButton_onClick(self.resBox.resIcon)
			end
		end)


end

---@private
function CustomBackPanel:InitGenerate__10(Root, data)
--[[
	Resource/ResBox/ResNumTxt
--]]
	local tmp = Root:Find("Resource/ResBox/ResNumTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resBox.resNumTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function CustomBackPanel:InitGenerate__11(Root, data)
--[[
	Resource/ResBox/AddBtn
--]]
	local tmp = Root:Find("Resource/ResBox/AddBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resBox.addBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function CustomBackPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return CustomBackPanel