_class("ChapterInfo", Object)
ChapterInfo = ChapterInfo

function ChapterInfo:Constructor(config)
  self.ID = config.ID
  self.Num = config.ChapterNum
  self.Name = config.ChapterName
  self.Index = config.ChapterIndex
  self.Src = config.Src
  self.Position = config.Position
  self.LockLevel = config.LockLevel
end
