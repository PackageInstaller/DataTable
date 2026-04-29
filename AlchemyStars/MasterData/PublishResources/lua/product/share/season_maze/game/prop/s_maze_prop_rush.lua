_class("SMazeProp_Rush", SMazePropBase)
SMazeProp_Rush = SMazeProp_Rush

function SMazeProp_Rush:Use(TT)
  local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  local res = AsyncRequestRes:New()
  cpt:HandleSeasonMazeUseOnce(TT, res, self:CfgID())
  if res:GetSucc() then
    Log.info("冲刺道具使用成功")
    return true
  else
    Log.error("冲刺道具使用失败:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return false
    end
    return false
  end
end
