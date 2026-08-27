local UICommonThemedPacks = class("UICommonThemedPacks", UIBaseWindow)
local base = UIBaseWindow
local UINCommonThemedPacksItem = require("Game.PayGift.CommonThemedPacks.UINCommonThemedPacksItem")

function UICommonThemedPacks:OnInit()
  UIUtil.SetTopStatus(self, self.OnClosePacks, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Background, self, self.OnClickClosePacks)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClosePacks)
  self._giftPool = UIItemPool.New(UINCommonThemedPacksItem, self.ui.gIftItem)
  self.ui.gIftItem:SetActive(false)
  self.__RefillGiftCallback = BindCallback(self, self.__RefillGift)
end

function UICommonThemedPacks:InitCommonThemedPacks(payGiftPopGroupId, callback)
  self._giftPopGroupId = payGiftPopGroupId
  local cfg = ConfigData.pay_gift_pop_des[payGiftPopGroupId]
  self._callback = callback
  self.ui.tex_Title.text.text = LanguageUtil.GetLocaleText(cfg.name)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(cfg.des)
  self._giftIdList = ConfigData.pay_gift_pop_des.popGroup[payGiftPopGroupId]
  self:__RefillGift()
end

function UICommonThemedPacks:InitLotteryQuickGift(giftIdList, closeFunc)
  self._callback = closeFunc
  self._giftIdList = giftIdList
  self._isLtr = true
  self.ui.tog_Popup.gameObject:SetActive(false)
  self.ui.tex_Title:SetIndex(0)
  self.ui.tex_Des.text = nil
  self:__RefillGift()
end

function UICommonThemedPacks:__RefillGift()
  self._giftPool:HideAll()
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  local giftList = {}
  local giftIdxDic = {}
  for idx, giftId in ipairs(self._giftIdList) do
    local giftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
    if giftInfo ~= nil and giftInfo:IsUnlock() then
      table.insert(giftList, giftInfo)
    end
    giftIdxDic[giftId] = idx
  end
  table.sort(giftList, function(a, b)
    if a:IsSoldOut() ~= b:IsSoldOut() then
      return not a:IsSoldOut()
    end
    return giftIdxDic[a.initPreGroupId] < giftIdxDic[b.initPreGroupId]
  end)
  for i, giftInfo in ipairs(giftList) do
    local item = self._giftPool:GetOne()
    item:InitCommonThemedPacksItem(giftInfo, self.__RefillGiftCallback, not self._isLtr)
  end
end

function UICommonThemedPacks:OnClickClosePacks()
  if self.ui.tog_Popup.isOn then
    local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    for _, giftId in ipairs(self._giftIdList) do
      userData:SetChipGiftPopIgnore(giftId, PlayerDataCenter.timestamp)
    end
  end
  UIUtil.OnClickBackByUiTab(self)
end

function UICommonThemedPacks:OnClosePacks()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UICommonThemedPacks:OnDelete()
  self._giftPool:DeleteAll()
  base.OnDelete(self)
end

return UICommonThemedPacks
