local View = require("UIMainFinish/UIMainFinishView")
local DataModel = {}
DataModel.showTempLeft = 0
DataModel.showRevive = 0

function DataModel.SetJsonData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
  DataModel.showTempLeft = data.showTempLeft
  DataModel.showRevive = data.showRevive
end

function DataModel.InitData()
end

function DataModel.RefreshOnShow()
  local parkMapCA = PlayerData:GetFactoryData(60600002, "ParkMapFactory")
  local showTempLeft = DataModel.showTempLeft == 1
  local showRevive = DataModel.showRevive == 1
  View.Group_Btn.Btn_Furlough:SetActive(showTempLeft)
  View.Group_Btn.Btn_Revive:SetActive(showRevive)
  if showRevive then
    local reviveNum = WitchData.GetReviveNum()
    View.Group_Btn.Btn_Revive.Txt_Num:SetText(string.format(GetText(80610471), reviveNum, parkMapCA.reviveLimit))
    local costInfo = parkMapCA.reviveCost[reviveNum + 1]
    if costInfo then
      View.Group_Btn.Btn_Revive.Group_RevivieCost.Txt_Num:SetText(costInfo.num)
    end
  end
  View.Group_Title.Txt_Revive:SetActive(showRevive)
  View.Group_Title.Txt_Finish:SetActive(not showRevive)
end

function DataModel.ReturnHome()
  local UIWitchMainDataModel = require("UIWitchMain/UIWitchMainDataModel")
  
  local function cb()
    local SliceSceneManager = CBus:GetManager(CS.ManagerName.SliceSceneManager, true)
    if SliceSceneManager then
      SliceSceneManager.loadedScene:Clear()
    end
    CBus:ChangeScene(UIWitchMainDataModel.backSceneName, function()
      UIManager:Open(UIWitchMainDataModel.backUI, Json.encode(UIWitchMainDataModel.backUIParams))
    end)
    GameSetting:LoadPlayerSetting()
    PlayerData:ResetCharacterFilter()
    PlayerData:ResetSuaqsFilter()
    PlayerData:ResetDepotFilter()
    if PlayerData.Last_Chapter_Parms and PlayerData.Last_Chapter_Parms.isWitchBattle then
      PlayerData.Last_Chapter_Parms = nil
      PlayerData.BattleCallBackPage = ""
    end
    local WitchMainDataController = require("UIWitchMain/UIWitchMainDataController")
    WitchMainDataController:Clear()
    WitchMainDataController = nil
  end
  
  CommonTips.OpenLoadingCB(cb)
end

function DataModel.AbandonActivity()
  local function cb(json)
    local params = {}
    
    params.win = 0
    params.reward = json.reward or {}
    UIManager:Open("UI/Witches/Main/SettleAccount", Json.encode(params), DataModel.ReturnHome)
    PlayerData:SetPlayerPrefs("int", "WitchShowTicket", 0)
  end
  
  WitchData.ReqLeftActivity(WitchData.ELeftType.Abandon, cb)
end

function DataModel.TempLeftActivity()
  local function cb(json)
    DataModel.ReturnHome()
  end
  
  WitchData.ReqLeftActivity(WitchData.ELeftType.Temp, cb)
end

function DataModel.ReviveActivity()
  if not WitchData.IsCanRevive() then
    return
  end
  local parkCA = PlayerData:GetFactoryData(60600002, "ParkMapFactory")
  local reviveNum = WitchData.GetReviveNum() + 1
  local costInfo = parkCA.reviveCost[reviveNum]
  if not costInfo then
    return
  end
  
  local function yesFun()
    local function cb()
      View.self:CloseUI(true)
      
      CommonTips.OpenWitchTip(80610329)
    end
    
    WitchData.ReqLeftActivity(WitchData.ELeftType.Revive, cb)
  end
  
  local itemId = costInfo.id
  local itemCA = PlayerData:GetFactoryData(itemId)
  local params = {}
  params.itemId = itemId
  params.useNum = costInfo.num
  CommonTips.OpenWitchPrompt(string.format(GetText(80610328), itemCA.textIcon, costInfo.num), nil, nil, yesFun)
end

return DataModel
