local module = class("moduleAreaLeveItemlList", G_UIModuleBase)
local _areaLeveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()
local _areaTypeTpl = L_GameTpl:getKiboDuelAreaTypeTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.levelItemDatas = {}
  self.curSelectLevel = 2
  self.levelCount = 1
end

function module.bind()
  return {
    scrollListLevel = {
      moduleName = "pages/kiboDuelAreaLevel/cellAreaLevelInfoItem"
    },
    scrollListLevelInitItemIndex = 2
  }
end

function module.methods()
  return {
    scrollListLevel = {
      onClick = function(self, level)
        if self.curSelectLevel == level then
          return
        end
        self:playCellAnimation(self.curSelectLevel + 1, "anim_PetArea_drop_circle")
        self.curSelectLevel = level
        self:snapToIndex(level)
        self:emit("onSelectLevelClick", level)
        self.bindComponents.anim:Stop()
        self.bindComponents.anim:Play("anim_PetArea_release_info")
      end
    },
    onSnapFinished = function(self, index)
      if index < 2 or index > self.levelCount then
        return
      end
      self:playCellAnimation(self.curSelectLevel + 1, "anim_PetArea_drop_circle")
      self.curSelectLevel = index
      self:playCellAnimation(index + 1, "anim_PetArea_release_circle")
      self:refreshCellSelectState()
      self:emit("onSelectLevelClick", self.curSelectLevel)
    end
  }
end

function module:initLoopListViewDragFunc()
  local loopListView = self.bindComponents.loopListView
  if loopListView then
    function loopListView.mOnBeginDragActionWithData(eventData)
      self:onBeginDrag(eventData)
    end
    
    function loopListView.mOnEndDragActionWithData(eventData)
      self:onEndDrag(eventData)
    end
  end
end

function module:onBeginDrag(eventData)
  self.bindComponents.anim:Stop()
  self.bindComponents.anim:Play("anim_PetArea_drop_info")
  self:playCellAnimation(self.curSelectLevel + 1, "anim_PetArea_drop_circle")
  self.isDragStart = true
end

function module:onEndDrag(eventData)
  if self.isDragStart then
    self:actionReleaseAnim()
  end
  self.isDragStart = false
end

function module:actionReleaseAnim()
  self.bindComponents.anim:Stop()
  self.bindComponents.anim:Play("anim_PetArea_release_info")
  self:newOrResetTimer("delayFinishSnapImmediately", function()
    if self.bindComponents.loopListView then
      self.bindComponents.loopListView:FinishSnapImmediately()
    end
  end, 0.12)
end

function module:open()
  self:refreshInfo()
  self:initLoopListViewDragFunc()
end

function module:close()
  local loopListView = self.bindComponents.loopListView
  if loopListView then
    loopListView.mOnBeginDragActionWithData = nil
    loopListView.mOnEndDragActionWithData = nil
  end
end

function module:refreshInfo()
  self.bind.scrollListLevel:clear()
  self.bind.scrollListLevel:insert_array(self.levelItemDatas)
end

function module:setLevelItemDatas(datas)
  self.levelItemDatas = datas
  self:refreshInfo()
end

function module:refreshCellSelectState()
  if not self.levelItemDatas or not self.isBind then
    return
  end
  for _, data in pairs(self.levelItemDatas) do
    data.isSelected = data.level == self.curSelectLevel
  end
  local scrollList = self.bind.scrollListLevel
  local count = scrollList:getLength()
  for i = 1, count do
    local cell = scrollList:getItemCls(i)
    cell:onSetData(self.levelItemDatas[i])
  end
end

function module:setAreaLevelData(areaType, level)
  self.curSelectLevel = level
  local levels = _areaLeveTpl:getAreaLevels(areaType)
  local store = L_PetDuelStore
  local levelItemDatas = {
    {isEmpty = true},
    {isEmpty = true}
  }
  local areaTypeTpl = _areaTypeTpl:getTplById(areaType)
  for _, _level in ipairs(levels) do
    if 1 < _level then
      table.insert(levelItemDatas, {
        level = _level,
        rewardStatus = store:getAreaLevelStatus(areaType, _level),
        isSelected = level == _level,
        redKey = store:getAreaLevelRewardReddotKey(areaType, _level),
        levelIcon = _areaTypeTpl:getUIIcon(areaTypeTpl)
      })
      self.levelCount = self.levelCount + 1
    end
  end
  table.insert(levelItemDatas, {isEmpty = true})
  table.insert(levelItemDatas, {isEmpty = true})
  self:setLevelItemDatas(levelItemDatas)
  self:snapToIndex(level)
end

function module:setSelect(level)
  self.curSelectLevel = level
  self:snapToIndex(level)
end

function module:snapToIndex(index)
  self.bind.scrollListLevelInitItemIndex = index
end

function module:playCellAnimation(index, animName)
  local scrollList = self.bind.scrollListLevel
  local cell = scrollList:getItemCls(index)
  if cell then
    cell:playAnimation(animName)
  end
end

return module
