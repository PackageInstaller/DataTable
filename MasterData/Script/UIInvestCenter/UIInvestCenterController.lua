local View = require("UIInvestCenter/UIInvestCenterView")
local DataModel = require("UIInvestCenter/UIInvestCenterDataModel")
local NPCDialog = require("Common/NPCDialog")
local Controller = {}

local function SetActive(ctr, active)
  if ctr == nil then
    return
  end
  if ctr.SetActive then
    ctr:SetActive(active)
  elseif ctr.self and ctr.self.SetActive then
    ctr.self:SetActive(active)
  end
end

local function IsActive(ctr)
  if ctr == nil then
    return false
  end
  if ctr.self then
    return ctr.self.IsActive == true
  end
  return ctr.IsActive == true
end

local function SetText(ctr, text)
  if ctr and ctr.SetText then
    ctr:SetText(tostring(text or ""))
  end
end

local function SetSprite(ctr, path)
  if ctr and ctr.SetSprite then
    ctr:SetSprite(path or "")
  end
end

local function SetColor(ctr, color)
  if ctr and ctr.SetColor then
    ctr:SetColor(color or "#FFFFFF")
  end
end

local function SetFilledImgAmount(ctr, amount)
  if ctr and ctr.SetFilledImgAmount then
    ctr:SetFilledImgAmount(amount or 0)
  end
end

local function RefreshScrollGrid(scrollGrid, count)
  if scrollGrid and scrollGrid.grid and scrollGrid.grid.self then
    scrollGrid.grid.self:SetDataCount(count or 0)
    scrollGrid.grid.self:RefreshAllElement()
  end
end

local function GetTalkButton()
  return View.Group_Main and View.Group_Main.Group_Btn and View.Group_Main.Group_Btn.Btn_Talk or nil
end

function Controller:SetNPC()
  local npcId = tonumber(DataModel.NpcId) or 0
  local npcConfig = 0 < npcId and PlayerData:GetFactoryData(npcId, "NPCFactory") or nil
  if not npcConfig then
    SetActive(View.Group_NPC, false)
    return
  end
  NPCDialog.SetNPC(View.Group_NPC, npcId)
  local stations = PlayerData:GetHomeInfo().stations
  if stations and stations[tostring(DataModel.StationId)] then
    local ok, homeCommon = pcall(require, "Common/HomeCommon")
    local repLv = homeCommon.GetRepLv(DataModel.StationId)
    NPCDialog.HandleNPCTxtTable({repLv = repLv})
  else
    NPCDialog.HandleNPCTxtTable(nil)
  end
end

function Controller:ShowNPCTalk(dialogEnum)
  if dialogEnum == DataModel.NPCDialogEnum.talkText then
    local result = QuestProcess.CheckTalkDo(DataModel.CacheEventList or {}, View, DataModel.BuildingId, function()
      SetActive(View.Group_Main, true)
    end)
    if result then
      if result == 2 then
        SetActive(View.Group_Main, false)
      end
      return
    end
  end
  local npcId = tonumber(DataModel.NpcId) or 0
  local npcConfig = 0 < npcId and PlayerData:GetFactoryData(npcId, "NPCFactory") or nil
  local textTable = npcConfig and npcConfig[dialogEnum] or nil
  if textTable == nil then
    return
  end
  NPCDialog.SetNPCText(View.Group_NPC, textTable, dialogEnum)
end

function Controller:CheckQuestProcess()
  local talkBtn = GetTalkButton()
  if not talkBtn then
    return
  end
  if (tonumber(DataModel.BuildingId) or 0) <= 0 then
    DataModel.CacheEventList = {}
    SetActive(talkBtn.Img_RedPoint, false)
    SetText(talkBtn.Txt_, GetText(80602502))
    return
  end
  local params = {}
  params.url = View.self.url
  local battleInfo = PlayerData.BattleInfo or {}
  local status = {
    Current = "Chapter",
    squadIndex = battleInfo.squadIndex,
    hasOpenThreeView = false
  }
  local extraUIParamData = {}
  if DataModel.initParams then
    for k, v in pairs(DataModel.initParams) do
      extraUIParamData[k] = v
    end
  end
  extraUIParamData.stationId = DataModel.StationId
  extraUIParamData.buildingId = DataModel.BuildingId
  extraUIParamData.npcId = DataModel.NpcId
  extraUIParamData.bgPath = DataModel.BgPath
  extraUIParamData.bgColor = DataModel.BgColor
  status.extraUIParamData = extraUIParamData
  params.status = status
  DataModel.CacheEventList = QuestProcess.CheckEventOpen(DataModel.BuildingId, params)
  local count = #(DataModel.CacheEventList or {})
  SetActive(talkBtn.Img_RedPoint, 0 < count)
  if 0 < count then
    QuestProcess.AddQuestCallBack(View.self.url, function()
      Controller:CheckQuestProcess()
    end)
    if count == 1 then
      local questCA = PlayerData:GetFactoryData(DataModel.CacheEventList[1].questId)
      SetText(talkBtn.Txt_, questCA and questCA.name or GetText(80602502))
    else
      SetText(talkBtn.Txt_, GetText(80602502))
    end
  else
    SetText(talkBtn.Txt_, GetText(80602502))
  end
end

function Controller:RefreshNPCInfo()
  if not string.nilorempty(DataModel.BgPath) then
    SetSprite(View.Img_BG, DataModel.BgPath)
  end
  SetColor(View.Img_BG, DataModel.BgColor)
  Controller:SetNPC()
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
  Controller:CheckQuestProcess()
end

function Controller:Init()
  DataModel.InitStationConfig()
  Controller:RefreshNPCInfo()
  SetActive(View.Group_GoodsTrade, false)
  SetActive(View.Group_spItem, false)
  SetActive(View.Group_GoodsTradeMission, false)
  SetActive(View.Group_Main, true)
  if DataModel.StationCA and View.Group_Main and View.Group_Main.Group_NpcInfo then
    SetText(View.Group_Main.Group_NpcInfo.Group_Dingwei.Txt_Station, DataModel.StationCA.name)
  end
end

function Controller:ReturnToMain()
  SetActive(View.Group_GoodsTradeMission, false)
  SetActive(View.Group_GoodsTrade, false)
  SetActive(View.Group_spItem, false)
  SetActive(View.Group_Main, true)
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
  Controller:CheckQuestProcess()
end

function Controller:OnReturnClick()
  if IsActive(View.Group_GoodsTradeMission) then
    Controller:CloseGoodsTradeMission()
    return
  end
  if IsActive(View.Group_GoodsTrade) or IsActive(View.Group_spItem) then
    Controller:ReturnToMain()
    return
  end
  UIManager:GoBack()
end

function Controller:OpenGoodsTrade()
  DataModel.InitStationConfig()
  SetActive(View.Group_Main, false)
  SetActive(View.Group_spItem, false)
  SetActive(View.Group_GoodsTradeMission, false)
  SetActive(View.Group_GoodsTrade, true)
  Controller:RefreshGoodsTrade()
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.investQuestText)
end

function Controller:OpenGoodsTradeMission(isIn)
  DataModel.InitStationConfig()
  SetActive(View.Group_GoodsTradeMission, true)
  SetActive(View.Group_GoodsTradeMission.Group_In, isIn)
  SetActive(View.Group_GoodsTradeMission.Group_Out, not isIn)
  local group = isIn and View.Group_GoodsTradeMission.Group_In or View.Group_GoodsTradeMission.Group_Out
  local dataList = isIn and DataModel.InMissionList or DataModel.OutMissionList
  group.ScrollGrid_.grid.self:SetDataCount(#dataList)
  group.ScrollGrid_.grid.self:RefreshAllElement()
end

function Controller:CloseGoodsTradeMission()
  SetActive(View.Group_GoodsTradeMission, false)
end

function Controller:OpenGoodsInvest()
  DataModel.InitStationConfig()
  SetActive(View.Group_Main, false)
  SetActive(View.Group_GoodsTrade, false)
  SetActive(View.Group_GoodsTradeMission, false)
  SetActive(View.Group_spItem, true)
  Controller:RefreshSpItemPanel()
end

function Controller:RefreshGoodsTrade()
  Controller:RefreshTradeGroup(View.Group_GoodsTrade.Group_In, DataModel.InProgress, #DataModel.InBuffList)
  Controller:RefreshTradeGroup(View.Group_GoodsTrade.Group_Out, DataModel.OutProgress, #DataModel.OutBuffList)
end

function Controller:RefreshTradeGroup(group, progressInfo, buffCount)
  if not group then
    return
  end
  progressInfo = progressInfo or {}
  local finishCount = progressInfo.finishCount or 0
  local totalCount = progressInfo.totalCount or 0
  local progress = 0 < totalCount and finishCount / totalCount or 0
  local isMax = progressInfo.isMax == true
  local totalMoney = progressInfo.totalMoney or 0
  SetFilledImgAmount(group.Img_barU, progress)
  SetText(group.Txt_num, tostring(finishCount))
  SetText(group.Txt_coin, 0)
  SetActive(group.Txt_LV, not isMax)
  SetActive(group.Txt_num, not isMax)
  SetActive(group.Txt_numMax, isMax)
  SetSprite(group.Img_coin, DataModel.GetStationCurrencyIcon())
  SetText(group.Txt_coin, tostring(totalMoney))
  group.ScrollGrid_.grid.self:SetDataCount(buffCount or 0)
  group.ScrollGrid_.grid.self:RefreshAllElement()
  SetActive(group.Img_Lv0, finishCount <= 0)
end

function Controller:RefreshTradeElement(element, elementIndex, dataList)
  local info = dataList and dataList[elementIndex]
  if not info then
    return
  end
  if info.Buff1 <= 0 or info.Buff1 == "" then
    SetActive(element.Img_Buff1, false)
  else
    SetActive(element.Img_Buff1, true)
    SetText(element.Img_Buff1.Txt_, GetText(info.Buff1))
  end
  if 0 >= info.Buff2 or info.Buff2 == "" then
    SetActive(element.Img_Buff2, false)
  else
    SetActive(element.Img_Buff2, true)
    SetText(element.Img_Buff2.Txt_, GetText(info.Buff1))
  end
  SetSprite(element.Img_Item, DataModel.GetGoodsImagePath(info.content))
end

function Controller:RefreshMissionElement(element, elementIndex, dataList)
  local info = dataList and dataList[elementIndex]
  if not info then
    return
  end
  local questCA = info.questCA
  SetText(element.Txt_QuestName, questCA and questCA.name or "")
  SetText(element.Txt_Detail, questCA and questCA.story or "")
  SetText(element.Txt_Bar, tostring(info.curCount or 0) .. "/" .. tostring(info.maxCount or 0))
  SetActive(element.Group_Max, info.isFinish)
  element.ScrollGrid_Item.grid.self:SetParentParam(elementIndex)
  element.ScrollGrid_Item.grid.self:SetDataCount(#(info.goodsList or {}))
  element.ScrollGrid_Item.grid.self:RefreshAllElement()
end

function Controller:RefreshMissionGoodsElement(element, elementIndex, dataList)
  local parentIndex = tonumber(element.ParentParam)
  local missionInfo = dataList and dataList[parentIndex]
  local goodsInfo = missionInfo and missionInfo.goodsList and missionInfo.goodsList[elementIndex]
  if not goodsInfo then
    return
  end
  SetSprite(element.Img_Item, goodsInfo.imagePath)
  element.Btn_detail:SetClickParam(goodsInfo.goodsId)
end

function Controller:RefreshInMissionElement(element, elementIndex)
  Controller:RefreshMissionElement(element, elementIndex, DataModel.InMissionList)
end

function Controller:RefreshOutMissionElement(element, elementIndex)
  Controller:RefreshMissionElement(element, elementIndex, DataModel.OutMissionList)
end

function Controller:RefreshInMissionGoodsElement(element, elementIndex)
  Controller:RefreshMissionGoodsElement(element, elementIndex, DataModel.InMissionList)
end

function Controller:RefreshOutMissionGoodsElement(element, elementIndex)
  Controller:RefreshMissionGoodsElement(element, elementIndex, DataModel.OutMissionList)
end

function Controller:RefreshSpItemPanel()
  DataModel.ApplySpItemGoodsQuery(nil)
  local idStr = DataModel.GetSpItemQuotationIdStr()
  if string.nilorempty(idStr) then
    return
  end
  local stationId = DataModel.StationId
  Net:SendProto("station.query_goods", function(json)
    if stationId ~= DataModel.StationId then
      return
    end
    if json and string.nilorempty(json.rc) then
      DataModel.ApplySpItemGoodsQuery(json)
      DataModel.RefreshSpItemData()
      RefreshScrollGrid(View.Group_spItem and View.Group_spItem.ScrollGrid_, #DataModel.SpItemList)
    end
  end, stationId, idStr)
end

function Controller:RefreshSpItemElement(element, elementIndex)
  local info = DataModel.SpItemList and DataModel.SpItemList[elementIndex]
  if not info then
    return
  end
  local goodCA = info.goodCA
  local costInfo = info.costInfo or {}
  SetSprite(element.Img_, goodCA and goodCA.imagePath or "")
  SetText(element.Txt_Name, goodCA and goodCA.name or "")
  SetText(element.Txt_LvNum, info.lvText)
  local questCa = info.questCa or {}
  SetText(element.Group_NoMax.Txt_Detail, questCa.story or "")
  if element.Img_Frame then
    SetText(element.Img_Frame.Img_Buy and element.Img_Frame.Img_Buy.Txt_num, tostring(DataModel.GetRoundNum(info.buyNum or 0)))
    SetText(element.Img_Frame.Img_have and element.Img_Frame.Img_have.Txt_num, info.inventoryText or "")
  end
  SetActive(element.Group_NoMax, not info.isMax)
  SetActive(element.Group_Max, info.isMax)
  if element.Group_NoMax and element.Group_NoMax.Img_Bg then
    SetActive(element.Group_NoMax.Img_Bg.Txt_pay, info.isUnlock)
    SetActive(element.Group_NoMax.Img_Bg.Txt_unlock, not info.isUnlock)
    SetText(element.Group_NoMax.Img_Bg.Txt_coinNum, tostring(costInfo.num or 0))
    SetSprite(element.Group_NoMax.Img_Bg.Img_coin, costInfo.icon)
  end
  if element.Btn_Item and element.Btn_Item.SetClickParam then
    element.Btn_Item:SetClickParam(elementIndex)
  end
  if element.Group_NoMax and element.Group_NoMax.Btn_ and element.Group_NoMax.Btn_.SetClickParam then
    element.Group_NoMax.Btn_:SetClickParam(elementIndex)
  end
end

function Controller:OnSpItemClick(idx)
  idx = tonumber(idx)
  local info = idx and DataModel.SpItemList and DataModel.SpItemList[idx] or nil
  if info and info.goodCA then
    CommonTips.OpenGoodsTips(info.goodCA.id)
  end
end

function Controller:OnSpItemUpgrade(idx)
  idx = tonumber(idx)
  if not idx then
    return
  end
  local info = DataModel.SpItemList and DataModel.SpItemList[idx] or nil
  if not info or info.isMax or not info.currentQuestId then
    return
  end
  local costInfo = info.costInfo or DataModel.GetQuestCostInfo(info.currentQuestId)
  if costInfo.id and 0 < (costInfo.num or 0) then
    local goodsInfo = PlayerData:GetGoodsById(costInfo.id) or {}
    if (goodsInfo.num or 0) < costInfo.num then
      CommonTips.OpenTips(80600539)
      return
    end
  end
  Net:SendProto("quest.complete_quest", function(json)
    if json and string.nilorempty(json.rc) then
      DataModel.RefreshQuestServerData(json.current_quests)
      if costInfo.id and 0 < (costInfo.num or 0) then
        PlayerData:RefreshUseItems({
          [costInfo.id] = costInfo.num
        })
      end
      Controller:RefreshSpItemPanel()
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.investSuccessText)
    else
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.investFailText)
    end
  end, info.currentQuestId)
end

function Controller:RefreshInElement(element, elementIndex)
  Controller:RefreshTradeElement(element, elementIndex, DataModel.InBuffList)
end

function Controller:RefreshOutElement(element, elementIndex)
  Controller:RefreshTradeElement(element, elementIndex, DataModel.OutBuffList)
end

return Controller
