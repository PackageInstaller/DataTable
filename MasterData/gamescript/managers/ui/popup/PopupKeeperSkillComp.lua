local PopupKeeperSkillComp = System.NewClass("PopupKeeperSkillComp", PopupBaseComp)

function PopupKeeperSkillComp:ctor()
  self.keepSkillItems = {}
end

function PopupKeeperSkillComp:OnBind(binder)
  self.binder = binder
  self:BindNewKeepSkills()
end

function PopupKeeperSkillComp:Clear()
  table.clear(self.keepSkillItems)
end

function PopupKeeperSkillComp:CheckPopup()
  if #self.keepSkillItems > 0 then
    local keeperSkillController = KeeperSkillController.Instance
    keeperSkillController:OpenKeeperSkillObtainView(table.remove(self.keepSkillItems, 1), function()
      self:SetBusy(false)
    end)
    self:SetBusy(true)
  end
end

function PopupKeeperSkillComp:BindNewKeepSkills()
  local defaultItem = DT.GetConstant("DefaultKeeperSkill")
  self.binder:BindEvent(EventMgr.Instance.OnNewKeepSkillItem, function(keeperSkillIds)
    for _, keeperSkillId in ipairs(keeperSkillIds) do
      local keeperSkillItem = KeeperSkillUtils.GetItemIdBySkill(keeperSkillId)
      if keeperSkillItem ~= defaultItem and not DataCenter.itemData.ActivedKeeperSkill[keeperSkillId] then
        DataCenter.itemData.ActivedKeeperSkill[keeperSkillId] = true
        table.insert(self.keepSkillItems, keeperSkillId)
      end
    end
  end)
end

return PopupKeeperSkillComp
