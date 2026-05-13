local LevelNode = class("LevelNode")
local ActCarbonRes = "ui/act_carbon/"
local StoryPosType = {UP = 1, DOWN = 2}

function LevelNode:ctor(params)
  self.levelId = params.levelId
  self.parent = params.parent
  self.callback = params.callback
  self.storyCallback = params.storyCallback
  self.isUnlocked = params.isUnlocked or false
  self.isCompleted = params.isCompleted or false
  self.StoryPosType = params.StoryPosType or StoryPosType.UP
  self:createNode()
end

function LevelNode:createNode()
  self.container = cc.Node:create()
  self.levelBtn = UIHelper.extend(ccui.Button:create())
  local levelPath = string.format("lv_%d.png", self.levelId)
  self.levelBtn:setImages(ActCarbonRes, {levelPath, levelPath})
  self.levelBtn:anch(0, 0):pos(0, 0)
  self.levelBtn:addTo(self.container)
  self.levelBtn:setCallback(function()
    if not self.isUnlocked then
      MFlashMsg:show({
        text = "请先通关前置关卡"
      })
      return
    end
    if self.callback then
      self.callback(self.levelId)
    end
  end)
  self.storyBtn = UIHelper.extend(ccui.Button:create())
  local storyPath = string.format("story_%d.png", self.levelId)
  self.storyBtn:setImages(ActCarbonRes, {storyPath, storyPath})
  if self.StoryPosType == LevelNode.StoryPosType.UP then
    self.storyBtn:anch(0, 0):pos(220, 150):addTo(self.levelBtn)
  else
    self.storyBtn:anch(0, 0):pos(230, 40):addTo(self.levelBtn)
  end
  self.storyBtn:setTouchScale()
  self.storyBtn:setCallback(function()
    if self.storyCallback then
      self.storyCallback(self.levelId)
    end
  end)
  self.lockIcon = display.newSprite(ActCarbonRes .. "lock_icon.png"):center(self.levelBtn):addTo(self.levelBtn)
  self:updateState()
end

function LevelNode:updateState()
  if self.isUnlocked then
    self.levelBtn:setColor(cc.c3b(255, 255, 255))
    self.lockIcon:hide()
    self.storyBtn:setVisible(self.isCompleted)
  else
    self.levelBtn:setColor(cc.c3b(100, 100, 100))
    self.lockIcon:show()
    self.storyBtn:hide()
  end
end

function LevelNode:setUnlocked(unlocked)
  self.isUnlocked = unlocked
  self:updateState()
end

function LevelNode:setCompleted(completed)
  self.isCompleted = completed
  self:updateState()
end

function LevelNode:getNode()
  return self.container
end

LevelNode.StoryPosType = StoryPosType
return LevelNode
