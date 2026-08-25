local PublicUIController = NewClass("PublicUIController", BaseController)

function PublicUIController:OnInit()
end

function PublicUIController:OnReset()
end

function PublicUIController:OnOpenPropertiesTipsView(data)
  UIManager.Instance:Reopen(Urls.PropertiesTipsView, data)
end

function PublicUIController:OnOpenSelectItemBaseView(data)
  UIManager.Instance:Reopen(Urls.SelectItemBaseView, data)
end

function PublicUIController:OnOpenPopAchievementTips(taskTid, callback)
  UIManager.Instance:Reopen(Urls.PopAchievementTips, taskTid, callback)
end

function PublicUIController:OnOpenInvestigatorLevelUp(data)
  UIManager.Instance:Reopen(Urls.InvestigatorLevelUpView, data)
end

function PublicUIController:OnOpenCommonillustrateView(title, content)
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
end

function PublicUIController:OnOpenMarqueeView(showTet)
  UIManager.Instance:Reopen(Urls.MarqueePanel, showTet)
end

function PublicUIController:OnOpenItemUseSelectView(data, isPreview)
  UIManager.Instance:Reopen(Urls.ItemUseSelectPanel, data, isPreview)
end

function PublicUIController:OnOpenCommonCardKeyWorldDescView(strList, parentNode, extraParam)
  UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, strList, parentNode, extraParam)
end

function PublicUIController:ReqUseChooseItem()
  ProtoManager.Instance:ReqServer("GameRequest", "OnUseChooseItem", function(svrData)
    Logger.Info("OnUseChooseItem Successful")
    UIManager.Instance:CloseByUrl(Urls.ItemUseSelectPanel)
  end, function()
    Logger.Info("OnUseChooseItem Fail")
  end, ItemUseSelectModel.Instance:GetItemId(), ItemUseSelectModel.Instance:GetCurSelectTid(), ItemUseSelectModel.Instance:GetUseNum())
end

return PublicUIController
