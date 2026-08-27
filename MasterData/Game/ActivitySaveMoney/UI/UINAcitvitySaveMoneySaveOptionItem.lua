local base = require("Game.ActivitySaveMoney.UI.UINAcitvitySaveMoneyWithdrawOptionItem")
local UINAcitvitySaveMoneySaveOptionItem = class("UINAcitvitySaveMoneySaveOptionItem", base)

function UINAcitvitySaveMoneySaveOptionItem:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_Bottom, self, self.__OnClickChoose)
  UIUtil.AddButtonListener(self.ui.btn_Gift, self, self.__OnClickChoose)
  self.imgStartWidth = self.ui.img_Stars.transform.rect.width
end

function UINAcitvitySaveMoneySaveOptionItem:InitSaveMoneyOptionItem(resLoader, cfg)
  self.cfg = cfg
  self.ui.tex_PackName.text = LanguageUtil.GetLocaleText(cfg.level_name)
  local immediateItemId = cfg.immediate_rewards_ids[1]
  if immediateItemId ~= nil then
    local immediateItem = ConfigData.item[immediateItemId]
    self.ui.tex_ImmediateRewards:SetIndex(0, LanguageUtil.GetLocaleText(immediateItem.name), tostring(cfg.immediate_rewards_nums[1]))
  end
  self.ui.tex_SaveMoney.text = cfg.save_consume_nums[1]
  self.ui.tex_WithdrawMoney.text = cfg.cumulative_rewards_nums[1]
  self.ui.tex_Choose:SetIndex(0)
  if not string.IsNullOrEmpty(cfg.level_picture) then
    self.ui.img_Gift.enabled = false
    resLoader:LoadABAssetAsync(PathConsts:GetActivitySaveMoney(cfg.level_picture), function(texture)
      if texture == nil or IsNull(self.transform) then
        return
      end
      self.ui.img_Gift.texture = texture
      self.ui.img_Gift.enabled = true
    end)
  end
  self.ui.img_Stars.transform.sizeDelta = Vector2.Temp(self.imgStartWidth * self.cfg.save_level, self.ui.img_Stars.transform.rect.height)
end

function UINAcitvitySaveMoneySaveOptionItem:__OnClickChoose()
  if self.cfg ~= nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
      if win == nil then
        return
      end
      win:SlideIn(nil, true)
      win:InitQuickPurchaseSaveMoney(self.cfg)
    end)
  end
end

return UINAcitvitySaveMoneySaveOptionItem
