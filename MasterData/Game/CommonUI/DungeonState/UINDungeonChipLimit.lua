local UINDungeonChipLimit = class("UINDungeonChipLimit", UIBaseNode)
local base = UIBaseNode
local CS_DOTween = CS.DG.Tweening.DOTween
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UINDungeonChipLimit:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SellChip, self, self._OnSellChipClick)
  self.__onEpSceneStateChanged = BindCallback(self, self._OnEpSceneStateChanged)
  MsgCenter:AddListener(eMsgEventId.OnEpSceneStateChanged, self.__onEpSceneStateChanged)
  self:_InitChipLimitSequence()
end

function UINDungeonChipLimit:InitDungeonChipLimit(chipLimitInfo)
  self.chipLimitInfo = chipLimitInfo
  self._isWeekly = ExplorationManager:GetIsInWeeklyChallenge()
  self._isTd = ExplorationManager:IsInTDExp()
  self._hasStore = ExplorationManager.epCtrl ~= nil and ExplorationManager.epCtrl.residentStoreCtrl:HasEpResidentStore()
  self:RefreshSellButton()
end

function UINDungeonChipLimit:RefreshSellButton(isGotoBattle)
  local tModel = false
  if self._isTd then
    tModel = self._hasStore
  end
  local cModel = false
  if self._isWeekly then
    if isGotoBattle == nil then
      cModel = self._hasStore and not ExplorationManager.epCtrl.sceneCtrl:InBattleScene()
    else
      cModel = not isGotoBattle
    end
  end
  self.__tModel = tModel
  self.__cModel = cModel
  local showSellBtn = self.__tModel or self.__cModel
  self:SetSellBtnActive(showSellBtn)
end

function UINDungeonChipLimit:RefreshLimit()
  local num = self.chipLimitInfo.count
  local limit = self.chipLimitInfo.limit
  self.ui.tex_LimitChip:SetIndex(0, tostring(num), tostring(limit))
  local isFirst = self.chipLimitInfo.firstLimit
  local isLimit = num > limit
  self.ui.obj_limitBackground:SetActive(isLimit)
  self.ui.obj_Limit:SetActive(isLimit)
  if num > limit then
    if isFirst and self.chipLimitSequence ~= nil then
      self.chipLimitSequence:PlayForward()
    end
    self.chipLimitInfo.firstLimit = false
    return
  end
  self.chipLimitInfo.firstLimit = true
end

function UINDungeonChipLimit:_InitChipLimitSequence()
  local obj_Limit_SizeDelta = self.ui.obj_Limit.transform.sizeDelta
  local obj_chipCountLimit_SizeDelta = self.ui.tran_Anima.sizeDelta
  local small_Limit_SizeDelta = Vector2.New(0, obj_Limit_SizeDelta.y)
  local small_chipCountLimit_SizeDelta = Vector2.New(obj_chipCountLimit_SizeDelta.x - obj_Limit_SizeDelta.x, obj_chipCountLimit_SizeDelta.y)
  self.ui.obj_Limit.transform.sizeDelta = small_Limit_SizeDelta
  self.ui.tran_Anima.sizeDelta = small_chipCountLimit_SizeDelta
  if self.chipLimitSequence ~= nil then
    self.chipLimitSequence:Kill()
    self.chipLimitSequence = nil
  end
  self.chipLimitSequence = CS_DOTween.Sequence():Append(self.ui.obj_Limit.transform:DOSizeDelta(obj_Limit_SizeDelta, 0.5)):Join(self.ui.tran_Anima:DOSizeDelta(obj_chipCountLimit_SizeDelta, 0.5)):Append(self.ui.obj_Limit.transform:DOSizeDelta(small_Limit_SizeDelta, 0.5):SetDelay(2.5)):Join(self.ui.tran_Anima:DOSizeDelta(small_chipCountLimit_SizeDelta, 0.5)):AppendCallback(function()
    self.chipLimitSequence:Rewind()
  end):Pause():SetAutoKill(false)
end

function UINDungeonChipLimit:_OnEpSceneStateChanged(epSceneState)
  local inTimeLine = epSceneState == ExplorationEnum.eEpSceneState.InTimeline
  local inBattleScene = epSceneState == ExplorationEnum.eEpSceneState.InBattleScene
  self:RefreshSellButton(inTimeLine or inBattleScene)
end

function UINDungeonChipLimit:_OnSellChipClick()
  local windows = UIManager:GetWindow(UIWindowTypeID.EpChallengeDiscard)
  if windows ~= nil then
    windows:CloseEpDiscard()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpChallengeDiscard, function(win)
    if win == nil then
      error("can't open EpChipDiscard UI")
      return
    end
    win:InitEpChipDiscard(ExplorationManager:GetDynPlayer(), nil, true)
  end)
end

function UINDungeonChipLimit:SetSellBtnActive(active)
  active = active or false
  local canSet = self.__tModel or self.__cModel
  if not canSet then
    self.ui.btn_SellChip.gameObject:SetActive(false)
    return
  end
  if self.ui.btn_SellChip.gameObject.activeSelf == active then
    return
  end
  self.ui.btn_SellChip.gameObject:SetActive(active)
end

function UINDungeonChipLimit:OnDelete()
  if self.chipLimitSequence ~= nil then
    self.chipLimitSequence:Kill()
    self.chipLimitSequence = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.OnEpSceneStateChanged, self.__onEpSceneStateChanged)
  base.OnDelete(self)
end

return UINDungeonChipLimit
