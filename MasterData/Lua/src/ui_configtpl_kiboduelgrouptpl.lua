local this = class("kiboDuelGroupTpl")

function this:init(config)
  self.data = config
  self.preCondition = {}
  self.afterCondition = {}
  self.chapterInfo = {}
  self.chapterColMax = {}
  for levelId, v in pairs(config) do
    if not self.chapterInfo[v.chapterID] then
      self.chapterInfo[v.chapterID] = {}
    end
    table.insert(self.chapterInfo[v.chapterID], v)
    if v.nextLevel then
      for _, id in ipairs(v.nextLevel) do
        if not self.preCondition[id] then
          self.preCondition[id] = {}
        end
        table.insert(self.preCondition[id], levelId)
        if not self.afterCondition[levelId] then
          self.afterCondition[levelId] = {}
        end
        table.insert(self.afterCondition[levelId], id)
      end
    end
  end
end

function this:getValue()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getLevelId(tpl)
  return tpl.id
end

function this:getChapterId(tpl)
  return tpl.chapterID
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getStamina(tpl)
  return tpl.stamina
end

function this:getLevelName(tpl)
  return L_Config:provider(tpl.levelName)
end

function this:getLevelNum(tpl)
  return L_Config:provider(tpl.levelNum)
end

function this:getLevelNpc(tpl)
  return L_Config:provider(tpl.levelNpc)
end

function this:getDec(tpl)
  return L_Config:provider(tpl.dec)
end

function this:getOffset(tpl)
  return tpl.offset
end

function this:getNextLevel(tpl)
  return tpl.nextLevel
end

function this:getPreCondition(levelId)
  return self.preCondition[levelId]
end

function this:getAfterCondition(levelId)
  return self.afterCondition[levelId]
end

function this:getChapterLevelNum(chapterId)
  return table.count(self.chapterInfo[chapterId])
end

function this:getChapterLevelInfo(chapterId)
  return self.chapterInfo[chapterId] or {}
end

function this:getChapterColMax(chapterId)
  return self.chapterColMax[chapterId]
end

return this
