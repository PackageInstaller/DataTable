local UINActivityFlipCardFlipItem = class("UINActivityFlipCardFlipItem", UIBaseNode)
local base = UIBaseNode
local ActivityFlipCardConfig = require("Game.ActivityFlipCard.Data.ActivityFlipCardConfig")
local cs_Ease = CS.DG.Tweening.Ease

function UINActivityFlipCardFlipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.__OnClickFlipItem)
end

function UINActivityFlipCardFlipItem:InitFlipCardFlipItem(flipCardData, index, onClick, resloader)
  self._flipCardData = flipCardData
  self._index = index
  self._onclick = onClick
  self._resloader = resloader
  local rewardIds, rewardNums = flipCardData:GetFlipCardRewardGetByIndex(index)
  if table.IsEmptyTable(rewardIds) then
    self:FlipBackSelfCard(false)
  else
    self:FlipOpenSelfCard(false)
  end
end

function UINActivityFlipCardFlipItem:__OnClickFlipItem()
  if self._onclick ~= nil then
    self._onclick(self._index)
  end
end

function UINActivityFlipCardFlipItem:FlipBackSelfCard(isShowAnim)
  if isShowAnim then
    self.ui.canvas_item:DOFade(0, 0.4):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
    self.ui.obj_root.transform:DOLocalMoveY(-50, 0.4):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject):OnComplete(function()
      self.ui.canvas_item:DOFade(1, 0.4)
      self.ui.obj_root.transform:DOLocalMoveY(0, 0.4):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
      self:_ResetNotOpenedCard()
    end)
  else
    self:_ResetNotOpenedCard()
  end
end

function UINActivityFlipCardFlipItem:_ResetNotOpenedCard()
  self.ui.obj_NotOpened:SetActive(true)
  self.ui.obj_Normal:SetActive(false)
  self.ui.obj_Special:SetActive(false)
  self.ui.btn_Item.interactable = true
  local currentRound = self._flipCardData:GetCurrentFlipRound()
  local hasFinal = self._flipCardData:GetRoundHasFinalReward(currentRound)
  self.ui.img_NotOpened:SetIndex(currentRound <= 2 and 1 or 0)
end

function UINActivityFlipCardFlipItem:FlipOpenSelfCard(isShowAnim, isShowQuickAnim, alwaysShowMask)
  self:__ResetTweenState(alwaysShowMask)
  self.ui.obj_Normal:SetActive(false)
  self.ui.obj_Special:SetActive(false)
  self.ui.btn_Item.interactable = false
  local rewardIds, rewardNums = self._flipCardData:GetFlipCardRewardGetByIndex(self._index)
  local rewardId = rewardIds[1]
  local rewardNum = rewardNums[1]
  local itemCfg = ConfigData.item[rewardId]
  if itemCfg == nil then
    return
  end
  local iconName = itemCfg.icon
  local isFinal, isActivityFinal = self._flipCardData:GetIsIndexFinalReward(self._index)
  if isFinal then
    self.ui.obj_Special:SetActive(not isShowAnim)
    if isActivityFinal then
      self.ui.img_NormalIcon.gameObject:SetActive(false)
      self.ui.img_SpImg.gameObject:SetActive(true)
      self.ui.img_SpImg.enabled = false
      local path = PathConsts:GetActivityFlipCardPath(self._flipCardData:GetFlipCardMainCfg().final_skin_path)
      self._resloader:LoadABAssetAsync(path, function(texture)
        if texture ~= nil and not IsNull(self.gameObject) then
          self.ui.img_SpImg.texture = texture
          self.ui.img_SpImg.enabled = true
        end
      end)
    else
      self.ui.img_NormalIcon.gameObject:SetActive(true)
      self.ui.img_SpImg.gameObject:SetActive(false)
      self.ui.img_NormalIcon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
    end
    self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  else
    self.ui.obj_Normal:SetActive(not isShowAnim)
    self.ui.img_Icon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
    self.ui.tex_Count:SetIndex(0, tostring(rewardNum))
    self.ui.img_Color.color = ActivityFlipCardConfig.FlipItemQualityColor[itemCfg.quality]
  end
  if isShowAnim then
    local isShowMask = alwaysShowMask ~= nil and alwaysShowMask
    self.ui.obj_CastMask:SetActive(true)
    if isFinal or isActivityFinal then
      local canvas = self.gameObject:AddComponent(typeof(CS.UnityEngine.Canvas))
      canvas.overrideSorting = true
      canvas.sortingLayerName = "UINormal"
      canvas.sortingOrder = 5
      self.ui.FXP_EventFlipCards.transform:SetParent(self.transform, true)
      self.ui.FXP_EventFlipCards.transform.anchoredPosition = Vector2.New(0, 0)
      TimerManager:StopTimer(self._AnimTimer)
      self.ui.anim_card:Play("UI_EventFlipCards_GetBigReward")
      self._AnimTimer = TimerManager:StartTimer(self.ui.anim_card.clip.length, function()
        self.ui.obj_CastMask:SetActive(isShowMask)
        DestroyUnityObject(canvas, true)
      end, self, true)
      return
    end
    local animTime = 0.25
    if isShowQuickAnim then
      animTime = 0.1
    end
    self.ui.obj_NotOpened.transform:DOScaleX(0, animTime):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject):OnComplete(function()
      self.ui.obj_Normal:SetActive(true)
      self.ui.obj_Normal.transform:DOScaleX(0, animTime):From():SetEase(cs_Ease.OutQuart):SetLink(self.gameObject):OnComplete(function()
        self.ui.obj_CastMask:SetActive(isShowMask)
      end)
      self.ui.obj_NotOpened.transform.localScale = Vector3.New(1, 1, 1)
      self.ui.obj_NotOpened:SetActive(false)
    end)
  end
end

function UINActivityFlipCardFlipItem:__ResetTweenState(alwaysShowMask)
  local isShowMask = alwaysShowMask ~= nil and alwaysShowMask
  self.ui.obj_NotOpened.transform:DOComplete()
  self.ui.obj_Special.transform:DOComplete()
  self.ui.obj_Normal.transform:DOComplete()
  self.ui.obj_CastMask:SetActive(isShowMask)
end

function UINActivityFlipCardFlipItem:OnDelete()
  TimerManager:StopTimer(self._AnimTimer)
  base.OnDelete(self)
end

return UINActivityFlipCardFlipItem
