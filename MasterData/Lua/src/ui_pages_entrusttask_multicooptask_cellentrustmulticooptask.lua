local cls = class("cellEntrustMultiCoopTask", G_UIModuleBase)
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
local _dungeonCrisisCrusadeTpl = L_GameTpl:getDungeonCrisisCrusadeTpl()
local _dungeonEntrustTagTpl = L_GameTpl:getDungeonEntrustTagTpl()
local _gameConstTpl = L_GameTpl:getGameConstTpl()
local scoreRankIconEnum = {
  [6] = "UI/Icon/PetScore/tex_icon_petscore_SSS.png",
  [5] = "UI/Icon/PetScore/tex_icon_petscore_SS.png",
  [4] = "UI/Icon/PetScore/tex_icon_petscore_S.png",
  [3] = "UI/Icon/PetScore/tex_icon_petscore_A.png",
  [2] = "UI/Icon/PetScore/tex_icon_petscore_B.png",
  [1] = "UI/Icon/PetScore/tex_icon_petscore_C.png"
}

function cls.bind()
  return {
    selectTab = -1,
    img_starNum = "",
    img_mainReward = "",
    img_mainReward2 = "",
    txt_levelName = "",
    txt_specialLevelName = "",
    txt_level = "",
    toggle_unlock = true,
    active_multiPlayer = false,
    list_levelTag = {
      moduleName = "pages/entrustTask/multiCoopTask/cellEntrustMultiCoopTaskTag"
    },
    txt_unlockCondition = "",
    go_select = false,
    active_specialLevelBg = false,
    active_normalLevelName = false,
    active_specialLevelName = false,
    active_unlockMask = false,
    active_leveltxt = false,
    active_mainReward = false,
    active_mainReward2 = false,
    active_surprise = false
  }
end

function cls.methods()
  return {
    onClick_select = function(self)
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function cls:refresh()
  self.maskHeightNum = 1
  self.dungeonEntrustCfg = _dungeonCrisisCrusadeTpl:getTplById(self.bind.levelId)
  self.curRoomLevelId = self.bind.curRoomLevelId
  self:refreshUnlockCondition()
  self:refreshFinishStatus()
  self:refreshTagList()
  self:setSelected(self.bind.levelId == self.bind.selectEntrustTaskId)
  self:setMultiPlayer(self.bind.levelId == self.bind.curRoomLevelId)
  local isSpecial = _dungeonCrisisCrusadeTpl:getEntrustType(self.dungeonEntrustCfg)
  if isSpecial == 2 then
    self.bind.active_specialLevelBg = true
    self.bind.active_surprise = true
    self.bind.active_specialLevelName = true
    self.bind.txt_specialLevelName = _dungeonCrisisCrusadeTpl:getName(self.dungeonEntrustCfg)
  else
    self.bind.active_surprise = false
    self.bind.active_normalLevelName = true
    self.bind.txt_levelName = _dungeonCrisisCrusadeTpl:getName(self.dungeonEntrustCfg)
  end
end

function cls:refreshFinishStatus()
  if not self.unlock then
    return
  end
  local levelScore = L_MultiDungeonStore:getMultiDungeonPassScore(self.bind.levelId)
  levelScore = levelScore or 0
  local starNum = self:calRank(levelScore)
  self.bind.selectTab = 0 < levelScore and 1 or 2
  if 0 < starNum then
    self.bind.img_starNum = scoreRankIconEnum[starNum]
  end
end

function cls:calRank(score)
  local dungeonEntrustCfg = _dungeonCrisisCrusadeTpl:getTplById(self.bind.levelId)
  local totalScore = _dungeonCrisisCrusadeTpl:getContributionValue(dungeonEntrustCfg)
  local perScore = score / totalScore
  local scoreMap = _gameConstTpl:getMultiDungeonGrade()
  local rank = 6
  for index = 1, #scoreMap do
    if perScore * 100 >= scoreMap[index][2] then
      return rank
    end
    rank = rank - 1
  end
  return rank
end

function cls:refreshTagList()
  local info = {}
  local tag = _dungeonCrisisCrusadeTpl:getTag(self.dungeonEntrustCfg)
  if tag then
    for i = #tag, 1, -1 do
      table.insert(info, {
        id = tag[i]
      })
    end
  end
  table.sort(info, function(a, b)
    local tpla = _dungeonEntrustTagTpl:getTplById(a.id)
    local tplb = _dungeonEntrustTagTpl:getTplById(b.id)
    return _dungeonEntrustTagTpl:getSort(tpla) < _dungeonEntrustTagTpl:getSort(tplb)
  end)
  self.bind.list_levelTag:clear()
  self.bind.list_levelTag:insert_array(info)
end

function cls:refreshUnlockCondition()
  local isComplete, strTips = L_MultiDungeonStore:getMultiDungeonIsUnlock(self.bind.levelId)
  self.unlock = isComplete
  if not isComplete then
    self.bind.selectTab = 3
  end
  self.bind.toggle_unlock = isComplete
  if not isComplete then
    self.bind.txt_unlockCondition = strTips
    self.bind.active_leveltxt = false
    self.bind.active_mainReward = false
    self.bind.active_mainReward2 = false
  else
    self.bind.active_leveltxt = true
    self.bind.txt_level = _dungeonCrisisCrusadeTpl:getRecLevelText(self.dungeonEntrustCfg)
    local mainReward = _dungeonCrisisCrusadeTpl:getMainRewardShow(self.dungeonEntrustCfg)
    if mainReward then
      local item = L_ItemTplManager:getItemConfig(mainReward[1].itemType, mainReward[1].itemId)
      if item then
        self.bind.active_mainReward = true
        self.bind.img_mainReward = item.icon
      end
      if mainReward[2] then
        local item2 = L_ItemTplManager:getItemConfig(mainReward[1].itemType, mainReward[1].itemId)
        if item2 then
          self.bind.active_mainReward2 = true
          self.bind.img_mainReward2 = item2.icon
        end
      end
    end
  end
end

function cls:adjustLockMaskHeight(num)
  self.bind.active_unlockMask = true
  self.maskHeightNum = num
  if not self.unlock then
    self.bindComponents.unlockMask.sizeDelta = L_Vector3.new(self.bindComponents.unlockMask.sizeDelta.x, 90 * self.maskHeightNum)
  end
end

function cls:hideMask()
  self.maskHeightNum = 1
  self.bind.active_unlockMask = false
end

function cls:setSelected(bSelect)
  self.bind.go_select = bSelect
end

function cls:setMultiPlayer(bSelect)
  self.bind.active_multiPlayer = bSelect
end

function cls:close(options)
  cls.super.close(self, options)
end

return cls
