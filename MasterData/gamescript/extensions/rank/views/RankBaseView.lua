local RankBaseView, Super = NewClass("RankBaseView", BaseView)
local DEFAULT_PAGE_SIZE = 10
local DEFAULT_SCROLL_THRESHOLD = 0.05
local DEFAULT_REQUEST_INTERVAL = 1

function RankBaseView:ctor()
  Super.ctor(self)
  self._rankIsRequesting = false
  self._rankInvalidRefreshing = false
  self._rankPendingInvalidRefresh = false
  self._rankPage = 1
  self._rankPageSize = DEFAULT_PAGE_SIZE
  self._rankLastRequestTime = 0
  self._rankLastInvalidRefreshTime = 0
end

function RankBaseView:_SetRankPageSize(size)
  self._rankPageSize = size
end

function RankBaseView:_ResetRankPagination()
  self._rankPage = 1
  self._rankIsRequesting = false
  self._rankInvalidRefreshing = false
  self._rankPendingInvalidRefresh = false
  self._rankLastRequestTime = 0
  self._rankLastInvalidRefreshTime = 0
end

function RankBaseView:_TryThrottleRankRequest()
  if self._rankIsRequesting or self._rankInvalidRefreshing then
    return false
  end
  local now = TimerManager.totalTime
  if now - self._rankLastRequestTime < DEFAULT_REQUEST_INTERVAL then
    return false
  end
  self._rankLastRequestTime = now
  return true
end

function RankBaseView:_RequestRankPage()
  if self._rankIsRequesting or self._rankInvalidRefreshing then
    return
  end
  self._rankIsRequesting = true
  local startIndex = (self._rankPage - 1) * self._rankPageSize + 1
  local count = self._rankPageSize
  self:_DoRequestRankData(startIndex, count, function()
    self._rankIsRequesting = false
    self:_OnRankPageSuccess()
    self:_ScheduleInvalidRankRefresh()
  end, function()
    self._rankIsRequesting = false
    self._rankPage = math.max(1, self._rankPage - 1)
    self:_OnRankPageFail()
  end)
end

function RankBaseView:_NextRankPage()
  if not self:_TryThrottleRankRequest() then
    return
  end
  local listCount = self:_GetRankListCount()
  if listCount <= 0 then
    return
  end
  local rankType, subTid = self:_GetRankRefreshContext()
  local totalLen = rankType and RankModel.Instance:GetRankLengthData(rankType, subTid) or nil
  if totalLen and totalLen > 0 then
    if listCount >= totalLen then
      return
    end
  elseif 0 ~= listCount % self._rankPageSize then
    return
  end
  self._rankPage = math.max(1, math.floor(listCount / self._rankPageSize) + 1)
  self:_RequestRankPage()
end

function RankBaseView:_DoRequestRankData(startIndex, count, onSuccess, onFail)
  error("RankBaseView:_DoRequestRankData must be overridden by subclass")
end

function RankBaseView:_GetRankListCount()
  error("RankBaseView:_GetRankListCount must be overridden by subclass")
  return 0
end

function RankBaseView:_OnRankPageSuccess()
end

function RankBaseView:_OnRankPageFail()
end

function RankBaseView:_GetRankTableView()
  return nil
end

function RankBaseView:_GetRankRefreshContext()
  return nil, nil
end

function RankBaseView:_GetVisibleRankPageRange()
  local tableView = self:_GetRankTableView()
  if not tableView or not tableView.GetVisibleCount then
    return 1, 1
  end
  local visibleCount = tableView:GetVisibleCount()
  if visibleCount <= 0 then
    return self._rankPage, self._rankPage
  end
  local minIdx, maxIdx = math.huge, 0
  for i = 0, visibleCount - 1 do
    local cell = tableView:GetCellByIndex(i)
    if cell and cell.index then
      local rankIdx = cell.index + 1
      if minIdx > rankIdx then
        minIdx = rankIdx
      end
      if maxIdx < rankIdx then
        maxIdx = rankIdx
      end
    end
  end
  if minIdx == math.huge then
    return self._rankPage, self._rankPage
  end
  local minPage = math.floor((minIdx - 1) / self._rankPageSize) + 1
  local maxPage = math.floor((maxIdx - 1) / self._rankPageSize) + 1
  return minPage, maxPage
end

function RankBaseView:_GetRankScopePages(rankType, subTid)
  local visibleMinPage, visibleMaxPage = self:_GetVisibleRankPageRange()
  local pageSet = {}
  local pages = {}
  for page = visibleMinPage, visibleMaxPage do
    if not pageSet[page] then
      pageSet[page] = true
      pages[#pages + 1] = page
    end
  end
  local pendingPage = visibleMaxPage + 1
  local rankLength = RankModel.Instance:GetRankLengthData(rankType, subTid) or 0
  local pendingStartIndex = (pendingPage - 1) * self._rankPageSize + 1
  if rankLength >= pendingStartIndex and not pageSet[pendingPage] then
    pages[#pages + 1] = pendingPage
  end
  table.sort(pages)
  return pages
end

function RankBaseView:_CollectInvalidPagesInScope(rankType, subTid)
  local scopePages = self:_GetRankScopePages(rankType, subTid)
  local invalidPages = {}
  for _, page in ipairs(scopePages) do
    if RankModel.Instance:IsRankPageInvalid(rankType, subTid, page) then
      invalidPages[#invalidPages + 1] = page
    end
  end
  return invalidPages
end

function RankBaseView:_BuildContiguousPageRanges(pages)
  if 0 == #pages then
    return {}
  end
  table.sort(pages)
  local ranges = {}
  local startPage = pages[1]
  local endPage = pages[1]
  for i = 2, #pages do
    if pages[i] == endPage + 1 then
      endPage = pages[i]
    else
      ranges[#ranges + 1] = {startPage, endPage}
      startPage = pages[i]
      endPage = pages[i]
    end
  end
  ranges[#ranges + 1] = {startPage, endPage}
  return ranges
end

function RankBaseView:_TryThrottleInvalidRankRefresh()
  if self._rankInvalidRefreshing or self._rankIsRequesting then
    return false
  end
  local now = TimerManager.totalTime
  if now - self._rankLastInvalidRefreshTime < DEFAULT_REQUEST_INTERVAL then
    return false
  end
  self._rankLastInvalidRefreshTime = now
  return true
end

function RankBaseView:_RequestInvalidRankRanges(rankType, subTid, ranges, rangeIdx)
  if not ranges or rangeIdx > #ranges then
    self._rankInvalidRefreshing = false
    if self._rankPendingInvalidRefresh then
      self._rankPendingInvalidRefresh = false
      self:_TryRefreshInvalidRankPages()
    else
      self:_OnInvalidRankRefreshDone()
    end
    return
  end
  local startPage = ranges[rangeIdx][1]
  local endPage = ranges[rangeIdx][2]
  local startIndex = (startPage - 1) * self._rankPageSize + 1
  local count = (endPage - startPage + 1) * self._rankPageSize
  local rankLength = RankModel.Instance:GetRankLengthData(rankType, subTid)
  if rankLength and rankLength > 0 then
    count = math.min(count, rankLength - startIndex + 1)
  end
  if count <= 0 then
    self:_RequestInvalidRankRanges(rankType, subTid, ranges, rangeIdx + 1)
    return
  end
  self._rankInvalidRefreshing = true
  self:_DoRequestRankData(startIndex, count, function()
    self._rankInvalidRefreshing = false
    self:_RequestInvalidRankRanges(rankType, subTid, ranges, rangeIdx + 1)
  end, function()
    self._rankInvalidRefreshing = false
    self._rankPendingInvalidRefresh = false
    self:_OnInvalidRankRefreshFail()
  end)
end

function RankBaseView:_TryRefreshInvalidRankPages()
  local rankType, subTid = self:_GetRankRefreshContext()
  if not rankType then
    return false
  end
  if not self:_TryThrottleInvalidRankRefresh() then
    self._rankPendingInvalidRefresh = true
    return false
  end
  local invalidPages = self:_CollectInvalidPagesInScope(rankType, subTid)
  if 0 == #invalidPages then
    return false
  end
  local ranges = self:_BuildContiguousPageRanges(invalidPages)
  self:_RequestInvalidRankRanges(rankType, subTid, ranges, 1)
  return true
end

function RankBaseView:_ScheduleInvalidRankRefresh()
  local rankType, subTid = self:_GetRankRefreshContext()
  if not rankType then
    return
  end
  if RankModel.Instance:ConsumeRankOverlapPendingRefresh(rankType, subTid) then
    self:_TryRefreshInvalidRankPages()
  end
end

function RankBaseView:_OnInvalidRankRefreshDone()
end

function RankBaseView:_OnInvalidRankRefreshFail()
end

function RankBaseView:_ResetRankScroll(tableView)
  if tableView then
    tableView:SetOffset(0, false)
  end
end

function RankBaseView:_SetupRankScroll(tableView, threshold, onPageEnd)
  threshold = threshold or DEFAULT_SCROLL_THRESHOLD
  local callback = onPageEnd or function()
    self:_NextRankPage()
  end
  
  function tableView.onScrollValueChanged(_, vector2)
    if vector2.y < threshold then
      callback()
    end
    self:_TryRefreshInvalidRankPages()
  end
end

return RankBaseView
