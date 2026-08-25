local typeof = _ENV.typeof
local Image = CS.UnityEngine.UI.Image
local DBGDungeonsOutAwakerItem, Super = System.NewComponent("DBGDungeonsOutAwakerItem")

function DBGDungeonsOutAwakerItem:ctor(res, data)
  Super.ctor(self)
  self.ui = Item_Dungeons_Out_Awaker_DataResource(res)
  self.data = data
end

function DBGDungeonsOutAwakerItem:OnBind(binder)
  self.binder = binder
  local config = DT.AwakerConfig[self.data.configId]
  local iconPath = AwakerDataUtils.GetLittleIcon(self.data.configId)
  local schoolConfig = DT.SchoolConfig[config.School]
  binder:SetImage(self.ui.Image_Awaker, iconPath)
  binder:SetImage(self.ui.Image_Career_Icon, schoolConfig.Icon)
  binder:SetText(self.ui.Text_MaxExp, LT.Text("MaxLevel_Tips_Exp"))
  binder:SetActive(self.ui.Text_MaxExp, false)
  self:PlayAnim()
end

function DBGDungeonsOutAwakerItem:PlayAnim()
  local awakeData = AwakerDataUtils.GetAwakerData(self.data.configId)
  local oriLevel = awakeData.lastLevel
  local oriExp = awakeData.lastExp
  local curLevel = awakeData.level
  local curExp = awakeData.exp
  local curMaxExp = AwakerDataUtils.GetExpUpgrade(self.data.configId, curLevel)
  local upgradeLevel = curLevel - oriLevel
  local upgradeExp = 0
  if 0 == upgradeLevel then
    upgradeExp = curExp - oriExp
  else
    for i = oriLevel, curLevel do
      upgradeExp = upgradeExp + AwakerDataUtils.GetExpUpgrade(self.data.configId, i)
    end
    upgradeExp = upgradeExp - oriExp - (curMaxExp - curExp)
  end
  self.binder:SetText(self.ui.Text_Upgrade_Exp, LT.Textf("%s%s", "+", upgradeExp))
  if not self.data.showAnim or oriExp == curExp and oriLevel == curLevel then
    self.binder:SetText(self.ui.Text_Level, curLevel)
    self.binder:SetText(self.ui.Text_Upgrade_To, curMaxExp - curExp)
    self.binder:SetImageFillAmount(self.ui.Image_Level_Progress, curExp / curMaxExp)
    if oriExp == AwakerDataUtils.GetExpUpgrade(self.data.configId, oriLevel) then
      self.binder:SetActive(self.ui.Group_Upgrade, false)
      self.binder:SetActive(self.ui.Text_MaxExp, true)
    end
  else
    self.binder:SetText(self.ui.Text_Level, oriLevel)
    local playTime = self:PlaySliderAnim(self.data.configId, oriExp, curExp, oriLevel, upgradeLevel, 0.5)
    self:PlayExpAnim(self.data.configId, curExp, oriLevel, upgradeLevel, upgradeExp, playTime)
  end
end

function DBGDungeonsOutAwakerItem:PlaySliderAnim(awakerTid, startExp, endExp, startLevel, upgradeLevel, duration)
  local playTime = duration
  local endLevel = startLevel + upgradeLevel
  local imageProgress = self.ui.Image_Level_Progress:GetComponent(typeof(Image))
  if upgradeLevel and upgradeLevel > 0 then
    local startMaxExp = AwakerDataUtils.GetExpUpgrade(awakerTid, startLevel)
    local startPercent = startExp / startMaxExp
    local endMaxExp = AwakerDataUtils.GetExpUpgrade(awakerTid, endLevel)
    local endPercent = endExp / endMaxExp
    for level = startLevel, endLevel do
      if level == startLevel then
        local function playFunc()
          self.binder:SetImageFillAmount(self.ui.Image_Level_Progress, startPercent)
          
          imageProgress:DOFillAmount(1, duration)
        end
        
        if startExp == startMaxExp then
          playTime = playTime - duration + 0.001
        else
          playFunc()
        end
      elseif level == endLevel then
        local function playFunc()
          self.binder:SetImageFillAmount(self.ui.Image_Level_Progress, 0)
          
          imageProgress:DOFillAmount(endPercent, duration)
          self.binder:SetText(self.ui.Text_Level, level)
        end
        
        self.binder:BindTimer(playTime, 1, nil, playFunc)
      else
        local function playFunc()
          self.binder:SetImageFillAmount(self.ui.Image_Level_Progress, 0)
          
          imageProgress:DOFillAmount(1, duration)
          self.binder:SetText(self.ui.Text_Level, level)
        end
        
        self.binder:BindTimer(playTime, 1, nil, playFunc)
        playTime = playTime + duration
      end
    end
    return playTime
  else
    local startMaxExp = AwakerDataUtils.GetExpUpgrade(awakerTid, startLevel)
    local startPercent = startExp / startMaxExp
    local endPercent = endExp / startMaxExp
    self.binder:SetImageFillAmount(self.ui.Image_Level_Progress, startPercent)
    imageProgress:DOFillAmount(endPercent, duration)
    return playTime
  end
end

function DBGDungeonsOutAwakerItem:PlayExpAnim(awakerTid, endExp, startLevel, upgradeLevel, upgradeExp, duration)
  local endLevel = startLevel + upgradeLevel
  local endMaxExp = AwakerDataUtils.GetExpUpgrade(awakerTid, endLevel)
  local doneExp = endMaxExp - endExp
  local curShowExp = doneExp + upgradeExp
  local interval = duration / math.abs(upgradeExp)
  local isSub = upgradeExp > 0
  local subExpNum = isSub and -1 or 1
  subExpNum = math.floor(subExpNum * (math.abs(upgradeExp) / 50))
  if 0 == subExpNum % 10 then
    subExpNum = isSub and subExpNum - 1 or subExpNum + 1
  end
  self.playAnimTimer = self.binder:BindTimer(interval, -1, function()
    if self.playAnimTimer and curShowExp == doneExp then
      if endExp == endMaxExp then
        self.binder:SetActive(self.ui.Group_Upgrade, false)
        self.binder:SetActive(self.ui.Text_MaxExp, true)
      end
      TimerManager.Instance:StopTimer(self.playAnimTimer)
      self.playAnimTimer = nil
      return
    end
    if 0 ~= upgradeExp then
      curShowExp = curShowExp + subExpNum
      if subExpNum > 0 and curShowExp > doneExp then
        curShowExp = doneExp
      elseif subExpNum < 0 and curShowExp < doneExp then
        curShowExp = doneExp
      end
    end
    self.binder:SetText(self.ui.Text_Upgrade_To, curShowExp)
  end)
end

function DBGDungeonsOutAwakerItem:OnUnbind()
  if self.playAnimTimer then
    TimerManager.Instance:StopTimer(self.playAnimTimer)
    self.playAnimTimer = nil
  end
end

return DBGDungeonsOutAwakerItem
