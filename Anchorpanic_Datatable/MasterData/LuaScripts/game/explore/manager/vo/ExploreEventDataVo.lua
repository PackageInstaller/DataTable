module("ExploreEventDataVo",Class.impl())

function parseEventData(self,cusData)
   self.id = cusData.id
   --所需要战员数量
   self.heroNum = cusData.hero_num

   --指定战员职业 
   --1  - 坦克
   --2  - 战士
   --3  - 输出
   --4  - 辅助
   self.heroTypeList = cusData.hero_type

   --指定战员职业所需数量
   self.heroTypeNumList = cusData.hero_type_num

   --指定战员属性类型
   --0-物理/无属性
   --1-电属性
   --2-火属性
   --3-冰属性
   self.eleTypeList = cusData.ele_type

   --指定战员属性类型数量
   self.eleTypeNumList = cusData.ele_type_num
   
   --事件名称 语言包ID
   self.eventName = cusData.event_name
   --要求说明 语言包ID
   self.explain = cusData.explain

   --事件说明 语言包ID
   self.eventExplain = cusData.event_explain
   --探索时间
   self.needTime = cusData.need_time

   --显示奖励
   self.showAeward = cusData.show_reward

   --icon
   self.pic = cusData.pic
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
