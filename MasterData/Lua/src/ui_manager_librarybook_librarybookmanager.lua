local this = class("librarybookManager")
local _librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()

function this:ctor()
end

function this:showLibraryReadingPage(seriesId)
  local curLibrarySeriesTpl = _librarySeriesTpl:getTplById(seriesId)
  if curLibrarySeriesTpl == nil then
    return
  end
  if #curLibrarySeriesTpl.subId == 1 and curLibrarySeriesTpl.subId[1] == L_Const.newsTypeLibraryBookReadingId then
    L_UI:open("pageLibraryBookNews", {})
  else
    L_UI:open("pageLibraryBookBrowse", {seriesId = seriesId})
  end
end

function this:showLibraryReadingPageByReadingId(readingId)
  if readingId == L_Const.newsTypeLibraryBookReadingId then
    L_UI:open("pageLibraryBookNews", {})
  else
    L_UI:open("pageLibraryBookBrowse", {bookBrowseId = readingId})
  end
end

return this
