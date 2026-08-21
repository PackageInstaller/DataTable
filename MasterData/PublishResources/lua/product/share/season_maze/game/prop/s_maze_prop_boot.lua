_class("SMazeProp_Boot", SMazePropBase)
SMazeProp_Boot = SMazeProp_Boot

function SMazeProp_Boot:Use(TT)
  local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  local res = AsyncRequestRes:New()
  cpt:HandleSeasonMazeUseOnce(TT, res, self:CfgID())
  if res:GetSucc() then
    Log.info("跑鞋道具使用成功")
    return true
  else
    Log.error("跑鞋道具使用失败:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return false
    end
    return false
  end
end
