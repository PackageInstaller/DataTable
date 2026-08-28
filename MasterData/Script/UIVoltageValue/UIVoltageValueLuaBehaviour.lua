local View = require("UIVoltageValue/UIVoltageValueView")
local DataModel = require("UIVoltageValue/UIVoltageValueDataModel")
local ViewFunction = require("UIVoltageValue/UIVoltageValueViewFunction")
local MusicalNoteView = require("UIMusicalNote/UIMusicalNoteView")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.lastVal = -1
    if UIManager:IsPanelOpened("UI/Battle/BattleResourcesCount/MusicalNote/MusicalNote") then
      MusicalNoteView.Group_NoteLevel0:SetLocalPositionY(-120)
      MusicalNoteView.Group_NoteLevel1:SetLocalPositionY(-120)
    end
    View.Group_VoltLevel0.self:SetActive(false)
    View.Group_VoltLevel1.self:SetActive(false)
    View.Group_VoltLevel2.self:SetActive(false)
    ViewFunction.UpdateVoltVal(true)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    ViewFunction.UpdateVoltVal(false)
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    if UIManager:IsPanelOpened("UI/Battle/BattleResourcesCount/MusicalNote/MusicalNote") then
      MusicalNoteView.Group_NoteLevel0:SetLocalPositionY(0)
      MusicalNoteView.Group_NoteLevel1:SetLocalPositionY(0)
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
