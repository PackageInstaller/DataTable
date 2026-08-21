---@class ActivityRoleExchange_Generate_rewardNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityRoleExchange_Generate_rewardIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class ActivityRoleExchange_Generate_finalReward
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ActivityRoleExchange_Generate_remainNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityRoleExchange_Generate_exchangeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityRoleExchange_Generate_taskBox_notGet_text
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityRoleExchange_Generate_taskBox_notGet
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public text ActivityRoleExchange_Generate_taskBox_notGet_text

---@class ActivityRoleExchange_Generate_taskBox_get
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ActivityRoleExchange_Generate_taskBox_go
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ActivityRoleExchange_Generate_taskBox_desc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityRoleExchange_Generate_taskBox_title
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityRoleExchange_Generate_taskBox
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public redPoint UnityEngine.GameObject
---@field public title ActivityRoleExchange_Generate_taskBox_title
---@field public desc ActivityRoleExchange_Generate_taskBox_desc
---@field public go ActivityRoleExchange_Generate_taskBox_go
---@field public get ActivityRoleExchange_Generate_taskBox_get
---@field public notGet ActivityRoleExchange_Generate_taskBox_notGet
---@field public icon UnityEngine.GameObject
---@field public finished UnityEngine.GameObject

---@class ActivityRoleExchange_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityRoleExchange_Generate_titleTextShadow
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityRoleExchange_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class ActivityRoleExchange_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bg ActivityRoleExchange_Generate_bg
---@field public titleTextShadow ActivityRoleExchange_Generate_titleTextShadow
---@field public titleText ActivityRoleExchange_Generate_titleText
---@field public content UnityEngine.GameObject
---@field public taskBox ActivityRoleExchange_Generate_taskBox
---@field public tips UnityEngine.GameObject
---@field public exchangeBtn ActivityRoleExchange_Generate_exchangeBtn
---@field public remainNum ActivityRoleExchange_Generate_remainNum
---@field public finalReward ActivityRoleExchange_Generate_finalReward
---@field public rewardIcon ActivityRoleExchange_Generate_rewardIcon
---@field public rewardNum ActivityRoleExchange_Generate_rewardNum
---@field public finishMask UnityEngine.GameObject
---@field public highLight UnityEngine.GameObject
local ActivityRoleExchange = class("ActivityRoleExchange", require("WndBase"))

function ActivityRoleExchange:ctor(data)
end

---@private
function ActivityRoleExchange:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ActivityRoleExchange")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ActivityRoleExchange:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ActivityRoleExchange:InitGenerate__2(Root, data)
--[[
	bg
--]]
	local tmp = Root:Find("bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function ActivityRoleExchange:InitGenerate__3(Root, data)
--[[
	bg/TimeBg/TimeBg/titleTextShadow
--]]
	local tmp = Root:Find("bg/TimeBg/TimeBg/titleTextShadow").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleTextShadow = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityRoleExchange:InitGenerate__4(Root, data)
--[[
	bg/TimeBg/TimeBg/titleTextShadow/titleText
--]]
	local tmp = Root:Find("bg/TimeBg/TimeBg/titleTextShadow/titleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityRoleExchange:InitGenerate__5(Root, data)
--[[
	bg/content
--]]
	local tmp = Root:Find("bg/content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp


end

---@private
function ActivityRoleExchange:InitGenerate__6(Root, data)
--[[
	bg/content/taskBox
--]]
	local tmp = Root:Find("bg/content/taskBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ActivityRoleExchange:InitGenerate__7(Root, data)
--[[
	bg/content/taskBox/RedPoint
--]]
	local tmp = Root:Find("bg/content/taskBox/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.redPoint = tmp


end

---@private
function ActivityRoleExchange:InitGenerate__8(Root, data)
--[[
	bg/content/taskBox/title
--]]
	local tmp = Root:Find("bg/content/taskBox/title").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.title = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityRoleExchange:InitGenerate__9(Root, data)
--[[
	bg/content/taskBox/desc
--]]
	local tmp = Root:Find("bg/content/taskBox/desc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.desc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityRoleExchange:InitGenerate__10(Root, data)
--[[
	bg/content/taskBox/go
--]]
	local tmp = Root:Find("bg/content/taskBox/go").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.go = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleExchange_go")
			if self.go_Button_onClick then
				self:go_Button_onClick(self.taskBox.go)
			end
		end)


end

---@private
function ActivityRoleExchange:InitGenerate__11(Root, data)
--[[
	bg/content/taskBox/get
--]]
	local tmp = Root:Find("bg/content/taskBox/get").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.get = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleExchange_get")
			if self.get_Button_onClick then
				self:get_Button_onClick(self.taskBox.get)
			end
		end)


end

---@private
function ActivityRoleExchange:InitGenerate__12(Root, data)
--[[
	bg/content/taskBox/notGet
--]]
	local tmp = Root:Find("bg/content/taskBox/notGet").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.notGet = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleExchange_notGet")
			if self.notGet_Button_onClick then
				self:notGet_Button_onClick(self.taskBox.notGet)
			end
		end)


end

---@private
function ActivityRoleExchange:InitGenerate__13(Root, data)
--[[
	bg/content/taskBox/notGet/text
--]]
	local tmp = Root:Find("bg/content/taskBox/notGet/text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.notGet.text = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityRoleExchange:InitGenerate__14(Root, data)
--[[
	bg/content/taskBox/icon
--]]
	local tmp = Root:Find("bg/content/taskBox/icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.icon = tmp


end

---@private
function ActivityRoleExchange:InitGenerate__15(Root, data)
--[[
	bg/content/taskBox/finished
--]]
	local tmp = Root:Find("bg/content/taskBox/finished").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBox.finished = tmp


end

---@private
function ActivityRoleExchange:InitGenerate__16(Root, data)
--[[
	bottomPart/tips
--]]
	local tmp = Root:Find("bottomPart/tips").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tips = tmp


end

---@private
function ActivityRoleExchange:InitGenerate__17(Root, data)
--[[
	bottomPart/tips/exchangeBtn
--]]
	local tmp = Root:Find("bottomPart/tips/exchangeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.exchangeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleExchange_exchangeBtn")
			if self.exchangeBtn_ScaleButton_onClick then
				self:exchangeBtn_ScaleButton_onClick(self.exchangeBtn)
			end
		end)


end

---@private
function ActivityRoleExchange:InitGenerate__18(Root, data)
--[[
	bottomPart/tips/remainNum
--]]
	local tmp = Root:Find("bottomPart/tips/remainNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.remainNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityRoleExchange:InitGenerate__19(Root, data)
--[[
	bottomPart/finalReward
--]]
	local tmp = Root:Find("bottomPart/finalReward").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.finalReward = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityRoleExchange_finalReward")
			if self.finalReward_Button_onClick then
				self:finalReward_Button_onClick(self.finalReward)
			end
		end)


end

---@private
function ActivityRoleExchange:InitGenerate__20(Root, data)
--[[
	bottomPart/finalReward/rewardIcon
--]]
	local tmp = Root:Find("bottomPart/finalReward/rewardIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function ActivityRoleExchange:InitGenerate__21(Root, data)
--[[
	bottomPart/finalReward/rewardNum
--]]
	local tmp = Root:Find("bottomPart/finalReward/rewardNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityRoleExchange:InitGenerate__22(Root, data)
--[[
	bottomPart/finalReward/finishMask
--]]
	local tmp = Root:Find("bottomPart/finalReward/finishMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.finishMask = tmp


end

---@private
function ActivityRoleExchange:InitGenerate__23(Root, data)
--[[
	bottomPart/finalReward/highLight
--]]
	local tmp = Root:Find("bottomPart/finalReward/highLight").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.highLight = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ActivityRoleExchange:SetLocalizedText(Root)

    local locObj_ActivityRoleExchange_TimeTxt = Root:Find("bg/TimeBg/TimeBg/TimeTxt")
    if locObj_ActivityRoleExchange_TimeTxt then
        locObj_ActivityRoleExchange_TimeTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityRoleExchange_TimeTxt
    end

    local locObj_ActivityRoleExchange_descTextShadow = Root:Find("bg/TimeBg/TimeBg/descTextShadow")
    if locObj_ActivityRoleExchange_descTextShadow then
        locObj_ActivityRoleExchange_descTextShadow.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityRoleExchange_descTextShadow
    end

    local locObj_ActivityRoleExchange_descText = Root:Find("bg/TimeBg/TimeBg/descTextShadow/descText")
    if locObj_ActivityRoleExchange_descText then
        locObj_ActivityRoleExchange_descText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityRoleExchange_descText
    end

    local locObj_ActivityRoleExchange_text = Root:Find("bg/content/taskBox/go/text")
    if locObj_ActivityRoleExchange_text then
        locObj_ActivityRoleExchange_text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityRoleExchange_text
    end

    local locObj_ActivityRoleExchange_gt_text = Root:Find("bg/content/taskBox/get/text")
    if locObj_ActivityRoleExchange_gt_text then
        locObj_ActivityRoleExchange_gt_text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityRoleExchange_gt_text
    end

    local locObj_ActivityRoleExchange_en_text = Root:Find("bottomPart/tips/exchangeBtn/text")
    if locObj_ActivityRoleExchange_en_text then
        locObj_ActivityRoleExchange_en_text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityRoleExchange_en_text
    end

    local locObj_ActivityRoleExchange_Text = Root:Find("bottomPart/finalReward/line/Text ")
    if locObj_ActivityRoleExchange_Text then
        locObj_ActivityRoleExchange_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.ActivityRoleExchange_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ActivityRoleExchange