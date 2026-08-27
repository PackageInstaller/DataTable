local base = UIBaseWindow
local UICommonQuickBattle = class("UICommonQuickBattle", base)
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_MovieManager = CS.MovieManager.Instance

function UICommonQuickBattle:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Clear, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.background, self, self._OnClickClose)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount, false)
end

function UICommonQuickBattle:InitCmQuickBattle(rewardDic, athDic, dzdcDic)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._QuickQuit):PushTopStatusDataToBackStack()
  self._dzdcDic = dzdcDic
  if self._moviePlayer == nil then
    self._moviePlayer = cs_MovieManager:GetMoviePlayer()
  end
  local avgPath = PathConsts:GetAvgVideoPath("dailyDungeonQuickBattle")
  self._moviePlayer:SetVideoRender(self.ui.videoHodler)
  self._moviePlayer:PlayVideo(avgPath)
  self._moviePlayer:SetLoopSeek(0, 59)
  self:__ShowItem(1.2)
  athDic = athDic or table.emptytable
  for uid, athData in pairs(athDic) do
    local itemCfg = athData.itemCfg
    local item = self.rewardItemPool:GetOne()
    item:InitItemWithCount(itemCfg, 1, function()
      UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
        if win ~= nil then
          win:InitAthDetail(itemCfg, athData)
        end
      end)
    end)
  end
  for itemId, itemNum in pairs(rewardDic) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("Cant get item cfg. itemId:" .. tostring(itemId))
    else
      local item = self.rewardItemPool:GetOne()
      item:InitItemWithCount(itemCfg, itemNum)
    end
  end
end

function UICommonQuickBattle:__ShowItem(time)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self.ui.list:SetActive(false)
  self.ui.background.enabled = false
  self.ui.btn_Clear.gameObject:SetActive(false)
  self.ui.obj_Finish:SetActive(false)
  self._isInAutoShow = true
  self._timerId = TimerManager:StartTimer(time, function()
    self:__ShowResult()
  end)
end

function UICommonQuickBattle:__ShowResult()
  self._isInAutoShow = false
  TimerManager:StopTimer(self._timerId)
  self._moviePlayer:CancelLoopSeek()
  self._moviePlayer:PresetsPauseVideoFrameNo(59)
  self.ui.list:SetActive(true)
  self.ui.obj_Finish:SetActive(true)
  self.ui.background.enabled = true
  self.ui.btn_Clear.gameObject:SetActive(true)
  self:_ShowDzdk()
end

function UICommonQuickBattle:_ShowDzdk()
  if self._dzdcDic == nil or table.IsEmptyTable(self._dzdcDic) then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(window)
    if window == nil then
      return
    end
    for itemId, num in pairs(self._dzdcDic) do
      window:ShowTips({itemId = itemId, num = num}, 2, eMessageSideType.ecParameter)
    end
  end)
end

function UICommonQuickBattle:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UICommonQuickBattle:_QuickQuit(toHome)
  if not toHome and self._isInAutoShow then
    self:__ShowResult()
    UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._QuickQuit):PushTopStatusDataToBackStack()
    return
  end
  self:Delete()
end

function UICommonQuickBattle:OnDelete()
  if self._moviePlayer ~= nil then
    self._moviePlayer:ReSet()
    cs_MovieManager:ReturnMoviePlayer(self._moviePlayer)
    self._moviePlayer = nil
  end
  self.rewardItemPool:DeleteAll()
  base.OnDelete(self)
end

return UICommonQuickBattle
