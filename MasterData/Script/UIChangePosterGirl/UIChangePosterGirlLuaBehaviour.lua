local View = require("UIChangePosterGirl/UIChangePosterGirlView")
local DataModel = require("UIChangePosterGirl/UIChangePosterGirlDataModel")
local Controller = require("UIChangePosterGirl/UIChangePosterGirlController")
local ViewFunction = require("UIChangePosterGirl/UIChangePosterGirlViewFunction")

local function GetAdjutantRoleIdList()
  local userInfo = PlayerData and PlayerData.ServerData and PlayerData.ServerData.user_info or nil
  return userInfo and userInfo.adjutant_id or {}
end

local function GetChoseBGDataModel()
  local ok, choseBGDataModel = pcall(require, "UIChoseBG/UIChoseBGDataModel")
  if not ok then
    return nil
  end
  return choseBGDataModel
end

local function IsChoseBGReturn(choseBGDataModel)
  return choseBGDataModel ~= nil and choseBGDataModel.HasReturnSelectRoomBackId and choseBGDataModel.HasReturnSelectRoomBackId()
end

local function HasInitParams(initParams)
  return initParams ~= nil and initParams ~= ""
end

local function GetChoseBGReturnParams(choseBGDataModel)
  if not IsChoseBGReturn(choseBGDataModel) then
    return nil
  end
  return {
    roleId = GetAdjutantRoleIdList(),
    scene = "Adjutant"
  }
end

local function HasRoleIdList(roleId)
  return type(roleId) == "table" and next(roleId) ~= nil
end

local function GetCurrentParams()
  return {
    roleId = DataModel.RoleId,
    scene = DataModel.Scene,
    tabIndex = DataModel.curSelectTab
  }
end

local Luabehaviour = {
  serialize = function()
    if DataModel.ConsumeSerializeOnGetwayJump == nil or not DataModel.ConsumeSerializeOnGetwayJump() then
      return
    end
    return Json.encode(GetCurrentParams())
  end,
  deserialize = function(initParams)
    local choseBGDataModel = GetChoseBGDataModel()
    local isChoseBGReturn = IsChoseBGReturn(choseBGDataModel)
    local params
    if HasInitParams(initParams) then
      params = Json.decode(initParams)
    elseif isChoseBGReturn then
      params = GetChoseBGReturnParams(choseBGDataModel)
    end
    params = params or {}
    DataModel.FirstFrame = true
    DataModel.RoleId = params.roleId
    DataModel.Scene = params.scene
    DataModel.ReturnTabIndex = params.tabIndex
    if not HasRoleIdList(DataModel.RoleId) then
      DataModel.RoleId = DataModel.SetRoleId(false, true)
    end
    Controller:Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.FirstFrame then
      DataModel.FirstFrame = false
      if MainManager.bgSceneName == "Main" then
        local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
        if not TradeDataModel.GetInTravel() then
          TrainCameraManager:OpenCamera(1)
        else
          TrainCameraManager:OpenCamera(0)
        end
      else
        TrainCameraManager:OpenCamera(2)
      end
    end
  end,
  ondestroy = function()
    DataModel.curSelectTab = nil
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
