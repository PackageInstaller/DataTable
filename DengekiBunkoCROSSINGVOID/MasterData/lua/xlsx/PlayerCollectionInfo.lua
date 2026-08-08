local raw = {
  [1] = ProtobufI("PlayerCollectionInfo", {
    type = 1,
    textureTitle = "home/Achievement_title_1",
    textureIcon = "Texture/Loby/Achievement_1",
    key = "achievementPoint",
    LabelName = "MyCollection_Achievement"
  }),
  [2] = ProtobufI("PlayerCollectionInfo", {
    type = 2,
    textureTitle = "home/Achievement_title_2",
    textureIcon = "Texture/Loby/Achievement_2",
    key = "equipNum",
    LabelName = "MyCollection_Equipment"
  }),
  [3] = ProtobufI("PlayerCollectionInfo", {
    type = 3,
    textureTitle = "home/Achievement_title_3",
    textureIcon = "Texture/Loby/Achievement_3",
    key = "weaponNum",
    LabelName = "MyCollection_Weapon"
  }),
  [4] = ProtobufI("PlayerCollectionInfo", {
    type = 4,
    textureTitle = "home/Achievement_title_4",
    textureIcon = "Texture/Loby/Achievement_4",
    key = "roleNum",
    LabelName = "MyCollection_Role"
  }),
  [5] = ProtobufI("PlayerCollectionInfo", {
    type = 5,
    textureTitle = "home/Achievement_title_5",
    textureIcon = "Texture/Loby/Achievement_5",
    LabelName = "MyCollection_Medal"
  }),
  [6] = ProtobufI("PlayerCollectionInfo", {
    type = 6,
    textureTitle = "home/Achievement_title_6",
    textureIcon = "Texture/Loby/Achievement_6",
    key = "skinNum",
    LabelName = "MyCollection_Skin"
  }),
  [7] = ProtobufI("PlayerCollectionInfo", {
    type = 7,
    textureTitle = "home/Achievement_title_7",
    textureIcon = "Texture/Loby/Achievement_7",
    key = "cgNum",
    LabelName = "MyCollection_CG"
  }),
  [8] = ProtobufI("PlayerCollectionInfo", {
    type = 8,
    textureTitle = "home/Achievement_title_8",
    textureIcon = "Texture/Loby/Achievement_8",
    key = "emojiNum",
    LabelName = "MyCollection_Emoji"
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8
}
return {raw, indexed}
