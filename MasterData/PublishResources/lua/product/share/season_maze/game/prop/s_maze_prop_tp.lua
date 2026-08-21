_class("SMazeProp_TP", SMazePropBase)
SMazeProp_TP = SMazeProp_TP

function SMazeProp_TP:Use(TT)
  local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  local res = AsyncRequestRes:New()
  cpt:HandleSeasonMazeUseOnce(TT, res, self:CfgID())
  if res:GetSucc() then
    Log.info("回城道具使用成功")
    return true
  else
    Log.error("回城道具使用失败:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return false
    end
    return false
  end
end
