_class("MainTaskModule", GameModule)
MainTaskModule = MainTaskModule

function MainTaskModule:Constructor()
  self.chapterList = {}
end

function MainTaskModule:Init()
  self:ParseCfg()
end

function MainTaskModule:ParseCfg()
  self.chapterList = {}
  for _, v in pairs(ChapterConfig) do
    if not self.chapterList[v.ID] then
      self.chapterList[v.ID] = ChapterInfo:New(v)
    end
  end
end
