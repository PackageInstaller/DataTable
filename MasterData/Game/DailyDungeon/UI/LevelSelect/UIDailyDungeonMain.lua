local UIDailyDungeonMain = class("UIDailyDungeonMain", UIBaseWindow)
local base = UIBaseWindow
local UINDailyLevelDifItem = require("Game.DailyDungeon.UI.LevelSelect.UINDailyLevelDifItem")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local UINDailyDungeonQuickBattle = require("Game.DailyDungeon.UI.LevelSelect.UINDailyDungeonQuickBattle")
local cs_MessageCommon = CS.MessageCommon

function UIDailyDungeonMain:OnInit()
  self.ui.lvDifItem:SetActive(false)
  self.lvdifItemPool = UIItemPool.New(UINDailyLevelDifItem, self.ui.lvDifItem)
  self._OnSelectDiffFunc = BindCallback(self, self._OnSelectDiff)
  UIUtil.AddButtonListener(self.ui.btn_Shop, self, self.__OnClickDailyShop)
  self.ui.tex_RefreshTime.gameObject:SetActive(false)
  UIUtil.SetTopStatus(self, self._OnClickBack)
  self._UpdateActivityDoubleRewardFunc = BindCallback(self, self._UpdateActivityDoubleReward)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self._UpdateActivityDoubleRewardFunc)
end

function UIDailyDungeonMain:InitDailyDungeonMain(dailyDgCtrl, openCurDiff)
  self.dailyDgCtrl = dailyDgCtrl
  local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
  self.dungeonDyncElem = dungeonDyncElem
  local isNew = dungeonDyncElem.isDailyDungeonNew
  self._isNewStart = isNew
  self.ui.tex_Count:SetIndex(isNew and 1 or 0)
  self:_UpdItem(openCurDiff)
  self:_UpdateActivityDoubleReward()
end

function UIDailyDungeonMain:_UpdateActivityDoubleReward()
  local isDouble = self.dungeonDyncElem:DgDyncIsHaveMultReward()
  self.ui.obj_double:SetActive(isDouble)
  self.__activityDestoryTime = nil
  self.ui.tex_DoubleTimeLeft.gameObject:SetActive(false)
  if isDouble then
    local curActivityDic = PlayerDataCenter.playerBonus:GetDungeonMultRewardCurActivityIdDic(proto_csmsg_DungeonType.DungeonType_Daily)
    local activityId
    for id, _ in pairs(curActivityDic) do
      activityId = id
      break
    end
    if activityId == nil then
      error("activityId == nil")
      return
    end
    local activivityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local actData = activivityCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.DungeonDouble, activityId)
    if actData == nil then
      error("actData == nil")
      return
    end
    self.__activityDestoryTime = actData:GetActivityDestroyTime()
  end
end

function UIDailyDungeonMain:_UpdItem(openCurDiff)
  local dungeonUITypeDic = ConfigData.material_dungeon.dungeonUITypeDic
  local dungeonIdList = dungeonUITypeDic[eDungeonEnum.eDungeonType.DailyDungeon]
  if dungeonIdList == nil then
    error("Cant get dungeonUITypeDic, eDungeonEnum.eDungeonType.DailyDungeon")
    return
  end
  self.lvdifItemPool:HideAll()
  local OnClickQuickDungeonBind = BindCallback(self, self.OnClickQuickDungeon)
  local lastUnLockDungeonIndex = 1
  for k, dungeonId in ipairs(dungeonIdList) do
    local matDungeonCfg = ConfigData.material_dungeon[dungeonId]
    local dungeonDyncElem
    if not self._isNewStart and self.dungeonDyncElem.moduleId == dungeonId then
      dungeonDyncElem = self.dungeonDyncElem
      if openCurDiff then
        self:_OnSelectDiff(matDungeonCfg)
      end
    end
    local lvDifItem = self.lvdifItemPool:GetOne()
    lvDifItem:InitDailyLevelDifItem(k, matDungeonCfg, self._OnSelectDiffFunc, dungeonDyncElem)
    lvDifItem:BindQuickBattleFunc(OnClickQuickDungeonBind)
    lvDifItem.gameObject.name = tostring(k)
    local unlock = FunctionUnlockMgr:ValidateUnlock(matDungeonCfg.id)
    if unlock then
      lastUnLockDungeonIndex = k
    end
  end
  self:DungeonScrollTo(lastUnLockDungeonIndex, #dungeonIdList)
end

function UIDailyDungeonMain:DungeonScrollTo(lastUnLockDungeonIndex, dungeonIdCount)
  if 1 < dungeonIdCount then
    local normalizedPos = lastUnLockDungeonIndex - 1 / dungeonIdCount - 1
    self.ui.scroll_levelScroll.horizontalNormalizedPosition = normalizedPos
  end
end

function UIDailyDungeonMain:UpdDailyDgMainTime(dInt, hStr, mStr, sStr)
  self.ui.tex_RefreshTime.gameObject:SetActive(true)
  if 0 < dInt then
    self.ui.tex_RefreshTime:SetIndex(0, tostring(dInt), hStr, mStr, sStr)
  else
    self.ui.tex_RefreshTime:SetIndex(1, hStr, mStr, sStr)
  end
  if self.__activityDestoryTime ~= nil then
    local remaindTime = self.__activityDestoryTime - PlayerDataCenter.timestamp
    local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
    self.ui.tex_DoubleTimeLeft.gameObject:SetActive(true)
    if 0 < d then
      self.ui.tex_DoubleTimeLeft:SetIndex(0, tostring(d), string.format("%02d:%02d:%02d", tostring(h), tostring(m), tostring(s)))
    else
      self.ui.tex_DoubleTimeLeft:SetIndex(1, string.format("%02d:%02d:%02d", tostring(h), tostring(m), tostring(s)))
    end
  end
end

function UIDailyDungeonMain:_OnSelectDiff(matDungeonCfg)
  if not self._isNewStart and matDungeonCfg.id ~= self.dungeonDyncElem.moduleId then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2901))
    return
  end
  local unlock = FunctionUnlockMgr:ValidateUnlock(matDungeonCfg.id)
  if not unlock then
    local tips = FunctionUnlockMgr:GetFuncUnlockDecription(matDungeonCfg.id)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(tips)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.DailyDungeonLevel, function(win)
    if win == nil then
      return
    end
    win:InitDailyDungeonLevel(self.dailyDgCtrl, matDungeonCfg, self._isNewStart, self.dungeonDyncElem)
  end)
end

function UIDailyDungeonMain:OnClickQuickDungeon(matDungeonCfg)
  if not PlayerDataCenter:IsDungeonModuleOpenQuick(matDungeonCfg.id) then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9309))
    return
  end
  local battleDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
  local canQuick = battleDyncElem:IsDailyModuleCanQuick(matDungeonCfg.id)
  if not canQuick then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(2901))
    return
  end
  
  local function applyFunc()
    local index = battleDyncElem.isDailyDungeonNew and 0 or battleDyncElem.idx
    NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_DailyDungeon_Quick(matDungeonCfg.id, function(args)
      if args == nil or args.Count == 0 then
        if isGameDev then
          error("args.Count == 0")
        end
        return
      end
      local msg = args[0]
      local dungeonElems = msg.dungeonElem
      if self._quickResNode == nil then
        self.ui.quickWindowNode:SetActive(true)
        self._quickResNode = UINDailyDungeonQuickBattle.New()
        self._quickResNode:Init(self.ui.quickWindowNode)
      else
        self._quickResNode:Show()
      end
      self._quickResNode:InitDailyQuickBattle(matDungeonCfg, index + 1, dungeonElems)
      MsgCenter:Broadcast(eMsgEventId.OnDailyDungeonQuickBattleOver)
    end)
  end
  
  if not battleDyncElem.isDailyDungeonNew then
    applyFunc()
  else
    local tip = ConfigData:GetTipContent(2900, LanguageUtil.GetLocaleText(matDungeonCfg.name))
    cs_MessageCommon.ShowMessageBox(tip, applyFunc, nil)
  end
end

function UIDailyDungeonMain:_OnClickBack(toHome)
  self.dailyDgCtrl:ExitDailyDungeon(toHome)
end

function UIDailyDungeonMain:__OnClickDailyShop()
  self.dailyDgCtrl:OpenDailyDungeonShop()
end

function UIDailyDungeonMain:OnDelete()
  if self.lvdifItemPool ~= nil then
    self.lvdifItemPool:DeleteAll()
    self.lvdifItemPool = nil
  end
  if self._quickResNode ~= nil then
    self._quickResNode:Delete()
  end
  UIManager:DeleteWindow(UIWindowTypeID.DailyDungeonLevel)
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self._UpdateActivityDoubleRewardFunc)
  base.OnDelete(self)
end

return UIDailyDungeonMain
