local KeeperSkillController = NewClass("KeeperSkillController", BaseController)

function KeeperSkillController:OnInit()
end

function KeeperSkillController:OnReset()
end

function KeeperSkillController:OpenKeeperSkillView(teamModel)
  UIManager.Instance:Reopen(Urls.KeeperSkillView, teamModel)
end

function KeeperSkillController:OpenBattlePopupKeeperSkillTip(roleInfo)
  UIManager.Instance:Reopen(Urls.BattlePopupKeeperSkillTip, roleInfo)
end

function KeeperSkillController:CloseBattlePopupKeeperSkillTip()
  UIManager.Instance:CloseByUrl(Urls.BattlePopupKeeperSkillTip)
end

function KeeperSkillController:OpenKeeperSkillObtainView(itemOrSkillId, closeCallback)
  UIManager.Instance:Reopen(Urls.KeeperSkillObtainView, itemOrSkillId, closeCallback)
end

function KeeperSkillController:CloseKeeperSkillObtainView()
  UIManager.Instance:CloseByUrl(Urls.KeeperSkillObtainView)
end

return KeeperSkillController
