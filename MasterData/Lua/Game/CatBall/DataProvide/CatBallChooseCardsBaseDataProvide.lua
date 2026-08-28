
--region global define
local import = import
--endregion

--region import
---@type CatBallUtils
local CatBallUtils        = import("Game.CatBall.CatBallUtils")
local MaidCoffeeConstants = import("Game.MaidCoffee.MaidCoffeeConstants")
--endregion

--region define

--endregion

---@class CatBallChooseCardsBaseDataProvide
local CatBallChooseCardsBaseDataProvide = Class('CatBallChooseCardsBaseDataProvide')

--region init 

function CatBallChooseCardsBaseDataProvide:OnInit(argument)
    self:InitData(argument)
end

function CatBallChooseCardsBaseDataProvide:InitData(argument)
    
end

function CatBallChooseCardsBaseDataProvide:InitPlayerCatId2Index()
    local playerCatId2Index = {}
    ---@param teamCatDojo TeamCatBallDojo
    for index, teamCatDojo in ipairs(self._teamCats) do
        local playerCatId = teamCatDojo.playerCatId or 0
        if playerCatId > 0 and teamCatDojo.catType == self._catBallType then
            playerCatId2Index[playerCatId] = index
        end
    end
    self._playerCatId2Index = playerCatId2Index
end

---InitCatBallEntityList
---@param catBallType Constants.CatBallType
function CatBallChooseCardsBaseDataProvide:InitCatBallEntityList(catBallType)
    --- 初始化猫球数据
    ---@type CatEggComponent
    local eggComponent     = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    ---@type table<number, CatEggDojo>
    local playerCatId2Dojo = eggComponent:GetCats()
    local catBallEntityList = {}
    table.walk(playerCatId2Dojo, function(playerCatId, dojo)
        local catId = dojo.catId
        ---@type CatBallVo
        local vo  = CatBallUtils.GetCatBallVo(catId)
        if catBallType == nil or catBallType == vo.types then
            table.insert(catBallEntityList, CatBallUtils.GeneratedCatBallEntity(dojo))
        end

    end)
    self._catBallEntityList = catBallEntityList
end

--endregion 


--region logic 


---AddTeamCat
---@param catEggDojo CatEggDojo
function CatBallChooseCardsBaseDataProvide:AddTeamCat(catEggDojo)
    local oldTeamIndex = self._playerCatId2Index[catEggDojo.id]
    local isSingle = self:GetMaxSelectCatBallNum() <= 1
    ---如果最大选择数量大于1 并且在编队中 则不处理
    if oldTeamIndex and not isSingle then
        return oldTeamIndex
    end
    local catBallType = self._catBallType
    ---@param value TeamCatBallDojo
    for index, value in ipairs(self._teamCats) do
        if value.catType == catBallType and (value.playerCatId == 0 or isSingle)  then
            local oldPlayerCatId = self:ClearPlayerCatId2Index(isSingle)
            if oldTeamIndex and isSingle then
                --- 单选 并且 要传入添加到编队里的猫球 已经在编队中 则直接反选
                value:ClearFiled()
                index = nil
            else
                value:Fill(catEggDojo)
                self._playerCatId2Index[catEggDojo.id] = index
            end
            return index, oldPlayerCatId
        end
    end
    return nil
end

function CatBallChooseCardsBaseDataProvide:IsLimitCat(questId,teamIndex)
    if isNull(questId) then
        return false
    end
    local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    if not isNull(levelType) then
        if levelType == Constants.IDType.ClubBoss then
            for index, value in ipairs(self._teamCats) do
                if value.catType == self._catBallType and (value.playerCatId ~= 0)  then
                    local isLimit = ClubUtils.IsBossLimitCat(value.playerCatId)
                    return isLimit
                end
            end
        elseif levelType == Constants.IDType.QuestChaoticRecall then
            local ChaoticRecallUtils = import("Game.UI.FightReady.ChaoticRecall.ChaoticRecallUtils")
            for index, value in ipairs(self._teamCats) do
                if value.catType == self._catBallType and (value.playerCatId ~= 0)  then
                    local isLimit = ChaoticRecallUtils.IsLimitCat(questId,value.playerCatId, teamIndex )
                    return isLimit
                end
            end
        elseif levelType == Constants.IDType.Fairyland then
            local FairylandUtils = import("Game.Fairyland.FairylandUtils")
            for index, value in ipairs(self._teamCats) do
                if value.catType == self._catBallType and (value.playerCatId ~= 0)  then
                    local isLimit = FairylandUtils.IsLimitCat(FairylandUtils.CurrentEnterQuestId, value.playerCatId)
                    return isLimit
                end
            end
        end
    end
    return false
end

---ClearPlayerCatId2Index
---@param isSingle boolean 是否是单独编队
function CatBallChooseCardsBaseDataProvide:ClearPlayerCatId2Index(isSingle)
    if not isSingle then
        return
    end
    local oldPlayerCatId
    for key, value in pairs(self._playerCatId2Index) do
        oldPlayerCatId = key
        self._playerCatId2Index[key] = nil
    end    
    return oldPlayerCatId
end

---ClearTeamCatById
---@param playerCatId number
function CatBallChooseCardsBaseDataProvide:ClearTeamCatById(playerCatId)
    local teamCatIndex = self._playerCatId2Index[playerCatId]
    for _, value in ipairs(self._teamCats) do
        if value.playerCatId == playerCatId then        
            value:ClearFiled()
            break
        end
    end
    
    self._playerCatId2Index[playerCatId] = nil
    return teamCatIndex
end

function CatBallChooseCardsBaseDataProvide:SaveTeamCats()
    
end

--endregion 


--region get/set 

function CatBallChooseCardsBaseDataProvide:GetMaxSelectCatBallNum()
    return self._maxSelectCatBallNum
end

function CatBallChooseCardsBaseDataProvide:GetTeamCats()
    return self._teamCats
end

function CatBallChooseCardsBaseDataProvide:GetPlayerCatId2Index()
    return self._playerCatId2Index
end

function CatBallChooseCardsBaseDataProvide:GetCatBallEntityList()
    return self._catBallEntityList
end

-- function CatBallChooseCardsBaseDataProvide:GetHideToFight()
--     return false
-- end

--- 子类实现 _maxTeamCount 的设置
function CatBallChooseCardsBaseDataProvide:GetMaxTeamCatBallCount()
    return self._maxTeamCatBallCount or 1
end


--- 子类实现
function CatBallChooseCardsBaseDataProvide:GetFilterType() end

---endregion 


--region handler 


---endregion 


function CatBallChooseCardsBaseDataProvide:Release()
    
end


return CatBallChooseCardsBaseDataProvide
