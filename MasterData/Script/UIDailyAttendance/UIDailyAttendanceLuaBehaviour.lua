local View = require("UIDailyAttendance/UIDailyAttendanceView")
local DataModel = require("UIDailyAttendance/UIDailyAttendanceDataModel")
local ViewFunction = require("UIDailyAttendance/UIDailyAttendanceViewFunction")
local Controller = require("UIDailyAttendance/UIDailyAttendanceController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      DataModel.SetJsonData(initParams)
    else
      DataModel.isAutoShow = false
    end
    Controller:InitView()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if GuideManager:GetCurrentClientGuideNO() > 0 and not DataModel.IsPanelClosing then
      View.self:StartC(LuaUtil.cs_generator(function()
        DataModel.IsPanelClosing = true
        coroutine.yield(CS.UnityEngine.WaitForSeconds(3))
        if DataModel.isAutoShow then
          UIManager:CloseTip("UI/DailyAttendance/DailyAttendance")
        else
          UIManager:GoBack()
        end
        DataModel.IsPanelClosing = false
      end))
    end
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
