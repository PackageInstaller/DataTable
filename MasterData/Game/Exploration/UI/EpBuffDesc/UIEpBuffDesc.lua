local UIEpBuffDesc = class("UIEpBuffDesc", UIBaseWindow)
local base = UIBaseWindow
local UINBuffDescItem = require("Game.Exploration.UI.EpBuffDesc.UINBuffDescItem")
local UINBuffTogs = require("Game.Exploration.UI.EpBuffDesc.UINBuffTogs")
local eEpBuffDescEnum = require("Game.Exploration.UI.EpBuffDesc.eEpBuffDescEnum")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local eTogsType = eEpBuffDescEnum.TogsType
local cs_DoTween = CS.DG.Tweening.DOTween

function UIEpBuffDesc:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.ui.epBuffDescItem:SetActive(false)
  self.ui.descPageBuffItem:SetActive(false)
  self.ui.ani_textContinue.gameObject:SetActive(false)
  self.ui.Img_Bg.raycastTarget = false
  self.ui.tex_EmptyTip.gameObject:SetActive(false)
  self._emptyTipActive = false
  self.ui.tex_Title:SetIndex(0)
  self.buffDescItemPool = UIItemPool.New(UINBuffDescItem, self.ui.epBuffDescItem)
  self.descPageItemPool = UIItemPool.New(UINBuffDescItem, self.ui.descPageBuffItem)
  UIUtil.AddButtonListener(self.ui.Btn_Bg, self, self._OnBackgroundClick)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self._OnClickBtnCheck)
  self._refershDunBuffDesc = BindCallback(self, self.RefershDunBuffDesc)
  self.buffTogs = UINBuffTogs.New()
  self.ui.obj_Togs:SetActive(false)
  self.buffTogs:Init(self.ui.obj_Togs)
  self._openFlyAniTimeScale = 1
  self.__cacheScrollRectScrollbar = self.ui.scrollRect_list.horizontalScrollbar
  self.ui.scrollRect_list.horizontalScrollbar = nil
  self.__cacheScrollRectScrollbar.gameObject:SetActive(false)
end

function UIEpBuffDesc:OnHide()
  self.buffTogs:Hide()
end

function UIEpBuffDesc:InitTimer(SetTime)
  self._timerID = TimerManager:StartTimer(SetTime, self._OnTimeOver, self, true, false, true)
end

function UIEpBuffDesc:InitEpBuffDesc(buffList, closeCallback, RefershFunc)
  self:InitTimer(self.ui.flo_canClickTime or 1)
  self.closeCallback = closeCallback
  if not RefershFunc then
    self:RefershEpBuffDesc(buffList)
  else
    RefershFunc(buffList)
  end
end

function UIEpBuffDesc:InitWCBuffDesc(buffList, closeCallback, index, aniTimeScale)
  self.ui.tex_Title:SetIndex(index or 0)
  self:InitEpBuffDesc(buffList, closeCallback, function()
    self:RefershEpBuffDesc(buffList, aniTimeScale)
  end)
end

function UIEpBuffDesc:InitDropBuffDesc(buffList, closeCallback, aniTimeScale)
  self.ui.tex_Title:SetIndex(6, tostring(table.count(buffList)))
  self:InitEpBuffDesc(buffList, closeCallback, function()
    self:RefershDropBuffDesc(buffList, aniTimeScale)
  end)
end

function UIEpBuffDesc:OpenBuffCloseFlyAni(aniTimeScale)
  self._openFlyAni = true
  aniTimeScale = aniTimeScale or 1
  self._openFlyAniTimeScale = aniTimeScale
end

function UIEpBuffDesc:InitEpBuffSelect(epBuffList, unlockBuffIdDic)
  self.ui.btn_Check.gameObject:SetActive(true)
  self.ui.btn_Check.interactable = false
  self.ui.Btn_Bg.enabled = false
  self.ui.tex_Title:SetIndex(1)
  self._OnClickBuffItemFunc = self._OnClickBuffItemFunc or BindCallback(self, self._OnClickBuffItem)
  for index, epBuff in ipairs(epBuffList) do
    local item = self.buffDescItemPool:GetOne(true)
    local lock = not unlockBuffIdDic[epBuff.dataId]
    item:InitBuffDescItemSelect(epBuff, lock, self._OnClickBuffItemFunc)
  end
  if 4 < #epBuffList then
    self.ui.contentSize.transform.pivot = Vector2.Temp(0, 0.5)
  else
    self.ui.contentSize.transform.pivot = Vector2.Temp(0.5, 0.5)
  end
  self.ui.contentSize.transform.anchoredPosition = Vector2.zero
end

function UIEpBuffDesc:InitEpFloorBuffShow(epBuff, closeCallback)
  local epBuffList = {epBuff}
  self.ui.tex_Title:SetIndex(2)
  self:InitEpBuffDesc(epBuffList, closeCallback)
end

function UIEpBuffDesc:InitGetEpBuffShow(epBuffList, closeCallback)
  self.ui.tex_Title:SetIndex(3)
  self:InitEpBuffDesc(epBuffList, closeCallback)
end

function UIEpBuffDesc:InitDescriptPageEpBuffShow(buffList, closeCallback)
  self.ui.tex_Title:SetIndex(4)
  self:InitEpBuffDesc(buffList, closeCallback, function(buffList)
    self:IniDescriptPageEpBuff(buffList)
    self.buffTogs:Show()
  end)
end

function UIEpBuffDesc:IniDescriptPageEpBuff(buffList)
  local positiveBuffList = {}
  local neutralBuffList = {}
  local negativeBuffList = {}
  local customBuffList = {}
  self.descPageItemPool:HideAll()
  for index, buff in ipairs(buffList) do
    if buff.epBuffCfg and buff.epBuffCfg.is_listshow then
      local item = self.descPageItemPool:GetOne(true)
      item:InitBuffDescItem(buff)
      if buff.epBuffCfg.buff_type == 0 then
        table.insert(neutralBuffList, item)
      elseif buff.epBuffCfg.buff_type == 1 then
        table.insert(positiveBuffList, item)
      elseif buff.epBuffCfg.buff_type == 2 then
        table.insert(negativeBuffList, item)
      end
      if buff.epBuffCfg.end_layer == 1 then
        table.insert(customBuffList, item)
      end
    elseif buff.wcBuffCfg and buff.wcBuffCfg.is_show then
      local item = self.descPageItemPool:GetOne(true)
      item:InitBuffDescItem(buff)
      if buff.wcBuffCfg.color_type == 2 then
        table.insert(neutralBuffList, item)
      elseif buff.wcBuffCfg.color_type == 1 then
        table.insert(positiveBuffList, item)
      elseif buff.wcBuffCfg.color_type == 3 then
        table.insert(negativeBuffList, item)
      end
      if buff.wcBuffCfg.show_type == eWarChessEnum.eWarChessBuffShowType.floor then
        table.insert(customBuffList, item)
      end
    elseif buff.dunBuffCfg and not buff.dunBuffCfg.is_hide then
      local item = self.descPageItemPool:GetOne(true)
      item:InitBuffDescItem(buff)
      if buff.dunBuffCfg.buff_type == 1 then
        table.insert(positiveBuffList, item)
      elseif buff.dunBuffCfg.buff_type == 2 then
        table.insert(negativeBuffList, item)
      end
    end
  end
  self.__pageList = {
    [eTogsType.All] = self.descPageItemPool.listItem,
    [eTogsType.Positive] = positiveBuffList,
    [eTogsType.Neutral] = neutralBuffList,
    [eTogsType.Negative] = negativeBuffList
  }
  if 0 < #customBuffList then
    self.__pageList[eTogsType.Custom] = customBuffList
    self.buffTogs:AddTog(eTogsType.Custom)
  end
end

function UIEpBuffDesc:RefershDescriptPageEpBuff(TogType, aniTimeScale)
  if self.__curTogType then
    local hideItemList = self.__pageList[self.__curTogType]
    for _, item in ipairs(hideItemList) do
      item:Hide()
    end
  end
  self.ui.scrollRect_list.horizontalScrollbar = self.__cacheScrollRectScrollbar
  local showItemList = self.__pageList[TogType]
  for _, item in ipairs(showItemList) do
    item:Show()
  end
  self.__curTogType = TogType
  if not self.__posDescPageContent then
    self.__posDescPageContent = self.ui.descPage_hLayout.transform.localPosition
  end
  self:_PlayBuffShowAni(showItemList, aniTimeScale, function()
    if not self.__originContent then
      self.__originContent = self.ui.scrollRect_list.content
    end
    self.ui.descPage_hLayout.transform.localPosition = self.__posDescPageContent
    self.ui.scrollRect_list.content = self.ui.descPage_hLayout.transform
  end)
end

function UIEpBuffDesc:RefershEpBuffDesc(buffList, aniTimeScale)
  self.buffDescItemPool:HideAll()
  for index, epBuff in ipairs(buffList) do
    if 4 < index then
      break
    end
    local item = self.buffDescItemPool:GetOne(true)
    item:InitBuffDescItem(epBuff)
  end
  self:_PlayBuffShowAni(self.buffDescItemPool.listItem, aniTimeScale, function()
    self.ui.hLayout.enabled = false
    self.ui.contentSize.enabled = false
  end, function()
    if not IsNull(self.gameobject) then
      self.ui.hLayout.enabled = true
      self.ui.contentSize.enabled = true
    end
  end)
end

function UIEpBuffDesc:RefershDropBuffDesc(buffList, aniTimeScale)
  self.buffDescItemPool:HideAll()
  for index, epBuff in ipairs(buffList) do
    local item = self.buffDescItemPool:GetOne(true)
    item:InitBuffDescItem(epBuff)
  end
end

function UIEpBuffDesc:_PlayBuffShowAni(showLsit, timeScale, onStartCallback, onCompleteCallback)
  CS.UnityEngine.Canvas.ForceUpdateCanvases()
  if self._showSeq ~= nil then
    self._showSeq:Complete()
    self._showSeq:Kill()
    self._showSeq = nil
    if self.__onCompleteCallback then
      self.__onCompleteCallback()
    end
  end
  if onStartCallback then
    onStartCallback()
  end
  self.__onCompleteCallback = onCompleteCallback
  local count = #showLsit
  if 0 < count then
    local intervalSec = 0.15
    if 4 < count then
      intervalSec = 0.6 / count
    end
    local sequence = cs_DoTween.Sequence()
    for index, item in ipairs(showLsit) do
      if 5 < index then
        break
      end
      local delay = (index - 1) * intervalSec
      sequence:Insert(0, item.transform:DOAnchorPosY(item.transform.anchoredPosition.y - 100, 0.5):From():SetDelay(delay):SetLink(item.gameObject))
      sequence:Insert(0, item.ui.fade:DOFade(0, 0.5):From():SetDelay(delay):SetLink(item.gameObject))
    end
    sequence:PrependInterval(0.05)
    sequence:OnComplete(function()
      if self.__onCompleteCallback then
        self.__onCompleteCallback()
      end
    end)
    sequence:SetUpdate(true)
    timeScale = timeScale or 1
    sequence.timeScale = timeScale
    self._showSeq = sequence
    if self._emptyTipActive then
      self.ui.tex_EmptyTip.gameObject:SetActive(false)
      self._emptyTipActive = false
    end
  elseif not self._emptyTipActive then
    self.ui.tex_EmptyTip.gameObject:SetActive(true)
    self._emptyTipActive = true
  end
end

function UIEpBuffDesc:InitDunBuffDesc(buffCfgList, closeCallback)
  self:InitEpBuffDesc(buffCfgList, closeCallback, self._refershDunBuffDesc)
end

function UIEpBuffDesc:RefershDunBuffDesc(buffCfgList)
  self.buffDescItemPool:HideAll()
  local isUp4 = 4 < #buffCfgList
  if isUp4 then
    self.ui.normalCardContent.pivot = Vector2.Temp(0, 0.5)
  else
    self.ui.normalCardContent.pivot = Vector2.Temp(0.5, 0.5)
  end
  for index, buffCfg in ipairs(buffCfgList) do
    local item = self.buffDescItemPool:GetOne(true)
    item:InitBuffDescItemByCfg(buffCfg)
  end
  self:_PlayBuffShowAni(self.buffDescItemPool.listItem, nil, function()
    self.ui.hLayout.enabled = false
    self.ui.contentSize.enabled = false
  end, function()
    self.ui.hLayout.enabled = true
    self.ui.contentSize.enabled = true
  end)
end

function UIEpBuffDesc:_OnTimeOver()
  if IsNull(self.transform) then
    return
  end
  self.ui.Img_Bg.raycastTarget = true
  if not self.__originContent then
    self.ui.ani_textContinue.gameObject:SetActive(true)
  end
end

function UIEpBuffDesc:BackAction()
  if not self._openFlyAni then
    self:Delete()
    if self.closeCallback ~= nil then
      self.closeCallback()
    end
    return
  end
  UIUtil.AddOneCover("UIEpBuffDesc")
  local seq = cs_DoTween.Sequence()
  local posList = {}
  for i, item in pairs(self.buffDescItemPool.listItem) do
    table.insert(posList, item.transform.localPosition)
  end
  local destPos = self.ui.defaultPos.position
  local chessMainWindow = UIManager:GetWindow(UIWindowTypeID.WarChessMain)
  if chessMainWindow ~= nil then
    local pos = chessMainWindow:GetWCMTopBuffPos()
    if pos ~= nil then
      destPos = pos
    end
  end
  for index, item in ipairs(self.buffDescItemPool.listItem) do
    item:StartBuffDescFlySeq(seq, destPos, posList[index])
  end
  seq.timeScale = self._openFlyAniTimeScale
  seq:SetLink(self.gameObject)
  seq:OnComplete(function()
    self:Delete()
    if self.closeCallback ~= nil then
      self.closeCallback()
    end
  end)
  seq:SetUpdate(true)
end

function UIEpBuffDesc:_OnBackgroundClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEpBuffDesc:_OnClickBuffItem(buffItem, epBuff)
  if self._lastSelectBuffItem ~= nil then
    self._lastSelectBuffItem:SetBuffDescItemSelect(false)
  end
  buffItem:SetBuffDescItemSelect(true)
  self._lastSelectBuffItem = buffItem
  self._selectedBuffId = epBuff.dataId
  self.ui.btn_Check.interactable = true
end

function UIEpBuffDesc:_OnClickBtnCheck()
  if ExplorationManager:IsInExploration() then
    local net = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
    net:CS_EXPLORATION_OpeninBuffSelect(self._selectedBuffId, function()
      UIUtil.OnClickBackByUiTab(self)
    end)
    return
  elseif WarChessSeasonManager:IsInWCS() then
    local wid = WarChessManager:GetWarChessCtrl():GetWCId()
    local net = NetworkManager:GetNetwork(NetworkTypeID.WarChess)
    net:CS_WarChess_Choice_Protocol(wid, self._selectedBuffId, function()
      WarChessSeasonManager:GetWCSCtrl():CleanWCSInitUnlockDic()
      UIUtil.OnClickBackByUiTab(self)
    end)
    return
  end
  error("Unsurpported select buff")
end

function UIEpBuffDesc:OnHide()
  if self.__originContent then
    self.ui.descPage_hLayout.transform.localPosition = self.__posDescPageContent
    self.ui.scrollRect_list.content = self.__originContent
    self.__originContent = nil
  end
end

function UIEpBuffDesc:OnDelete()
  UIUtil.CloseOneCover("UIEpBuffDesc")
  if self._timeID ~= nil then
    TimerManager:StopTimer(self._timerID)
    self._timerID = nil
  end
  self.ui.ani_textContinue:DOKill()
  if self._showSeq ~= nil then
    self._showSeq:Kill()
    self._showSeq = nil
  end
  self.__posDescPageContent = nil
  self.__pageList = nil
  self.buffDescItemPool:DeleteAll()
  self.descPageItemPool:DeleteAll()
  self.buffTogs:Delete()
  base.OnDelete(self)
end

return UIEpBuffDesc
