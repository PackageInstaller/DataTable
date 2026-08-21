_class("GuideWarnCheck", Object)
GuideWarnCheck = GuideWarnCheck

function GuideWarnCheck:CheckMainLobby()
  self:CheckController("UIMainLobbyController")
end

function GuideWarnCheck:CheckController(controllerName)
  local controller = GameGlobal.UIStateManager():GetController(controllerName)
  if not controller then
    Log.error("can't find controller " .. controllerName)
  end
  local context = {}
  context.sum = 0
  context.err = 0
  context.special = 0
  context.errIds = {}
  context.specailIs = {}
  local cfgs = Cfg.cfg_guide_warn({})
  for k, v in pairs(cfgs) do
    if v.guideController and v.guideController == controllerName then
      context.sum = context.sum + 1
      local state = self:GetBtn(controller, v)
      if state < 0 then
        context.err = context.err + 1
        table.insert(context.errIds, v.id)
      elseif state == 1 then
        context.special = context.special + 1
        table.insert(context.specailIs, v.id)
      end
    end
  end
  local pass = context.sum - context.err - context.special
  Log.error("一共检查 " .. context.sum .. " 条, 通过 " .. pass .. " 条， 错误 " .. context.err .. " 条, 特殊未检出 " .. context.special .. " 条")
  if 0 < context.err then
    Log.error("错误的条目:")
    local errMsg = table.concat(context.errIds, ",")
    Log.error(errMsg)
  end
  if 0 < context.special then
    Log.error("特殊未检查的条目:")
    local msg = table.concat(context.specailIs, ",")
    Log.error(msg)
  end
end

function GuideWarnCheck:GetBtn(controller, btnGuideCfg)
  local widgets = btnGuideCfg.guideUI
  local btn = btnGuideCfg.guideArea
  local go, parent, scrollRect, owner
  local special = tonumber(btn)
  if special then
    return 1
  elseif not widgets or #widgets <= 0 then
    go = controller:GetGameObject(btn)
    parent = controller:View():GetGameObject().transform:Find("UICanvas").transform
  else
    local deep = #widgets
    go, owner = controller:GetGameObjectInCustomWidget(widgets[1], btn)
    if owner and 1 < deep then
      for i = 2, deep do
        owner = owner:GetCustomWidget(widgets[i])
      end
      if owner then
        go = owner:GetGameObject(btn)
      end
    end
  end
  if go then
    return 0
  end
  return -1
end
