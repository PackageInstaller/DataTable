_class("UIActivityNPlusSixConst", Object)
UIActivityNPlusSixConst = UIActivityNPlusSixConst

function UIActivityNPlusSixConst:Constructor()
end

function UIActivityNPlusSixConst.GetCoinItemId()
  return 3000214
end

function UIActivityNPlusSixConst.GetItemIconName()
  local cfg = Cfg.cfg_item[UIActivityNPlusSixConst.GetCoinItemId()]
  if not cfg then
    return nil
  end
  return cfg.Icon
end
