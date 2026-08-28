
--region global define
local import = import
--endregion

--region import
---@type CatBallUtils
local CatBallUtils        = import("Game.CatBall.CatBallUtils")
local MaidCoffeeConstants = import("Game.MaidCoffee.MaidCoffeeConstants")
---@type CatBallChooseCardsBaseDataProvide
local BaseDatProvide      = import("Game.CatBall.DataProvide.CatBallChooseCardsBaseDataProvide")
--endregion

--region define

--endregion

---@class CatBallChooseCardsOperatesDataProvide
local CatBallChooseCardsOperatesDataProvide = Class('CatBallChooseCardsOperatesDataProvide', BaseDatProvide)

--region init 

function CatBallChooseCardsOperatesDataProvide:OnInit(argument)
    self:InitData(argument)
end

function CatBallChooseCardsOperatesDataProvide:InitData(argument)
    local catBallType      = argument.catBallType    --位置id
    self._catBallType      = catBallType
    ---@type MaidCoffeeComponent
    local component = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MaidCoffeeComponent)
    self._maxSelectCatBallNum = component:GetMaxCountByType(MaidCoffeeConstants.SelectType.Cat)
    local catList   = component:GetMaidCoffeeCatList()
    self._teamCats  = CatBallUtils.CatList2TeamCatBallList(catList, Constants.CatBallType.Operates, self._maxSelectCatBallNum)

    self._maxTeamCatBallCount = MaidCoffeeConstants.MaidCoffeeCatCount

    BaseDatProvide.InitPlayerCatId2Index(self)
    
    --- 初始化猫球数据
    BaseDatProvide.InitCatBallEntityList(self, catBallType)
 
end

--endregion 


--region logic 


---AddTeamCat
---@param catEggDojo CatEggDojo
function CatBallChooseCardsOperatesDataProvide:AddTeamCat(catEggDojo)
    return BaseDatProvide.AddTeamCat(self, catEggDojo)
end

---ClearTeamCatById
---@param playerCatId number
function CatBallChooseCardsOperatesDataProvide:ClearTeamCatById(playerCatId)
    return BaseDatProvide.ClearTeamCatById(self, playerCatId)
end

function CatBallChooseCardsOperatesDataProvide:SaveTeamCats()
    ---@type MaidCoffeeComponent
    local component = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MaidCoffeeComponent)
    component:SetMaidCoffeeCatList(self._teamCats)
end

--endregion 


--region get/set 

function CatBallChooseCardsOperatesDataProvide:GetMaxSelectCatBallNum()
    return self._maxSelectCatBallNum
end

function CatBallChooseCardsOperatesDataProvide:GetTeamCats()
    return self._teamCats
end

function CatBallChooseCardsOperatesDataProvide:GetPlayerCatId2Index()
    return self._playerCatId2Index
end

function CatBallChooseCardsOperatesDataProvide:GetCatBallEntityList()
    return self._catBallEntityList
end

function CatBallChooseCardsOperatesDataProvide:GetFilterType()
    return Constants.UIFilterType.CatBallOperates
end

---endregion 


--region handler 


---endregion 


function CatBallChooseCardsOperatesDataProvide:Release()
    
end


return CatBallChooseCardsOperatesDataProvide
