local MAX_SHOW_ITEM_NUM = 4

local function createMainCopyProgressRewardPanelModelState(progressDrops, star, groupTid, getData, starRewardDatas)
  local state = {}
  state.progressDrops = progressDrops
  state.star = star
  state.groupTid = groupTid
  state.getData = getData
  state.starRewardDatas = starRewardDatas
  state.showRewardItemGroup = {}
  state.showFirstRewards = false
  return state
end

local function createMainCopyProgressRewardPanelModelViews(_)
  local views = {}
  
  function views:IsHaveReward()
    for _, item in ipairs(self.showRewardItemGroup) do
      if item.needStar <= self.star and not item.isGet then
        return true
      end
    end
  end
  
  return views
end

local function createMainCopyProgressRewardPanelModelActions(data)
  local actions = {}
  
  function actions:InitShowRewardItemGroup()
    local rst = {}
    if data.progressDrops then
      rst = CopyDataUtils.GetShowRewardItemGroup(data.progressDrops, data.star, data.getData, data.groupTid)
    elseif data.starRewardDatas then
      rst = CopyDataUtils.GetShowRewardItemGroupByStarItemReward(data.starRewardDatas, data.star, data.getData, data.groupTid)
    end
    self:SetShowRewardItemGroup(rst)
  end
  
  function actions:SetShowRewardItemGroup(groupVal)
    if not groupVal then
      return
    end
    if #groupVal > MAX_SHOW_ITEM_NUM then
      table.sort(groupVal, function(a, b)
        local aNeedStar = a.needStar
        local bNeedStar = b.needStar
        local aIsGet = a.isGet and 1 or 0
        local bIsGet = b.isGet and 1 or 0
        if aIsGet == bIsGet then
          return aNeedStar < bNeedStar
        end
        return aIsGet < bIsGet
      end)
    else
      table.sort(groupVal, function(a, b)
        return a.needStar < b.needStar
      end)
    end
    data.showRewardItemGroup = groupVal
  end
  
  function actions:SetShowFirstRewards(boolVal)
    if nil == boolVal then
      return
    end
    data.showFirstRewards = boolVal
  end
  
  function actions:MarkRewardGot()
    local curGroupData = CopyMainModel.Instance:GetGroupData(data.groupTid)
    if not curGroupData.starGainInfo then
      curGroupData.starGainInfo = {}
    end
    for _, item in ipairs(data.showRewardItemGroup) do
      if item.needStar <= data.star then
        item.isGet = true
        curGroupData.starGainInfo[item.needStar] = true
      end
    end
  end
  
  return actions
end

local function onSetup(_, model)
  model:InitShowRewardItemGroup()
end

local MainCopyProgressRewardPanelModel = Vue.model("MainCopyProgressRewardPanelModel", createMainCopyProgressRewardPanelModelState):views(createMainCopyProgressRewardPanelModelViews):actions(createMainCopyProgressRewardPanelModelActions):setup(onSetup)
return MainCopyProgressRewardPanelModel
