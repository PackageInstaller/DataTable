require "class"
---@class BaseRole:BaseClass
local BaseRole = class("BaseRole")

---角色基类，持有 BaseShowManager 渲染所需的最小信息
---@param data {id: integer, cid: integer, camp: integer?}
function BaseRole:ctor(data)
    ---@type integer
    self.id = data.id
    ---@type integer
    self.cid = data.cid
    ---@type BattleCampType?
    self.camp = data.camp
    ---@type CharacterSkinTable? 皮肤配置，子类负责填充
    self.skinConfig = nil
end

return BaseRole
