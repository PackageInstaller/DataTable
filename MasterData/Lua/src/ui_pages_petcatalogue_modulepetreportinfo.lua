local this = class("modulePetReportInfo", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    activeShowRoot = true,
    activeProgress = false,
    activeFinish = false,
    txtLessTimes = "",
    listReportReward = {
      moduleName = "pages/petCatalogue/cellPetTaskRewardTag"
    },
    txtNormalContent = L_WordsTpl:getValue("ui_iconography_pet_star_link_reward_03"),
    txtFinished = L_WordsTpl:getValue("ui_iconography_pet_star_link_reward_01")
  }
end

function this:setReportInfo(petId)
  local petData = _petTpl:getTplById(petId)
  local maxNumber = _petTpl:getIconographyReportTimes(petData) or 0
  local hasNumber = 0 < maxNumber
  self.bind.activeShowRoot = hasNumber
  if not hasNumber then
    return
  end
  local progressNumber = L_CatalogStore:getReportRewardTimes(petId) or 0
  local showLessNumber = maxNumber > progressNumber
  self.bind.activeProgress = showLessNumber
  self.bind.activeFinish = not showLessNumber
  if showLessNumber then
    local lessNumber = maxNumber - progressNumber
    self.bind.txtLessTimes = L_WordsTpl:getValue("ui_iconography_pet_star_link_reward_02", {
      [0] = lessNumber
    })
    local rewardConfig = _petTpl:getIconographyReportReward(petData)
    local rewardInfo = L_DataUtil.parseRewardConfig(rewardConfig)
    self.bind.listReportReward:clear()
    self.bind.listReportReward:insert_array(rewardInfo)
  end
end

return this
