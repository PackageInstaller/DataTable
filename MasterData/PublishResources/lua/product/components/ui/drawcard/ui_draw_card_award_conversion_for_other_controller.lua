_class("UIDrawCardAwardConversionForOtherController", UIController)
UIDrawCardAwardConversionForOtherController = UIDrawCardAwardConversionForOtherController

function UIDrawCardAwardConversionForOtherController:OnShow(uiParam)
  self._conversion = self:GetGameObject("Conversion")
  self.converseContent = self:GetUIComponent("UISelectObjectPath", "ConverseContent")
  self._atlas = self:GetAsset("UIDrawCard.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  local tipspool = self:GetUIComponent("UISelectObjectPath", "tipspool")
  self._tipsPoolObj = self:GetGameObject("tipspool")
  self._tips = tipspool:SpawnObject("UISelectInfo")
  self:ConversiontagOnClick()
end

function UIDrawCardAwardConversionForOtherController:ShowTips(itemId, pos)
  self._tipsPoolObj:SetActive(true)
  self._tips:SetData(itemId, pos)
end

function UIDrawCardAwardConversionForOtherController:OnHide()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UIDrawCardAwardConversionForOtherController:CloseOnClick()
  self:CloseDialog()
end

function UIDrawCardAwardConversionForOtherController:ConversiontagOnClick()
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self._conversion:SetActive(true)
  self.converseContent:SpawnObjects("UIDrawCardAwardConversionItem", 4)
  local items = self.converseContent:GetAllSpawnList()
  for idx, value in ipairs(items) do
    value:SetData(idx)
  end
end
