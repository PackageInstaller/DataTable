local _PoolType = {
  Role = "Role",
  Effect = "Effect",
  SpriteAtlas = "SpriteAtlas"
}
_enum("PoolType", _PoolType)
PoolType = PoolType
_staticClass("PoolRegister")

function PoolRegister:RegisterPools(poolManager)
  poolManager:CreatePool(PoolType.Role, LoadType.GameObject, 3)
  poolManager:CreatePool(PoolType.Effect, LoadType.GameObject, 10)
  poolManager:CreatePool(PoolType.SpriteAtlas, LoadType.SpriteAtlas, 2)
end
