---@class ActivityPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class ActivityPanel_Generate_leftBtn_btnName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityPanel_Generate_leftBtn_sel_selName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityPanel_Generate_leftBtn_sel
---@field public gameObject UnityEngine.GameObject
---@field public selName ActivityPanel_Generate_leftBtn_sel_selName

---@class ActivityPanel_Generate_leftBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public sel ActivityPanel_Generate_leftBtn_sel
---@field public btnName ActivityPanel_Generate_leftBtn_btnName
---@field public redPoint UnityEngine.GameObject

---@class ActivityPanel_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivityPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bg ActivityPanel_Generate_bg
---@field public activitySignRole UnityEngine.GameObject
---@field public activityFirstChargeRole UnityEngine.GameObject
---@field public activityRoleExchangeRole UnityEngine.GameObject
---@field public leftBtnRoot UnityEngine.GameObject
---@field public leftBtn ActivityPanel_Generate_leftBtn
---@field public customBackPanel ActivityPanel_Generate_customBackPanel
local ActivityPanel = class("ActivityPanel", require("WndBase"))

function ActivityPanel:ctor(data)
end

---@private
function ActivityPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ActivityPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ActivityPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ActivityPanel:InitGenerate__2(Root, data)
--[[
	Bg
--]]
	local tmp = Root:Find("Bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivityPanel:InitGenerate__3(Root, data)
--[[
	activitySignRole
--]]
	local tmp = Root:Find("activitySignRole").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activitySignRole = tmp


end

---@private
function ActivityPanel:InitGenerate__4(Root, data)
--[[
	ActivityFirstChargeRole
--]]
	local tmp = Root:Find("ActivityFirstChargeRole").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activityFirstChargeRole = tmp


end

---@private
function ActivityPanel:InitGenerate__5(Root, data)
--[[
	ActivityRoleExchangeRole
--]]
	local tmp = Root:Find("ActivityRoleExchangeRole").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activityRoleExchangeRole = tmp


end

---@private
function ActivityPanel:InitGenerate__6(Root, data)
--[[
	AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot
--]]
	local tmp = Root:Find("AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.leftBtnRoot = tmp


end

---@private
function ActivityPanel:InitGenerate__7(Root, data)
--[[
	AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot/LeftBtn
--]]
	local tmp = Root:Find("AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot/LeftBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.leftBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityPanel_leftBtn")
			if self.leftBtn_Button_onClick then
				self:leftBtn_Button_onClick(self.leftBtn)
			end
		end)


end

---@private
function ActivityPanel:InitGenerate__8(Root, data)
--[[
	AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot/LeftBtn/Sel
--]]
	local tmp = Root:Find("AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot/LeftBtn/Sel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.leftBtn.sel = tmp


end

---@private
function ActivityPanel:InitGenerate__9(Root, data)
--[[
	AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot/LeftBtn/Sel/SelName
--]]
	local tmp = Root:Find("AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot/LeftBtn/Sel/SelName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.leftBtn.sel.selName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityPanel:InitGenerate__10(Root, data)
--[[
	AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot/LeftBtn/BtnName
--]]
	local tmp = Root:Find("AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot/LeftBtn/BtnName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.leftBtn.btnName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityPanel:InitGenerate__11(Root, data)
--[[
	AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot/LeftBtn/RedPoint
--]]
	local tmp = Root:Find("AdjustRoot/Left/bg/Scroll View/Viewport/LeftBtnRoot/LeftBtn/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.leftBtn.redPoint = tmp


end

---@private
function ActivityPanel:InitGenerate__12(Root, data)
--[[
	CustomBackPanel
--]]
	local tmp = Root:Find("CustomBackPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBackPanel = tmp

	tmp.customBackPanel = tmp:AddComponentLua("CustomBackPanel", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ActivityPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ActivityPanel