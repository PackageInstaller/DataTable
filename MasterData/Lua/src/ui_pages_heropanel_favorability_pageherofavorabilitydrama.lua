local this = class("pageHeroFavorabilityDrama", G_UIPageBase)
local _charPlotTpl = L_GameTpl:getCharPlotTpl()

function this.bind()
  return {
    titleText = "",
    contentText = "",
    dramaImage = "",
    go_dramaBtn = false,
    go_lookQuestBtn = false
  }
end

function this.methods()
  return {
    onClick_drama = function(self)
      local tpl = _charPlotTpl:getTplById(self.dramaId)
      local plotId = _charPlotTpl:getPlotId(tpl)
      if plotId and plotId ~= 0 then
        AzurWorld.StoryMgr:PlayStory(plotId, function(isFinish, _)
          if isFinish then
            L_SystemBreakManager:jumpTo(L_SystemConst.enum.heroData, {
              heroId = self.heroId,
              selectModuleParam = {
                openPanelEnum = L_Const.heroDataModuleType.Drama
              }
            })
          end
        end)
      end
    end,
    onClick_lookQuest = function(self)
      L_UI:close("pageHeroFavorabilityDrama")
      L_UI:open("pageTask", {
        taskId = self.taskId
      })
    end,
    onClick_close = function(self)
      L_UI:close("pageHeroFavorabilityDrama")
    end
  }
end

function this:preOpen(options)
  self.heroId = 0
  self.dramaId = 0
  if options then
    self.heroId = options.heroId
    self.dramaId = options.dramaId
  end
  local tpl = _charPlotTpl:getTplById(self.dramaId)
  self.bind.contentText = _charPlotTpl:getText(tpl)
  self.bind.titleText = _charPlotTpl:getTitle(tpl)
  self.bind.dramaImage = _charPlotTpl:getPic(tpl)
  local taskId = _charPlotTpl:getTaskId(tpl)
  local taskFinish = true
  if taskId and taskId ~= 0 then
    taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
  end
  self.taskId = taskId
  self.bind.go_dramaBtn = taskFinish
  self.bind.go_lookQuestBtn = not taskFinish
end

return this
