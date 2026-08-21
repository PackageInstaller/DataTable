---@class HomelandFunctionQuickPositioningPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HomelandFunctionQuickPositioningPanel_Generate_funPrefab_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandFunctionQuickPositioningPanel_Generate_funPrefab_iconImage
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomelandFunctionQuickPositioningPanel_Generate_funPrefab_viewBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HomelandFunctionQuickPositioningPanel_Generate_funPrefab
---@field public gameObject UnityEngine.GameObject
---@field public viewBtn HomelandFunctionQuickPositioningPanel_Generate_funPrefab_viewBtn
---@field public iconImage HomelandFunctionQuickPositioningPanel_Generate_funPrefab_iconImage
---@field public nameText HomelandFunctionQuickPositioningPanel_Generate_funPrefab_nameText
---@field public redPoint UnityEngine.GameObject

---@class HomelandFunctionQuickPositioningPanel_Generate_contentView
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomelandFunctionQuickPositioningPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public contentView HomelandFunctionQuickPositioningPanel_Generate_contentView
---@field public funPrefab HomelandFunctionQuickPositioningPanel_Generate_funPrefab
---@field public closeBtn HomelandFunctionQuickPositioningPanel_Generate_closeBtn
local HomelandFunctionQuickPositioningPanel = class("HomelandFunctionQuickPositioningPanel", require("MsgBoxBase"))

function HomelandFunctionQuickPositioningPanel:ctor(data)
end

---@private
function HomelandFunctionQuickPositioningPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("HomelandFunctionQuickPositioningPanel")

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
function HomelandFunctionQuickPositioningPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function HomelandFunctionQuickPositioningPanel:InitGenerate__2(Root, data)
--[[
	contentView
--]]
	local tmp = Root:Find("contentView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.contentView = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomelandFunctionQuickPositioningPanel:InitGenerate__3(Root, data)
--[[
	contentView/funGrid/funPrefab
--]]
	local tmp = Root:Find("contentView/funGrid/funPrefab").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.funPrefab = tmp


end

---@private
function HomelandFunctionQuickPositioningPanel:InitGenerate__4(Root, data)
--[[
	contentView/funGrid/funPrefab/viewBtn
--]]
	local tmp = Root:Find("contentView/funGrid/funPrefab/viewBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.funPrefab.viewBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomelandFunctionQuickPositioningPanel_viewBtn")
			if self.viewBtn_ScaleButton_onClick then
				self:viewBtn_ScaleButton_onClick(self.funPrefab.viewBtn)
			end
		end)


end

---@private
function HomelandFunctionQuickPositioningPanel:InitGenerate__5(Root, data)
--[[
	contentView/funGrid/funPrefab/viewBtn/iconImage
--]]
	local tmp = Root:Find("contentView/funGrid/funPrefab/viewBtn/iconImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.funPrefab.iconImage = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomelandFunctionQuickPositioningPanel:InitGenerate__6(Root, data)
--[[
	contentView/funGrid/funPrefab/viewBtn/nameText
--]]
	local tmp = Root:Find("contentView/funGrid/funPrefab/viewBtn/nameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.funPrefab.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandFunctionQuickPositioningPanel:InitGenerate__7(Root, data)
--[[
	contentView/funGrid/funPrefab/viewBtn/RedPoint
--]]
	local tmp = Root:Find("contentView/funGrid/funPrefab/viewBtn/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.funPrefab.redPoint = tmp


end

---@private
function HomelandFunctionQuickPositioningPanel:InitGenerate__8(Root, data)
--[[
	contentView/closeBtn
--]]
	local tmp = Root:Find("contentView/closeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomelandFunctionQuickPositioningPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function HomelandFunctionQuickPositioningPanel:SetLocalizedText(Root)

    local locObj_HomelandFunctionQuickPositioningPanel_TextTMP = Root:Find("contentView/tagView/Text (TMP)")
    if locObj_HomelandFunctionQuickPositioningPanel_TextTMP then
        locObj_HomelandFunctionQuickPositioningPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomelandFunctionQuickPositioningPanel_TextTMP
    end

    local locObj_HomelandFunctionQuickPositioningPanel_TextTMP1 = Root:Find("contentView/closeBtn/Text (TMP) (1)")
    if locObj_HomelandFunctionQuickPositioningPanel_TextTMP1 then
        locObj_HomelandFunctionQuickPositioningPanel_TextTMP1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomelandFunctionQuickPositioningPanel_TextTMP1
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return HomelandFunctionQuickPositioningPanel