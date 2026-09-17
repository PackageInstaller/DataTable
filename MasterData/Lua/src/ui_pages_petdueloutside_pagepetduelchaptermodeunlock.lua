local cls = class("pagePetDuelChapterModeUnlock", G_UIPageBase)
local _modeNameEnums = {
  [1] = L_WordsTpl:getValue("ui_pagePetDuelChapterModeUnlock_01"),
  [2] = L_WordsTpl:getValue("ui_pagePetDuelChapterModeUnlock_02")
}

function cls.bind()
  return {txt_modeName = ""}
end

function cls.methods()
  return {}
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  self.modeId = options.modeId
end

function cls:open(options)
  self:initPage()
end

function cls:initPage()
  local keyString = L_PetDuelStore:getModeChallengeSuccessSaveKey(self.modeId)
  C_PlayerPrefsUtility.SetBool(keyString, true)
  self.bind.txt_modeName = _modeNameEnums[self.modeId]
  self.info1Timer = Timer.once(2, function()
    L_UI:close(self.pageName)
  end, self)
end

function cls:escHandle()
end

function cls:close(options)
  cls.super.close(self, options)
  L_PetDuelStore:call(L_PetDuelStore.event.chapterModeUnlock_close, self.modeId)
end

return cls
