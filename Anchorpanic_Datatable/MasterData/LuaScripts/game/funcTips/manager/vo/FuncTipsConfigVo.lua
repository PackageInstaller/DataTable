--[[ 
-----------------------------------------------------
@filename       : FuncTipsConfigVo
@Description    : 功能说明配置数据
@date           : 2021-02-23 17:11:57
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.funcTips.manager.vo.FuncTipsConfigVo', Class.impl())

function ctor(self)
end

function parseData(self, cusId, cusData)
    self.id = cusId
    self.uicode = cusData.uicode
    self.index = cusData.index
    self.type = cusData.type
    -- self.posX = cusData.posx
    -- self.posY = cusData.posy
    -- self.areaW = cusData.areaw
    -- self.areaH = cusData.areah
    self.explain = cusData.explain
    self.control = cusData.control
end

function getExplain(self)
    return _TT(self.explain)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
