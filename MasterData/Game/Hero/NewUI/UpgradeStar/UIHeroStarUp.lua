local UIHeroStarUp = class("UIHeroStarUp", UIBaseWindow)
local base = UIBaseWindow
local UIHStarUpInfoNode = require("Game.Hero.NewUI.UpgradeStar.UIHStarUpInfoNode")
local UIHStarUpSkillNode = require("Game.Hero.NewUI.UpgradeStar.UIHStarUpSkillNode")
local previewType = require("Game.Hero.NewUI.UpgradeStar.eHeroStarUpEnum").previewType
local SkinEnum = require("Game.Skin.SkinEnum")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local waitRecorverNUM = 0

function UIHeroStarUp:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_LeftArrow, self, self.__OnClickLeftArrow)
  UIUtil.AddButtonListener(self.ui.btn_RightArrow, self, self.__OnClickRightArrow)
  self.starUpInfoNode = UIHStarUpInfoNode.New()
  self.starUpInfoNode:Init(self.ui.obj_InfoNode)
  self.starUpSkillNode = UIHStarUpSkillNode.New()
  self.starUpSkillNode:Init(self.ui.obj_SkillNode)
  self.ui.obj_SkillNode:SetActive(false)
  self.__onPreveteItemClick = BindCallback(self, self.__PreveteItemClick)
  self.__onStarUpClick = BindCallback(self, self.__StarUpClick)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  self.__refreshCostNode = BindCallback(self, self.RefreshCostNode)
  self.__OnSkinChange = BindCallback(self, self.OnSkinChange)
end

function UIHeroStarUp:InitHeroStarUp(resloader, hideCallBack, switchHeroFunc, notSetBackFunc)
  if not notSetBackFunc then
    UIUtil.SetTopStatus(self, self.OnClickBack)
  end
  self.resloader = resloader
  self.hideCallBack = hideCallBack
  self.switchHeroFunc = switchHeroFunc
  if self.winTween ~= nil then
    self.winTween:Complete()
  end
  self.isClosing = false
end

function UIHeroStarUp:SwitchHero(heroData, reUseBigImgResLoader)
  self.heroData = heroData
  self:RefreshAll(reUseBigImgResLoader)
  self:__PlayAllDOTween()
end

function UIHeroStarUp:RefreshAll(reUseBigImgResLoader, heroId)
  self.starUpSkillNode:Hide()
  if heroId ~= nil and heroId ~= self.heroData.dataId then
    return
  end
  self:RefreshHeroStaticInfo(reUseBigImgResLoader)
  self.starUpInfoNode:RefreshStarUpInfoUI(self.heroData, self.__onPreveteItemClick, self.__onStarUpClick)
end

function UIHeroStarUp:RefreshHeroStaticInfo(reUseBigImgResLoader)
  local campIcon = LanguageUtil.GetLocaleText(self.heroData:GetCampCfg().icon)
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Camp.texture = texture
  end)
  local bigImgResLoader
  if reUseBigImgResLoader ~= nil then
    bigImgResLoader = reUseBigImgResLoader
  else
    if self.bigImgResloader ~= nil then
      self.bigImgResloader:Put2Pool()
    end
    self.bigImgResloader = cs_ResLoader.Create()
    bigImgResLoader = self.bigImgResloader
  end
  if not IsNull(self.bigImgGameObject) then
    self.bigImgGameObject:SetActive(false)
  end
  bigImgResLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(self.heroData:GetResPicName(), SkinEnum.fromWhere.heroInfoAndHandbook), function(prefab)
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
    self.bigImgGameObject:SetActive(true)
    self.ui.tween_heroHolder:DORestart()
  end)
end

function UIHeroStarUp:__PlayAllDOTween()
  for i = 1, #self.ui.heroTweens do
    local tween = self.ui.heroTweens[i]
    tween:DORestart(false)
  end
end

function UIHeroStarUp:__PlayAllDOTweenBackwards()
  for i = 1, #self.ui.heroTweens do
    local tween = self.ui.heroTweens[i]
    tween:DOPlayBackwards()
  end
end

function UIHeroStarUp:__OnClickLeftArrow()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(-1, function(newHeroData, reUseBigImgResloader)
      self:SwitchHero(newHeroData, reUseBigImgResloader)
    end)
    if newHeroData ~= nil then
      self:SwitchHero(newHeroData, reUseBigImgResloader)
    end
  end
end

function UIHeroStarUp:__OnClickRightArrow()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(1, function(newHeroData, reUseBigImgResloader)
      self:SwitchHero(newHeroData, reUseBigImgResloader)
    end)
    if newHeroData ~= nil then
      self:SwitchHero(newHeroData, reUseBigImgResloader)
    end
  end
end

function UIHeroStarUp:OnClickBack()
  if not self.isClosing then
    self.isClosing = true
  else
    return
  end
  if self.hideCallBack ~= nil then
    self.hideCallBack()
  end
  local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if win ~= nil and not win.active then
    win.active = true
    win.gameObject:SetActive(true)
  end
  self.starUpSkillNode:Hide()
  self:__PlayAllDOTweenBackwards()
  if 0 < waitRecorverNUM then
    self:Hide()
  else
    self:Delete()
  end
end

function UIHeroStarUp:__PreveteItemClick(preData)
  if preData == nil or preData.preType == previewType.normal then
    return
  end
  if preData.preType == previewType.skill then
    self.starUpSkillNode:InitStarUpSkillNode(preData.data, preData.preUSkilllevel, self.resloader, preData.unlockAdvance)
    self.starUpSkillNode:Show()
    return
  end
  if preData.preType == previewType.skin then
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkinPreView, function(win)
      if win ~= nil then
        win:ShowSkinPreview(preData.newSkinId, preData.previewRank)
      end
    end)
    return
  end
  if preData.preType == previewType.reward then
    if preData.itemCfg == nil then
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      if win ~= nil then
        win:InitCommonItemDetail(preData.itemCfg)
      end
    end)
  end
end

function UIHeroStarUp:__StarUpClick()
  local ableUp, fitFrag, fitCurrency, fitExtr = self.heroData:AbleUpgradeStar()
  if ableUp then
    if self.__StarUpCompleteFunc == nil then
      self.__StarUpCompleteFunc = BindCallback(self, self.__OnStarUpComplete)
    end
    self.networkCtrl:SendHeroAddStar(self.heroData.dataId, self.__StarUpCompleteFunc)
  elseif not (fitFrag and fitCurrency) or not fitExtr then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.hero_CantUpgrade))
  end
end

function UIHeroStarUp:__OnStarUpComplete()
  self:RefreshAll()
end

function UIHeroStarUp:OnShow()
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__refreshCostNode)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnSkinChange)
  base.OnShow(self)
end

function UIHeroStarUp:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__refreshCostNode)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
  MsgCenter:RemoveListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnSkinChange)
end

function UIHeroStarUp:RefreshCostNode()
  self.starUpInfoNode:RefreshCostNode()
end

function UIHeroStarUp:OnSkinChange(heroId, skinId)
  if heroId == self.heroData.dataId then
    self:RefreshHeroStaticInfo()
  end
end

function UIHeroStarUp:GenCoverJumpReturnCallback()
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  self.bigImgGameObject = nil
  local dataTable = {}
  for key, value in pairs(self) do
    dataTable[key] = value
  end
  waitRecorverNUM = waitRecorverNUM + 1
  return function()
    self.resloader = nil
    self.hideCallBack = nil
    self.switchHeroFunc = nil
    for key, value in pairs(dataTable) do
      self[key] = value
    end
    self:InitHeroStarUp(self.resloader, self.hideCallBack, self.switchHeroFunc, true)
    self:SwitchHero(self.heroData, nil)
    waitRecorverNUM = waitRecorverNUM - 1
  end
end

function UIHeroStarUp:OnDelete()
  for i = 1, #self.ui.heroTweens do
    local tween = self.ui.heroTweens[i]
    tween:DOKill()
  end
  self.starUpSkillNode:Delete()
  self.starUpInfoNode:Delete()
  base.OnDelete(self)
end

function UIHeroStarUp:OnCloseTween()
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  base.OnCloseTween(self)
end

return UIHeroStarUp
