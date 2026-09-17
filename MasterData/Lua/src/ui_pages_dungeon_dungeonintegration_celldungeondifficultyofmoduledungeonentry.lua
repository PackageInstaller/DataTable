local this = class("cellDungeonDifficultyOfModuleDungeonEntry", G_UIModuleBase)
local _dungeonTpl = L_GameTpl:getDungeonTpl()

function this.bind()
  return {
    toggle_isLock = false,
    active_img_selectBg = false,
    img_difficultyLevel = nil,
    active_hasNext = false
  }
end

function this.methods()
  return {
    onClick_cellDungeonDifficulty = function(self)
      self:onClickCellDungeonDifficulty()
    end
  }
end

function this:setParent(parent)
  self.parent = parent
end

function this:setDataAndViewIndex(dungeongTpl, viewIndex)
  self.dungeonTpl = dungeongTpl
  self.bind.toggle_isLock = not L_ConditionManager:isComplete(_dungeonTpl:getUnlockCondition(self.dungeonTpl))
  self.viewIndex = viewIndex
end

function this:refreshUI()
  if self.bind.toggle_isLock then
    return
  end
  self.bind.img_difficultyLevel = _dungeonTpl:getDifficultyIconPath(self.dungeonTpl, self.isSelect)
  self.bind.active_img_selectBg = self.isSelect
end

function this:setSelect(isSelect)
  if self.bind.toggle_isLock then
    return
  end
  self.isSelect = isSelect
  self:refreshUI()
end

function this:onClickCellDungeonDifficulty()
  self.parent:onClickCellDungeonDifficulty(self.viewIndex and self.viewIndex or self.bind.maxViewIndex)
end

return this
