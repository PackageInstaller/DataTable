local PersistentConfig = {}
PersistentConfig.ePackage = {
  None = 0,
  UserData = 1,
  SystemData = 2,
  DeploySaveData = 3,
  UserChatData = 4
}
PersistentConfig.DataType = {System = 0, User = 1}
PersistentConfig.PersistentProtoFiles = {
  "user_data.pb.bytes",
  "system_data.pb.bytes",
  "deploy_data.pb.bytes",
  "chat_system.pb.bytes"
}
PersistentConfig.ModelSaveList = {
  PersistentConfig.ePackage.UserData,
  PersistentConfig.ePackage.SystemData
}
PersistentConfig.PackageData = {
  [PersistentConfig.ePackage.UserData] = {
    PbName = "save_data.user_data",
    DataType = PersistentConfig.DataType.User,
    DataModel = require("Game.PersistentManager.PersistentData.UserData"),
    LogoutUnload = true,
    SaveSingleton = true
  },
  [PersistentConfig.ePackage.UserChatData] = {
    PbName = "save_data.chat_system",
    DataType = PersistentConfig.DataType.User,
    DataModel = require("Game.PersistentManager.PersistentData.UserChatData"),
    LogoutUnload = true,
    SaveSingleton = true
  },
  [PersistentConfig.ePackage.SystemData] = {
    PbName = "save_data.system_data",
    DataType = PersistentConfig.DataType.System,
    DataModel = require("Game.PersistentManager.PersistentData.SystemSaveData"),
    LogoutUnload = false,
    SaveSingleton = true
  },
  [PersistentConfig.ePackage.DeploySaveData] = {
    PbName = "save_data.deploy_data",
    DataType = PersistentConfig.DataType.UserData,
    DataModel = require("Game.PersistentManager.PersistentData.DeploySaveData")
  }
}
return PersistentConfig
