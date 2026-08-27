local DailyDungeonLevelCtrl = class("ControllerBase", ControllerBase)
local base = ControllerBase
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local CS_GSceneManager_Ins = CS.GSceneManager.Instance
local cs_MessageCommon = CS.MessageCommon

function DailyDungeonLevelCtrl:OnInit()
  self._OnDailyDgOutOfDataFunc = BindCallback(self, self._OnDailyDgOutOfData)
  MsgCenter:AddListener(eMsgEventId.DailyDungeonOutOfData, self._OnDailyDgOutOfDataFunc)
end

function DailyDungeonLevelCtrl:ShowDailyDungeonMain(onShowWinFunc, closeFunc, openCurDiff, formBattleWin)
  self.closeFunc = closeFunc
  UIManager:ShowWindowAsync(UIWindowTypeID.DailyDungeonMain, function(window)
    if window == nil then
      return
    end
    if onShowWinFunc ~= nil then
      onShowWinFunc()
    end
    window:InitDailyDungeonMain(self, openCurDiff)
    local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
    if formBattleWin and dungeonDyncElem:IsDgDyncComplete() then
      UIManager:ShowWindowAsync(UIWindowTypeID.DailyDungeonComplete, function(win)
        if win == nil then
          return
        end
        local name = dungeonDyncElem:GetDgDyncElemName()
        win:InitDailyDungeonComplete(name)
      end)
    end
  end)
  self:UpdDailyDgRemainTime()
end

function DailyDungeonLevelCtrl:UpdDailyDgRemainTime()
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleRefreshableDungeon, eDungeonEnum.eMatDungeonGroup.DailyDungeon)
  if counterElem ~= nil then
    self.netxRefreshTimeStamp = counterElem.nextExpiredTm
    self:_SetRemaindTime()
  end
end

function DailyDungeonLevelCtrl:ReqEnterDailyDungeon(dailyDgDyncData)
  local stageId = dailyDgDyncData:GetDailyDgNextLvDungeonId()
  BattleDungeonManager:InjectBattleExitEvent(BindCallback(self, self._ExitBattleFunc))
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastBattleDeployFmtId(proto_csmsg_DungeonType.DungeonType_Daily)
  local formationData = PlayerDataCenter.formationDic[lastFmtId]
  if formationData == nil then
    formationData = PlayerDataCenter:CreateFormation(lastFmtId)
  end
  BattleDungeonManager:SaveFormation(formationData)
  local interfaceData = DungeonInterfaceData.CreateDailyDungeonInterface(dailyDgDyncData)
  BattleDungeonManager:RequestEnterDungeon(stageId, formationData, interfaceData, function()
    self:Delete()
    ControllerManager:DeleteController(ControllerTypeId.SectorController)
  end)
end

function DailyDungeonLevelCtrl:_ExitBattleFunc(isBatlleWin)
  ControllerManager:DeleteController(ControllerTypeId.Formation)
  local LastPlayData = require("Game.Sector.Data.LastPlayData")
  local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
  local lastPlayData = LastPlayData.New():SetLPDDngeonType(eDungeonEnum.eDungeonType.DailyDungeon):SetLPDIsWin(isBatlleWin == true)
  UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
  PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
end

function DailyDungeonLevelCtrl:_OnDailyDgOutOfData()
  UIManager:ShowWindowAsync(UIWindowTypeID.DailyDungeonMain, function(window)
    if window == nil then
      return
    end
    window:InitDailyDungeonMain(self)
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.DailyDungeonMain) then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.DailyDungeonMain)
    end
  end)
  self:UpdDailyDgRemainTime()
end

function DailyDungeonLevelCtrl:_SetRemaindTime()
  self:_ClearRemainTimer()
  if self.netxRefreshTimeStamp == nil or self.netxRefreshTimeStamp <= PlayerDataCenter.timestamp then
    return
  end
  self:_RefreshRemaindTime()
  self.remainTimerId = TimerManager:StartTimer(1, self._RefreshRemaindTime, self, false, false, false)
end

function DailyDungeonLevelCtrl:_RefreshRemaindTime()
  local remaindTime = math.max(math.floor(self.netxRefreshTimeStamp - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  local hStr = 10 <= h and tostring(h) or "0" .. tostring(h)
  local mStr = 10 <= m and tostring(m) or "0" .. tostring(m)
  local sStr = 10 <= s and tostring(s) or "0" .. tostring(s)
  if remaindTime <= 0 then
    self:_ClearRemainTimer()
  end
  local mainWin = UIManager:GetWindow(UIWindowTypeID.DailyDungeonMain)
  if mainWin ~= nil then
    mainWin:UpdDailyDgMainTime(d, hStr, mStr, sStr)
  end
  local levelWin = UIManager:GetWindow(UIWindowTypeID.DailyDungeonLevel)
  if levelWin ~= nil then
    levelWin:UpdDailyDgLevelTime(d, hStr, mStr, sStr)
  end
end

function DailyDungeonLevelCtrl:_ClearRemainTimer()
  if self.remainTimerId ~= nil then
    TimerManager:StopTimer(self.remainTimerId)
    self.remainTimerId = nil
  end
end

function DailyDungeonLevelCtrl:ExitDailyDungeon(toHome)
  if self.closeFunc ~= nil then
    self.closeFunc(toHome)
  end
  self:Delete()
end

function DailyDungeonLevelCtrl:OpenDailyDungeonShop()
  JumpManager:DirectShowShop(nil, nil, ShopEnum.ShopId.DailyDungeonShop)
end

function DailyDungeonLevelCtrl:OnDelete()
  self:_ClearRemainTimer()
  UIManager:DeleteWindow(UIWindowTypeID.DailyDungeonMain)
  MsgCenter:RemoveListener(eMsgEventId.DailyDungeonOutOfData, self._OnDailyDgOutOfDataFunc)
  base.OnDelete(self)
end

return DailyDungeonLevelCtrl
