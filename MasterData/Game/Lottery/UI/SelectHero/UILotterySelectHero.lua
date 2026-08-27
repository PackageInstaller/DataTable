local UILotterySelectHero = class("UILotterySelectHero", UIBaseWindow)
local base = UIBaseWindow
local UINLtrSelectHeroItem = require("Game.Lottery.UI.SelectHero.UINLtrSelectHeroItem")
local UINLtrSkillItem = require("Game.Lottery.UI.SelectHero.UINLtrSkillItem")
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
local HeroInfoData = require("Game.Lottery.Data.HeroInfoData")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_EventTriggerListener = CS.EventTriggerListener
local cs_DoTween = CS.DG.Tweening.DOTween
local LotteryRtUtil = require("Game.Lottery.UI.LotteryRtUtil")

function UILotterySelectHero:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_HeroInfo, self, self.__OnClickHeroInfo)
  UIUtil.AddButtonListener(self.ui.btn_ShowCharacter, self, self.__OnClickShowCharacter)
  self.ui.heroItem:SetActive(false)
  self.heroItemPool = UIItemPool.New(UINLtrSelectHeroItem, self.ui.heroItem)
  self._OnSelectHeroFunc = BindCallback(self, self._OnSelectHero)
  self.resLoader = cs_ResLoader.Create()
  self.ui.img_star.gameObject:SetActive(false)
  self.StarList = {}
  self.heroHoderDefaultPosition = self.ui.heroHolder.transform.localPosition
end

function UILotterySelectHero:InitLotterySelectHero(ltrPoolData)
  self.ltrPoolData = ltrPoolData
  local heroIdList, heroId2ItemIdMapDic = ltrPoolData:GetLtrFreeChoiceHeroIdList()
  self.heroId2ItemIdMapDic = heroId2ItemIdMapDic
  self:_InitHeroList(heroIdList)
end

function UILotterySelectHero:InitPageChangeDrag(startDragFunc, endDragFunc)
  local pageChangeEventTrigger = cs_EventTriggerListener.Get(self.ui.dragPageChange)
  pageChangeEventTrigger:onBeginDrag("+", startDragFunc)
  pageChangeEventTrigger:onEndDrag("+", endDragFunc)
end

function UILotterySelectHero:_InitHeroList(heroIdList)
  self.heroIdList = heroIdList
  self.heroItemPool:HideAll()
  for k, heroId in ipairs(heroIdList) do
    local heroItem = self.heroItemPool:GetOne()
    heroItem:InitLtrSelectHeroItem(heroId, self._OnSelectHeroFunc, self.resLoader)
    local rowIndex = math.ceil(k / 4)
    if not IsNull(self.ui.heroRowList[rowIndex]) then
      heroItem.transform:SetParent(self.ui.heroRowList[rowIndex])
    end
  end
  local defalutId = self.heroItemPool.listItem[1].heroId
  self:_OnSelectHero(defalutId)
end

function UILotterySelectHero:__OnClickHeroInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfoState, function(win)
    if win == nil then
      return
    end
    win:InitHeroInfoState(self.selectHeroId)
  end)
end

function UILotterySelectHero:__OnClickShowCharacter()
  local currentPoolId = 0
  local heroId = self.selectHeroId
  local lottrryCtrl = ControllerManager:GetController(ControllerTypeId.Lottery, true)
  if lottrryCtrl ~= nil then
    currentPoolId = lottrryCtrl.curPoolId
  end
  local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if ltrWin ~= nil then
    ltrWin:CloseLottery(true)
  end
  ControllerManager:GetController(ControllerTypeId.ShowCharacter, true):EnterShowCharacterScene(heroId, currentPoolId)
end

function UILotterySelectHero:_OnSelectHero(heroId)
  if self.isChangeing or self.selectHeroId == heroId then
    return
  end
  if heroId == nil then
    error("heroId is Empty")
    return
  end
  local isFirstSet = self.selectHeroId == nil
  self.selectHeroId = heroId
  if isFirstSet then
    self:LoadPic(false)
    self:ChangeHeroShow()
  else
    self:LoadPic(true)
    self:_AniHeroChange()
  end
  self.selectHeroData = HeroInfoData:New()
  self.selectHeroData:InitData(self.selectHeroId)
  self:__refreshPreviewPic()
  for i, item in ipairs(self.heroItemPool.listItem) do
    item:SetLtrSelectHeroItemIsOn(self.selectHeroId)
  end
end

function UILotterySelectHero:__refreshPreviewPic()
  if self.selectHeroId then
    local lottery_preview = ConfigData.lottery_preview[self.selectHeroId]
    if lottery_preview ~= nil then
      local fullPath = PathConsts:GetImagePath(lottery_preview.previewPic)
      local image = self.resLoader:LoadABAsset(fullPath)
      if image ~= nil then
        self.ui.img_PreviewCharacter.texture = image
      end
    end
  end
end

function UILotterySelectHero:__refreshModel()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  local modelPath = PathConsts:GetCharacterModelPathEx(self.selectHeroData.heroData:GetResModelName())
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

function UILotterySelectHero:ChangeHeroShow()
  local heroCfg = ConfigData.hero_data[self.selectHeroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(self.selectHeroId))
    return
  end
  self.curHeroCfg = heroCfg
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self.ui.tex_ENName.text = heroCfg.name_en
  local careerCfg = ConfigData.career[heroCfg.career]
  self.ui.img_Carrer.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  self:_UpdateStarNum(heroCfg.rank)
end

function UILotterySelectHero:_AniHeroChange()
  self.isChangeing = true
  self.isChangeingFirstState = true
  if self.heroChangeTween ~= nil then
    self.heroChangeTween:Restart()
    self.heroChangeTween:PlayForward()
    return
  end
  self.heroChangeTween = cs_DoTween.Sequence()
  self.heroChangeTween:SetAutoKill(false)
  local tempTime = 0.2
  local newWorldPos = self.ui.heroInfo.transform:TransformPoint(self.heroHoderDefaultPosition + Vector3.New(50, 0, 0))
  self.heroChangeTween:Append(self.ui.heroInfo:DOFade(0, tempTime))
  self.heroChangeTween:Join(self.ui.heroHolder.transform:DOMove(newWorldPos, tempTime))
  self.heroChangeTween:OnComplete(function()
    self.isChangeingFirstState = false
    self:TryContinueTween()
  end)
  self.heroChangeTween:PlayForward()
end

function UILotterySelectHero:LoadPic(isPreLoader)
  local function loadFunc(loader, finishAct)
    local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
    
    local resCfg = skinCtr:GetResModel(self.selectHeroId, 0)
    local resPath = PathConsts:GetCharacterBigImgPrefabPath(resCfg.res_Name)
    loader:LoadABAssetAsync(resPath, function(prefab)
      if IsNull(prefab) then
        return
      end
      local objField = prefab:Instantiate(self.ui.heroHolder.transform)
      local commonPicCtrl = objField:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroList")
      if finishAct ~= nil then
        finishAct(objField)
      end
      AudioManager:PlayAudioById(1062)
    end)
  end
  
  if isPreLoader then
    if self.nextResLoader ~= nil then
      self.nextResLoader:Put2Pool()
      self.nextResLoader = nil
    end
    if not IsNull(self.nextBigImgGameObject) then
      DestroyUnityObject(self.nextBigImgGameObject)
    end
    self.nextResLoader = cs_ResLoader.Create()
    loadFunc(self.nextResLoader, function(fileObj)
      self.nextBigImgGameObject = fileObj
      self:TryContinueTween()
    end)
  else
    if self.bigImgResloader ~= nil then
      self.bigImgResloader:Put2Pool()
    end
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgResloader = cs_ResLoader.Create()
    loadFunc(self.bigImgResloader, function(fileObj)
      self.bigImgGameObject = fileObj
    end)
  end
end

function UILotterySelectHero:TryContinueTween()
  if not self.isChangeing or self.isChangeingFirstState or IsNull(self.nextBigImgGameObject) then
    if self.nextBigImgGameObject ~= nil then
      self.nextBigImgGameObject:SetActive(false)
    end
    return
  end
  DestroyUnityObject(self.bigImgGameObject)
  self.bigImgGameObject = self.nextBigImgGameObject
  self.nextBigImgGameObject = nil
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
  end
  self.bigImgResloader = self.nextResLoader
  self.nextResLoader = nil
  self.bigImgGameObject:SetActive(true)
  self:ChangeHeroShow()
  if self.heroChangeTweenBack ~= nil then
    self.heroChangeTweenBack:Restart()
    self.heroChangeTweenBack:PlayForward()
    return
  end
  self.heroChangeTweenBack = cs_DoTween.Sequence()
  self.heroChangeTweenBack:SetAutoKill(false)
  local tempTime = 0.2
  local oriWorldPos = self.ui.heroInfo.transform:TransformPoint(self.heroHoderDefaultPosition)
  self.heroChangeTweenBack:Append(self.ui.heroInfo:DOFade(1, tempTime))
  self.heroChangeTweenBack:Join(self.ui.heroHolder.transform:DOMove(oriWorldPos, tempTime))
  self.heroChangeTweenBack:OnComplete(function()
    self.isChangeing = false
  end)
  self.heroChangeTweenBack:PlayForward()
end

function UILotterySelectHero:_UpdateStarNum(rank)
  local rankCfg = ConfigData.hero_rank[rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(rank))
    return
  end
  local num = rankCfg.star
  local count = math.ceil(num / 2)
  local isHalf = num % 2 == 1
  for _, starGameObject in ipairs(self.StarList) do
    starGameObject.gameObject:SetActive(false)
  end
  for i = 1, count do
    if self.StarList[i] ~= nil then
      self.StarList[i].gameObject:SetActive(true)
      self.StarList[i]:SetIndex(0)
    else
      local imgItemInfo = self.ui.img_star.gameObject:Instantiate():GetComponent(typeof(CS.UiImageItemInfo))
      table.insert(self.StarList, imgItemInfo)
      imgItemInfo.gameObject:SetActive(true)
    end
  end
  if isHalf then
    self.StarList[count]:SetIndex(1)
  end
end

function UILotterySelectHero:GetLtrSelectHeroItemId()
  local itemId = self.heroId2ItemIdMapDic[self.selectHeroId]
  return itemId, self.selectHeroId
end

function UILotterySelectHero:ConfimFreeSelectHero(ltrCtrl)
  local itemId = self.heroId2ItemIdMapDic[self.selectHeroId]
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryExchange, function(window)
    if window ~= nil then
      window:ShowLtrSHNode(itemId, self.curHeroCfg, self.ltrPoolData.ltrCfg, ltrCtrl)
    end
  end)
end

function UILotterySelectHero:OnHide()
  base.OnHide(self)
end

function UILotterySelectHero:ClearLotterySelect()
  if self.heroChangeTween ~= nil then
    self.heroChangeTween:Kill()
    self.heroChangeTween = nil
  end
  if self.heroChangeTweenBack ~= nil then
    self.heroChangeTweenBack:Kill()
    self.heroChangeTweenBack = nil
  end
  self.ui.heroHolder.transform.localPosition = self.heroHoderDefaultPosition
  self.ui.heroInfo.alpha = 1
  self.selectHeroId = nil
  self.isChangeing = false
  self.isChangeingFirstState = false
  self.ui.tex_Name.text = ""
  self.ui.tex_ENName.text = ""
  if self.nextResLoader ~= nil then
    self.nextResLoader:Put2Pool()
    self.nextResLoader = nil
  end
  if not IsNull(self.nextBigImgGameObject) then
    DestroyUnityObject(self.nextBigImgGameObject)
  end
end

function UILotterySelectHero:OnDelete()
  self:ClearLotterySelect()
  self.heroItemPool:DeleteAll()
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  base.OnDelete(self)
end

return UILotterySelectHero
