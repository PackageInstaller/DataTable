---@class AutoChessMainPanel_Generate_logBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class AutoChessMainPanel_Generate_aITextBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class AutoChessMainPanel_Generate_startBattleBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class AutoChessMainPanel_Generate_saveMapBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class AutoChessMainPanel_Generate_createEntityBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class AutoChessMainPanel_Generate_findPathBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class AutoChessMainPanel_Generate_setBlock
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class AutoChessMainPanel_Generate_setEndPos
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class AutoChessMainPanel_Generate_setStartPos
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class AutoChessMainPanel_Generate_inputField
---@field public gameObject UnityEngine.GameObject
---@field public tMP_InputField TMPro.TMP_InputField

---@class AutoChessMainPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public inputField AutoChessMainPanel_Generate_inputField
---@field public setStartPos AutoChessMainPanel_Generate_setStartPos
---@field public setEndPos AutoChessMainPanel_Generate_setEndPos
---@field public setBlock AutoChessMainPanel_Generate_setBlock
---@field public findPathBtn AutoChessMainPanel_Generate_findPathBtn
---@field public createEntityBtn AutoChessMainPanel_Generate_createEntityBtn
---@field public saveMapBtn AutoChessMainPanel_Generate_saveMapBtn
---@field public startBattleBtn AutoChessMainPanel_Generate_startBattleBtn
---@field public aITextBtn AutoChessMainPanel_Generate_aITextBtn
---@field public logBtn AutoChessMainPanel_Generate_logBtn
local AutoChessMainPanel = class("AutoChessMainPanel", require("WndBase"))

function AutoChessMainPanel:ctor(data)
end

---@private
function AutoChessMainPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("AutoChessMainPanel")

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
function AutoChessMainPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)


end

---@private
function AutoChessMainPanel:InitGenerate__2(Root, data)
--[[
	grid/InputField
--]]
	local tmp = Root:Find("grid/InputField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.inputField = tmp

	tmp.tMP_InputField = tmp:GetComponent(TypeInfo.TMP_InputField)


end

---@private
function AutoChessMainPanel:InitGenerate__3(Root, data)
--[[
	grid/setStartPos
--]]
	local tmp = Root:Find("grid/setStartPos").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setStartPos = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.setStartPos_Toggle_onValueChanged then
				self:setStartPos_Toggle_onValueChanged(self.setStartPos,isOn)
			end
		end)


end

---@private
function AutoChessMainPanel:InitGenerate__4(Root, data)
--[[
	grid/setEndPos
--]]
	local tmp = Root:Find("grid/setEndPos").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setEndPos = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.setEndPos_Toggle_onValueChanged then
				self:setEndPos_Toggle_onValueChanged(self.setEndPos,isOn)
			end
		end)


end

---@private
function AutoChessMainPanel:InitGenerate__5(Root, data)
--[[
	grid/setBlock
--]]
	local tmp = Root:Find("grid/setBlock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setBlock = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.setBlock_Toggle_onValueChanged then
				self:setBlock_Toggle_onValueChanged(self.setBlock,isOn)
			end
		end)


end

---@private
function AutoChessMainPanel:InitGenerate__6(Root, data)
--[[
	grid/findPathBtn
--]]
	local tmp = Root:Find("grid/findPathBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.findPathBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AutoChessMainPanel_findPathBtn")
			if self.findPathBtn_Button_onClick then
				self:findPathBtn_Button_onClick(self.findPathBtn)
			end
		end)


end

---@private
function AutoChessMainPanel:InitGenerate__7(Root, data)
--[[
	grid/createEntityBtn
--]]
	local tmp = Root:Find("grid/createEntityBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.createEntityBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AutoChessMainPanel_createEntityBtn")
			if self.createEntityBtn_Button_onClick then
				self:createEntityBtn_Button_onClick(self.createEntityBtn)
			end
		end)


end

---@private
function AutoChessMainPanel:InitGenerate__8(Root, data)
--[[
	grid/saveMapBtn
--]]
	local tmp = Root:Find("grid/saveMapBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.saveMapBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AutoChessMainPanel_saveMapBtn")
			if self.saveMapBtn_Button_onClick then
				self:saveMapBtn_Button_onClick(self.saveMapBtn)
			end
		end)


end

---@private
function AutoChessMainPanel:InitGenerate__9(Root, data)
--[[
	grid/startBattleBtn
--]]
	local tmp = Root:Find("grid/startBattleBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.startBattleBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AutoChessMainPanel_startBattleBtn")
			if self.startBattleBtn_Button_onClick then
				self:startBattleBtn_Button_onClick(self.startBattleBtn)
			end
		end)


end

---@private
function AutoChessMainPanel:InitGenerate__10(Root, data)
--[[
	grid/AITextBtn
--]]
	local tmp = Root:Find("grid/AITextBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.aITextBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AutoChessMainPanel_aITextBtn")
			if self.aITextBtn_Button_onClick then
				self:aITextBtn_Button_onClick(self.aITextBtn)
			end
		end)


end

---@private
function AutoChessMainPanel:InitGenerate__11(Root, data)
--[[
	grid/LogBtn
--]]
	local tmp = Root:Find("grid/LogBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.logBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AutoChessMainPanel_logBtn")
			if self.logBtn_Button_onClick then
				self:logBtn_Button_onClick(self.logBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function AutoChessMainPanel:SetLocalizedText(Root)

    local locObj_AutoChessMainPanel_Text = Root:Find("grid/InputField/Text Area/Text")
    if locObj_AutoChessMainPanel_Text then
        locObj_AutoChessMainPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AutoChessMainPanel_Text
    end

    local locObj_AutoChessMainPanel_Label = Root:Find("grid/setStartPos/Label")
    if locObj_AutoChessMainPanel_Label then
        locObj_AutoChessMainPanel_Label.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AutoChessMainPanel_Label
    end

    local locObj_AutoChessMainPanel_ss_Label = Root:Find("grid/setEndPos/Label")
    if locObj_AutoChessMainPanel_ss_Label then
        locObj_AutoChessMainPanel_ss_Label.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AutoChessMainPanel_ss_Label
    end

    local locObj_AutoChessMainPanel_sk_Label = Root:Find("grid/setBlock/Label")
    if locObj_AutoChessMainPanel_sk_Label then
        locObj_AutoChessMainPanel_sk_Label.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AutoChessMainPanel_sk_Label
    end

    local locObj_AutoChessMainPanel_TextTMP = Root:Find("grid/findPathBtn/Text (TMP)")
    if locObj_AutoChessMainPanel_TextTMP then
        locObj_AutoChessMainPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AutoChessMainPanel_TextTMP
    end

    local locObj_AutoChessMainPanel_cn_TextTMP = Root:Find("grid/createEntityBtn/Text (TMP)")
    if locObj_AutoChessMainPanel_cn_TextTMP then
        locObj_AutoChessMainPanel_cn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AutoChessMainPanel_cn_TextTMP
    end

    local locObj_AutoChessMainPanel_sn_TextTMP = Root:Find("grid/saveMapBtn/Text (TMP)")
    if locObj_AutoChessMainPanel_sn_TextTMP then
        locObj_AutoChessMainPanel_sn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AutoChessMainPanel_sn_TextTMP
    end

    local locObj_AutoChessMainPanel_gd_sn_TextTMP = Root:Find("grid/startBattleBtn/Text (TMP)")
    if locObj_AutoChessMainPanel_gd_sn_TextTMP then
        locObj_AutoChessMainPanel_gd_sn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AutoChessMainPanel_gd_sn_TextTMP
    end

    local locObj_AutoChessMainPanel_An_TextTMP = Root:Find("grid/AITextBtn/Text (TMP)")
    if locObj_AutoChessMainPanel_An_TextTMP then
        locObj_AutoChessMainPanel_An_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AutoChessMainPanel_An_TextTMP
    end

    local locObj_AutoChessMainPanel_Ln_TextTMP = Root:Find("grid/LogBtn/Text (TMP)")
    if locObj_AutoChessMainPanel_Ln_TextTMP then
        locObj_AutoChessMainPanel_Ln_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AutoChessMainPanel_Ln_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return AutoChessMainPanel