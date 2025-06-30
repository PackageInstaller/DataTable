-- @FileName:   FieldExplorationEventMoveSkill.lua
-- @Description:   拖动
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventLasetReflexSkill_M', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)

end

--提示器碰撞触发
function onTriggerEnterCall(self, tag, colliderTagID)
    self.tag = self.config.tid .. "_" .. self.mExecuteThing:getData().id

    local data =
    {
        tag = self.tag,
        params = {},
    }

    for i = 1, #self.config.param do
        local param = {}
        param.enId = self.config.param[i][2]
        param.callback = function ()
            local pos = gs.Vector3(self.config.param[i][1][1], 0, self.config.param[i][1][2]) + self.mExecuteThing:getCurPos()
            self.mExecuteThing:setPositionTween(pos, 0.3, function ()
                GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_LASETSHOOTSKILL_CHECKRAYCAST)
            end)
        end

        table.insert(data.params, param)
    end

    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_SHOWFUNCLICK, data)
end

--提示器碰撞退出
function onTriggerExitCall(self, tag, colliderTagID)
    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_HIDEFUNCLICK, self.tag)
end

function recover(self)
    super.recover(self)

    self.tag = nil
end

return _M
