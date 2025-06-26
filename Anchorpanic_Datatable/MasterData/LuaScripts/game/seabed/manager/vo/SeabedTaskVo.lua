module("seabed.SeabedTaskVo", Class.impl())

function parseData(self,id,data)
    self.id = id 

    self.tagType = data.tag_type
    self.taskType = data.task_type
    self.times = data.times
    self.des = data.des
    self.title = data.title
    self.rewards = data.rewards
end

function getUiCode(self)
    return 0
end

return _M