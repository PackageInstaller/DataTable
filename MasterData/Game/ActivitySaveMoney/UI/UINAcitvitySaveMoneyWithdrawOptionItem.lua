local UINAcitvitySaveMoneyWithdrawOptionItem = class("UINAcitvitySaveMoneyWithdrawOptionItem", UIBaseNode)
local base = UIBaseNode

function UINAcitvitySaveMoneyWithdrawOptionItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.imgStartWidth = self.ui.img_Stars.transform.rect.width
end

function UINAcitvitySaveMoneyWithdrawOptionItem:InitSaveMoneyOptionItem(resloader, cfg)
  self.cfg = cfg
  self.ui.tex_PackName.text = LanguageUtil.GetLocaleText(cfg.level_name)
  self.ui.tex_WithdrawMoney.text = cfg.cumulative_rewards_nums[1]
  self.ui.tex_Choose:SetIndex(1)
  if not string.IsNullOrEmpty(cfg.level_picture) then
    self.ui.img_Gift.enabled = false
    resloader:LoadABAssetAsync(PathConsts:GetActivitySaveMoney(cfg.level_picture), function(texture)
      if texture == nil or IsNull(self.transform) then
        return
      end
      self.ui.img_Gift.texture = texture
      self.ui.img_Gift.enabled = true
    end)
  end
  self.ui.img_Stars.transform.sizeDelta = Vector2.Temp(self.imgStartWidth * self.cfg.save_level, self.ui.img_Stars.transform.rect.height)
end

return UINAcitvitySaveMoneyWithdrawOptionItem
