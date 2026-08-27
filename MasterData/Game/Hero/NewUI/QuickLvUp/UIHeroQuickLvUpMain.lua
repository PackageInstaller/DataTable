local UIHeroQuickLvUpMain = class("UIHeroQuickLvUpMain", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local UINStarUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local SkinEnum = require("Game.Skin.SkinEnum")
local cs_ResLoader = CS.ResLoader
local CS_UiImageItemInfo = CS.UiImageItemInfo

function UIHeroQuickLvUpMain:OnInit()
  self._starList = {}
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, false)
  UIUtil.AddButtonListener(self.ui.btn_cancle, self, self.OnClickBtnCancle)
  UIUtil.AddButtonListener(self.ui.btn_confirm, self, self.OnClickBtnConfirm)
  self.resLoader = cs_ResLoader.Create()
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.UINBaseItem)
  self.baseItem:BindBaseItemResloader(self.resLoader)
  self.attrPool = UIItemPool.New(UINStarUpAttrItem, self.ui.attrItem)
  self.ui.attrItem:SetActive(false)
  table.insert(self._starList, self.ui.img_star)
end

function UIHeroQuickLvUpMain:InitHeroQuickLvUpMain(itemCfg, heroId, callback)
  self._itemCfg = itemCfg
  self._heroData = PlayerDataCenter:GetHeroData(heroId)
  self._callback = callback
  self.baseItem:InitBaseItem(itemCfg, null)
  self.baseItem:SetLimtTimeTagActive(false)
  local haveNum = PlayerDataCenter:GetItemCount(itemCfg.id)
  self.ui.text_itemNum:SetIndex(0, tostring(haveNum))
  self.attrPool:HideAll()
  local golevelCfg = ConfigData.hero_golevel[itemCfg.id]
  local rank = self._heroData.rank
  local oldLevel = self._heroData.level
  local newLevel = golevelCfg.go_level
  local oldPotential = self._heroData.potential
  local newPotential = self._heroData:GetHeroPotentialByLevel(newLevel)
  local attrDataDic = self._heroData:GetDifferAttrWhenRankUp(rank, newLevel, rank, oldLevel, newPotential, oldPotential)
  for k, v in pairs(attrDataDic) do
    local item = self.attrPool:GetOne()
    item:InitAttrItem(v.oldAttr, v.newAttr, v.attrId)
  end
  self.ui.text_toLevel:SetIndex(0, tostring(newLevel))
  self.ui.text_name.text = self._heroData:GetName()
  self.ui.text_ENName.text = self._heroData:GetEnName()
  self.ui.img_carrer:SetIndex(self._heroData.heroCfg.career - 1)
  self:UpdateStarNum()
  self:LoadHeroBigImg()
end

function UIHeroQuickLvUpMain:UpdateStarNum()
  local num = self._heroData.rankCfg.star
  local count = math.ceil(num / 2)
  local isHalf = num % 2 == 1
  for _, star in ipairs(self._starList) do
    star.gameObject:SetActive(false)
  end
  for i = 1, count do
    if self._starList[i] ~= nil then
      self._starList[i].gameObject:SetActive(true)
      self._starList[i]:SetIndex(0)
    else
      local imageItemInfo = self.ui.img_star.gameObject:Instantiate():GetComponent(typeof(CS_UiImageItemInfo))
      table.insert(self._starList, imageItemInfo)
      imageItemInfo.gameObject:SetActive(true)
    end
  end
  if isHalf then
    self._starList[count]:SetIndex(1)
  end
end

function UIHeroQuickLvUpMain:LoadHeroBigImg()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  self.resLoader = cs_ResLoader.Create()
  local campIcon = LanguageUtil.GetLocaleText(self._heroData:GetCampCfg().icon)
  self.resLoader:LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_camp.texture = texture
  end)
  if self.bigImageResLoader ~= nil then
    self.bigImageResLoader:Put2Pool()
    self.bigImageResLoader = nil
  end
  self.bigImageResLoader = cs_ResLoader.Create()
  if not IsNull(self.bigImageGameObject) then
    self.bigImageGameObject:SetActive(false)
  end
  self.bigImageResLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(self._heroData:GetResPicName(), SkinEnum.fromWhere.heroInfoAndHandbook), function(prefab)
    DestroyUnityObject(self.bigImageGameObject)
    self.bigImageGameObject = prefab:Instantiate(self.ui.HeroHolder)
    local commonPicCtrl = self.bigImageGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
    self.bigImageGameObject:SetActive(true)
  end)
end

function UIHeroQuickLvUpMain:OnClickBtnCancle()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHeroQuickLvUpMain:OnClickBtnConfirm()
  local useCount = 1
  local heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  heroNetwork:CS_HERO_GoLevel(self._heroData.dataId, self._itemCfg.id, function()
    self:OnClickBtnCancle()
    if self._callback ~= nil then
      self._callback()
    end
  end)
end

function UIHeroQuickLvUpMain:BackAction()
  self:Delete()
end

function UIHeroQuickLvUpMain:GenCoverJumpReturnCallback()
  if self.bigImageResLoader ~= nil then
    self.bigImageResLoader:Put2Pool()
    self.bigImageResLoader = nil
  end
  if not IsNull(self.bigImageGameObject) then
    DestroyUnityObject(self.bigImageGameObject)
  end
  self.bigImageGameObject = nil
  local dataTable = {}
  for key, value in pairs(self) do
    dataTable[key] = value
  end
  return function()
    for key, value in pairs(dataTable) do
      self[key] = value
    end
    self:InitHeroQuickLvUpMain(self._itemCfg, self._heroData)
  end
end

function UIHeroQuickLvUpMain:OnDelete()
  if self.bigImageResLoader ~= nil then
    self.bigImageResLoader:Put2Pool()
    self.bigImageResLoader = nil
  end
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  base.OnDelete(self)
end

return UIHeroQuickLvUpMain
