local cls = class("cellEntrustTaskDifficulty", G_UIModuleBase)
local _dungeonEntrustDifficultyTpl = L_GameTpl:getDungeonEntrustDifficultyTpl()
local _ColorWhite = C_Color(1, 1, 1)
local _ColorGray = C_Color(0.498, 0.498, 0.498)

function cls.bind()
  return {txt_difficulty = "", color_imgBg = _ColorGray}
end

function cls.methods()
  return {
    onClick_select = function(self)
      if self.bind.cbk then
        self.bind.cbk(self)
      end
    end
  }
end

function cls:refresh()
  self.selectIndex = self.bind.selectIndex
  self.index = self.bind.index
  local cfg = _dungeonEntrustDifficultyTpl:getTplById(self.index)
  self.bind.txt_difficulty = _dungeonEntrustDifficultyTpl:getName(cfg)
  self:setSelected(self.selectIndex == self.index)
end

function cls:setSelected(bSelect)
  self.bind.color_imgBg = bSelect and _ColorWhite or _ColorGray
end

function cls:close(options)
  cls.super.close(self, options)
end

return cls
