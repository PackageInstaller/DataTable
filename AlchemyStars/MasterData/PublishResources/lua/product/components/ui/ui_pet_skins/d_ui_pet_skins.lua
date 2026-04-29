local PetSkinFlag = {
  PSF_NORMAL = 1,
  PSF_COLLECTION = 2,
  PSF_MEMORY = 4,
  PSF_WISH = 5
}
_enum("PetSkinFlag", PetSkinFlag)
local PetSkinUiOpenType = {
  PSUOT_SHOW_LIST = 1,
  PSUT_SHOP_DETAIL = 2,
  PSUOT_TIPS = 3,
  PSUT_ACTIVITY_DETAIL = 4,
  PSUOT_SEASON_SKIN = 5
}
_enum("PetSkinUiOpenType", PetSkinUiOpenType)
local PetSkinStateType = {
  PSST_CUR_SKIN = 1,
  PSST_CAN_USE = 2,
  PSST_NOT_OBTAIN = 3,
  PSST_SHOP_BUY = 4,
  PSST_SHOP_OBTAINED = 5
}
_enum("PetSkinStateType", PetSkinStateType)
local PetSkinUnlockType = {
  PSUT_BASE = 1,
  PSUT_GRADE = 2,
  PSUT_SHOP = 3,
  PSUT_HauteCouture = 4,
  PSUT_BattlePass = 5,
  PSUT_Dream = 6
}
_enum("PetSkinUnlockType", PetSkinUnlockType)
_class("DPetSkinDetailCard", Object)
DPetSkinDetailCard = DPetSkinDetailCard

function DPetSkinDetailCard:Constructor(cfg)
  self.cfg = cfg
  self.unlock_CG = 0
  self.is_onbody = false
  self.obtained = false
  self.is_shop_detail = false
  self.is_tips_detail = false
end

function DPetSkinDetailCard:GetSkinId()
  if self.cfg then
    return self.cfg.id
  end
  return 0
end

function DPetSkinDetailCard:SetIsTipsDetail(inShop)
  self.is_tips_detail = inShop
end

function DPetSkinDetailCard:IsTipsDetail()
  return self.is_tips_detail
end

function DPetSkinDetailCard:SetIsShopDetail(inShop)
  self.is_shop_detail = inShop
end

function DPetSkinDetailCard:IsShopDetail()
  return self.is_shop_detail
end

function DPetSkinDetailCard:SetObtained(obtained)
  self.obtained = obtained
end

function DPetSkinDetailCard:IsObtained()
  return self.obtained
end

function DPetSkinDetailCard:SetIsCurrentSkin(isCurrent)
  self.is_onbody = isCurrent
end

function DPetSkinDetailCard:IsCurrentSkin()
  return self.is_onbody
end

function DPetSkinDetailCard:SetUnlockCg(unlockCg)
  self.unlock_CG = unlockCg
end

function DPetSkinDetailCard:IsUnlockCg()
  return self.unlock_CG == 1
end
