local cls = class("pageEntrustTaskReward", G_UIPageBase)
local _dungeonEntrustRewardTpl = L_GameTpl:getDungeonEntrustRewardTpl()
local _dungeonEntrustDifficultyTpl = L_GameTpl:getDungeonEntrustDifficultyTpl()

function cls.bind()
  return {
    txt_title = "",
    table_content = {
      moduleName = "pages/entrustTask/cellEntrustStarReward"
    },
    focusItemIndex = 0
  }
end

function cls.methods()
  return {
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
end

function cls:open(options)
  self.difficultyId = options.difficultyId or 0
  self.entrustType = options.entrustType
  self:initPage()
end

function cls:initPage()
  self.bind.txt_title = L_WordsTpl:getValue("residual_code_pageentrusttaskreward_01")
  local _, canReceiveRewardId = L_EntrustStore:getFirstCanReceiveStarNum(self.entrustType, self.difficultyId)
  local modeInfo = _dungeonEntrustRewardTpl:getInfoByDifficulty(self.entrustType, self.difficultyId) or {}
  local info = {}
  local selectIndex = 1
  for index, v in ipairs(modeInfo) do
    local isActive = canReceiveRewardId == v.id
    table.insert(info, {
      rewardId = v.id,
      active_curReward = isActive
    })
    if isActive then
      selectIndex = index
    end
  end
  self.bind.table_content:clear()
  self.bind.table_content:insert_array(info)
  self.bind.focusItemIndex = selectIndex - 1
end

function cls:close(options)
  cls.super.close(self, options)
end

return cls
