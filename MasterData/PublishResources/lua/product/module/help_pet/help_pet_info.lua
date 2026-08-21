local EnumHelpPetOperateType = {E_Del = 0, E_Add = 1}
_enum("EnumHelpPetOperateType", EnumHelpPetOperateType)
local EnumHelpSourceType = {
  E_HelpSource_System = 0,
  E_HelpSource_Friend = 1,
  E_HelpSource_Default = 2
}
_enum("EnumHelpSourceType", EnumHelpSourceType)
_class("DHelpPet_PetData", Object)
DHelpPet_PetData = DHelpPet_PetData

function DHelpPet_PetData:Constructor()
  self.m_nPlayerID = 0
  self.m_nTemplateID = 0
  self.m_nPstID = 0
  self.m_nLevel = 0
  self.m_nAwake = 0
  self.m_nGrade = 0
  self.m_nEquipLevel = 0
  self.m_nSkinID = 0
  self.m_nSourceType = 0
  self.m_nEquipRefineLevel = 0
  self.m_nAwakeLock = 0
end

DHelpPet_PetData._proto = {
  [1] = {
    "m_nPlayerID",
    "int64"
  },
  [2] = {
    "m_nTemplateID",
    "int"
  },
  [3] = {"m_nPstID", "int64"},
  [4] = {"m_nLevel", "int"},
  [5] = {"m_nAwake", "int"},
  [6] = {"m_nGrade", "int"},
  [7] = {
    "m_nEquipLevel",
    "int"
  },
  [8] = {"m_nSkinID", "int"},
  [9] = {
    "m_nSourceType",
    "int"
  },
  [10] = {
    "m_nEquipRefineLevel",
    "int"
  },
  [11] = {
    "m_nAwakeLock",
    "int"
  }
}
_class("DHelpPet_PetState", Object)
DHelpPet_PetState = DHelpPet_PetState

function DHelpPet_PetState:Constructor()
  self.m_nTemplateID = 0
  self.m_nPetPstID = 0
  self.m_nFightCount = 0
end

DHelpPet_PetState._proto = {
  [1] = {
    "m_nTemplateID",
    "int"
  },
  [2] = {
    "m_nPetPstID",
    "int64"
  },
  [3] = {
    "m_nFightCount",
    "int"
  }
}
_class("DHelpPet_FightData", Object)
DHelpPet_FightData = DHelpPet_FightData

function DHelpPet_FightData:Constructor()
  self.m_nPlayerID = 0
  self.m_tmFight = 0
  self.m_nLevelID = 0
end

DHelpPet_FightData._proto = {
  [1] = {
    "m_nPlayerID",
    "int64"
  },
  [2] = {"m_tmFight", "time"},
  [3] = {"m_nLevelID", "int"}
}
_class("DHelpPet_SupportPet", Object)
DHelpPet_SupportPet = DHelpPet_SupportPet

function DHelpPet_SupportPet:Constructor()
  self.m_nTemplateID = 0
  self.m_nPetPstID = 0
  self.m_vecFightData = {}
end

DHelpPet_SupportPet._proto = {
  [1] = {
    "m_nTemplateID",
    "int"
  },
  [2] = {
    "m_nPetPstID",
    "int64"
  },
  [4] = {
    "m_vecFightData",
    "list<DHelpPet_FightData>"
  }
}
_class("DHelpPet_HelpData", Object)
DHelpPet_HelpData = DHelpPet_HelpData

function DHelpPet_HelpData:Constructor()
  self.m_nPlayerID = 0
  self.m_nPetPstID = 0
  self.m_tmFight = 0
  self.m_nLevelID = 0
end

DHelpPet_HelpData._proto = {
  [1] = {
    "m_nPlayerID",
    "int64"
  },
  [2] = {
    "m_nPetPstID",
    "int64"
  },
  [3] = {"m_tmFight", "time"},
  [4] = {"m_nLevelID", "int"}
}
