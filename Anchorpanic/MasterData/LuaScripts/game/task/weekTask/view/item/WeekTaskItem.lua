--[[ 
-----------------------------------------------------
@filename       : WeekTaskItem
@Description    : 周常任务项目
@date           : 2020-11-30 10:35:08
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.task.weekTask.view.item.view.WeekTaskItem', Class.impl(task.DailyTaskItem))

function setData(self, param)
    super.setData(self, param)
    self.taskVo = param
    if (self.taskVo.id == 1) then
        self:setGuideTrans("guide_mGuideDaily_1", self.mBtnGet.transform)
    end
    self:updateView()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
