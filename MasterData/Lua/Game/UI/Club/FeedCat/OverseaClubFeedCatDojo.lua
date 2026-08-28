---@class OverseaClubFeedCatDojo : ClassFromJson
---@field petsLikeFood number[]                     今日宠物喜爱的食物id
---@field petsFeedTimes number                      今日宠物喂食次数
---@field petsExp number                            宠物经验
---@field petsLevel number                          宠物等级
---@field petsFacade table<number, number>          宠物外观  1  2  3 对应部位
---@field petsFund number                           宠物基金
---@field petsSatiety number                        宠物饱食度
---@field petsPhase number                          宠物阶段
---@field dailyDonateNum number                     今日捐赠次数
local OverseaClubFeedCatDojo = Class("OverseaClubFeedCatDojo", import("Game.Dojo.ClassFromJson"))

function OverseaClubFeedCatDojo:__init()
    self.petsLikeFood = {}
    self.petsFeedTimes = 0
    self.petsExp = 0
    self.petsLevel = 0
    self.petsFacade = {}
    self.petsFund = 0
    self.petsSatiety = 0
    self.dailyDonateNum = 0
end

function OverseaClubFeedCatDojo:CheckData()
    self:CheckPetsLikeFood()
    self:CheckPetsLevel()
    --self:SetPetsFund(self.petsFund)
    --self:SetPetsFacade(self.petsFacade)
    
    self.petsFeedTimes = checkNumber(self.petsFeedTimes)
    self.petsExp = checkNumber(self.petsExp)
    
    self.petsSatiety = checkNumber(self.petsSatiety)
    self.dailyDonateNum = checkNumber(self.dailyDonateNum)
end

function OverseaClubFeedCatDojo:CheckPetsLevel()
    self.petsLevel = checkNumber(self.petsLevel)
    if self.petsLevel == 0 then
        self.petsLevel = 1
    end
    ---@type OverseaClubFeedCatUtils
    local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")
    self.petsPhase = Utils.CalPetPhase(self.petsLevel)
end

function OverseaClubFeedCatDojo:CheckPetsLikeFood()
    self.petsLikeFood = checkTable(self.petsLikeFood)
    for i, v in ipairs(self.petsLikeFood) do
        self.petsLikeFood[i] = checkNumber(v)
    end
end

function OverseaClubFeedCatDojo:SetPetsFacade(petsFacade)
    petsFacade = checkTable(petsFacade)
    petsFacade = self.StringKey_NumberKey(petsFacade)
    self.petsFacade = petsFacade
end

function OverseaClubFeedCatDojo:SetPetsFund(petsFund)
    petsFund = checkNumber(petsFund)
    --同步到item
    local ownNum = GoodsUtils.GetThingNo(Constants.Currency.ClubFeedCatSkinCoin)
    local diff = petsFund - ownNum
    GoodsUtils.DrawRewards({
        {goodsId = Constants.Currency.ClubFeedCatSkinCoin, num = diff}
    })
    self.petsFund = petsFund
end

OverseaClubFeedCatDojo.SetFunc = {
    petsFacade = OverseaClubFeedCatDojo.SetPetsFacade,
    petsFund = OverseaClubFeedCatDojo.SetPetsFund
}

function OverseaClubFeedCatDojo:__delete()
    self.petsLikeFood = nil
    self.petsFeedTimes = nil
    self.petsExp = nil
    self.petsLevel = nil
    self.petsFacade = nil
    self.petsFund = nil
    self.petsSatiety = nil
    self.dailyDonateNum = nil
end

return OverseaClubFeedCatDojo