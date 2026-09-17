local this = class("pageReputation", G_UIPageBase)
local _reputationLevelTpl = L_GameTpl:getReputationLevelTpl()

function this.bind()
  return {
    moduleCellReputationForce = {
      moduleName = "pages/pageReputation/cellReputationForce"
    },
    moduleCellReputationRewards = {
      moduleName = "pages/pageReputation/cellReputationRewards"
    },
    go_tip = false,
    module_tip = {
      moduleName = "pages/home/homeLevel/moduleHomeInfoTip"
    },
    localPosition_tip = nil,
    localPosition_Handle = nil
  }
end

function this.methods()
  return {
    onClickClose = function(self)
      L_UI:close(self.pageName)
    end,
    onValueChange_moduleCellReputationForce = function(self, value)
      self:updateLeftLine()
    end,
    moduleCellReputationRewards = {
      onClick_select = function(self, itemBind, pos)
        self:showTip(itemBind, pos)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:initData()
  self:refreshForceScrollList()
  self:refreshForceSelected()
  self:refreshRewardsScrollList()
end

function this:initData()
  local tempDatas = _reputationLevelTpl:getTotalForceList()
  self._selectedForce = 0 < #tempDatas and tempDatas[1] or -1
end

function this:refreshForceScrollList()
  local tag = {}
  local tempDatas = _reputationLevelTpl:getTotalForceList()
  for k, v in ipairs(tempDatas) do
    table.insert(tag, {
      forceId = v,
      clickCb = function(module)
        if module.bind.forceId == self._selectedForce then
          return
        end
        self._selectedForce = module.bind.forceId
        self:onCloseTip()
        self:refreshForceSelected()
        self:updateLeftLine()
      end
    })
  end
  self.bind.moduleCellReputationForce:clear()
  self.bind.moduleCellReputationForce:insert_array(tag)
  FrameScheduler.add(function()
    self.bindComponents.tableViewForce:ReloadData()
  end)
end

function this:refreshForceSelected()
  for i, v in pairs(self.modules.moduleCellReputationForce) do
    local cell = v
    cell:setSelected(self._selectedForce == v.bind.forceId)
  end
  self:refreshRewardsScrollList()
end

function this:refreshRewardsScrollList()
  local tag = {}
  local totalForceLvList = _reputationLevelTpl:getTplByForce(self._selectedForce)
  for i, v in ipairs(totalForceLvList) do
    table.insert(tag, {
      reputationTpl = v,
      cellClickCb = function(lv, id)
        self:RefreshSelectedReward(lv, id)
      end
    })
  end
  self.bind.moduleCellReputationRewards:clear()
  self.bind.moduleCellReputationRewards:insert_array(tag)
end

function this:RefreshSelectedReward(lv, rewardId)
  for i, v in pairs(self.modules.moduleCellReputationRewards) do
    local cell = v
    cell:setSelected(lv, rewardId)
  end
end

function this:showTip(itemBind, pos)
  self.bind.go_tip = true
  local module_tip = self.modules.module_tip
  module_tip:reset()
  module_tip:setData(itemBind.type, itemBind.id)
  local targetPos = self.bindComponents.rect_Board.transform:InverseTransformPoint(pos) + L_Vector3.new(50, 20, 0)
  local height = self.bindComponents.rect_moduleHomeLevelInfoTip.sizeDelta.y
  local width = self.bindComponents.rect_moduleHomeLevelInfoTip.sizeDelta.x
  local halfScreenHeight = self.bindComponents.rect_Board.transform.rect.height / 2
  if targetPos.y - height < -halfScreenHeight then
    targetPos.y = -halfScreenHeight + height
  end
  local halfScreenWidth = self.bindComponents.rect_Board.transform.rect.width / 2
  if halfScreenWidth < targetPos.x + width then
    targetPos.x = halfScreenWidth - width
  end
  self.bind.localPosition_tip = targetPos
end

function this:updateLeftLine()
  for i, v in pairs(self.modules.moduleCellReputationForce) do
    if v.isBind and v.bind.forceId == self._selectedForce then
      local targetPos = self.bindComponents.rect_Board.transform:InverseTransformPoint(v.uiBinding.transform.position)
      if L_DeviceTpl:getIsPc() then
        self.bind.localPosition_Handle = L_Vector3.new(0, targetPos.y + 25, 0)
      else
        self.bind.localPosition_Handle = L_Vector3.new(0, targetPos.y + 10, 0)
      end
      return
    end
  end
  self.bind.localPosition_Handle = L_Vector3.new(-10, -2000, 0)
end

function this:onCloseTip()
  self.bind.go_tip = false
  for i, v in pairs(self.modules.moduleCellReputationRewards) do
    v:clearSelect()
  end
end

function this:update()
  if CS.UnityEngine.Input.GetMouseButtonDown(0) then
    self:onCloseTip()
  end
end

return this
