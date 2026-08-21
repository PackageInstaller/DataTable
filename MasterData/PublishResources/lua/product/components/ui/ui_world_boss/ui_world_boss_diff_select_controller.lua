_class("UIWorldBossDiffSelectController", UIController)
UIWorldBossDiffSelectController = UIWorldBossDiffSelectController

function UIWorldBossDiffSelectController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIWorldBossDiffSelectController:OnShow(uiParams)
  self.diffCfg = {
    [1] = {
      name = "str_world_boss_normal",
      bg = "gfworld_xz_di01"
    },
    [2] = {
      name = "str_world_boss_hard",
      bg = "gfworld_xz_di02"
    }
  }
  self.bossMissionId = uiParams[1]
  self.conformCallback = uiParams[2]
  self.lastSelectIndex = -1
  self:InitWidget()
  self:_OnValue()
end

function UIWorldBossDiffSelectController:InitWidget()
  self.contentPool = self:GetUIComponent("UISelectObjectPath", "content")
  self.animaiton = self:GetUIComponent("Animation", "animation")
end

function UIWorldBossDiffSelectController:_OnValue()
  local cfg_world_boss_mission = Cfg.cfg_world_boss_mission[self.bossMissionId]
  if not cfg_world_boss_mission then
    Log.error("err UIWorldBossDiffSelectController cfg_world_boss_mission can't find with id = " .. self.bossMissionId)
    self:CloseDialog()
    return
  end
  local levels = cfg_world_boss_mission.FightLevel
  local levelDesces = cfg_world_boss_mission.LevelDesc
  local len = #levels
  if len > #self.diffCfg then
    len = #self.diffCfg
  end
  local items = self.contentPool:SpawnObjects("UIWorldBossDiffcultyItem", len)
  self._items = items
  for i = 1, len do
    local cfg = self.diffCfg[i]
    local item = items[i]
    if i == 1 then
      self:SetSelect(item, 1)
    end
    item:SetData(i, cfg, levelDesces[i], function(selectItem, index)
      self:SetSelect(selectItem, index)
    end)
  end
end

function UIWorldBossDiffSelectController:SetSelect(item, index)
  if self.lastSelectIndex == index then
    return
  end
  if self.lastSelectItem then
    self.lastSelectItem:SetSelect(false)
  end
  self.lastSelectIndex = index
  self.lastSelectItem = item
  self.lastSelectItem:SetSelect(true)
end

function UIWorldBossDiffSelectController:ConformBtnOnClick(go)
  self:CloseDialog()
  if self.conformCallback then
    self.conformCallback(self.lastSelectIndex)
  end
end

function UIWorldBossDiffSelectController:CancelBtnOnClick(go)
  self:CloseWithAnimation()
end

function UIWorldBossDiffSelectController:BgRootOnClick(go)
  self:CloseWithAnimation()
end

function UIWorldBossDiffSelectController:CloseWithAnimation()
  self:StartTask(function(TT)
    local key = "UIWorldBossDiffSelectController_Close"
    self:Lock(key)
    self.animaiton:Play("UIWorldBossDiffSelectController_out")
    YIELD(TT, 500)
    self:UnLock(key)
    self:CloseDialog()
  end)
end
