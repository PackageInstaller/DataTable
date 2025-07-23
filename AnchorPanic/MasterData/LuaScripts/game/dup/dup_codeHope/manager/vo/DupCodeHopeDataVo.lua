--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeDataVo
@Description    : 代号·希望副本总览
@date           : 2021-05-10 15:15:04
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dup_codeHope.manager.vo.DupCodeHopeDataVo', Class.impl())

function parseData(self, cusId, cusData)
    self.id = cusId
    self.name = cusData.name
    self.selectName = cusData.select_name
    self.stageList = cusData.stage
    self.background = cusData.background
    self.buffList = cusData.buff_arr
    self.chapterAward = AwardPackManager:getAwardListById(cusData.chapter_award)
end

function getAwardList(self)
    local propsList = {}
    for i = 1, #self.chapterAward do
        local propsVo = props.PropsVo.new()
        propsVo:setTid(self.chapterAward[i].tid)
        propsVo.count = self.chapterAward[i].num
        table.insert(propsList,propsVo)
    end

    return propsList
end

function getName(self)
    return _TT(self.name)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
