_class("UISeasonMazeBeadAutoSynItem", UICustomWidget)
UISeasonMazeBeadAutoSynItem = UISeasonMazeBeadAutoSynItem

function UISeasonMazeBeadAutoSynItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeBeadAutoSynItem:InitWidget()
  self._choiceMark = self:GetUIComponent("Image", "ChoiceMark")
  self._beads = {}
  self._beads[1] = self:GetUIComponent("UISelectObjectPath", "B1")
  self._beads[2] = self:GetUIComponent("UISelectObjectPath", "B2")
  self._beads[3] = self:GetUIComponent("UISelectObjectPath", "B3")
end

function UISeasonMazeBeadAutoSynItem:SetData(index, data, tipsCallBack, choiceCallBack, preViewFunc)
  self._index = index
  self._data = data
  self._tipsCallBack = tipsCallBack
  self._choiceCallBack = choiceCallBack
  self._widgets = {}
  for index, value in ipairs(self._beads) do
    local widget = value:SpawnObject("UISeasonMazeBeadItem")
    self._widgets[index] = widget
    if index < 3 then
      widget:SetData(index, data.beadData[index], function(uid, id, position)
        self._tipsCallBack(uid, id, position)
      end, SeasonMazeBeadItemType.SynthesisList)
    end
  end
  preViewFunc(self._widgets[3], SeasonMazeBeadData:New(0, self._widgets[1]:Data()), SeasonMazeBeadData:New(0, self._widgets[2]:Data()))
  self:OnChoice()
end

function UISeasonMazeBeadAutoSynItem:ChoiceOnClick(go)
  self._data.choice = not self._data.choice
  self:OnChoice()
  self._choiceCallBack()
end

function UISeasonMazeBeadAutoSynItem:OnChoice()
  self._choiceMark.enabled = self._data.choice
end
