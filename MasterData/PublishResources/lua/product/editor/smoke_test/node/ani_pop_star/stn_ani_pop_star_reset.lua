require("common_async_base")
_class("AniPopStar_Reset", Common_AsyncBase)
AniPopStar_Reset = AniPopStar_Reset

function AniPopStar_Reset:Constructor(_manager)
end

function AniPopStar_Reset:TaskFunc(TT, status)
  local strcmd = string.format("AnipopUnlockAllHard %s", LocalDB.GetString("OpenIdTest"))
  self.m_pManager:SendCheatCommand(strcmd)
  self.m_pManager:Log(self, "Command sent: ", strcmd)
  local res = AsyncRequestRes:New()
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  res = anipopModule:RequestAnipopInfo(TT)
  if res:GetSucc() then
    local aniPopInfo = anipopModule:GetAniPopInfo()
    local res = anipopModule:Balance(TT, aniPopInfo.cur_hard_id)
    if res:GetSucc() then
    else
      Log.fatal("启迪互联重置失败:", res:GetResult())
    end
    local testHardID = 1
    local runData = self.m_pManager:GetMissionRunData()
    testHardID = runData:GetHardID()
    local res = anipopModule:SelectHard(TT, testHardID)
    if res:GetSucc() then
    else
      Log.fatal("启迪互联选择难度错误：", res:GetResult())
    end
  else
    Log.fatal("启迪互联请求失败:", res:GetResult())
  end
end
