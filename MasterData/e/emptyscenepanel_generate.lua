---@class EmptyScenePanel_Generate_button5
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EmptyScenePanel_Generate_button4
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EmptyScenePanel_Generate_button3
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EmptyScenePanel_Generate_button2
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EmptyScenePanel_Generate_button1
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EmptyScenePanel_Generate_returnButton
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EmptyScenePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public returnButton EmptyScenePanel_Generate_returnButton
---@field public button1 EmptyScenePanel_Generate_button1
---@field public button2 EmptyScenePanel_Generate_button2
---@field public button3 EmptyScenePanel_Generate_button3
---@field public button4 EmptyScenePanel_Generate_button4
---@field public button5 EmptyScenePanel_Generate_button5
local EmptyScenePanel = class("EmptyScenePanel", require("WndBase"))

function EmptyScenePanel:ctor(data)
end

---@private
function EmptyScenePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("EmptyScenePanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)
	self:InitGenerate__7(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function EmptyScenePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function EmptyScenePanel:InitGenerate__2(Root, data)
--[[
	ReturnButton
--]]
	local tmp = Root:Find("ReturnButton").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.returnButton = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EmptyScenePanel_returnButton")
			if self.returnButton_Button_onClick then
				self:returnButton_Button_onClick(self.returnButton)
			end
		end)


end

---@private
function EmptyScenePanel:InitGenerate__3(Root, data)
--[[
	Button1
--]]
	local tmp = Root:Find("Button1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.button1 = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EmptyScenePanel_button1")
			if self.button1_Button_onClick then
				self:button1_Button_onClick(self.button1)
			end
		end)


end

---@private
function EmptyScenePanel:InitGenerate__4(Root, data)
--[[
	Button2
--]]
	local tmp = Root:Find("Button2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.button2 = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EmptyScenePanel_button2")
			if self.button2_Button_onClick then
				self:button2_Button_onClick(self.button2)
			end
		end)


end

---@private
function EmptyScenePanel:InitGenerate__5(Root, data)
--[[
	Button3
--]]
	local tmp = Root:Find("Button3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.button3 = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EmptyScenePanel_button3")
			if self.button3_Button_onClick then
				self:button3_Button_onClick(self.button3)
			end
		end)


end

---@private
function EmptyScenePanel:InitGenerate__6(Root, data)
--[[
	Button4
--]]
	local tmp = Root:Find("Button4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.button4 = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EmptyScenePanel_button4")
			if self.button4_Button_onClick then
				self:button4_Button_onClick(self.button4)
			end
		end)


end

---@private
function EmptyScenePanel:InitGenerate__7(Root, data)
--[[
	Button5
--]]
	local tmp = Root:Find("Button5").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.button5 = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EmptyScenePanel_button5")
			if self.button5_Button_onClick then
				self:button5_Button_onClick(self.button5)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function EmptyScenePanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return EmptyScenePanel