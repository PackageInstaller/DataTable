_class("UIS4ProgressController", UIController)
UIS4ProgressController = UIS4ProgressController

function UIS4ProgressController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIS4ProgressController:OnShow(uiParams)
  self._tradeData = uiParams[1]
  self._campaign = uiParams[2]
  self.TotalProcessCompInfo = self._tradeData:GetTotalProcessCompInfo()
  self.RewardProcessCompInfo = self._tradeData:GetRewardProcessCompInfo()
  self.TotalProcessComp = self._tradeData:GetTotalProcessComp()
  self.RewardProcessComp = self._tradeData:GetRewardProcessComp()
  self.TotalList = self.TotalProcessComp:GetProgressList()
  self.RewardList = self.RewardProcessComp:GetProgressList()
  self.TotalCurrentProgress = self.TotalProcessCompInfo.m_current_progress
  self.RewardCurrentProgress = self.RewardProcessCompInfo.m_current_progress
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self:InitWidget()
  self:InitData()
  self:PlayLevelUpAnimIn()
end

function UIS4ProgressController:InitWidget()
  self._backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._commonTopBtn = self._backBtns:SpawnObject("UISeasonTopBtn")
  self._commonTopBtn:SetData(function()
    local LockName = "UIS4ProgressController_AnimOut"
    self:StartTask(function(TT)
      self:Lock(LockName)
      self._anim:Play("uianim_UIS4ProgressController_out")
      YIELD(TT, 300)
      self:UnLock(LockName)
      self:CloseDialog()
    end)
    self:CloseDialog()
  end, function()
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    seasonModule:UIModule():ExitSeasonTo(UIStateType.UIMain)
  end, nil, nil, nil)
  self.businessContent = self:GetUIComponent("UISelectObjectPath", "BusinessContent")
  self.profitContent = self:GetUIComponent("UISelectObjectPath", "ProfitContent")
  self.level = self:GetUIComponent("UILocalizationText", "Level")
  self.processCount = self:GetUIComponent("UILocalizationText", "ProcessCount")
  self.business = self:GetGameObject("Business")
  self.profit = self:GetGameObject("Profit")
  self.shopOnChoose = self:GetGameObject("ShopOnChoose")
  self.profitOnChoose = self:GetGameObject("ProfitOnChoose")
  self.maxLevelObj = self:GetGameObject("MaxLevel")
  self.levelUpBtnObj = self:GetGameObject("LevelUpBtn")
  self.BusinessRed = self:GetGameObject("BusinessRed")
  self.ProfitRed = self:GetGameObject("ProfitRed")
  self.LockMask = self:GetGameObject("Lock")
  self.LevelRedPoint = self:GetGameObject("LevelRedPoint")
  self._anim = self:GetUIComponent("Animation", "_anim")
  self.LastLevel = self:GetUIComponent("UILocalizationText", "LastLevel")
end

function UIS4ProgressController:InitData()
  self:LoadBusiness()
  self:LoadProfit(true)
  self:SetProfitLevelData()
  self:BtnChose(true)
  self:RefreshRedPoint()
end

function UIS4ProgressController:LoadBusiness()
  local count = table.count(self.TotalList)
  self.BusinessItems = self.businessContent:SpawnObjects("UIS4BusinessProgress", count)
  for i, v in ipairs(self.BusinessItems) do
    local progress = self.TotalList[i]
    local status = self.TotalProcessComp:CheckItemStatus(progress)
    local rewards = self.TotalProcessComp:GetProgressRewards(progress)
    v:SetData(i, status, progress, rewards, function(progress)
      self.TotalProcessComp:Start_HandleReceiveReward(progress, function(res, rewards)
        self:_OnBusinessReceiveRewards(res, rewards)
      end)
    end)
  end
  for i, v in ipairs(self.BusinessItems) do
    v:PlayProgressAnimIn()
  end
end

function UIS4ProgressController:_OnBusinessReceiveRewards(res, rewards)
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
    self.TotalList = self.TotalProcessComp:GetProgressList()
    self:LoadBusiness()
    self:RefreshRedPoint()
  else
    self._campaign:CheckErrorCode(res.m_result)
  end
end

function UIS4ProgressController:LoadProfit(playAnim)
  local count = table.count(self.RewardList)
  local NormalList = self:GetListForNumber(self.RewardList)
  self.RewardProcessComp:SortProgressListByCampaignPersonProgressStatus(self.RewardList)
  self.ProfitItems = self.profitContent:SpawnObjects("UIS4ProfitTarget", count)
  for i, v in ipairs(self.ProfitItems) do
    local number = NormalList[self.RewardList[i]]
    local progress = self.RewardList[i]
    local status = self.RewardProcessComp:CheckItemStatus(progress)
    local rewards = self.RewardProcessComp:GetProgressRewards(progress)
    v:SetData(i, number, status, progress, rewards, function(progress)
      self.RewardProcessComp:Start_HandleReceiveReward(progress, function(res, rewards)
        self:_OnProfitReceiveRewards(res, rewards)
      end)
    end)
  end
  if playAnim then
    for i, v in ipairs(self.ProfitItems) do
      if i < 100 then
        v:PlayProfitAnimIn()
      else
        break
      end
    end
  end
end

function UIS4ProgressController:_OnProfitReceiveRewards(res, rewards)
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
    self.RewardList = self.RewardProcessComp:GetProgressList()
    self:LoadProfit()
    self:RefreshRedPoint()
  else
    self._campaign:CheckErrorCode(res.m_result)
  end
end

function UIS4ProgressController:GetListForNumber(RewardList)
  local list = {}
  for k, v in pairs(RewardList) do
    list[v] = k
  end
  return list
end

function UIS4ProgressController:BtnChose(ToBusiness)
  local LockName = "UIS4ProgressController_Change"
  if ToBusiness then
    self.shopOnChoose:SetActive(true)
    self.profitOnChoose:SetActive(false)
    for i, v in ipairs(self.BusinessItems) do
      v:PlayProgressAnimIn()
    end
    self:StartTask(function(TT)
      self:Lock(LockName)
      self._anim:Play("uianim_UIS4ProgressController_Business")
      YIELD(TT, 300)
      self:UnLock(LockName)
    end)
  else
    self.shopOnChoose:SetActive(false)
    self.profitOnChoose:SetActive(true)
    for i, v in ipairs(self.ProfitItems) do
      if i < 10 then
        v:PlayProfitAnimIn()
      else
        break
      end
    end
    self:StartTask(function(TT)
      self:Lock(LockName)
      self._anim:Play("uianim_UIS4ProgressController_profit")
      YIELD(TT, 300)
      self:UnLock(LockName)
    end)
  end
end

function UIS4ProgressController:SetProfitLevelData()
  local level = 0
  local m_progress = self.RewardProcessCompInfo.m_progress
  local OrderList = self.RewardProcessComp:GetProgressList()
  local max = OrderList[1]
  for i, v in ipairs(OrderList) do
    if v <= m_progress then
      if level < table.count(OrderList) then
        level = level + 1
      end
    else
      max = v
      break
    end
  end
  self.level:SetText(level)
  self.levelNumber = level
  local countStr
  if max > self.RewardCurrentProgress then
    self.LockMask:SetActive(true)
    self.LevelRedPoint:SetActive(false)
    countStr = "<color=#e64712>" .. self.RewardCurrentProgress .. "</color>"
  else
    self.LockMask:SetActive(false)
    self.LevelRedPoint:SetActive(true)
    countStr = "<color=#EAE1D0>" .. max .. "</color>"
  end
  if m_progress == OrderList[table.count(OrderList)] then
    self.levelUpBtnObj:SetActive(false)
    self.maxLevelObj:SetActive(true)
    countStr = "<color=#EAE1D0>" .. m_progress .. "</color>"
    self.processCount:SetText(countStr .. "/" .. m_progress)
  else
    self.processCount:SetText(countStr .. "/" .. max)
  end
end

function UIS4ProgressController:RefreshRedPoint()
  local totalRed = self.TotalProcessComp:HasCanGetReward()
  local ProfitAwardRed = self.RewardProcessComp:HasCanGetReward()
  local ProfitLevelRed = self.RewardProcessComp:HasCanLevelUp()
  self.BusinessRed:SetActive(totalRed)
  self.ProfitRed:SetActive(ProfitAwardRed or ProfitLevelRed)
  local controller = GameGlobal.UIStateManager():GetController("UIS4TradeMainController")
  controller:RefreshRedPoint()
end

function UIS4ProgressController:LevelUpBtnOnClick(go)
  local m_progress = self.RewardProcessCompInfo.m_progress
  local m_current_progress = self.RewardProcessCompInfo.m_current_progress
  local HandleProgress
  local OrderList = self.RewardProcessComp:GetProgressList()
  for key, value in pairs(OrderList) do
    if value > m_progress then
      HandleProgress = value
      break
    end
  end
  if m_current_progress < HandleProgress then
    return
  end
  self:StartTask(self.ProfitLevelUp, self, HandleProgress)
end

function UIS4ProgressController:ProfitLevelUp(TT, progress)
  local lockName = "UIS4ProgressController:ProfitLevelUp"
  self:Lock(lockName)
  local res = AsyncRequestRes:New()
  local result = self.RewardProcessComp:HandlePersonProgressProgressReq(TT, res, progress)
  self:UnLock(lockName)
  if res:GetSucc() then
    self.RewardList = self.RewardProcessComp:GetProgressList()
    self:LoadProfit(false)
    self:RefreshRedPoint()
    local LockName = "UIS4ProgressController_AnimIN"
    self:StartTask(function(TT)
      self:Lock(LockName)
      self.level:SetText(self.levelNumber + 1)
      self.LastLevel.gameObject:SetActive(true)
      self.LastLevel:SetText(self.levelNumber)
      local OrderList = self.RewardProcessComp:GetProgressList()
      if self.RewardProcessCompInfo.m_progress == OrderList[table.count(OrderList)] then
        self.levelUpBtnObj:SetActive(false)
        self.maxLevelObj:SetActive(true)
      end
      self._anim:Play("uianim_UIS4ProgressController_up")
      YIELD(TT, 700)
      self:UnLock(LockName)
      self:SetProfitLevelData()
    end)
  else
    Log.error("###[UIS4ProgressController] ProfitLevelUp fail, result:", res:GetResult(), " progress:", progress)
  end
end

function UIS4ProgressController:ChangeBusinessOnClick(go)
  if self.shopOnChoose.activeSelf then
    return
  end
  self:BtnChose(true)
end

function UIS4ProgressController:ChangeProfitOnClick(go)
  if self.profitOnChoose.activeSelf then
    return
  end
  self:BtnChose(false)
end

function UIS4ProgressController:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIS4ProgressController:PlayLevelUpAnimIn()
  local LockName = "UIS4ProgressController_AnimIN"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4ProgressController_in")
    YIELD(TT, 500)
    self:UnLock(LockName)
  end)
end
