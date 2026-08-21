_class("UIHauteCoutureDuplicateItemPLM", UIHauteCoutureDuplicateItem)
UIHauteCoutureDuplicateItemPLM = UIHauteCoutureDuplicateItemPLM

function UIHauteCoutureDuplicateItemPLM:SetBg(cfg)
  if cfg.UIType == 1 then
    self.bg:LoadImage("plmsenior_rule_di03")
  elseif cfg.UIType == 2 or cfg.UIType == 3 then
    self.bg:LoadImage("plmsenior_rule_di07")
  else
    self.bg:LoadImage("plmsenior_rule_di04")
  end
end
