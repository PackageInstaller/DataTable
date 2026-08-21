---@class ActivityRoleChoose_Generate_remainNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityRoleChoose_Generate_exchangeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityRoleChoose_Generate_role4_detail
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityRoleChoose_Generate_role4
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public selected UnityEngine.GameObject
---@field public detail ActivityRoleChoose_Generate_role4_detail
---@field public mask UnityEngine.GameObject

---@class ActivityRoleChoose_Generate_role3_detail
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityRoleChoose_Generate_detail
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityRoleChoose_Generate_role3
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public selected UnityEngine.GameObject
---@field public detail ActivityRoleChoose_Generate_role3_detail
---@field public mask UnityEngine.GameObject

---@class ActivityRoleChoose_Generate_role2_detail
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityRoleChoose_Generate_role2
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public selected UnityEngine.GameObject
---@field public detail ActivityRoleChoose_Generate_role2_detail
---@field public mask UnityEngine.GameObject

---@class ActivityRoleChoose_Generate_role1_detail
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityRoleChoose_Generate_role1
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public selected UnityEngine.GameObject
---@field public detail ActivityRoleChoose_Generate_role1_detail
---@field public mask UnityEngine.GameObject

---@class ActivityRoleChoose_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ActivityRoleChoose_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bg ActivityRoleChoose_Generate_bg
---@field public role1 ActivityRoleChoose_Generate_role1
---@field public role2 ActivityRoleChoose_Generate_role2
---@field public role3 ActivityRoleChoose_Generate_role3
---@field public selected UnityEngine.GameObject
---@field public detail ActivityRoleChoose_Generate_detail
---@field public mask UnityEngine.GameObject
---@field public role4 ActivityRoleChoose_Generate_role4
---@field public tips UnityEngine.GameObject
---@field public icon UnityEngine.GameObject
---@field public exchangeBtn ActivityRoleChoose_Generate_exchangeBtn
---@field public disable UnityEngine.GameObject
---@field public remainNum ActivityRoleChoose_Generate_remainNum
local ActivityRoleChoose = class("ActivityRoleChoose", require("WndBase"))

function ActivityRoleChoose:ctor(data)
end

---@private
function ActivityRoleChoose:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ActivityRoleChoose")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ActivityRoleChoose:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ActivityRoleChoose:InitGenerate__2(Root, data)
--[[
	bg
--]]
	local tmp = Root:Find("bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_bg")
			if self.bg_Button_onClick then
				self:bg_Button_onClick(self.bg)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__3(Root, data)
--[[
	role1
--]]
	local tmp = Root:Find("role1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1 = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_role1")
			if self.role1_Button_onClick then
				self:role1_Button_onClick(self.role1)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__4(Root, data)
--[[
	role1/selected
--]]
	local tmp = Root:Find("role1/selected").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.selected = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__5(Root, data)
--[[
	role1/detail
--]]
	local tmp = Root:Find("role1/detail").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.detail = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_detail")
			if self.detail_ScaleButton_onClick then
				self:detail_ScaleButton_onClick(self.role1.detail)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__6(Root, data)
--[[
	role1/mask
--]]
	local tmp = Root:Find("role1/mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role1.mask = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__7(Root, data)
--[[
	role2
--]]
	local tmp = Root:Find("role2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2 = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_role2")
			if self.role2_Button_onClick then
				self:role2_Button_onClick(self.role2)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__8(Root, data)
--[[
	role2/selected
--]]
	local tmp = Root:Find("role2/selected").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.selected = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__9(Root, data)
--[[
	role2/detail
--]]
	local tmp = Root:Find("role2/detail").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.detail = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_detail")
			if self.detail_ScaleButton_onClick then
				self:detail_ScaleButton_onClick(self.role2.detail)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__10(Root, data)
--[[
	role2/mask
--]]
	local tmp = Root:Find("role2/mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role2.mask = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__11(Root, data)
--[[
	role3
--]]
	local tmp = Root:Find("role3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3 = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_role3")
			if self.role3_Button_onClick then
				self:role3_Button_onClick(self.role3)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__12(Root, data)
--[[
	role3/click/selected
--]]
	local tmp = Root:Find("role3/click/selected").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selected = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__13(Root, data)
--[[
	role3/click/detail
--]]
	local tmp = Root:Find("role3/click/detail").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.detail = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_detail")
			if self.detail_ScaleButton_onClick then
				self:detail_ScaleButton_onClick(self.detail)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__14(Root, data)
--[[
	role3/click/mask
--]]
	local tmp = Root:Find("role3/click/mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__15(Root, data)
--[[
	role3/selected
--]]
	local tmp = Root:Find("role3/selected").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.selected = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__16(Root, data)
--[[
	role3/detail
--]]
	local tmp = Root:Find("role3/detail").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.detail = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_detail")
			if self.detail_ScaleButton_onClick then
				self:detail_ScaleButton_onClick(self.role3.detail)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__17(Root, data)
--[[
	role3/mask
--]]
	local tmp = Root:Find("role3/mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role3.mask = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__18(Root, data)
--[[
	role4
--]]
	local tmp = Root:Find("role4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role4 = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_role4")
			if self.role4_Button_onClick then
				self:role4_Button_onClick(self.role4)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__19(Root, data)
--[[
	role4/selected
--]]
	local tmp = Root:Find("role4/selected").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role4.selected = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__20(Root, data)
--[[
	role4/detail
--]]
	local tmp = Root:Find("role4/detail").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role4.detail = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_detail")
			if self.detail_ScaleButton_onClick then
				self:detail_ScaleButton_onClick(self.role4.detail)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__21(Root, data)
--[[
	role4/mask
--]]
	local tmp = Root:Find("role4/mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role4.mask = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__22(Root, data)
--[[
	tips
--]]
	local tmp = Root:Find("tips").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tips = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__23(Root, data)
--[[
	tips/icon
--]]
	local tmp = Root:Find("tips/icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.icon = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__24(Root, data)
--[[
	tips/exchangeBtn
--]]
	local tmp = Root:Find("tips/exchangeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.exchangeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleChoose_exchangeBtn")
			if self.exchangeBtn_ScaleButton_onClick then
				self:exchangeBtn_ScaleButton_onClick(self.exchangeBtn)
			end
		end)


end

---@private
function ActivityRoleChoose:InitGenerate__25(Root, data)
--[[
	tips/exchangeBtn/disable
--]]
	local tmp = Root:Find("tips/exchangeBtn/disable").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.disable = tmp


end

---@private
function ActivityRoleChoose:InitGenerate__26(Root, data)
--[[
	tips/remainNum
--]]
	local tmp = Root:Find("tips/remainNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.remainNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ActivityRoleChoose:SetLocalizedText(Root)

    local locObj_ActivityRoleChoose_text = Root:Find("tips/exchangeBtn/text")
    if locObj_ActivityRoleChoose_text then
        locObj_ActivityRoleChoose_text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityRoleChoose_text
    end

    local locObj_ActivityRoleChoose_de_text = Root:Find("tips/exchangeBtn/disable/text")
    if locObj_ActivityRoleChoose_de_text then
        locObj_ActivityRoleChoose_de_text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityRoleChoose_de_text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ActivityRoleChoose