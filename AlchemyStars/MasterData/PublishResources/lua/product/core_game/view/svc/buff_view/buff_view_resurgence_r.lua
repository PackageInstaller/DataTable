_class("BuffViewResurgence", BuffViewBase)
BuffViewResurgence = BuffViewResurgence

function BuffViewResurgence:PlayView(TT)
  local result = self._buffResult
  local playerEntity = result:GetEntity()
  local beforeResurgenceTeamLeader = result:GetLeader()
  local addHPValue = result:GetAddValue()
  local damageInfo = result:GetDamageInfo()
  local teamLeaderEntity = self._world:Player():GetLocalTeamEntity():GetTeamLeaderPetEntity()
  beforeResurgenceTeamLeader:SetViewVisible(false)
  playerEntity:SetViewVisible(true)
  local tOldTeamOrder = result:GetOldTeamOrder()
  local tNewTeamOrder = result:GetNewTeamOrder()
  local viewRequest = BattleTeamOrderViewRequest:New(tOldTeamOrder, tNewTeamOrder, BattleTeamOrderViewType.FillVacancies_MazePetDead)
  local renderBattleSvc = self._world:GetService("RenderBattle")
  renderBattleSvc:RequestUIChangeTeamOrderView(viewRequest)
  local ntTeamOrderChange = NTTeamOrderChange:New(self._world:Player():GetLocalTeamEntity(), tOldTeamOrder, tNewTeamOrder)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, ntTeamOrderChange)
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:OnTeamOrderChangeRefresh()
  local deadTriggerParam = "Death"
  local deadAnimName = "death"
  local viewCmpt = playerEntity:View()
  local playerObj = viewCmpt:GetGameObject()
  local animTimeLen = GameObjectHelper.GetActorAnimationLength(playerObj, deadAnimName)
  playerEntity:SetAnimatorControllerTriggers({deadTriggerParam})
  YIELD(TT, animTimeLen * 1000)
  local animator = playerObj.transform:Find("Root"):GetComponent(typeof(UnityEngine.Animator))
  animator:Play("idle", 0)
  local targetEffectID = self:BuffViewInstance():BuffConfigData():GetExecEffectID()
  if targetEffectID then
    local effectService = self._world:GetService("Effect")
    local effectEntity = effectService:CreateEffect(targetEffectID, playerEntity)
    YIELD(TT, 1000)
  end
  local battleRenderCmpt = self._world:BattleRenderConfig()
  battleRenderCmpt:RemoveDeadPet(playerEntity:PetPstID():GetPstID())
  local playDamageSvc = self._world:GetService("PlayDamage")
  playDamageSvc:UpdateTargetHPBar(TT, playerEntity, damageInfo)
  playerEntity:SetViewVisible(false)
  teamLeaderEntity:SetViewVisible(true)
end
