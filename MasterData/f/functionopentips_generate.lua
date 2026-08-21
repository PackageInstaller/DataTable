---@class FunctionOpenTips_Generate_buttonSkip
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class FunctionOpenTips_Generate_levelRed_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FunctionOpenTips_Generate_levelRed_desc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FunctionOpenTips_Generate_levelRed
---@field public gameObject UnityEngine.GameObject
---@field public desc FunctionOpenTips_Generate_levelRed_desc
---@field public titleText FunctionOpenTips_Generate_levelRed_titleText

---@class FunctionOpenTips_Generate_levelNormal_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FunctionOpenTips_Generate_levelNormal_desc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FunctionOpenTips_Generate_levelNormal
---@field public gameObject UnityEngine.GameObject
---@field public desc FunctionOpenTips_Generate_levelNormal_desc
---@field public titleText FunctionOpenTips_Generate_levelNormal_titleText

---@class FunctionOpenTips_Generate_functionPart_desc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FunctionOpenTips_Generate_functionPart_icon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class FunctionOpenTips_Generate_functionPart
---@field public gameObject UnityEngine.GameObject
---@field public icon FunctionOpenTips_Generate_functionPart_icon
---@field public desc FunctionOpenTips_Generate_functionPart_desc

---@class FunctionOpenTips_Generate_blueEffect_right
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class FunctionOpenTips_Generate_blueEffect_left
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class FunctionOpenTips_Generate_blueEffect
---@field public gameObject UnityEngine.GameObject
---@field public left FunctionOpenTips_Generate_blueEffect_left
---@field public right FunctionOpenTips_Generate_blueEffect_right

---@class FunctionOpenTips_Generate_title
---@field public gameObject UnityEngine.GameObject
---@field public functionPart UnityEngine.GameObject
---@field public levelNormal UnityEngine.GameObject
---@field public levelHard UnityEngine.GameObject

---@class FunctionOpenTips_Generate_level
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FunctionOpenTips_Generate_closeBg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class FunctionOpenTips_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animOverCallBack AnimOverCallBack
---@field public animator UnityEngine.Animator
---@field public closeBg FunctionOpenTips_Generate_closeBg
---@field public redEffect_1 UnityEngine.GameObject
---@field public blueEffect_1 UnityEngine.GameObject
---@field public lightBlue UnityEngine.GameObject
---@field public lightRed UnityEngine.GameObject
---@field public level FunctionOpenTips_Generate_level
---@field public title FunctionOpenTips_Generate_title
---@field public blueEffect FunctionOpenTips_Generate_blueEffect
---@field public redEffect UnityEngine.GameObject
---@field public functionPart FunctionOpenTips_Generate_functionPart
---@field public levelNormal FunctionOpenTips_Generate_levelNormal
---@field public levelRed FunctionOpenTips_Generate_levelRed
---@field public icon UnityEngine.GameObject
---@field public buttonSkip FunctionOpenTips_Generate_buttonSkip
local FunctionOpenTips = class("FunctionOpenTips", require("WndBase"))

function FunctionOpenTips:ctor(data)
end

---@private
function FunctionOpenTips:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("FunctionOpenTips")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function FunctionOpenTips:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)

	self.animator = Root:GetComponent(TypeInfo.Animator)


end

---@private
function FunctionOpenTips:InitGenerate__2(Root, data)
--[[
	closeBg
--]]
	local tmp = Root:Find("closeBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FunctionOpenTips_closeBg")
			if self.closeBg_Button_onClick then
				self:closeBg_Button_onClick(self.closeBg)
			end
		end)


end

---@private
function FunctionOpenTips:InitGenerate__3(Root, data)
--[[
	closeBg/redEffect_1
--]]
	local tmp = Root:Find("closeBg/redEffect_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.redEffect_1 = tmp


end

---@private
function FunctionOpenTips:InitGenerate__4(Root, data)
--[[
	closeBg/blueEffect_1
--]]
	local tmp = Root:Find("closeBg/blueEffect_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.blueEffect_1 = tmp


end

---@private
function FunctionOpenTips:InitGenerate__5(Root, data)
--[[
	closeBg/lightBlue
--]]
	local tmp = Root:Find("closeBg/lightBlue").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lightBlue = tmp


end

---@private
function FunctionOpenTips:InitGenerate__6(Root, data)
--[[
	closeBg/lightRed
--]]
	local tmp = Root:Find("closeBg/lightRed").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lightRed = tmp


end

---@private
function FunctionOpenTips:InitGenerate__7(Root, data)
--[[
	closeBg/level
--]]
	local tmp = Root:Find("closeBg/level").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.level = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FunctionOpenTips:InitGenerate__8(Root, data)
--[[
	closeBg/title
--]]
	local tmp = Root:Find("closeBg/title").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.title = tmp


end

---@private
function FunctionOpenTips:InitGenerate__9(Root, data)
--[[
	closeBg/title/blueEffect
--]]
	local tmp = Root:Find("closeBg/title/blueEffect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.blueEffect = tmp


end

---@private
function FunctionOpenTips:InitGenerate__10(Root, data)
--[[
	closeBg/title/blueEffect/Effect/left
--]]
	local tmp = Root:Find("closeBg/title/blueEffect/Effect/left").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.blueEffect.left = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function FunctionOpenTips:InitGenerate__11(Root, data)
--[[
	closeBg/title/blueEffect/Effect/right
--]]
	local tmp = Root:Find("closeBg/title/blueEffect/Effect/right").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.blueEffect.right = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function FunctionOpenTips:InitGenerate__12(Root, data)
--[[
	closeBg/title/redEffect
--]]
	local tmp = Root:Find("closeBg/title/redEffect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.redEffect = tmp


end

---@private
function FunctionOpenTips:InitGenerate__13(Root, data)
--[[
	closeBg/title/functionPart
--]]
	local tmp = Root:Find("closeBg/title/functionPart").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.title.functionPart = tmp


end

---@private
function FunctionOpenTips:InitGenerate__14(Root, data)
--[[
	closeBg/title/levelNormal
--]]
	local tmp = Root:Find("closeBg/title/levelNormal").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.title.levelNormal = tmp


end

---@private
function FunctionOpenTips:InitGenerate__15(Root, data)
--[[
	closeBg/title/levelHard
--]]
	local tmp = Root:Find("closeBg/title/levelHard").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.title.levelHard = tmp


end

---@private
function FunctionOpenTips:InitGenerate__16(Root, data)
--[[
	closeBg/content/functionPart
--]]
	local tmp = Root:Find("closeBg/content/functionPart").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.functionPart = tmp


end

---@private
function FunctionOpenTips:InitGenerate__17(Root, data)
--[[
	closeBg/content/functionPart/icon
--]]
	local tmp = Root:Find("closeBg/content/functionPart/icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.functionPart.icon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function FunctionOpenTips:InitGenerate__18(Root, data)
--[[
	closeBg/content/functionPart/textBg/desc
--]]
	local tmp = Root:Find("closeBg/content/functionPart/textBg/desc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.functionPart.desc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FunctionOpenTips:InitGenerate__19(Root, data)
--[[
	closeBg/content/levelNormal
--]]
	local tmp = Root:Find("closeBg/content/levelNormal").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelNormal = tmp


end

---@private
function FunctionOpenTips:InitGenerate__20(Root, data)
--[[
	closeBg/content/levelNormal/line/desc
--]]
	local tmp = Root:Find("closeBg/content/levelNormal/line/desc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelNormal.desc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FunctionOpenTips:InitGenerate__21(Root, data)
--[[
	closeBg/content/levelNormal/titleBg/titleText
--]]
	local tmp = Root:Find("closeBg/content/levelNormal/titleBg/titleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelNormal.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FunctionOpenTips:InitGenerate__22(Root, data)
--[[
	closeBg/content/levelRed
--]]
	local tmp = Root:Find("closeBg/content/levelRed").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelRed = tmp


end

---@private
function FunctionOpenTips:InitGenerate__23(Root, data)
--[[
	closeBg/content/levelRed/icon
--]]
	local tmp = Root:Find("closeBg/content/levelRed/icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.icon = tmp


end

---@private
function FunctionOpenTips:InitGenerate__24(Root, data)
--[[
	closeBg/content/levelRed/line/desc
--]]
	local tmp = Root:Find("closeBg/content/levelRed/line/desc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelRed.desc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FunctionOpenTips:InitGenerate__25(Root, data)
--[[
	closeBg/content/levelRed/titleBg/titleText
--]]
	local tmp = Root:Find("closeBg/content/levelRed/titleBg/titleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelRed.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FunctionOpenTips:InitGenerate__26(Root, data)
--[[
	closeBg/buttonSkip
--]]
	local tmp = Root:Find("closeBg/buttonSkip").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.buttonSkip = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FunctionOpenTips_buttonSkip")
			if self.buttonSkip_Button_onClick then
				self:buttonSkip_Button_onClick(self.buttonSkip)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function FunctionOpenTips:SetLocalizedText(Root)

    local locObj_FunctionOpenTips_titleText = Root:Find("closeBg/content/levelNormal/titleBg/titleText")
    if locObj_FunctionOpenTips_titleText then
        locObj_FunctionOpenTips_titleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.FunctionOpenTips_titleText
    end

    local locObj_FunctionOpenTips_tg_titleText = Root:Find("closeBg/content/levelRed/titleBg/titleText")
    if locObj_FunctionOpenTips_tg_titleText then
        locObj_FunctionOpenTips_tg_titleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.FunctionOpenTips_tg_titleText
    end

    local locObj_FunctionOpenTips_closeDesc = Root:Find("closeBg/content/closeDesc")
    if locObj_FunctionOpenTips_closeDesc then
        locObj_FunctionOpenTips_closeDesc.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.FunctionOpenTips_closeDesc
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return FunctionOpenTips