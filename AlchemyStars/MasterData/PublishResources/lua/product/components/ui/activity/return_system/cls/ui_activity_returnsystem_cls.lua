_class("ActivityReturnSystemLoginAward", Object)
ActivityReturnSystemLoginAward = ActivityReturnSystemLoginAward

function ActivityReturnSystemLoginAward:Constructor()
  self.day = 0
  self.petId = 0
  self.petIcon = ""
  self.petName = ""
  self.petGreeting = ""
  self.petAwardName = ""
  self.status = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_UNKNOW
  self.awards = {}
end

function ActivityReturnSystemLoginAward:InitPetInfo(petId)
  local cfgv = Cfg.cfg_pet[petId]
  if not cfgv then
    Log.fatal("### no pet in cfg_pet.petId=", petId)
    return
  end
  self.petIcon = HelperProxy:GetInstance():GetPetTeamBody(petId, 0, cfgv.SkinId, PetSkinEffectPath.CARD_TEAM)
  self.petName = StringTable.Get(cfgv.Name)
  self.petGreeting = StringTable.Get("str_return_system_award_hello_" .. petId)
  self.petAwardName = StringTable.Get("str_return_system_award_from_" .. petId)
end

function ActivityReturnSystemLoginAward:SetStatus(status)
  self.status = status
end
