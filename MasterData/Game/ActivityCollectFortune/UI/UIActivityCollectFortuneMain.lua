local UIActivityCollectFortuneMain = class("UIActivityCollectFortuneMain", UIBaseWindow)
local base = UIBaseWindow
local UINActivityCollectFortuneDonateNode = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneDonateNode")
local UINActivityCollectFortuneGiftLotteryNode = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneGiftLotteryNode")
local UINActivityCollectFortuneItem = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneItem")
local UINActivityCollectFortuneDownNode = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneDownNode")
local SkinEnum = require("Game.Skin.SkinEnum")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroL2dInterationController = require("Game.Hero.Live2D.HeroL2dInterationController")
local ActivityCollectFortuneEnum = require("Game.ActivityCollectFortune.Data.ActivityCollectFortuneEnum")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon

function UIActivityCollectFortuneMain:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickBack)
  self._itemListPool = UIItemPool.New(UINActivityCollectFortuneItem, self.ui.Item)
  self.ui.Item:SetActive(false)
  self.__OnClickBtnReturn = BindCallback(self, self.OnClickBtnReturn)
  self.OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.OnItemChangeFunc)
  self.OnFriendListChanged = BindCallback(self, self.__OnFriendListChanged)
  MsgCenter:AddListener(eMsgEventId.OnUserFriendListChange, self.OnFriendListChanged)
  UIUtil.AddButtonListener(self.ui.Btn_Donate, self, self.OnClickBtnDonate)
  UIUtil.AddButtonListener(self.ui.Btn_Get, self, self.OnClickBtnGet)
  UIUtil.AddButtonListener(self.ui.Btn_Reward, self, self.OnClickBtnReward)
  UIUtil.AddButtonListener(self.ui.Btn_Task, self, self.OnClickBtnTask)
  UIUtil.AddButtonListener(self.ui.Btn_Open, self, self.OnClickBtnDraw)
  UIUtil.AddButtonListener(self.ui.Btn_Tips, self, self.OnClickBtnTips)
  self.oriHeroHolderPos = self.ui.HeroHolder.transform.localPosition
  self.oriPicHolderPos = self.ui.PicHolder.transform.localPosition
  self._fromWhere = SkinEnum.fromWhere.bp
  self.resloader = cs_ResLoader.Create()
  self._itemIdDic = {}
end

function UIActivityCollectFortuneMain:BindActTaskOnClickFunc(func)
  self._onClickTask = func
end

function UIActivityCollectFortuneMain:BindActTaskReddotRefreshFunc(func)
  self._taskReddotFunc = func
  self:RefreshCollectFortuneMainReddot()
end

function UIActivityCollectFortuneMain:BindReddotRefreshFunc(func)
  self._reddotRefreshFunc = func
end

function UIActivityCollectFortuneMain:InitCollectFortuneMain(actData, closeFunc)
  if actData == nil then
    return
  end
  self._actData = actData
  self._closeFunc = closeFunc
  if self._donateNode == nil then
    self._donateNode = UINActivityCollectFortuneDonateNode.New()
    self._donateNode:Init(self.ui.DonateNode)
  end
  if self._giftLotteryNode == nil then
    self._giftLotteryNode = UINActivityCollectFortuneGiftLotteryNode.New()
    self._giftLotteryNode:Init(self.ui.GiftGetNode)
  end
  if self._downNode == nil then
    self._downNode = UINActivityCollectFortuneDownNode.New()
    self._downNode:Init(self.ui.Down)
    self._downNode:ActCollectFortunrDN_Inite(self._actData, self.resloader)
  end
  self._actData:SetActCollectFortuneIsLooked()
  self:InitCollectFortuneMainUI()
  self:LoadCollectFortuneRes()
  self:RefreshCollectFortuneMainReddot()
end

function UIActivityCollectFortuneMain:InitCollectFortuneMainUI()
  local mainCfg = self._actData:GetActCollectFortuneMainCfg()
  if mainCfg == nil then
    error("cant find collect fortune config!!")
    return
  end
  self._itemListPool:HideAll()
  local itemIdListWithIndex = self._actData:GetActCollectFortuneItemIdListWithIndex()
  self._itemIdList = itemIdListWithIndex
  for index, idList in ipairs(itemIdListWithIndex) do
    local allCount = 0
    for _, id in ipairs(idList) do
      local count = PlayerDataCenter:GetItemCount(id)
      allCount = allCount + count
      self._itemIdDic[id] = true
    end
    local id = idList[1]
    local item = self._itemListPool:GetOne()
    item:InitCollectFortuneItem(index, id, allCount)
  end
  local startTime = self._actData:GetActivityBornTime()
  local destoryTime = self._actData:GetActivityDestroyTime()
  local startStr = TimeUtil:TimestampToDateString(startTime, nil, true)
  local destoryStr = TimeUtil:TimestampToDateString(destoryTime, nil, true)
  self.ui.Tex_Time.text = startStr .. " - " .. destoryStr
end

function UIActivityCollectFortuneMain:RefreshMainUIItemList()
  for index, idList in ipairs(self._itemIdList) do
    local allCount = 0
    for _, id in ipairs(idList) do
      local count = PlayerDataCenter:GetItemCount(id)
      allCount = allCount + count
    end
    local id = idList[1]
    local item = self._itemListPool.listItem[index]
    item:InitCollectFortuneItem(index, id, allCount)
  end
end

function UIActivityCollectFortuneMain:UpdateActCollectFortuneByDayPass()
  if self._donateNode and self._donateNode.activeSelf then
    self._donateNode:UpdateDonateNodeByDayPass()
  end
end

function UIActivityCollectFortuneMain:RefreshCollectFortuneMainReddot()
  if self.ui.GetRedDot then
    local isShowRedDot = self._actData:IsCanGetGift()
    self.ui.GetRedDot:SetActive(isShowRedDot)
  end
  if self.ui.TaskRedDot then
    local isShowRedDot = self._taskReddotFunc ~= nil and self._taskReddotFunc()
    self.ui.TaskRedDot:SetActive(isShowRedDot)
  end
end

function UIActivityCollectFortuneMain:LoadCollectFortuneRes()
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
  local mainCfg = self._actData:GetActCollectFortuneMainCfg()
  local live2dLevel = mainCfg.skin_type
  local isHaveL2D = 0 < live2dLevel
  local skinId = mainCfg.skin_id
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resModelCfg = skinCtrl:GetResModel(mainCfg.hero_id, skinId)
  if isHaveL2D then
    local skinCfg = ConfigData.skin[skinId]
    self:__TryLoadLive2D(skinCfg, resModelCfg)
  else
    self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModelCfg.src_id_pic, self._fromWhere))
  end
end

function UIActivityCollectFortuneMain:__TryLoadLive2D(skinCfg, resModel)
  if skinCfg == nil then
    error("skinCfg is nil!!")
    return
  end
  local skinId = skinCfg.id
  local live2dCfg = ConfigData.skin_live2d[skinId]
  local isHaveSkin = skinCfg.isdefault_skin or PlayerDataCenter.skinData:IsHaveSkin(skinId)
  local isHideHolight = PlayerDataCenter.skinData:IsHideHolight(skinId)
  local l2dPath = PathConsts:GetCharacterLive2DPath(resModel.src_id_pic, self._fromWhere)
  self:__LoadLive2D(l2dPath, isHideHolight)
end

function UIActivityCollectFortuneMain:__LoadLive2D(path, isHideHolight)
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
      local mainCfg = self._actData:GetActCollectFortuneMainCfg()
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = mainCfg.hero_id
      local skinId = mainCfg.skin_id
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
    local mainCfg = self._actData:GetActCollectFortuneMainCfg()
    local posData = mainCfg.BG_pos
    if posData ~= nil then
      self.l2dModelIns.transform.localPosition = Vector3.New(posData[1], posData[2], 0)
    end
  end)
end

function UIActivityCollectFortuneMain:__LoadPic(path, isShowSkinOutline)
  self.bigImgResloader = cs_ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or IsNull(self.transform) then
      return
    end
    self.bigImgObj = prefab:Instantiate(self.ui.PicHolder.transform)
    local commonPicCtrl = self.bigImgObj:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
    local mainCfg = self._actData:GetActCollectFortuneMainCfg()
    local posData = mainCfg.BG_pos
    if posData ~= nil then
      self.bigImgObj.transform.localPosition = Vector3.New(posData[1], posData[2], 0)
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

function UIActivityCollectFortuneMain:OnClickBtnDonate()
  if self._donateNode == nil then
    return
  end
  self._donateNode:InitActCollectFortuneDonateNode(self._actData, self.resloader)
  self._donateNode:BindCloseFunc(BindCallback(self, self.OnClickNodeBack))
  self.ui.DonateNode:SetActive(true)
end

function UIActivityCollectFortuneMain:OnClickBtnGet()
  if self._giftLotteryNode == nil then
    return
  end
  self._giftLotteryNode:InitActCollectFortuneGiftLotteryNode(self._actData, ActivityCollectFortuneEnum.eGiftLotteryNodeType.Gift, self.__OnClickBtnReturn, self.resloader)
  self._giftLotteryNode:BindCloseFunc(BindCallback(self, self.OnClickNodeBack))
  self.ui.GiftGetNode:SetActive(true)
end

function UIActivityCollectFortuneMain:OnClickBtnReward()
  if self._giftLotteryNode == nil then
    return
  end
  self._giftLotteryNode:InitActCollectFortuneGiftLotteryNode(self._actData, ActivityCollectFortuneEnum.eGiftLotteryNodeType.Lottery)
  self._giftLotteryNode:BindCloseFunc(BindCallback(self, self.OnClickNodeBack))
  self.ui.GiftGetNode:SetActive(true)
end

function UIActivityCollectFortuneMain:OnClickBtnTask()
  if self._onClickTask ~= nil then
    self._onClickTask(true)
  end
end

function UIActivityCollectFortuneMain:OnClickBtnDraw()
  local networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityCollectFortune)
  if networkCtrl then
    local isCouldeDraw, itemTable = self._actData:GetActCollectFortuneIsCouldDraw()
    if not isCouldeDraw then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(50005))
      return
    end
    self._downNode:ActCollectFortunrDN_ShowDrawTween(function()
      networkCtrl:CS_ActCollectFortune_Draw(self._actData:GetActCollectFortuneActId(), itemTable, function()
        self._downNode:ActCollectFortunrDN_RefreshOpenBtnTween()
        if self._reddotRefreshFunc ~= nil then
          self._reddotRefreshFunc()
        end
      end)
    end)
  end
end

function UIActivityCollectFortuneMain:OnClickBtnReturn()
  if self._giftLotteryNode ~= nil and self._donateNode ~= nil then
    self._giftLotteryNode:OnClickBack()
    self:OnClickBtnDonate()
  end
end

function UIActivityCollectFortuneMain:OnClickBtnTips()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    local mainCfg = self._actData:GetActCollectFortuneMainCfg()
    local title = ConfigData:GetTipContent(mainCfg.rule_title)
    local tip = ConfigData:GetTipContent(mainCfg.rule_des)
    window:InitCommonInfo(tip, title)
  end)
end

function UIActivityCollectFortuneMain:OnClickNodeBack(go)
  go:SetActive(false)
  self:RefreshCollectFortuneMainReddot()
end

function UIActivityCollectFortuneMain:OnClickBack()
  if self._closeFunc ~= nil then
    self._closeFunc()
  end
  self:Delete()
end

function UIActivityCollectFortuneMain:__ItemUpdate(itemDic)
  local needUpdate = false
  for id, _ in pairs(self._itemIdDic) do
    if itemDic[id] ~= nil then
      needUpdate = true
    end
    if needUpdate then
      break
    end
  end
  if needUpdate then
    self:RefreshMainUIItemList()
    self._downNode:ActCollectFortunrDN_RefreshOpenBtnTween()
  end
end

function UIActivityCollectFortuneMain:__OnFriendListChanged()
  if self._donateNode ~= nil then
    self._donateNode:InitActCollectFortuneDonateFriendList()
  end
end

function UIActivityCollectFortuneMain:GenCoverJumpReturnCallback()
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
    self:InitCollectFortuneMainUI()
    self:LoadCollectFortuneRes()
  end
end

function UIActivityCollectFortuneMain:OnDeleteEntity()
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

function UIActivityCollectFortuneMain:OnDelete()
  self._donateNode:Delete()
  self._giftLotteryNode:Delete()
  self._downNode:Delete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.OnUserFriendListChange, self.OnFriendListChanged)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if not IsNull(self.bigImgObj) then
    DestroyUnityObject(self.bigImgObj)
  end
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  self._itemListPool:DeleteAll()
  base.OnDelete(self)
end

return UIActivityCollectFortuneMain
