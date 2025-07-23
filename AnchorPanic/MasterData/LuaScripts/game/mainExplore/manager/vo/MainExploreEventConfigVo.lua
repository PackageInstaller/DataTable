--[[ 
-----------------------------------------------------
@filename       : MainExploreItemConfigVo
@Description    : 主线探索事件配置
@date           : 2022-3-29 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreEventConfigVo", Class.impl())

function parseConfig(self, mapId, eventId, cusData)
	-- 地图id
	self.mapId = mapId
	-- 事件id
	self.eventId = eventId
	-- 小地图图标
	self.miniIcon = cusData.mini_icon
	-- 小地图图标是否显示在外边
	self.miniShowOutEnable = cusData.mini_showout_enable == 1
	-- 小地图是否显示范围
	self.miniRangeEnable = cusData.mini_range_enable == 1
	-- 事件总类型（环境事件（不互斥）、常规事件（互斥））
	self.totalType = cusData.type
	-- 事件类型
	self.eventType = cusData.event_type
	-- 事件标题
	self.mDes = cusData.event_des
	-- 事件描述
	self.mTitle = cusData.event_title
	-- 巡逻类型
	self.partolType = cusData.find_type
	-- 正常移动速度
	self.normalSpeed = cusData.normal_speed
	-- 撤销索敌成功的跟随移动速度
	self.cancelFollowSpeed = cusData.cancel_follow_speed
	-- 索敌成功的跟随移动速度
	self.followSpeed = cusData.follow_speed
	-- 索敌范围
	self.findRange = cusData.find_range
	-- 索敌角度
	self.findAngle = cusData.find_angle
	-- 攻击范围
	self.attackRange = cusData.attact_range
	-- 最大追踪距离
	self.maxFollowRange = cusData.max_range
	-- 感应范围（为了让怪物屁股后面可以感应到玩家偷袭）
	self.reactionRange = cusData.reaction_range
	-- 模型正常播放速度
	self.normalAnimationSpeed = cusData.normal_animation_speed
	-- 模型资源
	self.modelPrefab = cusData.prefab_name
	-- 可点击的按钮文字
	self.mEnableBtnDes = cusData.able_btn_text
	-- 交互距离
	self.interactRange = cusData.interact_range
	-- 障碍物数据
	self.mObstacleData = cusData.obstacle_data
	-- 是否可通过（决定是否启用NavMeshObstacle）
	self.enableObstacle = cusData.is_cross == 0

    -- 事件效果列表
    self.mEventEffectList = cusData.event_effect
    -- 事件触发的前置条件事件列表
	self.frontEventIdList = cusData.front_id
	-- 是否进入交互范围就自动触发
	self.isAutoTrigger = cusData.is_auto == 1
	-- 是否重复触发
	self.isCanRepeat = cusData.is_repeat == 1
	-- 触发状态列表（触发时，一些特定限制）
	self.triggerStateList = cusData.trigger_state
    
	-- 剧情对话数据
    self.mEventTalkData = cusData.talk_id

	-- 初次介绍的对话一id（非剧情对话）
	self.introduceId = cusData.introduce_id
	-- 初次介绍的触发范围（非剧情对话）
	self.introduceRange = cusData.introduce_range
end

function getDes(self)
	return _TT(self.mDes)
end

function getTitle(self)
	return _TT(self.mTitle)
end

function getEnableBtnDes(self)
	return _TT(self.mEnableBtnDes)
end

-- 获取障碍物数据
function getObstacleData(self)
	if(#self.mObstacleData > 0)then
		local type = self.mObstacleData[1]
		local center = math.Vector3(self.mObstacleData[2][1] / 100, self.mObstacleData[2][2] / 100, self.mObstacleData[2][3] / 100)
		local size = math.Vector3(self.mObstacleData[3][1] / 100, self.mObstacleData[3][2] / 100, self.mObstacleData[3][3] / 100)
		return type, center, size
	else
		return nil, nil, nil
	end
end

-- 根据具体事件类型获取效果参数
function getEffecctList(self, startIndex, endIndex)
    if (self.mEventEffectList) then
        if (startIndex == nil and endIndex == nil) then
            return self.mEventEffectList
        else
            local list = {}
            local effectLen = #self.mEventEffectList
            startIndex = startIndex == nil and 1 or startIndex
            endIndex = endIndex == nil and effectLen or endIndex

            startIndex = startIndex < 1 and 1 or startIndex
            startIndex = startIndex > effectLen and effectLen or startIndex

            endIndex = endIndex < 1 and 1 or endIndex
            endIndex = endIndex > effectLen and effectLen or endIndex

            if (startIndex > endIndex) then
                startIndex, endIndex = endIndex, startIndex
            end

            for i = startIndex, endIndex do
                table.insert(list, self.mEventEffectList[i])
            end
            return list
        end
    else
        return {}
    end
end

-- 1:对话在事件触发表现前，2:对话在事件触发表现后
function getEventTalkData(self)
    if(#self.mEventTalkData > 0)then
        local isPlayBefore = self.mEventTalkData[1] == 1
        local talkId = self.mEventTalkData[2]
        return isPlayBefore, talkId
    else
        return nil, nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
