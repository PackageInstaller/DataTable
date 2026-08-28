local View = require("UIUnlockedChoose/UIUnlockedChooseView")
local DataModel = require("UIUnlockedChoose/UIUnlockedChooseDataModel")
local ViewFunction = require("UIUnlockedChoose/UIUnlockedChooseViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.data = initParams ~= nil and initParams ~= "" and Json.decode(initParams) or {}
    DataModel.RefreshCurrency()
    local costCfg = DataModel.data.costId and PlayerData:GetFactoryData(DataModel.data.costId, "ListFactory") or nil
    DataModel.data.cfg = costCfg
    local materialList = costCfg and costCfg.materialList or {}
    local listNum = #materialList
    for i = 1, 5 do
      local element = View.Group_Balloon["Group_Choose" .. i]
      if i <= listNum then
        element.self:SetActive(true)
        DataModel.SetElement(materialList[i], element)
      else
        element.self:SetActive(false)
      end
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  perupdate = function()
  end,
  update = function()
  end,
  ondestroy = function()
    DataModel.data = nil
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
