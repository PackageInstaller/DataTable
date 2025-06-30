--[[ 
-----------------------------------------------------
@filename       : EliminateMapVo
@Description    : 消消乐关卡配置数据
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateStageConfigVo", Class.impl())

function setData(self, mapId, cusData)
    self.mapId = mapId
    self.mapRow = cusData.max_row
    self.mapCol = cusData.max_col

    self.tileSize = cusData.tile_size
    self.maskBg = cusData.mask_bg
    self.preMapId = cusData.pre_id
    
    self.mapName = cusData.name
    self.mapAwardId = cusData.first_award
    self.targetList = cusData.target_list
    self.maxRound = cusData.max_round
    self.dropThingTypeList = cusData.drop_list
    
    self.beginTimeData = {}
    if not table.empty(cusData.begin_time) then
		self.beginTimeData.year = cusData.begin_time[1][1]
		self.beginTimeData.month = cusData.begin_time[1][2]
		self.beginTimeData.day = cusData.begin_time[1][3]
		self.beginTimeData.hour = cusData.begin_time[2][1]
		self.beginTimeData.min = cusData.begin_time[2][2]
		self.beginTimeData.sec = cusData.begin_time[2][3]
    end
end

function isLock(self)
  local isLock = true
  if(self.preMapId <= 0)then
    isLock = false
  else
    local preStageConfigVo = eliminate.EliminateManager:getMapStageConfigVo(self.preMapId)
    if(preStageConfigVo:isOpen() and eliminate.EliminateManager:isStagePass(self.preMapId))then
      isLock = false
    end
  end
  return isLock
end

function isOpen(self)
    local isOpen = false
    if table.empty(self.beginTimeData) then
		  isOpen = true
	  else
      isOpen = GameManager:getClientTime() > os.time(self.beginTimeData)
    end
    return isOpen
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
