local UIActivityFlipCardMain = class("UIActivityFlipCardMain", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINActivityFlipCardFlipItem = require("Game.ActivityFlipCard.UI.UINActivityFlipCardFlipItem")
local cs_ResLoader = CS.ResLoader
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local JumpManager = require("Game.Jump.JumpManager")
local SkinEnum = require("Game.Skin.SkinEnum")
local UINActivityFlipCardDrawMultiWindow = require("Game.ActivityFlipCard.UI.UINActivityFlipCardDrawMultiWindow")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroL2dInterationController = require("Game.Hero.Live2D.HeroL2dInterationController")

function UIActivityFlipCardMain:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.resloader = cs_ResLoader.Create()
  local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWindow ~= nil then
    homeWindow:OpenOtherWin()
    self:SetFromWhichUI(eBaseWinFromWhere.home)
  end
  self.oriHeroHolderPos = self.ui.HeroHolder.transform.localPosition
  self.oriPicHolderPos = self.ui.PicHolder.transform.localPosition
  self._fromWhere = SkinEnum.fromWhere.bp
  self._bigRewardItem = UINBaseItemWithReceived.New()
  self._bigRewardItem:Init(self.ui.uINBaseItemWithReceived)
  self._multiDrawWindow = UINActivityFlipCardDrawMultiWindow.New()
  self._multiDrawWindow:Init(self.ui.QuickFlip)
  self._rewardShowPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.RewardShowItem)
  self.ui.RewardShowItem:SetActive(false)
  self._flipItemPool = UIItemPool.New(UINActivityFlipCardFlipItem, self.ui.obj_FlipItem, false)
  self.__OnClickFlipCardDrawMultiCallback = BindCallback(self, self.OnFlipCardDrawMulti)
  self.__OnFlipCardDrawMultiClose = BindCallback(self, self.OnFlipCardDrawMultiClose)
  self.__RefreshFlipTimeCountCallback = BindCallback(self, self.__RefreshFlipTimeCount)
  self.__OnClickFlipCardCallback = BindCallback(self, self.__OnClickFlipCard)
  self.__RefreshFlipCardMainCallback = BindCallback(self, self.RefreshFlipCardMain)
  self.__OnGetTask = BindCallback(self, self.OnGetTask)
  MsgCenter:AddListener(eMsgEventId.ActivityFlipCardChange, self.__RefreshFlipCardMainCallback)
  self.__OnItemUpdate = BindCallback(self, self.__OnFlipCardItemChange)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  UIUtil.AddButtonListener(self.ui.btn_Next, self, self.__OnClickNextRound)
  UIUtil.AddButtonListener(self.ui.btn_Gift, self, self.__OnClickRewardPreview)
  UIUtil.AddButtonListener(self.ui.btn_PaidItem, self, self.__OnclickPaidItem)
  UIUtil.AddButtonListener(self.ui.btn_FreeItem, self, self.__OnclickFreeItem)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self.__OnClickActIntro)
  UIUtil.AddButtonListener(self.ui.btn_GetMore, self, self.OnClickFilpCardGetMore)
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self.OnClickFilpCardTask)
  UIUtil.AddButtonListener(self.ui.btn_Avg, self, self.__OnClickFlipAvg)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.__OnClickFlipSkinPreview)
  UIUtil.AddButtonListener(self.ui.btn_QuickFlip, self, self.__OnClickBtnQuickFlip)
  self._flipCardItems = {}
  self._itemChangeListen = {}
end

function UIActivityFlipCardMain:InitFlipCardMain(actId)
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return
  end
  local flipCardData = flipCardCtrl:GetFlipCardDataByActId(actId)
  self._flipCardData = flipCardData
  flipCardData:SetFlipCardLooked()
  self:__RefreshFlipTimeCount()
  TimerManager:StopTimer(self._timerId)
  self._timerId = TimerManager:StartTimer(2, self.__RefreshFlipTimeCountCallback, self)
  local flipCfg = self._flipCardData:GetFlipCardMainCfg()
  local finalRewardIds = self._flipCardData:GetFlipRewardsByRewardGroupId(flipCfg.final_skin)
  self._skinid = finalRewardIds[1]
  local skinCfg = ConfigData.skin[self._skinid]
  local heroCfg = ConfigData.hero_data[skinCfg.heroId]
  self._heroId = skinCfg.heroId
  self.ui.tex_SkinName.text = LanguageUtil.GetLocaleText(skinCfg.name)
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroCfg.name)
  local activityCfg = ConfigData.activity[self._flipCardData:GetActFrameId()]
  local actName = ConfigData.activity_name[activityCfg.name_id].name
  self.ui.tex_EventName.text = LanguageUtil.GetLocaleText(actName)
  local freeItemId = self._flipCardData:GetFlipCardFreeCost()
  local freeItemCfg = ConfigData.item[freeItemId]
  self.ui.img_FreeItem.sprite = CRH:GetSprite(freeItemCfg.small_icon)
  self._itemChangeListen[freeItemId] = true
  local paidItemId = self._flipCardData:GetFlipCardPaidCost()
  local paidItemCfg = ConfigData.item[paidItemId]
  self.ui.img_PaidItem.sprite = CRH:GetSprite(paidItemCfg.small_icon)
  self._itemChangeListen[paidItemId] = true
  self._flipItemPool:HideAll()
  local currentRound = self._flipCardData:GetCurrentFlipRound()
  local maxItemCount = self._flipCardData:GetFlipPoolRewardCount(currentRound)
  for index = 1, maxItemCount do
    local flipItem = self._flipItemPool:GetOne()
    flipItem:InitFlipCardFlipItem(self._flipCardData, index, self.__OnClickFlipCardCallback, self.resloader)
    self._flipCardItems[index] = flipItem
  end
  self._rewardShowPool:HideAll()
  local rewardShowIdList = ConfigData.activity_flipcards_main.rewardsShowIdList[actId]
  if rewardShowIdList == nil then
    error("plz check ActivityFlipCardConfig!!")
    return
  end
  for _, rewardCfg in ipairs(rewardShowIdList) do
    local reward = ConfigData.activity_flipcards_award[rewardCfg.id].reward
    for id, count in pairs(reward) do
      local itemCfg = ConfigData.item[id]
      local rewardNum = count * rewardCfg.count
      local rewardItem = self._rewardShowPool:GetOne()
      rewardItem:InitItemWithCount(itemCfg, rewardNum)
    end
  end
  self:RefreshFlipCardMain()
  self:UpdateActivityFlipCardItem()
  self:RefreshTaskRedDot()
  self:LoadFlipCardRes()
end

function UIActivityFlipCardMain:LoadFlipCardRes()
  self.ui.HeroHolder.transform.localPosition = self.oriHeroHolderPos
  self.ui.PicHolder.transform.localPosition = self.oriPicHolderPos
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  if not IsNull(self.bigImgObj) then
    DestroyUnityObject(self.bigImgObj)
  end
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.l2dBinding = nil
  local mainCfg = self._flipCardData:GetFlipCardMainCfg()
  local live2dLevel = mainCfg.skin_type ~= nil and mainCfg.skin_type or 0
  local isHaveL2D = 0 < live2dLevel
  local skinId = mainCfg.skin_id ~= nil and mainCfg.skin_id or self._skinid
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resModelCfg = skinCtrl:GetResModel(mainCfg.hero_id, skinId)
  if isHaveL2D then
    local skinCfg = ConfigData.skin[skinId]
    self:__TryLoadLive2D(skinCfg, resModelCfg)
  else
    self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModelCfg.src_id_pic, self._fromWhere))
  end
end

function UIActivityFlipCardMain:__TryLoadLive2D(skinCfg, resModel)
  if skinCfg == nil then
    error("skinCfg is nil!!")
    return
  end
  local skinid = skinCfg.id
  local live2dCfg = ConfigData.skin_live2d[skinId]
  local isHaveSkin = skinCfg.isdefault_skin or PlayerDataCenter.skinData:IsHaveSkin(skinId)
  local isHideHolight = PlayerDataCenter.skinData:IsHideHolight(skinId)
  local l2dPath = PathConsts:GetCharacterLive2DPath(resModel.src_id_pic, self._fromWhere)
  self:__LoadLive2D(l2dPath, isHideHolight)
end

function UIActivityFlipCardMain:__LoadLive2D(path, isHideHolight)
  self.Live2DResloader = cs_ResLoader.Create()
  self.Live2DResloader:LoadABAssetAsync(path, function(l2dModelAsset)
    if IsNull(self.transform) or IsNull(l2dModelAsset) then
      return
    end
    self.l2dModelIns = l2dModelAsset:Instantiate(self.ui.HeroHolder.transform)
    self.l2dModelIns.transform:SetLayer(LayerMask.UI)
    self.l2dBinding = {}
    UIUtil.LuaUIBindingTable(self.l2dModelIns, self.l2dBinding)
    local cs_CubismInterationController = self.l2dModelIns.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      local mainCfg = self._flipCardData:GetFlipCardMainCfg()
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = mainCfg.hero_id
      local skinId = mainCfg.skin_id ~= nil and mainCfg.skin_id or self._skinid
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:SetInterationOpenWait(false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.HeroFade, 1, true)
      self.heroCubismInteration:SetL2DPosType("HeroSkin", false)
    end
    self.l2dBinding.renderController.uiCanvasGroup = self.ui.HeroFade
    self.l2dBinding.renderController.SortingLayer = "UINormal"
    self.l2dBinding.renderController.SortingOrder = 100
    self.l2dBinding.renderController.InfluencedByUICanvas = true
    HeroL2dInterationController.ActiveLive2dHolight(self.l2dBinding.renderController, not isHideHolight)
    local mainCfg = self._flipCardData:GetFlipCardMainCfg()
    local posData = self._flipCardData:GetFlipCardSkinBgPosData(mainCfg.skin_type)
    if posData ~= nil then
      self.l2dModelIns.transform.localPosition = Vector3.New(posData.x, posData.y, 0)
    end
    local scaleData = self._flipCardData:GetFlipCardSkinBgScaleData()
    if scaleData ~= nil then
      self.l2dModelIns.transform.localScale = Vector3.New(scaleData.x, scaleData.y, scaleData.z)
    end
  end)
end

function UIActivityFlipCardMain:__LoadPic(path, isShowSkinOutline)
  self.bigImgResloader = cs_ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or IsNull(self.transform) then
      return
    end
    self.bigImgObj = prefab:Instantiate(self.ui.PicHolder.transform)
    local commonPicCtrl = self.bigImgObj:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
    local mainCfg = self._flipCardData:GetFlipCardMainCfg()
    local posData = self._flipCardData:GetFlipCardSkinBgPosData(mainCfg.skin_type)
    if posData ~= nil then
      self.l2dModelIns.transform.localPosition = Vector3.New(posData.x, posData.y, 0)
    end
    local rawImage = self.bigImgObj:FindComponent(eUnityComponentID.RawImage)
    if rawImage ~= nil then
      if isShowSkinOutline then
        rawImage.color = PlayerDataCenter.skinData.outlineColor
      else
        rawImage.color = Color.white
      end
    end
  end)
end

function UIActivityFlipCardMain:RefreshTaskRedDot()
  local isShowRed = self._flipCardData:IsCanGetTask()
  self.ui.obj_taskRedDot:SetActive(isShowRed)
end

function UIActivityFlipCardMain:RefreshFlipCardMain()
  local currentRound = self._flipCardData:GetCurrentFlipRound()
  local isPickedRoundFinal = self._flipCardData:GetIsPickedRoundFinal()
  local isPickedActivityFinal = self._flipCardData:GetIsPickedActivityFinal()
  local isPickedAll = self._flipCardData:GetIsPickedRoundAll()
  local hasFinal, hasActivityFinal = self._flipCardData:GetRoundHasFinalReward(currentRound)
  self.ui.btn_Avg.gameObject:SetActive(isPickedActivityFinal)
  local rewardIds, rewardNums = self._flipCardData:GetFlipFinalRewardByRound(currentRound)
  for index, rewardId in ipairs(rewardIds) do
    local rewardNum = rewardNums[index]
    local itemCfg = ConfigData.item[rewardId]
    self._bigRewardItem:InitItemWithCount(itemCfg, rewardNum, nil, isPickedRoundFinal)
    break
  end
  if hasFinal then
    if not hasActivityFinal then
      self.ui.tex_Title:SetIndex(0, tostring(currentRound))
    else
      self.ui.tex_Title:SetIndex(1, tostring(currentRound))
    end
  else
    self.ui.tex_Title:SetIndex(2)
  end
  if hasFinal then
    self.ui.obj_ItemNode:SetActive(true)
    local canGoNext = isPickedAll or isPickedRoundFinal
    self.ui.obj_CantGoNext:SetActive(not canGoNext)
    self.ui.obj_Next:SetActive(canGoNext)
  else
    self.ui.obj_ItemNode:SetActive(false)
  end
  for k, item in ipairs(self._rewardShowPool.listItem) do
    item:SetPickedUIActive(currentRound > k)
    if k == currentRound then
      item:SetPickedUIActive(isPickedRoundFinal)
    end
  end
end

function UIActivityFlipCardMain:UpdateActivityFlipCardItem()
  local freeItemRemain = self._flipCardData:GetFlipCardFreeItemRemain()
  local paidItemRemain = self._flipCardData:GetFlipCardPaidItemRemain()
  self.ui.tex_freeCount.text = tostring(freeItemRemain)
  self.ui.tex_PaidCount.text = tostring(paidItemRemain)
  self.ui.obj_TimeRemain:SetActive(0 < freeItemRemain)
end

function UIActivityFlipCardMain:__RefreshFlipTimeCount()
  local title, timeStr = ActivityFrameUtil.GetShowEndTimeStr(self._flipCardData)
  local countdownStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._flipCardData:GetActivityEndTime())
  self.ui.tex_TimeState.text = title
  self.ui.tex_EndTime.text = timeStr
  self.ui.tex_LastTime.text = countdownStr
  self.ui.tex_TimeRemain.text = countdownStr
  if diff < 0 then
    TimerManager:StopTimer(self._timerId)
  end
end

function UIActivityFlipCardMain:OnGetTask()
  self:RefreshTaskRedDot()
  self._flipCardData:__RefreshFlipCardRedHasTask()
end

function UIActivityFlipCardMain:__OnClickFlipCard(index)
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return
  end
  flipCardCtrl:ReqFlipCardDraw(self._flipCardData:GetActId(), index)
end

function UIActivityFlipCardMain:__OnClickNextRound()
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return
  end
  flipCardCtrl:ReqFlipCardNewRound(self._flipCardData:GetActId())
end

function UIActivityFlipCardMain:OnClickFilpCardGetMore()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityFlipCardGetMore, function(window)
    if window ~= nil then
      window:InitFlipCardGetMore(self._flipCardData:GetActId(), self._flipCardData:GetActFrameId())
    end
  end)
end

function UIActivityFlipCardMain:OnClickFilpCardTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityFlipCardTask, function(window)
    if window == nil then
      return
    end
    local taskIds = ConfigData.activity_general[self._flipCardData:GetActFrameId()].once_quest
    window:InitFlipCardTask(taskIds, nil, self.__OnGetTask)
    window:SetChristmasEnvTaskTitle(ConfigData:GetTipContent(9711))
  end)
end

function UIActivityFlipCardMain:__OnClickRewardPreview()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityFlipCardPreview, function(window)
    window:InitFlipRewardPreview(self._flipCardData, self._flipCardData:GetCurrentFlipRound())
  end)
end

function UIActivityFlipCardMain:__OnclickPaidItem()
  local paidItemId = self._flipCardData:GetFlipCardPaidCost()
  local paidItemCfg = ConfigData.item[paidItemId]
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    window:InitCommonItemDetail(paidItemCfg)
  end)
end

function UIActivityFlipCardMain:__OnclickFreeItem()
  local freeItemId = self._flipCardData:GetFlipCardFreeCost()
  local freeItemCfg = ConfigData.item[freeItemId]
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    window:InitCommonItemDetail(freeItemCfg)
  end)
end

function UIActivityFlipCardMain:__OnClickActIntro()
  local flipCfg = self._flipCardData:GetFlipCardMainCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(flipCfg.rule_des), ConfigData:GetTipContent(flipCfg.rule_title))
  end)
end

function UIActivityFlipCardMain:__OnClickFlipAvg()
  ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, self._flipCardData:GetFlipFinalRewardAvg())
end

function UIActivityFlipCardMain:__OnClickFlipSkinPreview()
  JumpManager:Jump(JumpManager.eJumpTarget.HeroSkin, nil, nil, {
    self._skinid,
    require("Game.Skin.SkinEnum").fromWhere.bp
  }, true)
end

function UIActivityFlipCardMain:__OnClickBtnQuickFlip()
  if self._multiDrawWindow == nil then
    return
  end
  if self.ui.QuickFlip.activeSelf then
    return
  end
  self._multiDrawWindow:InitFlipCardDrawMultiWindow(self._flipCardData, self.__OnClickFlipCardDrawMultiCallback, self.__OnFlipCardDrawMultiClose)
  self.ui.QuickFlip:SetActive(true)
  self.ui.MainRaycaster.enabled = false
end

function UIActivityFlipCardMain:OnFlipCardDrawMulti(count)
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return
  end
  flipCardCtrl:ReqFlipCardDrawMulti(self._flipCardData:GetActId(), count)
end

function UIActivityFlipCardMain:OnFlipCardDrawMultiClose()
  self.ui.MainRaycaster.enabled = true
end

function UIActivityFlipCardMain:FlipOpenCard(index, isQuick, alwaysShowMask)
  if self._flipCardItems[index] == nil then
    return
  end
  self._flipCardItems[index]:FlipOpenSelfCard(true, isQuick, alwaysShowMask)
end

function UIActivityFlipCardMain:FlipBackAllCard(animTime)
  self.ui.obj_CastMask:SetActive(true)
  self._getAllTimer = TimerManager:StartTimer(animTime, function()
    for _, flipItem in ipairs(self._flipCardItems) do
      flipItem:FlipBackSelfCard(true)
    end
    self.ui.obj_CastMask:SetActive(false)
  end, self, true)
end

function UIActivityFlipCardMain:OnGetFinalReward()
  self:__OnClickNextRound()
end

function UIActivityFlipCardMain:__OnFlipCardItemChange(itemDic)
  for itemId, _ in pairs(self._itemChangeListen) do
    if itemDic[itemId] ~= nil and self._flipCardData:GetIsCanRefreshItem() then
      self:UpdateActivityFlipCardItem()
    end
  end
end

function UIActivityFlipCardMain:GenCoverJumpReturnCallback()
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  self.bigImgGameObject = nil
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
  end
  self.l2dModelIns = nil
  self.l2dBinding = nil
  local dataTable = {}
  for key, value in pairs(self) do
    dataTable[key] = value
  end
  return function()
    for key, value in pairs(dataTable) do
      self[key] = value
    end
    self:RefreshFlipCardMain()
    self:LoadFlipCardRes()
  end
end

function UIActivityFlipCardMain:OnHide()
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return
  end
  flipCardCtrl:Try2ShowFlipCardDrawMulti(self._flipCardData:GetActId(), nil, true)
  if not IsNull(self.bigImgObj) then
    DestroyUnityObject(self.bigImgObj)
  end
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  base.OnHide(self)
end

function UIActivityFlipCardMain:__BackAction()
  self:OnCloseWin()
  self:Delete()
end

function UIActivityFlipCardMain:OnDeleteEntity()
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  base.OnDeleteEntity(self)
end

function UIActivityFlipCardMain:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.ActivityFlipCardPreview)
  UIManager:DeleteWindow(UIWindowTypeID.ActivityFlipCardGetMore)
  UIManager:DeleteWindow(UIWindowTypeID.ActivityFlipCardTask)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.ActivityFlipCardChange, self.__RefreshFlipCardMainCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  TimerManager:StopTimer(self._timerId)
  TimerManager:StopTimer(self._getAllTimer)
  TimerManager:StopTimer(self.rewardTimer)
  self._flipItemPool:DeleteAll()
  self._rewardShowPool:DeleteAll()
  if not IsNull(self.bigImgObj) then
    DestroyUnityObject(self.bigImgObj)
  end
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  base.OnDelete(self)
end

return UIActivityFlipCardMain
