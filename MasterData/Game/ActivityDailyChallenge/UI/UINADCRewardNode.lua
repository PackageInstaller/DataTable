local UINADCRewardNode = class("UINADCRewardNode", UIBaseNode)
local base = UIBaseNode
local UINADCRewardItem = require("Game.ActivityDailyChallenge.UI.UINADCRewardItem")
local UINADCRewardPreiview = require("Game.ActivityDailyChallenge.UI.UINADCRewardPreiview")

function UINADCRewardNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.closeBG, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.btn_ScoreReward, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.bottom, self, self.OnClickCycleReward)
  UIUtil.AddButtonListener(self.ui.btn_receiveAll, self, self.__ReceiveAll)
  self.__OnClickRewardCallback = BindCallback(self, self.OnClickReward)
  self.__ReceiveAllCallback = BindCallback(self, self.__ReceiveAll)
  self._itemPool = UIItemPool.New(UINADCRewardItem, self.ui.item)
  self.ui.item:SetActive(false)
  self._previewNode = UINADCRewardPreiview.New()
  self._previewNode:Init(self.ui.rewardFrame)
  self._previewNode:Hide()
  self._index2ItemDic = {}
end

function UINADCRewardNode:InitADCRewardNode(adcData, callback)
  self._adcData = adcData
  self._cycleCfg = adcData:GetADCCycleAward()
  self._callback = callback
  self._itemPool:HideAll()
  local awardCfgList = self._adcData:GetADCAwardCfg()
  for i, cfg in ipairs(awardCfgList) do
    local item = self._itemPool:GetOne()
    item:InitADCRewardItem(self._adcData, i, self.__OnClickRewardCallback)
    self._index2ItemDic[i] = item
  end
  self.ui.exItem.transform:SetAsLastSibling()
  self:__RefreshExtra()
  self:__RefreshNextStage()
  self:__RefreshBtnReceiveAll()
  self._previewNode:Hide()
end

function UINADCRewardNode:RefreshADCRewardNode()
  for i, v in ipairs(self._itemPool.listItem) do
    v:RefreshADCRewardItem()
  end
  self:__RefreshExtra()
  self:__RefreshNextStage()
  self:__RefreshBtnReceiveAll()
  self._previewNode:Hide()
end

function UINADCRewardNode:__RefreshExtra()
  self.ui.tex_Score.text = tostring(self._adcData:GetADCTotalPoint())
  if self._adcData:GetADCTotalPoint() < self._adcData:GetADCMaxFixedPoint() then
    self.ui.img_progressCircle.fillAmount = 0
    self.ui.text.text = "0/" .. tostring(self._cycleCfg.need_point)
    return
  end
  local basePoint = math.max(self._adcData:GetADCCycleGotPoint(), self._adcData:GetADCMaxFixedPoint())
  local diff = self._adcData:GetADCTotalPoint() - basePoint
  self.ui.img_progressCircle.fillAmount = diff / self._cycleCfg.need_point
  self.ui.text.text = tostring(diff) .. "/" .. tostring(self._cycleCfg.need_point)
end

function UINADCRewardNode:__RefreshNextStage()
  local awardCfg = self._adcData:GetADCAwardCfg()
  local curPoint = self._adcData:GetADCTotalPoint()
  local extraCfg = self._adcData:GetADCCycleAward()
  local nextPoint = 0
  for index, cfg in ipairs(awardCfg) do
    if curPoint < cfg.need_point then
      nextPoint = cfg.need_point
      break
    end
  end
  if nextPoint == 0 then
    local diff = curPoint - self._adcData:GetADCMaxFixedPoint()
    diff = math.floor(diff / extraCfg.need_point) + 1
    nextPoint = self._adcData:GetADCMaxFixedPoint() + diff * extraCfg.need_point
  end
  self.ui.tex_num.text = tostring(nextPoint)
end

function UINADCRewardNode:__RefreshBtnReceiveAll()
  local canReceive = false
  local awardCfgList = self._adcData:GetADCAwardCfg()
  for i, cfg in ipairs(awardCfgList) do
    canReceive = self._adcData:IsCanADCFixedReward(cfg.need_point)
    if canReceive then
      break
    end
  end
  canReceive = canReceive or self._adcData:IsCanADCExtraReward()
  self.ui.btn_receiveAll.gameObject:SetActive(canReceive)
end

function UINADCRewardNode:OnClickReward(awardCfg, item)
  if not self._adcData:IsCanADCFixedReward(awardCfg.need_point) then
    self:__ShowPreview(awardCfg, item.transform.position, self._adcData:IsReceiveADCFixedReward(awardCfg.need_point))
    return
  end
  self._adcData:ReqADCScoreReward(awardCfg.need_point, false, false, function()
    self:__OnClickRewardCallBack()
  end)
end

function UINADCRewardNode:OnClickCycleReward()
  if not self._adcData:IsCanADCExtraReward() then
    self:__ShowPreview(self._cycleCfg, self.ui.exItem.transform.position, false)
    return
  end
  self._adcData:ReqADCScoreReward(nil, true, false, function()
    self:__OnClickRewardCallBack()
  end)
end

function UINADCRewardNode:__ReceiveAll()
  local awardCfgList = self._adcData:GetADCAwardCfg()
  local score
  local isCycle = true
  local getAll
  for i, cfg in ipairs(awardCfgList) do
    if self._adcData:IsCanADCFixedReward(cfg.need_point) then
      score = cfg.need_point
      isCycle = false
      getAll = true
      break
    end
  end
  self._adcData:ReqADCScoreReward(score, isCycle, getAll, function()
    self:__OnClickRewardCallBack()
  end)
end

function UINADCRewardNode:__OnClickRewardCallBack()
  if not IsNull(self.transform) then
    self:RefreshADCRewardNode()
    self:Roll2LatestItemPosition(false)
    if self._callback ~= nil then
      self._callback()
    end
  end
end

function UINADCRewardNode:Roll2LatestItemPosition(isNeedDotween)
  local awardCfgList = self._adcData:GetADCAwardCfg()
  local showIndex = 1
  for index, value in ipairs(awardCfgList) do
    local awardCfg = awardCfgList[index]
    local needPoint = awardCfg.need_point
    local unlock = needPoint <= self._adcData:GetADCTotalPoint()
    local canReward = self._adcData:IsCanADCFixedReward(needPoint)
    if unlock then
      if canReward then
        showIndex = index
        break
      else
        showIndex = index
      end
    end
  end
  CS.UnityEngine.Canvas.ForceUpdateCanvases()
  local item = self._index2ItemDic[showIndex]
  local scrollSize = self.ui.scrollrect.transform.rect.width
  local rectSize = self.ui.scrollrect.content.transform.rect.width
  if scrollSize >= rectSize or showIndex == 1 then
    self.ui.scrollrect.horizontalNormalizedPosition = 0
    return
  end
  local targetPos = item.transform.localPosition.x - item.transform.rect.width * item.transform.pivot.x
  local rate = math.min(targetPos / (rectSize - scrollSize), 1)
  if isNeedDotween then
    self.ui.scrollrect.horizontalNormalizedPosition = 0
    local time = rate * 0.3
    self.ui.scrollrect:DOHorizontalNormalizedPos(rate, time):SetDelay(0.05):SetLink(self.gameObject)
  else
    self.ui.scrollrect.horizontalNormalizedPosition = rate
  end
end

function UINADCRewardNode:__ShowPreview(awardCfg, pos, isPicked)
  pos = self._previewNode.transform.parent:InverseTransformPoint(pos)
  pos.y = self._previewNode.transform.localPosition.y
  pos.z = self._previewNode.transform.localPosition.z
  self._previewNode.transform.localPosition = pos
  self._previewNode:Show()
  self._previewNode:InitADCAwardPreview(awardCfg, isPicked)
end

return UINADCRewardNode
