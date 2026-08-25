local RankPaginationMixin = {}
local DEFAULT_PAGE_SIZE = 10
local DEFAULT_SCROLL_THRESHOLD = 0.05
local DEFAULT_REQUEST_INTERVAL = 1

function RankPaginationMixin.Inject(class)
  for k, v in pairs(RankPaginationMixin) do
    if "Inject" ~= k and nil == class[k] then
      class[k] = v
    end
  end
end

function RankPaginationMixin:InitRankPagination()
  self._rankIsRequesting = false
  self._rankPage = 1
  self._rankPageSize = DEFAULT_PAGE_SIZE
  self._rankLastRequestTime = 0
end

function RankPaginationMixin:_SetRankPageSize(size)
  self._rankPageSize = size
end

function RankPaginationMixin:_ResetRankPagination()
  self._rankPage = 1
  self._rankIsRequesting = false
  self._rankLastRequestTime = 0
end

function RankPaginationMixin:_TryThrottleRankRequest()
  if self._rankIsRequesting then
    return false
  end
  local now = TimerManager.totalTime
  if now - self._rankLastRequestTime < DEFAULT_REQUEST_INTERVAL then
    return false
  end
  self._rankLastRequestTime = now
  return true
end

function RankPaginationMixin:_RequestRankPage()
  if self._rankIsRequesting then
    return
  end
  self._rankIsRequesting = true
  local startIndex = (self._rankPage - 1) * self._rankPageSize + 1
  local count = self._rankPageSize
  self:_DoRequestRankData(startIndex, count, function()
    self._rankIsRequesting = false
    self:_OnRankPageSuccess()
  end, function()
    self._rankIsRequesting = false
    self._rankPage = math.max(1, self._rankPage - 1)
    self:_OnRankPageFail()
  end)
end

function RankPaginationMixin:_NextRankPage()
  if not self:_TryThrottleRankRequest() then
    return
  end
  local listCount = self:_GetRankListCount()
  if listCount <= 0 then
    return
  end
  if self._GetRankTotalCount then
    local totalCount = self:_GetRankTotalCount()
    if totalCount and totalCount > 0 and listCount >= totalCount then
      return
    end
  elseif 0 ~= listCount % self._rankPageSize then
    return
  end
  self._rankPage = math.max(1, math.floor(listCount / self._rankPageSize) + 1)
  self:_RequestRankPage()
end

function RankPaginationMixin:_DoRequestRankData(startIndex, count, onSuccess, onFail)
  error("RankPaginationMixin:_DoRequestRankData must be overridden by host class")
end

function RankPaginationMixin:_GetRankListCount()
  error("RankPaginationMixin:_GetRankListCount must be overridden by host class")
  return 0
end

function RankPaginationMixin:_OnRankPageSuccess()
end

function RankPaginationMixin:_OnRankPageFail()
end

function RankPaginationMixin:_ResetRankScroll(tableView)
  if tableView then
    tableView:SetOffset(0, false)
  end
end

function RankPaginationMixin:_SetupRankScroll(tableView, threshold, onPageEnd)
  threshold = threshold or DEFAULT_SCROLL_THRESHOLD
  local callback = onPageEnd or function()
    self:_NextRankPage()
  end
  
  function tableView.onScrollValueChanged(_, vector2)
    if vector2.y < threshold then
      callback()
    end
  end
end

return RankPaginationMixin
