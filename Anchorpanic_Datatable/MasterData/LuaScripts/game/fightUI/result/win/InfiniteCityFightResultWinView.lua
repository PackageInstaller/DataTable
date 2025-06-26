--[[ 
-----------------------------------------------------
@filename       : InfiniteCityFightResultWinView
@Description    : 战斗结算胜利界面
@date           : 2021-03-08 14:57:28
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('fightUI.InfiniteCityFightResultWinView', Class.impl(fightUI.FightResultWinView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("figthtResult/InfiniteCityFightResultWinView.prefab")

function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)
    self.mTxtDisasterLv = self:getChildGO("mTxtDisasterLv"):GetComponent(ty.Text)
    self.mTxtScoure = self:getChildGO("mTxtScoure"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    self:updateScore()
end

--非激活
function deActive(self)
    super.deActive(self)
end

function updateScore(self)
    self.mTxtDisasterLv.text = _TT(3040, self.resultData.args[1])
    self.mTxtScoure.text = _TT(3041, self.resultData.args[2])
end

-- 关闭界面发送通知
function sendFightOver(self)
    if #self.resultData.award > 0 then
        ShowAwardPanel:showPropsAwardMsg(self.resultData.award, function()
            role.RoleController:onShowPlayerLvlUp(function()
                infiniteCity.InfiniteCityController:onShowSelectTrophy(function()
                    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER,{isWin = true})
                end)
            end)
        end)
    else
        role.RoleController:onShowPlayerLvlUp(function()
            infiniteCity.InfiniteCityController:onShowSelectTrophy(function()
                GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER,{isWin = true})
            end)
        end)
    end

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
