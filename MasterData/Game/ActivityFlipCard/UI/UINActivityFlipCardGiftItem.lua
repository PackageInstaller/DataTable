local UIActivityFlipCardGiftItem = class("UIActivityFlipCardGiftItem", UIBaseNode)
local base = UIBaseNode
local cs_Ease = CS.DG.Tweening.Ease

function UIActivityFlipCardGiftItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_go, self, self.OnClickGo)
end

function UIActivityFlipCardGiftItem:InitFlipCardGiftItemWithTask(finishCount, totalCount, goCallback)
  self.ui.obj_task:SetActive(true)
  self.ui.obi_gift:SetActive(false)
  self.ui.tex_title.text = ConfigData:GetTipContent(24006)
  self.ui.tex_des.text = ConfigData:GetTipContent(24007)
  self.ui.tex_limit:SetIndex(0, tostring(finishCount), tostring(totalCount))
  self.ui.tex_go:SetIndex(1)
  self.goCallback = goCallback
  self.isTask = true
end

function UIActivityFlipCardGiftItem:InitFlipCardGiftItemWithGiftData(giftData, goCallback, resloader)
  self.ui.obj_task:SetActive(false)
  self.ui.obi_gift:SetActive(true)
  self.goCallback = goCallback
  local giftCfg = giftData.defaultCfg
  local needItem = giftCfg.costId
  local payType = giftCfg.pay_type
  if payType == 1 then
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    local priceStr, priceNum, specailSymbol = payCtrl:GetPayPriceShow(giftCfg.payId)
    self.ui.img_icon.gameObject:SetActive(false)
    self.ui.tex_go:SetIndex(0, priceStr)
  else
    self.ui.img_icon.gameObject:SetActive(true)
    self.ui.tex_go:SetIndex(0, tostring(giftCfg.cur_price))
    self.ui.img_icon.sprite = CRH:GetSpriteByItemId(needItem, true)
  end
  self.ui.tex_title.text = LanguageUtil.GetLocaleText(giftData.groupCfg.name)
  self.ui.tex_des.text = LanguageUtil.GetLocaleText(giftData.groupCfg.des)
  self.ui.tex_limit:SetIndex(1, tostring(giftData.times), tostring(giftCfg.times))
  resloader:LoadABAssetAsync(PathConsts:GetShopGiftBgPath(giftData.groupCfg.icon), function(texture)
    if not IsNull(texture) then
      self.ui.img_Gift.texture = texture
    end
  end)
  self.isTask = false
  self.limitBuyTime = giftCfg.times
  self.giftData = giftData
end

function UIActivityFlipCardGiftItem:PlayFlipCardGetMoreCardInitTween(index)
  self.ui.canvas_item:DOFade(0, 1):From():SetEase(cs_Ease.OutQuart):SetLink(self.gameObject):SetDelay(index * 0.1)
  self.ui.root.transform:DOLocalMoveY(-100, 1):From():SetEase(cs_Ease.OutQuart):SetLink(self.gameObject):SetDelay(index * 0.1)
end

function UIActivityFlipCardGiftItem:OnClickGo()
  if not self.isTask and self.giftData.times >= self.limitBuyTime then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(24005))
    return
  end
  if self.goCallback ~= nil then
    self.goCallback(self.isTask, self.giftData)
  end
end

return UIActivityFlipCardGiftItem
