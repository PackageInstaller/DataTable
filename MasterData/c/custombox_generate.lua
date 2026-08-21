---@class CustomBox_Generate_showEf
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class CustomBox_Generate_isGetMark
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class CustomBox_Generate_itemNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CustomBox_Generate_tipsTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CustomBox_Generate_isFrist
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CustomBox_Generate_roleIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CustomBox_Generate_star_6
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class CustomBox_Generate_star_5
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class CustomBox_Generate_star_4
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class CustomBox_Generate_star_3
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class CustomBox_Generate_star_2
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class CustomBox_Generate_star_1
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class CustomBox_Generate_delBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CustomBox_Generate_isIn_inCountTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CustomBox_Generate_isIn
---@field public gameObject UnityEngine.GameObject
---@field public isOne UnityEngine.GameObject
---@field public inCountTxt CustomBox_Generate_isIn_inCountTxt

---@class CustomBox_Generate_typeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CustomBox_Generate_itemNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CustomBox_Generate_rangeImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CustomBox_Generate_charIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CustomBox_Generate_itemIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CustomBox_Generate_rankBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class CustomBox_Generate_equipBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public clickLongPressListener ClickLongPressListener

---@class CustomBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public equipBtn CustomBox_Generate_equipBtn
---@field public nullDataPanel UnityEngine.GameObject
---@field public nullReward UnityEngine.GameObject
---@field public nullTaskItem UnityEngine.GameObject
---@field public nullDelItem UnityEngine.GameObject
---@field public hasDataPanel UnityEngine.GameObject
---@field public rankBg CustomBox_Generate_rankBg
---@field public itemIcon CustomBox_Generate_itemIcon
---@field public charIcon CustomBox_Generate_charIcon
---@field public rangeImg CustomBox_Generate_rangeImg
---@field public countObj UnityEngine.GameObject
---@field public itemNum CustomBox_Generate_itemNum
---@field public typeIcon CustomBox_Generate_typeIcon
---@field public isIn CustomBox_Generate_isIn
---@field public delBtn CustomBox_Generate_delBtn
---@field public isSelect UnityEngine.GameObject
---@field public starList UnityEngine.GameObject
---@field public star_1 CustomBox_Generate_star_1
---@field public star_2 CustomBox_Generate_star_2
---@field public star_3 CustomBox_Generate_star_3
---@field public star_4 CustomBox_Generate_star_4
---@field public star_5 CustomBox_Generate_star_5
---@field public star_6 CustomBox_Generate_star_6
---@field public commonMask UnityEngine.GameObject
---@field public isEquipIn UnityEngine.GameObject
---@field public roleBg UnityEngine.GameObject
---@field public roleIcon CustomBox_Generate_roleIcon
---@field public isLock UnityEngine.GameObject
---@field public isLock2 UnityEngine.GameObject
---@field public isSp UnityEngine.GameObject
---@field public isFrist CustomBox_Generate_isFrist
---@field public tipsTxt CustomBox_Generate_tipsTxt
---@field public itemNameTxt CustomBox_Generate_itemNameTxt
---@field public isGet UnityEngine.GameObject
---@field public isGetMark CustomBox_Generate_isGetMark
---@field public overLoad UnityEngine.GameObject
---@field public redPoint UnityEngine.GameObject
---@field public equipInsufficient UnityEngine.GameObject
---@field public new UnityEngine.GameObject
---@field public showEf CustomBox_Generate_showEf
local CustomBox = class("CustomBox", require("CommonBase"))

function CustomBox:ctor(data)
end

---@private
function CustomBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("CustomBox")

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
	self:InitGenerate__41(Root,data)
	self:InitGenerate__42(Root,data)
	self:InitGenerate__43(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function CustomBox:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)


end

---@private
function CustomBox:InitGenerate__2(Root, data)
--[[
	EquipBtn
--]]
	local tmp = Root:Find("EquipBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.equipBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.clickLongPressListener = tmp:GetComponent(TypeInfo.ClickLongPressListener)


end

---@private
function CustomBox:InitGenerate__3(Root, data)
--[[
	EquipBtn/NullDataPanel
--]]
	local tmp = Root:Find("EquipBtn/NullDataPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nullDataPanel = tmp


end

---@private
function CustomBox:InitGenerate__4(Root, data)
--[[
	EquipBtn/NullReward
--]]
	local tmp = Root:Find("EquipBtn/NullReward").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nullReward = tmp


end

---@private
function CustomBox:InitGenerate__5(Root, data)
--[[
	EquipBtn/NullTaskItem
--]]
	local tmp = Root:Find("EquipBtn/NullTaskItem").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nullTaskItem = tmp


end

---@private
function CustomBox:InitGenerate__6(Root, data)
--[[
	EquipBtn/NullDelItem
--]]
	local tmp = Root:Find("EquipBtn/NullDelItem").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nullDelItem = tmp


end

---@private
function CustomBox:InitGenerate__7(Root, data)
--[[
	EquipBtn/HasDataPanel
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.hasDataPanel = tmp


end

---@private
function CustomBox:InitGenerate__8(Root, data)
--[[
	EquipBtn/HasDataPanel/RankBg
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/RankBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rankBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CustomBox:InitGenerate__9(Root, data)
--[[
	EquipBtn/HasDataPanel/ItemIcon
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/ItemIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CustomBox:InitGenerate__10(Root, data)
--[[
	EquipBtn/HasDataPanel/charIcon
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/charIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.charIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CustomBox:InitGenerate__11(Root, data)
--[[
	EquipBtn/HasDataPanel/RangeImg
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/RangeImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangeImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CustomBox:InitGenerate__12(Root, data)
--[[
	EquipBtn/HasDataPanel/CountObj
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/CountObj").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.countObj = tmp


end

---@private
function CustomBox:InitGenerate__13(Root, data)
--[[
	EquipBtn/HasDataPanel/CountObj/ItemNum
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/CountObj/ItemNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CustomBox:InitGenerate__14(Root, data)
--[[
	EquipBtn/HasDataPanel/TypeIcon
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/TypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CustomBox:InitGenerate__15(Root, data)
--[[
	EquipBtn/HasDataPanel/IsIn
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsIn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isIn = tmp


end

---@private
function CustomBox:InitGenerate__16(Root, data)
--[[
	EquipBtn/HasDataPanel/IsIn/IsOne
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsIn/IsOne").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isIn.isOne = tmp


end

---@private
function CustomBox:InitGenerate__17(Root, data)
--[[
	EquipBtn/HasDataPanel/IsIn/InCountTxt
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsIn/InCountTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isIn.inCountTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CustomBox:InitGenerate__18(Root, data)
--[[
	EquipBtn/HasDataPanel/DelBtn
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/DelBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.delBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function CustomBox:InitGenerate__19(Root, data)
--[[
	EquipBtn/HasDataPanel/IsSelect
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isSelect = tmp


end

---@private
function CustomBox:InitGenerate__20(Root, data)
--[[
	EquipBtn/HasDataPanel/StarList
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/StarList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.starList = tmp


end

---@private
function CustomBox:InitGenerate__21(Root, data)
--[[
	EquipBtn/HasDataPanel/StarList/Star_1
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/StarList/Star_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.star_1 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function CustomBox:InitGenerate__22(Root, data)
--[[
	EquipBtn/HasDataPanel/StarList/Star_2
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/StarList/Star_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.star_2 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function CustomBox:InitGenerate__23(Root, data)
--[[
	EquipBtn/HasDataPanel/StarList/Star_3
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/StarList/Star_3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.star_3 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function CustomBox:InitGenerate__24(Root, data)
--[[
	EquipBtn/HasDataPanel/StarList/Star_4
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/StarList/Star_4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.star_4 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function CustomBox:InitGenerate__25(Root, data)
--[[
	EquipBtn/HasDataPanel/StarList/Star_5
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/StarList/Star_5").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.star_5 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function CustomBox:InitGenerate__26(Root, data)
--[[
	EquipBtn/HasDataPanel/StarList/Star_6
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/StarList/Star_6").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.star_6 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function CustomBox:InitGenerate__27(Root, data)
--[[
	EquipBtn/HasDataPanel/CommonMask
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/CommonMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonMask = tmp


end

---@private
function CustomBox:InitGenerate__28(Root, data)
--[[
	EquipBtn/HasDataPanel/IsEquipIn
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsEquipIn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isEquipIn = tmp


end

---@private
function CustomBox:InitGenerate__29(Root, data)
--[[
	EquipBtn/HasDataPanel/IsEquipIn/RoleBg
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsEquipIn/RoleBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBg = tmp


end

---@private
function CustomBox:InitGenerate__30(Root, data)
--[[
	EquipBtn/HasDataPanel/IsEquipIn/RoleBg/mask/RoleIcon
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsEquipIn/RoleBg/mask/RoleIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CustomBox:InitGenerate__31(Root, data)
--[[
	EquipBtn/HasDataPanel/IsLock
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsLock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isLock = tmp


end

---@private
function CustomBox:InitGenerate__32(Root, data)
--[[
	EquipBtn/HasDataPanel/IsLock2
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsLock2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isLock2 = tmp


end

---@private
function CustomBox:InitGenerate__33(Root, data)
--[[
	EquipBtn/HasDataPanel/IsSp
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsSp").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isSp = tmp


end

---@private
function CustomBox:InitGenerate__34(Root, data)
--[[
	EquipBtn/HasDataPanel/IsFrist
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsFrist").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isFrist = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function CustomBox:InitGenerate__35(Root, data)
--[[
	EquipBtn/HasDataPanel/IsFrist/TipsTxt
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsFrist/TipsTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CustomBox:InitGenerate__36(Root, data)
--[[
	EquipBtn/HasDataPanel/itemNameTxt
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/itemNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CustomBox:InitGenerate__37(Root, data)
--[[
	EquipBtn/HasDataPanel/IsGet
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsGet").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isGet = tmp


end

---@private
function CustomBox:InitGenerate__38(Root, data)
--[[
	EquipBtn/HasDataPanel/IsGet/isGetMark
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/IsGet/isGetMark").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isGetMark = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function CustomBox:InitGenerate__39(Root, data)
--[[
	EquipBtn/HasDataPanel/OverLoad
--]]
	local tmp = Root:Find("EquipBtn/HasDataPanel/OverLoad").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.overLoad = tmp


end

---@private
function CustomBox:InitGenerate__40(Root, data)
--[[
	EquipBtn/RedPoint
--]]
	local tmp = Root:Find("EquipBtn/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.redPoint = tmp


end

---@private
function CustomBox:InitGenerate__41(Root, data)
--[[
	EquipBtn/EquipInsufficient
--]]
	local tmp = Root:Find("EquipBtn/EquipInsufficient").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.equipInsufficient = tmp


end

---@private
function CustomBox:InitGenerate__42(Root, data)
--[[
	New
--]]
	local tmp = Root:Find("New").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.new = tmp


end

---@private
function CustomBox:InitGenerate__43(Root, data)
--[[
	ShowEf
--]]
	local tmp = Root:Find("ShowEf").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showEf = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function CustomBox:SetLocalizedText(Root)

    local locObj_CustomBox_TextTMP = Root:Find("EquipBtn/HasDataPanel/IsEquipIn/Text (TMP)")
    if locObj_CustomBox_TextTMP then
        locObj_CustomBox_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CustomBox_TextTMP
    end

    local locObj_CustomBox_txt = Root:Find("EquipBtn/EquipInsufficient/Image/txt")
    if locObj_CustomBox_txt then
        locObj_CustomBox_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CustomBox_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return CustomBox