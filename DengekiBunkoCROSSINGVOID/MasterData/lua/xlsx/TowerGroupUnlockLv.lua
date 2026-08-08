local raw = {
  [1] = ProtobufI("TowerGroupUnlockLv", {groupId = 1, level = 11}),
  [2] = ProtobufI("TowerGroupUnlockLv", {groupId = 2, level = 25}),
  [3] = ProtobufI("TowerGroupUnlockLv", {groupId = 3, level = 35})
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3
}
return {raw, indexed}
