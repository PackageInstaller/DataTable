local UIEpBuff = class("UIEpBuff", UIBaseWindow)
local base = UIBaseWindow
local UIEpBuffDetailItem = require("Game.Exploration.UI.EpBuff.UIEpBuffDetailItem")
local UIEpBuffItem = require("Game.Exploration.UI.EpBuff.UIEpBuffItem")

function UIEpBuff:OnInit()
  self.__fadeTween = UIManager:PlayDoFade(self.ui.canvasGroup, 0, 1, 0.5)
  self.ui.buffItem:SetActive(false)
  self.ui.buffDetailItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.buffNode, self, self.OnBuffNodeClicked)
  UIUtil.AddButtonListener(self.ui.uI_BuffDetail, self, self.OnBuffDetailPanelClicked)
  UIUtil.AddValueChangedListener(self.ui.tog_Unfold, self, self.OnUnfoldClick)
  self.poolBuffItem = UIItemPool.New(UIEpBuffItem, self.ui.buffItem)
  self.poolBuffDetailItem = UIItemPool.New(UIEpBuffDetailItem, self.ui.buffDetailItem)
  self.__onEpBuffListChange = BindCallback(self, self.OnEpBuffListChange)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__onEpBuffListChange)
  self.contSizeX = self.ui.buffContent.transform.sizeDelta.x
  self.contSizeY = self.ui.buffContent.transform.sizeDelta.y
  self.buffItemLen = self.ui.buffContent.cellSize.x
end

function UIEpBuff:InitEpBuffList(dynPlayer)
  local buffList = dynPlayer:GetEpBuffList()
  self:OnEpBuffListChange(buffList)
end

function UIEpBuff:Show()
  base.Show(self)
  if self.__fadeTween ~= nil then
    self.__fadeTween:Kill()
  end
  self.__fadeTween = UIManager:PlayDoFade(self.ui.canvasGroup, 0, 1, 0.25)
end

function UIEpBuff:Hide()
  if self.__fadeTween ~= nil then
    self.__fadeTween:Kill()
  end
  self.__fadeTween = UIManager:PlayDoFade(self.ui.canvasGroup, 1, 0, 0.25, BindCallback(self, base.Hide))
end

function UIEpBuff:OnEpBuffListChange(buffList)
  self.buffList = buffList
  self:Show()
  self.poolBuffItem:HideAll()
  for k, epBuff in pairs(buffList) do
    local buffItem = self.poolBuffItem:GetOne()
    buffItem:InitEpBuffItem(epBuff)
  end
  self:__PagesOfBuffContent(buffList)
end

function UIEpBuff:Show()
  if self.buffList == nil or #self.buffList == 0 then
    self:Hide()
    return
  end
  base.Show(self)
end

function UIEpBuff:OnBuffNodeClicked()
  if self.buffList == nil or #self.buffList == 0 then
    return
  end
  self.ui.BuffDetailNode:SetActive(true)
  self.poolBuffDetailItem:HideAll()
  for k, epBuff in pairs(self.buffList) do
    local buffDetailItem = self.poolBuffDetailItem:GetOne()
    buffDetailItem:InitEpBuffDetail(epBuff)
  end
  self:OnUpdateSecond()
  self.__onUpdateSecondTimerId = TimerManager:StartTimer(1, self.OnUpdateSecond, self, false, false, true)
end

function UIEpBuff:OnUpdateSecond()
  local time = PlayerDataCenter.timestamp
  for k, buffDetailItem in pairs(self.poolBuffDetailItem.listItem) do
    buffDetailItem:RefershBuffDetailTime(time)
  end
end

function UIEpBuff:OnBuffDetailPanelClicked()
  self.ui.BuffDetailNode:SetActive(false)
  TimerManager:StopTimer(self.__onUpdateSecondTimerId)
end

function UIEpBuff:__PagesOfBuffContent(buffList)
  self.page = 1
  local buffCount = #buffList
  if self.buffItemLen * buffCount > self.contSizeX then
    self.page = self.page + 1
  end
  self.ui.tog_Unfold.gameObject:SetActive(self.page > 1)
end

function UIEpBuff:OnUnfoldClick(value)
  local newSizeY = 0
  local z = 0
  if value then
    newSizeY = self.contSizeY * self.page
    z = 180
  else
    newSizeY = self.contSizeY
  end
  self.ui.buffContent.transform.sizeDelta = Vector2.New(self.contSizeX, newSizeY)
  self.ui.obj_togIcon.transform.rotation = Vector3.New(0, 0, z)
end

function UIEpBuff:OnDelete()
  TimerManager:StopTimer(self.__onUpdateSecondTimerId)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__onEpBuffListChange)
  base.OnDelete(self)
end

return UIEpBuff
