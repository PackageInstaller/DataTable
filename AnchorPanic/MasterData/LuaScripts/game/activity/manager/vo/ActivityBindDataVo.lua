module('game.activity.manager.vo.ActivityBindDataVo', Class.impl())

function parseData(self, id, data)
    self.id = id
    self.taskParty = data.task_party
    self.taskType = data.task_type
    self.time = data.time
    self.describe = data.describe
    self.title = data.title
    self.reward = data.reward
    self.uiCode = data.ui_code
end

return _M