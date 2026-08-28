---@class TeamCatBallDojo
local TeamCatBallDojo = Class('TeamCatBallDojo')

local pairs       = pairs
local checkTable  = checkTable
local checkNumber = checkNumber


function TeamCatBallDojo:__init()
    self.catType     = 0 --- 1: 主 2:被 3:经营 对应猫球卡牌表types
    self.playerCatId = 0 --- 玩家猫球ID
    self.catId       = 0 --- 猫球ID 配表id
end


function TeamCatBallDojo:__delete()
    self.playerCatId = nil --- 玩家猫球ID
    self.catId       = nil --- 猫球ID 配表id
end

function TeamCatBallDojo:FillByJsonData(jsonData, catType_)
    self.playerCatId = checkNumber(jsonData.playerCatId)
    self.catId       = checkNumber(jsonData.catId)
    local catType    = self.catType
    self.catType     = catType == 0 and catType_ or catType
end

---FillByCatBallDojo
---@param dojo CatEggDojo
function TeamCatBallDojo:Fill(dojo, catType_)
    if dojo == nil then
        return
    end
    self.playerCatId = dojo.id
    self.catId       = dojo.catId
    local catType    = self.catType
    self.catType     = catType == 0 and catType_ or catType
end

function TeamCatBallDojo:SetCatType(catType)
    self.catType     = catType --- 1: 主 2:被 3:经营 对应猫球卡牌表types
end

---SetStar
---计算属性需要此字段
function TeamCatBallDojo:SetStar(star)
    self.star = star
end

function TeamCatBallDojo:ClearFiled()
    self.playerCatId = 0 --- 玩家猫球ID
    self.catId       = 0 --- 猫球ID 配表id
end

return TeamCatBallDojo
