local this = class("cellRewardTab", G_UIModuleBase)
local _GameEventRewardGroupTpl = L_GameTpl:getGameEventsRewardGroupTpl()

function this.bind()
  return {
    txt_title_bg = string.empty,
    txt_title_check = string.empty,
    tab_id = 0
  }
end

function this.methods()
  return {
    onClick_tab = function(self)
      if self.bind.action ~= nil then
        self.bind.action(self.bind.id)
      else
        errorf("活动奖励页面" .. "未绑定点击事件,按钮名称: " .. self.bind.id, 2)
      end
    end
  }
end

function this:open()
  local tpl = _GameEventRewardGroupTpl:getTplById(self.bind.id)
  local name = _GameEventRewardGroupTpl:getName(tpl)
  self:refreshTitle(name)
  self:registerRedDot()
  local isNew = self:hasNewData(self.bind.id)
  self:refreshRedDot(isNew)
  self.bind.tab_id = self.bind.id
end

function this:hasNewData(id)
  local red_point = L_GameEventStore:getGameEventData(self.bind.activityId):getRedPointData()
  local is_new = false
  if red_point[id] ~= nil then
    is_new = red_point[id]
  end
  return is_new
end

function this:registerRedDot()
  L_ReddotManager:registerReddot(self.bindComponents.reddotnew, string.format(L_ReddotManager.DotDef.GameAct_Reward_Tab, self.bind.id), nil, nil)
end

function this:refreshRedDot(isNew)
  if isNew then
    L_ReddotManager:markNew(L_ReddotManager.DotDef.GameAct_Reward_Tab, self.bind.id)
  else
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_Reward_Tab, self.bind.id)
  end
  self.bindComponents.reddotnew.gameObject:SetActive(isNew)
end

function this:refreshTitle(title)
  self.bind.txt_title_bg = title
  self.bind.txt_title_check = title
end

return this
