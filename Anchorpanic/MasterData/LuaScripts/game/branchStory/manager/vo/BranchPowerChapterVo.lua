module("branchStory.BranchPowerChapterVo", Class.impl())
--[[ 
    关卡章节数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.chapterId = cusId

    --关卡名称
    self.mName = cusData.stage_name
    --副本说明
    self.explain = cusData.explain
    --需要的道具
    self.needTid = cusData.need_tid
    --需要的道具数量
    self.needNum = cusData.need_num
    --展示的道具包id
    self.showDrop = cusData.show_drop

    --音乐id
    self.musicId = cusData.music_id
    --场景id
    self.sceneId = cusData.scene_id
    --关卡类型
    self.stageType = cusData.stage_type
    --解锁条件
    self.unlockStage = cusData.unlock_stage

    --提示标题
    self.pointTitle = cusData.point_title
    --提示内容
    self.pointDes = cusData.point_des

    self.mIconPath = cusData.img

    -- 格挡次数
    self.blockNum = cusData.block_num

    -- self.needMainStageId = cusData.unlock_stage
    -- self.mUnLockText = cusData.unlock_text
    -- self.mIconPath = cusData.icon_image
    -- self.stageIdList = {}

    -- local len = #cusData.stage
    -- for i = 1, len do
    --     table.insert(self.stageIdList, cusData.stage[i])
    -- end
    -- table.sort(self.stageIdList, self.__sortStageIdList)
end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
