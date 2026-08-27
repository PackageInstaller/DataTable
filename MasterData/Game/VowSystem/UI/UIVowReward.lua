local UIVowReward = class("UIVowReward", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType
local UINCommonRewardTimeTips = require("Game.CommonUI.UINCommonRewardTimeTips")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local defaultScale = Vector3.New(0.8, 0.8, 0.8)

function UIVowReward:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):PushTopStatusDataToBackStack()
  self.resloader = cs_ResLoader.Create()
  self.rewardData = nil
  self.__isShowingReward = false
  self.commonRewardQueue = {}
  self.exitFuncList = {}
  self._rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount, false)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  self.__OnRewardItemClick = BindCallback(self, self.OnRewardItemClick)
  self.__UpdateRewardShowFunc = BindCallback(self, self.__UpdateRewardShow)
  self.__SetCanClickClose = BindCallback(self, self.SetIsCanClickClose, true)
  self:SetIsCanClickClose(true)
  self.__onOPenShowReward = false
end

function UIVowReward:SetIsCanClickClose(isCan)
  self.__isCanClickClose = isCan
end

function UIVowReward:OnRewardItemClick(itemCfg, index)
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:SetNotNeedAnyJump(true)
      win:InitListDetail(self.rewardData.rewardDataList, index)
    end
  end)
end

function UIVowReward:AddAndTryShowReward(commonRewardData)
  self.rewardData = commonRewardData
  if commonRewardData.exitAction ~= nil then
    table.insert(self.exitFuncList, commonRewardData.exitAction)
  end
  self:__ShowNextReward()
end

function UIVowReward:__ShowNextReward()
  ControllerManager:GetController(ControllerTypeId.Skin, true):CheckItemListsForSkins(self.rewardData.rewardIds, self.__UpdateRewardShowFunc, self.rewardData)
end

function UIVowReward:__ShowNextRewardOrDelete()
  if #self.commonRewardQueue > 0 then
    self:__ShowNextReward()
  else
    self:Delete()
    for index, func in ipairs(self.exitFuncList) do
      func()
    end
  end
end

function UIVowReward:__UpdateRewardShow()
  self:Show()
  if not string.IsNullOrEmpty(self.rewardData.title) then
    self.ui.txt_RewardTitle.text = self.rewardData.title
  end
  local fromFavourLevel, toFavourLevel = self.rewardData:GetVowFavourLevelChange()
  self.ui.tex_BeforLvl.text = tostring(fromFavourLevel)
  self.ui.tex_AfterLvl.text = tostring(toFavourLevel)
  AudioManager:PlayAudioById(1029)
  self:__RefreshList()
end

function UIVowReward:__RefreshList()
  self:__ShowGetRewardFx()
end

function UIVowReward:__ShowGetRewardFx()
  self.ui.dotween_rewardContent:DORestart()
  if not IsNull(self.tweenSeq) then
    self.tweenSeq:Kill(true)
    self.tweenSeq = nil
  end
  self.__onOPenShowReward = true
  if not self.__isAdded then
    self.__isAdded = true
    self.ui.dotween_rewardContent.onComplete:AddListener(function()
      self.__onOPenShowReward = false
      self:__PlayTooMuchRewardAnima()
    end)
  end
end

function UIVowReward:__PlayTooMuchRewardAnima()
  local function ShowOnePage()
    if not IsNull(self.tweenSeq) then
      self.tweenSeq:Kill(true)
      
      self.tweenSeq = nil
    end
    self.tweenSeq = cs_DoTween.Sequence()
    self.tweenSeq:AppendInterval(0.05)
    self._rewardItemPool:HideAll()
    for index, rewardIds in ipairs(self.rewardData.rewardIds) do
      local rewardItem = self._rewardItemPool:GetOne()
      rewardItem:BindBaseItemResloader(self.resloader)
      local itemId = self.rewardData.rewardIds[index]
      local itemNum = self.rewardData.rewardNums[index]
      local itemCfg = ConfigData.item[itemId]
      if self.rewardData.crUpHeroFragDic ~= nil then
        rewardItem:SetIsConvertHeroFrag()
      end
      rewardItem.baseItem:SetIsShowNewTag(false)
      if self.rewardData.crItemNewDic ~= nil and self.rewardData.crItemNewDic[itemId] ~= nil then
        rewardItem.baseItem:SetIsShowNewTag(true)
      end
      rewardItem:InitItemWithCount(itemCfg, itemNum, self.__OnRewardItemClick)
      rewardItem:SetNotNeedAnyJump(true)
      rewardItem:BindClickCustomArg(index)
      rewardItem.transform.localScale = defaultScale
      self.tweenSeq:Append(rewardItem.transform:DOScale(Vector3.zero, 0.2):From():SetEase(cs_Ease.OutBack):SetLink(rewardItem.gameObject))
      self.tweenSeq:AppendCallback(function()
        if ConfigData.game_config.itemWithGreatFxDic[rewardItem.itemCfg.id] then
          rewardItem:LoadGetGreatRewardFx(self.resloader, 0)
        else
          rewardItem:LoadGetRewardFx(self.resloader, 0)
        end
      end)
    end
    self.tweenSeq:AppendCallback(function()
      if not IsNull(self.tweenSeq) then
        self.tweenSeq:Kill(true)
        self.tweenSeq = nil
      end
    end)
  end
  
  ShowOnePage()
end

function UIVowReward:OnClickClose()
  if self.tweenSeq ~= nil and self.tweenSeq:IsPlaying() then
    self.tweenSeq.timeScale = 1000
  elseif self.__isAdded and not self.__onOPenShowReward then
    if not self.__isCanClickClose then
      return
    end
    if #self.commonRewardQueue > 0 then
      self.__isShowingReward = false
    end
    self:__ShowNextRewardOrDelete()
  end
end

function UIVowReward:OnDelete()
  self._rewardItemPool:DeleteAll()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if not IsNull(self.ui.dotween_rewardContent) then
    self.ui.dotween_rewardContent:DOKill()
  end
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill(true)
    self.tweenSeq = nil
  end
  if self._challengeTimerId ~= nil then
    TimerManager:StopTimer(self._challengeTimerId)
  end
  if self.__cannotClickCloseTimerId ~= nil then
    TimerManager:StopTimer(self.__cannotClickCloseTimerId)
    self.__cannotClickCloseTimerId = nil
  end
  base.OnDelete(self)
end

return UIVowReward
