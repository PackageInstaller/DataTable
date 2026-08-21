---@class DispatchBattlePanel_Generate_role_hpProgress
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DispatchBattlePanel_Generate_role_hpText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DispatchBattlePanel_Generate_role_roleHeadBox
---@field public gameObject UnityEngine.GameObject
---@field public roleHeadBox RoleHeadBox

---@class DispatchBattlePanel_Generate_role
---@field public gameObject UnityEngine.GameObject
---@field public roleHeadBox DispatchBattlePanel_Generate_role_roleHeadBox
---@field public hpIcon1 UnityEngine.GameObject
---@field public hpIcon2 UnityEngine.GameObject
---@field public hpIcon3 UnityEngine.GameObject
---@field public hpText DispatchBattlePanel_Generate_role_hpText
---@field public hpProgress DispatchBattlePanel_Generate_role_hpProgress
---@field public ef UnityEngine.GameObject

---@class DispatchBattlePanel_Generate_enemy_frameImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DispatchBattlePanel_Generate_enemy_roleImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DispatchBattlePanel_Generate_enemy
---@field public gameObject UnityEngine.GameObject
---@field public roleImg DispatchBattlePanel_Generate_enemy_roleImg
---@field public frameImg DispatchBattlePanel_Generate_enemy_frameImg
---@field public ef UnityEngine.GameObject

---@class DispatchBattlePanel_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class DispatchBattlePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bg DispatchBattlePanel_Generate_bg
---@field public enemy DispatchBattlePanel_Generate_enemy
---@field public roleRoot UnityEngine.GameObject
---@field public role DispatchBattlePanel_Generate_role
local DispatchBattlePanel = class("DispatchBattlePanel", require("WndBase"))

function DispatchBattlePanel:ctor(data)
end

---@private
function DispatchBattlePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("DispatchBattlePanel")

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
function DispatchBattlePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function DispatchBattlePanel:InitGenerate__2(Root, data)
--[[
	Bg
--]]
	local tmp = Root:Find("Bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("DispatchBattlePanel_bg")
			if self.bg_Button_onClick then
				self:bg_Button_onClick(self.bg)
			end
		end)


end

---@private
function DispatchBattlePanel:InitGenerate__3(Root, data)
--[[
	Enemy
--]]
	local tmp = Root:Find("Enemy").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.enemy = tmp


end

---@private
function DispatchBattlePanel:InitGenerate__4(Root, data)
--[[
	Enemy/RoleMask/RoleImg
--]]
	local tmp = Root:Find("Enemy/RoleMask/RoleImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.enemy.roleImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DispatchBattlePanel:InitGenerate__5(Root, data)
--[[
	Enemy/RoleMask/FrameImg
--]]
	local tmp = Root:Find("Enemy/RoleMask/FrameImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.enemy.frameImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DispatchBattlePanel:InitGenerate__6(Root, data)
--[[
	Enemy/Ef
--]]
	local tmp = Root:Find("Enemy/Ef").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.enemy.ef = tmp


end

---@private
function DispatchBattlePanel:InitGenerate__7(Root, data)
--[[
	RoleRoot
--]]
	local tmp = Root:Find("RoleRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleRoot = tmp


end

---@private
function DispatchBattlePanel:InitGenerate__8(Root, data)
--[[
	RoleRoot/Role
--]]
	local tmp = Root:Find("RoleRoot/Role").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role = tmp


end

---@private
function DispatchBattlePanel:InitGenerate__9(Root, data)
--[[
	RoleRoot/Role/RoleHeadBox
--]]
	local tmp = Root:Find("RoleRoot/Role/RoleHeadBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role.roleHeadBox = tmp

	tmp.roleHeadBox = tmp:AddComponentLua("RoleHeadBox", data)


end

---@private
function DispatchBattlePanel:InitGenerate__10(Root, data)
--[[
	RoleRoot/Role/Bg/HpIcon1
--]]
	local tmp = Root:Find("RoleRoot/Role/Bg/HpIcon1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role.hpIcon1 = tmp


end

---@private
function DispatchBattlePanel:InitGenerate__11(Root, data)
--[[
	RoleRoot/Role/Bg/HpIcon2
--]]
	local tmp = Root:Find("RoleRoot/Role/Bg/HpIcon2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role.hpIcon2 = tmp


end

---@private
function DispatchBattlePanel:InitGenerate__12(Root, data)
--[[
	RoleRoot/Role/Bg/HpIcon3
--]]
	local tmp = Root:Find("RoleRoot/Role/Bg/HpIcon3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role.hpIcon3 = tmp


end

---@private
function DispatchBattlePanel:InitGenerate__13(Root, data)
--[[
	RoleRoot/Role/Bg/HpText
--]]
	local tmp = Root:Find("RoleRoot/Role/Bg/HpText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role.hpText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function DispatchBattlePanel:InitGenerate__14(Root, data)
--[[
	RoleRoot/Role/Bg/HpProgress
--]]
	local tmp = Root:Find("RoleRoot/Role/Bg/HpProgress").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role.hpProgress = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DispatchBattlePanel:InitGenerate__15(Root, data)
--[[
	RoleRoot/Role/Ef
--]]
	local tmp = Root:Find("RoleRoot/Role/Ef").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role.ef = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function DispatchBattlePanel:SetLocalizedText(Root)

    local locObj_DispatchBattlePanel_Text = Root:Find("Image (1)/Text")
    if locObj_DispatchBattlePanel_Text then
        locObj_DispatchBattlePanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.DispatchBattlePanel_Text
    end

    local locObj_DispatchBattlePanel_I2_Text = Root:Find("Image (2)/Text")
    if locObj_DispatchBattlePanel_I2_Text then
        locObj_DispatchBattlePanel_I2_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.DispatchBattlePanel_I2_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return DispatchBattlePanel