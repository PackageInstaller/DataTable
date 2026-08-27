local DungeonCenterUtil = {}

function DungeonCenterUtil.EnterDungeonFormationDeal()
  UIManager:HideWindow(UIWindowTypeID.SectorEntrance)
  UIManager:HideWindow(UIWindowTypeID.DungeonTowerLevel)
  UIManager:HideWindow(UIWindowTypeID.DungeonLevelDetail)
  UIManager:HideWindow(UIWindowTypeID.ActivityWinterDungeon)
  UIManager:HideWindow(UIWindowTypeID.DungeonTowerSelect)
  UIManager:HideWindow(UIWindowTypeID.DungeonHexaTower)
end

function DungeonCenterUtil.ExitDungeonFormationDeal()
  UIManager:ShowWindowOnly(UIWindowTypeID.DungeonLevelDetail, true)
  UIManager:ShowWindowOnly(UIWindowTypeID.DungeonTowerLevel, true)
  UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance, true)
  UIManager:ShowWindowOnly(UIWindowTypeID.ActivityWinterDungeon, true)
  UIManager:ShowWindowOnly(UIWindowTypeID.DungeonTowerSelect, true)
  UIManager:ShowWindowOnly(UIWindowTypeID.DungeonHexaTower, true)
end

function DungeonCenterUtil.TryPlayRepeatDungeonEnterAvg(actFrameId)
  local cfgList = ConfigData.act_general_repeat_dg_story[actFrameId]
  if cfgList == nil then
    return
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  for k, cfg in ipairs(cfgList) do
    if not avgPlayCtrl:IsAvgPlayed(cfg.story_id) and CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, cfg.story_id)
      return
    end
  end
end

return DungeonCenterUtil
