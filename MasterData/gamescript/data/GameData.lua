local GameData = {}
GameData.playerTilePosition = {x = 0, y = 0}
GameData.IsShowAccountState = true
GameData.IsReplaceRole = false
GameData.IsShowGmEntry = true
GameData.ShowLag = true
GameData.IsInCombat = false
GameData.serverVersion = nil
GameData.OpenAsynUI = false
GameData.EnterMockDemo = false
GameData.DelayReconnectTime = 0
GameData.OpenReqMask = true
GameData.ButtonClickTime = 0
GameData.CurrTextLanguage = DT.GetConstant("InitLanguageCode_HKTW")
GameData.OriginLang = DT.GetConstant("OriginLang")
GameData.IsUseTranslationConfig = CS.FrameWork.Z1Const.IsUseTranslationTextConfig()
GameData.ShareRewardFinish = false
GameData.BindPhoneReward = false
GameData.IsShowShortCut = false
do return Vue.reactive end
return Vue.reactive, GameData
