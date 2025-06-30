module('branchStory.BranchTactivsStageVo', Class.impl())

-- 解析数据
function parseData(self, cusId, cusData)
    self.stageId = cusId
    self.mName = cusData.name
    -- 所属章节
    self.chapterId = cusData.chapter
    -- 关卡名
    self.mStageName = cusData.stage_name
    self.des = cusData.explain
    -- 消耗
    self.costTid = cusData.need_tid
    self.costNum = cusData.need_num
    -- 通关展示奖励包id
    self.awardPackId = cusData.drop
    self.m_musicId = cusData.music_id
    self.m_sceneId = cusData.scene_id
    -- 关卡类型
    self.type = cusData.stage_type
    self.pointLineData = cusData.point_line
end

function getName(self)
    return self.mName
end

function getStageName(self)
    return _TT(self.mStageName)
end

function getDes(self)
    return _TT(self.des)
end

function getMusicId(self)
	return self.m_musicId
end

function getSceneId(self)
	return self.m_sceneId
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
