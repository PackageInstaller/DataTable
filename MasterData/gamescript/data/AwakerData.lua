local AwakerData = Vue.reactive({})
AwakerData.awakerMap = {}
AwakerData.mockAwakerMap = {}
AwakerData.showAttrIds = nil
AwakerData.skillTypeLT = {
  "RoleDetailsSkill_Str_ActiveSkill",
  "RoleDetailsSkill_Str_Atk",
  "RoleDetailsSkill_Str_Def",
  "RoleDetailsSkill_Str_AbilitySkill",
  "RoleDetailsSkill_Str_Skill"
}
AwakerData.showAwakerList = {}
AwakerData.curShowAwakerIndex = 0
AwakerData.gainNewAwakerList = {}
AwakerData.curShowAwaker = nil
AwakerData.hasReqServerData = false
AwakerData.TalentDataMap = {}
return AwakerData
