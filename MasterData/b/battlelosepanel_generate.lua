---@class BattleLosePanel_Generate_tipsText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleLosePanel_Generate_backBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleLosePanel_Generate_retryBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleLosePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public retryBtn BattleLosePanel_Generate_retryBtn
---@field public backBtn BattleLosePanel_Generate_backBtn
---@field public tipsText BattleLosePanel_Generate_tipsText
local BattleLosePanel = class("BattleLosePanel", require("WndBase"))

function BattleLosePanel:ctor(data)
end

---@private
function BattleLosePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("BattleLosePanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function BattleLosePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function BattleLosePanel:InitGenerate__2(Root, data)
--[[
	RetryBtn
--]]
	local tmp = Root:Find("RetryBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.retryBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleLosePanel_retryBtn")
			if self.retryBtn_ScaleButton_onClick then
				self:retryBtn_ScaleButton_onClick(self.retryBtn)
			end
		end)


end

---@private
function BattleLosePanel:InitGenerate__3(Root, data)
--[[
	BackBtn
--]]
	local tmp = Root:Find("BackBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.backBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleLosePanel_backBtn")
			if self.backBtn_ScaleButton_onClick then
				self:backBtn_ScaleButton_onClick(self.backBtn)
			end
		end)


end

---@private
function BattleLosePanel:InitGenerate__4(Root, data)
--[[
	TipsText
--]]
	local tmp = Root:Find("TipsText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function BattleLosePanel:SetLocalizedText(Root)

    local locObj_BattleLosePanel_RetryText = Root:Find("RetryBtn/RetryText")
    if locObj_BattleLosePanel_RetryText then
        locObj_BattleLosePanel_RetryText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.BattleLosePanel_RetryText
    end

    local locObj_BattleLosePanel_BackText = Root:Find("BackBtn/BackText")
    if locObj_BattleLosePanel_BackText then
        locObj_BattleLosePanel_BackText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.BattleLosePanel_BackText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return BattleLosePanel