_class("ChapterAwardData", Object)
ChapterAwardData = ChapterAwardData

function ChapterAwardData:Constructor()
  self.chapter_data = {}
  self.cfg = Cfg.cfg_mission_chapter_award()
end

function ChapterAwardData:Init()
  for k, v in pairs(self.cfg) do
    local c = ChapterAwardChapter:New()
    self.chapter_data[v.ChapterID] = c
    local serverChapterData = self:GetServerChapterDataByChapterId(v.ChapterID)
    if serverChapterData then
      c:UpdateStarCount(serverChapterData.star_count)
    end
    c.grades = {}
    for i, iv in ipairs(v.AwardItemIDList) do
      local g = ChapterAwardGrade:New()
      table.insert(c.grades, g)
      g.chapter_id = v.ChapterID
      g.star_count = iv.StarCount
      g.awards = {}
      local arr = self:GetSortedArr(iv.AwardItemList)
      if arr then
        for i, v in ipairs(arr) do
          table.insert(g.awards, v)
        end
      end
      g:UpdateCollected(serverChapterData)
    end
    c.previewAward = {}
    if v.previewAward then
      for index, iv in ipairs(v.previewAward) do
        local g = ChapterAwardPreview:New()
        g.startMissionId = iv[1]
        g.endMissionId = iv[2]
        g.index = iv[3]
        g.awardIndex = iv[4]
        table.insert(c.previewAward, g)
      end
    end
  end
end

function ChapterAwardData:GetSortedArr(list)
  if not list then
    return
  end
  local vecSort = SortedArray:New(Algorithm.COMPARE_CUSTOM, DiscoveryStage._LessComparer)
  for i, v in ipairs(list) do
    local award = Award:New()
    award:InitWithCount(v.ItemID, v.Count)
    vecSort:Insert(award)
  end
  return vecSort.elements
end

function ChapterAwardData._LessComparer(nItemIDA, nItemIDB)
  local cfgItemA = Cfg.cfg_item[nItemIDA.id]
  local cfgItemB = Cfg.cfg_item[nItemIDB.id]
  if not cfgItemA or not cfgItemB then
    return 0
  end
  if cfgItemA.Color < cfgItemB.Color then
    return -1
  elseif cfgItemA.Color > cfgItemB.Color then
    return 1
  elseif nItemIDA.id < nItemIDB.id then
    return 1
  elseif nItemIDA.id > nItemIDB.id then
    return -1
  else
    return 0
  end
end

function ChapterAwardData:GetServerChapterDataByChapterId(chapterId)
  local module = GameGlobal.GetModule(MissionModule)
  local serverData = module:GetChapterInfo()
  for i, v in pairs(serverData) do
    if chapterId == v.chapter_id then
      return v
    end
  end
end

function ChapterAwardData:GetChapterAwardChapterByChapterId(chapterId)
  return self.chapter_data[chapterId]
end

function ChapterAwardData:ChapterListCanCollect(chapterMap)
  for id, val in pairs(chapterMap) do
    if self.chapter_data[id] and self.chapter_data[id]:CanCollect() then
      return true
    end
  end
  return false
end

function ChapterAwardData:CanCollectWithoutChapter(data, chapterid)
  local section = data:GetDiscoverySectionByChapterId(chapterid)
  local chapters = section.chapterIds
  for id, value in pairs(chapters) do
    if self.chapter_data[id] and id ~= chapterid and self.chapter_data[id]:CanCollect() then
      return true
    end
  end
  return false
end

_class("ChapterAwardChapter", Object)
ChapterAwardChapter = ChapterAwardChapter

function ChapterAwardChapter:Constructor()
  self.star_count = 0
  self.grades = {}
end

function ChapterAwardChapter:UpdateStarCount(star_count)
  self.star_count = star_count
end

function ChapterAwardChapter:CanCollect()
  for i, v in ipairs(self.grades) do
    if v:CanCollect(self.star_count) then
      return true
    end
  end
  return false
end

_class("ChapterAwardGrade", Object)
ChapterAwardGrade = ChapterAwardGrade

function ChapterAwardGrade:Constructor()
  self.chapter_id = 0
  self.star_count = 0
  self.awards = {}
  self.collected = false
end

function ChapterAwardGrade:UpdateCollected(serverChapterData)
  if not serverChapterData then
    return
  end
  for i, v in ipairs(serverChapterData.receive_star_award_list) do
    if self.star_count == v then
      self.collected = true
      break
    end
  end
end

function ChapterAwardGrade:CanCollect(chapterStarCount)
  if not self.collected and chapterStarCount >= self.star_count then
    return true
  end
  return false
end

_class("ChapterAwardPreview", Object)
ChapterAwardPreview = ChapterAwardPreview

function ChapterAwardPreview:Constructor()
  self.startMissionId = 0
  self.endMissionId = 0
  self.index = 1
  self.awardIndex = 1
end
