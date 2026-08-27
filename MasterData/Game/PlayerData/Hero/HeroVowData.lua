local HeroVowData = class("HeroVowData")

function HeroVowData.CreateVowData(VowMsg)
  VowMsg = VowMsg or table.emptytable
  local heroVowData = HeroVowData.New()
  heroVowData.vowTime = VowMsg.vowTime or 0
  heroVowData.sign = VowMsg.sign or table.emptytable
  heroVowData.name = VowMsg.name or ""
  heroVowData.nextModifyNameTm = VowMsg.nextModifyNameTm or -1
  return heroVowData
end

return HeroVowData
