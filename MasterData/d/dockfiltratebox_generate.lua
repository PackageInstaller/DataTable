---@class DockFiltrateBox_Generate_typeBox_typeName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DockFiltrateBox_Generate_typeBox_typeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DockFiltrateBox_Generate_typeBox_typeIconOff
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DockFiltrateBox_Generate_typeBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public typeIconOff DockFiltrateBox_Generate_typeBox_typeIconOff
---@field public typeIcon DockFiltrateBox_Generate_typeBox_typeIcon
---@field public typeName DockFiltrateBox_Generate_typeBox_typeName

---@class DockFiltrateBox_Generate_modeBtn_isSelect_starMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DockFiltrateBox_Generate_modeBtn_isSelect_starTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DockFiltrateBox_Generate_modeBtn_isSelect_rankIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DockFiltrateBox_Generate_modeBtn_selectNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DockFiltrateBox_Generate_modeBtn_isSelect
---@field public gameObject UnityEngine.GameObject
---@field public rankMode UnityEngine.GameObject
---@field public rankIcon DockFiltrateBox_Generate_modeBtn_isSelect_rankIcon
---@field public starMode UnityEngine.GameObject
---@field public starTxt DockFiltrateBox_Generate_modeBtn_isSelect_starTxt
---@field public starMsgTxt DockFiltrateBox_Generate_modeBtn_isSelect_starMsgTxt

---@class DockFiltrateBox_Generate_modeBtn_starMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DockFiltrateBox_Generate_modeBtn_starTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DockFiltrateBox_Generate_modeBtn_rankIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DockFiltrateBox_Generate_modeBtn_modeNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DockFiltrateBox_Generate_modeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public modeNameTxt DockFiltrateBox_Generate_modeBtn_modeNameTxt
---@field public rankMode UnityEngine.GameObject
---@field public rankIcon DockFiltrateBox_Generate_modeBtn_rankIcon
---@field public starMode UnityEngine.GameObject
---@field public starTxt DockFiltrateBox_Generate_modeBtn_starTxt
---@field public starMsgTxt DockFiltrateBox_Generate_modeBtn_starMsgTxt
---@field public isSelect DockFiltrateBox_Generate_modeBtn_isSelect
---@field public selectNameTxt DockFiltrateBox_Generate_modeBtn_selectNameTxt

---@class DockFiltrateBox_Generate_saveTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DockFiltrateBox_Generate_saveBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class DockFiltrateBox_Generate_resetBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class DockFiltrateBox_Generate_confirmBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class DockFiltrateBox_Generate_starListBox_starListBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class DockFiltrateBox_Generate_starListBox
---@field public gameObject UnityEngine.GameObject
---@field public starListBtn DockFiltrateBox_Generate_starListBox_starListBtn
---@field public offIcon UnityEngine.GameObject
---@field public openIcon UnityEngine.GameObject
---@field public msgList UnityEngine.GameObject

---@class DockFiltrateBox_Generate_rankListBox_rankListBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class DockFiltrateBox_Generate_rankListBox
---@field public gameObject UnityEngine.GameObject
---@field public rankListBtn DockFiltrateBox_Generate_rankListBox_rankListBtn
---@field public offIcon UnityEngine.GameObject
---@field public openIcon UnityEngine.GameObject
---@field public msgList UnityEngine.GameObject

---@class DockFiltrateBox_Generate_typeListBox_msgList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class DockFiltrateBox_Generate_typeListBox_typeListBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class DockFiltrateBox_Generate_typeListBox
---@field public gameObject UnityEngine.GameObject
---@field public verticalLayoutGroup UnityEngine.UI.VerticalLayoutGroup
---@field public typeListBtn DockFiltrateBox_Generate_typeListBox_typeListBtn
---@field public offIcon UnityEngine.GameObject
---@field public openIcon UnityEngine.GameObject
---@field public msgList DockFiltrateBox_Generate_typeListBox_msgList

---@class DockFiltrateBox_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class DockFiltrateBox_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class DockFiltrateBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask DockFiltrateBox_Generate_mask
---@field public closeBtn DockFiltrateBox_Generate_closeBtn
---@field public typeListBox DockFiltrateBox_Generate_typeListBox
---@field public rankListBox DockFiltrateBox_Generate_rankListBox
---@field public starListBox DockFiltrateBox_Generate_starListBox
---@field public confirmBtn DockFiltrateBox_Generate_confirmBtn
---@field public resetBtn DockFiltrateBox_Generate_resetBtn
---@field public saveBtn DockFiltrateBox_Generate_saveBtn
---@field public saveTxt DockFiltrateBox_Generate_saveTxt
---@field public modeBtn DockFiltrateBox_Generate_modeBtn
---@field public typeBox DockFiltrateBox_Generate_typeBox
local DockFiltrateBox = class("DockFiltrateBox", require("WndBase"))

function DockFiltrateBox:ctor(data)
end

---@private
function DockFiltrateBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("DockFiltrateBox")

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
	self:InitGenerate__34(Root,data)
	self:InitGenerate__35(Root,data)
	self:InitGenerate__36(Root,data)
	self:InitGenerate__37(Root,data)
	self:InitGenerate__38(Root,data)
	self:InitGenerate__39(Root,data)
	self:InitGenerate__40(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function DockFiltrateBox:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function DockFiltrateBox:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("DockFiltrateBox_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function DockFiltrateBox:InitGenerate__3(Root, data)
--[[
	BoxBg/TitleBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/TitleBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("DockFiltrateBox_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function DockFiltrateBox:InitGenerate__4(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/TypeListBox
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/TypeListBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox = tmp

	tmp.verticalLayoutGroup = tmp:GetComponent(TypeInfo.VerticalLayoutGroup)


end

---@private
function DockFiltrateBox:InitGenerate__5(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/TypeListBox/TypeList/TypeListBtn
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/TypeListBox/TypeList/TypeListBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox.typeListBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("DockFiltrateBox_typeListBtn")
			if self.typeListBtn_Button_onClick then
				self:typeListBtn_Button_onClick(self.typeListBox.typeListBtn)
			end
		end)


end

---@private
function DockFiltrateBox:InitGenerate__6(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/TypeListBox/TypeList/TypeListBtn/OffIcon
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/TypeListBox/TypeList/TypeListBtn/OffIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox.offIcon = tmp


end

---@private
function DockFiltrateBox:InitGenerate__7(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/TypeListBox/TypeList/TypeListBtn/OpenIcon
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/TypeListBox/TypeList/TypeListBtn/OpenIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox.openIcon = tmp


end

---@private
function DockFiltrateBox:InitGenerate__8(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/TypeListBox/MsgList
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/TypeListBox/MsgList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeListBox.msgList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function DockFiltrateBox:InitGenerate__9(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/RankListBox
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/RankListBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rankListBox = tmp


end

---@private
function DockFiltrateBox:InitGenerate__10(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/RankListBox/RankList/RankListBtn
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/RankListBox/RankList/RankListBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rankListBox.rankListBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("DockFiltrateBox_rankListBtn")
			if self.rankListBtn_Button_onClick then
				self:rankListBtn_Button_onClick(self.rankListBox.rankListBtn)
			end
		end)


end

---@private
function DockFiltrateBox:InitGenerate__11(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/RankListBox/RankList/RankListBtn/OffIcon
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/RankListBox/RankList/RankListBtn/OffIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rankListBox.offIcon = tmp


end

---@private
function DockFiltrateBox:InitGenerate__12(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/RankListBox/RankList/RankListBtn/OpenIcon
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/RankListBox/RankList/RankListBtn/OpenIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rankListBox.openIcon = tmp


end

---@private
function DockFiltrateBox:InitGenerate__13(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/RankListBox/MsgList
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/RankListBox/MsgList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rankListBox.msgList = tmp


end

---@private
function DockFiltrateBox:InitGenerate__14(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/StarListBox
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/StarListBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.starListBox = tmp


end

---@private
function DockFiltrateBox:InitGenerate__15(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/StarListBox/StarList/StarListBtn
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/StarListBox/StarList/StarListBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.starListBox.starListBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("DockFiltrateBox_starListBtn")
			if self.starListBtn_Button_onClick then
				self:starListBtn_Button_onClick(self.starListBox.starListBtn)
			end
		end)


end

---@private
function DockFiltrateBox:InitGenerate__16(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/StarListBox/StarList/StarListBtn/OffIcon
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/StarListBox/StarList/StarListBtn/OffIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.starListBox.offIcon = tmp


end

---@private
function DockFiltrateBox:InitGenerate__17(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/StarListBox/StarList/StarListBtn/OpenIcon
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/StarListBox/StarList/StarListBtn/OpenIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.starListBox.openIcon = tmp


end

---@private
function DockFiltrateBox:InitGenerate__18(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content/StarListBox/MsgList
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content/StarListBox/MsgList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.starListBox.msgList = tmp


end

---@private
function DockFiltrateBox:InitGenerate__19(Root, data)
--[[
	BoxBg/ConfirmBtn
--]]
	local tmp = Root:Find("BoxBg/ConfirmBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.confirmBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("DockFiltrateBox_confirmBtn")
			if self.confirmBtn_ScaleButton_onClick then
				self:confirmBtn_ScaleButton_onClick(self.confirmBtn)
			end
		end)


end

---@private
function DockFiltrateBox:InitGenerate__20(Root, data)
--[[
	BoxBg/ResetBtn
--]]
	local tmp = Root:Find("BoxBg/ResetBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resetBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("DockFiltrateBox_resetBtn")
			if self.resetBtn_ScaleButton_onClick then
				self:resetBtn_ScaleButton_onClick(self.resetBtn)
			end
		end)


end

---@private
function DockFiltrateBox:InitGenerate__21(Root, data)
--[[
	BoxBg/SaveBtn
--]]
	local tmp = Root:Find("BoxBg/SaveBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.saveBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("DockFiltrateBox_saveBtn")
			if self.saveBtn_ScaleButton_onClick then
				self:saveBtn_ScaleButton_onClick(self.saveBtn)
			end
		end)


end

---@private
function DockFiltrateBox:InitGenerate__22(Root, data)
--[[
	BoxBg/SaveBtn/SaveTxt
--]]
	local tmp = Root:Find("BoxBg/SaveBtn/SaveTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.saveTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function DockFiltrateBox:InitGenerate__23(Root, data)
--[[
	Custom/ModeBtn
--]]
	local tmp = Root:Find("Custom/ModeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("DockFiltrateBox_modeBtn")
			if self.modeBtn_ScaleButton_onClick then
				self:modeBtn_ScaleButton_onClick(self.modeBtn)
			end
		end)


end

---@private
function DockFiltrateBox:InitGenerate__24(Root, data)
--[[
	Custom/ModeBtn/ModeNameTxt
--]]
	local tmp = Root:Find("Custom/ModeBtn/ModeNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.modeNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function DockFiltrateBox:InitGenerate__25(Root, data)
--[[
	Custom/ModeBtn/RankMode
--]]
	local tmp = Root:Find("Custom/ModeBtn/RankMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.rankMode = tmp


end

---@private
function DockFiltrateBox:InitGenerate__26(Root, data)
--[[
	Custom/ModeBtn/RankMode/RankIcon
--]]
	local tmp = Root:Find("Custom/ModeBtn/RankMode/RankIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.rankIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DockFiltrateBox:InitGenerate__27(Root, data)
--[[
	Custom/ModeBtn/StarMode
--]]
	local tmp = Root:Find("Custom/ModeBtn/StarMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.starMode = tmp


end

---@private
function DockFiltrateBox:InitGenerate__28(Root, data)
--[[
	Custom/ModeBtn/StarMode/StarTxt
--]]
	local tmp = Root:Find("Custom/ModeBtn/StarMode/StarTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.starTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function DockFiltrateBox:InitGenerate__29(Root, data)
--[[
	Custom/ModeBtn/StarMode/StarTxt/RankIcon/StarMsgTxt
--]]
	local tmp = Root:Find("Custom/ModeBtn/StarMode/StarTxt/RankIcon/StarMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.starMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function DockFiltrateBox:InitGenerate__30(Root, data)
--[[
	Custom/ModeBtn/IsSelect
--]]
	local tmp = Root:Find("Custom/ModeBtn/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect = tmp


end

---@private
function DockFiltrateBox:InitGenerate__31(Root, data)
--[[
	Custom/ModeBtn/IsSelect/SelectNameTxt
--]]
	local tmp = Root:Find("Custom/ModeBtn/IsSelect/SelectNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.selectNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function DockFiltrateBox:InitGenerate__32(Root, data)
--[[
	Custom/ModeBtn/IsSelect/RankMode
--]]
	local tmp = Root:Find("Custom/ModeBtn/IsSelect/RankMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect.rankMode = tmp


end

---@private
function DockFiltrateBox:InitGenerate__33(Root, data)
--[[
	Custom/ModeBtn/IsSelect/RankMode/RankIcon
--]]
	local tmp = Root:Find("Custom/ModeBtn/IsSelect/RankMode/RankIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect.rankIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DockFiltrateBox:InitGenerate__34(Root, data)
--[[
	Custom/ModeBtn/IsSelect/StarMode
--]]
	local tmp = Root:Find("Custom/ModeBtn/IsSelect/StarMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect.starMode = tmp


end

---@private
function DockFiltrateBox:InitGenerate__35(Root, data)
--[[
	Custom/ModeBtn/IsSelect/StarMode/StarTxt
--]]
	local tmp = Root:Find("Custom/ModeBtn/IsSelect/StarMode/StarTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect.starTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function DockFiltrateBox:InitGenerate__36(Root, data)
--[[
	Custom/ModeBtn/IsSelect/StarMode/StarTxt/RankIcon/StarMsgTxt
--]]
	local tmp = Root:Find("Custom/ModeBtn/IsSelect/StarMode/StarTxt/RankIcon/StarMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect.starMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function DockFiltrateBox:InitGenerate__37(Root, data)
--[[
	Custom/TypeBox
--]]
	local tmp = Root:Find("Custom/TypeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("DockFiltrateBox_typeBox")
			if self.typeBox_ScaleButton_onClick then
				self:typeBox_ScaleButton_onClick(self.typeBox)
			end
		end)


end

---@private
function DockFiltrateBox:InitGenerate__38(Root, data)
--[[
	Custom/TypeBox/TypeIconOff
--]]
	local tmp = Root:Find("Custom/TypeBox/TypeIconOff").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBox.typeIconOff = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DockFiltrateBox:InitGenerate__39(Root, data)
--[[
	Custom/TypeBox/TypeIcon
--]]
	local tmp = Root:Find("Custom/TypeBox/TypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBox.typeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DockFiltrateBox:InitGenerate__40(Root, data)
--[[
	Custom/TypeBox/TypeName
--]]
	local tmp = Root:Find("Custom/TypeBox/TypeName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBox.typeName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function DockFiltrateBox:SetLocalizedText(Root)

    local locObj_DockFiltrateBox_TitleNameSTxt = Root:Find("BoxBg/TitleNameBg/TitleNameSTxt")
    if locObj_DockFiltrateBox_TitleNameSTxt then
        locObj_DockFiltrateBox_TitleNameSTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.DockFiltrateBox_TitleNameSTxt
    end

    local locObj_DockFiltrateBox_TitleNameTxt = Root:Find("BoxBg/TitleNameBg/TitleNameTxt")
    if locObj_DockFiltrateBox_TitleNameTxt then
        locObj_DockFiltrateBox_TitleNameTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.DockFiltrateBox_TitleNameTxt
    end

    local locObj_DockFiltrateBox_GrounpName = Root:Find("BoxBg/Scroll View/Viewport/Content/TypeListBox/TypeList/TypeListBtn/GrounpName")
    if locObj_DockFiltrateBox_GrounpName then
        locObj_DockFiltrateBox_GrounpName.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.DockFiltrateBox_GrounpName
    end

    local locObj_DockFiltrateBox_Rn_GrounpName = Root:Find("BoxBg/Scroll View/Viewport/Content/RankListBox/RankList/RankListBtn/GrounpName")
    if locObj_DockFiltrateBox_Rn_GrounpName then
        locObj_DockFiltrateBox_Rn_GrounpName.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.DockFiltrateBox_Rn_GrounpName
    end

    local locObj_DockFiltrateBox_Sn_GrounpName = Root:Find("BoxBg/Scroll View/Viewport/Content/StarListBox/StarList/StarListBtn/GrounpName")
    if locObj_DockFiltrateBox_Sn_GrounpName then
        locObj_DockFiltrateBox_Sn_GrounpName.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.DockFiltrateBox_Sn_GrounpName
    end

    local locObj_DockFiltrateBox_txt = Root:Find("BoxBg/ConfirmBtn/txt")
    if locObj_DockFiltrateBox_txt then
        locObj_DockFiltrateBox_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.DockFiltrateBox_txt
    end

    local locObj_DockFiltrateBox_Rn_txt = Root:Find("BoxBg/ResetBtn/txt")
    if locObj_DockFiltrateBox_Rn_txt then
        locObj_DockFiltrateBox_Rn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.DockFiltrateBox_Rn_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return DockFiltrateBox