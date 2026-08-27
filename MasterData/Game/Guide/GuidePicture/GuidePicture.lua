local GuidePicture = {}
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function GuidePicture.OpenGuidePicture(guideType, completeAction, finishShowClose)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  finishShowClose = finishShowClose or not userDataCache:IsGuidPicLooked(guideType)
  userDataCache:RecordGuidPicLooked(guideType)
  ConfigData:LoadDynCfg(eDynConfigData.guide_describe)
  local tipsDesCfg = ConfigData.guide_describe[guideType]
  if tipsDesCfg ~= nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.GuidePicture_0623New, function(win)
      if win == nil then
        return
      end
      win:InitGuidePicture_New(guideType, completeAction, finishShowClose)
    end)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.GuidePicture, function(window)
      window:InitGuidePicture(guideType, completeAction, finishShowClose)
    end)
  end
  ConfigData:ReleaseDynCfg(eDynConfigData.guide_describe)
end

return GuidePicture
