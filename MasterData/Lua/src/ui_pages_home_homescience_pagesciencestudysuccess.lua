local this = class("pageScienceStudySuccess", G_UIPageBase)
local _homeTechnologyTreeTpl = L_GameTpl:getHomeTechnologyTreeTpl()
local _homeTechnologyTypeTpl = L_GameTpl:getHomeTechnologyTypeTpl()
local _homeTechnologyTpl = L_GameTpl:getHomeTechnologyTpl()

function this.bind()
  return {
    goMask = false,
    go_leftName = false,
    go_midImg = false,
    go_rightName = false,
    go_midName = false,
    text_leftName = "",
    text_rightName = "",
    text_midName = "",
    text_desc = "",
    img_techType = nil,
    img_tech = nil
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._onEvent_storyStartHandle = handler(self, self.onEvent_storyStartHandle)
  C_StoryEvent.instance:Listen(C_EStoryEvent.StoryStart, self._onEvent_storyStartHandle)
  local techTreeId = options.techTreeId
  self.callback = options.callback
  self:showItem(techTreeId)
end

function this:show(options)
end

function this:open(options)
  this.super.open(self, options)
  L_AudioUtil.playSound("Play_SFX_System_UI_Tech_Learned")
end

function this:close(options)
  this.super.close(self, options)
  if self._onEvent_storyStartHandle ~= nil then
    C_StoryEvent.instance:Cancel(C_EStoryEvent.StoryStart, self._onEvent_storyStartHandle)
    self._onEvent_storyStartHandle = nil
  end
  if self.callback then
    self.callback()
  end
end

function this:onEvent_storyStartHandle()
  L_UI:close(self.pageName)
end

function this:showItem(techTreeId)
  local techLevel = L_TechnologyStore:getCurTechnologyLevelById(techTreeId)
  local homeTechnologyTplId = _homeTechnologyTpl:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(techTreeId, techLevel)
  local homeTechnologyTpl = _homeTechnologyTpl:getTplById(homeTechnologyTplId)
  if techLevel == 1 then
    self.bind.go_leftName = false
    self.bind.go_midImg = false
    self.bind.go_rightName = false
    self.bind.go_midName = true
    self.bind.text_midName = _homeTechnologyTpl:getObjName(homeTechnologyTpl)
  elseif 1 < techLevel then
    self.bind.go_leftName = true
    self.bind.go_midImg = true
    self.bind.go_rightName = true
    self.bind.go_midName = false
    local leftLevel = techLevel - 1
    local rightLevel = techLevel
    local leftHomeTechnologyTplId = _homeTechnologyTpl:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(techTreeId, leftLevel)
    local leftHomeTechnologyTpl = _homeTechnologyTpl:getTplById(leftHomeTechnologyTplId)
    self.bind.text_leftName = _homeTechnologyTpl:getObjName(leftHomeTechnologyTpl)
    local rightHomeTechnologyTplId = _homeTechnologyTpl:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(techTreeId, rightLevel)
    local rightHomeTechnologyTpl = _homeTechnologyTpl:getTplById(rightHomeTechnologyTplId)
    self.bind.text_rightName = _homeTechnologyTpl:getObjName(rightHomeTechnologyTpl)
  end
  self.bind.text_desc = _homeTechnologyTpl:getEffectDescription(homeTechnologyTpl)
  local homeTechnologyTreeTpl = _homeTechnologyTreeTpl:getTplById(techTreeId)
  local homeTechnologyTypeTpl = _homeTechnologyTypeTpl:getTplById(_homeTechnologyTreeTpl:getType(homeTechnologyTreeTpl))
  self.bind.img_techType = _homeTechnologyTypeTpl:getTechnologyCurrencyPageIcon(homeTechnologyTypeTpl)
  self.bind.img_tech = _homeTechnologyTreeTpl:getIcon(homeTechnologyTreeTpl)
end

return this
