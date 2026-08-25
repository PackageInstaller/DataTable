local BattleAwakerHeadPanel, Super = System.NewComponent("BattleAwakerHeadPanel")

function BattleAwakerHeadPanel:ctor(res, ultiSkillList)
  Super.ctor(self)
  self.ui = UI_Battle_Panel_DbgResource(res)
  self.ultiSkillList = ultiSkillList
  self.items = {}
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleAwakerHeadPanel:OnBind(binder)
  Logger.Info("BattleAwakerHeadPanel:OnBind(), 创建 UI", table.tostring(self.ultiSkillList))
  self.binder = binder
  for i = 1, 4 do
    local ultiSkill = self.ultiSkillList[i]
    local uiName = "AwakerSkill_" .. i
    if not ultiSkill then
      self.ui[uiName]:SetActive(false)
    else
      local item = binder:BindComponent(BattleAwakerSkillItem(self.ui[uiName], ultiSkill, i))
      table.insert(self.items, item)
    end
  end
end

function BattleAwakerHeadPanel:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattleAwakerHeadPanel:GetItemWorldPosition(awakerClient)
  local item
  for _, v in ipairs(self.items) do
    if v.ultiSkill.awakerUid == awakerClient.uid then
      item = v
      break
    end
  end
  local distance = CS.Framework.UIUtilTool.GetDistancesFromNearPlane(bg.mainCamera, awakerClient.rootNode.transform.position)
  do return CS.Framework.UIUtilTool.ConvertUIWorldPosToScene, item.ui.uiNode.transform.position, distance, bg.mainCamera end
  return CS.Framework.UIUtilTool.ConvertUIWorldPosToScene, item.ui.uiNode.transform.position, distance, bg.mainCamera, bg.uiCamera, v.ultiSkill.awakerUid, awakerClient.uid
end

function BattleAwakerHeadPanel:GetItemUIWorldPosition(awakerClient)
  local item = self:GetItem(awakerClient.uid)
  local worldPos = item.ui.uiNode.transform.position
  return worldPos
end

function BattleAwakerHeadPanel:GetItem(uid)
  for _, item in ipairs(self.items) do
    if item.ultiSkill.awakerUid == uid then
      return item
    end
  end
end

function BattleAwakerHeadPanel:GetHead(awakerTid)
  for index, info in ipairs(self.ultiSkillList) do
    if info.roleTid == awakerTid then
      return self.ui["AwakerSkill_" .. index]
    end
  end
end

function BattleAwakerHeadPanel:ForbiddenAwakerItemsClick(boolVal)
  for _, item in ipairs(self.items) do
    item:ForbiddenClick(boolVal)
  end
end

return BattleAwakerHeadPanel
