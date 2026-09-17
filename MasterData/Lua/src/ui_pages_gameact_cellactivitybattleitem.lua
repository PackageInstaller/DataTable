local this = class("cellActivityBattleItem", G_UIModuleBase)
local _GameEventKiboDuleTpl = L_GameTpl:getGameEventsKiboDuelTpl()
local _kiboDuelTpl = L_GameTpl:getKiboDuelTpl()
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this.bind()
  return {
    txt_name = "",
    item_id = 0,
    img_bg_unselect = true,
    img_bg_select = false,
    img_star_1 = false,
    img_star_1_up = false,
    img_star_2 = false,
    img_star_2_up = false,
    img_star_3 = false,
    img_star_3_up = false,
    img_level_order = Unity.Color.white,
    img_level_order_i = "",
    img_bg_light_noraml = 1.0,
    img_level_order_alpha = 0.6,
    img_bg_light_unselect = false,
    img_lock_bg = false,
    img_lock = false,
    canSelect = true
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      if self.bind.action ~= nil then
        self.bind.action(self.bind.id)
        self.bindComponents.tab_anim:Play("anim_act_kibobattle_level_cell_selected")
      else
        errorf("活动奖励" .. "cellActivityBattleItem.onClick_select: Action is nil", 2)
      end
      L_ReddotManager:markNew(L_ReddotManager.DotDef.GameAct_Events_Battle, self.bind.id)
      self.bindComponents.reddotNew.gameObject:SetActive(false, self.bind.id)
    end
  }
end

function this:ctor()
  this.super.ctor(self)
  self.starIconMap = {
    [1] = "UI/Atlas/Page/EntrustTask/tex_dungeonentrust_icon_wz04.png",
    [2] = "UI/Atlas/Page/EntrustTask/tex_dungeonentrust_icon_wz05.png",
    [3] = "UI/Atlas/Page/EntrustTask/tex_dungeonentrust_icon_wz06.png"
  }
  self.isSelect = false
  self.selectColor = {
    [1] = C_ColorUtility.TryParseHtmlString("#47516F"),
    [2] = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  }
end

function this:open()
  local tpl = _GameEventKiboDuleTpl:getTplById(self.bind.id)
  local name = _GameEventKiboDuleTpl:getName(tpl)
  local event_id = _GameEventKiboDuleTpl:getGroupId(tpl)
  self:refreshName(name)
  local level_id = _GameEventKiboDuleTpl:getKiboDuelId(tpl)
  local starData = L_PetDuelStore:getKiBoDuelStar(level_id)
  local starNum = 0
  if starData ~= nil then
    for i, v in pairs(starData) do
      if v then
        starNum = starNum + 1
      end
    end
  end
  local is_pass = L_GameEventStore:getGameEventData(event_id):getGameEvent():getLevelPass(self.bind.id)
  self.isTimeLock = false
  C_MJLog.LogDebug("活动测试，刷新节点id: " .. self.bind.id .. "红点数据", C_ELogModule.Home)
  self.isLock = self:checkLock()
  self:refreshState(self.isLock, is_pass, starNum)
  self:registerRedDot()
  self:refreshRedDot(self.isTimeLock)
  self.bind.item_id = self.bind.id
  self:refreshSelectState()
  self.bind.img_level_order_i = self.bind.LevelIconMap
  self.bindComponents.cellActivityBattleItemTabItem.enabled = false
  self.timer = Timer.once(1, function()
    self.bindComponents.cellActivityBattleItemTabItem.enabled = true
    Timer.remove(self.timer)
    self.timer = nil
  end, self)
end

function this:close()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:checkLock()
  local tpl = _GameEventKiboDuleTpl:getTplById(self.bind.id)
  local event_id = _GameEventKiboDuleTpl:getGroupId(tpl)
  local ex_id = _GameEventKiboDuleTpl:getExId(tpl)
  local ex_level_pass = false
  if ex_id == nil or ex_id == 0 then
    ex_level_pass = true
  else
    ex_level_pass = L_GameEventStore:getGameEventData(event_id):getGameEvent():getLevelPass(ex_id)
  end
  local event_tpl = _GameEventTpl:getTplById(event_id)
  local start_time = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(event_tpl))
  local end_time = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
  local unlock_day = _GameEventKiboDuleTpl:getUnlockTime(tpl)
  local level_start_time = start_time
  if 0 <= unlock_day - 1 then
    level_start_time = start_time + (unlock_day - 1) * 86400
  end
  local isLock = level_start_time < L_TimeUtil:getServerTime() and end_time > L_TimeUtil:getServerTime()
  self.isTimeLock = not isLock
  if self.isTimeLock then
    C_MJLog.LogDebug("活动测试，刷新节点id: " .. self.bind.id .. " self.isTimeLock 为true", C_ELogModule.Home)
  else
    C_MJLog.LogDebug("活动测试，刷新节点id: " .. self.bind.id .. " self.isTimeLock 为false", C_ELogModule.Home)
  end
  return not isLock or not ex_level_pass
end

function this:registerRedDot()
end

function this:refreshRedDot(isTimeLock)
  if not isTimeLock then
    C_MJLog.LogDebug("活动测试，刷新节点id: " .. self.bind.id .. " 刷新红点 状态 为true", C_ELogModule.Home)
    if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.GameAct_Events_Battle) then
      C_MJLog.LogDebug("活动测试，刷新节点id: " .. self.bind.id .. " 刷新红点 GameAct_Events_Battle状态 为true", C_ELogModule.Home)
    else
      C_MJLog.LogDebug("活动测试，刷新节点id: " .. self.bind.id .. " 刷新红点 GameAct_Events_Battle状态 为true", C_ELogModule.Home)
    end
    self.bindComponents.reddotNew.gameObject:SetActive(not L_ReddotManager:haveNew(L_ReddotManager.DotDef.GameAct_Events_Battle, self.bind.id))
  else
    C_MJLog.LogDebug("活动测试，刷新节点id: " .. self.bind.id .. " 刷新红点 状态 为false", C_ELogModule.Home)
    self.bindComponents.reddotNew.gameObject:SetActive(false)
  end
end

function this:refreshName(name)
  self.bind.txt_name = name
end

function this:refreshNumber(number)
  self.bind.img_number = number
end

function this:refreshState(isLock, is_pass, starNum)
  self.bind.go_lock = isLock
  self.bind.go_star = isLock or starNum ~= 0
  self.bind.go_pass = is_pass
  if self.starIconMap[starNum] ~= nil then
    self.bind.img_star = self.starIconMap[starNum]
  end
  self.bind.img_lock_bg = self.isTimeLock
  self.bind.img_lock = self.isTimeLock
  if not self.isTimeLock and L_ReddotManager:haveNew(L_ReddotManager.DotDef.GameAct_Events_Battle, self.bind.id) then
    self.bind.img_star_1 = true
    self.bind.img_star_2 = true
    self.bind.img_star_3 = true
  end
  if not self.isTimeLock and L_ReddotManager:haveNew(L_ReddotManager.DotDef.GameAct_Events_Battle, self.bind.id) then
    if starNum == 1 then
      self.bind.img_star_1_up = true
      self.bind.img_star_2_up = false
      self.bind.img_star_3_up = false
      self.bind.img_star_1 = false
      self.bind.img_star_2 = true
      self.bind.img_star_3 = true
    elseif starNum == 2 then
      self.bind.img_star_1_up = true
      self.bind.img_star_2_up = true
      self.bind.img_star_3_up = false
      self.bind.img_star_1 = false
      self.bind.img_star_2 = false
      self.bind.img_star_3 = true
    elseif starNum == 3 then
      self.bind.img_star_1_up = true
      self.bind.img_star_2_up = true
      self.bind.img_star_3_up = true
      self.bind.img_star_1 = false
      self.bind.img_star_2 = false
      self.bind.img_star_3 = false
    end
  end
end

function this:refreshSelectState()
  if not self.isTimeLock then
    if self.bindComponents.cellActivityBattleItemTabItem.Group.SelectedId == -1 or self.bindComponents.cellActivityBattleItemTabItem.Group.SelectedId == 0 then
      self.bind.img_lock_bg = false
    else
      self.bind.img_lock_bg = not self.bindComponents.cellActivityBattleItemTabItem.isOn
    end
  end
  local _, color_isOn = C_ColorUtility.TryParseHtmlString("#FFFFFF")
  local _, color_isDown = C_ColorUtility.TryParseHtmlString("#47516F")
  if self.bindComponents.cellActivityBattleItemTabItem.isOn then
    self.bind.img_bg_light_noraml = 0.5
    self.bind.img_level_order_alpha = 1
    self.bind.img_level_order = color_isOn
  else
    self.bind.img_bg_light_noraml = 1.0
    self.bind.img_level_order_alpha = 0.6
    self.bind.img_level_order = color_isDown
  end
end

function this:refreshImgMask(isMask)
  self.bind.img_lock_bg = isMask
end

function this:GetCellIndex()
  return self.bind.index_cell
end

return this
