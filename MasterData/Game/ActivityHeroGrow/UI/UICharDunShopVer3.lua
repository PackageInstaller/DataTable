local base = require("Game.ActivityHeroGrow.UI.UICharDunShopVer2")
local UICharDunShopVer3 = class("UICharDunShopVer3", base)
local UINCharDunShopVer3Item = require("Game.ActivityHeroGrow.UI.UINCharDunShopVer3Item")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local cs_ResLoader = CS.ResLoader

function UICharDunShopVer3:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickCloseShopVer2)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnClickRewardAll)
  self.__OnRewardOneCallback = BindCallback(self, self.__OnRewardOne)
  self.ui.shopList.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.shopList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.shopList.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.__ItemUpdateCallback = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemUpdateCallback)
  self._resloader = cs_ResLoader.Create()
  self._itemDic = {}
end

function UICharDunShopVer3:InitCharDunShopVer3(heroGrowData, callback)
  self._heroGrowData = heroGrowData
  self._callback = callback
  self:Refresh()
  self:__CreateItem()
  self:__CountDown()
  self:LoadBgImage()
  self._timerId = TimerManager:StartTimer(1, self.__CountDown, self)
end

function UICharDunShopVer3:Refresh()
  self:RefreshToken()
  self:RefreshProPross()
  self:RefreshShopTime()
  self:RefreshThemeColor()
  self:RefreshTipsText()
  self:RefreshListItem()
end

function UICharDunShopVer3:__CreateItem()
  local allCfg = self._heroGrowData:GetTokenConfig()
  local count = #allCfg
  local itemCount = self._heroGrowData:GetHeroGrowTokenCount()
  self.ui.shopList.totalCount = count
  self.ui.shopList:RefillCells(0)
  local isExist, lv = self._heroGrowData:IsHeroGrowExistLvReward()
  if not isExist then
    lv = self._heroGrowData:GetShopCurrentLv()
  end
  if 0 < lv then
    self.ui.shopList:SrollToCellWithinTime(lv - 1, 0.7)
  end
end

function UICharDunShopVer3:RefreshListItem()
  for k, v in pairs(self._itemDic) do
    v:Refresh()
  end
  self.ui.btn_GetAll.gameObject:SetActive(self._heroGrowData:IsHeroGrowExistLvReward())
end

function UICharDunShopVer3:RefreshTipsText()
  local tokenId = self._heroGrowData:GetHeroGrowTokenId()
  local itemName = LanguageUtil.GetLocaleText(ConfigData.item[tokenId].name)
  self.ui.tex_Tips:SetIndex(0, itemName)
end

function UICharDunShopVer3:RefreshToken()
  local itemId = self._heroGrowData:GetHeroGrowTokenId()
  self.ui.imgToken.sprite = CRH:GetSpriteByItemId(itemId)
  local itemCount = self._heroGrowData:GetHeroGrowTokenCount()
  self.ui.tex_TokenNum.text = tostring(itemCount)
end

function UICharDunShopVer3:RefreshProPross()
  local activityCfg = self._heroGrowData:GetMainCfg()
  local tokenStateCount = activityCfg.token_stage
  local currentLv = self._heroGrowData:GetShopCurrentLv()
  local nextRewardCount = self._heroGrowData:GetShopNextRewardCount()
  local currentProgress = self._heroGrowData:GetShopNextRewardProgress()
  self.ui.Tex_Progress.text = string.format("%s/%s", nextRewardCount, tokenStateCount)
  if self._heroGrowData:IsRewardMax() then
    self.ui.Tex_Lvl:SetIndex(0, "Max")
  else
    self.ui.Tex_Lvl:SetIndex(0, tostring(currentLv))
  end
  self.ui.Bar_currentProgress.value = currentProgress
end

function UICharDunShopVer3:RefreshThemeColor()
  local color = self._heroGrowData:GetHGV3DecoColor()
  for i, v in ipairs(self.ui.array_colorRep) do
    v.color = color
  end
end

function UICharDunShopVer3:RefreshShopTime()
  local date = TimeUtil:TimestampToDate(self._heroGrowData:GetActivityDestroyTime(), false, true)
  self.ui.tex_Time.text = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
end

function UICharDunShopVer3:OnClickRewardAll()
  if not self._heroGrowData:IsHeroGrowExistLvReward() then
    return
  end
  local Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3)
  local actId = self._heroGrowData:GetActId()
  Ctrl:ReqHeroGrowAllTokenReward(actId, function()
    if IsNull(self.transform) then
      return
    end
    self:Refresh()
  end)
end

function UICharDunShopVer3:__ItemUpdate(updateItem)
  if updateItem[self._heroGrowData:GetHeroGrowTokenId()] == nil then
    return
  end
  self:Refresh()
end

function UICharDunShopVer3:__OnInstantiateItem(go)
  local item = UINCharDunShopVer3Item.New()
  item:Init(go)
  self._itemDic[go] = item
end

function UICharDunShopVer3:__OnChangeItem(go, index)
  local item = self._itemDic[go]
  if item == nil then
    if isGameDev then
      error("scoreItem is nil " .. tostring(index))
    end
    return
  end
  local lv = index + 1
  item:InitCharDunShopVer3Item(self._heroGrowData, lv, self.__OnRewardOneCallback)
end

function UICharDunShopVer3:__OnRewardOne(lv, item)
  if self._heroGrowData:IsHeroGrowLvReceived(lv) then
    return
  end
  local allCfg = self._heroGrowData:GetTokenConfig()
  if allCfg[lv] == nil or allCfg[lv].need_token > self._heroGrowData:GetHeroGrowTokenCount() then
    return
  end
  local Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3)
  local actId = self._heroGrowData:GetActId()
  Ctrl:ReqHeroGrowSingleTokenReward(actId, lv, function()
    if IsNull(self.transform) then
      return
    end
    self:Refresh()
  end)
end

function UICharDunShopVer3:LoadBgImage()
  local uiCfg = self._heroGrowData:GetUIConfig()
  local heroId = self._heroGrowData:GetHGV3HeroId()
  local skinId = uiCfg.reward_skin
  local pos = Vector3.New(uiCfg.reward_skin_pos[1], uiCfg.reward_skin_pos[2], uiCfg.reward_skin_pos[3])
  local size = Vector3.New(uiCfg.reward_skin_scale[1], uiCfg.reward_skin_scale[2], uiCfg.reward_skin_scale[3])
  if uiCfg.skin_type == 1 then
    self:__LoadPic(heroId, skinId, pos, size)
  else
    self:__LoadL2D(heroId, skinId, pos, size)
  end
end

function UICharDunShopVer3:__LoadL2D(heroId, skinId, pos, size)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  if not PlayerDataCenter.skinData:IsSkinL2dCouldShow(skinId) then
    self:__LoadPic(heroId, skinId, pos, size)
    return
  end
  local resName = skinCfg.src_id_pic
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName), function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.heroHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroHolder, -600, true)
      self.heroCubismInteration:SetL2DPosType("CharDun", false)
      self.heroCubismInteration:SetInterationOpenWait(false)
      cs_CubismInterationController.transform.localPosition = pos
      cs_CubismInterationController.transform.localScale = size
    end
  end)
end

function UICharDunShopVer3:__LoadPic(heroId, skinId, pos, size)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("CharDun")
    commonPicCtrl.transform.localPosition = pos
    commonPicCtrl.transform.localScale = size
  end)
end

return UICharDunShopVer3
