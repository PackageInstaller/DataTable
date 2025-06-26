--[[ 
-----------------------------------------------------
@filename       : FightWinSignView
@Description    : 战斗结算胜利标识
@date           : 2021-01-21 13:53:28
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('fightUI.FightWinSignView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("figthtResult/FightWinSignView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0

--初始化UI
function configUI(self)
    self.mImgTitle_Win = self:getChildGO("mImgTitle_Win")
    self.mImgTitle_Suc = self:getChildGO("mImgTitle_Suc")

end

--激活
function active(self)
    AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_battle_win.prefab"))
    LoopManager:setTimeout(1.5,self,function ()
        self:close()
    end)


    local battleType = fight.FightManager:getBattleType()
    if battleType == PreFightBattleType.Guild_boss_war or battleType == PreFightBattleType.Guild_boss_imitate then
        self.mImgTitle_Suc:SetActive(true)
        self.mImgTitle_Win:SetActive(false)
    else
        self.mImgTitle_Suc:SetActive(false)
        self.mImgTitle_Win:SetActive(true)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
