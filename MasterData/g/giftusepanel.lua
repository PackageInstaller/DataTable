---@class GiftUsePanel : GiftUsePanel_Generate
---##################### 【GiftUsePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【GiftUsePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local GiftUsePanel = require "GiftUsePanel_Generate"
local SetNumView = require("SetNumView")

function GiftUsePanel:InitLogic(data)
    local canvas = self.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"

    ---@type SetNumView
    local lua_setNumView = SetNumView:new(self.setNumView.gameObject)
    lua_setNumView:InitGenerate()
    self.lua_setNumView = lua_setNumView
end

--function GiftUsePanel:StartCreating(time)
--
--end

--function GiftUsePanel:StartEnter(time)
--
--end

--function GiftUsePanel:StartRemoving(time)
--
--end

--function GiftUsePanel:StartExit(time)
--
--end

function GiftUsePanel:OnOpen(data, initiative)
    self.itemId = data.itemId
    self.needNum = data.needNum or 0
    self.targetId = data.targetId
    if not self.itemId or not self.targetId then
        return
    end
    self.itemCfg = Config.GetItemInfo(self.itemId)
    self.targetItemCfg = Config.GetItemInfo(self.targetId)
    if not self.targetItemCfg or not self.itemCfg or self.itemCfg.useType ~= GE.ItemUseType.multiple then
        return
    end
    for index, awardData in ipairs(self.itemCfg.effect or {}) do
        if awardData[2] == self.targetId then
            self.nowSelectIndex = index
            self.numMul = awardData[3] or 1
            break
        end
    end
    self.giftItem.nameText.text.text = self.itemCfg.itemName
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme3, self.itemCfg.quality), self.giftItem.qualityImg.image)
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, self.itemCfg.icon), self.giftItem.iconImg.image)
    self.getItem.nameText.text.text = self.targetItemCfg.itemName
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme3, self.targetItemCfg.quality), self.getItem.qualityImg.image)
    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, self.targetItemCfg.icon), self.getItem.iconImg.image)
    
    self.maxBoxCount = Me:getItemNumById(self.itemId)
    self.curBoxCount = self.maxBoxCount > 0 and 1 or 0

    self.lua_setNumView:SetData({
        maxNum = self.maxBoxCount,
        --titleText = "购买数量",
        onValueChange = function(curVal)
            self.curBoxCount = curVal
            self:refreshUI()
        end
    })

    self:refreshUI()
end

function GiftUsePanel:refreshUI()
    if self.curBoxCount > 0 then
        self.okBtn.normal:SetActive(true)
        self.okBtn.gray:SetActive(false)
    else
        self.okBtn.normal:SetActive(false)
        self.okBtn.gray:SetActive(true)
    end
    if self.maxBoxCount == 0 then
        self.giftItem.limitCountText.text.text = "<color=#FF3838>0</color>"
    else
        self.giftItem.limitCountText.text.text = string.format("<color=#333333>%s</color>/%s", self.curBoxCount, self.maxBoxCount)
    end
    -- LuaLogger.e(self.needNum)
    -- LuaLogger.e(Me:getItemCountById(self.targetId))
    local needCount = self.needNum - Me:getItemCountById(self.targetId)
    if needCount > 0 then
        local showCount = self.curBoxCount * self.numMul
        if showCount < needCount then
            self.getItem.limitCountText.text.text = string.format("<color=#FF3838>%s</color>/<color=#333333>%s</color>", showCount, needCount)
        else
            self.getItem.limitCountText.text.text = string.format("<color=#27b13d>%s</color>/<color=#333333>%s</color>", showCount, needCount)
        end
    else
        self.getItem.limitCountText.text.text = string.format("<color=#333333>%s</color>",self.curBoxCount * self.numMul)
    end
end

--function GiftUsePanel:OnClose(initiative)
--
--end

--function GiftUsePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function GiftUsePanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function GiftUsePanel:mask_Button_onClick(mask)
    UIMgr:closeSpecificUI(self)
end

--[[
/BoxBg/TitleSideBg/CloseBtn onClick 
--]]
function GiftUsePanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:closeSpecificUI(self)
end

--[[
/BoxBg/SetNumList/SubBtn onClick 
--]]
function GiftUsePanel:subBtn_ScaleButton_onClick(subBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.curBoxCount > 0 then
        self.curBoxCount = self.curBoxCount - 1
        self:refreshUI()
    end
end

--[[
/BoxBg/OkBtn onClick 
--]]
function GiftUsePanel:okBtn_ScaleButton_onClick(okBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.curBoxCount <= 0 then
        return
    end
    Me:openGiftPackReq({id = self.itemId, num = self.curBoxCount, selectIndex = self.nowSelectIndex}, function()
        UIMgr:closeSpecificUI(self)
    end)
end

--[[
/BoxBg/SetNumView/minusBtn onClick 
--]]
function GiftUsePanel:minusBtn_ScaleButton_onClick(minusBtn)

end

--[[
/BoxBg/SetNumView/plusBtn onClick 
--]]
function GiftUsePanel:plusBtn_ScaleButton_onClick(plusBtn)

end

--[[
/BoxBg/SetNumView/maxBtn onClick 
--]]
function GiftUsePanel:maxBtn_ScaleButton_onClick(maxBtn)

end

--[[
/BoxBg/SetNumView/numSlider onValueChanged 
--]]
function GiftUsePanel:numSlider_Slider_onValueChanged(numSlider,value)

end

return GiftUsePanel
