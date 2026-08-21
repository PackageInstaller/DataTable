---@class ActivityCommonShopPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class ActivityCommonShopPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class ActivityCommonShopPanel_Generate_toggleBtn_name2
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommonShopPanel_Generate_toggleBtn_name1
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommonShopPanel_Generate_toggleBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public name1 ActivityCommonShopPanel_Generate_toggleBtn_name1
---@field public isOn UnityEngine.GameObject
---@field public name2 ActivityCommonShopPanel_Generate_toggleBtn_name2
---@field public redPoint UnityEngine.GameObject

---@class ActivityCommonShopPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class ActivityCommonShopPanel_Generate_commonShopBox_picText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommonShopPanel_Generate_commonShopBox_picIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivityCommonShopPanel_Generate_commonShopBox_taskName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommonShopPanel_Generate_commonShopBox_limitText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommonShopPanel_Generate_commonShopBox_numText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommonShopPanel_Generate_commonShopBox_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivityCommonShopPanel_Generate_commonShopBox_quaityImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivityCommonShopPanel_Generate_commonShopBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public quaityImg ActivityCommonShopPanel_Generate_commonShopBox_quaityImg
---@field public iconImg ActivityCommonShopPanel_Generate_commonShopBox_iconImg
---@field public numText ActivityCommonShopPanel_Generate_commonShopBox_numText
---@field public limitTip UnityEngine.GameObject
---@field public limitText ActivityCommonShopPanel_Generate_commonShopBox_limitText
---@field public taskName ActivityCommonShopPanel_Generate_commonShopBox_taskName
---@field public priceBg UnityEngine.GameObject
---@field public picIcon ActivityCommonShopPanel_Generate_commonShopBox_picIcon
---@field public picText ActivityCommonShopPanel_Generate_commonShopBox_picText
---@field public selloutView UnityEngine.GameObject
---@field public mask UnityEngine.GameObject

---@class ActivityCommonShopPanel_Generate_shopLoopList
---@field public gameObject UnityEngine.GameObject
---@field public loopGridView SuperScrollView.LoopGridView

---@class ActivityCommonShopPanel_Generate_imgBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ActivityCommonShopPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public imgBg ActivityCommonShopPanel_Generate_imgBg
---@field public toggleList UnityEngine.GameObject
---@field public shopLoopList ActivityCommonShopPanel_Generate_shopLoopList
---@field public commonShopBox ActivityCommonShopPanel_Generate_commonShopBox
---@field public customBox ActivityCommonShopPanel_Generate_customBox
---@field public toggleBtn ActivityCommonShopPanel_Generate_toggleBtn
---@field public customBackPanel ActivityCommonShopPanel_Generate_customBackPanel
---@field public customMsgPanel ActivityCommonShopPanel_Generate_customMsgPanel
local ActivityCommonShopPanel = class("ActivityCommonShopPanel", require("WndBase"))

function ActivityCommonShopPanel:ctor(data)
end

---@private
function ActivityCommonShopPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ActivityCommonShopPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ActivityCommonShopPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ActivityCommonShopPanel:InitGenerate__2(Root, data)
--[[
	ImgBg
--]]
	local tmp = Root:Find("ImgBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.imgBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ActivityCommonShopPanel:InitGenerate__3(Root, data)
--[[
	ToggleList
--]]
	local tmp = Root:Find("ToggleList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleList = tmp


end

---@private
function ActivityCommonShopPanel:InitGenerate__4(Root, data)
--[[
	ShopLoopList
--]]
	local tmp = Root:Find("ShopLoopList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopLoopList = tmp

	tmp.loopGridView = tmp:GetComponent(TypeInfo.LoopGridView)


end

---@private
function ActivityCommonShopPanel:InitGenerate__5(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityCommonShopPanel_commonShopBox")
			if self.commonShopBox_ScaleButton_onClick then
				self:commonShopBox_ScaleButton_onClick(self.commonShopBox)
			end
		end)


end

---@private
function ActivityCommonShopPanel:InitGenerate__6(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/QuaityImg
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/QuaityImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.quaityImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivityCommonShopPanel:InitGenerate__7(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/IconImg
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/IconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivityCommonShopPanel:InitGenerate__8(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/NumText
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/NumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommonShopPanel:InitGenerate__9(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/LimitTip
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/LimitTip").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.limitTip = tmp


end

---@private
function ActivityCommonShopPanel:InitGenerate__10(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/LimitText
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/LimitText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.limitText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommonShopPanel:InitGenerate__11(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/TaskName
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/TaskName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.taskName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommonShopPanel:InitGenerate__12(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/PriceBg
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/PriceBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.priceBg = tmp


end

---@private
function ActivityCommonShopPanel:InitGenerate__13(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/PriceBg/PicIcon
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/PriceBg/PicIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.picIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivityCommonShopPanel:InitGenerate__14(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/PriceBg/PicText
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/PriceBg/PicText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.picText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommonShopPanel:InitGenerate__15(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/SelloutView
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/SelloutView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.selloutView = tmp


end

---@private
function ActivityCommonShopPanel:InitGenerate__16(Root, data)
--[[
	ShopLoopList/Viewport/Content/CommonShopBox/SelloutView/Mask
--]]
	local tmp = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/SelloutView/Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonShopBox.mask = tmp


end

---@private
function ActivityCommonShopPanel:InitGenerate__17(Root, data)
--[[
	Custom/CustomBox
--]]
	local tmp = Root:Find("Custom/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function ActivityCommonShopPanel:InitGenerate__18(Root, data)
--[[
	Custom/ToggleBtn
--]]
	local tmp = Root:Find("Custom/ToggleBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityCommonShopPanel_toggleBtn")
			if self.toggleBtn_ScaleButton_onClick then
				self:toggleBtn_ScaleButton_onClick(self.toggleBtn)
			end
		end)


end

---@private
function ActivityCommonShopPanel:InitGenerate__19(Root, data)
--[[
	Custom/ToggleBtn/Name1
--]]
	local tmp = Root:Find("Custom/ToggleBtn/Name1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBtn.name1 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommonShopPanel:InitGenerate__20(Root, data)
--[[
	Custom/ToggleBtn/IsOn
--]]
	local tmp = Root:Find("Custom/ToggleBtn/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBtn.isOn = tmp


end

---@private
function ActivityCommonShopPanel:InitGenerate__21(Root, data)
--[[
	Custom/ToggleBtn/IsOn/Name2
--]]
	local tmp = Root:Find("Custom/ToggleBtn/IsOn/Name2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBtn.name2 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommonShopPanel:InitGenerate__22(Root, data)
--[[
	Custom/ToggleBtn/RedPoint
--]]
	local tmp = Root:Find("Custom/ToggleBtn/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBtn.redPoint = tmp


end

---@private
function ActivityCommonShopPanel:InitGenerate__23(Root, data)
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

---@private
function ActivityCommonShopPanel:InitGenerate__24(Root, data)
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

function ActivityCommonShopPanel:SetLocalizedText(Root)

    local locObj_ActivityCommonShopPanel_LimitTip = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/LimitTip")
    if locObj_ActivityCommonShopPanel_LimitTip then
        locObj_ActivityCommonShopPanel_LimitTip.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityCommonShopPanel_LimitTip
    end

    local locObj_ActivityCommonShopPanel_Text = Root:Find("ShopLoopList/Viewport/Content/CommonShopBox/SelloutView/Text")
    if locObj_ActivityCommonShopPanel_Text then
        locObj_ActivityCommonShopPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityCommonShopPanel_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ActivityCommonShopPanel