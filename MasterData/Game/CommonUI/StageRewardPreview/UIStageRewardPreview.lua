local UIStageRewardPreview = class("UIStageRewardPreview", UIBaseWindow)
local base = UIBaseWindow
local UINStageRewardPreItem = require("Game.CommonUI.StageRewardPreview.UINStageRewardPreItem")

function UIStageRewardPreview:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self._OnClickReceivedAll)
  self.rowItemPool = UIItemPool.New(UINStageRewardPreItem, self.ui.rowItem, false)
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  self.ui.tex_HeadAttri1:SetIndex(0)
end

function UIStageRewardPreview:InitUIStageRewardPreview(rewardListCfg, curStage, numStage)
  self.ui.obj_Current.gameObject:SetActive(false)
  local showCur = false
  local showCurItem
  self.rowItemPool:HideAll()
  for k, v in ipairs(rewardListCfg) do
    local isPick = k <= curStage
    local rowItem = self.rowItemPool:GetOne()
    rowItem:InitStageRewardPreItem(v, isPick)
    if numStage and numStage == k and not showCur then
      showCur = true
      showCurItem = rowItem
    elseif not numStage and curStage == k and not showCur then
      showCur = true
      showCurItem = rowItem
    end
  end
  if showCur and showCurItem then
    self.ui.obj_Current.gameObject:SetActive(true)
    local parent = showCurItem:GetStageRewardPreItemCurHolder()
    self.ui.obj_Current:SetParent(parent)
    self.ui.obj_Current.anchoredPosition = Vector2.zero
  end
  if showCur then
    local nowStage = numStage or curStage
    self.ui.scrollRect.verticalNormalizedPosition = 1 - (nowStage - 1) / (#rewardListCfg - 1)
  else
    self.ui.scrollRect.verticalNormalizedPosition = 1
  end
end

function UIStageRewardPreview:InitUIStageRewardPreviewV2(rewardListCfg, pickedScore, curScore, receiveAllFunc)
  self.ui.obj_Current.gameObject:SetActive(false)
  local showCur, showCurItem
  self.rowItemPool:HideAll()
  for index, cfg in ipairs(rewardListCfg) do
    local isPick = pickedScore >= cfg.score
    local rowItem = self.rowItemPool:GetOne()
    rowItem:InitStageRewardPreItem(cfg, isPick)
    if curScore >= cfg.score then
      showCur = index
      showCurItem = rowItem
      if not isPick and receiveAllFunc ~= nil then
        self:SetRewardReceivedAllFunc(receiveAllFunc)
      end
    end
  end
  if showCur and showCurItem then
    self.ui.obj_Current.gameObject:SetActive(true)
    local parent = showCurItem:GetStageRewardPreItemCurHolder()
    self.ui.obj_Current:SetParent(parent)
    self.ui.obj_Current.anchoredPosition = Vector2.zero
  end
  if showCur then
    self.ui.scrollRect.verticalNormalizedPosition = 1 - (showCur - 1) / (#rewardListCfg - 1)
  else
    self.ui.scrollRect.verticalNormalizedPosition = 1
  end
end

function UIStageRewardPreview:SetRewardReceivedAllFunc(func)
  if func then
    self.ui.btn_ReceiveAll.gameObject:SetActive(true)
  else
    self.ui.btn_ReceiveAll.gameObject:SetActive(false)
  end
  self.receiveAllFunc = func
end

function UIStageRewardPreview:_OnClickReceivedAll()
  if self.receiveAllFunc then
    self.receiveAllFunc()
  end
end

function UIStageRewardPreview:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIStageRewardPreview:OnDelete()
  self.rowItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIStageRewardPreview
