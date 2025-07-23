--[[ 
-----------------------------------------------------
@filename       : MainPlayDupConst
@Description    : 资源副本
@date           : 2023-02-20 16:43:22
@Author         : Shuai
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("game.mainPlay.manager.MainPlayDupConst", Class.impl())

MAINPLAYDUP_DAILY = 1 -- 物资
MAINPLAY_EQUIP = 2-- 模组
MAINPLAYDUP_POTENCY = 3 -- 潜能

--MAINPLAY_EQUIP = 6 -- 芯片

function getTabList(self)
    if not self.tab then
        self.tab = {}
        --物资
        self.tab[1] = { page = mainPlay.MainPlayDupConst.MAINPLAYDUP_DAILY, funcId = funcopen.FuncOpenConst.FUNC_ID_DUP_DAILY, openEventName = EventName.OPEN_DUP_DAILY_PANEL, nomalLan = _TT(4526), des = _TT(4529) }
        --潜能
        self.tab[2] = { page = mainPlay.MainPlayDupConst.MAINPLAYDUP_POTENCY, funcId = funcopen.FuncOpenConst.FUNC_ID_DUP_HERO_STAR_UP, openEventName = EventName.OPEN_DUP_POTENCY_VIEW, nomalLan = _TT(52083), des = _TT(4612) }
        --模组
        self.tab[3] = { page = mainPlay.MainPlayDupConst.MAINPLAY_EQUIP, funcId = funcopen.FuncOpenConst.FUNC_ID_EQUIP, openEventName = EventName.OPEN_EQUIP_DUP, nomalLan = _TT(4527), des = _TT(4528) }
    end
    return self.tab
end

function getColorByType(self, type)
    if    self.color == nil then
        self.color = "ffffffff"
    end
    if type == mainPlay.MainPlayDupConst.MAINPLAYDUP_DAILY then
        self.color = "e8952bff"
    elseif type == mainPlay.MainPlayDupConst.MAINPLAY_EQUIP then
        self.color = "C777FFff"
    else
        self.color = "58c475ff"
    end
    return self.color
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]