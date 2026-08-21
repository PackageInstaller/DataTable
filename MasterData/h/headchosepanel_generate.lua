---@class HeadChosePanel_Generate_headBox_headIconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup

---@class HeadChosePanel_Generate_headBox_btn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class HeadChosePanel_Generate_headBox
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public btn HeadChosePanel_Generate_headBox_btn
---@field public headIconImg HeadChosePanel_Generate_headBox_headIconImg
---@field public isLock UnityEngine.GameObject
---@field public isSelect UnityEngine.GameObject
---@field public isEquip UnityEngine.GameObject

---@class HeadChosePanel_Generate_headList
---@field public gameObject UnityEngine.GameObject
---@field public loopGridView SuperScrollView.LoopGridView

---@class HeadChosePanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HeadChosePanel_Generate_getMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HeadChosePanel_Generate_headNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HeadChosePanel_Generate_nowHeadBox_headIconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup

---@class HeadChosePanel_Generate_nowHeadBox
---@field public gameObject UnityEngine.GameObject
---@field public headIconImg HeadChosePanel_Generate_nowHeadBox_headIconImg

---@class HeadChosePanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HeadChosePanel_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HeadChosePanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class HeadChosePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask HeadChosePanel_Generate_mask
---@field public titleText HeadChosePanel_Generate_titleText
---@field public closeBtn HeadChosePanel_Generate_closeBtn
---@field public nowHeadBox HeadChosePanel_Generate_nowHeadBox
---@field public headNameTxt HeadChosePanel_Generate_headNameTxt
---@field public getMsgTxt HeadChosePanel_Generate_getMsgTxt
---@field public okBtn HeadChosePanel_Generate_okBtn
---@field public headList HeadChosePanel_Generate_headList
---@field public content UnityEngine.GameObject
---@field public headBox HeadChosePanel_Generate_headBox
local HeadChosePanel = class("HeadChosePanel", require("WndBase"))

function HeadChosePanel:ctor(data)
end

---@private
function HeadChosePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("HeadChosePanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function HeadChosePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function HeadChosePanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("HeadChosePanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function HeadChosePanel:InitGenerate__3(Root, data)
--[[
	BoxBg/TitleSideBg/Titlebg/TitleText
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HeadChosePanel:InitGenerate__4(Root, data)
--[[
	BoxBg/TitleSideBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HeadChosePanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function HeadChosePanel:InitGenerate__5(Root, data)
--[[
	BoxBg/NowHeadBox
--]]
	local tmp = Root:Find("BoxBg/NowHeadBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowHeadBox = tmp


end

---@private
function HeadChosePanel:InitGenerate__6(Root, data)
--[[
	BoxBg/NowHeadBox/mask/HeadIconImg
--]]
	local tmp = Root:Find("BoxBg/NowHeadBox/mask/HeadIconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowHeadBox.headIconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function HeadChosePanel:InitGenerate__7(Root, data)
--[[
	BoxBg/HeadNameTxt
--]]
	local tmp = Root:Find("BoxBg/HeadNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HeadChosePanel:InitGenerate__8(Root, data)
--[[
	BoxBg/GetMsgTxt
--]]
	local tmp = Root:Find("BoxBg/GetMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.getMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HeadChosePanel:InitGenerate__9(Root, data)
--[[
	BoxBg/OkBtn
--]]
	local tmp = Root:Find("BoxBg/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HeadChosePanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function HeadChosePanel:InitGenerate__10(Root, data)
--[[
	BoxBg/HeadListBg/HeadList
--]]
	local tmp = Root:Find("BoxBg/HeadListBg/HeadList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headList = tmp

	tmp.loopGridView = tmp:GetComponent(TypeInfo.LoopGridView)


end

---@private
function HeadChosePanel:InitGenerate__11(Root, data)
--[[
	BoxBg/HeadListBg/HeadList/Viewport/Content
--]]
	local tmp = Root:Find("BoxBg/HeadListBg/HeadList/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp


end

---@private
function HeadChosePanel:InitGenerate__12(Root, data)
--[[
	BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox
--]]
	local tmp = Root:Find("BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headBox = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HeadChosePanel:InitGenerate__13(Root, data)
--[[
	BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox/Btn
--]]
	local tmp = Root:Find("BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox/Btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headBox.btn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function HeadChosePanel:InitGenerate__14(Root, data)
--[[
	BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox/Btn/Mask/HeadIconImg
--]]
	local tmp = Root:Find("BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox/Btn/Mask/HeadIconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headBox.headIconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function HeadChosePanel:InitGenerate__15(Root, data)
--[[
	BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox/Btn/IsLock
--]]
	local tmp = Root:Find("BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox/Btn/IsLock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headBox.isLock = tmp


end

---@private
function HeadChosePanel:InitGenerate__16(Root, data)
--[[
	BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox/Btn/IsSelect
--]]
	local tmp = Root:Find("BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox/Btn/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headBox.isSelect = tmp


end

---@private
function HeadChosePanel:InitGenerate__17(Root, data)
--[[
	BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox/Btn/IsEquip
--]]
	local tmp = Root:Find("BoxBg/HeadListBg/HeadList/Viewport/Content/HeadBox/Btn/IsEquip").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headBox.isEquip = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function HeadChosePanel:SetLocalizedText(Root)

    local locObj_HeadChosePanel_TitleText2 = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText2")
    if locObj_HeadChosePanel_TitleText2 then
        locObj_HeadChosePanel_TitleText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HeadChosePanel_TitleText2
    end

    local locObj_HeadChosePanel_txt = Root:Find("BoxBg/Line/txt")
    if locObj_HeadChosePanel_txt then
        locObj_HeadChosePanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HeadChosePanel_txt
    end

    local locObj_HeadChosePanel_On_txt = Root:Find("BoxBg/OkBtn/txt")
    if locObj_HeadChosePanel_On_txt then
        locObj_HeadChosePanel_On_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HeadChosePanel_On_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return HeadChosePanel