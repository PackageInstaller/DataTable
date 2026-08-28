local View = require("UIHomeTrade/UIHomeTradeView")
local DataModel = require("UIHomeTrade/UIWarehouseDataModel")
local MainDataModel = require("UIHomeTrade/UIHomeTradeDataModel")
local MainController = require("UIHomeTrade/UIHomeTradeController")
local TradeDataModel = require("UIHomeTrade/UITradeDataModel")
local Controller = {}

function Controller:Init()
  Net:SendProto("station.get_warehouse_info", function(json)
    if json.warehouse then
      if PlayerData.ServerData.user_home_info == nil then
        PlayerData.ServerData.user_home_info = {}
        PlayerData.ServerData.user_home_info.warehouse = {}
      end
      PlayerData.ServerData.user_home_info.warehouse = json.warehouse
    end
    if json.warehouse_cache then
      if PlayerData.ServerData.user_home_info == nil then
        PlayerData.ServerData.user_home_info = {}
        PlayerData.ServerData.user_home_info.warehouse_cache = {}
      end
      PlayerData.ServerData.user_home_info.warehouse_cache = json.warehouse_cache
    end
    MainDataModel.IsWarehouseOpen = true
    View.self:PlayAnim("Warehouse")
    View.Group_Main.self:SetActive(false)
    UIManager:LoadSplitPrefab(View, "UI/HomeTrade/HomeTrade", "Group_Warehouse")
    View.Group_Warehouse.self:SetActive(true)
    DataModel.Init()
    MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.openWarehouseText)
    Controller:RefreshTopShow()
    local homeCommon = require("Common/HomeCommon")
    homeCommon.SetReputationElement(View.Group_Warehouse.Group_Reputation, MainDataModel.StationId)
    local stationCA = PlayerData:GetFactoryData(MainDataModel.StationId, "HomeStationFactory")
    View.Group_Warehouse.Group_NpcInfoL.Group_Station.Txt_Station:SetText(stationCA.name)
    Controller:RefreshCurGoodsBatchMode(2)
    Controller:RefreshStationGoodsBatchMode(2)
    Controller:RefreshCurGoodsShow()
    Controller:RefreshStationGoodsShow()
  end)
end

function Controller:RefreshTopShow()
  local remainCount = DataModel.GetRemainStationSpace()
  View.Group_Warehouse.Group_Resources.Group_TradeLv.Txt_Num:SetText(string.format(GetText(80601085), remainCount))
  local goldIcon, goldNum = TradeDataModel.GetStationGoldIconAndNum()
  View.Group_Warehouse.Group_Resources.Group_GoldCoin.Txt_Num:SetText(goldNum or 0)
  View.Group_Warehouse.Group_Resources.Group_GoldCoin.Img_Icon:SetSprite(goldIcon or "")
end

function Controller:RefreshCurGoodsShow()
  if #DataModel.CurGoods == 0 then
    View.Group_Warehouse.Group_Saveget.Group_Train.Img_Kong:SetActive(true)
    View.Group_Warehouse.Group_Saveget.Group_Train.ScrollGrid_GoodsList.self:SetActive(false)
  else
    View.Group_Warehouse.Group_Saveget.Group_Train.Img_Kong:SetActive(false)
    View.Group_Warehouse.Group_Saveget.Group_Train.ScrollGrid_GoodsList.self:SetActive(true)
    View.Group_Warehouse.Group_Saveget.Group_Train.ScrollGrid_GoodsList.grid.self:SetDataCount(#DataModel.CurGoods)
    View.Group_Warehouse.Group_Saveget.Group_Train.ScrollGrid_GoodsList.grid.self:RefreshAllElement()
  end
  Controller:RefreshCurGoodsSpace()
end

function Controller:RefreshStationGoodsShow()
  if #DataModel.StationGoods == 0 then
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.Img_Kong:SetActive(true)
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.ScrollGrid_GoodsList.self:SetActive(false)
  else
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.Img_Kong:SetActive(false)
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.ScrollGrid_GoodsList.self:SetActive(true)
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.ScrollGrid_GoodsList.grid.self:SetDataCount(#DataModel.StationGoods)
    View.Group_Warehouse.Group_Saveget.Group_Warehouse.ScrollGrid_GoodsList.grid.self:RefreshAllElement()
  end
  Controller:RefreshStationGoodsSpace()
end

function Controller:ClickCurGoods(idx)
  local data = DataModel.CurGoods[idx]
  if data.info.isGoods then
    CommonTips.OpenTips(80601101)
    return
  end
  if DataModel.CurGoodsBatchMode == 1 then
    MainController:OpenBatchPanel(data, idx, 2)
  else
    Controller:CurToStation(idx, data.num)
  end
end

function Controller:CurToStation(idx, num)
  if DataModel.CurToStation(idx, num) then
    Controller:RefreshCurGoodsShow()
    Controller:RefreshStationGoodsShow()
  end
end

function Controller:ClickStationGoods(idx)
  local data = DataModel.StationGoods[idx]
  if DataModel.StationGoodsBatchMode == 1 then
    MainController:OpenBatchPanel(data, idx, 3)
  else
    Controller:StationToCur(idx, data.num)
  end
end

function Controller:StationToCur(idx, num)
  if DataModel.StationToCur(idx, num) then
    Controller:RefreshCurGoodsShow()
    Controller:RefreshStationGoodsShow()
  end
end

function Controller:RefreshCurGoodsBatchMode(mode)
  if DataModel.CurGoodsBatchMode == mode then
    return
  end
  DataModel.CurGoodsBatchMode = mode
  View.Group_Warehouse.Group_Saveget.Group_Train.Btn_Batch.Group_Off.self:SetActive(mode ~= 1)
  View.Group_Warehouse.Group_Saveget.Group_Train.Btn_Max.Group_Off.self:SetActive(mode ~= 2)
  View.Group_Warehouse.Group_Saveget.Group_Train.Btn_Batch.Group_On.self:SetActive(mode == 1)
  View.Group_Warehouse.Group_Saveget.Group_Train.Btn_Max.Group_On.self:SetActive(mode == 2)
end

function Controller:RefreshCurGoodsSpace()
  local element = View.Group_Warehouse.Group_Saveget.Group_Train
  element.Txt_Space:SetText(DataModel.CurGoodsSpace .. "/" .. DataModel.CurGoodsMaxSpace)
  element.Img_PBNow:SetFilledImgAmount(DataModel.CurGoodsSpace / DataModel.CurGoodsMaxSpace)
end

function Controller:RefreshStationGoodsSpace()
  local element = View.Group_Warehouse.Group_Saveget.Group_Warehouse
  element.Txt_Space:SetText(DataModel.StationGoodsSpace .. "/" .. DataModel.StationGoodsMaxSpace)
  element.Img_PBNow:SetFilledImgAmount(DataModel.StationGoodsSpace / DataModel.StationGoodsMaxSpace)
end

function Controller:RefreshStationGoodsBatchMode(mode)
  if DataModel.StationGoodsBatchMode == mode then
    return
  end
  DataModel.StationGoodsBatchMode = mode
  View.Group_Warehouse.Group_Saveget.Group_Warehouse.Btn_Batch.Group_Off.self:SetActive(mode ~= 1)
  View.Group_Warehouse.Group_Saveget.Group_Warehouse.Btn_Max.Group_Off.self:SetActive(mode ~= 2)
  View.Group_Warehouse.Group_Saveget.Group_Warehouse.Btn_Batch.Group_On.self:SetActive(mode == 1)
  View.Group_Warehouse.Group_Saveget.Group_Warehouse.Btn_Max.Group_On.self:SetActive(mode == 2)
end

function Controller:RefreshElement(element, data, idx)
  local btnItem = require("Common/BtnItem")
  btnItem:SetItem(element.Group_Item, {
    id = data.info.id,
    num = data.num
  })
  element.Group_Item.Btn_Item:SetClickParam(idx)
  if element.Img_Order then
    element.Img_Order:SetActive(data.info.isGoods)
    element.Img_Not.self:SetActive(data.info.isGoods)
  end
end

function Controller:ClickExpandSpace()
  local t = {}
  t.stationId = MainDataModel.StationId
  t.npcId = MainDataModel.NpcId
  UIManager:Open("UI/HomeTrade/WarehouseOption", Json.encode(t))
end

function Controller:InnerReturnToMain()
  View.Group_Warehouse.self:SetActive(false)
  View.Group_Main.self:SetActive(true)
  View.self:PlayAnim("Main")
end

function Controller:ReturnToMain()
  MainDataModel.IsWarehouseOpen = false
  DataModel.DealWithGoods(function()
    Controller.InnerReturnToMain(self)
  end)
end

function Controller:GoHome()
  MainDataModel.IsWarehouseOpen = false
  DataModel.DealWithGoods(function()
    UIManager:GoHome()
  end)
end

return Controller
