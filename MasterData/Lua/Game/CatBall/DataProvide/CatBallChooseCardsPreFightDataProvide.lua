
--region global define

--endregion

--region import
---@type CatBallUtils
local CatBallUtils =  import("Game.CatBall.CatBallUtils")
---@type CatBallChooseCardsBaseDataProvide
local BaseDatProvide      = import("Game.CatBall.DataProvide.CatBallChooseCardsBaseDataProvide")
--endregion

--region define
local CatBallType = Constants.CatBallType

--endregion

---@class CatBallChooseCardsPreFightDataProvide
local CatBallChooseCardsPreFightDataProvide = Class('CatBallChooseCardsPreFightDataProvide', BaseDatProvide)


--region init 

function CatBallChooseCardsPreFightDataProvide:OnInit(argument)
    self:InitData(argument)
end

function CatBallChooseCardsPreFightDataProvide:InitData(argument)
    self._levelId          = argument.levelId --- 关卡id
    self._teamNumType      = argument.teamNumType -- 编队类型
    self._teamIndex        = argument.teamIndex or 1    --位置id
    ---@type Constants.CatBallType
    local catBallType      = argument.catBallType    --位置id
    self._catBallType      = catBallType
    self._maxSelectCatBallNum    = 1

    --- 初始化猫编队数据
    ---@type TeamComponent
    local teamComponent    = GameUtils.GetEntityCompByType(ECSComponentType.Constants.TeamComponent)
    --- 这里会把主被动猫全取出 也就是teamComponent:GetMaxTeamCatNum() 个数条数据
    if self._teamNumType then
        ---@type TeamCatBallDojo[]
        self._teamCats         = clone(teamComponent:GetTeamCatByTeamType(self._teamNumType, self._teamIndex))
    else
        ---@type TeamCatBallDojo[]
        self._teamCats         = clone(teamComponent:GetTeamCatByQuestId(self._levelId, self._teamIndex))
    end
    --- 主被动猫球只能选一个
    self._maxTeamCatBallCount = 1

    BaseDatProvide.InitPlayerCatId2Index(self)

    --- 初始化猫球数据
    BaseDatProvide.InitCatBallEntityList(self, catBallType)
end

--endregion 


--region logic 

---AddTeamCat
---@param catEggDojo CatEggDojo
function CatBallChooseCardsPreFightDataProvide:AddTeamCat(catEggDojo)
    return BaseDatProvide.AddTeamCat(self, catEggDojo)
end

-- function CatBallChooseCardsPreFightDataProvide:GetHideToFight()
--     return true
-- end

---ClearTeamCatById
---@param playerCatId number
function CatBallChooseCardsPreFightDataProvide:ClearTeamCatById(playerCatId)
    return BaseDatProvide.ClearTeamCatById(self, playerCatId)
end

function CatBallChooseCardsPreFightDataProvide:SaveTeamCats()
    ---@type TeamComponent
    local teamComponent    = GameUtils.GetEntityCompByType(ECSComponentType.Constants.TeamComponent)
    if self._teamNumType then
        teamComponent:SetTeamCatByTeamType(self._teamNumType, self._teamCats, self._teamIndex)
    else
        teamComponent:SetTeamCatByQuestId(self._levelId, self._teamCats, self._teamIndex)
    end
end

--endregion 


--region get/set 

function CatBallChooseCardsPreFightDataProvide:GetMaxSelectCatBallNum()
    return self._maxSelectCatBallNum
end

function CatBallChooseCardsPreFightDataProvide:GetTeamCats()
    return self._teamCats
end

function CatBallChooseCardsPreFightDataProvide:GetCatBallEntityList()
    return self._catBallEntityList
end

function CatBallChooseCardsPreFightDataProvide:GetPlayerCatId2Index()
    return self._playerCatId2Index
end

function CatBallChooseCardsPreFightDataProvide:GetFilterType()
    return Constants.UIFilterType.CatBallFight
end

function CatBallChooseCardsPreFightDataProvide:GetIsShowLevelUpBtn()
    local curLevelType = GoodsUtils.GetIdType(self._levelId, Constants.IDArea.Quests)     --关卡类型
    return not (curLevelType == Constants.IDType.QuestMapDecryptionMap or curLevelType == Constants.IDType.QuestMapDecryptionTracking)
end

---endregion 


--region handler 


---endregion 


function CatBallChooseCardsPreFightDataProvide:Release()
    
end


return CatBallChooseCardsPreFightDataProvide
