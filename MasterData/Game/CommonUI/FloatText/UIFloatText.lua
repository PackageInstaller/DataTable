local UIFloatText = class("UIFloatText", UIBaseWindow)
local base = UIBaseWindow
local UIFloatTextItem = require("Game.CommonUI.FloatText.UIFloatTextItem")
local MinIntervalShowText = 30

function UIFloatText:OnInit()
  self.__update_handle = BindCallback(self, self.Update)
  UpdateManager:AddUpdate(self.__update_handle)
  self.floatTextItemPool = UIItemPool.New(UIFloatTextItem, self.ui.floatTextItem)
  self.textDataQue = {}
  self.lastShowTextFrame = 0
end

function UIFloatText:Update()
  self.lastShowTextFrame = math.max(0, self.lastShowTextFrame - 1)
  if self.lastShowTextFrame == 0 and 0 < #self.textDataQue then
    local textData = table.remove(self.textDataQue, 1)
    self:__ShowTextInternal(textData)
    self.lastShowTextFrame = MinIntervalShowText
  end
end

function UIFloatText:ShowFloatText(position, textContent, color)
  local data = {
    position = position,
    textContent = textContent,
    color = color
  }
  table.insert(self.textDataQue, data)
end

function UIFloatText:__ShowTextInternal(textData)
  local item = self.floatTextItemPool:GetOne()
  item:InitFloatTextItem(textData.position, textData.textContent, textData.color, BindCallback(self, self.RecoveryFloatText))
end

function UIFloatText:RecoveryFloatText(floatTextItem)
  self.floatTextItemPool:HideOne(floatTextItem)
end

function UIFloatText:OnDelete()
  UpdateManager:RemoveUpdate(self.__update_handle)
  self.floatTextItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIFloatText
