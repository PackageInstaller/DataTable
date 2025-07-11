--[[ 
-----------------------------------------------------
@filename       : MazeFightResultWinView
@Description    : 默示之境战斗结算胜利界面
@date           : 2021-07-07 10:49:46
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('fightUI.MazeFightResultWinView', Class.impl(fightUI.FightResultWinView))

-- 关闭界面发送通知
function sendFightOver(self)
    if #self.resultData.award > 0 then
        ShowAwardPanel:showPropsAwardMsg(self.resultData.award, function()
            role.RoleController:onShowPlayerLvlUp(function()
                maze.MazeController:onShowSelectGoods(function()
                    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER,{isWin = true})
                end)
            end)
        end)
    else
        role.RoleController:onShowPlayerLvlUp(function()
            maze.MazeController:onShowSelectGoods(function()
                GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER,{isWin = true})
            end)
        end)
    end

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
