--region import
local haskey      = table.haskey
local type        = type
local isSet       = isSet
local checkTable  = checkTable
local checkNumber = checkNumber
--endregion

--region defines

--endregion

---@class ClubGVGBuildingInfoDojo
local ClubGVGBuildingInfoDojo = Class('ClubGVGBuildingInfoDojo')


function ClubGVGBuildingInfoDojo:__init()
    --- (0: 未被占领 1: 已占领 2: 对战中)
    self.status = 0 
    --- 社团GVG建筑表 id
    self.type = 0 
    --- 所属社团
    self.clubId = 0 
    ---  建筑物所在位置
    self.place = 0 
    ---  护盾值
    self.shield = 0 
    --- 建筑物剩余血量
    self.leftHp = 0 
    --- 建筑物里社团成员信息
    self.clubPlayerInfo = {} 
    --- 进攻建筑的玩家
    self.attackPlayerIds   = {} 
    --- 战斗中的玩家信息
    self.fightingInfo    = {} 
end


function ClubGVGBuildingInfoDojo:__delete()
    
end


---Fill
---填充数据
---@param jsonData {stage: number, stageLeftSeconds: number, playerPlace: number, leftRebirthTimes: number, leftRebirthSeconds: number, accelerateCD: number, playerInfo: table}
function ClubGVGBuildingInfoDojo:Fill(jsonData)
    
    for key, value in pairs(jsonData) do
        if isSet(jsonData,key) and haskey(self,key) then
            local filedType = type(self[key])
            if filedType == "table" then
                self[key] = checkTable(value)
            elseif filedType == "number" then
                self[key] = checkNumber(value)
            else
                self[key] = value
            end
        end
    end    

    return self
end



return ClubGVGBuildingInfoDojo
