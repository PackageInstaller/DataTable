local UIActivitySkinLimitMain = class("UIActivitySkinLimitMain", UIBaseWindow)
local base = UIBaseWindow
local UINHeroSkin = require("Game.Skin.UI.UINHeroSkin")
local SkinEnum = require("Game.Skin.SkinEnum")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroL2dInterationController = require("Game.Hero.Live2D.HeroL2dInterationController")
local eMoveDir = {Left = 1, Right = 2}

function UIActivitySkinLimitMain:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.resLoader = cs_ResLoader.Create()
  self.skinPool = UIItemPool.New(UINHeroSkin, self.ui.skinPreviewItem)
  self.ui.skinPreviewItem:SetActive(false)
  self.oriHeroHolderPos = self.ui.HeroHolder.transform.localPosition
  self.oriPicHolderPos = self.ui.PicHolder.transform.localPosition
  self._fromWhere = SkinEnum.fromWhere.bp
  UIUtil.AddButtonListener(self.ui.btn_getMore, self, self.__OnClickSkinLimitTask)
  UIUtil.AddButtonListener(self.ui.btn_buy, self, self.__OnClickSkinLimitExperience)
  UIUtil.AddButtonListener(self.ui.btn_use, self, self.__OnClickSkinLimitPreset)
  UIUtil.AddButtonListener(self.ui.btn_tip, self, self.__OnClickTip)
  UIUtil.AddButtonListener(self.ui.btn_ticket, self, self.__OnClickTicket)
  UIUtil.AddValueChangedListener(self.ui.tog_live2d, self, self.__OnChangeLive2dValue)
  self.__OnClickSkinItem = BindCallback(self, self.OnClickSkinItem)
  self.__RefreshSkinLimitView = BindCallback(self, self.RefreshSkinLimitView)
  self.__OnItemUpdate = BindCallback(self, self.OnItemUpdate)
  self.__OnGetSkinLimitTask = BindCallback(self, self.OnGetSkinLimitTask)
  self.__OnSkinLimitTimeOut = BindCallback(self, self.OnSkinLimitTimeOut)
  self.__OnSkinPresetBtnUpdate = BindCallback(self, self.OnSkinPresetBtnUpdate)
  self.__OnSkinLimitUpdateHeroSkin = BindCallback(self, self.OnSkinLimitUpdateHeroSkin)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnSkinLimitTimeOut)
  MsgCenter:AddListener(eMsgEventId.AdjCustomModify, self.__OnSkinPresetBtnUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateHeroSkin, self.__OnSkinLimitUpdateHeroSkin)
end

function UIActivitySkinLimitMain:InitSkinLimitMain(actId)
  local skinLimitCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySkinLimit)
  if skinLimitCtrl == nil then
    return
  end
  local skinLimitData = skinLimitCtrl:GetSkinLimitDataByActId(actId)
  if skinLimitData == nil then
    return
  end
  skinLimitData:SetSkinLimitLooked()
  self._skinLimitData = skinLimitData
  self._skinList = skinLimitData:GetSkinLimitSkinList()
  local activityCfg = ConfigData.activity[self._skinLimitData:GetActFrameId()]
  local actName = self._skinLimitData:GetSkinLimitActvityName()
  self.ui.text_title.text = LanguageUtil.GetLocaleText(actName)
  local startTimeStr1, startTimeStr2 = self._skinLimitData:GetSkinLimitStartTime()
  self.ui.text_startTime:SetIndex(0, startTimeStr1, startTimeStr2)
  local endTimeStr1, endTimeStr2 = self._skinLimitData:GetSkinLimitEndTime()
  self.ui.text_endTime:SetIndex(0, endTimeStr1, endTimeStr2)
  local freeItemId = ConstGlobalItem.SkinLimit
  local freeItemCfg = ConfigData.item[freeItemId]
  self.ui.img_ticketImg.sprite = CRH:GetSprite(freeItemCfg.small_icon)
  self.ui.img_icon.sprite = CRH:GetSprite(freeItemCfg.small_icon)
  self:InitSkinList()
  self:RefreshSkinLimitView()
  self:OnGetSkinLimitTask()
end

function UIActivitySkinLimitMain:RefreshSkinLimitView()
  self:RefreshSkinLimitMain()
  self:RefreshSkinLimitItem()
  self:RefreshSkinLimitShowTime()
  self:RefreshSkinLimitSkinList()
  self:RefreshSkinLimitButton()
  self:Try2StartTimer()
end

function UIActivitySkinLimitMain:InitSkinList()
  self.curIndex = 1
  self.skinPool:HideAll()
  local item
  for _, data in ipairs(self._skinList) do
    item = self.skinPool:GetOne(true)
    item.gameObject:SetActive(true)
    local skinCfg = ConfigData.skin[data.skin_id]
    local heroId = data.hero_id
    item:InitSkinItem(heroId, skinCfg, self.resLoader, self.__OnClickSkinItem, nil, self)
    item:HidePriceAndCutDown()
    item.transform:SetParent(self.ui.rect_skinList.transform)
  end
  for i = 1, #self.skinPool.listItem do
    item = self.skinPool.listItem[i]
    if i == self.curIndex then
      item:SetSelectState(true)
    else
      item:SetSelectState(false)
    end
  end
end

function UIActivitySkinLimitMain:Try2StartTimer()
  self:OnTimerFinish()
  local needTimer = false
  for i = 1, #self.skinPool.listItem do
    local item = self.skinPool.listItem[i]
    local haveSkinLimit = PlayerDataCenter.skinData:IsHaveSkinLimit(item.skinCfg.id)
    if haveSkinLimit then
      needTimer = true
      break
    end
  end
  if needTimer then
    self._timer = TimerManager:StartTimer(1, self.OnSkinLimitTimer, self)
    self:OnSkinLimitTimer()
  end
end

function UIActivitySkinLimitMain:OnSkinLimitTimer()
  self:RefreshSkinLimitShowTime()
  self:RefreshSkinLimitSkinList()
end

function UIActivitySkinLimitMain:OnTimerFinish()
  if self._timer ~= nil then
    TimerManager:StopTimer(self._timer)
    self._timer = nil
  end
  self:RefreshSkinLimitButton()
end

function UIActivitySkinLimitMain:RefreshSkinLimitMain()
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  local curData = self._skinList[self.curIndex]
  local live2d_level = curData.skin_type
  local isOpen = PlayerDataCenter.skinData:GetLive2dSwitchState(item.heroCfg.id, skinCfg ~= nil and skinCfg.id or 0)
  self.ui.tog_live2d.gameObject:SetActive(0 < live2d_level)
  if 0 < live2d_level then
    self.ui.text_live2d:SetIndex(live2d_level - 1)
  end
  self:LoadSkinLimitRes()
end

function UIActivitySkinLimitMain:RefreshSkinLimitSkinList()
  for i = 1, #self.skinPool.listItem do
    local item = self.skinPool.listItem[i]
    item:UpdateSkinLimitTime()
  end
end

function UIActivitySkinLimitMain:RefreshSkinLimitItem()
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  local freeItemId = ConstGlobalItem.SkinLimit
  local haveNum = PlayerDataCenter:GetItemCount(freeItemId)
  self.ui.text_ticketNum.text = haveNum
end

function UIActivitySkinLimitMain:RefreshSkinLimitButton()
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  local isHaveSkinLimit = PlayerDataCenter.skinData:IsHaveSkinLimit(skinCfg.id)
  local isHaveSkinPermanent = PlayerDataCenter.skinData:IsHaveSkinPermanent(skinCfg.id)
  local isHaveSkin = isHaveSkinLimit or isHaveSkinPermanent
  local haveNum = PlayerDataCenter:GetItemCount(ConstGlobalItem.SkinLimit)
  self.ui.btn_buy.gameObject:SetActive(not isHaveSkin)
  if not isHaveSkin then
    self.ui.text_buy:SetIndex((isHaveSkinPermanent or haveNum < 1) and 1 or 0)
  end
  local adjData = PlayerDataCenter.allAdjCustomData:GetAdjCustomPresetData(1)
  local canSetAdj = adjData == nil or adjData:GetAdjMainHeroSkinId() ~= skinCfg.id
  self.ui.obj_canUse:SetActive(isHaveSkin)
  if isHaveSkin then
    self.ui.text_use:SetIndex(not canSetAdj and 1 or 0)
  end
end

function UIActivitySkinLimitMain:RefreshSkinLimitShowTime()
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  local isHaveSkinLimit = PlayerDataCenter.skinData:IsHaveSkinLimit(skinCfg.id)
  self.ui.obj_expTime:SetActive(isHaveSkinLimit)
  if isHaveSkinLimit then
    local remaindTime = PlayerDataCenter.skinData:GetSkinLimitTime(skinCfg.id) - PlayerDataCenter.timestamp
    if remaindTime < 0 then
      remaindTime = 0
    end
    local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false)
    self.ui.text_expTime:SetIndex(0, string.format("%02d", h), string.format("%02d", m), string.format("%02d", s))
  end
end

function UIActivitySkinLimitMain:RefreshTaskRedDot()
  local isShowRedDot = self._skinLimitData:IsCanGetTask()
  self.ui.obj_taskRedDot:SetActive(isShowRedDot)
end

function UIActivitySkinLimitMain:LoadSkinLimitRes()
  local item = self.skinPool.listItem[self.curIndex]
  local curData = self._skinList[self.curIndex]
  local resModel = item.resModelCfg
  self.isLive2dTogValid = false
  item:GetIsItemShowOutline(function(isShowSkinOutline, replaceSkinRes)
    local live2dlevel = curData.skin_type
    local isHaveL2D = 0 < live2dlevel and not isShowSkinOutline
    if isHaveL2D then
      local skinCfg = item.skinCfg
      local isOpen = PlayerDataCenter.skinData:GetLive2dSwitchState(item.heroCfg.id, skinCfg ~= nil and skinCfg.id or 0)
      self.ui.tog_live2d.isOn = isOpen
      if isOpen then
        self.ui.ani_tog:DORewind()
      else
        self.ui.ani_tog:DOComplete()
      end
      self.isLive2dTogValid = true
    end
  end)
  self:LoadViewRes()
end

function UIActivitySkinLimitMain:LoadViewRes()
  self.ui.HeroHolder.transform.localPosition = self.oriHeroHolderPos
  self.ui.PicHolder.transform.localPosition = self.oriPicHolderPos
  local item = self.skinPool.listItem[self.curIndex]
  local curData = self._skinList[self.curIndex]
  local resModel = item.resModelCfg
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
  item:GetIsItemShowOutline(function(isShowSkinOutline, replaceSkinRes)
    local live2dlevel = curData.skin_type
    local isHaveL2D = 0 < live2dlevel and not isShowSkinOutline
    if isHaveL2D then
      local skinCfg = item.skinCfg
      if self.ui.tog_live2d.isOn then
        self:__TryLoadLive2D(skinCfg, resModel)
      else
        self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic, self._fromWhere))
      end
    else
      local picResPath
      if isShowSkinOutline then
        picResPath = PathConsts:GetCharacterBigImgPrefabPath(replaceSkinRes, self._fromWhere)
      else
        picResPath = PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic, self._fromWhere)
      end
      self:__LoadPic(picResPath, isShowSkinOutline)
    end
  end)
end

function UIActivitySkinLimitMain:__TryLoadLive2D(skinCfg, resModel, isShowSkinOutline)
  if skinCfg == nil then
    error("skinCfg is nil")
    return
  end
  local skinId = skinCfg.id
  local live2dCfg = ConfigData.skin_live2d[skinId]
  local isHaveSkin = skinCfg.isdefault_skin or PlayerDataCenter.skinData:IsHaveSkin(skinId)
  local isHideHolight = PlayerDataCenter.skinData:IsHideHolight(skinId)
  local l2dPath = PathConsts:GetCharacterLive2DPath(resModel.src_id_pic, self._fromWhere)
  self:__LoadLive2D(l2dPath, isHideHolight)
end

function UIActivitySkinLimitMain:__LoadLive2D(path, isHideHolight)
  self.ui.heroFade.alpha = 0
  self.Live2DResloader = cs_ResLoader.Create()
  self.Live2DResloader:LoadABAssetAsync(path, function(l2dModelAsset)
    if IsNull(self.transform) or IsNull(l2dModelAsset) then
      return
    end
    self.l2dModelIns = l2dModelAsset:Instantiate(self.ui.heroFade.transform)
    self.l2dModelIns.transform:SetLayer(LayerMask.UI)
    self.l2dBinding = {}
    UIUtil.LuaUIBindingTable(self.l2dModelIns, self.l2dBinding)
    local cs_CubismInterationController = self.l2dModelIns.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      local curData = self._skinList[self.curIndex]
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = curData.hero_id
      local skinId = curData.skin_id
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:SetInterationOpenWait(false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroFade, 1, true)
      self.heroCubismInteration:SetL2DPosType("HeroSkin", false)
    end
    self.l2dBinding.renderController.uiCanvasGroup = self.ui.heroFade
    self.l2dBinding.renderController.SortingLayer = "UINormal"
    self.l2dBinding.renderController.SortingOrder = 100
    self.l2dBinding.renderController.InfluencedByUICanvas = true
    HeroL2dInterationController.ActiveLive2dHolight(self.l2dBinding.renderController, not isHideHolight)
    local posData = self._skinLimitData:GetSkinDataPosList(self.curIndex)
    if posData ~= nil then
      self.l2dModelIns.transform.localPosition = Vector3.New(posData.live2dPosX, posData.live2dPosY, 0)
    end
    self:_MoveHeroHolderTween(self.ui.heroFade, eMoveDir.Right)
  end)
end

function UIActivitySkinLimitMain:__LoadPic(path, isShowSkinOutline)
  self.ui.picFade.alpha = 0
  self.bigImgResloader = cs_ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or IsNull(self.transform) then
      return
    end
    self.bigImgObj = prefab:Instantiate(self.ui.PicHolder.transform)
    local commonPicCtrl = self.bigImgObj:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
    local posData = self._skinLimitData:GetSkinDataPosList(self.curIndex)
    if posData ~= nil then
      self.bigImgObj.transform.anchoredPosition = Vector2.New(posData.bgPosX, posData.bgPosY)
    end
    self:_MoveHeroHolderTween(self.ui.picFade, eMoveDir.Right)
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

function UIActivitySkinLimitMain:OnClickSkinItem(item)
  local index = self:GetIndexByItem(item)
  if (index or self.curIndex) ~= self.curIndex then
    local diff = index - self.curIndex
    self:SetItemChange(diff)
    self:RefreshSkinLimitMain()
    self:RefreshSkinLimitButton()
    self:RefreshSkinLimitShowTime()
    AudioManager:PlayAudioById(1111)
  end
end

function UIActivitySkinLimitMain:__OnClickSkinLimitTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivitySkinLimitTask, function(window)
    if window == nil then
      return
    end
    local taskIds = ConfigData.activity_general[self._skinLimitData:GetActFrameId()].once_quest
    window:InitSkinLimitTask(taskIds, nil, self.__OnGetSkinLimitTask)
    window:SetEnvTaskTitle(ConfigData:GetTipContent(9711))
  end)
end

function UIActivitySkinLimitMain:__OnClickSkinLimitExperience()
  local skinLimitCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySkinLimit)
  if skinLimitCtrl == nil then
    return
  end
  local item = self.skinPool.listItem[self.curIndex]
  local skinCfg = item.skinCfg
  local limitData = self._skinList[self.curIndex]
  skinLimitCtrl:OnClickSkinLimitExperience(skinCfg, limitData, self.__RefreshSkinLimitView)
end

function UIActivitySkinLimitMain:__OnClickSkinLimitPreset()
  local skinLimitCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySkinLimit)
  if skinLimitCtrl == nil then
    return
  end
  local item = self.skinPool.listItem[self.curIndex]
  local heroId = item.heroCfg.id
  local skinCfg = item.skinCfg
  skinLimitCtrl:OnClickSkinLimitPreset(heroId, skinCfg)
end

function UIActivitySkinLimitMain:__OnClickTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(self._skinLimitData:GetSkinLimitActivityTip()), ConfigData:GetTipContent(9706))
  end)
end

function UIActivitySkinLimitMain:__OnClickTicket()
  local itemCfg = ConfigData.item[ConstGlobalItem.SkinLimit]
  if itemCfg == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:InitCommonItemDetail(itemCfg)
    end
  end)
end

function UIActivitySkinLimitMain:__OnChangeLive2dValue(flag)
  if not self.isLive2dTogValid then
    return
  end
  local item = self.skinPool.listItem[self.curIndex]
  PlayerDataCenter.skinData:RecordLive2dSwitchState(item.heroCfg.id, item.skinCfg ~= nil and item.skinCfg.id or 0, flag)
  self:LoadViewRes()
  if flag then
    self.ui.ani_tog:DOPlayBackwards()
  else
    self.ui.ani_tog:DOPlayForward()
  end
end

function UIActivitySkinLimitMain:OnItemUpdate(itemDic)
  if itemDic[ConstGlobalItem.SkinLimit] ~= nil then
    self:RefreshSkinLimitItem()
    self:RefreshSkinLimitButton()
  end
end

function UIActivitySkinLimitMain:OnGetSkinLimitTask()
  self._skinLimitData:__RefreshSkinLimitRedHasTask()
  self:RefreshTaskRedDot()
end

function UIActivitySkinLimitMain:OnSkinLimitTimeOut()
  self:RefreshSkinLimitButton()
  self:RefreshSkinLimitShowTime()
  self:RefreshSkinLimitSkinList()
  self:LoadSkinLimitRes()
  self:Try2StartTimer()
end

function UIActivitySkinLimitMain:OnSkinPresetBtnUpdate()
  self:RefreshSkinLimitButton()
end

function UIActivitySkinLimitMain:OnSkinLimitUpdateHeroSkin()
  for _, item in ipairs(self.skinPool.listItem) do
    item:TryReloadCtify(self.resLoader)
  end
end

function UIActivitySkinLimitMain:SetItemChange(num)
  self.skinPool.listItem[self.curIndex]:SetSelectState(false)
  self.curIndex = self.curIndex + num
  self.skinPool.listItem[self.curIndex]:SetSelectState(true)
end

function UIActivitySkinLimitMain:GetIndexByItem(item)
  for i, v in ipairs(self.skinPool.listItem) do
    if v == item then
      return i
    end
  end
  return nil
end

function UIActivitySkinLimitMain:GetSkinFromWhere()
  return self._fromWhere
end

function UIActivitySkinLimitMain:_MoveHeroHolderTween(canvasGroup, curMoveDir)
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

function UIActivitySkinLimitMain:GenCoverJumpReturnCallback()
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
    self.curIndex = dataTable.curIndex
    self:Show()
    self:RefreshSkinLimitView()
  end
end

function UIActivitySkinLimitMain:OnHide()
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

function UIActivitySkinLimitMain:__BackAction()
  self:OnCloseWin()
  self:Delete()
end

function UIActivitySkinLimitMain:OnDeleteEntity()
  if self.resLoader ~= nil then
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

function UIActivitySkinLimitMain:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.ActivitySkinLimitTask)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  MsgCenter:RemoveListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnSkinLimitTimeOut)
  MsgCenter:RemoveListener(eMsgEventId.AdjCustomModify, self.__OnSkinPresetBtnUpdate)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHeroSkin, self.__OnSkinLimitUpdateHeroSkin)
  if self._timer ~= nil then
    TimerManager:StopTimer(self._timer)
    self._timer = nil
  end
  if self.moveSeq ~= nil then
    self.moveSeq:Kill()
    self.moveSeq = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.skinList ~= nil then
    self.skinList:OnDelete()
  end
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

return UIActivitySkinLimitMain
