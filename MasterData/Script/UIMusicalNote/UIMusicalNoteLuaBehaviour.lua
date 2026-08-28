local View = require("UIMusicalNote/UIMusicalNoteView")
local DataModel = require("UIMusicalNote/UIMusicalNoteDataModel")
local ViewFunction = require("UIMusicalNote/UIMusicalNoteViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.lastVal = -1
    if UIManager:IsPanelOpened("UI/Battle/BattleResourcesCount/VoltageValue/VoltageValue") then
      View.Group_NoteLevel0:SetLocalPositionY(-120)
      View.Group_NoteLevel1:SetLocalPositionY(-120)
    end
    View.Group_NoteLevel0.self:SetActive(false)
    View.Group_NoteLevel1.self:SetActive(false)
    ViewFunction.UpdateVal(true)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    ViewFunction.UpdateVal(false)
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
