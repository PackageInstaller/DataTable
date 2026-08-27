local UITDProcessView = class("UITDProcessView", UIBaseWindow)
local base = UIBaseWindow
local UINTDProcessViewItem = require("Game.BattleTowerDefence.UI.UINTDProcessViewItem")

function UITDProcessView:OnInit()
  self.viewItemPool = UIItemPool.New(UINTDProcessViewItem, self.ui.obj_processItem)
  self.ui.obj_processItem:SetActive(false)
  self.listLen = self.ui.tran_list.rect.width
  self.centerLen = self.listLen / 2
  self.ui.obj_cCNode:SetActive(false)
  self.ui.obj_factorTip:SetActive(false)
end

function UITDProcessView:RefreshLightProcessView(mapData, curCount, beforeCount, closeFunc)
  self.ui.tex_Title:SetIndex(1)
  self:__RefreshProcessView(mapData, curCount, beforeCount, closeFunc)
end

function UITDProcessView:RefreshFactorTip(gradeUp, gradeDown)
  self.ui.obj_factorTip:SetActive(true)
  self.ui.tex_factorTip:SetIndex(0, tostring(gradeDown), tostring(gradeUp))
end

function UITDProcessView:RefreshTDProcessView(mapData, curCount, beforeCount, closeFunc)
  self.ui.tex_Title:SetIndex(0)
  self:__RefreshProcessView(mapData, curCount, beforeCount, closeFunc)
end

function UITDProcessView:__RefreshProcessView(mapData, curCount, beforeCount, closeFunc)
  self.mapData = mapData
  local totalCount = mapData.maxMapColNumber
  if totalCount == nil or totalCount == 0 then
    error("UITDProcessView totalCount is nil or 0")
    return
  end
  if curCount == nil or curCount == 0 then
    error("UITDProcessView curCount is nil or 0")
    return
  end
  if closeFunc ~= nil then
    closeFunc()
  end
  self:_ClearAutoHideTimer()
  self._autoHideTiemrId = TimerManager:StartTimer(3, self.Hide, self, true)
  self.diff = curCount - beforeCount or 0
  self.curCount = curCount
  self.totalCount = totalCount
  self.maxLen = (totalCount - 1) * self.ui.flo_unitLen
  self.isAdd = 0 < self.diff
  self.isSingle = totalCount == 1
  self.notExceed = not (self.ui.flo_unitLen * totalCount > self.listLen)
  self.ui.img_Bar.fillAmount = 0
  self.ui.tex_Progress.text = tostring(self.curCount - self.diff) .. "/" .. tostring(totalCount)
  self.ui.obj_barNode:SetActive(1 < totalCount)
  self:_InitListRect(totalCount, beforeCount)
  self:_InitViewItem(totalCount, curCount)
  self:_InitTween(curCount)
end

function UITDProcessView:_ClearAutoHideTimer()
  TimerManager:StopTimer(self._autoHideTiemrId)
end

function UITDProcessView:RefreshCC(hideInterest)
  if self.ui.obj_cCNode.activeSelf then
    self.ui.obj_cCNode:SetActive(false)
  end
  if ExplorationManager == nil then
    return
  end
  local dynplayer = ExplorationManager:GetDynPlayer()
  if dynplayer == nil then
    return
  end
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  if epTypeCfg == nil then
    return
  end
  if not self.ui.obj_cCNode.activeSelf then
    self.ui.obj_cCNode:SetActive(true)
  end
  local theMoney = dynplayer:GetMoneyCount()
  if theMoney >= ConfigData.game_config.towerMoneyMax then
    hideInterest = true
  end
  local isInterestOpen = epTypeCfg.interest_open and not hideInterest
  self.ui.tex_CCAdd.text.enabled = isInterestOpen
  if isInterestOpen then
    local y = 1 + epTypeCfg.interest[1] / 1000
    local x = math.ceil(theMoney / y)
    local add = math.floor(x * epTypeCfg.interest[1] / 1000)
    if add >= epTypeCfg.interest[2] then
      add = epTypeCfg.interest[2]
      theMoney = theMoney - add
    else
      theMoney = x
    end
    self.ui.tex_CCAdd:SetIndex(0, tostring(add))
  end
  self.ui.tex_CC.text = tostring(theMoney)
end

function UITDProcessView:_InitListRect(totalCount, beforeCount)
  local function Inner(total)
    local max = (total - 1) * self.ui.flo_unitLen
    
    return self.centerLen - max * 0.5
  end
  
  local function OutSide(cur, total)
    local v = (cur - 1) * self.ui.flo_unitLen
    return self:_GetMoveRectX(v)
  end
  
  local pos = self.ui.tran_rect.anchoredPosition
  pos.x = self.isSingle or self.notExceed and Inner(totalCount) or OutSide(beforeCount, totalCount)
  self.ui.tran_rect.anchoredPosition = pos
end

function UITDProcessView:_InitViewItem(totalCount, curCount)
  self.viewItemPool:HideAll()
  for roomX = 1, totalCount do
    local item = self.viewItemPool:GetOne()
    item:InitTDProcessViewItem(roomX, self.mapData, roomX < curCount)
  end
end

function UITDProcessView:_InitTween(curCount)
  if self.selItem ~= nil then
    self.selItem:DOTweenKill()
  end
  self.ui.img_Bar:DOKill(true)
  self.ui.tran_rect:DOKill()
  local selItem = self.viewItemPool.listItem[curCount]
  if selItem ~= nil then
    self.selItem = selItem
  end
  local fillAmount = 0
  if 0 < curCount - 1 then
    fillAmount = (curCount - 1) / (self.totalCount - 1)
    self.ui.img_Bar.fillAmount = (curCount - self.diff - 1) / (self.totalCount - 1)
  end
  local duraction = 0 < fillAmount and self.isAdd and 1 or 0
  self.ui.img_Bar:DOFillAmount(fillAmount, duraction):OnComplete(function()
    self.ui.img_Bar.fillAmount = fillAmount
    self.selItem:PlayScaleTween()
    self.ui.tex_Progress.text = tostring(curCount) .. "/" .. tostring(self.totalCount)
  end)
  if self.isSingle or self.notExceed then
    return
  end
  local v = (curCount - 1) * self.ui.flo_unitLen
  local moveX = self:_GetMoveRectX(v)
  self.ui.tran_rect:DOAnchorPosX(moveX, duraction)
end

function UITDProcessView:_GetMoveRectX(value)
  if value <= self.centerLen then
    return 0
  end
  if value <= self.maxLen - self.centerLen then
    return self.centerLen - value
  end
  return self.listLen - self.maxLen
end

function UITDProcessView:OnHide()
  self:_ClearAutoHideTimer()
  base.OnHide(self)
end

function UITDProcessView:OnDelete()
  self.viewItemPool:DeleteAll()
  self.ui.img_Bar:DOKill()
  base.OnDelete(self)
end

return UITDProcessView
