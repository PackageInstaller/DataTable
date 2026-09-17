local this = class("starManualManager")
local starManualTpl = L_GameTpl:getStarManualTpl()
local starManualLevelTpl = L_GameTpl:getStarManualLevelTpl()
local systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()

function this:parseItem(configData)
  local openTime = starManualLevelTpl:getOpen(configData)
  local doubleTime = starManualLevelTpl:getDoubleTime(configData)
  local starManualId = starManualLevelTpl:getStarManualId(configData)
  local cost = starManualLevelTpl:getCost(configData)
  local open_hash = {}
  local double_hash = {}
  for i, v in pairs(openTime) do
    if open_hash[v] == nil then
      open_hash[v] = v
    end
  end
  local isDoubleTimeTxt = false
  if not table.isEmpty(doubleTime) then
    isDoubleTimeTxt = true
  end
  for i, v in pairs(doubleTime) do
    if double_hash[v] == nil then
      double_hash[v] = v
    end
  end
  local curWeekDay = L_TimeUtil.getCurWeekDay()
  local double_status = double_hash[curWeekDay] ~= nil and true or false
  local close_status = open_hash[curWeekDay] == nil and true or false
  local showLimit = starManualLevelTpl:getShow(configData) == 1
  local limit = starManualTpl:getLimitParam(starManualTpl:getTplById(starManualId))
  local limitLabel = ""
  if not math.isEmpty(limit) then
    showLimit = true
    limitLabel = string.format("%d/%d", limit, limit)
  end
  local data = {
    openTime = not close_status and (isDoubleTimeTxt and starManualLevelTpl:getDoubleDesc(configData) or starManualLevelTpl:getOpenDesc(configData)) or L_WordsTpl:getValue("ui_systemBreakManager_03"),
    name = starManualLevelTpl:getName(configData),
    desc = starManualLevelTpl:getDesc(configData),
    itemList = starManualLevelTpl:getItem(configData),
    cost = cost > L_PlayerStore:getCurrencyNum(L_Const.currencyType.stamina) and string.format("<color=#FF7E6D>%d</color>", cost) or tostring(cost),
    icon = starManualLevelTpl:getPic(configData),
    show_limit = showLimit,
    limit_label = limitLabel,
    show_close = close_status,
    up_status = double_status
  }
  return data
end

function this:dungeonJumpTo(id)
  local tpl = starManualLevelTpl:getTplById(id)
  local systemId = tonumber(starManualLevelTpl:getSystem(tpl))
  if not math.isEmpty(systemId) then
    L_SystemBreakManager:jumpTo(systemId)
  else
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("residual_code_starmanualmanager_01"),
      hideConfirm = true,
      hideCancel = true
    })
  end
end

return this
