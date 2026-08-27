local TinyGameUtil = {}

function TinyGameUtil.CreateMineTinyGameGrade(maxScore)
  local mineGrade = {}
  mineGrade.name = PlayerDataCenter:GetSelfName()
  mineGrade.uid = PlayerDataCenter:GetSelfId()
  mineGrade.score = maxScore or 0
  return mineGrade
end

function TinyGameUtil.CreateFriendTinyGameDatas(cat, gameId)
  if not PlayerDataCenter.friendDataCenter:IsFriendDataCenterInited() then
    return {}
  end
  local friendsData = PlayerDataCenter.friendDataCenter:GetFreindList()
  if friendsData == nil or #friendsData <= 0 then
    return {}
  end
  local allGrades = {}
  for _, v in ipairs(friendsData) do
    local eachFriendGrade = {}
    eachFriendGrade.name = v:GetUserName()
    eachFriendGrade.score = 0
    eachFriendGrade.uid = v:GetUserUID()
    local tinyGame = v:GetTinyGameData(cat, gameId)
    if tinyGame ~= nil then
      eachFriendGrade.score = tinyGame.score
    end
    table.insert(allGrades, eachFriendGrade)
  end
  return allGrades
end

function TinyGameUtil.SortTinyGameRankDatas(allFriendData, mineGrade)
  if 1 < #allFriendData then
    table.sort(allFriendData, function(a, b)
      if a.score == b.score then
        return a.uid < b.uid
      else
        return a.score > b.score
      end
    end)
  end
  if mineGrade == nil then
    return 0
  end
  local myRank = 0
  for index, data in pairs(allFriendData) do
    if data == mineGrade then
      myRank = index
    end
  end
  return myRank
end

return TinyGameUtil
