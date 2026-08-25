local AwakerSelectShowingController = NewClass("AwakerSelectShowingController", BaseController)

function AwakerSelectShowingController:OnInit()
end

function AwakerSelectShowingController:OnReset()
end

function AwakerSelectShowingController:Confirm(mainPanelModel, awakerTid)
  mainPanelModel:SetShowAwaker(awakerTid)
  AwakerDataUtils.SetBoardAwaker(awakerTid)
end

function AwakerSelectShowingController:HideHud(mainPanelModel)
  mainPanelModel:SetHideHud(true)
end

function AwakerSelectShowingController:ResetBg()
  local function confirmResetBg()
    CollectionHallCfgUtils.ResetMainBgMusic()
    
    CollectionHallCfgUtils.ResetMainBgCG()
  end
  
  Alert.Show("MainResetBG", nil, confirmResetBg)
end

return AwakerSelectShowingController
