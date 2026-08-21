_class("N25Data", CampaignDataBase)
N25Data = N25Data

function N25Data:Constructor()
  self.replays = {}
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.componentIdShop = ECampaignN25ComponentID.ECAMPAIGN_N25_SHOP
end

function N25Data:Init()
end

function N25Data:GetEggCount()
  return 1
end

function N25Data.GetPstId()
  local mRole = GameGlobal.GetModule(RoleModule)
  return mRole:GetPstId()
end

function N25Data.GetPrefsKey(str)
  local playerPrefsKey = N25Data.GetPstId() .. str .. "fk"
  return playerPrefsKey
end

function N25Data.HasPrefs(key)
  return UnityEngine.PlayerPrefs.HasKey(key)
end

function N25Data.SetPrefsKey(key)
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function N25Data.GetPrefsKeyMain()
  return N25Data.GetPrefsKey("UIN25DataPrefsKeyMain_fk")
end

function N25Data.GetPrefsKeyShop()
  return N25Data.GetPrefsKey("UIN25DataPrefsKeyShop_fk")
end

function N25Data.GetPrefsKeyLine()
  return N25Data.GetPrefsKey("UIN25DataPrefsKeyNormal_fk")
end

function N25Data.GetPrefsKeyHard()
  return N25Data.GetPrefsKey("UIN25DataPrefsKeyHard_fk")
end

function N25Data.GetPrefsKeyGameIdol()
  return N25Data.GetPrefsKey("UIN25DataPrefsKeyIdol_fk")
end

function N25Data.GetPrefsKeyGameBloodSucker()
  return N25Data.GetPrefsKey("UIN25DataPrefsKeyBloodSucker_fk")
end

function N25Data.HasPrefsMain()
  return UnityEngine.PlayerPrefs.HasKey(N25Data.GetPrefsKeyMain())
end

function N25Data.SetPrefsMain()
  UnityEngine.PlayerPrefs.SetInt(N25Data.GetPrefsKeyMain(), 1)
end

function N25Data.HasPrefsShop()
  return UnityEngine.PlayerPrefs.HasKey(N25Data.GetPrefsKeyShop())
end

function N25Data.SetPrefsShop()
  UnityEngine.PlayerPrefs.SetInt(N25Data.GetPrefsKeyShop(), 1)
end

function N25Data.SetPrefsLine()
  UnityEngine.PlayerPrefs.SetInt(N25Data.GetPrefsKeyLine(), 1)
end

function N25Data.SetPrefsHard()
  UnityEngine.PlayerPrefs.SetInt(N25Data.GetPrefsKeyHard(), 1)
end

function N25Data.SetPrefsGameIdol()
  UnityEngine.PlayerPrefs.SetInt(N25Data.GetPrefsKeyGameIdol(), 1)
end

function N25Data.SetPrefsGameBloodSucker()
  UnityEngine.PlayerPrefs.SetInt(N25Data.GetPrefsKeyGameBloodSucker(), 1)
end
