---@class FilterPanel : FilterPanel_Generate
---##################### 【FilterPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【FilterPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local FilterPanel = require "FilterPanel_Generate"

function FilterPanel:InitLogic(data)

end

--function FilterPanel:StartCreating(time)
--
--end

--function FilterPanel:StartEnter(time)
--
--end

--function FilterPanel:StartRemoving(time)
--
--end

--function FilterPanel:StartExit(time)
--
--end

function FilterPanel:OnOpen(data, initiative)

end

--function FilterPanel:OnClose(initiative)
--
--end

--function FilterPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function FilterPanel:OnRefresh(data)
--
--end

--[[
/mask onClick 
--]]
function FilterPanel:mask_Button_onClick(mask)
    UIMgr:closeUI(self)
end

--[[
/PanelBg/Art/TitleBg/CloseBtn onClick 
--]]
function FilterPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UIMgr:closeUI(self)
end

--[[
/PanelBg/OkBtn onClick 
--]]
function FilterPanel:okBtn_ScaleButton_onClick(okBtn)
    UIMgr:closeUI(self)
end

--[[
/PanelBg/AllClearBtn onClick 
--]]
function FilterPanel:allClearBtn_ScaleButton_onClick(allClearBtn)

end

--[[
/PanelBg/SaveBtn onClick 
--]]
function FilterPanel:saveBtn_ScaleButton_onClick(saveBtn)

end

--[[
/ModeBtn onClick 
--]]
function FilterPanel:modeBtn_ScaleButton_onClick(modeBtn)

end

return FilterPanel
