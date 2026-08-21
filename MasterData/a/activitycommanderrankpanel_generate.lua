---@class ActivityCommanderRankPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class ActivityCommanderRankPanel_Generate_rewardBox_getBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ActivityCommanderRankPanel_Generate_rewardBox_rankTitleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommanderRankPanel_Generate_rewardBox_rankText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommanderRankPanel_Generate_rewardBox
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public rankText ActivityCommanderRankPanel_Generate_rewardBox_rankText
---@field public rankTitleText ActivityCommanderRankPanel_Generate_rewardBox_rankTitleText
---@field public normalRoot UnityEngine.GameObject
---@field public payRoot UnityEngine.GameObject
---@field public lockMask UnityEngine.GameObject
---@field public lockIcon UnityEngine.GameObject
---@field public normalLockIcon UnityEngine.GameObject
---@field public getBtn ActivityCommanderRankPanel_Generate_rewardBox_getBtn
---@field public canGet UnityEngine.GameObject
---@field public payCanGet UnityEngine.GameObject

---@class ActivityCommanderRankPanel_Generate_timeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommanderRankPanel_Generate_onceGetBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityCommanderRankPanel_Generate_notPriceText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommanderRankPanel_Generate_notGoBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityCommanderRankPanel_Generate_tipsGetIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivityCommanderRankPanel_Generate_tipsTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommanderRankPanel_Generate_priceText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommanderRankPanel_Generate_goBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityCommanderRankPanel_Generate_leftPart
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ActivityCommanderRankPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public spineRoot UnityEngine.GameObject
---@field public leftPart ActivityCommanderRankPanel_Generate_leftPart
---@field public goBtn ActivityCommanderRankPanel_Generate_goBtn
---@field public priceText ActivityCommanderRankPanel_Generate_priceText
---@field public tipsTxt ActivityCommanderRankPanel_Generate_tipsTxt
---@field public tipsGetIcon ActivityCommanderRankPanel_Generate_tipsGetIcon
---@field public notGoBtn ActivityCommanderRankPanel_Generate_notGoBtn
---@field public notPriceText ActivityCommanderRankPanel_Generate_notPriceText
---@field public onceGetBtn ActivityCommanderRankPanel_Generate_onceGetBtn
---@field public timeTxt ActivityCommanderRankPanel_Generate_timeTxt
---@field public payLocked UnityEngine.GameObject
---@field public content UnityEngine.GameObject
---@field public rewardBox ActivityCommanderRankPanel_Generate_rewardBox
---@field public customBox ActivityCommanderRankPanel_Generate_customBox
local ActivityCommanderRankPanel = class("ActivityCommanderRankPanel", require("WndBase"))

function ActivityCommanderRankPanel:ctor(data)
end

---@private
function ActivityCommanderRankPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ActivityCommanderRankPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ActivityCommanderRankPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__2(Root, data)
--[[
	SpineRoot
--]]
	local tmp = Root:Find("SpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.spineRoot = tmp


end

---@private
function ActivityCommanderRankPanel:InitGenerate__3(Root, data)
--[[
	leftPart
--]]
	local tmp = Root:Find("leftPart").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.leftPart = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__4(Root, data)
--[[
	leftPart/GoBtn
--]]
	local tmp = Root:Find("leftPart/GoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityCommanderRankPanel_goBtn")
			if self.goBtn_ScaleButton_onClick then
				self:goBtn_ScaleButton_onClick(self.goBtn)
			end
		end)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__5(Root, data)
--[[
	leftPart/GoBtn/PriceText
--]]
	local tmp = Root:Find("leftPart/GoBtn/PriceText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.priceText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__6(Root, data)
--[[
	leftPart/GoBtn/TipsTxt
--]]
	local tmp = Root:Find("leftPart/GoBtn/TipsTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__7(Root, data)
--[[
	leftPart/GoBtn/TipsGetIcon
--]]
	local tmp = Root:Find("leftPart/GoBtn/TipsGetIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsGetIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__8(Root, data)
--[[
	leftPart/NotGoBtn
--]]
	local tmp = Root:Find("leftPart/NotGoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.notGoBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityCommanderRankPanel_notGoBtn")
			if self.notGoBtn_ScaleButton_onClick then
				self:notGoBtn_ScaleButton_onClick(self.notGoBtn)
			end
		end)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__9(Root, data)
--[[
	leftPart/NotGoBtn/NotPriceText
--]]
	local tmp = Root:Find("leftPart/NotGoBtn/NotPriceText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.notPriceText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__10(Root, data)
--[[
	rightPart/OnceGetBtn
--]]
	local tmp = Root:Find("rightPart/OnceGetBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.onceGetBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityCommanderRankPanel_onceGetBtn")
			if self.onceGetBtn_ScaleButton_onClick then
				self:onceGetBtn_ScaleButton_onClick(self.onceGetBtn)
			end
		end)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__11(Root, data)
--[[
	rightPart/ActTitleBg/TimeBg/TimeTxt
--]]
	local tmp = Root:Find("rightPart/ActTitleBg/TimeBg/TimeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__12(Root, data)
--[[
	rightPart/RewardTitleBg/PayLocked
--]]
	local tmp = Root:Find("rightPart/RewardTitleBg/PayLocked").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.payLocked = tmp


end

---@private
function ActivityCommanderRankPanel:InitGenerate__13(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp


end

---@private
function ActivityCommanderRankPanel:InitGenerate__14(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__15(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox/RankText
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox/RankText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.rankText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__16(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox/RankTitleText
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox/RankTitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.rankTitleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__17(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox/NormalRoot
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox/NormalRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.normalRoot = tmp


end

---@private
function ActivityCommanderRankPanel:InitGenerate__18(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox/PayRoot
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox/PayRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.payRoot = tmp


end

---@private
function ActivityCommanderRankPanel:InitGenerate__19(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox/LockMask
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox/LockMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.lockMask = tmp


end

---@private
function ActivityCommanderRankPanel:InitGenerate__20(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox/LockIcon
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox/LockIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.lockIcon = tmp


end

---@private
function ActivityCommanderRankPanel:InitGenerate__21(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox/NormalLockIcon
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox/NormalLockIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.normalLockIcon = tmp


end

---@private
function ActivityCommanderRankPanel:InitGenerate__22(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox/GetBtn
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox/GetBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.getBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function ActivityCommanderRankPanel:InitGenerate__23(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox/CanGet
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox/CanGet").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.canGet = tmp


end

---@private
function ActivityCommanderRankPanel:InitGenerate__24(Root, data)
--[[
	rightPart/ScrollView/Viewport/Content/RewardBox/PayCanGet
--]]
	local tmp = Root:Find("rightPart/ScrollView/Viewport/Content/RewardBox/PayCanGet").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBox.payCanGet = tmp


end

---@private
function ActivityCommanderRankPanel:InitGenerate__25(Root, data)
--[[
	CustomBox
--]]
	local tmp = Root:Find("CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ActivityCommanderRankPanel:SetLocalizedText(Root)

    local locObj_ActivityCommanderRankPanel_GoText = Root:Find("leftPart/GoBtn/GoText")
    if locObj_ActivityCommanderRankPanel_GoText then
        locObj_ActivityCommanderRankPanel_GoText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityCommanderRankPanel_GoText
    end

    local locObj_ActivityCommanderRankPanel_CurrencyText = Root:Find("leftPart/GoBtn/PriceText/CurrencyText")
    if locObj_ActivityCommanderRankPanel_CurrencyText then
        locObj_ActivityCommanderRankPanel_CurrencyText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityCommanderRankPanel_CurrencyText
    end

    local locObj_ActivityCommanderRankPanel_NotGoText = Root:Find("leftPart/NotGoBtn/NotGoText")
    if locObj_ActivityCommanderRankPanel_NotGoText then
        locObj_ActivityCommanderRankPanel_NotGoText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityCommanderRankPanel_NotGoText
    end

    local locObj_ActivityCommanderRankPanel_Nt_CurrencyText = Root:Find("leftPart/NotGoBtn/NotPriceText/CurrencyText")
    if locObj_ActivityCommanderRankPanel_Nt_CurrencyText then
        locObj_ActivityCommanderRankPanel_Nt_CurrencyText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityCommanderRankPanel_Nt_CurrencyText
    end

    local locObj_ActivityCommanderRankPanel_txt = Root:Find("rightPart/OnceGetBtn/txt")
    if locObj_ActivityCommanderRankPanel_txt then
        locObj_ActivityCommanderRankPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityCommanderRankPanel_txt
    end

    local locObj_ActivityCommanderRankPanel_TitleTxt = Root:Find("rightPart/ActTitleBg/TitleTxt")
    if locObj_ActivityCommanderRankPanel_TitleTxt then
        locObj_ActivityCommanderRankPanel_TitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityCommanderRankPanel_TitleTxt
    end

    local locObj_ActivityCommanderRankPanel_NomalTitle = Root:Find("rightPart/RewardTitleBg/NomalTitle")
    if locObj_ActivityCommanderRankPanel_NomalTitle then
        locObj_ActivityCommanderRankPanel_NomalTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityCommanderRankPanel_NomalTitle
    end

    local locObj_ActivityCommanderRankPanel_PayTitle = Root:Find("rightPart/RewardTitleBg/PayTitle")
    if locObj_ActivityCommanderRankPanel_PayTitle then
        locObj_ActivityCommanderRankPanel_PayTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityCommanderRankPanel_PayTitle
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ActivityCommanderRankPanel