local PlayerClickCollectManager = class("PlayerClickCollectManager")
local WAIT_TIME = 60

function PlayerClickCollectManager:ctor()
  self.__waitReportTimer = nil
  self.__wait2ReportClickNumDic = {}
  self.__tryReport = BindCallback(self, self.__TryReport)
end

function PlayerClickCollectManager:BtnClickNumCollect(reportId)
  self:__OnBtnClick(reportId)
end

function PlayerClickCollectManager:__OnBtnClick(reportId)
  local clickNum = self.__wait2ReportClickNumDic[reportId] or 0
  self.__wait2ReportClickNumDic[reportId] = clickNum + 1
  self:__TryStartReportTimer()
end

function PlayerClickCollectManager:__TryStartReportTimer()
  if self.__waitReportTimer == nil then
    self.__waitReportTimer = TimerManager:StartTimer(WAIT_TIME, self.__tryReport, self, true)
  end
end

function PlayerClickCollectManager:__TryReport()
  if table.IsEmptyTable(self.__wait2ReportClickNumDic) then
    return
  end
  local objNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
  local buttonClickDic = {}
  for key, value in pairs(self.__wait2ReportClickNumDic) do
    buttonClickDic[key] = value
  end
  objNetwork:CS_CLIENT_OP_SYNC(buttonClickDic)
  self.__wait2ReportClickNumDic = {}
  self.__waitReportTimer = nil
end

function PlayerClickCollectManager:OnLogout()
  if self.__waitReportTimer ~= nil then
    TimerManager:StopTimer(self.__waitReportTimer)
    self.__waitReportTimer = nil
  end
  self.__wait2ReportClickNumDic = {}
end

return PlayerClickCollectManager
