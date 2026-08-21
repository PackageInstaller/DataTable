module("manual.ManualMapVo", Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.areaList = cusData.area_list
    self.mapIcon = cusData.map_icon
    self.pos = cusData.pos
    self.titlePos = cusData.title_pos
    self.name = cusData.name
    self.engName = cusData.eng_name
    self.icon = cusData.icon 
    self.sort = cusData.sort
    self.des = cusData.des
end

return _M