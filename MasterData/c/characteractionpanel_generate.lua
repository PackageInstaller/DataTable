---@class CharacterActionPanel_Generate_chooseBackBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CharacterActionPanel_Generate_confirmBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CharacterActionPanel_Generate_backBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CharacterActionPanel_Generate_skill3Btn_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CharacterActionPanel_Generate_skill3Btn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public nameTxt CharacterActionPanel_Generate_skill3Btn_nameTxt

---@class CharacterActionPanel_Generate_skill2Btn_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CharacterActionPanel_Generate_skill2Btn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public nameTxt CharacterActionPanel_Generate_skill2Btn_nameTxt

---@class CharacterActionPanel_Generate_skill1Btn_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CharacterActionPanel_Generate_skill1Btn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public nameTxt CharacterActionPanel_Generate_skill1Btn_nameTxt

---@class CharacterActionPanel_Generate_standbyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CharacterActionPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public actionGroup UnityEngine.GameObject
---@field public standbyBtn CharacterActionPanel_Generate_standbyBtn
---@field public skill1Btn CharacterActionPanel_Generate_skill1Btn
---@field public skill2Btn CharacterActionPanel_Generate_skill2Btn
---@field public skill3Btn CharacterActionPanel_Generate_skill3Btn
---@field public doSkillGroup UnityEngine.GameObject
---@field public backBtn CharacterActionPanel_Generate_backBtn
---@field public confirmBtn CharacterActionPanel_Generate_confirmBtn
---@field public chooseTargetGroup UnityEngine.GameObject
---@field public chooseBackBtn CharacterActionPanel_Generate_chooseBackBtn
local CharacterActionPanel = class("CharacterActionPanel", require("WndBase"))

function CharacterActionPanel:ctor(data)
end

---@private
function CharacterActionPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("CharacterActionPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function CharacterActionPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function CharacterActionPanel:InitGenerate__2(Root, data)
--[[
	ActionGroup
--]]
	local tmp = Root:Find("ActionGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.actionGroup = tmp


end

---@private
function CharacterActionPanel:InitGenerate__3(Root, data)
--[[
	ActionGroup/StandbyBtn
--]]
	local tmp = Root:Find("ActionGroup/StandbyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.standbyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CharacterActionPanel_standbyBtn")
			if self.standbyBtn_ScaleButton_onClick then
				self:standbyBtn_ScaleButton_onClick(self.standbyBtn)
			end
		end)


end

---@private
function CharacterActionPanel:InitGenerate__4(Root, data)
--[[
	ActionGroup/SkillBtns/Skill1Btn
--]]
	local tmp = Root:Find("ActionGroup/SkillBtns/Skill1Btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill1Btn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CharacterActionPanel_skill1Btn")
			if self.skill1Btn_ScaleButton_onClick then
				self:skill1Btn_ScaleButton_onClick(self.skill1Btn)
			end
		end)


end

---@private
function CharacterActionPanel:InitGenerate__5(Root, data)
--[[
	ActionGroup/SkillBtns/Skill1Btn/NameTxt
--]]
	local tmp = Root:Find("ActionGroup/SkillBtns/Skill1Btn/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill1Btn.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CharacterActionPanel:InitGenerate__6(Root, data)
--[[
	ActionGroup/SkillBtns/Skill2Btn
--]]
	local tmp = Root:Find("ActionGroup/SkillBtns/Skill2Btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill2Btn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CharacterActionPanel_skill2Btn")
			if self.skill2Btn_ScaleButton_onClick then
				self:skill2Btn_ScaleButton_onClick(self.skill2Btn)
			end
		end)


end

---@private
function CharacterActionPanel:InitGenerate__7(Root, data)
--[[
	ActionGroup/SkillBtns/Skill2Btn/NameTxt
--]]
	local tmp = Root:Find("ActionGroup/SkillBtns/Skill2Btn/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill2Btn.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CharacterActionPanel:InitGenerate__8(Root, data)
--[[
	ActionGroup/SkillBtns/Skill3Btn
--]]
	local tmp = Root:Find("ActionGroup/SkillBtns/Skill3Btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill3Btn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CharacterActionPanel_skill3Btn")
			if self.skill3Btn_ScaleButton_onClick then
				self:skill3Btn_ScaleButton_onClick(self.skill3Btn)
			end
		end)


end

---@private
function CharacterActionPanel:InitGenerate__9(Root, data)
--[[
	ActionGroup/SkillBtns/Skill3Btn/NameTxt
--]]
	local tmp = Root:Find("ActionGroup/SkillBtns/Skill3Btn/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skill3Btn.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CharacterActionPanel:InitGenerate__10(Root, data)
--[[
	DoSkillGroup
--]]
	local tmp = Root:Find("DoSkillGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.doSkillGroup = tmp


end

---@private
function CharacterActionPanel:InitGenerate__11(Root, data)
--[[
	DoSkillGroup/BackBtn
--]]
	local tmp = Root:Find("DoSkillGroup/BackBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.backBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CharacterActionPanel_backBtn")
			if self.backBtn_ScaleButton_onClick then
				self:backBtn_ScaleButton_onClick(self.backBtn)
			end
		end)


end

---@private
function CharacterActionPanel:InitGenerate__12(Root, data)
--[[
	DoSkillGroup/ConfirmBtn
--]]
	local tmp = Root:Find("DoSkillGroup/ConfirmBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.confirmBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CharacterActionPanel_confirmBtn")
			if self.confirmBtn_ScaleButton_onClick then
				self:confirmBtn_ScaleButton_onClick(self.confirmBtn)
			end
		end)


end

---@private
function CharacterActionPanel:InitGenerate__13(Root, data)
--[[
	ChooseTargetGroup
--]]
	local tmp = Root:Find("ChooseTargetGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.chooseTargetGroup = tmp


end

---@private
function CharacterActionPanel:InitGenerate__14(Root, data)
--[[
	ChooseTargetGroup/ChooseBackBtn
--]]
	local tmp = Root:Find("ChooseTargetGroup/ChooseBackBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.chooseBackBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CharacterActionPanel_chooseBackBtn")
			if self.chooseBackBtn_ScaleButton_onClick then
				self:chooseBackBtn_ScaleButton_onClick(self.chooseBackBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function CharacterActionPanel:SetLocalizedText(Root)

    local locObj_CharacterActionPanel_StandbyTxt = Root:Find("ActionGroup/StandbyBtn/StandbyTxt")
    if locObj_CharacterActionPanel_StandbyTxt then
        locObj_CharacterActionPanel_StandbyTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CharacterActionPanel_StandbyTxt
    end

    local locObj_CharacterActionPanel_BackTxt = Root:Find("DoSkillGroup/BackBtn/BackTxt")
    if locObj_CharacterActionPanel_BackTxt then
        locObj_CharacterActionPanel_BackTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CharacterActionPanel_BackTxt
    end

    local locObj_CharacterActionPanel_ConfirmTxt = Root:Find("DoSkillGroup/ConfirmBtn/ConfirmTxt")
    if locObj_CharacterActionPanel_ConfirmTxt then
        locObj_CharacterActionPanel_ConfirmTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CharacterActionPanel_ConfirmTxt
    end

    local locObj_CharacterActionPanel_Cn_BackTxt = Root:Find("ChooseTargetGroup/ChooseBackBtn/BackTxt")
    if locObj_CharacterActionPanel_Cn_BackTxt then
        locObj_CharacterActionPanel_Cn_BackTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CharacterActionPanel_Cn_BackTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return CharacterActionPanel