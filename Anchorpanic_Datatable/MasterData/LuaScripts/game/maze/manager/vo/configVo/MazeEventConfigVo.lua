--[[ 
-----------------------------------------------------
@filename       : MazeEventConfigVo
@Description    : 迷宫事件配置数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("maze.MazeEventConfigVo", Class.impl())

function setData(self, eventId, cusData)
    self.mEventId = eventId
    self.mEventType = cusData.event_type
    self.mPrefabName = maze.getPrefabUrl(cusData.prefab_name)
    -- 事件0度方向
    self.mDirectionList = cusData.direction
    self.mDes = cusData.des
    self.misCanPass = cusData.is_cross
    self.mCostMultiplier = cusData.cost_multiplier
    self.mTriggerRange = cusData.trigger_range
    self.mIsRepeat = cusData.is_repeat
    self.mIsAuto = cusData.is_auto
    self.mIsMutexFloor = cusData.is_mutex_floor

    self.mEventTitle = cusData.event_title
    self.mEventDes = cusData.event_des
    self.mTextAbleBtn = cusData.able_btn_text
    self.mTextUnAbleBtn = cusData.unable_btn_text
    self.mIsShowCancel = cusData.is_show_cancel == 1
    
    self.mAfterTriggerTip = cusData.after_trigger_tip
	-- 触发状态列表（触发时，一些特定限制）
	self.triggerStateList = cusData.trigger_state
    -- 触发状态特效
    self.triggerEffectDic = {}
    for _, data in pairs(cusData.trigger_effect_list) do
        self.triggerEffectDic[data[1]] = data[2] 
    end
    --是否今日不在提示
    self.is_notice = cusData.is_notice
end

--今日是否可以提示
function getIsNotice(self)
    return self.is_notice == 1
end

function getEventId(self)
    return self.mEventId or 0
end

function getEventType(self)
    return self.mEventType or 0
end

function getPrefabName(self)
    return self.mPrefabName or ""
end

function getDirectionList(self)
    return self.mDirectionList
end

function getDes(self)
    return self.mDes or ""
end

function isCanPass(self)
    return self.misCanPass == 1
end

function getCostMultiplier(self)
    return self.mCostMultiplier
end

function triggerRange(self)
    return self.mTriggerRange or 0
end

-- 前端暂时没用处
-- function isRepeat(self)
--     return self.mIsRepeat == 1
-- end

function isAuto(self)
    return self.mIsAuto == 1
end

function isMutexFloor(self)
    return self.mIsMutexFloor == 1
end

function getEventTitle(self)
    return _TT(self.mEventTitle)
end

function getEventDes(self)
    return _TT(self.mEventDes)
end

function getTextAbleBtn(self)
    return _TT(self.mTextAbleBtn)
end

function getTextUnAbleBtn(self)
    return _TT(self.mTextUnAbleBtn)
end

function getIsShowCancel(self)
    return self.mIsShowCancel
end

function getAfterTriggerTip(self)
    return self.mAfterTriggerTip
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
