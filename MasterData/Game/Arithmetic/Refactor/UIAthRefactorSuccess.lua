local UIAthRefactorSuccess = class("UIAthRefactorSuccess", UIBaseWindow)
local base = UIBaseWindow
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")
local UINAthUsingRate = require("Game.Arithmetic.UsingRate.UINAthUsingRate")
local cs_MessageCommon = CS.MessageCommon
local cs_tweening = CS.DG.Tweening
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local nodeHightList = {
  [1] = 120,
  [2] = 763.4835,
  [3] = 197.87
}

function UIAthRefactorSuccess:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Save, self, self._OnClickSave)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self._OnClickCancel)
  self.athDetailOld = UINAthDetailItem.New()
  self.athDetailOld:Init(self.ui.athDetailOld)
  self.athDetailNew = UINAthDetailItem.New()
  self.athDetailNew:Init(self.ui.athDetailNew)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
end

function UIAthRefactorSuccess:InitAthRefactorSuccess(athData, heroData)
  self:_InitData(athData)
  local isMulti = #self._affixGroupList > 1
  self.athDetailOld:SetAthDetailItemBrief(isMulti):InitAthDetailItem(nil, athData, heroData, nil, nil, true)
  self.athDetailNew:SetAthDetailItemBrief(isMulti):InitAthDetailItem(nil, athData, heroData, nil, nil, true)
  if isMulti then
    self:_InitExtra()
  else
    self:_SelectResult(1)
  end
  self:_UpdAthRfctDetailUsingRate()
  self:_PlayTween()
end

function UIAthRefactorSuccess:_PlayTween()
  self:__InitTheTween()
  self.ui.fXP_StarUpSuccessbj:Play()
end

function UIAthRefactorSuccess:_InitData(athData)
  self.athData = athData
  self.hasHighQuality = false
  self._affixGroupList = {}
  for k, v in ipairs(PlayerDataCenter.allAthData.athReconsitutionDataList) do
    local newAffixList = {}
    for k, affixElem in ipairs(athData.affixList) do
      if affixElem.lock then
        table.insert(newAffixList, affixElem)
      else
        local elem = v.reco[k - 1]
        local newAffixElem = DeepCopy(affixElem)
        newAffixElem.id = elem.id
        newAffixElem.quality = elem.quality
        newAffixElem.value = PlayerDataCenter.allAthData:GenAthAffixValue(newAffixElem.id, newAffixElem.quality, newAffixElem.level)
        if newAffixElem.quality > affixElem.quality then
          self.hasHighQuality = true
        end
        table.insert(newAffixList, newAffixElem)
      end
    end
    table.insert(self._affixGroupList, newAffixList)
  end
end

function UIAthRefactorSuccess:_InitExtra()
  if self._resultItemPool == nil then
    local UINRfctSuccessResultItem = require("Game.Arithmetic.Refactor.Success.UINRfctSuccessResultItem")
    self._resultItemPool = UIItemPool.New(UINRfctSuccessResultItem, self.ui.resultItem, false)
  end
  self.ui.ResultRect:SetAllTogglesOff()
  self._resultItemPool:HideAll()
  self._selectResultFunc = self._selectResultFunc or BindCallback(self, self._SelectResult)
  for k, affixList in ipairs(self._affixGroupList) do
    local isSelected = k == 1
    local resultItem = self._resultItemPool:GetOne()
    resultItem:InitRfctSuccessResultItem(k, affixList, self._selectResultFunc, isSelected)
  end
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.ResultRect.transform)
end

function UIAthRefactorSuccess:_UpdAthRfctDetailUsingRate()
  if self.athData.bindInfo == nil then
    self.ui.athUsingRate:SetActive(false)
    return
  end
  self._showUsingRate = true
  if self.athUsingRateNode == nil then
    local athUsingRate = UINAthUsingRate.New()
    athUsingRate:Init(self.ui.athUsingRate)
    athUsingRate:InitAthUsingRate(BindCallback(self, self._ShowUsingRateWin))
    self.athUsingRateNode = athUsingRate
  end
  self.athUsingRateNode:Show()
end

function UIAthRefactorSuccess:_ShowUsingRateWin()
  local heroData = PlayerDataCenter.heroDic[self.athData.bindInfo.id]
  local areaId = self.athData.bindInfo.idx
  self.athUsingRateNode:ShowAthUsingRateDetail(heroData, areaId)
end

function UIAthRefactorSuccess:_SelectResult(idx)
  self._selectResultIdx = idx
  self.athDetailNew:RefreshAthDetailItemSubAttr(self._affixGroupList[idx])
end

function UIAthRefactorSuccess:_OnClickSave()
  local function sendFunc()
    self.__OnSaveComplete = self.__OnSaveComplete or BindCallback(self, self._OnSaveComplete)
    
    self.athNetwork:CS_ATH_ReconsitutionSave(self._selectResultIdx - 1, self.__OnSaveComplete)
  end
  
  if self:_AnyBetterResult() then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(6049), sendFunc, nil)
    return
  end
  sendFunc()
end

function UIAthRefactorSuccess:_AnyBetterResult()
  local selectAffixList = self._affixGroupList[self._selectResultIdx]
  local selTotalQuality = 0
  for k, selectedAffix in ipairs(selectAffixList) do
    selTotalQuality = selTotalQuality + AthEnum.GetAthRfctBetterQualityWeight(selectedAffix.quality)
  end
  for k, affixList in ipairs(self._affixGroupList) do
    if k ~= self._selectResultIdx then
      local curQuality = 0
      for k2, selectedAffix in ipairs(affixList) do
        curQuality = curQuality + AthEnum.GetAthRfctBetterQualityWeight(selectedAffix.quality)
      end
      if selTotalQuality < curQuality then
        return true
      end
    end
  end
  return false
end

function UIAthRefactorSuccess:_OnSaveComplete()
  local window = UIManager:GetWindow(UIWindowTypeID.AthRefactor)
  if window ~= nil then
    window:ResetAthRefactor()
  end
  self:Hide()
end

function UIAthRefactorSuccess:_OnClickCancel()
  if self.__OnCancelComplete == nil then
    self.__OnCancelComplete = BindCallback(self, self._OnCancelComplete)
  end
  
  local function sendFunc()
    self.athNetwork:CS_ATH_ReconsitutionDrop(self.__OnCancelComplete)
  end
  
  if self.hasHighQuality then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.ATH_ConfirmCancelRefactor), sendFunc, nil)
  else
    sendFunc()
  end
end

function UIAthRefactorSuccess:_OnCancelComplete()
  local window = UIManager:GetWindow(UIWindowTypeID.AthRefactor)
  if window ~= nil then
    window:ResetAthRefactor()
  end
  self:Hide()
end

function UIAthRefactorSuccess:__InitTheTween()
  self.ui.obj_isNew:SetActive(false)
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill()
  end
  self.ui.canvasGroup.interactable = false
  self.tweenSeq = cs_tweening.DOTween.Sequence()
  local count = 0
  local delay = 0
  for index, Hight in ipairs(nodeHightList) do
    count = count + 1
    delay = count == 2 and 0.35 or 0
    self:__SetNodeShowTween(index, Hight, delay)
  end
end

function UIAthRefactorSuccess:__SetNodeShowTween(index, height, SetDelay)
  local delay = SetDelay or 0
  local fade = self.ui.fadeList[index]
  local layout = self.ui.layoutList[index]
  layout.minHeight = 0
  self.tweenSeq:Append(layout:DOMinSize(Vector2.New(0, height), 0.3, true):SetDelay(delay))
  if index == 1 then
    self.tweenSeq:Join(fade:DOFade(0, 0.1):SetLoops(6, cs_tweening.LoopType.Yoyo))
  elseif index == 2 then
    fade.alpha = 0
    self.tweenSeq:Join(fade:DOFade(1, 0.3))
    self:_SetAthItemTween(self.ui.athDetailOld, 300)
    self:_SetAthItemTween(self.ui.athDetailNew, 300)
  else
    fade.alpha = 0
    self.tweenSeq:Join(fade:DOFade(1, 0.3))
    self:_SetAthItemTween(self.ui.btn_Cancle.gameObject, 100)
    self:_SetAthItemTween(self.ui.btn_Save.gameObject, 100)
  end
  self.tweenSeq:OnComplete(function()
    self.ui.obj_isNew:SetActive(true)
    self.ui.canvasGroup.interactable = true
  end)
end

function UIAthRefactorSuccess:_SetAthItemTween(itemObj, office)
  local transform = itemObj.transform
  self.tweenSeq:Join(transform:DOAnchorPosY(transform.anchoredPosition.y - office, 0.3):From())
end

function UIAthRefactorSuccess:OnDelete()
  self.athDetailOld:Delete()
  self.athDetailNew:Delete()
  if self._resultItemPool ~= nil then
    self._resultItemPool:DeleteAll()
  end
  if self.athUsingRateNode then
    self.athUsingRateNode:Delete()
  end
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill()
    self.tweenSeq = nil
  end
  base.OnDelete(self)
end

return UIAthRefactorSuccess
