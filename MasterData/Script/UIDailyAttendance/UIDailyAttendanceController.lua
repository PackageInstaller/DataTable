local View = require("UIDailyAttendance/UIDailyAttendanceView")
local DataModel = require("UIDailyAttendance/UIDailyAttendanceDataModel")
local Controller = {}

function Controller:InitView()
  DataModel.InitData()
  Controller:InitPanel()
  Controller:RefreshPanel()
  Controller:RefreshTotalSignInElement()
  Controller:ClickMonthItem(DataModel.NowMonth, true)
  Controller:ClickDayItem(DataModel.NowDay, true)
  View.Img_BG.Group_Birthday.Group_BirthdayCard.Img_BirthdayCard.Img_BirthdayItemBG.Txt_BirthdayItem:SetText(GetText(80607138))
  View.Img_BG.Group_Birthday.Group_BirthdayCard.Group_Multiple.Img_MultipleCard.Img_BirthdayItemBG.Txt_BirthdayItem:SetText(GetText(80607138))
  View.Img_BG.Group_Birthday.Group_BirthdayCard:SetActive(false)
  View.Img_BG.Group_Birthday:SetActive(DataModel.CheckHaveRoleBirthday())
  View.self:PlayAnimOnce("Enter", function()
    Controller:CheckTodayIsSign()
  end)
end

function Controller:InitPanel()
  View.Img_BG.Txt_DailyAttendance:SetText(GetText(80607118))
  if CommonTips.IsResEN() then
    View.Img_BG.Txt_DailyAttendanceEN:SetActive(false)
    View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_Text.Txt_TextTwo:SetActive(false)
    View.Img_BG.Group_Bottom.Group_Date.Txt_MonthText:SetTxtFontSize(30)
  end
  View.Img_BG.Group_Top.Group_Text.Txt_MonthlyAccumulation:SetText(GetText(80607119))
  View.Img_BG.Group_Bottom.Group_Date.Txt_MonthText:SetText(GetText(80607120))
  View.Img_BG.Group_Bottom.Group_Date.Img_TotalAccumulation.Txt_TotalDaysText:SetText(GetText(80607121))
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_Text.Txt_TextOne:SetText(GetText(80607122))
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_Text.Txt_TextTwo:SetText(PlayerData:GetFactoryData(40100008).ENText)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_Text.Txt_TextThree:SetText(GetText(80607123))
  View.Img_BG.Group_Bottom.Img_MonthCardBG.StaticGrid_MonthCardItem.grid.self:SetDataCount(3)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.StaticGrid_MonthCardItem.grid.self:RefreshAllElement()
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Btn_NotTime.Txt_SignType:SetText(GetText(80607128))
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Btn_Pass.Txt_SignType:SetText(GetText(80607130))
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Btn_Signed.Txt_SignType:SetText(GetText(80607129))
end

function Controller:SetDayItemElement(element, elementIndex)
  element.Img_BG.Txt_Day:SetText(elementIndex)
  element.Img_TodayBG.Txt_Day:SetText(elementIndex)
  element.Img_BirthdayBG.Txt_Day:SetText(elementIndex)
  local isToday = DataModel.NowDay == elementIndex and DataModel.NowMonth == DataModel.CurSelectMonth
  element.Img_TodayBG:SetActive(isToday)
  local isBirth = DataModel.CheckHaveRoleBirthday(DataModel.CurSelectMonth, elementIndex)
  element.Img_BirthdayBG:SetActive(isBirth)
  local rewardItem = DataModel.RewardCfg[elementIndex]
  local rewardCfg = PlayerData:GetFactoryData(rewardItem.id)
  element.Img_Item:SetSprite(rewardCfg.iconPath)
  element.Txt_Num:SetText(rewardItem.num)
  element.Txt_Num:SetColor(isToday and "#000000" or "#FFFFFF")
  element.Img_Signed:SetActive(DataModel.GetDayDailyIsSigned(DataModel.CurSelectMonth, elementIndex))
  element.Img_Select:SetActive(elementIndex == DataModel.CurSelectDay)
  element.Btn_Item:SetClickParam(elementIndex)
end

function Controller:SetMonthItemElement(element, elementIndex)
  element.Btn_Month.Txt_Month:SetText(elementIndex)
  element.Btn_Month:SetClickParam(elementIndex)
  local isSelect = elementIndex == DataModel.CurSelectMonth
  element.Btn_Month.Txt_Month:SetColor(isSelect and "#000000" or "7D7D7D")
  element.Img_Select:SetActive(isSelect)
end

function Controller:SetMonthCardItemElement(element, elementIndex)
  local reward = DataModel.MonthCardReward[elementIndex]
  local cfg = PlayerData:GetFactoryData(reward.id)
  element.Img_Item:SetSprite(cfg.iconPath)
  element.Txt_Num:SetText("X" .. reward.num)
  local isSigned = DataModel.GetDayMonthIsSigned(DataModel.CurSelectMonth, DataModel.CurSelectDay)
  element.Img_Signed:SetActive(isSigned)
  element.Img_Item:SetColor(isSigned and "#8E8E8E" or "#00000")
  element.Btn_MonthCardItem:SetClickParam(elementIndex)
end

function Controller:SetTotalSignInItemElement(element, elementIndex)
  local cfg = DataModel.TotalSignRewardCfg[elementIndex]
  local itemCfg = PlayerData:GetFactoryData(cfg.id)
  element.Img_Item:SetSprite(itemCfg.iconPath)
  element.Txt_Num:SetText("X" .. cfg.num)
  element.Group_SetDay.Txt_Day:SetText(cfg.date)
  element.Img_Sign:SetActive(false)
  local isFinish = DataModel.NowMonthSignInCount >= cfg.date
  element.Img_BG:SetActive(isFinish)
  element.Img_Signed:SetActive(isFinish)
  element.Group_SetDay.Img_DaySign:SetActive(isFinish)
  element.Group_SetDay.Txt_Day:SetColor(isFinish and "#FFB800" or "#B6B6B6")
  element.Img_Item:SetColor(isFinish and "#8E8E8E" or "#FFFFFF")
  element.Btn_AccumulationItem:SetClickParam(elementIndex)
end

function Controller:RefreshAllDayItem()
  local dayCount = DataModel.GetMonthDayCount(DataModel.CurSelectMonth)
  View.Img_BG.Group_Main.StaticGrid_DayItem.grid.self:SetDataCount(dayCount)
  View.Img_BG.Group_Main.StaticGrid_DayItem.grid.self:RefreshAllElement()
end

function Controller:RefreshAllMonthItem(isInit)
  View.Img_BG.Group_Main.ScrollGrid_Month.grid.self:SetDataCount(12)
  View.Img_BG.Group_Main.ScrollGrid_Month.grid.self:RefreshAllElement()
  if isInit then
    View.Img_BG.Group_Main.ScrollGrid_Month.grid.self:MoveToPos(DataModel.CurSelectMonth)
  end
end

function Controller:RefreshTotalSignInElement()
  View.Img_BG.Group_Top.StaticGrid_AccumulationItem.grid.self:SetDataCount(3)
  View.Img_BG.Group_Top.StaticGrid_AccumulationItem.grid.self:RefreshAllElement()
  local record = 0
  for i = 1, 3 do
    if DataModel.NowMonthSignInCount >= DataModel.TotalSignDayRecord[i] then
      record = record + 1
    end
  end
  if 0 < record then
    View.Img_BG.Group_Top.StaticGrid_AccumulationItem.grid[record].Img_Sign:SetActive(true)
  end
end

function Controller:RefreshSelectDayShow()
  View.Img_BG.Group_Bottom.Group_Date.Txt_Month:SetText(string.format("%02d", DataModel.CurSelectMonth))
  View.Img_BG.Group_Bottom.Group_Date.Txt_Day:SetText(string.format("%02d", DataModel.CurSelectDay))
end

function Controller:RefreshPanel()
  DataModel.NowMonthSignInCount = DataModel.GetMonthTotalSignCount(DataModel.NowMonth)
  View.Img_BG.Group_Top.Group_Text.Txt_Day:SetText(DataModel.NowMonthSignInCount)
  View.Img_BG.Group_Top.Group_PointOne.Img_PointNot:SetActive(DataModel.NowMonthSignInCount < DataModel.TotalSignDayRecord[2])
  View.Img_BG.Group_Top.Group_PointOne.Img_Point:SetActive(DataModel.NowMonthSignInCount >= DataModel.TotalSignDayRecord[2])
  View.Img_BG.Group_Top.Group_PointTwo.Img_PointNot:SetActive(DataModel.NowMonthSignInCount < DataModel.TotalSignDayRecord[3])
  View.Img_BG.Group_Top.Group_PointTwo.Img_Point:SetActive(DataModel.NowMonthSignInCount >= DataModel.TotalSignDayRecord[3])
  View.Img_BG.Group_Bottom.Group_Date.Img_TotalAccumulation.Txt_TotalDays:SetText(PlayerData.ServerData.total_login_num or 0)
  local totalDay = DataModel.TotalSignDayRecord[3] - DataModel.TotalSignDayRecord[1]
  local signDayCount = DataModel.NowMonthSignInCount
  local amount = 0
  if signDayCount < DataModel.TotalSignDayRecord[1] then
    amount = 0
  elseif signDayCount > DataModel.TotalSignDayRecord[3] then
    amount = 1
  else
    amount = (signDayCount - DataModel.TotalSignDayRecord[1]) / totalDay
  end
  View.Img_BG.Group_Top.Img_ProgressBar:SetFilledImgAmount(amount)
end

function Controller:RefreshDailyRewardPanel()
  local rewardItem = DataModel.RewardCfg[DataModel.CurSelectDay]
  local rewardCfg = PlayerData:GetFactoryData(rewardItem.id)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Img_RewardItemBG.Btn_RewardItem:SetSprite(rewardCfg.iconPath)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Img_RewardItemBG.Img_RewardItem:SetSprite(rewardCfg.iconPath)
  local signType = DataModel.GetDaySignType()
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Btn_NotTime:SetActive(signType == DataModel.SignType.NotTime)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Btn_Pass:SetActive(signType == DataModel.SignType.NoSign)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Btn_Signed:SetActive(signType == DataModel.SignType.Signed)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Btn_RewardSign:SetActive(signType == DataModel.SignType.CanSign)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Img_RewardItemBG.Img_RewardItemSigned:SetActive(signType == DataModel.SignType.Signed)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_RewardItem.Img_RewardItemBG.Img_RewardItem:SetColor(signType == DataModel.SignType.Signed and "#8E8E8E" or "#FFFFFF")
  View.Img_BG.Group_Bottom.Img_MonthCardBG.StaticGrid_MonthCardItem.grid.self:RefreshAllElement()
  local haveMonthCardOnSelectDay = DataModel.GetRemainMonthCardDayCount()
  local isYesterday = TimeUtil:IsLogicYesterday()
  local selectDayTimeStamp = os.time({
    year = DataModel.NowYear,
    month = DataModel.CurSelectMonth,
    day = DataModel.CurSelectDay,
    hour = 5,
    min = 0,
    sec = 0
  }) + TimeUtil:GetLocalTimeZone() * 3600
  local curDayStamp = TimeUtil:GetFutureTimeStampByUTC(isYesterday and -1 or 0, 5)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_HaveMonthlyCard:SetActive(0 <= haveMonthCardOnSelectDay)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_NoMonthlyCard:SetActive(haveMonthCardOnSelectDay < 0 and selectDayTimeStamp >= curDayStamp)
  if haveMonthCardOnSelectDay then
    View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_HaveMonthlyCard.Txt_RemainingTime:SetText(haveMonthCardOnSelectDay)
  end
  local color = (0 <= haveMonthCardOnSelectDay or DataModel.GetDayMonthIsSigned()) and "#FFB800" or "#A2A2A2"
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_Text.Txt_TextOne:SetColor(color)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_Text.Txt_TextTwo:SetColor(color)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_Text.Txt_TextThree:SetColor(color)
  View.Img_BG.Group_Bottom.Img_MonthCardBG.Group_Text.Txt_MonthCardText:SetColor(color)
end

function Controller:RefreshBirthDayCard()
  local birthData = DataModel.GetRoleBirthdayList()[DataModel.CurSelectBirthDayRoleIdx]
  local roleId = type(birthData) == "table" and birthData.roleId or birthData
  local roleCfg = PlayerData:GetFactoryData(roleId)
  if not roleCfg then
    return
  end
  local birthFace = type(birthData) == "table" and birthData.birthFace or roleCfg.birthFace
  if string.nilorempty(birthFace) then
    local curSkin
    local playerRoleData = PlayerData:GetRoleById(roleId)
    if next(playerRoleData) == nil then
      curSkin = roleCfg.skinList[1].unitViewId
    else
      curSkin = playerRoleData.current_skin[1]
    end
    local viewCfg = PlayerData:GetFactoryData(curSkin, "UnitViewFactory")
    birthFace = viewCfg and viewCfg.face or ""
  end
  local giftId = type(birthData) == "table" and birthData.birthdayCake or roleCfg.birthdayCake
  local giftCfg = PlayerData:GetFactoryData(giftId)
  local birthdayMessage = type(birthData) == "table" and birthData.birthdayMessage or roleCfg.birthdayMessage or ""
  DataModel.CurBirthDayCakeItemId = giftId
  View.Img_BG.Group_Birthday.Group_BirthdayCard.Img_BirthdayCard.Img_HeadPortrait.Txt_Name:SetText(roleCfg.name)
  View.Img_BG.Group_Birthday.Group_BirthdayCard.Img_BirthdayCard.Img_HeadPortrait.Img_Mask.Img_Character:SetSprite(birthFace)
  View.Img_BG.Group_Birthday.Group_BirthdayCard.Img_BirthdayCard.ScrollView_Details.Viewport.Content.Txt_Details:SetText(birthdayMessage)
  View.Img_BG.Group_Birthday.Group_BirthdayCard.Img_BirthdayCard.Img_BirthdayItem:SetSprite(giftCfg and giftCfg.iconPath or "")
end

function Controller:ClickLetter()
  if not DataModel.CheckHaveRoleBirthday() then
    return
  end
  View.Img_BG.Group_Birthday:SetActive(true)
  local roles = DataModel.GetRoleBirthdayList()
  View.Img_BG.Group_Birthday.Group_BirthdayCard.Group_Multiple:SetActive(table.count(roles) > 1)
  DataModel.CurSelectBirthDayRoleIdx = 1
  View.self:PlayAnimOnce("BirthdayEnter", function()
    Controller:TrySign()
  end)
  Controller:RefreshBirthDayCard()
end

function Controller:ClickLetterLeftBtn()
  local roleCount = table.count(DataModel.GetRoleBirthdayList())
  DataModel.CurSelectBirthDayRoleIdx = DataModel.CurSelectBirthDayRoleIdx - 1
  if DataModel.CurSelectBirthDayRoleIdx == 0 then
    DataModel.CurSelectBirthDayRoleIdx = roleCount
  end
  View.self:PlayAnimOnce("BirthdayChange")
  Controller:RefreshBirthDayCard()
end

function Controller:ClickLetterRightBtn()
  local roleCount = table.count(DataModel.GetRoleBirthdayList())
  DataModel.CurSelectBirthDayRoleIdx = DataModel.CurSelectBirthDayRoleIdx + 1
  if roleCount < DataModel.CurSelectBirthDayRoleIdx then
    DataModel.CurSelectBirthDayRoleIdx = 1
  end
  View.self:PlayAnimOnce("BirthdayChange")
  Controller:RefreshBirthDayCard()
end

function Controller:ClickDayItem(idx, isInit)
  if DataModel.CurSelectDay == idx and not isInit then
    return
  end
  DataModel.GetNowTime()
  local lastDayIdx = DataModel.CurSelectDay
  local lastDayCtr = View.Img_BG.Group_Main.StaticGrid_DayItem.grid[lastDayIdx]
  local curDayCtr = View.Img_BG.Group_Main.StaticGrid_DayItem.grid[idx]
  DataModel.CurSelectDay = idx
  Controller:SetDayItemElement(lastDayCtr, lastDayIdx)
  Controller:SetDayItemElement(curDayCtr, idx)
  View.self:PlayAnimOnce("DayChange")
  Controller:ChangeSelectRefresh()
end

function Controller:ClickMonthItem(idx, isInit)
  local selectMonth = idx
  if selectMonth == -1 then
    return
  end
  if DataModel.CurSelectMonth == selectMonth and not isInit then
    return
  end
  DataModel.CurSelectMonth = selectMonth
  DataModel.CurSelectDay = 1
  View.self:PlayAnimOnce("MonthChange")
  if DataModel.CurSelectMonth <= DataModel.NowMonth and DataModel.SignInData[DataModel.CurSelectMonth] == nil then
    Controller:RequireMonthSignInData(DataModel.CurSelectMonth)
  else
    Controller:RefreshAllDayItem()
    Controller:RefreshAllMonthItem(isInit)
    Controller:ChangeSelectRefresh()
  end
end

function Controller:ChangeSelectRefresh()
  Controller:RefreshSelectDayShow()
  Controller:RefreshDailyRewardPanel()
  local isFuture = DataModel.IsSelectedFuture()
  View.Img_BG.Group_Birthday:SetActive(DataModel.CheckHaveRoleBirthday() and not isFuture)
end

function Controller:CheckTodayIsSign()
  if DataModel.GetDayDailyIsSigned(DataModel.NowMonth, DataModel.NowDay) then
    return
  end
  if table.count(DataModel.GetRoleBirthdayList(DataModel.NowMonth, DataModel.NowDay)) > 0 then
    Controller:ClickLetter()
  else
    Controller:TrySign()
  end
end

function Controller:RequireMonthSignInData(month, needSign)
  Net:SendProto("main.sign_record", function(json)
    if json.records then
      DataModel.SignInData[month] = json.records[tostring(month)]
    end
    if needSign then
      Controller:TrySign()
    else
      Controller:RefreshAllDayItem()
      Controller:RefreshAllMonthItem()
      Controller:ChangeSelectRefresh()
    end
  end, tostring(month))
end

function Controller:TrySign()
  DataModel.GetNowTime()
  if DataModel.CurSelectMonth == DataModel.NowMonth and DataModel.CurSelectDay == DataModel.NowDay then
    if DataModel.SignInData[DataModel.NowMonth] == nil then
      Controller:RequireMonthSignInData(DataModel.NowMonth, true)
    else
      if DataModel.GetDayDailyIsSigned() then
        return
      end
      local birthList = DataModel.GetRoleBirthdayIdList()
      local roles = ""
      if table.count(birthList) > 0 then
        roles = table.concat(birthList, ",")
      else
        roles = ""
      end
      Net:SendProto("main.monthly_sign", function(json)
        if json.reward then
          CommonTips.OpenShowItem(json.reward)
        end
        DataModel.GetMonthCardRemainTime()
        if not PlayerData.ServerData.monthly_sign[tostring(DataModel.NowMonth)] then
          PlayerData.ServerData.monthly_sign[tostring(DataModel.NowMonth)] = {}
        end
        PlayerData.ServerData.monthly_sign[tostring(DataModel.NowMonth)][tostring(DataModel.NowDay)] = {
          m_card = DataModel.RemainMonthCardDayCount >= 0,
          day = true
        }
        if not DataModel.SignInData[DataModel.NowMonth] then
          DataModel.SignInData[DataModel.NowMonth] = {}
        end
        DataModel.SignInData[DataModel.NowMonth][DataModel.NowDay] = {
          m_card = DataModel.RemainMonthCardDayCount >= 0,
          day = true
        }
        local ctr = View.Img_BG.Group_Main.StaticGrid_DayItem.grid[DataModel.NowDay]
        Controller:SetDayItemElement(ctr, DataModel.NowDay)
        Controller:RefreshPanel()
        Controller:RefreshDailyRewardPanel()
        Controller:RefreshTotalSignInElement()
        View.Img_Shield:SetActive(false)
        View.Img_BG.Group_Bottom.Group_Date.Img_TotalAccumulation.Txt_TotalDays:SetText(PlayerData.ServerData.total_login_num or 0)
        local mainController = require("UIMainUI/UIMainUIController")
        mainController:InitCommonShow()
      end, "40100008", roles)
    end
  end
end

return Controller
