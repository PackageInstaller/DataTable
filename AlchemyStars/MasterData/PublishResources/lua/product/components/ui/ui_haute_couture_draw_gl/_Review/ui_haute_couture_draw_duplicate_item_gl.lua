_class("UIHauteCoutureDuplicateItemGL", UIHauteCoutureDuplicateItem)
UIHauteCoutureDuplicateItemGL = UIHauteCoutureDuplicateItemGL

function UIHauteCoutureDuplicateItemGL:SetBg(cfg)
  if cfg.RewardSortOrder == 10 then
    self.bg:LoadImage("glseniorfk_rule_di01")
  else
    self.bg:LoadImage("glseniorfk_rule_di102")
  end
end
