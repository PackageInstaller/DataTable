local module = class("moduleAchievementAwardPreView", G_UIModuleBase)
local _achievementAwardTpl = L_GameTpl:getAchievementAwardTpl()

function module.bind()
  return {
    obj_self = true,
    list_award = {
      moduleName = "pages/achievement/cellAchievementAwardPreView"
    }
  }
end

function module.methods()
  return {
    onclick_Close = function(self)
      self.bind.obj_self = false
    end
  }
end

function module:openInit(curGetPoint)
  local nextAwardId = _achievementAwardTpl:getIdByPoint(curGetPoint)
  local datas = {}
  for i, v in ipairs(_achievementAwardTpl.data) do
    table.insert(datas, {
      id = v.id,
      point = v.achiPoint,
      rewardDatas = v.reward,
      nextAwardId = nextAwardId
    })
  end
  self.bind.list_award:clear()
  self.bind.list_award:insert_array(datas)
end

return module
