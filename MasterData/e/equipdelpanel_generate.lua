---@class EquipDelPanel_Generate_attributeBox
---@field public gameObject UnityEngine.GameObject
---@field public attributeBox AttributeBox

---@class EquipDelPanel_Generate_sortTypeBtn_sortTypeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipDelPanel_Generate_sortTypeBtn_sortTypeTxtOff
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipDelPanel_Generate_sortTypeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public sortTypeTxtOff EquipDelPanel_Generate_sortTypeBtn_sortTypeTxtOff
---@field public natureList UnityEngine.GameObject
---@field public isOpen UnityEngine.GameObject
---@field public isEx UnityEngine.GameObject
---@field public sortTypeTxt EquipDelPanel_Generate_sortTypeBtn_sortTypeTxt

---@class EquipDelPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class EquipDelPanel_Generate_delEquipItem
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class EquipDelPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class EquipDelPanel_Generate_likeFiltrateBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public isOn UnityEngine.GameObject

---@class EquipDelPanel_Generate_filtrateBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class EquipDelPanel_Generate_sortStateBtn_downImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class EquipDelPanel_Generate_sortStateBtn_downBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class EquipDelPanel_Generate_sortStateBtn_upImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class EquipDelPanel_Generate_sortStateBtn_upBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class EquipDelPanel_Generate_sortStateBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public upBg EquipDelPanel_Generate_sortStateBtn_upBg
---@field public upImg EquipDelPanel_Generate_sortStateBtn_upImg
---@field public downBg EquipDelPanel_Generate_sortStateBtn_downBg
---@field public downImg EquipDelPanel_Generate_sortStateBtn_downImg

---@class EquipDelPanel_Generate_sortTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipDelPanel_Generate_sortBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class EquipDelPanel_Generate_delOkBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class EquipDelPanel_Generate_levelUpText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipDelPanel_Generate_delOkBtn_1
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class EquipDelPanel_Generate_selectCountTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipDelPanel_Generate_delEquip
---@field public gameObject UnityEngine.GameObject
---@field public scrollRect UnityEngine.UI.ScrollRect
---@field public loopGridView SuperScrollView.LoopGridView

---@class EquipDelPanel_Generate_emptyPanel
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup

---@class EquipDelPanel_Generate_customTips
---@field public gameObject UnityEngine.GameObject
---@field public customTips CustomTips

---@class EquipDelPanel_Generate_sortMask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EquipDelPanel_Generate_fastSelectBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class EquipDelPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public fastSelectBtn EquipDelPanel_Generate_fastSelectBtn
---@field public sortMask EquipDelPanel_Generate_sortMask
---@field public customTips EquipDelPanel_Generate_customTips
---@field public emptyPanel EquipDelPanel_Generate_emptyPanel
---@field public delEquip EquipDelPanel_Generate_delEquip
---@field public selectCountTxt EquipDelPanel_Generate_selectCountTxt
---@field public canGetList UnityEngine.GameObject
---@field public delOkBtn_1 EquipDelPanel_Generate_delOkBtn_1
---@field public levelUpText EquipDelPanel_Generate_levelUpText
---@field public delOkBtn EquipDelPanel_Generate_delOkBtn
---@field public customSortBox UnityEngine.GameObject
---@field public sortBtn EquipDelPanel_Generate_sortBtn
---@field public sortTxt EquipDelPanel_Generate_sortTxt
---@field public sortStateBtn EquipDelPanel_Generate_sortStateBtn
---@field public filtrateBtn EquipDelPanel_Generate_filtrateBtn
---@field public likeFiltrateBtn EquipDelPanel_Generate_likeFiltrateBtn
---@field public sortSelectList UnityEngine.GameObject
---@field public customBackPanel EquipDelPanel_Generate_customBackPanel
---@field public delEquipItem EquipDelPanel_Generate_delEquipItem
---@field public customBox EquipDelPanel_Generate_customBox
---@field public sortTypeBtn EquipDelPanel_Generate_sortTypeBtn
---@field public attributeBox EquipDelPanel_Generate_attributeBox
local EquipDelPanel = class("EquipDelPanel", require("WndBase"))

function EquipDelPanel:ctor(data)
end

---@private
function EquipDelPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("EquipDelPanel")

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
function EquipDelPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function EquipDelPanel:InitGenerate__2(Root, data)
--[[
	FastSelectBtn
--]]
	local tmp = Root:Find("FastSelectBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.fastSelectBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelPanel_fastSelectBtn")
			if self.fastSelectBtn_ScaleButton_onClick then
				self:fastSelectBtn_ScaleButton_onClick(self.fastSelectBtn)
			end
		end)


end

---@private
function EquipDelPanel:InitGenerate__3(Root, data)
--[[
	SortMask
--]]
	local tmp = Root:Find("SortMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortMask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelPanel_sortMask")
			if self.sortMask_Button_onClick then
				self:sortMask_Button_onClick(self.sortMask)
			end
		end)


end

---@private
function EquipDelPanel:InitGenerate__4(Root, data)
--[[
	AdjustRoot/CustomTips
--]]
	local tmp = Root:Find("AdjustRoot/CustomTips").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customTips = tmp

	tmp.customTips = tmp:AddComponentLua("CustomTips", data)


end

---@private
function EquipDelPanel:InitGenerate__5(Root, data)
--[[
	AdjustRoot/EmptyPanel
--]]
	local tmp = Root:Find("AdjustRoot/EmptyPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.emptyPanel = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function EquipDelPanel:InitGenerate__6(Root, data)
--[[
	AdjustRoot/DelEquip
--]]
	local tmp = Root:Find("AdjustRoot/DelEquip").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.delEquip = tmp

	tmp.scrollRect = tmp:GetComponent(TypeInfo.ScrollRect)

	tmp.loopGridView = tmp:GetComponent(TypeInfo.LoopGridView)


end

---@private
function EquipDelPanel:InitGenerate__7(Root, data)
--[[
	AdjustRoot/CanGetPanel/SelectCountTxt
--]]
	local tmp = Root:Find("AdjustRoot/CanGetPanel/SelectCountTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selectCountTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipDelPanel:InitGenerate__8(Root, data)
--[[
	AdjustRoot/CanGetPanel/Scroll View/Viewport/CanGetList
--]]
	local tmp = Root:Find("AdjustRoot/CanGetPanel/Scroll View/Viewport/CanGetList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.canGetList = tmp


end

---@private
function EquipDelPanel:InitGenerate__9(Root, data)
--[[
	AdjustRoot/DelOkBtn_1
--]]
	local tmp = Root:Find("AdjustRoot/DelOkBtn_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.delOkBtn_1 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelPanel_delOkBtn_1")
			if self.delOkBtn_1_ScaleButton_onClick then
				self:delOkBtn_1_ScaleButton_onClick(self.delOkBtn_1)
			end
		end)


end

---@private
function EquipDelPanel:InitGenerate__10(Root, data)
--[[
	AdjustRoot/DelOkBtn_1/levelUpText
--]]
	local tmp = Root:Find("AdjustRoot/DelOkBtn_1/levelUpText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelUpText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipDelPanel:InitGenerate__11(Root, data)
--[[
	AdjustRoot/DelOkBtn
--]]
	local tmp = Root:Find("AdjustRoot/DelOkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.delOkBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelPanel_delOkBtn")
			if self.delOkBtn_ScaleButton_onClick then
				self:delOkBtn_ScaleButton_onClick(self.delOkBtn)
			end
		end)


end

---@private
function EquipDelPanel:InitGenerate__12(Root, data)
--[[
	AdjustRoot/CustomSortBox
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customSortBox = tmp


end

---@private
function EquipDelPanel:InitGenerate__13(Root, data)
--[[
	AdjustRoot/CustomSortBox/SortBg/SortBtn
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/SortBg/SortBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelPanel_sortBtn")
			if self.sortBtn_ScaleButton_onClick then
				self:sortBtn_ScaleButton_onClick(self.sortBtn)
			end
		end)


end

---@private
function EquipDelPanel:InitGenerate__14(Root, data)
--[[
	AdjustRoot/CustomSortBox/SortBg/SortBtn/SortTxt
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/SortBg/SortBtn/SortTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipDelPanel:InitGenerate__15(Root, data)
--[[
	AdjustRoot/CustomSortBox/SortBg/SortStateBtn
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/SortBg/SortStateBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortStateBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelPanel_sortStateBtn")
			if self.sortStateBtn_ScaleButton_onClick then
				self:sortStateBtn_ScaleButton_onClick(self.sortStateBtn)
			end
		end)


end

---@private
function EquipDelPanel:InitGenerate__16(Root, data)
--[[
	AdjustRoot/CustomSortBox/SortBg/SortStateBtn/UpBg
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/SortBg/SortStateBtn/UpBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortStateBtn.upBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function EquipDelPanel:InitGenerate__17(Root, data)
--[[
	AdjustRoot/CustomSortBox/SortBg/SortStateBtn/UpBg/UpImg
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/SortBg/SortStateBtn/UpBg/UpImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortStateBtn.upImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function EquipDelPanel:InitGenerate__18(Root, data)
--[[
	AdjustRoot/CustomSortBox/SortBg/SortStateBtn/DownBg
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/SortBg/SortStateBtn/DownBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortStateBtn.downBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function EquipDelPanel:InitGenerate__19(Root, data)
--[[
	AdjustRoot/CustomSortBox/SortBg/SortStateBtn/DownBg/DownImg
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/SortBg/SortStateBtn/DownBg/DownImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortStateBtn.downImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function EquipDelPanel:InitGenerate__20(Root, data)
--[[
	AdjustRoot/CustomSortBox/FiltrateBtn
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/FiltrateBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.filtrateBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelPanel_filtrateBtn")
			if self.filtrateBtn_ScaleButton_onClick then
				self:filtrateBtn_ScaleButton_onClick(self.filtrateBtn)
			end
		end)


end

---@private
function EquipDelPanel:InitGenerate__21(Root, data)
--[[
	AdjustRoot/CustomSortBox/LikeFiltrateBtn
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/LikeFiltrateBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.likeFiltrateBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelPanel_likeFiltrateBtn")
			if self.likeFiltrateBtn_ScaleButton_onClick then
				self:likeFiltrateBtn_ScaleButton_onClick(self.likeFiltrateBtn)
			end
		end)


end

---@private
function EquipDelPanel:InitGenerate__22(Root, data)
--[[
	AdjustRoot/CustomSortBox/LikeFiltrateBtn/IsOn
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/LikeFiltrateBtn/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.likeFiltrateBtn.isOn = tmp


end

---@private
function EquipDelPanel:InitGenerate__23(Root, data)
--[[
	AdjustRoot/CustomSortBox/SortSelectList
--]]
	local tmp = Root:Find("AdjustRoot/CustomSortBox/SortSelectList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortSelectList = tmp


end

---@private
function EquipDelPanel:InitGenerate__24(Root, data)
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
function EquipDelPanel:InitGenerate__25(Root, data)
--[[
	Custom/DelEquipItem
--]]
	local tmp = Root:Find("Custom/DelEquipItem").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.delEquipItem = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function EquipDelPanel:InitGenerate__26(Root, data)
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
function EquipDelPanel:InitGenerate__27(Root, data)
--[[
	Custom/SortTypeBtn
--]]
	local tmp = Root:Find("Custom/SortTypeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortTypeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelPanel_sortTypeBtn")
			if self.sortTypeBtn_ScaleButton_onClick then
				self:sortTypeBtn_ScaleButton_onClick(self.sortTypeBtn)
			end
		end)


end

---@private
function EquipDelPanel:InitGenerate__28(Root, data)
--[[
	Custom/SortTypeBtn/SortTypeTxtOff
--]]
	local tmp = Root:Find("Custom/SortTypeBtn/SortTypeTxtOff").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortTypeBtn.sortTypeTxtOff = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipDelPanel:InitGenerate__29(Root, data)
--[[
	Custom/SortTypeBtn/NatureList
--]]
	local tmp = Root:Find("Custom/SortTypeBtn/NatureList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortTypeBtn.natureList = tmp


end

---@private
function EquipDelPanel:InitGenerate__30(Root, data)
--[[
	Custom/SortTypeBtn/isOpen
--]]
	local tmp = Root:Find("Custom/SortTypeBtn/isOpen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortTypeBtn.isOpen = tmp


end

---@private
function EquipDelPanel:InitGenerate__31(Root, data)
--[[
	Custom/SortTypeBtn/isOpen/isEx
--]]
	local tmp = Root:Find("Custom/SortTypeBtn/isOpen/isEx").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortTypeBtn.isEx = tmp


end

---@private
function EquipDelPanel:InitGenerate__32(Root, data)
--[[
	Custom/SortTypeBtn/isOpen/SortTypeTxt
--]]
	local tmp = Root:Find("Custom/SortTypeBtn/isOpen/SortTypeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sortTypeBtn.sortTypeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipDelPanel:InitGenerate__33(Root, data)
--[[
	Custom/AttributeBox
--]]
	local tmp = Root:Find("Custom/AttributeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.attributeBox = tmp

	tmp.attributeBox = tmp:AddComponentLua("AttributeBox", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function EquipDelPanel:SetLocalizedText(Root)

    local locObj_EquipDelPanel_Fn_TextTMP = Root:Find("FastSelectBtn/Text (TMP)")
    if locObj_EquipDelPanel_Fn_TextTMP then
        locObj_EquipDelPanel_Fn_TextTMP.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.EquipDelPanel_Fn_TextTMP
    end

    local locObj_EquipDelPanel_NameTxt = Root:Find("AdjustRoot/EmptyPanel/NameTxt")
    if locObj_EquipDelPanel_NameTxt then
        locObj_EquipDelPanel_NameTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.EquipDelPanel_NameTxt
    end

    local locObj_EquipDelPanel_TitleTxt = Root:Find("AdjustRoot/CanGetPanel/TitleBox/TitleTxt")
    if locObj_EquipDelPanel_TitleTxt then
        locObj_EquipDelPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.EquipDelPanel_TitleTxt
    end

    local locObj_EquipDelPanel_TextTMP = Root:Find("AdjustRoot/CanGetPanel/Text (TMP)")
    if locObj_EquipDelPanel_TextTMP then
        locObj_EquipDelPanel_TextTMP.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.EquipDelPanel_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return EquipDelPanel