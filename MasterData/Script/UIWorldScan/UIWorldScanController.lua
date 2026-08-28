local DataModel = require("UIWorldScan/UIWorldScanDataModel")
local View = require("UIWorldScan/UIWorldScanView")
local Timer = require("Common/Timer")
local Controller = {}

function Controller:Init()
  Controller:refreshEventMap()
  Controller:refreshEventBtn()
  Controller:refreshAutoBtn()
  Controller:OpenBtnList()
  Controller:RefreshTimeShow(false)
  local polluteConfig = PlayerData:GetFactoryData(99900056, "ConfigFactory")
  local itemId = polluteConfig.scanCostList[1].id
  local itemCA = PlayerData:GetFactoryData(itemId)
  View.Btn_Scan.Img_Icon:SetSprite(itemCA.iconPath)
  local item = PlayerData:GetGoodsById(itemId)
  View.Group_Item.Img_Icon:SetSprite(itemCA.iconPath)
  View.Group_Item.Txt_Num:SetText(item.num)
  if DataModel.eventId then
    for k, v in ipairs(DataModel.eventList) do
      if v.eventId == DataModel.eventId then
        Controller:ClickEvent(k, true, true)
        break
      end
    end
  elseif DataModel.isAuto == true then
    if #DataModel.autoTypeList > 0 then
      for i = 1, #DataModel.autoTypeList do
        for j = 1, #DataModel.eventList do
          local v = DataModel.eventList[j]
          if v.typeIndex == DataModel.autoTypeList[i] then
            Controller:ClickEvent(j, true, true)
            return
          end
        end
      end
      Controller:endAuto()
    else
      Controller:endAuto()
    end
  end
end

function Controller:refreshEventMap()
  if DataModel.eventObjList and table.count(DataModel.eventObjList) > 0 then
    for k, v in pairs(DataModel.eventObjList) do
      Object.Destroy(v)
    end
  end
  DataModel.eventObjList = {}
  if DataModel.eventList == nil or table.count(DataModel.eventList) == 0 then
    return
  end
  local EventParent = View.Group_Map.ScrollView_Map.Viewport.Content.Group_EventList.transform
  local Group_Event = "UI/Activity/ActivityGlobalBattle/Group_Event"
  local pathCa = PlayerData:GetFactoryData(99900021)
  for k = #DataModel.eventList, 1, -1 do
    local v = DataModel.eventList[k]
    local areaId = v.areaId
    local areaCfg = PlayerData:GetFactoryData(areaId)
    local currIndex = v.posIndex + 1
    local eventCfg = PlayerData:GetFactoryData(v.eventId, "AFKEventFactory")
    local obj = View.self:GetRes(Group_Event, EventParent)
    local x = 0
    local y = 0
    if v.type == "hidden" then
      local polluteConfig = PlayerData:GetFactoryData(99900056, "ConfigFactory")
      if polluteConfig and polluteConfig.ClickHiddenEventPosList[currIndex] then
        x = polluteConfig.ClickHiddenEventPosList[currIndex].icon_x
        y = polluteConfig.ClickHiddenEventPosList[currIndex].icon_y
      end
    elseif v.type == "dungeon" then
      if areaCfg.ClickDungeonEventPosList[currIndex] then
        x = areaCfg.ClickDungeonEventPosList[currIndex].icon_x / 2
        y = areaCfg.ClickDungeonEventPosList[currIndex].icon_y / 2
      else
        print(string.format("AreaFactory\229\183\165\229\142\130 %d ClickDungeonEventPosList \231\154\132%d\230\138\165\233\148\153 ", areaId, currIndex))
      end
    elseif v.type == "pollute" then
      if areaCfg.ClickEventPosList[currIndex] then
        x = areaCfg.ClickEventPosList[currIndex].icon_x / 2
        y = areaCfg.ClickEventPosList[currIndex].icon_y / 2
      else
        print(string.format("AreaFactory\229\183\165\229\142\130 %d \231\154\132ClickEventPosList \231\154\132%d\230\138\165\233\148\153 ", areaId, currIndex))
      end
    else
      local listCfg = PlayerData:GetFactoryData(v.listId, "ListFactory")
      local detail = listCfg.clickEventList[currIndex]
      if detail and detail.isShowUI then
        x = detail.icon_x / 2
        y = detail.icon_y / 2
      end
    end
    if pathCa then
      local img_On = obj.transform:Find("Group_On/Img_Icon"):GetComponent(typeof(CS.Seven.UIImg))
      local img_Off = obj.transform:Find("Group_Off/Img_Icon"):GetComponent(typeof(CS.Seven.UIImg))
      local Img_Round = obj.transform:Find("Group_Off/Img_Round"):GetComponent(typeof(CS.Seven.UIImg))
      img_On:SetSprite(pathCa.scanOnIconPath[v.iconIndex].path)
      img_Off:SetSprite(pathCa.scanOffIconPath[v.iconIndex].path)
      Img_Round:SetSprite(pathCa.scanOffRoundPath[v.iconIndex].path)
    end
    obj.transform.localPosition = Vector3(x, y, 0)
    obj:SetActive(true)
    local isOk = true
    local img_Icon = obj.transform:Find("Img_Icon"):GetComponent(typeof(CS.Seven.UIImg))
    if img_Icon == nil or img_Icon:IsNull() then
      print_r("Img_Icon Is Null !!!!!!")
      isOk = false
    else
      img_Icon:SetSprite(eventCfg.MapIconPath)
    end
    if not isOk then
      obj:SetActive(false)
    end
    local btn_event = obj.transform:Find("Btn_Event"):GetComponent(typeof(CS.Seven.UIBtn))
    btn_event:SetClickFunction(function()
      Controller:ClickEvent(k, true)
    end)
    if k == DataModel.indexSelected then
      obj.transform:Find("Group_On").gameObject:SetActive(true)
      obj.transform:Find("Group_Off").gameObject:SetActive(false)
    else
      obj.transform:Find("Group_On").gameObject:SetActive(false)
      obj.transform:Find("Group_Off").gameObject:SetActive(true)
    end
    table.insert(DataModel.eventObjList, 1, obj)
  end
end

function Controller:refreshEventBtn()
  View.Group_Btn.self:SetActive(false)
  local eventCount = DataModel.eventList == nil and 0 or table.count(DataModel.eventList)
  if 0 < eventCount then
    View.Group_Btn.self:SetActive(true)
    print_r(View.Group_Btn.ScrollGrid_BtnList.grid.self.IsActive)
    View.Group_Btn.ScrollGrid_BtnList.grid.self:SetDataCount(eventCount)
    View.Group_Btn.ScrollGrid_BtnList.grid.self:RefreshAllElement()
    local height = math.min(eventCount * 80 + (eventCount - 1) * 8 + 60, 692)
    View.Group_Btn.Img_Bg:SetHeight(height)
    Controller:setScrollHeight(View.Group_Btn.ScrollGrid_BtnList, eventCount)
    View.Group_Btn.ScrollGrid_BtnList.grid.self:MoveToTop()
    View.Group_Btn.Btn_Main.Txt_T:SetText(GetText(80612091))
  end
end

function Controller:setScrollHeight(ScrollNow, count)
  local maxHeight = 632
  local curHeight = 0
  curHeight = count * 80 + (count - 1) * 8
  if maxHeight < curHeight then
    ScrollNow.self:SetHeight(maxHeight)
    ScrollNow.grid.self.ScrollRect.enabled = true
  else
    ScrollNow.self:SetHeight(curHeight)
    ScrollNow.grid.self.ScrollRect.enabled = false
  end
end

function Controller:SetBtnEventGridElelment(element, elementIndex)
  local index = tonumber(elementIndex)
  element.Btn_Event:SetClickParam(index)
  local row = DataModel.eventList[index]
  local eventCA = PlayerData:GetFactoryData(row.eventId, "AFKEventFactory")
  element.Btn_Event.Txt_T:SetText(eventCA.name .. " Lv." .. row.lv)
  row.name = eventCA.name .. " Lv." .. row.lv
  local pathCa = PlayerData:GetFactoryData(99900021)
  if pathCa then
    element.Btn_Event.Img_Icon:SetSprite(pathCa.scanBtnIconPath[row.iconIndex].path)
  end
  if index == DataModel.indexSelected then
    element.Btn_Event.Img_Off:SetActive(false)
    element.Btn_Event.Img_On:SetActive(true)
    element.Btn_Event.Txt_T:SetColor("#282F2E")
    element.Btn_Event.Img_Icon:SetColor("#282F2E")
  else
    element.Btn_Event.Img_Off:SetActive(true)
    element.Btn_Event.Img_On:SetActive(false)
    element.Btn_Event.Txt_T:SetColor("#FFFFFF")
    element.Btn_Event.Img_Icon:SetColor("#FFFFFF")
  end
  row.element = element
end

function Controller:OpenBtnList()
  View.Group_Btn.Btn_Main.Img_Arrow:SetLocalScale(Vector3(1, DataModel.isOpenBtnList, 1))
  View.Group_Btn.ScrollGrid_BtnList.self:SetActive(DataModel.isOpenBtnList == 1 and true or false)
  View.Group_Btn.Img_Bg:SetActive(DataModel.isOpenBtnList == 1 and true or false)
end

function Controller:ClickEvent(index, isMove, isAuto)
  if isAuto == nil and DataModel.isAuto == true then
    Controller:endAuto()
  end
  if index == DataModel.indexSelected and isAuto == nil then
    Controller:releaseEvent()
    if UIManager:IsPanelOpened("UI/Chapter/Battle_DungeonScan") then
      UIManager:ClosePanel(false, "UI/Chapter/Battle_DungeonScan")
    end
    return
  end
  local eventObjOld = DataModel.eventObjList[DataModel.indexSelected]
  if eventObjOld then
    eventObjOld.transform:Find("Group_On").gameObject:SetActive(false)
    eventObjOld.transform:Find("Group_Off").gameObject:SetActive(true)
  end
  local eventObjCur = DataModel.eventObjList[index]
  if eventObjCur then
    eventObjCur.transform:Find("Group_On").gameObject:SetActive(true)
    eventObjCur.transform:Find("Group_Off").gameObject:SetActive(false)
  end
  if isMove == true then
    View.Group_Btn.ScrollGrid_BtnList.grid.self:MoveToPos(index or 1)
  end
  local rowOld = DataModel.eventList[DataModel.indexSelected]
  if rowOld then
    rowOld.element.Btn_Event.Img_Off:SetActive(true)
    rowOld.element.Btn_Event.Img_On:SetActive(false)
    rowOld.element.Btn_Event.Txt_T:SetColor("#FFFFFF")
    rowOld.element.Btn_Event.Img_Icon:SetColor("#FFFFFF")
  end
  local row = DataModel.eventList[index]
  row.element.Btn_Event.Img_Off:SetActive(false)
  row.element.Btn_Event.Img_On:SetActive(true)
  row.element.Btn_Event.Txt_T:SetColor("#282F2E")
  row.element.Btn_Event.Img_Icon:SetColor("#282F2E")
  DataModel.indexSelected = index
  local eventId = row.eventId
  local areaId = row.areaId
  local type = row.type
  local eventIndex = row.eventIndex
  View.Group_Btn.Btn_Main.Txt_T:SetText(row.name)
  PlayerData.TempCache.EventIndex = nil
  local isIn = true
  if UIManager:IsPanelOpened("UI/Chapter/Battle_DungeonScan") then
    UIManager:ClosePanel(false, "UI/Chapter/Battle_DungeonScan")
    isIn = false
  end
  PlayerData.TempCache.isOpenBtnList = DataModel.isOpenBtnList
  UIManager:Open("UI/Chapter/Battle_DungeonScan", Json.encode({
    activityId = DataModel.activityId,
    eventId = eventId,
    eventIndex = eventIndex,
    areaId = areaId,
    type = type,
    isIn = isIn,
    isAuto = isAuto
  }))
end

function Controller:releaseEvent()
  if DataModel.indexSelected > 0 then
    local index = DataModel.indexSelected
    local eventObjCur = DataModel.eventObjList[index]
    if eventObjCur and eventObjCur.transform and eventObjCur.transform:Find("Group_On") then
      eventObjCur.transform:Find("Group_On").gameObject:SetActive(false)
      eventObjCur.transform:Find("Group_Off").gameObject:SetActive(true)
    end
    local row = DataModel.eventList[index]
    row.element.Btn_Event.Img_Off:SetActive(true)
    row.element.Btn_Event.Img_On:SetActive(false)
    row.element.Btn_Event.Txt_T:SetColor("#FFFFFF")
    row.element.Btn_Event.Img_Icon:SetColor("#FFFFFF")
    View.Group_Btn.Btn_Main.Txt_T:SetText(GetText(80612091))
    DataModel.indexSelected = 0
  end
end

function Controller:endAuto()
  DataModel.isAuto = false
  View.Group_Auto.Btn_Start:SetActive(DataModel.isAuto == false)
  View.Group_Auto.Btn_End:SetActive(DataModel.isAuto == true)
end

function Controller:refreshAutoBtn()
  View.Group_Auto.Btn_Start:SetActive(DataModel.isAuto == false)
  View.Group_Auto.Btn_End:SetActive(DataModel.isAuto == true)
  View.Group_Auto.Group_List.StaticGrid_List.grid.self:SetDataCount(#DataModel.typeIndexList)
  View.Group_Auto.Group_List.StaticGrid_List.grid.self:RefreshAllElement()
end

function Controller:SetBtnAutoItemGridElelment(element, elementIndex)
  local index = tonumber(elementIndex)
  element.Btn_Item:SetClickParam(index)
  local pathCa = PlayerData:GetFactoryData(99900021)
  if index == 1 then
    element.Btn_Item.Txt_Type:SetText(GetText(80612122))
    element.Btn_Item.Img_Icon:SetSprite(pathCa.scanBtnIconPath[5].path)
  elseif index == 2 then
    element.Btn_Item.Txt_Type:SetText(GetText(80612121))
    element.Btn_Item.Img_Icon:SetSprite(pathCa.scanBtnIconPath[2].path)
  elseif index == 3 then
    element.Btn_Item.Txt_Type:SetText(GetText(80608994))
    element.Btn_Item.Img_Icon:SetSprite(pathCa.scanBtnIconPath[3].path)
  else
    element.Btn_Item.Txt_Type:SetText(GetText(80608993))
    element.Btn_Item.Img_Icon:SetSprite(pathCa.scanBtnIconPath[4].path)
  end
  if #DataModel.autoTypeList > 0 then
    for i = 1, #DataModel.autoTypeList do
      if DataModel.autoTypeList[i] == index then
        element.Btn_Item.Group_On.self:SetActive(true)
        element.Btn_Item.Group_Off.self:SetActive(false)
        element.Btn_Item.Group_On.Txt_Index:SetText(i)
        element.Btn_Item.Txt_Type:SetColor("#282F2E")
        element.Btn_Item.Img_Icon:SetColor("#282F2E")
        return
      end
    end
  end
  element.Btn_Item.Group_On.self:SetActive(false)
  element.Btn_Item.Group_Off.self:SetActive(true)
  element.Btn_Item.Txt_Type:SetColor("#FFFFFF")
  element.Btn_Item.Img_Icon:SetColor("#FFFFFF")
end

function Controller:clickBtnAutoItem(index)
  if #DataModel.autoTypeList > 0 then
    for i = 1, #DataModel.autoTypeList do
      if DataModel.autoTypeList[i] == index then
        table.remove(DataModel.autoTypeList, i)
        Controller:refreshAutoBtn()
        return
      end
    end
  end
  table.insert(DataModel.autoTypeList, index)
  Controller:refreshAutoBtn()
end

function Controller:StartScan()
  if DataModel.isBuffer == true then
    CommonTips.OpenTips(80612106)
    return
  end
  local useItem = {}
  local polluteConfig = PlayerData:GetFactoryData(99900056, "ConfigFactory")
  for k, v in pairs(polluteConfig.scanCostList) do
    if PlayerData:GetGoodsById(v.id).num < (v.num or 0) then
      local function callback()
        local json = {}
        
        json.shops = PlayerData.ServerData.shops
        json.shopId = 80305469
        if PlayerData.RechargeGoods == nil then
          Net:SendProto("shop.info", function(json)
            UIManager:Open("UI/Store/Store", Json.encode(json))
          end)
        else
          UIManager:Open("UI/Store/Store", Json.encode(json))
        end
      end
      
      CommonTips.OnPrompt(80612104, nil, nil, callback)
      return
    end
    useItem[v.id] = v.num
  end
  Controller:endAuto()
  Net:SendProto("unification.refresh_scan", function(json)
    PlayerData:RefreshUseItems(useItem)
    local itemId = polluteConfig.scanCostList[1].id
    local item = PlayerData:GetGoodsById(itemId)
    View.Group_Item.Txt_Num:SetText(item.num)
    View.Group_Scaning.self:SetActive(true)
    View.timer = nil
    View.timer = Timer.New(3.2, function()
      Controller:refreshEventMap()
      Controller:refreshEventBtn()
      Controller:refreshAutoBtn()
      View.timer:Stop()
    end)
    View.timer:Start()
    View.timer2 = nil
    View.timer2 = Timer.New(6, function()
      View.Group_Scaning.self:SetActive(false)
      View.Group_Scaning.Group_Success.self:SetActive(false)
      View.timer2:Stop()
    end)
    View.timer2:Start()
    DataModel.indexSelected = 0
    DataModel:SetEventData(json)
  end)
end

function Controller:RefreshTimeShow(isCheck)
  local textId
  local serverTime = TimeUtil:GetServerTimeStamp()
  local targetTimeBuffer = TimeUtil:GetNextSpecialTimeStamp(5, 1, 0)
  local timeTableBuffer = TimeUtil:SecondToTable(targetTimeBuffer - serverTime)
  local targetTime = TimeUtil:GetNextSpecialTimeStamp(5, 0, 5)
  local timeTable = TimeUtil:SecondToTable(targetTime - serverTime)
  local timeTableShow
  if DataModel.isBuffer == true then
    if isCheck == true and timeTableBuffer.hour > DataModel.lastHourBuffer then
      DataModel.lastHourBuffer = timeTableBuffer.hour
      DataModel.isBuffer = false
      Controller:endAuto()
      Net:SendProto("unification.world_event", function(json)
        DataModel:SetEventData(json)
        Controller:refreshEventMap()
        Controller:refreshEventBtn()
        Controller:refreshAutoBtn()
        CommonTips.OpenTips(80612105)
      end)
      return
    elseif 0 < timeTableBuffer.hour or timeTableBuffer.hour == 0 and 1 <= timeTableBuffer.minute then
      DataModel.isBuffer = false
      return
    end
    textId = 80612093
    timeTableShow = timeTableBuffer
  else
    if isCheck == true and timeTable.hour > DataModel.lastHour then
      DataModel.lastHour = timeTable.hour
      DataModel.isBuffer = true
      DataModel.eventList = {}
      Controller:refreshEventMap()
      Controller:refreshEventBtn()
      Controller:refreshAutoBtn()
      return
    end
    textId = 80612092
    timeTableShow = timeTable
  end
  local hour = timeTableShow.hour < 10 and "0" .. tostring(timeTableShow.hour) or tostring(timeTableShow.hour)
  local minute = timeTableShow.minute < 10 and "0" .. tostring(timeTableShow.minute) or tostring(timeTableShow.minute)
  local second = 10 > timeTableShow.second and "0" .. tostring(timeTableShow.second) or tostring(timeTableShow.second)
  local show_time = hour .. ":" .. minute .. ":" .. second
  View.Group_Time.Txt_T:SetText(GetText(textId))
  View.Group_Time.Txt_Time:SetText(tostring(show_time))
  DataModel.lastHour = timeTable.hour
  DataModel.lastHourBuffer = timeTableBuffer.hour
end

return Controller
