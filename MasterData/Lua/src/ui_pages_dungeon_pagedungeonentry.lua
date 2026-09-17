local this = class("pageDungeonEntry", G_UIPageBase)
local _dungeonTpl = L_GameTpl:getDungeonTpl()
local _staminaChestDropTpl = L_GameTpl:getStaminaChestDropTpl()

function this.bind()
  return {
    txt_groupName = nil,
    scrollList_group = {
      moduleName = "pages/dungeon/cellDungeonGroup"
    },
    txt_name = nil,
    go_difficulty = false,
    scrollList_difficulty = {
      moduleName = "pages/dungeon/cellDungeonDifficulty"
    },
    go_bossTips = false,
    txt_bossDifficulty = nil,
    go_buff = false,
    txt_buff = nil,
    scrollList_enemy = {
      moduleName = "pages/dungeon/cellDungeonEnemy"
    },
    txt_rewardTips = nil,
    scrollList_reward = {
      moduleName = "pages/dungeon/cellDungeonReward"
    },
    go_upTips = false,
    txt_upTips = nil
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_go = function(self)
      self:checkGo()
    end,
    scrollList_group = {
      onClick_select = function(self, bind)
        if bind.go_select then
          return
        end
        self._selectGroupId = bind.groupId
        self:initDifficultyList()
        self:initDungeonInfo()
        self:setDungeonGroupListActive()
      end
    },
    scrollList_difficulty = {
      onClick_select = function(self, bind)
        if bind.go_select then
          return
        end
        if bind.go_lock then
          local desc = L_ConditionManager:getDescs(_dungeonTpl:getUnlockCondition(_dungeonTpl:getTplById(bind.dungeonId)))
          L_FlyMsgManager:showNormalMsg(desc[1])
          return
        end
        self._selectDungeonId = bind.dungeonId
        self:setDifficultyListActive()
        self:initDungeonInfo()
      end
    }
  }
end

function this:check(options, callback)
  callback(true)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_refreshStamina, self)
  self._curDoorId = options.doorId
  if math.isEmpty(self._curDoorId) then
    errorf(string.format("pageDungeonEntry:preOpen 参数错误 doorId:%s", self._curDoorId))
    return
  end
  self:loadVirtualCamera(options.entity)
  self:initPage()
end

function this:close(options)
  this.super.close(self, options)
  self:unloadVirtualCamera()
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_refreshStamina)
end

function this:show()
end

function this:initPage()
  self:initDungeonGroupList()
  self:initDifficultyList()
  self:initDungeonInfo()
end

function this:initDungeonGroupList()
  local dungeonConfig = _dungeonTpl:getTplListByDoorId(self._curDoorId)
  local tmp = {}
  for groupId, tplList in pairs(dungeonConfig) do
    table.insert(tmp, {
      groupId = groupId,
      doorId = self._curDoorId
    })
  end
  self._selectGroupId = tmp[1].groupId
  self.bind.scrollList_group:clear()
  self.bind.scrollList_group:insert_array(tmp)
  self:setDungeonGroupListActive()
end

function this:setDungeonGroupListActive()
  for i, v in pairs(self.modules.scrollList_group) do
    v:setSelect(self._selectGroupId == v.bind.groupId)
  end
end

function this:initDifficultyList()
  local tplList = _dungeonTpl:getTplListByDoorIdAndGroupId(self._curDoorId, self._selectGroupId)
  local tmp_difficulty = {}
  for _, tpl in pairs(tplList) do
    table.insert(tmp_difficulty, {
      dungeonId = _dungeonTpl:getId(tpl),
      dungeonGroupOrder = _dungeonTpl:getDungeonGroupOrder(tpl)
    })
  end
  table.sort(tmp_difficulty, function(a, b)
    return a.dungeonGroupOrder < b.dungeonGroupOrder
  end)
  local count = #tmp_difficulty
  tmp_difficulty[count].go_line = false
  self._selectDungeonId = tmp_difficulty[1].dungeonId
  self.bind.scrollList_difficulty:clear()
  self.bind.scrollList_difficulty:insert_array(tmp_difficulty)
  self:setDifficultyListActive()
end

function this:setDifficultyListActive()
  for i, v in pairs(self.modules.scrollList_difficulty) do
    v:setSelect(self._selectDungeonId == v.bind.dungeonId)
  end
  self.bind.txt_groupName = _dungeonTpl:getGroupName(_dungeonTpl:getTplById(self._selectDungeonId))
end

function this:initDungeonInfo()
  local tpl_dungeon = _dungeonTpl:getTplById(self._selectDungeonId)
  self.bind.txt_name = _dungeonTpl:getName(tpl_dungeon)
  local dungeonSystemType = _dungeonTpl:getDungeonSystemType(tpl_dungeon)
  local isBoss = dungeonSystemType == L_DungeonConst.DungeonSystemType.WeekBoss
  if isBoss then
    self.bind.txt_rewardTips = L_WordsTpl:getValue("notice_pageDungeonEntry_03", {
      [0] = 1
    })
  else
    self.bind.txt_rewardTips = L_WordsTpl:getValue("notice_pageDungeonEntry_02", {
      [0] = _dungeonTpl:getNeedPower(tpl_dungeon)
    })
  end
  self.bind.go_difficulty = not isBoss
  self.bind.go_bossTips = isBoss
  if isBoss then
    self.bind.txt_bossDifficulty = L_DungeonConst.RomeNumber[L_WorldLevelStore:getServerLevelInfo().cur_level]
  end
  local enemy = _dungeonTpl:getEnemy(tpl_dungeon)
  local tmp_enemy = {}
  for i, v in pairs(enemy) do
    local id, level = table.unpack(v)
    table.insert(tmp_enemy, {id = id, level = level})
  end
  self.bind.scrollList_enemy:clear()
  self.bind.scrollList_enemy:insert_array(tmp_enemy)
  local tmp_reward = {}
  local tpl_staminaChest = _staminaChestDropTpl:getTplByWorldFilter(L_Const.StaminaBoxSystemType.SBST_CAMPAIGN, self._selectDungeonId)
  local leftRewardTime, isUp = L_StaminaChestManager:getStaminaRewardTimes(_staminaChestDropTpl:getId(tpl_staminaChest))
  local reward = L_DataUtil.parseRangeRewardConfig(isUp and _staminaChestDropTpl:getRewardDisplayUp(tpl_staminaChest) or _staminaChestDropTpl:getRewardDisplay(tpl_staminaChest))
  for _, v in pairs(reward) do
    table.insert(tmp_reward, {
      itemType = v.itemType,
      itemId = v.itemId,
      itemNumTxt = v.itemNumTxt,
      go_up = isUp
    })
  end
  self.bind.scrollList_reward:clear()
  self.bind.scrollList_reward:insert_array(tmp_reward)
  self.bind.go_upTips = not table.isEmpty(_dungeonTpl:getUpDuration(tpl_dungeon))
  self.bind.txt_upTips = nil
  self.bindComponents.graphicGroup_upTips.color = isUp and C_Color(0.9333333, 0.5960785, 0.1607843, 1) or C_Color(1, 1, 1, 0.55)
end

function this:checkGo()
  local curStamina = L_PlayerStore:getCurrencyNum(L_Const.currencyType.stamina)
  local tpl_dungeon = _dungeonTpl:getTplById(self._selectDungeonId)
  
  local function endDo()
  end
  
  if curStamina < _dungeonTpl:getNeedPower(tpl_dungeon) then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_pageDungeonEntry_01"),
      confirmCallback = endDo,
      showNoMoreType = L_Const.ShowNoMoreType.today,
      showNoMoreKey = L_Const.ShowNoMoreKey.pageDungeonEntry_start
    })
    return
  end
  endDo()
end

function this:onEvent_refreshStamina()
  local tpl_dungeon = _dungeonTpl:getTplById(self._selectDungeonId)
  local curStamina = L_PlayerStore:getCurrencyNum(L_Const.currencyType.stamina)
  local consume = _dungeonTpl:getNeedPower(tpl_dungeon)
  local color = curStamina >= consume and L_Const.colorHtml.white001 or L_Const.colorHtml.red001
  self.bind.txt_stamina = L_GameUtil.fillColor(consume, color)
end

function this:loadVirtualCamera(entity)
  C_CameraManager.ActivateTactics(C_ECameraType.Dungeon, C_CinemachineBlendType.EaseIn, 800)
  local cameraController = C_CameraManager.GetTactics(C_ECameraType.Dungeon)
  cameraController:SetDungeonDoorId(entity:GetTransform(), self._curDoorId)
end

function this:unloadVirtualCamera()
  C_CameraManager.DeactivateTactics(C_ECameraType.Dungeon)
end

return this
