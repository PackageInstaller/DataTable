
local acMgr = AutoChessManager.instance()

local base = require("AutoChessEntity")

---@class AutoChessRole:AutoChessEntity
local AutoChessRole = class("AutoChessRole", base)

function AutoChessRole:ctor(data)
	self.id = data.id
	self.entityType = GE.EntityType.Player
    local cfg = Config.GetAutoChessHeroTable(self.id)
    local skinId = 0
    local serverData = Me:getPlayerHero(self.id)
    if serverData == nil then
        skinId = cfg.baseSkinID
    else
        skinId = serverData.equipSk1in
    end
    self.roleCfg = cfg

    ---@type CharacterSkinTable
    self.skinConfig = Config.GetCharacterSkinInfo(skinId)
end


function AutoChessRole:Init()
    base.Init(self)

    local cfg = self.roleCfg
    if cfg == nil then
        return
    end
    self:AddAttribute( GE.AutoChessAttributeType.HP, cfg.hp)
    self:AddAttribute( GE.AutoChessAttributeType.MaxHP, cfg.hp)
    self:AddAttribute( GE.AutoChessAttributeType.bombard, cfg.bombard)
    self:AddAttribute( GE.AutoChessAttributeType.torpedo, cfg.torpedo)
    self:AddAttribute( GE.AutoChessAttributeType.armor, cfg.armor)
    self:AddAttribute( GE.AutoChessAttributeType.evade, cfg.evade)
    self:AddAttribute( GE.AutoChessAttributeType.airdefense, cfg.airdefense)
    self:AddAttribute( GE.AutoChessAttributeType.lucky, cfg.lucky)
    self:AddAttribute( GE.AutoChessAttributeType.MoveSpeed, cfg.moveSpeed)
    self.skillController:AddSkills(cfg.skills)
end

---@return string
function AutoChessRole:GetContainerName()
	return Config.PrefabPath.AutoChessRole
end

function AutoChessRole:GetModelPath()
    if self.skinConfig == nil then
        return ""
    end
    return string.format(Config.PrefabPath.RoleModelPrefab, self.skinConfig.modelKey, self.skinConfig.modelKey)
end
function AutoChessRole:OnModelLoadFinish()
    
    base.OnModelLoadFinish(self)
	self.modelObj.transform.localPosition = Vector3.New(0,self.skinConfig.modelOffset,0)
    self.modelObj.transform.localScale = Vector3.one * self.skinConfig.modelRate
end

---@return string?
function AutoChessRole:GetAiName()
    local AIRegistry = require("AIRegistry")
    return AIRegistry.ResolveForHero(self.id, self.roleCfg)
end

function AutoChessRole:OnDeath()
    self.isDead = true
    
    ---TODO 可以播放一些死亡动画
    acMgr:RemoveEntity(self:GetUID())

end

return AutoChessRole