local DormFightFormationData = class("FormationData")

function DormFightFormationData:ctor()
  self.data = {}
end

function DormFightFormationData.Create()
  local formation = DormFightFormationData.New()
  return formation
end

function DormFightFormationData:GetFormationHeroDic()
  return self.data
end

function DormFightFormationData:SetHero2Formation(index, heroId)
  self.data[index] = heroId
end

function DormFightFormationData:Exchange2Hero(index1, index2)
  local function exchangeNN(index1, index2)
    self.data[index2], self.data[index1] = self.data[index1], self.data[index2]
  end
  
  exchangeNN(index1, index2)
end

function DormFightFormationData:CleanFormation()
  self.data = {}
end

return DormFightFormationData
