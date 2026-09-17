local cls = class("cellPetDuelChapterMode", G_UIModuleBase)
local _modeNameEnums = {
  [1] = "ui_pagePetDuelChapterPass_02",
  [2] = "ui_pagePetDuelChapterPass_03"
}

function cls.bind()
  return {
    toggle_select = false,
    active_locked = false,
    txt_modeName = ""
  }
end

function cls.methods()
  return {
    onClick_select = function(self)
      if not L_PetDuelStore:checkChapterModeUnlock(self.modeId, true) then
        return
      end
      if self.modeId == self.bind.selectModeId then
        return
      end
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function cls:refresh()
  self.modeId = self.bind.modeId
  self.selectModeId = self.bind.selectModeId
  self:refreshView()
end

function cls:refreshView()
  self.bind.txt_modeName = L_WordsTpl:getValue(_modeNameEnums[self.modeId])
  self.bind.active_locked = not L_PetDuelStore:checkChapterModeUnlock(self.modeId, false)
  self.bind.toggle_select = self.modeId == self.selectModeId
end

return cls
