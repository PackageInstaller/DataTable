--[[ 
-----------------------------------------------------
@filename       : HeroListScrollItem_1
@Description    : 芯片切换英雄界面
@Author         : hezhilong
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroListScrollItem_3", Class.impl(hero.HeroListScrollItem_1))

function updateBubbleView(self, isFlag)
end

function onClickItemHandler(self)
    local heroSelectVo = self.data
    local heroVo = heroSelectVo:getDataVo()
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_EQUIP_PANEL, { heroId = heroVo.id, tabType = nil })
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
