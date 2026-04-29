_class("UISideEnterConst", Object)
UISideEnterConst = UISideEnterConst

function UISideEnterConst:Constructor()
end

function UISideEnterConst.GetCfg_ClassPrefab(cfgName, cfg, cls_key, pfb_key, baseClassName)
  local class = cfg and cfg[cls_key] or ""
  local prefab = cfg and cfg[pfb_key] or ""
  local errStr = ""
  if string.isnullorempty(class) then
    errStr = cls_key .. " 配置为空"
  elseif string.isnullorempty(prefab) then
    errStr = pfb_key .. " 配置为空"
  elseif string.isnullorempty(prefab) or not string.endwith(prefab, ".prefab") then
    errStr = pfb_key .. " 中配置的字段应该以 .prefab 结尾"
  else
    local type = Classes[class]
    if not type then
      errStr = cls_key .. " 中配置的 " .. class .. " 类型不存在"
    elseif not string.isnullorempty(baseClassName) and type._className ~= baseClassName and not type:IsChildOf(baseClassName) then
      errStr = cls_key .. " 中配置的 " .. class .. "不是 " .. baseClassName .. " 的子类"
    end
  end
  if not string.isnullorempty(errStr) then
    Log.exception("UISideEnterConst.GetCfg_ClassPrefab() ", cfgName, " ", errStr)
  end
  return class, prefab
end

function UISideEnterConst.GetCfg_SideEnterBtn(id)
  local cfg = Cfg.cfg_main_side_enter_btn[id]
  if cfg == nil then
    Log.exception("cfg_main_side_enter_btn[", id, "] = nil", debug.traceback())
  end
  return cfg
end

function UISideEnterConst.GetCfg_SideEnterBtn_Info(id)
  local cfgName = "cfg_main_side_enter_btn[" .. id .. "]"
  local cfg = UISideEnterConst.GetCfg_SideEnterBtn(id)
  local cls_key = "EntryClass"
  local pfb_key = "EntryPrefab"
  return UISideEnterConst.GetCfg_ClassPrefab(cfgName, cfg, cls_key, pfb_key, UISideEnterItem_Base._className)
end

function UISideEnterConst.GetCfg_SideEnterContent(id)
  local cfg = Cfg.cfg_main_side_enter_content[id]
  if cfg == nil then
    Log.exception("cfg_main_side_enter_content[", id, "] = nil", debug.traceback())
  end
  return cfg
end

function UISideEnterConst.GetCfgList_SideEnterEdge()
  local cfgs = Cfg.cfg_main_side_enter_edge({IsActive = true})
  return cfgs or {}
end

function UISideEnterConst.GetCfgList_SideEnterCenter()
  local cfgs = Cfg.cfg_main_side_enter_center({IsActive = true})
  table.sort(cfgs, function(a, b)
    if a.Hot ~= b.Hot then
      return a.Hot
    end
    return a.ID < b.ID
  end)
  return cfgs or {}
end

function UISideEnterConst.GetCfg_SideEnterContent_Info(id, type)
  local cfgName = "cfg_main_side_enter_content[" .. id .. "]"
  local cfg = UISideEnterConst.GetCfg_SideEnterContent(id)
  local cls_key = type == 2 and "PageClass" or "SingleClass"
  local pfb_key = type == 2 and "PagePrefab" or "SinglePrefab"
  return UISideEnterConst.GetCfg_ClassPrefab(cfgName, cfg, cls_key, pfb_key, UISideEnterCenterContentBase._className)
end

function UISideEnterConst.SpawnSideEnterLoader(TT, uiView, widgetName, cfgList, hideCallback, redCallback)
  local showTb = {}
  local showCfg = {}
  for i = 1, #cfgList do
    local btnKey = cfgList[i].BtnKey
    local btnCfg = UISideEnterConst.GetCfg_SideEnterBtn(btnKey)
    if UISideEnterBtnConst.CheckOpen(TT, btnCfg) then
      table.insert(showCfg, cfgList[i])
    end
  end
  local objs = UIWidgetHelper.SpawnObjects(uiView, widgetName, "UISideEnterLoader", #showCfg)
  for i = 1, #showCfg do
    objs[i]:SetData(TT, showCfg[i], hideCallback, redCallback)
    if objs[i]:GetShow() then
      table.insert(showTb, objs[i])
    end
  end
  return showTb
end
