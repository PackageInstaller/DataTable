local this = class("pageRecentAchieve", G_UIPageBase)

function this.bind()
  return {
    recentAchieveList = {
      moduleName = "pages/ActivityTask/cellActivityTaskItem"
    }
  }
end

function this.methods()
  return {
    onclick_close = function(self)
      print("=========================guanbi界面")
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  local showList = {}
  local allAchieve = L_AchievementUtil.getFinishMap()
  for key, value in pairs(allAchieve) do
    if value ~= 0 then
      print("=========================================id", key)
      table.insert(showList, {
        index = #showList + 1,
        id = key,
        bAchieve = true,
        selIndex = -1,
        finishTime = value
      })
    end
  end
  table.sort(showList, function(a, b)
    return a.finishTime > b.finishTime
  end)
  self.bind.recentAchieveList:clear()
  self.bind.recentAchieveList:insert_array(showList)
end

function this:close(options)
end

function this:show()
end

return this
