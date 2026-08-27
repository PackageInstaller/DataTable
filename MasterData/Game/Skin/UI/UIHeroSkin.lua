local UIHeroSkin = class("UIHeroSkin", UIBaseWindow)
local base = UIBaseWindow
local UINHeroSkin = require("Game.Skin.UI.UINHeroSkin")
local cs_DoTween = CS.DG.Tweening.DOTween
local JumpManager = require("Game.Jump.JumpManager")
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local ShopEnum = require("Game.Shop.ShopEnum")
local SkinEnum = require("Game.Skin.SkinEnum")
local ShopUtil = require("Game.Shop.ShopUtil")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local eMoveDir = {Left = 1, Right = 2}
local waitRecorverNUM = 0
local heroDragScaleLimit = {max = 1.7, min = 0.7}

function UIHeroSkin:OnInit()
  AudioManager:PlayAudioById(1111)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  UIUtil.AddButtonListener(self.ui.btn_Equip, self, self.OnClickUse)
  UIUtil.AddButtonListener(self.ui.btn_Goto, self, self.OnClickGoto)
  UIUtil.AddButtonListener(self.ui.btn_ShowCharacter, self, self.OnClickPreview3DSkin)
  UIUtil.AddButtonListener(self.ui.btn_SwitchLeft, self, self.OnClickLeftSwitch)
  UIUtil.AddButtonListener(self.ui.btn_SwitchRight, self, self.OnClickRightSwitch)
  UIUtil.AddButtonListener(self.ui.btn_ReturnNormal, self, self.OnClickViewReturn)
  UIUtil.AddButtonListener(self.ui.btn_ViewHero, self, self.OnClickViewHero)
  UIUtil.AddButtonListener(self.ui.btn_AVGCharDun, self, self.OnClickAVGCharDun)
  UIUtil.AddButtonListener(self.ui.btn_AudioList, self, self.OnClickOpenSkinVoice)
  UIUtil.AddButtonListener(self.ui.btn_BpSkinGift, self, self.OnClickBpSKinGift)
  UIUtil.AddButtonListener(self.ui.btn_SkinUpgrade, self, self._OnClickSkinUpgrade)
  UIUtil.AddValueChangedListener(self.ui.tog_Live2D, self, self.OnChangeLive2dValue)
  self.skinPool = UIItemPool.New(UINHeroSkin, self.ui.skinPreviewItem)
  self.ui.skinPreviewItem:SetActive(false)
  self.__OnClickSkinItem = BindCallback(self, self.OnClickSkinItem)
  self.__OnGesture = BindCallback(self, self.OnGesture)
  self.__RefreshState = BindCallback(self, self.RefreshState)
  self.itemLength = self.ui.skinPreviewItem.transform.sizeDelta.x
  self.oriHeroNodePos = self.ui.heroNode.transform.localPosition
  self.oriPicHolderPos = self.ui.picHolder.transform.localPosition
  self.oriHeroFadePos = self.ui.heroFade.transform.localPosition
  self.__OnUpdateHero = BindCallback(self, self.__UpdateHero)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnUpdateHero)
  self.__OnUpdateHeroSkin = BindCallback(self, self.__UpdateHeroSkin)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinUpgrade, self.__OnUpdateHeroSkin)
  MsgCenter:AddListener(eMsgEventId.UpdateHeroSkin, self.__OnUpdateHeroSkin)
  self.__OnPayGiftCondition = BindCallback(self, self.OnPayGiftCondition)
  MsgCenter:AddListener(eMsgEventId.PayGiftItemPreConfition, self.__OnPayGiftCondition)
  MsgCenter:AddListener(eMsgEventId.PayGiftChange, self.__OnPayGiftCondition)
  self.__OnHeroSkinLimitTimeOut = BindCallback(self, self.OnHeroSkinLimitTimeOut)
  MsgCenter:AddListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnHeroSkinLimitTimeOut)
end

function UIHeroSkin:__UpdateHero(heroUpdate, hasNew)
  if hasNew then
    self:RefreshState()
  end
end

function UIHeroSkin:__UpdateHeroSkin()
  self:Refresh()
  for i, skinItem in ipairs(self.skinPool.listItem) do
    skinItem:TryReloadCtify(self.resLoader)
  end
end

function UIHeroSkin:OnShow()
  if self.l2dBinding ~= nil and not IsNull(self.l2dBinding.renderController) then
    local interation = self.l2dBinding.renderController.transform:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if interation ~= nil then
      interation:RestartBodyAnimation()
    end
  end
  base.OnShow(self)
end

function UIHeroSkin:GetHeroId()
  return self.heroId
end

function UIHeroSkin:GetCurrentSkinId()
  if self.skinIds == nil then
    return nil
  end
  local skinId = self.skinIds[self.curIndex]
  return skinId
end

function UIHeroSkin:_ResetData()
  self.skinIds = nil
  self.heroId = nil
  self.curIndex = 0
  self.usingIndex = 0
  self.buyCallback = nil
  self.closeCallback = nil
  self.changeCallback = nil
  self.heroDataList = nil
  self._isInPreview = false
  self.heroSwitchIndex = nil
end

function UIHeroSkin:SetHeroSkinBanJump()
  self._banJump = true
  UIUtil.SetTopStatusBtnShow(false, false)
  self.ui.btn_Goto.gameObject:SetActive(false)
end

function UIHeroSkin:InitSkinBySkinList(skinId, skinIds, buyCallback, closeCallback, isJumpReturn)
  if not isJumpReturn then
    UIUtil.SetTopStatus(self, self.OnReturn)
  end
  self:_ResetData()
  self.__isHeroList = false
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.skinIds = {}
  local selectSkinId
  for i, v in ipairs(skinIds) do
    if PlayerDataCenter.skinData:IsSkinUnlocked(v) then
      table.insert(self.skinIds, v)
      if v == skinId then
        selectSkinId = skinId
      end
    end
  end
  if selectSkinId == nil then
    selectSkinId = self.skinIds[1]
  end
  self.heroId = skinCtr:GetHeroId(selectSkinId)
  self.curIndex = 1
  self.buyCallback = buyCallback
  self.closeCallback = closeCallback
  self.ui.btn_SwitchLeft.gameObject:SetActive(false)
  self.ui.btn_SwitchRight.gameObject:SetActive(false)
  for i, v in ipairs(self.skinIds) do
    if selectSkinId == v then
      self.curIndex = i
    end
  end
  if self.winTween ~= nil then
    self.winTween:Complete()
  end
  if not isJumpReturn then
    self:InitView()
  end
end

function UIHeroSkin:InitSkin(heroId, changeCallback, heroDataList, closeCallback, isJumpReturn)
  if not isJumpReturn then
    UIUtil.SetTopStatus(self, self.OnReturn)
  end
  self:_ResetData()
  self.__isHeroList = true
  self.heroId = heroId
  self.curIndex = 1
  self.changeCallback = changeCallback
  self.heroDataList = heroDataList
  self.closeCallback = closeCallback
  local usingSkinId = 0
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData ~= nil then
    usingSkinId = heroData.skinId
  end
  local heroCfg = ConfigData.hero_data[self.heroId]
  self.skinIds = {
    heroCfg.default_skin
  }
  for i, v in ipairs(heroCfg.skin) do
    if PlayerDataCenter.skinData:IsSkinUnlocked(v) then
      table.insert(self.skinIds, v)
      if v == usingSkinId then
        self.curIndex = #self.skinIds
      end
    end
  end
  self.usingIndex = self.curIndex
  local hasSwitch = self.heroDataList ~= nil and 1 < #self.heroDataList
  if hasSwitch then
    self.heroSwitchIndex = nil
    for i, v in ipairs(self.heroDataList) do
      if v.dataId == self.heroId then
        self.heroSwitchIndex = i
        break
      end
    end
    hasSwitch = self.heroSwitchIndex ~= nil
  end
  self.ui.btn_SwitchLeft.gameObject:SetActive(hasSwitch)
  self.ui.btn_SwitchRight.gameObject:SetActive(hasSwitch)
  if not isJumpReturn then
    self:InitView()
  end
end

function UIHeroSkin:SetSkinFromWhere(where)
  self._fromWhere = where
end

function UIHeroSkin:GetSkinFromWhere()
  return self._fromWhere
end

function UIHeroSkin:OnClickLeftSwitch()
  if self._isInPreview then
    return
  end
  if self.heroSwitchIndex == 1 then
    self.heroSwitchIndex = #self.heroDataList
  else
    self.heroSwitchIndex = self.heroSwitchIndex - 1
  end
  self:RefreShByHeroSwitchIndex()
  if self.changeCallback ~= nil then
    self.changeCallback(-1)
  end
end

function UIHeroSkin:OnClickRightSwitch()
  if self._isInPreview then
    return
  end
  if self.heroSwitchIndex == #self.heroDataList then
    self.heroSwitchIndex = 1
  else
    self.heroSwitchIndex = self.heroSwitchIndex + 1
  end
  self:RefreShByHeroSwitchIndex()
  if self.changeCallback ~= nil then
    self.changeCallback(1)
  end
end

function UIHeroSkin:RefreShByHeroSwitchIndex()
  if self.heroSwitchIndex == nil then
    return
  end
  local heroData = self.heroDataList[self.heroSwitchIndex]
  local usingSkinId = heroData.skinId
  self.heroId = heroData.dataId
  self.curIndex = 1
  local heroCfg = ConfigData.hero_data[self.heroId]
  self.skinIds = {
    heroCfg.default_skin
  }
  for i, v in ipairs(heroCfg.skin) do
    if PlayerDataCenter.skinData:IsSkinUnlocked(v) then
      table.insert(self.skinIds, v)
      if v == usingSkinId then
        self.curIndex = #self.skinIds
      end
    end
  end
  self.usingIndex = self.curIndex
  self:InitView()
end

function UIHeroSkin:InitView()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
    self._lastThemId = nil
  end
  self.resLoader = CS.ResLoader.Create()
  self.ui.btn_BpSkinGift.gameObject:SetActive(false)
  self.skinPool:HideAll()
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local item
  for _, skinId in ipairs(self.skinIds) do
    item = self.skinPool:GetOne(true)
    item.gameObject:SetActive(true)
    local skinCfg = ConfigData.skin[skinId]
    local heroId = self.heroId
    if skinCfg ~= nil then
      heroId = skinCtr:GetHeroId(skinId) or self.heroId
    end
    item:InitSkinItem(heroId, skinCfg, self.resLoader, self.__OnClickSkinItem, self.__RefreshState, self)
    item.transform:SetParent(self.ui.rect_skin.transform)
  end
  for i = 1, #self.skinPool.listItem do
    item = self.skinPool.listItem[i]
    if i == self.curIndex then
      item:SetSelectState(true)
    else
      item:SetSelectState(false)
    end
  end
  self:SetResourceDisplay()
  self:Refresh()
  self:RefreshHaveCount()
  self:LocationHighLightSkinItem()
  self:Try2StartSkinTimer()
end

function UIHeroSkin:Refresh(moveDir)
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  local resModel = item.resModelCfg
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.heroId = item.heroCfg.id
  if skinCfg ~= nil then
    self.ui.tex_Intro.text = LanguageUtil.GetLocaleText(skinCfg.describe)
  else
    self.ui.tex_Intro.text = ""
  end
  if self._lastHeroId ~= self.heroId then
    self._lastHeroId = self.heroId
    local vowCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
    local heroName = vowCtrl:GetHeroName(self.heroId, true)
    self.ui.tex_Name.text = heroName
    self.ui.tex_NameEN.text = LanguageUtil.GetLocaleText(item.heroCfg.name_en)
  end
  local themId = skinCfg ~= nil and skinCfg.theme or ConfigData.game_config.defaultSkinThemId
  if self._lastThemId ~= themId then
    self._lastThemId = themId
    local skinThemCfg = ConfigData.skinTheme[themId]
    if skinThemCfg ~= nil then
      self.ui.img_Head.gameObject:SetActive(false)
      self.resLoader:LoadABAssetAsync(PathConsts:GetHeroSkinThemePicPath(skinThemCfg.pic, self._fromWhere), function(Texture)
        if Texture == nil or IsNull(self.transform) then
          return
        end
        self.ui.img_Head.texture = Texture
        self.ui.img_Head.gameObject:SetActive(true)
      end)
    end
  end
  self.isLive2dTogValid = false
  item:GetIsItemShowOutline(function(IsShowSkinOutline)
    local live2dLevel = item:GetItemLive2dLevel()
    local isHaveL2D = 0 < live2dLevel and not IsShowSkinOutline
    local skinId = skinCfg.id
    local isHasSkin = skinCfg.isdefault_skin or PlayerDataCenter.skinData:IsHaveSkin(skinId)
    local isForceHideL2dTog = not isHasSkin and not PlayerDataCenter.skinData:IsSkinL2dCouldShow(skinId)
    self.ui.tog_Live2D.gameObject:SetActive(isHaveL2D and not isForceHideL2dTog)
    if isHaveL2D then
      local isOpen = PlayerDataCenter.skinData:GetLive2dSwitchState(item.heroCfg.id, skinCfg ~= nil and skinCfg.id or 0)
      self.ui.tog_Live2D.isOn = isOpen
      if isOpen then
        self.ui.ani_Tog:DORewind()
      else
        self.ui.ani_Tog:DOComplete()
      end
      self.isLive2dTogValid = true
      if live2dLevel == 2 then
        self.ui.tex_Live2D:SetIndex(1)
      else
        self.ui.tex_Live2D:SetIndex(0)
      end
    end
  end)
  self:LoadViewRes(moveDir)
  self:RefreshState()
end

function UIHeroSkin:SetResourceDisplay()
  local ids
  for i, v in ipairs(self.skinPool.listItem) do
    if v.shopGoodsData ~= nil and (ids == nil or not table.contain(ids, v.shopGoodsData.currencyId)) then
      ids = ids or {}
      table.insert(ids, v.shopGoodsData.currencyId)
      if v.shopGoodsData.currencyId == ConstGlobalItem.PaidSubItem and not table.contain(ids, ConstGlobalItem.PaidItem) then
        table.insert(ids, ConstGlobalItem.PaidItem)
      end
    end
  end
  if ids ~= nil then
    table.sort(ids, function(a, b)
      return a < b
    end)
  end
  UIUtil.RefreshTopResId(ids)
end

function UIHeroSkin:RefreshState()
  self.ui.btn_Buy.gameObject:SetActive(false)
  self.ui.btn_Equip.gameObject:SetActive(false)
  self.ui.btn_Goto.gameObject:SetActive(false)
  self.ui.obj_Equipped:SetActive(false)
  self.ui.btn_SkinUpgrade.gameObject:SetActive(false)
  local couldShow3DSkin = not BattleDungeonManager:InBattleDungeon()
  self.ui.btn_ShowCharacter.gameObject:SetActive(couldShow3DSkin)
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  local isHave = skinCfg == nil or skinCfg.isdefault_skin or PlayerDataCenter.skinData:IsHaveSkinPermanent(skinCfg.id)
  local isHaveSkinLimit = PlayerDataCenter.skinData:IsHaveSkinLimit(skinCfg.id)
  local isHaveHero = PlayerDataCenter:ContainsHeroData(self:GetHeroId())
  self._bpSkinShopId = item:GetSkinShopId()
  local bpSkinGift = item:GetSkinBpGiftId()
  self:__RefreshBpSkinGift(bpSkinGift)
  self.ui.btn_AVGCharDun.gameObject:SetActive(not string.IsNullOrEmpty(skinCfg.skin_avg) and isHave)
  self.ui.btn_AudioList.gameObject:SetActive(skinCfg.has_voice and isHaveHero and isHave and (self.__isHeroList or self:GetSkinFromWhere() == SkinEnum.fromWhere.bp))
  local showSkinUpgrade = PlayerDataCenter.skinData:IsSkinCanUpgrade(skinCfg.id)
  showSkinUpgrade = showSkinUpgrade and PlayerDataCenter.skinData:IsInSkinUpgradeTimeRange(skinCfg.id)
  if showSkinUpgrade or isHaveSkinLimit then
    self:Try2StartSkinTimer()
  end
  if self.__isHeroList then
    if self.usingIndex ~= nil and self.curIndex == self.usingIndex then
      self.ui.obj_Equipped:SetActive(true)
      self.ui.tex_EquipInfo:SetIndex(0)
      return
    end
  elseif isHave and skinCfg ~= nil then
    local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
    local heroId = skinCtrl:GetHeroId(skinCfg.id)
    if heroId == nil or PlayerDataCenter.heroDic[heroId] == nil then
      self.ui.obj_Equipped:SetActive(true)
      self.ui.tex_EquipInfo:SetIndex(1)
      return
    end
    local heroData = PlayerDataCenter.heroDic[heroId]
    if heroData.skinId == skinCfg.id then
      self.ui.obj_Equipped:SetActive(true)
      self.ui.tex_EquipInfo:SetIndex(0)
      return
    end
  end
  if isHave or isHaveSkinLimit and self._fromWhere ~= SkinEnum.fromWhere.shopOrGift then
    self.ui.btn_Equip.gameObject:SetActive(true)
    self.ui.obj_Equipped:SetActive(false)
    return
  end
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local flag, condition = skinCtr:CheckSourceValid(skinCfg.id)
  if flag then
    if item.shopGoodsData ~= nil then
      self.ui.btn_Buy.gameObject:SetActive(true)
      local priceItem = ConfigData.item[item.shopGoodsData.currencyId]
      self.ui.img_Price.sprite = CRH:GetSprite(priceItem.small_icon)
      self.ui.tex_Price.text = tostring(item.shopGoodsData.newCurrencyNum)
    elseif condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active or skinCfg.jumpId ~= nil and 0 < skinCfg.jumpId then
      self.ui.btn_Goto.gameObject:SetActive(true)
      if condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active then
        local actFrameData = skinCtr:GetActFrameDataBySkinCfg(skinCfg)
        if actFrameData ~= nil then
          self.ui.text_goto:SetIndex(1)
        else
          self.ui.text_goto:SetIndex(0)
        end
      else
        self.ui.text_goto:SetIndex(0)
      end
    elseif condition == proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank then
      self.ui.obj_Equipped:SetActive(true)
      self.ui.tex_EquipInfo:SetIndex(3)
    elseif condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Gift then
      self.ui.btn_Goto.gameObject:SetActive(true)
      self.ui.text_goto:SetIndex(2)
    else
      self.ui.obj_Equipped:SetActive(true)
      self.ui.tex_EquipInfo:SetIndex(2)
    end
  else
    self.ui.obj_Equipped:SetActive(true)
    self.ui.tex_EquipInfo:SetIndex(2)
  end
  if self._banJump then
    self.ui.btn_Goto.gameObject:SetActive(false)
  end
end

function UIHeroSkin:_ShowSkinUpgrade(skinId)
  local skinData = PlayerDataCenter.skinData
  local isShow = skinData:IsSkinCanUpgrade(skinId) and skinData:IsInSkinUpgradeTimeRange(skinId)
  self.ui.btn_SkinUpgrade.gameObject:SetActive(isShow)
  if isShow then
    local costId, costNum = PlayerDataCenter.skinData:GetSkinUpgradeCost(skinId)
    local priceItem = ConfigData.item[costId]
    self.ui.img_UpCostIcon.sprite = CRH:GetSprite(priceItem.small_icon)
    self.ui.tex_UpPrice.text = tostring(costNum)
  end
end

function UIHeroSkin:LoadViewRes(moveDir)
  if self._heroNodeTween ~= nil then
    self._heroNodeTween:Kill()
    self._heroNodeTween = nil
  end
  if self.moveSeq ~= nil then
    self.moveSeq:Kill(true)
    self.moveSeq = nil
  end
  self.ui.heroNode.transform.localPosition = self.oriHeroNodePos
  self.ui.picHolder.transform.localPosition = self.oriPicHolderPos
  self.ui.heroFade.transform.localPosition = self.oriHeroFadePos
  self._isInPreview = false
  local item = self.skinPool.listItem[self.curIndex]
  local resModel = item.resModelCfg
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  local curMoveDir
  curMoveDir = moveDir == nil and eMoveDir.Right or moveDir
  local resPath = PathConsts:GetCharacterLive2DPath(resModel.src_id_pic, self._fromWhere)
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
  item:GetIsItemShowOutline(function(isShowSkinOutline, replaceSkinRes)
    local live2dLevel = item:GetItemLive2dLevel()
    local isHaveL2D = 0 < live2dLevel and not isShowSkinOutline
    if isHaveL2D then
      if self.ui.tog_Live2D.isOn then
        local skinCfg = item.skinCfg
        self:__TryLoadLive2D(skinCfg, resModel, curMoveDir)
      else
        self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic, self._fromWhere), curMoveDir)
      end
    else
      local picResPath
      if isShowSkinOutline then
        picResPath = PathConsts:GetCharacterBigImgPrefabPath(replaceSkinRes, self._fromWhere)
      else
        picResPath = PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic, self._fromWhere)
      end
      self:__LoadPic(picResPath, curMoveDir, isShowSkinOutline)
    end
  end)
end

function UIHeroSkin:__TryLoadLive2D(skinCfg, resModel, curMoveDir, IsShowSkinOutline)
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local skinId = skinCfg.id
  local isHasSkin = skinCfg.isdefault_skin or PlayerDataCenter.skinData:IsHaveSkin(skinId)
  if not isHasSkin and not PlayerDataCenter.skinData:IsSkinL2dCouldShow(skinId) then
    local picPath = PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic, self._fromWhere)
    self:__LoadPic(picPath, curMoveDir, IsShowSkinOutline)
  else
    local l2dPath = PathConsts:GetCharacterLive2DPath(resModel.src_id_pic, self._fromWhere)
    self:__LoadLive2D(l2dPath, curMoveDir)
  end
end

function UIHeroSkin:__LoadLive2D(path, curMoveDir)
  self.ui.heroFade.alpha = 0
  self.Live2DResloader = CS.ResLoader.Create()
  self.Live2DResloader:LoadABAssetAsync(path, function(l2dModelAsset)
    if IsNull(self.transform) or IsNull(l2dModelAsset) then
      return
    end
    self.l2dModelIns = l2dModelAsset:Instantiate(self.ui.heroFade.transform)
    self.l2dModelIns.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.l2dModelIns.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = self.heroId
      local skinId = self.skinIds[self.curIndex]
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:SetInterationOpenWait(false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroFade, 1, true)
      self.heroCubismInteration:SetL2DPosType("HeroSkin", false)
    end
    self.l2dBinding = {}
    UIUtil.LuaUIBindingTable(self.l2dModelIns, self.l2dBinding)
    self:_MoveHeroHolderTween(self.ui.heroFade, curMoveDir)
  end)
end

function UIHeroSkin:__LoadPic(path, curMoveDir, IsShowSkinOutline)
  self.ui.picFade.alpha = 0
  self.bigImgResloader = CS.ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or IsNull(self.transform) then
      return
    end
    self.bigImgGameObject = prefab:Instantiate(self.ui.picHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
    self:_MoveHeroHolderTween(self.ui.picFade, curMoveDir)
    local rawImage = self.bigImgGameObject:FindComponent(eUnityComponentID.RawImage)
    if rawImage ~= nil then
      if IsShowSkinOutline then
        rawImage.color = PlayerDataCenter.skinData.outlineColor
      else
        rawImage.color = Color.white
      end
    end
  end)
end

function UIHeroSkin:RefreshHaveCount()
  local countMax = #self.skinPool.listItem
  local countHave = 0
  for _, item in pairs(self.skinPool.listItem) do
    if item.skinCfg == nil or item.skinCfg.isdefault_skin or PlayerDataCenter.skinData:IsHaveSkin(item.skinCfg.id) then
      countHave = countHave + 1
    end
  end
  self.ui.tex_HasCount.text = tostring(countHave) .. "/" .. tostring(countMax)
end

function UIHeroSkin:OnClickLeft()
  if self.curIndex > 1 then
    self:SetItemChange(-1)
    self:Refresh(eMoveDir.Left)
  end
end

function UIHeroSkin:OnClickRight()
  if self.curIndex < #self.skinPool.listItem then
    self:SetItemChange(1)
    self:Refresh(eMoveDir.Right)
  end
end

function UIHeroSkin:OnClickSkinItem(item)
  if self.draging then
    return
  end
  local index = self:_GetIndexByItem(item)
  if (index or self.curIndex) ~= self.curIndex then
    local diff = index - self.curIndex
    self:SetItemChange(diff)
    self:Refresh(0 < diff)
    AudioManager:PlayAudioById(1111)
  end
  self:LocationHighLightSkinItem()
end

function UIHeroSkin:LocationHighLightSkinItem()
  CS.UnityEngine.Canvas.ForceUpdateCanvases()
  local scrollWidth = self.ui.skinScroll.transform.rect.width
  local rectWidth = self.ui.skinScroll.content.rect.width
  local overRectIndex = math.floor(scrollWidth / (rectWidth / #self.skinPool.listItem))
  if overRectIndex >= self.curIndex then
    self.ui.skinScroll.horizontalNormalizedPosition = 0
  else
    local allOverCount = #self.skinPool.listItem - overRectIndex
    local overCount = self.curIndex - overRectIndex
    self.ui.skinScroll.horizontalNormalizedPosition = overCount / allOverCount
  end
end

function UIHeroSkin:OnClickBuy()
  if self._isInPreview then
    return
  end
  local item = self.skinPool.listItem[self.curIndex]
  local shopGoodsData = item.shopGoodsData
  local resIds = {}
  table.insert(resIds, shopGoodsData.currencyId)
  if not table.contain(resIds, ConstGlobalItem.PaidItem) and (shopGoodsData.currencyId == ConstGlobalItem.PaidSubItem or shopGoodsData.currencyId == ConstGlobalItem.SkinTicket) then
    table.insert(resIds, 1, ConstGlobalItem.PaidItem)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(window)
    window:SlideIn()
    window:InitBuyFixedCountGood(1, shopGoodsData, true, resIds, function()
      for _, skinItem in ipairs(self.skinPool.listItem) do
        local shopId, shelfId = skinItem:TryGetShopGoodsId()
        if shopId == shopGoodsData.shopId and shelfId == shopGoodsData.shelfId then
          skinItem:RefreshHeroSkinItem()
          break
        end
      end
      self:RefreshState()
      self:RefreshHaveCount()
      if self.buyCallback ~= nil then
        self.buyCallback()
      end
    end)
  end)
end

function UIHeroSkin:OnClickPreview3DSkin()
  local showCharacterSkinCtrl = ControllerManager:GetController(ControllerTypeId.ShowCharacterSkin, true)
  local heroId = self:GetHeroId()
  local skinId = self:GetCurrentSkinId()
  showCharacterSkinCtrl:InitShowCharacterSkinCtrl(heroId, skinId, nil, nil)
end

function UIHeroSkin:OnClickGoto()
  if self._isInPreview then
    return
  end
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  if (skinCfg.jumpId or 0) == 0 and skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active] ~= nil then
    local actData = skinCtrl:GetActFrameDataBySkinCfg(skinCfg)
    if actData ~= nil then
      local frameId = actData:GetActivityFrameId()
      JumpManager:Jump(JumpManager.eJumpTarget.DynActivity, nil, nil, {frameId})
    end
  elseif skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Gift] ~= nil then
    local giftInfo = skinCtrl:GetGiftBySkinCfg(skinCfg)
    if giftInfo ~= nil then
      local jumpParam = skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Gift]
      JumpManager:Jump(JumpManager.eJumpTarget.DynShop, nil, nil, {
        ConfigData.pay_gift_type[jumpParam[1]].inShop,
        jumpParam[1]
      })
    end
  else
    JumpManager:Jump(skinCfg.jumpId)
  end
end

function UIHeroSkin:_OnClickSkinUpgrade()
  UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
    if win == nil then
      return
    end
    win:SlideIn()
    local item = self.skinPool.listItem[self.curIndex]
    local skinCfg = item.skinCfg
    win:InitSkinUpgradePurchase(skinCfg.id, function()
      item:RefreshHeroSkinItem()
      self:Refresh()
    end)
  end)
end

function UIHeroSkin:OnClickUse()
  if self._isInPreview then
    return
  end
  if self.curIndex == self.usingIndex then
    return
  end
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  local callback = BindCallback(self, self.ClickHeroSkinUseCallback)
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  skinCtrl:HeroSkinChange(self.heroId, skinCfg, callback)
end

function UIHeroSkin:ClickHeroSkinUseCallback()
  self.usingIndex = self.curIndex
  self:RefreshState()
end

function UIHeroSkin:OnChangeLive2dValue(flag)
  if self._isInPreview then
    return
  end
  if not self.isLive2dTogValid then
    return
  end
  local item = self.skinPool.listItem[self.curIndex]
  PlayerDataCenter.skinData:RecordLive2dSwitchState(item.heroCfg.id, item.skinCfg ~= nil and item.skinCfg.id or 0, flag)
  self:LoadViewRes()
  if flag then
    self.ui.ani_Tog:DOPlayBackwards()
  else
    self.ui.ani_Tog:DOPlayForward()
  end
end

function UIHeroSkin:OnClickViewHero()
  if self._isInPreview then
    return
  end
  self._isInPreview = true
  self.ui.normalNode:SetActive(false)
  self.ui.viewNode:SetActive(true)
  AudioManager:PlayAudioById(1061)
  UIUtil.HideTopStatus()
  if self._heroNodeTween ~= nil then
    self._heroNodeTween:Kill()
    self._heroNodeTween = nil
  end
  self:CalcaluteDragLimit()
  self._heroNodeTween = self.ui.heroNode.transform:DOLocalMove(Vector3.New(0, 0, 0), 0.5)
  self._heroNodeTween:OnComplete(function()
    self._heroNodeTween:Kill()
    self._heroNodeTween = nil
  end)
  CS_LeanTouch.OnGesture("+", self.__OnGesture)
end

function UIHeroSkin:OnClickViewReturn()
  self.ui.normalNode:SetActive(true)
  self.ui.viewNode:SetActive(false)
  AudioManager:PlayAudioById(1111)
  UIUtil.ReShowTopStatus()
  if self._heroNodeTween ~= nil then
    self._heroNodeTween:Kill()
    self._heroNodeTween = nil
  end
  self._heroNodeTween = cs_DoTween.Sequence()
  self._heroNodeTween:Insert(0, self.ui.heroNode.transform:DOLocalMove(self.oriHeroNodePos, 0.5))
  self._heroNodeTween:Insert(0, self.ui.picHolder.transform:DOLocalMove(self.oriPicHolderPos, 0.5))
  self._heroNodeTween:Insert(0, self.ui.heroFade.transform:DOLocalMove(self.oriHeroFadePos, 0.5))
  self._heroNodeTween:Insert(0, self.ui.picHolder.transform:DOScale(Vector3.New(1, 1, 1), 0.5))
  self._heroNodeTween:Insert(0, self.ui.heroFade.transform:DOScale(Vector3.New(1, 1, 1), 0.5))
  self._heroNodeTween:OnComplete(function()
    self._heroNodeTween:Kill()
    self._heroNodeTween = nil
    self._isInPreview = false
  end)
  CS_LeanTouch.OnGesture("-", self.__OnGesture)
end

function UIHeroSkin:OnClickAVGCharDun()
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  if not string.IsNullOrEmpty(skinCfg.skin_avg) then
    ControllerManager:GetController(ControllerTypeId.Avg, true):ShowAvg(skinCfg.skin_avg, showWindowFunc)
  end
end

function UIHeroSkin:OnClickOpenSkinVoice()
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  if skinCfg.has_voice then
    local function openVoiceNodeFunc()
      local heroStateWindow = UIManager:GetWindow(UIWindowTypeID.HeroState)
      
      heroStateWindow:OpenHeroInformation(function(window)
        if window ~= nil then
          window:SwitchTog(window.eNodeType.voice)
          local voiceNode = window.nodeDic[window.eNodeType.voice]
          local skinId = skinCfg.id
          local index = voiceNode:GetSkinVoiceIndexBySkinId(skinId)
          voiceNode:SelectSkinVoice(skinId, index)
        end
      end)
    end
    
    UIUtil.OnClickBackByUiTab(self)
    local heroStateWindow = UIManager:GetWindow(UIWindowTypeID.HeroState)
    if heroStateWindow ~= nil then
      openVoiceNodeFunc()
    else
      do
        local heroId = self:GetHeroId()
        JumpManager:Jump(JumpManager.eJumpTarget.Hero, nil, function()
          local win = UIManager:GetWindow(UIWindowTypeID.HeroList)
          if win ~= nil then
            local heroData = PlayerDataCenter:GetHeroData(heroId)
            win:Roll2Hero(heroData.dataId)
            win:OnSelHeroItemClick(heroData, nil, function()
              openVoiceNodeFunc()
            end)
          end
        end, nil, true)
      end
    end
  end
end

function UIHeroSkin:OnPayGiftCondition()
  if self._bpGiftId == nil or self._bpGiftId == 0 then
    return
  end
  self:__RefreshBpSkinGift(self._bpGiftId)
end

function UIHeroSkin:__RefreshBpSkinGift(bpSkinGift)
  local existPriorityGift = ShopUtil.ExistShopPriorityGift(self._bpSkinShopId)
  self.ui.obj_BpSkinGiftTag:SetActive(existPriorityGift)
  local showBpGift = false
  self._bpGiftId = 0
  if 0 < bpSkinGift then
    local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
    if payGiftCtrl ~= nil then
      local giftInfo = payGiftCtrl:GetPayGiftDataById(bpSkinGift)
      if giftInfo ~= nil and giftInfo:IsUnlock() then
        showBpGift = true
        self._bpGiftId = bpSkinGift
      end
    end
  end
  self.ui.btn_BpSkinGift.gameObject:SetActive(showBpGift)
end

function UIHeroSkin:OnClickBpSKinGift()
  if self._bpGiftId == nil then
    return
  end
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  if payGiftCtrl == nil then
    return
  end
  local giftId = self._bpGiftId
  if ShopUtil.ExistShopPriorityGift(self._bpSkinShopId) then
    local priorityGiftId = ShopUtil.GetShopPriorityGiftId(self._bpSkinShopId)
    giftId = priorityGiftId
  end
  local giftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
  if giftInfo ~= nil and giftInfo:IsUnlock() then
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(window)
      window:SlideIn()
      window:InitBuyPayGift(giftInfo)
    end)
  end
end

function UIHeroSkin:CalcaluteDragLimit(isInDrag)
  if not IsNull(self.bigImgGameObject) then
    if isInDrag and self._viewScaleRecord == self.ui.picHolder.transform.localScale.y then
      return
    end
    self._viewScaleRecord = self.ui.picHolder.transform.localScale.y
    if not isInDrag or self._bigImgGameObjectHeight == nil then
      local rectTr = self.bigImgGameObject.transform
      self._bigImgGameObjectHeight = rectTr.rect.height * rectTr.localScale.y
      self._bigImgGameObjectWidth = rectTr.rect.width * rectTr.localScale.x
    end
    local limitYMin = (-self._bigImgGameObjectHeight / 2 - self.bigImgGameObject.transform.localPosition.y) * self._viewScaleRecord
    local limitYMax = (self._bigImgGameObjectHeight / 2 - self.bigImgGameObject.transform.localPosition.y) * self._viewScaleRecord
    local limitXMax = (self._bigImgGameObjectWidth / 2 - self.bigImgGameObject.transform.localPosition.x) * self._viewScaleRecord
    local limitXMin = (-self._bigImgGameObjectWidth / 2 - self.bigImgGameObject.transform.localPosition.x) * self._viewScaleRecord
    if self._heroDragPosLimit == nil then
      self._heroDragPosLimit = {}
    end
    self._heroDragPosLimit.xMin = limitXMin
    self._heroDragPosLimit.xMax = limitXMax
    self._heroDragPosLimit.yMax = limitYMax
    self._heroDragPosLimit.yMin = limitYMin
  elseif not IsNull(self.l2dBinding) then
    if isInDrag and self._viewScaleRecord == self.ui.heroFade.transform.localScale.y then
      return
    end
    self._viewScaleRecord = self.ui.heroFade.transform.localScale.y
    if not isInDrag or self._l2dModelHeight == nil then
      local leftUp, rightBottom = GetL2dBorderVec(self.l2dModelIns)
      local inverseleftUp = self.l2dModelIns.transform:TransformPoint(leftUp)
      inverseleftUp = self.ui.heroFade.transform:InverseTransformPoint(inverseleftUp)
      local inverserightBottom = self.l2dModelIns.transform:TransformPoint(rightBottom)
      inverserightBottom = self.ui.heroFade.transform.parent:InverseTransformPoint(inverserightBottom)
      self._l2dModelHeight = inverseleftUp.y - inverserightBottom.y
      self._l2dModelWidth = inverserightBottom.x - inverseleftUp.x
      self._l2dCenterRatio = Vector2.New(-leftUp.x / (rightBottom.x - leftUp.x), leftUp.y / (leftUp.y - rightBottom.y))
    end
    local limitYMin = (-self._l2dModelHeight * self._l2dCenterRatio.y - self.l2dModelIns.transform.localPosition.y) * self._viewScaleRecord
    local limitYMax = (self._l2dModelHeight * (1 - self._l2dCenterRatio.y) - self.l2dModelIns.transform.localPosition.y) * self._viewScaleRecord
    local limitXMax = (self._l2dModelWidth * self._l2dCenterRatio.x - self.l2dModelIns.transform.localPosition.x) * self._viewScaleRecord
    local limitXMin = (-self._l2dModelWidth * (1 - self._l2dCenterRatio.x) - self.l2dModelIns.transform.localPosition.x) * self._viewScaleRecord
    if self._heroDragPosLimit == nil then
      self._heroDragPosLimit = {}
    end
    self._heroDragPosLimit.xMin = limitXMin
    self._heroDragPosLimit.xMax = limitXMax
    self._heroDragPosLimit.yMax = limitYMax
    self._heroDragPosLimit.yMin = limitYMin
  end
end

function UIHeroSkin:LimitDragPos(targetPos)
  targetPos.x = math.clamp(targetPos.x, self._heroDragPosLimit.xMin, self._heroDragPosLimit.xMax)
  targetPos.y = math.clamp(targetPos.y, self._heroDragPosLimit.yMin, self._heroDragPosLimit.yMax)
end

function UIHeroSkin:OnReturn()
  if self.l2dBinding ~= nil then
    self.l2dBinding.renderController.uiCanvasGroup = self.ui.canvasGroup
  end
  self.ui.frameAni:DOPlayBackwards()
  if 0 < waitRecorverNUM then
    self:Hide()
  else
    self:OnCloseWin()
    self:Delete()
  end
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
end

function UIHeroSkin:SetItemChange(num)
  self.skinPool.listItem[self.curIndex]:SetSelectState(false)
  self.curIndex = self.curIndex + num
  self.skinPool.listItem[self.curIndex]:SetSelectState(true)
end

function UIHeroSkin:_GetIndexByItem(item)
  local index
  for i, v in ipairs(self.skinPool.listItem) do
    if v == item then
      return i
    end
  end
  return nil
end

function UIHeroSkin:_RefreshCol(heroId)
  local rare = 1
  if PlayerDataCenter.heroDic[heroId] ~= nil then
    rare = PlayerDataCenter.heroDic[heroId].rare
  else
    local heroCfg = ConfigData.hero_data[heroId]
    local rankCfg = ConfigData.hero_rank[heroCfg.rank]
    rare = rankCfg.rare
  end
  self:_RefreshColsTween(HeroRareColor[rare])
end

function UIHeroSkin:_RefreshColsTween(endColor)
  if self.endColor == nil then
    self.endColor = endColor
    for index, image in ipairs(self.ui.arr_cols) do
      image.color = endColor
    end
  else
    if self.cloSeq ~= nil then
      self.cloSeq:Kill()
      self.cloSeq = nil
    end
    local cloSeq = cs_DoTween.Sequence()
    for index, image in ipairs(self.ui.arr_cols) do
      cloSeq:Insert(0, image:DOColor(endColor, 0.3))
    end
    self.cloSeq = cloSeq
  end
end

function UIHeroSkin:_MoveHeroHolderTween(canvasGroup, curMoveDir)
  if self.moveSeq ~= nil then
    self.moveSeq:Kill(true)
    self.moveSeq = nil
  end
  local moveSeq = cs_DoTween.Sequence()
  moveSeq:Append(canvasGroup:DOFade(1, 0.35))
  local transform = canvasGroup.transform
  local pos = transform.localPosition
  local moveX = 404
  if curMoveDir == eMoveDir.Left then
    transform.localPosition = Vector3.New(pos.x - moveX, pos.y, pos.z)
    moveSeq:Join(canvasGroup.transform:DOLocalMoveX(moveX, 0.45):SetRelative(true))
  else
    transform.localPosition = Vector3.New(pos.x + moveX, pos.y, pos.z)
    moveSeq:Join(canvasGroup.transform:DOLocalMoveX(-moveX, 0.45):SetRelative(true))
  end
  self.moveSeq = moveSeq
end

function UIHeroSkin:OnGesture(fingerList)
  if fingerList.Count == 0 then
    return
  end
  local result = CS_LeanTouch.RaycastGui(fingerList[0].ScreenPosition)
  if result.Count == 0 or not result[0].gameObject.transform:IsChildOf(self.transform) then
    return
  end
  if self._heroNodeTween ~= nil then
    return
  end
  if fingerList.Count == 1 then
    local touch = fingerList[0]
    local lastPos = UIManager:Screen2UIPosition(touch.LastScreenPosition, self.transform.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform)), UIManager.UICamera)
    local curPos = UIManager:Screen2UIPosition(touch.ScreenPosition, self.transform.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform)), UIManager.UICamera)
    local diffPos = curPos - lastPos
    diffPos = Vector3.New(diffPos.x, diffPos.y, 0)
    if self._heroDragPosLimit == nil then
      self:CalcaluteDragLimit()
    end
    local targetPos = self.ui.picHolder.transform.localPosition + diffPos
    self:LimitDragPos(targetPos)
    self.ui.picHolder.transform.localPosition = targetPos
    self.ui.heroFade.transform.localPosition = targetPos
  elseif fingerList.Count == 2 then
    local touch1 = fingerList[0]
    local touch2 = fingerList[1]
    local lastDiffX = touch1.LastScreenPosition.x - touch2.LastScreenPosition.x
    local lastDiffY = touch1.LastScreenPosition.y - touch2.LastScreenPosition.y
    local curDiffX = touch1.ScreenPosition.x - touch2.ScreenPosition.x
    local curDiffY = touch1.ScreenPosition.y - touch2.ScreenPosition.y
    local diff = Mathf.Sqrt(Mathf.Pow(curDiffX, 2) + Mathf.Pow(curDiffY, 2)) - Mathf.Sqrt(Mathf.Pow(lastDiffX, 2) + Mathf.Pow(lastDiffY, 2))
    local scale = self.ui.picHolder.transform.localScale.x + diff / 500 * (heroDragScaleLimit.max - heroDragScaleLimit.min)
    scale = math.clamp(scale, heroDragScaleLimit.min, heroDragScaleLimit.max)
    self.ui.picHolder.transform.localScale = Vector3.New(scale, scale, scale)
    self.ui.heroFade.transform.localScale = Vector3.New(scale, scale, scale)
    self:CalcaluteDragLimit(true)
    local targetPos = self.ui.picHolder.transform.localPosition
    self:LimitDragPos(targetPos)
    self.ui.picHolder.transform.localPosition = targetPos
    self.ui.heroFade.transform.localPosition = targetPos
  end
end

function UIHeroSkin:GenCoverJumpReturnCallback()
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
  waitRecorverNUM = waitRecorverNUM + 1
  return function()
    self:_ResetData()
    for key, value in pairs(dataTable) do
      self[key] = value
    end
    if self.__isHeroList then
      self:InitSkin(self.heroId, self.changeCallback, self.heroDataList, self.closeCallback, true)
    else
      self:InitSkinBySkinList(nil, self.skinIds, self.buyCallback, self.closeCallback, true)
    end
    self.curIndex = dataTable.curIndex
    self:Show()
    self:InitView()
    waitRecorverNUM = waitRecorverNUM - 1
  end
end

function UIHeroSkin:Try2StartSkinTimer()
  self:OnSkinTimerEnd()
  self:__OnSkinTimer()
  self.skinTimer = TimerManager:StartTimer(1, self.__OnSkinTimer, self)
end

function UIHeroSkin:__OnSkinTimer()
  local skinData = PlayerDataCenter.skinData
  local canUpgrade = 0
  local skinLimitNum = 0
  for _, skinItem in ipairs(self.skinPool.listItem) do
    local skinCfg = skinItem.skinCfg
    skinItem:UpdateSkinUpgrade()
    skinItem:UpdateSkinLimitTime()
    if skinData:IsSkinCanUpgrade(skinCfg.id) and skinData:IsInSkinUpgradeTimeRange(skinCfg.id) then
      canUpgrade = canUpgrade + 1
    end
    if skinData:IsHaveSkinLimit(skinCfg.id) then
      skinLimitNum = skinLimitNum + 1
    end
  end
  local showItem = self.skinPool.listItem[self.curIndex]
  self:_ShowSkinUpgrade(showItem.skinCfg.id)
  if canUpgrade < 1 and skinLimitNum < 1 then
    self:OnSkinTimerEnd()
  end
end

function UIHeroSkin:OnSkinTimerEnd()
  if self.skinTimer ~= nil then
    TimerManager:StopTimer(self.skinTimer)
    self.skinTimer = nil
  end
end

function UIHeroSkin:OnHeroSkinLimitTimeOut()
  self.usingIndex = 1
  self:RefreshState()
end

function UIHeroSkin:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnUpdateHero)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHeroSkin, self.__OnUpdateHeroSkin)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinUpgrade, self.__OnUpdateHeroSkin)
  MsgCenter:RemoveListener(eMsgEventId.PayGiftItemPreConfition, self.__OnPayGiftCondition)
  MsgCenter:RemoveListener(eMsgEventId.PayGiftChange, self.__OnPayGiftCondition)
  MsgCenter:RemoveListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnHeroSkinLimitTimeOut)
  if self.pageSequence ~= nil then
    self.pageSequence:Kill(true)
    self.pageSequence = nil
  end
  if self.cloSeq ~= nil then
    self.cloSeq:Kill()
    self.cloSeq = nil
  end
  if self.moveSeq ~= nil then
    self.moveSeq:Kill()
    self.moveSeq = nil
  end
  if self._heroNodeTween ~= nil then
    self._heroNodeTween:Kill()
    self._heroNodeTween = nil
  end
  self.ui.frameAni:DOKill()
  if self._isInPreview then
    self._isInPreview = false
    CS_LeanTouch.OnGesture("-", self.__OnGesture)
  end
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
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  self:OnSkinTimerEnd()
  base.OnDelete(self)
end

function UIHeroSkin:OnDeleteEntity()
  if self._isInPreview then
    self._isInPreview = false
    CS_LeanTouch.OnGesture("-", self.__OnGesture)
  end
  if self.resLoader then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
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
  self.skinPool:DeleteAll()
  base.OnDeleteEntity(self)
end

function UIHeroSkin:OnHide()
  if not not IsNull(self.__commonBlackMat) then
    DestroyUnityObject(self.__commonBlackMat)
    self.__commonBlackMat = nil
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  base.OnHide(self)
end

function UIHeroSkin:CloseTween(resloader)
  if self.ui.canvasGroup ~= nil then
    self.ui.canvasGroup.interactable = false
  end
  base.CloseTween(self, resloader)
end

return UIHeroSkin
