local cls = class("pagePetDuelChapterPass", G_UIPageBase)
local _kiboDuelChapterTpl = L_GameTpl:getKiBoDuelChapterTpl()
local _modeNameEnums = {
  [1] = "ui_pagePetDuelChapterPass_02",
  [2] = "ui_pagePetDuelChapterPass_03"
}

function cls.bind()
  return {txt_chapterPassed = "", txt_modeName = ""}
end

function cls.methods()
  return {}
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  self.chapterId = options.chapterId
end

function cls:open(options)
  self:initPage()
end

function cls:initPage()
  local keyString = L_PetDuelStore:getChapterChallengeSuccessSaveKey(self.chapterId)
  C_PlayerPrefsUtility.SetBool(keyString, true)
  local cfg = _kiboDuelChapterTpl:getTplById(self.chapterId)
  local index = _kiboDuelChapterTpl:getIndex(cfg)
  local mode = _kiboDuelChapterTpl:getModeId(cfg)
  self.bind.txt_chapterPassed = L_WordsTpl:getValue("ui_pagePetDuelChapterPass_01", {
    [0] = index
  })
  self.bind.txt_modeName = L_WordsTpl:getValue(_modeNameEnums[mode])
  self.info1Timer = Timer.once(2, function()
    L_UI:close(self.pageName)
  end, self)
end

function cls:escHandle()
end

function cls:close(options)
  cls.super.close(self, options)
  L_PetDuelStore:call(L_PetDuelStore.event.chapterPass_close, self.chapterId)
end

return cls
