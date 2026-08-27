local UILottery = class("UILottery", UIBaseWindow)
local base = UIBaseWindow
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local UINLtrPoolItem = require("Game.Lottery.UI.UINLtrPoolItem")
local UINLtrHeroItem = require("Game.Lottery.UI.UINLtrHeroItem")
local UINLtrOwnedHeroItem = require("Game.Lottery.UI.UINLtrOwnedHeroItem")
local UILotteryPoolDetail = require("Game.Lottery.UI.PoolDetail.UILotteryPoolDetail")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local HeroInfoData = require("Game.Lottery.Data.HeroInfoData")
local LotteryRtUtil = require("Game.Lottery.UI.LotteryRtUtil")
local JumpManager = require("Game.Jump.JumpManager")
local UINLtrSpecialSelectHero = require("Game.Lottery.UI.SpecialSelectHero.UINLtrSpecialSelectHero")
local UINSkinActDrawLottery = require("Game.Lottery.UI.SkinAct.UINSkinActDrawLottery")
local cs_ResLoader = CS.ResLoader
local cs_MovieManager_ins = CS.MovieManager.Instance
local cs_EventTriggerListener = CS.EventTriggerListener
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local CS_ClientConsts = CS.ClientConsts

function UILottery:OnInit()
  self.__onSelectLtrPoolItem = BindCallback(self, self.SelectLtrPoolItem)
  self.__UpdPoolReddotFunc = BindCallback(self, self._UpdPoolReddot)
  self.__UpdBtnTenRedDot = BindCallback(self, self._UpdBtnTenRedDot)
  self.__ownedHeroPool = UIItemPool.New(UINLtrOwnedHeroItem, self.ui.ownedItem, false)
  self:_ShowBtnTenRedDot(false)
  UIUtil.AddButtonListener(self.ui.btn_Once, self, self.__OnClickDrawOne)
  UIUtil.AddButtonListener(self.ui.btn_Ten, self, self.__OnClickDrawTen)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self.__OnClickFreeSelect)
  UIUtil.AddButtonListener(self.ui.btn_SpecialOne, self, self.__OnClickDrawSpecialOne)
  UIUtil.AddButtonListener(self.ui.btn_PtExchange, self, self.__OnClickPtExchange)
  UIUtil.AddButtonListener(self.ui.btn_PoolDetail, self, self.__OnClickPoolDetail)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.__OnClickBg)
  UIUtil.AddButtonListener(self.ui.btn_LeftArrow, self, self.__OnClickLeftArrow)
  UIUtil.AddButtonListener(self.ui.btn_RightArrow, self, self.__OnClickRightArrow)
  UIUtil.AddButtonListener(self.ui.btn_UpAddIntro, self, self.__OnClickUpIntro)
  UIUtil.AddButtonListener(self.ui.btn_UpNormalIntro, self, self.__OnClickUpIntro)
  UIUtil.AddButtonListener(self.ui.btn_ChangeMode, self, self.__OnClickSwitchGroup)
  UIUtil.AddButtonListener(self.ui.btn_AVGCharDun, self, self.OnClickCharDun)
  UIUtil.AddButtonListener(self.ui.btn_QuickGift, self, self._OnClickQuickGift)
  UIUtil.AddButtonListener(self.ui.btn_HeroInfo, self, self.__OnClickHeroInfo)
  UIUtil.AddButtonListener(self.ui.btn_ShowCharacter, self, self.__OnClickShowCharacter)
  UIUtil.SetTopStatus(self, self.__OnClickClose, {}, nil, nil)
  self.resLoader = cs_ResLoader.Create()
  self.ui.specialSelectHero:SetActive(false)
  self.ui.infoItem:SetActive(false)
  self.ltrPoolItemPool = UIItemPool.New(UINLtrPoolItem, self.ui.infoItem)
  self.poolItemWidth = self.ui.infoItem.transform.sizeDelta.x + self.ui.scrollLayoutGroup.spacing
  self.heroL = UINLtrHeroItem.New()
  self.heroL:Init(self.ui.subHeroItem)
  self.heroR = UINLtrHeroItem.New()
  self.heroR:Init(self.ui.mainHeroItem)
  self.skinActDrawLotteryNode = UINSkinActDrawLottery.New()
  self.skinActDrawLotteryNode:Init(self.ui.btn_SkinAct)
  self.__OnPageChangeDragBegin = BindCallback(self, self.OnPageChangeDragBegin)
  self.__OnPageChangeDragEnd = BindCallback(self, self.OnPageChangeDragEnd)
  local pageChangeEventTrigger = cs_EventTriggerListener.Get(self.ui.dragPageChange)
  pageChangeEventTrigger:onBeginDrag("+", self.__OnPageChangeDragBegin)
  pageChangeEventTrigger:onEndDrag("+", self.__OnPageChangeDragEnd)
  self._onItemChangeFunc = BindCallback(self, self._OnItemChange)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._onItemChangeFunc)
end

function UILottery:InitUILottery(ltrCtrl, poolGroupDataList, poolIndex, inGroupLtrData)
  self.ltrCtrl = ltrCtrl
  self:_SetPoolDataList(poolGroupDataList)
  self.poolItemDic = {}
  local reddotNode = PlayerDataCenter.allLtrData:GetLtrRedDotNode()
  local avgIdDic = {}
  self.ltrPoolItemPool:HideAll()
  for k, poolGroupData in ipairs(self.poolGroupDataList) do
    local poolData = poolGroupData.ltrPoolData
    local poolItem = self.ltrPoolItemPool:GetOne()
    poolItem:InitLtrPoolItem(k, poolData, self.resLoader, self.__onSelectLtrPoolItem)
    self.poolItemDic[poolData.poolId] = poolItem
    local poolNode = reddotNode:GetChild(poolData.poolId)
    if poolNode ~= nil then
      poolItem:ShowLtrPoolItemReddot(poolNode:GetRedDotCount() > 0)
    end
    local avgId = poolData:TryGetLtrIntoAvgNotPlayed()
    if avgId ~= nil and avgIdDic[avgId] == nil and not GuideManager.inGuide then
      avgIdDic[avgId] = true
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId)
    end
  end
  self.ui.img_Select:SetAsLastSibling()
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.scrollLayoutGroup.transform)
  self:SelectLtrUIPool(poolIndex, inGroupLtrData, true, true)
  RedDotController:AddListener(RedDotDynPath.LotteryPrPoolPath, self.__UpdPoolReddotFunc)
end

function UILottery:_SetPoolDataList(poolGroupDataList)
  if CS_ClientConsts.IsAudit then
    self.poolGroupDataList = {}
    for k, v in pairs(poolGroupDataList) do
      if v.ltrPoolData.poolId == 2 then
        table.insert(self.poolGroupDataList, v)
      end
    end
  else
    self.poolGroupDataList = poolGroupDataList
  end
end

function UILottery:RefreshLtrPoolUI(poolGroupDataList)
  local poolIndex = self.poolIndex
  if poolIndex > #poolGroupDataList then
    poolIndex = 1
  end
  self:_SetPoolDataList(poolGroupDataList)
  local curIdDic = {}
  for k, poolGroupData in ipairs(poolGroupDataList) do
    local poolId = poolGroupData.ltrPoolData.poolId
    curIdDic[poolId] = true
    local poolItem = self.poolItemDic[poolId]
    if poolItem == nil then
      poolItem = self.ltrPoolItemPool:GetOne()
      poolItem:InitLtrPoolItem(k, poolGroupData.ltrPoolData, self.resLoader, self.__onSelectLtrPoolItem)
      self.poolItemDic[poolId] = poolItem
    end
    poolItem.transform:SetAsLastSibling()
    poolItem:SetLtrPoolItemIndex(k)
  end
  local toBeRemoveIdDic = {}
  for poolId, poolItem in pairs(self.poolItemDic) do
    if curIdDic[poolId] == nil then
      toBeRemoveIdDic[poolId] = true
      self.ltrPoolItemPool:HideOne(poolItem)
    end
  end
  for poolId, v in pairs(toBeRemoveIdDic) do
    self.poolItemDic[poolId] = nil
  end
  self.ui.img_Select:SetAsLastSibling()
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.scrollLayoutGroup.transform)
  self:SelectLtrUIPool(poolIndex)
end

function UILottery:__refreshModel()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  local modelPath = PathConsts:GetCharacterModelPathEx(self.UpHeroData.heroData:GetResModelName())
  if self.modelPath == modelPath then
    return
  end
  if not IsNull(self.heroGo) then
    self.heroGo:SetActive(false)
  end
  self.resLoader = cs_ResLoader.Create()
  self.resLoader:LoadABAssetAsync(modelPath, function(prefab)
    DestroyUnityObject(self.heroGo)
    self.modelPath = modelPath
    self.heroGo = prefab:Instantiate(self.ui.modelHoder.transform)
    self.heroGo.transform.localEulerAngles = Vector3.New(0, 180, 0)
    self.heroGo.transform.localPosition = Vector3.New(0, -0.5, 0)
  end)
end

function UILottery:SelectLotteryPoolById(poolId)
  local poolIndex, inGroupLtrData = self.ltrCtrl:GenSelectLtrPool(poolId)
  self:SelectLtrUIPool(poolIndex, inGroupLtrData, false)
end

function UILottery:SelectLtrUIPool(poolIndex, inGroupLtrData, withAudio, isInit)
  local poolId = self.poolGroupDataList[poolIndex].ltrPoolData.poolId
  local poolItem = self.poolItemDic[poolId]
  self:SelectLtrPoolItem(poolItem, inGroupLtrData, withAudio, isInit)
end

function UILottery:SelectLtrPoolItem(poolItem, inGroupLtrData, withAudio, isInit)
  if withAudio == nil then
    withAudio = true
  end
  if withAudio then
    AudioManager:PlayAudioById(1041)
  end
  self:_ClearSelectMoveTween()
  self._selectMoveTween = self.ui.img_Select:DOLocalMoveX(poolItem.transform.anchoredPosition.x, 0.2)
  if self.poolItem ~= poolItem then
    self.ui.ani_Pic:DORestart()
    self.poolItem = poolItem
  end
  self.poolIndex = poolItem.index
  local poolGrouData = self.poolGroupDataList[self.poolIndex]
  local ltrPoolData
  local lastPoolData = poolGrouData:TryGetLastLtrPoolData()
  if lastPoolData == nil then
  else
    ltrPoolData = inGroupLtrData or lastPoolData
  end
  local showSelectPool = false
  if not ltrPoolData then
    if poolGrouData:HasLtrMoreGroup() then
      showSelectPool = true
      ltrPoolData = poolGrouData:GetLtrInGroupDataList()[1]
    else
      ltrPoolData = poolItem.ltrPoolData
    end
  end
  self:SelectLtrPoolByData(ltrPoolData)
  self:_LocateItemTween()
  if isInit then
    self.ltrCtrl:ChangeLotteryState(LotteryEnum.eLotteryState.Normal)
  end
  if showSelectPool and not GuideManager.inGuide then
    self.ltrCtrl:ChangeLotteryState(LotteryEnum.eLotteryState.SelectPool)
    UIManager:ShowWindowAsync(UIWindowTypeID.LotterySelectPool, function(win)
      if win == nil then
        return
      end
      win:InitLtrSelectPool(poolGrouData, 0, function(ltrData)
        self:SelectLtrPoolByData(ltrData)
        self.ltrCtrl:SelectGroupPoolSuccess(ltrData.poolId)
        self.ltrCtrl:ChangeLotteryState(LotteryEnum.eLotteryState.Normal)
      end)
    end)
  end
end

function UILottery:SelectLtrPoolByData(ltrPoolData)
  local changedPool = self.curPoolData ~= ltrPoolData
  self.curPoolData = ltrPoolData
  self.curPoolCfg = ltrPoolData:GetLtrPoolDataCfg()
  local poolId = self.curPoolCfg.lottery_id
  self.ltrCtrl:SelectLtrPool(poolId)
  self:__RefreshGuaranteeState()
  self:RefreshCurLtrUI(changedPool)
  self:RefreshCharDunBtn()
end

function UILottery:RefreshCurLtrUI(changedPool)
  local curPoolData = self.curPoolData
  local curPoolCfg = self.curPoolCfg
  self.ui.btn_LeftArrow.interactable = self.poolIndex ~= 1
  self.ui.btn_RightArrow.interactable = self.poolIndex ~= #self.poolGroupDataList
  self:__RefreshTopRes()
  local hasOnece = curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.Once)
  local hasTen = curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.Ten)
  local hasSpecialOnce = curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.SpecialOnce)
  local hasFreeChoice = curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.FreeChoice)
  local IsGuaranteeOpen = curPoolData:IsGuaranteeOpen()
  local IsHeroInfoBtnOpenParam = curPoolData:IsHeroInfoBtnOpen()
  if hasFreeChoice then
    self.ui.model_camera.gameObject:SetActive(false)
    self.ui.rect_uiModel.gameObject:SetActive(false)
    local window = UIManager:GetWindow(UIWindowTypeID.LotterySelectHero)
    if window ~= nil then
      if not self.curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.FreeChoice) then
        window:Hide()
        return
      end
      window:Show()
      window:InitLotterySelectHero(self.curPoolData)
      window.transform.localScale = Vector3.one
      self.ui.dragPageChange:SetActive(false)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.LotterySelectHero, function(window)
        if window == nil then
          return
        end
        window.transform:SetParent(self.ui.selectHeroHolder)
        window:InitPageChangeDrag(self.__OnPageChangeDragBegin, self.__OnPageChangeDragEnd)
        if not self.curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.FreeChoice) then
          window:Hide()
          return
        end
        window:InitLotterySelectHero(self.curPoolData)
        window.transform.localScale = Vector3.one
        self.ui.dragPageChange:SetActive(false)
      end)
    end
  else
    local selectHeroWindow = UIManager:GetWindow(UIWindowTypeID.LotterySelectHero)
    if selectHeroWindow ~= nil and selectHeroWindow.active then
      selectHeroWindow:Hide()
      selectHeroWindow:ClearLotterySelect()
    end
    self.ui.dragPageChange:SetActive(true)
  end
  self.ui.sprcialSlogan.gameObject:SetActive(IsGuaranteeOpen)
  self.ui.adapter:SetActive(not hasFreeChoice)
  self.ui.btn_PoolDetail.gameObject:SetActive(not hasFreeChoice)
  self:__RefreshFreeChoiceTips()
  local isUpLottery = IsHeroInfoBtnOpenParam[1]
  self.ui.btn_HeroInfo.gameObject:SetActive(isUpLottery)
  self.ui.btn_ShowCharacter.gameObject:SetActive(isUpLottery)
  self.UpHeroId = IsHeroInfoBtnOpenParam[2]
  if isUpLottery and self.UpHeroId then
    local lottery_preview = ConfigData.lottery_preview[self.UpHeroId]
    if lottery_preview ~= nil then
      local fullPath = PathConsts:GetImagePath(lottery_preview.previewPic)
      local image = self.resLoader:LoadABAsset(fullPath)
      if image ~= nil then
        self.ui.img_PreviewCharacter.texture = image
      end
    end
  end
  self.ui.btn_Once.gameObject:SetActive(hasOnece)
  self.ui.btn_Ten.gameObject:SetActive(hasTen)
  self.ui.btn_Select.gameObject:SetActive(hasFreeChoice)
  self.ui.btn_SpecialOne.gameObject:SetActive(hasSpecialOnce)
  if hasOnece then
    self.ui.tex_PayOnce.text = tostring(self.curPoolCfg.costNum1)
    self.ui.img_PayIcon_Once.sprite = CRH:GetSprite(ConfigData.item[self.curPoolCfg.costId1].small_icon)
  end
  if hasSpecialOnce then
    local itemCfg = ConfigData.item[self.curPoolCfg.costId3]
    self.ui.tex_PaySepecialOne.text = tostring(self.curPoolCfg.costNum3)
    self.ui.img_PayIcon_SpecialOnce.sprite = CRH:GetSprite(itemCfg.small_icon)
    self.ui.tex_SpecialOnceItemName:SetIndex(0, LanguageUtil.GetLocaleText(itemCfg.name))
  end
  if hasFreeChoice then
    self.ui.tex_Pay_Select.text = tostring(self.curPoolCfg.costNum4)
    self.ui.img_PayIcon_Select.sprite = CRH:GetSprite(ConfigData.item[self.curPoolCfg.costId4].small_icon)
  end
  self:RefreshCurLtrChangedUI()
  if self.curPoolCfg.intro_des == nil then
    self.ui.tex_Desc.text = nil
  else
    self.ui.tex_Desc.text = LanguageUtil.GetLocaleText(self.curPoolCfg.intro_des)
  end
  local lastTempResLoader
  if changedPool and self.tempResLoader ~= nil then
    lastTempResLoader = self.tempResLoader
    self.tempResLoader = nil
  end
  if self.tempResLoader == nil then
    self.tempResLoader = cs_ResLoader.Create()
  end
  self.ui.img_Pic.enabled = false
  if self.curPoolCfg.bg_type == 1 then
    if self.moviePlayer ~= nil then
      self.moviePlayer:StopVideo()
      cs_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
      self.moviePlayer = nil
    end
    local path = PathConsts:GetLotteryPicPath("MainPicture/" .. self.curPoolCfg.bg_path)
    self.tempResLoader:LoadABAssetAsync(path, function(texture)
      if texture == nil then
        return
      end
      self.ui.img_Pic.texture = texture
      self.ui.img_Pic.enabled = true
    end)
  elseif self.curPoolCfg.bg_type == 2 then
    local lastPlayer
    if self.moviePlayer ~= nil then
      self.moviePlayer:StopVideo()
      lastPlayer = self.moviePlayer
    end
    self.moviePlayer = cs_MovieManager_ins:GetMoviePlayer()
    self.moviePlayer:SetVideoRender(self.ui.img_Video)
    local path = "Lottery/" .. self.curPoolCfg.bg_path
    self.moviePlayer:PlayVideo(path, nil, 1, true)
    if lastPlayer then
      cs_MovieManager_ins:ReturnMoviePlayer(lastPlayer)
    end
  else
    error("lottery_para.bg_type error : " .. tostring(self.curPoolCfg.bg_type))
  end
  self.ui.img_SubImage.enabled = false
  if not string.IsNullOrEmpty(self.curPoolCfg.bg1_path) then
    local path = PathConsts:GetLotteryPicPath("SubPicture/" .. self.curPoolCfg.bg1_path)
    self.tempResLoader:LoadABAssetAsync(path, function(texture)
      if texture == nil then
        return
      end
      self.ui.img_SubImage.texture = texture
      self.ui.img_SubImage.enabled = true
    end)
  end
  self.ui.img_Tile.enabled = false
  if not string.IsNullOrEmpty(self.curPoolCfg.intro_path) then
    local introPath = PathConsts:GetLotteryPicPath("Tile/" .. self.curPoolCfg.intro_path)
    self.tempResLoader:LoadABAssetAsync(introPath, function(texture)
      if texture == nil then
        return
      end
      self.ui.img_Tile.texture = texture
      self.ui.img_Tile.enabled = true
    end)
  end
  if self.curPoolCfg.up_reward1 == 0 then
    self.heroL:Hide()
  else
    self.heroL:Show()
    self.heroL:InitLtrHeroItem(self.curPoolCfg.up_reward1, self.tempResLoader, self.curPoolCfg.up_hero1_para)
  end
  if self.curPoolCfg.up_reward2 == 0 then
    self.heroR:Hide()
  else
    self.heroR:Show()
    self.heroR:InitLtrHeroItem(self.curPoolCfg.up_reward2, self.tempResLoader, self.curPoolCfg.up_hero2_para)
  end
  local startTime, endTime = curPoolData:GetStartAndEndTime()
  if self._countdownTimerId ~= nil then
    TimerManager:StopTimer(self._countdownTimerId)
    self._countdownTimerId = nil
  end
  if endTime == -1 then
    self.ui.tex_EndTime.gameObject:SetActive(false)
  else
    self.ui.tex_EndTime.gameObject:SetActive(true)
    self._countdownTimerId = TimerManager:StartTimer(1, self.__CountDownEndTime, self)
    self:__CountDownEndTime()
  end
  self:_TryUpdJpQZ()
  self:_RefreshLtrGroup()
  self:_RefreshNewRuleReddot()
  self:_UpdQuickGiftBtn()
  self:_RefreshManyUpHeroShow()
  self:_TryUpdSpecialSelectHero()
  if lastTempResLoader ~= nil then
    lastTempResLoader:Put2Pool()
    lastTempResLoader = nil
  end
end

function UILottery:_TryRefreshSkinAct()
  local lotteryType = self.curPoolData:GetLotteryDataCfgPoolType()
  local poolId = self.curPoolData.poolId
  self.skinActDrawLotteryNode:InitSkinActDrawLottery(lotteryType, poolId)
end

function UILottery:_TryUpdSpecialSelectHero()
  if self.curPoolData:IsLtrSpecialSelectHero() then
    if self._speSelectHeroNode == nil then
      self._speSelectHeroNode = UINLtrSpecialSelectHero.New()
      self._speSelectHeroNode:Init(self.ui.specialSelectHero)
    end
    self._speSelectHeroNode:Show()
    self._speSelectHeroNode:InitLtrSpecialSelectHeroNode(self.curPoolData)
    return
  end
  if self._speSelectHeroNode then
    self._speSelectHeroNode:Hide()
  end
end

function UILottery:_RefreshManyUpHeroShow()
  local curPoolData = self.curPoolData
  local curPoolCfg = self.curPoolCfg
  if #curPoolCfg.pt_rewardItemIdList <= 1 or curPoolData:IsLtrSpecialSelectHero() then
    self.ui.isOwned:SetActive(false)
    return
  end
  self.__ownedHeroPool:HideAll()
  self.ui.isOwned:SetActive(true)
  for k, itemId in ipairs(curPoolCfg.pt_rewardItemIdList) do
    local itemCfg = ConfigData.item[itemId]
    local heroId = itemCfg.arg[1]
    local ownedItem = self.__ownedHeroPool:GetOne(true)
    ownedItem:InitLtrOwnedHeroItem(heroId)
  end
end

function UILottery:_RefreshLtrGroup()
  local ltrGroupData = self.poolGroupDataList[self.poolIndex]
  local hasMoreGroup = ltrGroupData:HasLtrMoreGroup()
  self.ui.btn_ChangeMode.gameObject:SetActive(hasMoreGroup)
  if not hasMoreGroup then
    return
  end
  local ruleId = self.curPoolCfg.repeat_type
  self.ui.tex_ChangeMode:SetIndex(ruleId)
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local showRed = userData:GetLtrNewConvertSwitchRed()
  self.ui.obj_ChangeModeRedDot:SetActive(showRed)
end

function UILottery:_RefreshNewRuleReddot()
  local showLtrNewRuleRed = self.curPoolData:IsShowLtrNewRuleReddot()
  self.ui.obj_PoolDetailRedDot:SetActive(showLtrNewRuleRed)
end

function UILottery:RefreshCurLtrChangedUI()
  self:__RefreshSpecialOnceBtnState()
  self:__RefreshPtBtn()
  self:__RefreshTenBtn()
  self:_RefreshSpecialUp()
  self:_RefreshManyUpHeroShow()
  self:_TryRefreshSkinAct()
  if self.curPoolCfg.count_limit ~= 0 and not self.curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.FreeChoice) then
    self.ui.obj_RemianNum:SetActive(true)
    local limitNum = self.curPoolData:GetLtrPoolLimitNum()
    local remainNum = self.curPoolData:GetLtrPoolRemainNum()
    self.ui.tex_RemianNum.text = tostring(remainNum) .. "/" .. tostring(limitNum)
  else
    self.ui.obj_RemianNum:SetActive(false)
  end
end

function UILottery:_TryUpdJpQZ()
  if Consts.GameChannelType.IsJp() and self.curPoolCfg.costId2 ~= nil and ConstGlobalItem.IsQZ(self.curPoolCfg.costId2) then
    self.ui.tex_FreeQZ:SetIndex(0, tostring(PlayerDataCenter:GetItemCoutNoMerge(ConstGlobalItem.PaidItem)))
    self.ui.tex_PayQZ:SetIndex(0, tostring(PlayerDataCenter:GetItemCoutNoMerge(ConstGlobalItem.PaidQZ)))
    self.ui.obj_JpQZ:SetActive(true)
    return
  end
  self.ui.obj_JpQZ:SetActive(false)
end

function UILottery:_RefreshSpecialUp()
  if not self.curPoolData:ShowLtrUpIntro() then
    self.ui.obj_UpAdd:SetActive(false)
    self.ui.obj_UpNormal:SetActive(false)
    return
  end
  local isSpecialUp = self.curPoolData:IsLtrSpecialUp()
  self.ui.obj_UpAdd:SetActive(isSpecialUp)
  self.ui.obj_UpNormal:SetActive(not isSpecialUp)
  if isSpecialUp then
    local noUpNum = self.curPoolData:GetLtrNoUpNum()
    local mustUpNum = self.curPoolData:GetLtrSpecialUpNum()
    self.ui.tex_SpUpNum:SetIndex(0, tostring(noUpNum), tostring(mustUpNum))
  end
end

function UILottery:__RefreshTopRes()
  local topResDic = {}
  for k, execType in pairs(LotteryEnum.eLtrExecType) do
    if self.curPoolData:IsLtrExecTypeOpen(execType) then
      local costIdStr = "costId" .. tostring(execType)
      if self.curPoolCfg[costIdStr] ~= nil then
        topResDic[self.curPoolCfg[costIdStr]] = true
      end
    end
  end
  if self.curPoolData:IsLtrHasTenPrior() then
    topResDic[self.curPoolCfg.costIdTenPrior] = true
  end
  if self.curPoolCfg.pool_client_type == LotteryEnum.eLotteryPoolType.Paid then
    topResDic[ConstGlobalItem.PaidItem] = true
    topResDic[ConstGlobalItem.PaidSubItem] = true
  end
  local topResIdList = {}
  for itemId, _ in pairs(topResDic) do
    table.insert(topResIdList, itemId)
  end
  table.sort(topResIdList)
  UIUtil.RefreshTopResId(topResIdList, nil, false, self)
end

function UILottery:__RefreshPtBtn()
  local hasPt = self.curPoolData:HasLtrPt()
  self.ui.btn_PtExchange.gameObject:SetActive(hasPt)
  self.ui.obj_MaskOnlyPt:SetActive(false)
  self.ui.obj_onlyPtTips:SetActive(false)
  if not hasPt then
    return
  end
  local ptNum = self.curPoolData:GetLtrPtNum()
  local maxPtNum = 0
  for k, num in ipairs(self.curPoolCfg.pt_rewardCostNumList) do
    maxPtNum = math.max(maxPtNum, num)
  end
  self.ui.tex_PtNum:SetIndex(0, tostring(ptNum), tostring(maxPtNum))
  if ptNum >= maxPtNum then
    self.ui.obj_MaskOnlyPt:SetActive(true)
    self.ui.obj_onlyPtTips:SetActive(true)
    self.ui.tex_PtTips:SetIndex(0, tostring(maxPtNum))
  end
end

function UILottery:__RefreshTenBtn()
  if not self.curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.Ten) then
    return
  end
  self:_RemoveBtnTenReddotListener()
  local ok, btnTenNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.LotteryPr, self.curPoolData.poolId, RedDotStaticTypeId.LotteryTen)
  if ok then
    RedDotController:AddListener(btnTenNode.nodePath, self.__UpdBtnTenRedDot)
    self._lastBtnTenReddotPath = btnTenNode.nodePath
  end
  self:_ShowBtnTenRedDot(ok and btnTenNode:GetRedDotCount() > 0)
  local limitNum = self.curPoolCfg.count_limit
  local disableTen = limitNum ~= 0 and self.curPoolData:GetLtrPoolRemainNum() < 10
  self.ui.btn_Ten.enabled = not disableTen
  self.ui.obj_TenNumLimit:SetActive(disableTen)
  self._hasCustomDrawNum = nil
  local drawNum = 10
  local drawCostId = self.curPoolCfg.costId2
  local drawCostNum = self.curPoolCfg.costNum2
  if self.curPoolData:LtrCurTenIsPrior() then
    drawCostNum = self.curPoolCfg.costNumTenPrior
    drawCostId = self.curPoolCfg.costIdTenPrior
  else
    local ok, residueNum = self.curPoolData:TryGetLtrCustomDrawNum()
    if ok and 1 < residueNum and residueNum < 10 then
      drawNum = residueNum
      drawCostNum = self.curPoolCfg.costNum1 * residueNum
      self._hasCustomDrawNum = residueNum
    end
  end
  self.ui.img_PayIcon_Ten.sprite = CRH:GetSprite(ConfigData.item[drawCostId].small_icon)
  self.ui.tex_BtnTen:SetIndex(0, tostring(drawNum))
  self.ui.tex_PayTen.text = tostring(drawCostNum)
end

function UILottery:__RefreshGuaranteeState()
  local IsGuaranteeOpen = self.curPoolData:IsGuaranteeOpen()
  if not IsGuaranteeOpen then
    return
  end
  local usedGuarantee = PlayerDataCenter.allLtrData.ltrSpecial[self.curPoolData.ltrCfg.guaranteeType]
  local allGuarantee = self.curPoolData.ltrCfg.guaranteeNums
  if usedGuarantee == nil then
    usedGuarantee = 0
  end
  self.ui.tex_SprcialSlogan.text = string.format("%s/%s", usedGuarantee, allGuarantee)
end

function UILottery:__RefreshFreeChoiceTips()
  local isFreeChoice = self.curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.FreeChoice)
  self.ui.obj_FreeChoiceTips:SetActive(false)
  if not isFreeChoice then
    return
  end
  local lastEndTime, lastPoolData
  for k, poolGroupData in ipairs(self.poolGroupDataList) do
    local poolData = poolGroupData.ltrPoolData
    local startTime, endTime = poolData:GetStartAndEndTime()
    if poolData:IsLtrFreeChoicePrompt() then
      if endTime == -1 then
        lastPoolData = poolData
        break
      end
      if lastEndTime == nil or lastEndTime < endTime then
        lastEndTime = endTime
        lastPoolData = poolData
      end
    end
  end
  if lastPoolData == nil then
    return
  end
  self.ui.obj_FreeChoiceTips:SetActive(true)
  local poolName = LanguageUtil.GetLocaleText(lastPoolData.ltrCfg.name)
  self.ui.tex_FreeChoiceTips:SetIndex(0, poolName)
end

function UILottery:__RefreshSpecialOnceBtnState()
  if not self.curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.SpecialOnce) then
    self:__ClearSpecialOnceBtnTimer()
    return
  end
  if self.curPoolData:IsLtrExecSpecialOneceTimeOk() then
    self.ui.obj_MaskSpecialOne:SetActive(false)
    self.ui.btn_SpecialOne.enabled = true
    self.ui.tex_SpecialOneceTime.text = LanguageUtil.GetLocaleText(self.curPoolCfg.sp_time_show)
  else
    self.ui.obj_MaskSpecialOne:SetActive(true)
    self.ui.btn_SpecialOne.enabled = false
    self:__ClearSpecialOnceBtnTimer()
    self._specialOnceBtnTimerId = TimerManager:StartTimer(1, self.__UpdSpecialOnceBtnTime, self, false, false, true)
    self:__UpdSpecialOnceBtnTime()
  end
end

function UILottery:__UpdSpecialOnceBtnTime()
  local remainingTs = self.curPoolData:GetLtrExecSpecialOneceRemainingTs()
  if 0 <= remainingTs then
    self.ui.tex_SpecialOneceTime.text = TimeUtil:TimestampToTime(remainingTs)
    return
  end
  self:__ClearSpecialOnceBtnTimer()
  self:__RefreshSpecialOnceBtnState()
end

function UILottery:__ClearSpecialOnceBtnTimer()
  if self._specialOnceBtnTimerId ~= nil then
    TimerManager:StopTimer(self._specialOnceBtnTimerId)
    self._specialOnceBtnTimerId = nil
  end
end

function UILottery:__CountDownEndTime()
  local startTime, endTime = self.curPoolData:GetStartAndEndTime()
  local diff = endTime - PlayerDataCenter.timestamp
  if 0 < diff then
    local d, h, m, s = TimeUtil:TimestampToTimeInter(diff, false, true)
    if 0 < d then
      self.ui.tex_EndTime:SetIndex(0, string.format("%02d", d), string.format("%02d", h))
    else
      self.ui.tex_EndTime:SetIndex(1, string.format("%02d", h), string.format("%02d", m))
    end
  else
    self.ui.tex_EndTime:SetIndex(1, "00", "00")
    if self._countdownTimerId ~= nil then
      TimerManager:StopTimer(self._countdownTimerId)
      self._countdownTimerId = nil
    end
  end
end

function UILottery:__ClearScrollTween()
  if self.__scrollTween ~= nil then
    self.__scrollTween:Kill()
    self.__scrollTween = nil
  end
end

function UILottery:__OnClickDrawOne()
  self.ltrCtrl:LtrDrawOne()
end

function UILottery:__OnClickDrawTen()
  if self._hasCustomDrawNum ~= nil then
    self.ltrCtrl:LtrCustomDraw(self._hasCustomDrawNum)
  else
    self.ltrCtrl:LtrDrawTen()
  end
end

function UILottery:__OnClickDrawSpecialOne()
  self.ltrCtrl:LtrDrawSpecialOne()
end

function UILottery:__OnClickFreeSelect()
  self.ltrCtrl:LtrFreeSelectJudge(self.curPoolData.ltrCfg)
end

function UILottery:__OnClickPtExchange()
  if self.ltrCtrl:CheckLtrPoolExpired() then
    return
  end
  if not self.ltrCtrl:LtrCheckSpecialSelect() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryExchange, function(window)
    if window ~= nil then
      window:ShowLtrPtNode(self.curPoolData, self.ltrCtrl)
    end
  end)
end

function UILottery:__OnClickPoolDetail(showWinFunc)
  if self.ltrCtrl:CheckLtrPoolExpired() then
    return
  end
  self.ltrCtrl:ChangeLotteryState(LotteryEnum.eLotteryState.PoolDetail)
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryPoolDetail, function(win)
    if win == nil then
      return
    end
    local poolGrouData = self.poolGroupDataList[self.poolIndex]
    win:InitLtrPoolDetail(self.curPoolData, poolGrouData, function()
      self.ltrCtrl:ChangeLotteryState(LotteryEnum.eLotteryState.Normal)
    end)
    if showWinFunc ~= nil then
      showWinFunc(win)
    end
  end)
end

function UILottery:__OnClickBg()
  self.ltrCtrl:CheckLtrPoolExpired()
end

function UILottery:__OnClickLeftArrow()
  self:__ChangePoolIndex(false)
end

function UILottery:__OnClickRightArrow()
  self:__ChangePoolIndex(true)
end

function UILottery:__OnClickUpIntro()
  self:__OnClickPoolDetail(function(win)
    win:ShowLtrDetailUpRule()
  end)
end

function UILottery:__OnClickSwitchGroup()
  local ltrGroupData = self.poolGroupDataList[self.poolIndex]
  self.ltrCtrl:ChangeLotteryState(LotteryEnum.eLotteryState.SelectPool)
  UIManager:ShowWindowAsync(UIWindowTypeID.LotterySelectPool, function(win)
    if win == nil then
      return
    end
    win:InitLtrSelectPool(ltrGroupData, self.curPoolData.poolId, function(ltrData)
      self:SelectLtrPoolByData(ltrData)
      self.ltrCtrl:SelectGroupPoolSuccess(ltrData.poolId)
      self.ltrCtrl:ChangeLotteryState(LotteryEnum.eLotteryState.Normal)
    end)
    if self.ui.obj_ChangeModeRedDot.activeInHierarchy then
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetLtrNewConvertSwitchRed()
      PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
      self.ui.obj_ChangeModeRedDot:SetActive(false)
    end
  end)
end

function UILottery:__OnClickHeroInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfoState, function(win)
    if win == nil then
      return
    end
    win:InitHeroInfoState(self.UpHeroId)
  end)
end

function UILottery:__OnClickShowCharacter()
  local currentPoolId = 0
  local lottrryCtrl = ControllerManager:GetController(ControllerTypeId.Lottery, true)
  if lottrryCtrl ~= nil then
    currentPoolId = lottrryCtrl.curPoolId
  end
  self:CloseLottery(true)
  ControllerManager:GetController(ControllerTypeId.ShowCharacter, true):EnterShowCharacterScene(self.UpHeroId, currentPoolId)
end

function UILottery:__ChangePoolIndex(isAdd)
  local index = self.poolIndex
  if isAdd then
    index = index + 1
  else
    index = index - 1
  end
  index = math.clamp(index, 1, #self.poolGroupDataList)
  if index == self.poolIndex then
    return
  end
  self:SelectLtrUIPool(index)
  self:_LocateItemTween()
end

function UILottery:_LocateItemTween()
  self.ui.infoScroll:StopMovement()
  local tarPos
  local leftPos = -(self.ui.scrollLayoutGroup.padding.left + (self.poolIndex - 1) * self.poolItemWidth)
  local rightPos = leftPos - self.poolItemWidth
  local curPosX = self.ui.infoScroll.content.localPosition.x
  if curPosX - leftPos < 0 then
    tarPos = leftPos + self.ui.scrollLayoutGroup.padding.left
    if self.poolIndex ~= 1 then
      tarPos = tarPos + self.poolItemWidth * 0.5
    end
  elseif curPosX - rightPos > self.ui.infoScroll.transform.rect.width then
    tarPos = rightPos + self.ui.infoScroll.transform.rect.width
    if self.poolIndex ~= #self.poolGroupDataList then
      tarPos = tarPos - self.poolItemWidth * 0.5
    end
  else
    return
  end
  self:__ClearScrollTween()
  self.__scrollTween = self.ui.infoScroll.content:DOLocalMoveX(tarPos, 0.2)
end

function UILottery:__OnClickClose()
  if self.fromType == eBaseWinFromWhere.home then
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    self:CloseLottery(homeWin ~= nil)
  end
end

function UILottery:CloseLottery(needRemoveAllVoice)
  self:OnCloseWin()
  if needRemoveAllVoice then
    AudioManager:RemoveAllVoice()
  end
  ControllerManager:DeleteController(ControllerTypeId.Lottery)
  self:Delete()
end

function UILottery:ScrollLotteryPoolEnd()
  self.ui.infoScroll.horizontalNormalizedPosition = 1
end

function UILottery:OnPageChangeDragBegin(go, eventData)
  if GuideManager.inGuide then
    return
  end
  self.pageChangeTouchPointX = eventData.position.x
end

function UILottery:OnPageChangeDragEnd(go, eventData)
  if self.pageChangeTouchPointX == nil then
    return
  end
  local curPointX = eventData.position.x
  local startPointX = self.pageChangeTouchPointX
  self.pageChangeTouchPointX = nil
  local diff = curPointX - startPointX
  if diff > self.ui.dragPageChangeDiff then
    self:__ChangePoolIndex(false)
  elseif diff < -self.ui.dragPageChangeDiff then
    self:__ChangePoolIndex(true)
  end
end

function UILottery:_OnItemChange(itemUpdateDic)
  if self.curPoolData ~= nil and self.curPoolData:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.Once) and self.curPoolCfg ~= nil and itemUpdateDic[self.curPoolCfg.costId1] ~= nil or self.curPoolData ~= nil and self.curPoolData:IsLtrHasTenPrior() and self.curPoolCfg ~= nil and itemUpdateDic[self.curPoolCfg.costIdTenPrior] ~= nil then
    self:__RefreshTenBtn()
  end
  if itemUpdateDic[ConstGlobalItem.PaidItem] ~= nil or itemUpdateDic[ConstGlobalItem.PaidQZ] ~= nil then
    self:_TryUpdJpQZ()
  end
end

function UILottery:_UpdPoolReddot(reddotNode)
  local ltrId = reddotNode.nodeId
  local poolItem = self.poolItemDic[ltrId]
  if poolItem ~= nil then
    poolItem:ShowLtrPoolItemReddot(reddotNode:GetRedDotCount() > 0)
  end
end

function UILottery:_UpdBtnTenRedDot(node)
  self:_ShowBtnTenRedDot(node:GetRedDotCount() > 0)
end

function UILottery:_RemoveBtnTenReddotListener()
  if self._lastBtnTenReddotPath ~= nil then
    RedDotController:RemoveListener(self._lastBtnTenReddotPath, self.__UpdBtnTenRedDot)
    self._lastBtnTenReddotPath = nil
  end
end

function UILottery:_ShowBtnTenRedDot(isShow)
  self.ui.redDot_BtnTen:SetActive(isShow)
end

function UILottery:_ClearSelectMoveTween()
  if self._selectMoveTween ~= nil then
    self._selectMoveTween:Kill()
    self._selectMoveTween = nil
  end
end

function UILottery:HideLtrDetailNewRuleRedPoint()
  self.ui.obj_PoolDetailRedDot:SetActive(false)
end

function UILottery:EnableLtrVideo(enable)
  self.ui.img_Video.enabled = enable
end

function UILottery:RefreshCharDunBtn()
  if self.curPoolCfg.jump_id ~= JumpManager.eJumpTarget.DynSectorLevel then
    self.ui.btn_AVGCharDun.gameObject:SetActive(false)
  else
    local flag = self.curPoolCfg.jump_arg ~= nil and PlayerDataCenter.sectorEntranceHandler:CheckSectorValid(self.curPoolCfg.jump_arg[1])
    self.ui.btn_AVGCharDun.gameObject:SetActive(flag)
  end
end

function UILottery:OnClickCharDun()
  if 0 < (self.curPoolCfg.jump_id or 0) then
    JumpManager:Jump(self.curPoolCfg.jump_id, nil, nil, self.curPoolCfg.jump_arg)
  end
end

function UILottery:_UpdQuickGiftBtn()
  local ok, giftIdList = self.curPoolData:GetBuyableGiftIdList()
  self.ui.btn_QuickGift.gameObject:SetActive(ok)
end

function UILottery:_OnClickQuickGift()
  local ok, giftIdList = self.curPoolData:GetBuyableGiftIdList()
  if not ok then
    self:_UpdQuickGiftBtn()
    return
  end
  PlayerClickCollectManager:BtnClickNumCollect(1005)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonThemedPacks, function(win)
    if win == nil then
      return
    end
    win:InitLotteryQuickGift(giftIdList, function()
      self:_UpdQuickGiftBtn()
    end)
  end)
end

function UILottery:OnDelete()
  RedDotController:RemoveListener(RedDotDynPath.LotteryPrPoolPath, self.__UpdPoolReddotFunc)
  self:_RemoveBtnTenReddotListener()
  self.ui.ani_Pic:DOKill()
  self.ltrPoolItemPool:DeleteAll()
  if self._countdownTimerId ~= nil then
    TimerManager:StopTimer(self._countdownTimerId)
    self._countdownTimerId = nil
  end
  self.skinActDrawLotteryNode:Delete()
  UIManager:DeleteWindow(UIWindowTypeID.LotterySelectHero)
  UIManager:DeleteWindow(UIWindowTypeID.LotteryExchange)
  self:_ClearSelectMoveTween()
  if self.tempResLoader ~= nil then
    self.tempResLoader:Put2Pool()
    self.tempResLoader = nil
  end
  if self.moviePlayer ~= nil then
    cs_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  self:__ClearScrollTween()
  self:__ClearSpecialOnceBtnTimer()
  self.resLoader:Put2Pool()
  self.resLoader = nil
  if self._speSelectHeroNode ~= nil then
    self._speSelectHeroNode:Delete()
  end
  if self.texture ~= nil then
    self.ui.model_camera.targetTexture = nil
    self.ui.model_Image.texture = nil
    LotteryRtUtil.ReleaseTemporaryAndDestory(self.texture)
    self.texture = nil
    self.ui.model_camera.gameObject:SetActive(false)
    self.ui.rect_uiModel.gameObject:SetActive(false)
  end
  self.__ownedHeroPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._onItemChangeFunc)
  base.OnDelete(self)
end

return UILottery
