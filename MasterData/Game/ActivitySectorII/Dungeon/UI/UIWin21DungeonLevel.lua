local UIWin21DungeonLevel = class("UIWin21DungeonLevel", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local cs_MessageCommon = CS.MessageCommon
local UINAWDunLevelItem = require("Game.ActivitySectorII.Dungeon.UI.UINAWDunLevelItem")
local UINAWDunLine = require("Game.ActivitySectorII.Dungeon.UI.UINAWDunLine")
local UINAWDunChallenge = require("Game.ActivitySectorII.Dungeon.UI.Challenge.UINAWDunChallenge")

function UIWin21DungeonLevel:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.__dunDataDic = nil
  self.__dunOrderList = nil
  self.levelItemDic = {}
  self.__selectDunData = nil
  self.__OnClickWADunItem = BindCallback(self, self.OnClickWADunItem)
  self.__showIntroduce = BindCallback(self, self.__ShowIntroduce)
  UIUtil.SetTopStatus(self, self.__OnReturnClick, nil, self.__showIntroduce)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnClickBackGround)
  UIUtil.AddButtonListener(self.ui.btn_IsDouble, self, self.__OnClickChangeMultEffic)
  UIUtil.AddButtonListener(self.ui.btn_PointUp, self, self.__OnClickPointUp)
  UIUtil.AddButtonListener(self.ui.btn_res, self, self.__OnClickTicketRes)
  self.levelItemPool = UIItemPool.New(UINAWDunLevelItem, self.ui.obj_levelItem)
  self.ui.obj_levelItem:SetActive(false)
  self.levelLinePool = UIItemPool.New(UINAWDunLine, self.ui.obj_lineItem)
  self.ui.obj_lineItem:SetActive(false)
  self._challengeNode = UINAWDunChallenge.New()
  self._challengeNode:Init(self.ui.challengeItem)
  self.__onActTechChange = BindCallback(self, self.__OnActTechChange)
  MsgCenter:AddListener(eMsgEventId.ActivityTechChange, self.__onActTechChange)
  self.__updateTopCurrencys = BindCallback(self, self.RefreshTicketCount)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  self:__SetDungeonSelectUI(false)
end

function UIWin21DungeonLevel:InitWADungeon(actId, barWin, closeCallback)
  self.actId = actId
  self.barWin = barWin
  self.closeCallback = closeCallback
  local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
  local SectorIIData = sectorIICtrl:GetSectorIIDataByActId(actId)
  self.__SectorIIData = SectorIIData
  self.__dunDataDic, self.__dunOrderList = SectorIIData:GetSectorIIDungeonDataDic()
  self:RefreshWADunItem()
  self:RefreshWADunLine()
  self._OnClickChallengeFunc = self._OnClickChallengeFunc or BindCallback(self, self._OnClickChallenge)
  self._challengeNode:InitAWDunChallenge(SectorIIData, self._OnClickChallengeFunc)
  self.techID = SectorIIData:GetTechId()
  self.tickId = SectorIIData:GetSectorIIDunTicketId()
  self:__InitTicketUI()
  self:RefreshPointMultRate()
  self:RefreshMultEffi()
  self:__ShowWADunItemTween()
end

function UIWin21DungeonLevel:__InitTicketUI()
  local cfg = ConfigData.item[self.tickId]
  if cfg == nil then
    error("Can`t find item cfg. id:" .. self.tickId)
    return
  end
  self.ui.img_Res.sprite = CRH:GetSprite(cfg.small_icon)
  self:RefreshTicketCount()
end

function UIWin21DungeonLevel:__OnActTechChange()
  self:RefreshPointMultRate()
  self:RefreshMultEffi()
end

function UIWin21DungeonLevel:RefreshWADunItem()
  self.levelItemPool:HideAll()
  for _, dunStageId in ipairs(self.__dunOrderList) do
    local SIIDunData = self.__dunDataDic[dunStageId]
    local dunItem = self.levelItemPool:GetOne()
    dunItem:RefreshWADunLevelItem(SIIDunData, self.__OnClickWADunItem)
  end
end

function UIWin21DungeonLevel:RefreshWADunLine()
  self.levelLinePool:HideAll()
  local lastLevelPos, cueLevelPos
  for index, dunStageId in ipairs(self.__dunOrderList) do
    local nextDunData = self.__dunDataDic[dunStageId]
    cueLevelPos = nextDunData:GetAWDungeonPos()
    if 1 < index then
      local lineItem = self.levelLinePool:GetOne()
      lineItem:RefreshAWDunLine(lastLevelPos, cueLevelPos, nextDunData)
    end
    lastLevelPos = cueLevelPos
  end
end

function UIWin21DungeonLevel:RefreshMultEffi()
  local isCouldUsingMultEffi = self.__SectorIIData:GetSectorII_EffiMultRate() > 0
  self.ui.btn_IsDouble.gameObject:SetActive(isCouldUsingMultEffi)
  if isCouldUsingMultEffi then
    local isUsingMultEffi = self.__SectorIIData:GetSectorII_IsTurnOnMultEffi()
    self.ui.obj_image_marker:SetActive(isUsingMultEffi)
  end
end

function UIWin21DungeonLevel:RefreshPointMultRate()
  local pointMultRateDic = self.__SectorIIData:GetSectorII_PointMultRat()
  local poitId = self.__SectorIIData:GetSectorIIDunPointId()
  local multRata = pointMultRateDic[poitId] or 0
  local isHaveMultRate = 0 < multRata
  self.ui.btn_PointUp.interactable = not isHaveMultRate
  if isHaveMultRate then
    self.ui.tex_PointMultNum:SetIndex(0, GetPreciseDecimalStr(multRata / 10, 0))
  else
    self.ui.tex_PointMultNum:SetIndex(1)
  end
end

function UIWin21DungeonLevel:RefreshTicketCount()
  self.ui.tex_Res.text = PlayerDataCenter:GetItemCount(self.tickId)
end

function UIWin21DungeonLevel:OnClickWADunItem(dunItem)
  local SIIDunData = dunItem.SIIDunData
  if self.__selectDunData == SIIDunData then
    return
  end
  self.barWin:Hide()
  self.__selectDunData = SIIDunData
  self.__selectItemPos = dunItem:GetAWDunLevelAnchoredPos()
  local parent = dunItem:GetStageHolderRect()
  local sizeDelta = Vector2.New(141, 145)
  self:__SetDungeonSelectParent(parent, sizeDelta)
  self:__SetDungeonSelectUI(true)
  local isLocked = not SIIDunData:GetIsLevelUnlock()
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(window)
    if window == nil then
      return
    end
    window:SetDunLevelDetaiHideStartEvent(function()
      if IsNull(self.gameObject) then
        error("UIWin21DungeonLevel gameobject is nil")
        return
      end
      self:__CancelSelect()
      self:__PlayMoveLeftTween(false)
    end)
    window:SetDunLevelDetaiHideEndEvent(nil)
    local width, duration = window:GetDLevelDetailWidthAndDuration()
    self:__PlayMoveLeftTween(true, width, duration)
    window:InitDungeonLevelDetail(SIIDunData, isLocked)
  end)
end

function UIWin21DungeonLevel:_OnClickChallenge(challengeNode, challengeDgData)
  if self.__selectDunData == challengeDgData then
    return
  end
  self.barWin:Hide()
  self.__selectDunData = challengeDgData
  self.__selectItemPos = challengeNode.transform.anchoredPosition
  local parent = challengeNode.transform
  local sizeDelta = Vector2.New(570, 190)
  self:__SetDungeonSelectParent(parent, sizeDelta)
  self:__SetDungeonSelectUI(true)
  local isLocked = not challengeDgData:GetIsLevelUnlock()
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(window)
    if window == nil then
      return
    end
    window:SetDunLevelDetaiHideStartEvent(function()
      self:__CancelSelect()
      self:__PlayMoveLeftTween(false)
    end)
    window:SetDunLevelDetaiHideEndEvent(nil)
    local width, duration = window:GetDLevelDetailWidthAndDuration()
    self:__PlayMoveLeftTween(true, width, duration)
    window:InitDungeonLevelDetail(challengeDgData, isLocked)
  end)
end

function UIWin21DungeonLevel:__CancelSelect()
  if self.__selectDunData == nil then
    return
  end
  self.barWin:Show()
  self:__SetDungeonSelectUI(false)
  self.__selectDunData = nil
end

function UIWin21DungeonLevel:__OnClickBackGround()
  if self.__selectDunData ~= nil then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.DungeonLevelDetail)
  end
  self.__selectDunData = nil
end

function UIWin21DungeonLevel:__OnClickChangeMultEffic()
  local bool = not self.__SectorIIData:GetSectorII_IsTurnOnMultEffi()
  self.__SectorIIData:SetSectorII_IsTurnOnMultEffi(bool)
  self:RefreshMultEffi()
  local dunLevelDetailWin = UIManager:GetWindow(UIWindowTypeID.DungeonLevelDetail)
  if dunLevelDetailWin ~= nil then
    dunLevelDetailWin:RefreshDunLevelDetaiEnterCost()
  end
end

function UIWin21DungeonLevel:__OnClickPointUp()
  local msg = ""
  local techID = self.techID or 0
  local techData = self.__SectorIIData:GetTechById(techID)
  if techData == nil then
    return
  end
  local str = LanguageUtil.GetLocaleText(techData.techCfg.name)
  msg = string.format(ConfigData:GetTipContent(7103), str)
  cs_MessageCommon.ShowMessageTipsWithErrorSound(msg)
end

function UIWin21DungeonLevel:__OnClickTicketRes()
  local itemCfg = ConfigData.item[self.tickId]
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  window:InitCommonItemDetail(itemCfg)
end

function UIWin21DungeonLevel:__OnReturnClick()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UIWin21DungeonLevel:__SetDungeonSelectUI(enabled)
  self.ui.obj_DunSel:SetActive(enabled)
end

function UIWin21DungeonLevel:__SetDungeonSelectParent(parent, sizeDelta)
  self.ui.obj_DunSel.transform:SetParent(parent)
  self.ui.obj_DunSel.transform.localPosition = Vector3.zero
  self.ui.obj_DunSel.transform.sizeDelta = sizeDelta
end

function UIWin21DungeonLevel:__ShowWADunItemTween()
  if self.__showSeq ~= nil then
    self.__showSeq:Restart()
  end
  local showSeq = cs_DoTween.Sequence()
  showSeq:SetAutoKill(false)
  local limitCount = #self.levelItemPool.listItem
  for k, item in ipairs(self.levelItemPool.listItem) do
    local point = item:GetPointUI()
    local title = item:GetTitleUI()
    local pk = (k - 1) * 0.15
    local tk = (limitCount - 1) * 0.15 + pk
    showSeq:Insert(pk, point:DOScale(Vector3.New(0, 0, 1), 0.4):SetEase(cs_Ease.OutBack):From())
    showSeq:Insert(tk, title:DOSizeDelta(Vector2.New(-330.3623, 86), 0.45):From())
  end
  for k, line in ipairs(self.levelLinePool.listItem) do
    local lk = k * 0.15
    local tran = line.transform
    showSeq:Insert(lk, tran:DOSizeDelta(Vector3.New(0, 4, 1), 0.4):From())
  end
  showSeq:OnComplete(function()
    for k, item in ipairs(self.levelItemPool.listItem) do
      item:SetTexTileBestFit(true)
    end
  end)
  self.__showSeq = showSeq
end

local BgX = UIManager.BackgroundStretchSize.x
local n = BgX * (CS.UIManager.Instance.CurNotchValue / 100)

function UIWin21DungeonLevel:__PlayMoveLeftTween(isLeft, offset, duration)
  self.ui.rect_map:DOKill()
  local map = self.ui.rect_map
  if not isLeft then
    map:DOLocalMoveX(0, self.duration)
    self.duration = 0
    return
  end
  local mid = (BgX - offset) / 2
  local move = mid - self.__selectItemPos.x - n
  move = math.clamp(move, -offset, 0)
  map:DOLocalMoveX(move, duration)
  self.duration = duration
end

function UIWin21DungeonLevel:__ShowIntroduce()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(ConfigData.game_config.win21GuideNum, nil)
end

function UIWin21DungeonLevel:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.__showSeq ~= nil then
    self.__showSeq:Kill()
    self.__showSeq = nil
  end
  self.ui.rect_map:DOKill()
  self._challengeNode:Delete()
  MsgCenter:RemoveListener(eMsgEventId.ActivityTechChange, self.__onActTechChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  base.OnDelete(self)
end

return UIWin21DungeonLevel
