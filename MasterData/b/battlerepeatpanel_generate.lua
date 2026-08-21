---@class BattleRepeatPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class BattleRepeatPanel_Generate_formationRole_roleHeadBox
---@field public gameObject UnityEngine.GameObject
---@field public roleHeadBox RoleHeadBox

---@class BattleRepeatPanel_Generate_formationRole
---@field public gameObject UnityEngine.GameObject
---@field public dragListener DragListener
---@field public scaleButton ScaleButton
---@field public roleHeadBox BattleRepeatPanel_Generate_formationRole_roleHeadBox

---@class BattleRepeatPanel_Generate_preFormationBox_selectText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class BattleRepeatPanel_Generate_preFormationBox_formationText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class BattleRepeatPanel_Generate_preFormationBox
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public formationText BattleRepeatPanel_Generate_preFormationBox_formationText
---@field public isSelect UnityEngine.GameObject
---@field public selectText BattleRepeatPanel_Generate_preFormationBox_selectText
---@field public roleList UnityEngine.GameObject

---@class BattleRepeatPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleRepeatPanel_Generate_cacelBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleRepeatPanel_Generate_setNumView_numSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class BattleRepeatPanel_Generate_setNumView_maxText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleRepeatPanel_Generate_setNumView_minText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleRepeatPanel_Generate_setNumView_maxBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleRepeatPanel_Generate_setNumView_plusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleRepeatPanel_Generate_setNumView_minusBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleRepeatPanel_Generate_setNumView_curNumText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleRepeatPanel_Generate_setNumView_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleRepeatPanel_Generate_setNumView
---@field public gameObject UnityEngine.GameObject
---@field public titleText BattleRepeatPanel_Generate_setNumView_titleText
---@field public curNumText BattleRepeatPanel_Generate_setNumView_curNumText
---@field public minusBtn BattleRepeatPanel_Generate_setNumView_minusBtn
---@field public plusBtn BattleRepeatPanel_Generate_setNumView_plusBtn
---@field public maxBtn BattleRepeatPanel_Generate_setNumView_maxBtn
---@field public minText BattleRepeatPanel_Generate_setNumView_minText
---@field public maxText BattleRepeatPanel_Generate_setNumView_maxText
---@field public numSlider BattleRepeatPanel_Generate_setNumView_numSlider

---@class BattleRepeatPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class BattleRepeatPanel_Generate_sweepFloorTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleRepeatPanel_Generate_addStrengthBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleRepeatPanel_Generate_strengthIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class BattleRepeatPanel_Generate_allStrengthText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleRepeatPanel_Generate_allStrengthTextDesc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleRepeatPanel_Generate_needStrengthText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleRepeatPanel_Generate_exitBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleRepeatPanel_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleRepeatPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class BattleRepeatPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask BattleRepeatPanel_Generate_mask
---@field public titleText BattleRepeatPanel_Generate_titleText
---@field public exitBtn BattleRepeatPanel_Generate_exitBtn
---@field public needStrengthText BattleRepeatPanel_Generate_needStrengthText
---@field public allStrengthTextDesc BattleRepeatPanel_Generate_allStrengthTextDesc
---@field public allStrengthText BattleRepeatPanel_Generate_allStrengthText
---@field public strengthIcon BattleRepeatPanel_Generate_strengthIcon
---@field public addStrengthBtn BattleRepeatPanel_Generate_addStrengthBtn
---@field public setSimulatedInfo UnityEngine.GameObject
---@field public sweepFloorTxt BattleRepeatPanel_Generate_sweepFloorTxt
---@field public rewardList UnityEngine.GameObject
---@field public customBox BattleRepeatPanel_Generate_customBox
---@field public setNumView BattleRepeatPanel_Generate_setNumView
---@field public cacelBtn BattleRepeatPanel_Generate_cacelBtn
---@field public okBtn BattleRepeatPanel_Generate_okBtn
---@field public content UnityEngine.GameObject
---@field public preFormationBox BattleRepeatPanel_Generate_preFormationBox
---@field public formationRole BattleRepeatPanel_Generate_formationRole
---@field public customMsgPanel BattleRepeatPanel_Generate_customMsgPanel
local BattleRepeatPanel = class("BattleRepeatPanel", require("WndBase"))

function BattleRepeatPanel:ctor(data)
end

---@private
function BattleRepeatPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("BattleRepeatPanel")

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
	self:InitGenerate__27(Root,data)
	self:InitGenerate__28(Root,data)
	self:InitGenerate__29(Root,data)
	self:InitGenerate__30(Root,data)
	self:InitGenerate__31(Root,data)
	self:InitGenerate__32(Root,data)
	self:InitGenerate__33(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function BattleRepeatPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function BattleRepeatPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("BattleRepeatPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function BattleRepeatPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/Title/image/TitleText
--]]
	local tmp = Root:Find("BoxBg/Title/image/TitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleRepeatPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/Title/exitBtn
--]]
	local tmp = Root:Find("BoxBg/Title/exitBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.exitBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleRepeatPanel_exitBtn")
			if self.exitBtn_ScaleButton_onClick then
				self:exitBtn_ScaleButton_onClick(self.exitBtn)
			end
		end)


end

---@private
function BattleRepeatPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/RepeatInfo/StrengthInfo/NeedStrBox/NeedStrengthText
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/StrengthInfo/NeedStrBox/NeedStrengthText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.needStrengthText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleRepeatPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/RepeatInfo/StrengthInfo/NeedStrBox/AllStrengthTextDesc
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/StrengthInfo/NeedStrBox/AllStrengthTextDesc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.allStrengthTextDesc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleRepeatPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/RepeatInfo/StrengthInfo/AllStrBox/AllStrengthText
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/StrengthInfo/AllStrBox/AllStrengthText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.allStrengthText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleRepeatPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/RepeatInfo/StrengthInfo/StrengthiconBg/StrengthIcon
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/StrengthInfo/StrengthiconBg/StrengthIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.strengthIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function BattleRepeatPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/RepeatInfo/StrengthInfo/StrengthiconBg/AddStrengthBtn
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/StrengthInfo/StrengthiconBg/AddStrengthBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.addStrengthBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleRepeatPanel_addStrengthBtn")
			if self.addStrengthBtn_ScaleButton_onClick then
				self:addStrengthBtn_ScaleButton_onClick(self.addStrengthBtn)
			end
		end)


end

---@private
function BattleRepeatPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/RepeatInfo/SetSimulatedInfo
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetSimulatedInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setSimulatedInfo = tmp


end

---@private
function BattleRepeatPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/RepeatInfo/SetSimulatedInfo/SweepFloorTxt
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetSimulatedInfo/SweepFloorTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sweepFloorTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleRepeatPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/RepeatInfo/RewardBg/ScrollView/Viewport/RewardList
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/RewardBg/ScrollView/Viewport/RewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardList = tmp


end

---@private
function BattleRepeatPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/RepeatInfo/RewardBg/ScrollView/Viewport/RewardList/CustomBox
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/RewardBg/ScrollView/Viewport/RewardList/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function BattleRepeatPanel:InitGenerate__14(Root, data)
--[[
	BoxBg/RepeatInfo/SetNumView
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetNumView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView = tmp


end

---@private
function BattleRepeatPanel:InitGenerate__15(Root, data)
--[[
	BoxBg/RepeatInfo/SetNumView/titleText
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetNumView/titleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleRepeatPanel:InitGenerate__16(Root, data)
--[[
	BoxBg/RepeatInfo/SetNumView/curNumInfo/curNumText
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetNumView/curNumInfo/curNumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.curNumText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleRepeatPanel:InitGenerate__17(Root, data)
--[[
	BoxBg/RepeatInfo/SetNumView/minusBtn
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetNumView/minusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.minusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleRepeatPanel_minusBtn")
			if self.minusBtn_ScaleButton_onClick then
				self:minusBtn_ScaleButton_onClick(self.setNumView.minusBtn)
			end
		end)


end

---@private
function BattleRepeatPanel:InitGenerate__18(Root, data)
--[[
	BoxBg/RepeatInfo/SetNumView/plusBtn
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetNumView/plusBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.plusBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleRepeatPanel_plusBtn")
			if self.plusBtn_ScaleButton_onClick then
				self:plusBtn_ScaleButton_onClick(self.setNumView.plusBtn)
			end
		end)


end

---@private
function BattleRepeatPanel:InitGenerate__19(Root, data)
--[[
	BoxBg/RepeatInfo/SetNumView/maxBtn
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetNumView/maxBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.maxBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleRepeatPanel_maxBtn")
			if self.maxBtn_ScaleButton_onClick then
				self:maxBtn_ScaleButton_onClick(self.setNumView.maxBtn)
			end
		end)


end

---@private
function BattleRepeatPanel:InitGenerate__20(Root, data)
--[[
	BoxBg/RepeatInfo/SetNumView/minText
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetNumView/minText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.minText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleRepeatPanel:InitGenerate__21(Root, data)
--[[
	BoxBg/RepeatInfo/SetNumView/maxText
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetNumView/maxText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.maxText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleRepeatPanel:InitGenerate__22(Root, data)
--[[
	BoxBg/RepeatInfo/SetNumView/numSlider
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/SetNumView/numSlider").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.setNumView.numSlider = tmp

	tmp.slider = tmp:GetComponent(TypeInfo.Slider)
	tmp.slider.onValueChanged:RemoveAllListeners()
	tmp.slider.onValueChanged:AddListener(function (value)
			if self.numSlider_Slider_onValueChanged then
				self:numSlider_Slider_onValueChanged(self.setNumView.numSlider,value)
			end
		end)


end

---@private
function BattleRepeatPanel:InitGenerate__23(Root, data)
--[[
	BoxBg/RepeatInfo/CacelBtn
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/CacelBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cacelBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleRepeatPanel_cacelBtn")
			if self.cacelBtn_ScaleButton_onClick then
				self:cacelBtn_ScaleButton_onClick(self.cacelBtn)
			end
		end)


end

---@private
function BattleRepeatPanel:InitGenerate__24(Root, data)
--[[
	BoxBg/RepeatInfo/OkBtn
--]]
	local tmp = Root:Find("BoxBg/RepeatInfo/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleRepeatPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function BattleRepeatPanel:InitGenerate__25(Root, data)
--[[
	BoxBg/PreFormation/ScrollView/Viewport/Content
--]]
	local tmp = Root:Find("BoxBg/PreFormation/ScrollView/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp


end

---@private
function BattleRepeatPanel:InitGenerate__26(Root, data)
--[[
	BoxBg/PreFormation/ScrollView/Viewport/Content/PreFormationBox
--]]
	local tmp = Root:Find("BoxBg/PreFormation/ScrollView/Viewport/Content/PreFormationBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.preFormationBox = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function BattleRepeatPanel:InitGenerate__27(Root, data)
--[[
	BoxBg/PreFormation/ScrollView/Viewport/Content/PreFormationBox/FormationBg/FormationText
--]]
	local tmp = Root:Find("BoxBg/PreFormation/ScrollView/Viewport/Content/PreFormationBox/FormationBg/FormationText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.preFormationBox.formationText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function BattleRepeatPanel:InitGenerate__28(Root, data)
--[[
	BoxBg/PreFormation/ScrollView/Viewport/Content/PreFormationBox/FormationBg/IsSelect
--]]
	local tmp = Root:Find("BoxBg/PreFormation/ScrollView/Viewport/Content/PreFormationBox/FormationBg/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.preFormationBox.isSelect = tmp


end

---@private
function BattleRepeatPanel:InitGenerate__29(Root, data)
--[[
	BoxBg/PreFormation/ScrollView/Viewport/Content/PreFormationBox/FormationBg/IsSelect/SelectText
--]]
	local tmp = Root:Find("BoxBg/PreFormation/ScrollView/Viewport/Content/PreFormationBox/FormationBg/IsSelect/SelectText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.preFormationBox.selectText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function BattleRepeatPanel:InitGenerate__30(Root, data)
--[[
	BoxBg/PreFormation/ScrollView/Viewport/Content/PreFormationBox/RoleListBg/RoleList
--]]
	local tmp = Root:Find("BoxBg/PreFormation/ScrollView/Viewport/Content/PreFormationBox/RoleListBg/RoleList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.preFormationBox.roleList = tmp


end

---@private
function BattleRepeatPanel:InitGenerate__31(Root, data)
--[[
	FormationRole
--]]
	local tmp = Root:Find("FormationRole").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.formationRole = tmp

	tmp.dragListener = tmp:GetComponent(TypeInfo.DragListener)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function BattleRepeatPanel:InitGenerate__32(Root, data)
--[[
	FormationRole/RoleHeadBox
--]]
	local tmp = Root:Find("FormationRole/RoleHeadBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.formationRole.roleHeadBox = tmp

	tmp.roleHeadBox = tmp:AddComponentLua("RoleHeadBox", data)


end

---@private
function BattleRepeatPanel:InitGenerate__33(Root, data)
--[[
	CustomMsgPanel
--]]
	local tmp = Root:Find("CustomMsgPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customMsgPanel = tmp

	tmp.customMsgPanel = tmp:AddComponentLua("CustomMsgPanel", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function BattleRepeatPanel:SetLocalizedText(Root)

    local locObj_BattleRepeatPanel_TitleText2 = Root:Find("BoxBg/Title/image/TitleText2")
    if locObj_BattleRepeatPanel_TitleText2 then
        locObj_BattleRepeatPanel_TitleText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRepeatPanel_TitleText2
    end

    local locObj_BattleRepeatPanel_StrengthText = Root:Find("BoxBg/RepeatInfo/StrengthInfo/StrengthTitle/StrengthText")
    if locObj_BattleRepeatPanel_StrengthText then
        locObj_BattleRepeatPanel_StrengthText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRepeatPanel_StrengthText
    end

    local locObj_BattleRepeatPanel_StrengthEngText = Root:Find("BoxBg/RepeatInfo/StrengthInfo/StrengthTitle/StrengthEngText")
    if locObj_BattleRepeatPanel_StrengthEngText then
        locObj_BattleRepeatPanel_StrengthEngText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRepeatPanel_StrengthEngText
    end

    local locObj_BattleRepeatPanel_AllStrengthTextDesc = Root:Find("BoxBg/RepeatInfo/StrengthInfo/AllStrBox/AllStrengthTextDesc")
    if locObj_BattleRepeatPanel_AllStrengthTextDesc then
        locObj_BattleRepeatPanel_AllStrengthTextDesc.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRepeatPanel_AllStrengthTextDesc
    end

    local locObj_BattleRepeatPanel_BattleText = Root:Find("BoxBg/RepeatInfo/SetSimulatedInfo/BattleTitle/BattleText")
    if locObj_BattleRepeatPanel_BattleText then
        locObj_BattleRepeatPanel_BattleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRepeatPanel_BattleText
    end

    local locObj_BattleRepeatPanel_BattleEngText = Root:Find("BoxBg/RepeatInfo/SetSimulatedInfo/BattleTitle/BattleEngText")
    if locObj_BattleRepeatPanel_BattleEngText then
        locObj_BattleRepeatPanel_BattleEngText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRepeatPanel_BattleEngText
    end

    local locObj_BattleRepeatPanel_RewardText = Root:Find("BoxBg/RepeatInfo/RewardBg/RewardTitle/RewardText")
    if locObj_BattleRepeatPanel_RewardText then
        locObj_BattleRepeatPanel_RewardText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRepeatPanel_RewardText
    end

    local locObj_BattleRepeatPanel_RewardEngText = Root:Find("BoxBg/RepeatInfo/RewardBg/RewardTitle/RewardEngText")
    if locObj_BattleRepeatPanel_RewardEngText then
        locObj_BattleRepeatPanel_RewardEngText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRepeatPanel_RewardEngText
    end

    local locObj_BattleRepeatPanel_txt = Root:Find("BoxBg/RepeatInfo/CacelBtn/txt")
    if locObj_BattleRepeatPanel_txt then
        locObj_BattleRepeatPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRepeatPanel_txt
    end

    local locObj_BattleRepeatPanel_On_txt = Root:Find("BoxBg/RepeatInfo/OkBtn/txt")
    if locObj_BattleRepeatPanel_On_txt then
        locObj_BattleRepeatPanel_On_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.BattleRepeatPanel_On_txt
    end

    local locObj_BattleRepeatPanel_PreTitle = Root:Find("BoxBg/PreFormation/PreTitle")
    if locObj_BattleRepeatPanel_PreTitle then
        locObj_BattleRepeatPanel_PreTitle.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.BattleRepeatPanel_PreTitle
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return BattleRepeatPanel