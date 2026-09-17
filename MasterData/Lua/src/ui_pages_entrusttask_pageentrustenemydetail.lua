local cls = class("pageEntrustEnemyDetail", G_UIPageBase)
local _dungeonTpl = L_GameTpl:getDungeonTpl()
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _petTpl = L_GameTpl:getPetTpl()

function cls.bind()
  return {
    list_enemy = {
      moduleName = "pages/entrustTask/cellEntrustEnemy"
    },
    txt_enemyName = "",
    txt_enemyLevel = "",
    txt_enemyDesc = "",
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function cls.methods()
  return {
    module_commonTipLarge = {
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  self.entrustType = options.entrustType
  self.dungeonId = options.dungeonId
  self.selectIndex = options.selectIndex or 1
  self:initCommonTipModule()
  self:initPage()
end

function cls:open(options)
end

function cls:initCommonTipModule()
  local moduleTip = self.modules.module_commonTipLarge
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("residual_code_pageentrustenemydetail_01"),
    hideConfirm = true,
    hideCancel = true
  })
end

function cls:initPage()
  local function onClick_select(cell)
    if self.selectIndex ~= cell.bind.index then
      self.selectIndex = cell.bind.index
      
      self.bindComponents.anim_content:Stop()
      self.bindComponents.anim_content:Rewind()
      self.bindComponents.anim_content:Play("anim_entrust_enemy_change")
      for i = 1, #self.bind.list_enemy do
        self.bind.list_enemy:change(i, {
          selectIndex = self.selectIndex
        })
      end
      self:refreshSelectInfo()
    end
  end
  
  if self.entrustType == L_Const.EntrustTypeEnum.PetDuel then
    local curKiBoDuelCfg = _kiBoDuelTpl:getTplById(self.dungeonId)
    self.enemyInfo = {}
    for k, v in pairs(_kiBoDuelTpl:getEnemy(curKiBoDuelCfg)) do
      table.insert(self.enemyInfo, {
        selectIndex = self.selectIndex,
        id = k,
        level = v,
        cbk = onClick_select,
        entrustType = L_Const.EntrustTypeEnum.PetDuel
      })
    end
    table.sort(self.enemyInfo, function(a, b)
      return a.id < b.id
    end)
    for index, v in ipairs(self.enemyInfo) do
      v.index = index
    end
  elseif self.entrustType == L_Const.EntrustTypeEnum.Rogue then
    local rogueActivityTpl = L_GameTpl:getRogueActivityTpl()
    local rogueActivityCfg = rogueActivityTpl:getTplById(self.dungeonId)
    self.enemyInfo = {}
    if rogueActivityCfg then
      for idx, enemyId in ipairs(rogueActivityTpl:getEnemy(rogueActivityCfg)) do
        table.insert(self.enemyInfo, {
          selectIndex = self.selectIndex,
          index = idx,
          id = enemyId,
          level = 10,
          cbk = onClick_select
        })
      end
    end
  else
    local cfg = _dungeonTpl:getTplById(self.dungeonId)
    local enemyList
    if self.entrustType == L_Const.EntrustTypeEnum.MultiCoopEntrust then
      enemyList = self:getDungeonEnemySortDataMult(self.dungeonId)
    else
      enemyList = self:getDungeonEnemySortData(self.dungeonId)
    end
    self.enemyInfo = {}
    for i, v in ipairs(enemyList) do
      table.insert(self.enemyInfo, {
        selectIndex = self.selectIndex,
        index = i,
        id = v,
        level = _dungeonTpl:getDiffType(cfg),
        cbk = onClick_select
      })
    end
  end
  self.bind.list_enemy:clear()
  self.bind.list_enemy:insert_array(self.enemyInfo)
  self:refreshSelectInfo()
end

function cls:getDungeonEnemySortDataMult(dungeonId)
  local cfg = _dungeonTpl:getTplById(dungeonId)
  local enemyList = _dungeonTpl:getEnemy(cfg)
  local infos = {}
  for i, v in ipairs(enemyList) do
    local id, level = table.unpack(v)
    if _enemyTpl:getTplById(id) then
      table.insert(infos, id)
    end
  end
  table.sort(infos, function(a, b)
    local tplA = _enemyTpl:getTplById(a)
    local tplB = _enemyTpl:getTplById(b)
    if tplA and tplB then
      return tplA.enemyType < tplB.enemyType
    else
      return false
    end
  end)
  return infos
end

function cls:getDungeonEnemySortData(dungeonId)
  local cfg = _dungeonTpl:getTplById(dungeonId)
  local enemyList = _dungeonTpl:getEnemy(cfg)
  local sortData = {}
  local priority = {
    [L_Const.enemyType.boss] = 3,
    [L_Const.enemyType.elite] = 2,
    [L_Const.enemyType.normal] = 1
  }
  for i = 1, #enemyList do
    local v = enemyList[i]
    local id, level = table.unpack(v)
    local tpl = _enemyTpl:getTplById(id)
    if tpl then
      local p = priority[tpl.enemyType] or 0
      table.insert(sortData, {
        id = id,
        p = p,
        index = i
      })
    end
  end
  table.sort(sortData, function(a, b)
    if a.p == b.p then
      return a.index < b.index
    else
      return a.p > b.p
    end
  end)
  local finalInfos = {}
  for i = 1, #sortData do
    finalInfos[i] = sortData[i].id
  end
  return finalInfos
end

function cls:refreshSelectInfo()
  if self.entrustType == L_Const.EntrustTypeEnum.PetDuel then
    local petCfgId = self.enemyInfo[self.selectIndex].id
    local petCfg = _petTpl:getTplById(petCfgId)
    self.bind.txt_enemyName = _petTpl:getName(petCfg)
    self.bind.txt_enemyLevel = string.format("Lv.%s", self.enemyInfo[self.selectIndex].level)
    self.bind.txt_enemyDesc = _petTpl:getDesc(petCfg)
    return
  end
  local enemyId = self.enemyInfo[self.selectIndex].id
  local enemyCfg = _enemyTpl:getTplById(enemyId)
  self.bind.txt_enemyName = _enemyTpl:getName(enemyCfg)
  self.bind.txt_enemyLevel = string.format("Lv.%s", self.enemyInfo[self.selectIndex].level)
  self.bind.txt_enemyDesc = _enemyTpl:getDesc(enemyCfg)
end

function cls:close(options)
  cls.super.close(self, options)
end

return cls
