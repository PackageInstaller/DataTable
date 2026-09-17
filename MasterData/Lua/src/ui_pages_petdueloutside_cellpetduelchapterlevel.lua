local cls = class("cellPetDuelChapterLevel", G_UIModuleBase)
local _kiboDuelGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()

function cls.bind()
  return {
    toggle_unlock = false,
    toggle_star1 = false,
    toggle_star2 = false,
    toggle_star3 = false,
    active_starRoot = false,
    txt_levelName = "",
    txt_levelOrder = "",
    active_select = false,
    list_lineNode = {
      moduleName = "pages/petDuelOutside/cellPetDuelLineNode"
    }
  }
end

function cls.methods()
  return {
    onClick_select = function(self)
      if not L_PetDuelStore:checkChapterLevelUnlocked(self.levelId, true) then
        return
      end
      if self.levelId == self.selectLevelId then
        return
      end
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function cls:refresh()
  self.levelId = self.bind.levelId
  self.selectLevelId = self.bind.selectLevelId
  self:refreshView()
end

function cls:refreshView()
  self.bUnlocked = L_PetDuelStore:checkChapterLevelUnlocked(self.levelId, false)
  self.bind.toggle_unlock = self.bUnlocked
  local hasPassed = L_PetDuelStore:getIsSuccess(self.levelId)
  self.bind.active_starRoot = hasPassed
  if hasPassed then
    local starData = L_PetDuelStore:getKiBoDuelStar(self.levelId)
    for i = 1, 3 do
      if not starData[i] then
        self.bind["toggle_star" .. i] = true
      else
        self.bind["toggle_star" .. i] = false
      end
    end
  end
  local cfg = _kiboDuelGroupTpl:getTplById(self.levelId)
  self.bindComponents.rect.anchoredPosition3D = L_PetDuelStore:getChapterLevelPos(self.levelId)
  self.bind.txt_levelName = _kiboDuelGroupTpl:getLevelName(cfg)
  self.bind.txt_levelOrder = _kiboDuelGroupTpl:getLevelNum(cfg)
  self.bind.active_select = self.levelId == self.selectLevelId
  self:refreshLineNode()
end

function cls:refreshLineNode()
  local cellWidth = L_PetDuelStore:getChapterLevelCellWidth()
  local listNodeInfo = {}
  local preCondition = _kiboDuelGroupTpl:getPreCondition(self.levelId)
  if preCondition then
    for _, preLevelId in ipairs(preCondition) do
      local curPos = L_PetDuelStore:getChapterLevelPos(self.levelId)
      local prePos = L_PetDuelStore:getChapterLevelPos(preLevelId)
      local sizeDelta = (math.abs(curPos.x - prePos.x) - cellWidth) / 2
      table.insert(listNodeInfo, {
        posType = L_PetConst.PetDuelLinePosEnums.PreCondition,
        sizeDelta = sizeDelta
      })
    end
  end
  local afterCondition = _kiboDuelGroupTpl:getAfterCondition(self.levelId)
  if afterCondition then
    for _, afterLevelId in ipairs(afterCondition) do
      local curPos = L_PetDuelStore:getChapterLevelPos(self.levelId)
      local afterPos = L_PetDuelStore:getChapterLevelPos(afterLevelId)
      local sizeDelta = (math.abs(curPos.x - afterPos.x) - cellWidth) / 2
      table.insert(listNodeInfo, {
        posType = L_PetConst.PetDuelLinePosEnums.AfterCondition,
        sizeDelta = sizeDelta
      })
      if math.abs(curPos.y - afterPos.y) >= 1 then
        table.insert(listNodeInfo, {
          posType = L_PetConst.PetDuelLinePosEnums.Vertical,
          sizeDelta = math.abs(curPos.y - afterPos.y),
          posX = sizeDelta + cellWidth,
          posY = (curPos.y + afterPos.y) / 2 - curPos.y
        })
      end
    end
  end
  self.bind.list_lineNode:clear()
  self.bind.list_lineNode:insert_array(listNodeInfo)
end

return cls
