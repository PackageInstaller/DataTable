local UINWhiteDayAlbHeroList = class("UINWhiteDayAlbHeroList", UIBaseNode)
local base = UIBaseNode
local UINWhiteDayAlbHero = require("Game.ActivityWhiteDay.UI.Album.UINWhiteDayAlbHero")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")

function UINWhiteDayAlbHeroList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.background, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirmAlbHero)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnClickIntro)
  self.ui.scroll.onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  self.ui.scroll.onChangeItem = BindCallback(self, self.OnChangeItem)
  self._itemDic = {}
  self.__OnSelectPhotoCallback = BindCallback(self, self.__OnSelectPhoto)
  self._resloader = cs_ResLoader.Create()
  self.__ItemUpdateCallback = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemUpdateCallback)
end

function UINWhiteDayAlbHeroList:InitAlbHeroList(AWDData, callback)
  self._data = AWDData
  self._callback = callback
  local awdCfg = self._data:GetWDCfg()
  self._costId = awdCfg.skinCostIds[1]
  self._costNum = awdCfg.skinCostNums[1]
  self._firstCostNum = awdCfg.skinFirstCostNums[1]
  self._skinOrgCostNums = awdCfg.skinOrgCostNums[1]
  local sprite = CRH:GetSpriteByItemId(self._costId, true)
  self.ui.img_Icon_title.sprite = sprite
  self.ui.img_Icon_cost.sprite = sprite
  sprite = CRH:GetSpriteByItemId(ConstGlobalItem.PaidItem, true)
  self.ui.img_Icon_QZ.sprite = sprite
  self:RefreshAlbHeroList()
end

function UINWhiteDayAlbHeroList:AutoSelectAlbHero(skinId)
  local selectPhotoCfg, index
  for i, photoCfg in ipairs(self._photoHeroCfgList) do
    if photoCfg.skinId == skinId then
      index = i - 1
      selectPhotoCfg = photoCfg
      break
    end
  end
  if selectPhotoCfg == nil then
    return
  end
  self._selectPhotoCfg = nil
  self._selectAlbHeroItem = nil
  self.ui.scroll:SrollToCell(index, 9999, function()
    for go, item in pairs(self._itemDic) do
      if item:GetPhotoHeroCfg() == selectPhotoCfg then
        self._selectPhotoCfg = selectPhotoCfg
        self._selectAlbHeroItem = item
        self._selectAlbHeroItem:SetAlbHeroSelectState(true)
      else
        item:SetAlbHeroSelectState(false)
      end
    end
  end)
end

function UINWhiteDayAlbHeroList:RefreshAlbHeroList()
  self._selectPhotoCfg = nil
  self._selectAlbHeroItem = nil
  self:__ItemUpdate()
  local unlockPhotoDic = self._data:GetWDUnlockedPhotoDic()
  local photoCfgs = self._data:GetWDPhotoCfgs()
  self._photoHeroCfgList = {}
  for id, _ in pairs(unlockPhotoDic) do
    local cfg = photoCfgs[id]
    if cfg.skinId ~= nil and PlayerDataCenter.skinData:IsSkinUnlocked(cfg.skinId) and not PlayerDataCenter.skinData:IsHaveSkin(cfg.skinId) then
      table.insert(self._photoHeroCfgList, cfg)
    end
  end
  table.sort(self._photoHeroCfgList, function(a, b)
    return a.id < b.id
  end)
  self.ui.scroll.totalCount = #self._photoHeroCfgList
  self.ui.scroll:RefillCells()
  self:__RefreshConfirmBtnState()
end

function UINWhiteDayAlbHeroList:OnInstantiateItem(go)
  local item = UINWhiteDayAlbHero.New()
  item:Init(go)
  self._itemDic[go] = item
end

function UINWhiteDayAlbHeroList:OnChangeItem(go, index)
  local item = self._itemDic[go]
  if item == self._selectAlbHeroItem then
    self._selectAlbHeroItem = nil
  end
  local cfg = self._photoHeroCfgList[index + 1]
  item:InitAlbHero(cfg, self._resloader, self.__OnSelectPhotoCallback)
  if cfg == self._selectPhotoCfg then
    self._selectAlbHeroItem = item
    self._selectAlbHeroItem:SetAlbHeroSelectState(true)
  end
end

function UINWhiteDayAlbHeroList:__ItemUpdate()
  self.ui.tex_Count_title.text = tostring(PlayerDataCenter:GetItemCount(self._costId))
  self.ui.tex_Count_QZ.text = tostring(PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem))
end

function UINWhiteDayAlbHeroList:__RefreshConfirmBtnState()
  if self._firstCostNum ~= nil and not self._data:GetWDIsPhotoSkinBought() then
    self.ui.tex_oldPrice.gameObject:SetActive(true)
    self.ui.tex_oldPrice.text = tostring(self._costNum)
    self.ui.tex_Count_cost.text = tostring(self._firstCostNum)
  elseif self._skinOrgCostNums ~= nil then
    self.ui.tex_oldPrice.gameObject:SetActive(true)
    self.ui.tex_oldPrice.text = tostring(self._skinOrgCostNums)
    self.ui.tex_Count_cost.text = tostring(self._costNum)
  else
    self.ui.tex_oldPrice.gameObject:SetActive(false)
    self.ui.tex_Count_cost.text = tostring(self._costNum)
  end
end

function UINWhiteDayAlbHeroList:__OnSelectPhoto(photoCfg, albHeroItem)
  if self._selectAlbHeroItem ~= nil then
    self._selectAlbHeroItem:SetAlbHeroSelectState(false)
  end
  if self._selectPhotoCfg == photoCfg then
    self._selectPhotoCfg = nil
    self._selectAlbHeroItem = nil
    return
  end
  self._selectAlbHeroItem = albHeroItem
  self._selectPhotoCfg = photoCfg
  self._selectAlbHeroItem:SetAlbHeroSelectState(true)
end

function UINWhiteDayAlbHeroList:OnClickConfirmAlbHero()
  if self._selectPhotoCfg == nil then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7214))
    return
  end
  
  local function LocalFunc_Buy()
    local actFrameId = self._data:GetActFrameId()
    local photoId = self._selectPhotoCfg.id
    local whiteNet = NetworkManager:GetNetwork(NetworkTypeID.WhiteDay)
    local skinId = self._selectPhotoCfg.skinId
    whiteNet:CS_Activity_Polariod_Buy_Skin(actFrameId, photoId, function(msg)
      local itemIds = {skinId}
      local itemCounts = {1}
      local heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        local CRData = CommonRewardData.CreateCRDataUseList(itemIds, itemCounts):SetCRHeroSnapshoot(heroIdSnapShoot, false):SetCRNotHandledGreat(true)
        window:AddAndTryShowReward(CRData)
      end)
      if not IsNull(self.transform) then
        if self._data:GetWDIsUnlockPhotoSkinGet() then
          self:Hide()
        else
          self:RefreshAlbHeroList()
          self:__RefreshConfirmBtnState()
        end
      end
    end)
  end
  
  local hasNum = PlayerDataCenter:GetItemCount(self._costId)
  local isBought = self._data:GetWDIsPhotoSkinBought()
  if hasNum < self._costNum and (self._firstCostNum == nil or isBought) or self._firstCostNum ~= nil and hasNum < self._firstCostNum and not isBought then
    if self._costId == ConstGlobalItem.PaidSubItem then
      local diff = self._costNum - hasNum
      if diff <= PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem) then
        local diffStr = tostring(diff)
        local tip = string.format(ConfigData:GetTipContent(10008), diffStr, diffStr)
        cs_MessageCommon.ShowMessageBox(tip, LocalFunc_Buy, nil)
      else
        local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
        payCtrl:Jump2BuyQuartz(nil, nil, true)
      end
      return
    end
    if self._costId == ConstGlobalItem.ActivityToken then
      local quickBuyData = ShopEnum.eQuickBuy.activityToken
      local shopId = quickBuyData.shopId
      local shelfId = quickBuyData.shelfId
      local goodData
      local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
      ctrl:GetShopData(shopId, function(shopData)
        goodData = shopData.shopGoodsDic[shelfId]
        UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
          if win == nil then
            error("can't open QuickBuy win")
            return
          end
          win:SlideIn(nil, true)
          win:InitBuyTarget(goodData, nil, true, quickBuyData.resourceIds, function()
            if self.closeCommonRewardCallback ~= nil then
              self.closeCommonRewardCallback()
              self.closeCommonRewardCallback = nil
            end
          end)
          win:OnClickAdd(true)
        end)
      end)
    end
  else
    LocalFunc_Buy()
  end
end

function UINWhiteDayAlbHeroList:OnClickIntro()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    local wdCfg = self._data:GetWDCfg()
    window:InitCommonInfoByRule(wdCfg.skin_rule, true)
  end)
end

function UINWhiteDayAlbHeroList:OnHide()
  base.OnHide(self)
  if self._callback ~= nil then
    self._callback()
  end
end

function UINWhiteDayAlbHeroList:OnDelete()
  base.OnDelete(self)
  if self._resloader then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemUpdateCallback)
end

return UINWhiteDayAlbHeroList
