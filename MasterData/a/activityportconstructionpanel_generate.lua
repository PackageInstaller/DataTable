---@class ActivityPortConstructionPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class ActivityPortConstructionPanel_Generate_commonTaskBox_getBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityPortConstructionPanel_Generate_commonTaskBox_goToBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityPortConstructionPanel_Generate_commonTaskBox_taskMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityPortConstructionPanel_Generate_commonTaskBox_taskNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityPortConstructionPanel_Generate_commonTaskBox
---@field public gameObject UnityEngine.GameObject
---@field public taskNameTxt ActivityPortConstructionPanel_Generate_commonTaskBox_taskNameTxt
---@field public taskMsgTxt ActivityPortConstructionPanel_Generate_commonTaskBox_taskMsgTxt
---@field public rewardList UnityEngine.GameObject
---@field public goToBtn ActivityPortConstructionPanel_Generate_commonTaskBox_goToBtn
---@field public getBtn ActivityPortConstructionPanel_Generate_commonTaskBox_getBtn
---@field public finish UnityEngine.GameObject

---@class ActivityPortConstructionPanel_Generate_taskLoopList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public loopListView2 SuperScrollView.LoopListView2
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ActivityPortConstructionPanel_Generate_activityProgressText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityPortConstructionPanel_Generate_descText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityPortConstructionPanel_Generate_descTextShadow
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityPortConstructionPanel_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityPortConstructionPanel_Generate_titleTextShadow
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityPortConstructionPanel_Generate_timeBg
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ActivityPortConstructionPanel_Generate_bg3
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivityPortConstructionPanel_Generate_bg2
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivityPortConstructionPanel_Generate_bg1
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivityPortConstructionPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bg1 ActivityPortConstructionPanel_Generate_bg1
---@field public bg2 ActivityPortConstructionPanel_Generate_bg2
---@field public bg3 ActivityPortConstructionPanel_Generate_bg3
---@field public timeBg ActivityPortConstructionPanel_Generate_timeBg
---@field public titleTextShadow ActivityPortConstructionPanel_Generate_titleTextShadow
---@field public titleText ActivityPortConstructionPanel_Generate_titleText
---@field public descTextShadow ActivityPortConstructionPanel_Generate_descTextShadow
---@field public descText ActivityPortConstructionPanel_Generate_descText
---@field public activityProgressText ActivityPortConstructionPanel_Generate_activityProgressText
---@field public taskLoopList ActivityPortConstructionPanel_Generate_taskLoopList
---@field public commonTaskBox ActivityPortConstructionPanel_Generate_commonTaskBox
---@field public customBox ActivityPortConstructionPanel_Generate_customBox
local ActivityPortConstructionPanel = class("ActivityPortConstructionPanel", require("WndBase"))

function ActivityPortConstructionPanel:ctor(data)
end

---@private
function ActivityPortConstructionPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ActivityPortConstructionPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ActivityPortConstructionPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__2(Root, data)
--[[
	Main/BgRoot/Bg1
--]]
	local tmp = Root:Find("Main/BgRoot/Bg1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg1 = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__3(Root, data)
--[[
	Main/BgRoot/Bg2
--]]
	local tmp = Root:Find("Main/BgRoot/Bg2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg2 = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__4(Root, data)
--[[
	Main/BgRoot/Bg3
--]]
	local tmp = Root:Find("Main/BgRoot/Bg3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg3 = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__5(Root, data)
--[[
	Main/TimeBg
--]]
	local tmp = Root:Find("Main/TimeBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeBg = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__6(Root, data)
--[[
	Main/TimeBg/TimeBg/titleTextShadow
--]]
	local tmp = Root:Find("Main/TimeBg/TimeBg/titleTextShadow").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleTextShadow = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__7(Root, data)
--[[
	Main/TimeBg/TimeBg/titleTextShadow/titleText
--]]
	local tmp = Root:Find("Main/TimeBg/TimeBg/titleTextShadow/titleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__8(Root, data)
--[[
	Main/TimeBg/TextBg/DescTextShadow
--]]
	local tmp = Root:Find("Main/TimeBg/TextBg/DescTextShadow").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.descTextShadow = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__9(Root, data)
--[[
	Main/TimeBg/TextBg/DescTextShadow/DescText
--]]
	local tmp = Root:Find("Main/TimeBg/TextBg/DescTextShadow/DescText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.descText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__10(Root, data)
--[[
	Main/TimeBg/ActivityProgress/ActivityProgressText
--]]
	local tmp = Root:Find("Main/TimeBg/ActivityProgress/ActivityProgressText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activityProgressText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__11(Root, data)
--[[
	Main/TaskLoopList
--]]
	local tmp = Root:Find("Main/TaskLoopList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskLoopList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.loopListView2 = tmp:GetComponent(TypeInfo.LoopListView2)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__12(Root, data)
--[[
	Main/TaskLoopList/Viewport/Content/CommonTaskBox
--]]
	local tmp = Root:Find("Main/TaskLoopList/Viewport/Content/CommonTaskBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox = tmp


end

---@private
function ActivityPortConstructionPanel:InitGenerate__13(Root, data)
--[[
	Main/TaskLoopList/Viewport/Content/CommonTaskBox/TaskNameTxt
--]]
	local tmp = Root:Find("Main/TaskLoopList/Viewport/Content/CommonTaskBox/TaskNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.taskNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__14(Root, data)
--[[
	Main/TaskLoopList/Viewport/Content/CommonTaskBox/TaskMsgTxt
--]]
	local tmp = Root:Find("Main/TaskLoopList/Viewport/Content/CommonTaskBox/TaskMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.taskMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__15(Root, data)
--[[
	Main/TaskLoopList/Viewport/Content/CommonTaskBox/RewardList
--]]
	local tmp = Root:Find("Main/TaskLoopList/Viewport/Content/CommonTaskBox/RewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.rewardList = tmp


end

---@private
function ActivityPortConstructionPanel:InitGenerate__16(Root, data)
--[[
	Main/TaskLoopList/Viewport/Content/CommonTaskBox/GoToBtn
--]]
	local tmp = Root:Find("Main/TaskLoopList/Viewport/Content/CommonTaskBox/GoToBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.goToBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityPortConstructionPanel_goToBtn")
			if self.goToBtn_ScaleButton_onClick then
				self:goToBtn_ScaleButton_onClick(self.commonTaskBox.goToBtn)
			end
		end)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__17(Root, data)
--[[
	Main/TaskLoopList/Viewport/Content/CommonTaskBox/GetBtn
--]]
	local tmp = Root:Find("Main/TaskLoopList/Viewport/Content/CommonTaskBox/GetBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.getBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityPortConstructionPanel_getBtn")
			if self.getBtn_ScaleButton_onClick then
				self:getBtn_ScaleButton_onClick(self.commonTaskBox.getBtn)
			end
		end)


end

---@private
function ActivityPortConstructionPanel:InitGenerate__18(Root, data)
--[[
	Main/TaskLoopList/Viewport/Content/CommonTaskBox/Finish
--]]
	local tmp = Root:Find("Main/TaskLoopList/Viewport/Content/CommonTaskBox/Finish").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.finish = tmp


end

---@private
function ActivityPortConstructionPanel:InitGenerate__19(Root, data)
--[[
	Main/CustomBox
--]]
	local tmp = Root:Find("Main/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ActivityPortConstructionPanel:SetLocalizedText(Root)

    local locObj_ActivityPortConstructionPanel_TimeTxt = Root:Find("Main/TimeBg/TimeBg/TimeTxt")
    if locObj_ActivityPortConstructionPanel_TimeTxt then
        locObj_ActivityPortConstructionPanel_TimeTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityPortConstructionPanel_TimeTxt
    end

    local locObj_ActivityPortConstructionPanel_Text = Root:Find("Main/TimeBg/ActivityProgress/Text ")
    if locObj_ActivityPortConstructionPanel_Text then
        locObj_ActivityPortConstructionPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityPortConstructionPanel_Text
    end

    local locObj_ActivityPortConstructionPanel_Gn_Text = Root:Find("Main/TaskLoopList/Viewport/Content/CommonTaskBox/GoToBtn/Text ")
    if locObj_ActivityPortConstructionPanel_Gn_Text then
        locObj_ActivityPortConstructionPanel_Gn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityPortConstructionPanel_Gn_Text
    end

    local locObj_ActivityPortConstructionPanel_Cx_Gn_Text = Root:Find("Main/TaskLoopList/Viewport/Content/CommonTaskBox/GetBtn/Text ")
    if locObj_ActivityPortConstructionPanel_Cx_Gn_Text then
        locObj_ActivityPortConstructionPanel_Cx_Gn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityPortConstructionPanel_Cx_Gn_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ActivityPortConstructionPanel