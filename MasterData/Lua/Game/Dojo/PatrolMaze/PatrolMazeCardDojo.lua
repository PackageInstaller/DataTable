-------------------------------------------------------------------------------
-- 夜巡迷宫 - 卡牌数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-01 00:24:52
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local CardSkillUtils  = import('Game.CardProgression.CardProgressionSkillUtils')

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class PatrolMazeCardDojo : BaseDojo
---@field New fun():PatrolMazeCardDojo
local PatrolMazeCardDojo = Class('PatrolMazeCardDojo', BaseDojo)


function PatrolMazeCardDojo:__init()
    ---@type integer @ 自增id（助战角色的话，id为助战表id）
    self.id = 0

    ---@type integer @ 卡牌id
    self.cardId = 0

    ---@type integer @ 加成星级
    self.addStar = 0

    ---@type integer @ 基础星级
    self.baseStar = 0

    ---@type boolean @ 是否为支援卡
    self.isAssist = 0

    ---@type integer @ 卡牌助理id
    self.assistId = 0

    ---@type number @ 血量百分比
    self.hpPercent = 1
    
    ---@type integer @ sp能量
    self.energy = 0

    ---@type CardDojo @ 卡牌数据dojo
    self.cardDojo = nil
end


function PatrolMazeCardDojo:__delete()
    self.id        = nil
    self.cardId    = nil
    self.addStar   = nil
    self.baseStar  = nil
    self.isAssist  = nil
    self.assistId  = nil
    self.hpPercent = nil
    self.energy    = nil
    self.cardDojo  = nil
end


---@param jsonData table
---@return PatrolMazeCardDojo
function PatrolMazeCardDojo:Fill(jsonData)
    self.id       = checkInt(jsonData.id)
    self.cardId   = checkInt(jsonData.cardId)
    self.isAssist = checkInt(jsonData.isAssistant) == 1
    self.energy   = checkInt(jsonData.energy)

    if self.isAssist then
        self.assistId = self.id
        self.cardDojo = PatrolMazeUtils.GetAssistCardDojo(self.assistId)
    else
        self.assistId = 0
        self.cardDojo = PatrolMazeUtils.GetMazeCardDojo(self.cardId)
    end
    
    if self.cardDojo then
        self.cardDojo.id = self.id
        self.baseStar = self.cardDojo.star
    end

    self:SetAddStar(jsonData.addStar)
    self:SetHpPercent(jsonData.hpPercent)
    return self
end


---@return CardDojo
function PatrolMazeCardDojo:GetCardDojo()
    return self.cardDojo
end


--- 设置 卡牌血量
---@param hpPercent number
function PatrolMazeCardDojo:SetHpPercent(hpPercent)
    self.hpPercent = math.min(checkNumber(hpPercent), 1)
end


--- 设置 星级加成
---@param addStar integer
function PatrolMazeCardDojo:SetAddStar(addStar)
    self.addStar = checkInt(addStar)
    if self.cardDojo and self.addStar > 0 then
        local oldStar = self.cardDojo.star
        local newStar = math.min(self.baseStar + self.addStar, Constants.CardMaxStar)
        -- check same
        if oldStar ~= newStar then
            -- update star
            self.cardDojo.star = newStar
            -- calculate skill
            local finalSkillLv, buffSkillLv = CardSkillUtils.GetFinalSkillLvAndBuffLv(self.cardId, newStar)
            self.cardDojo.finalSkillLevel = finalSkillLv
            self.cardDojo.awakeningLevel  = buffSkillLv
        end
    end
end


return PatrolMazeCardDojo
