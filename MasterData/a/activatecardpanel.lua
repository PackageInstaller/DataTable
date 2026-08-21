---@class ActivateCardPanel : ActivateCardPanel_Generate
---##################### 【ActivateCardPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ActivateCardPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ActivateCardPanel = require "ActivateCardPanel_Generate"

function ActivateCardPanel:InitLogic(data)

end

--function ActivateCardPanel:StartCreating(time)
--
--end

--function ActivateCardPanel:StartEnter(time)
--
--end

--function ActivateCardPanel:StartRemoving(time)
--
--endq

--function ActivateCardPanel:StartExit(time)
--
--end

function ActivateCardPanel:OnOpen(data, initiative)
    ---@type Color
    local color = nil
    local cardPath =  string.format(Config.SpritePath.MonthCard, data)
    if data == 1 then
        color = Color.New(255/255, 211/255, 71/255)
       
    else
        color = Color.New(143/255, 201/255, 255/255)
    end

    self.gyImg.image.color = color

    self.l_lineImg.image.color = color
    self.r_lineImg.image.color = color
    self.cardIconImg.image.color = color
    self.nameBgImg.image.color = color
    self.nameText.text.color = color
    self.frameImg.image.color = color
    self:LoadSpriteAsync(cardPath, self.cardTextureImg.image)
end

--function ActivateCardPanel:OnClose(initiative)
--
--end

--function ActivateCardPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ActivateCardPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function ActivateCardPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:closeCurrentUI(self)
end

return ActivateCardPanel
