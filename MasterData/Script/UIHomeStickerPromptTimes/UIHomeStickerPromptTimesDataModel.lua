local View = require("UIHomeStickerPromptTimes/UIHomeStickerPromptTimesView")
local Controller = require("UIHomeSticker/UIHomeStickerController")
local DataModel = {}

function DataModel:Init()
  local curNum = PlayerData:GetGoodsById(self.costId).num
  local configCA = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  self.maxNum = math.min(configCA.stickerMax, math.floor(curNum / self.costNum))
  self.curSelectNum = nil
  self:InitUI()
  self:SetSelectNum(1)
end

function DataModel:InitUI()
  View.Group_Slider.Group_Num.Txt_Possess:SetText(self.maxNum)
  View.Group_Gold.Img_:SetSprite(PlayerData:GetFactoryData(self.costId, "ItemFactory").buyPath)
end

function DataModel:SetSelectNum(num)
  if num == self.curSelectNum then
    return
  end
  self.curSelectNum = num
  self:RefreshSelectNumView()
  self._isSliderChanging = true
  View.Group_Slider.Slider_Value:SetSliderValue((num - 1) / math.max(1, self.maxNum - 1))
  self._isSliderChanging = false
end

function DataModel:RefreshSelectNumView()
  local num = self.curSelectNum
  View.Group_Slider.Group_Num.Txt_Select:SetText(num)
  View.Group_Gold.Txt_Num:SetText(num * self.costNum)
end

function DataModel:OnSliderValue(percent)
  if self._isSliderChanging == true then
    return
  end
  local newUseNum = math.ceil(math.max(self.maxNum - 1, 1) * percent + 1)
  newUseNum = math.min(self.maxNum, math.max(1, newUseNum))
  self.curSelectNum = newUseNum
  self:RefreshSelectNumView()
end

function DataModel:DoTakePhoto()
  Controller:DoTakePhoto(self.characterInfo, self.costId, self.costNum, self.curSelectNum)
end

return DataModel
