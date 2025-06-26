-- @FileName:   FieldExplorationEventPassageSkill.lua
-- @Description:   通路技能,间隔检测是否没有东西在上面
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.event.FieldExplorationEventPassageSkill', Class.impl(fieldExploration.FieldExplorationEventBaseSkill))

function setData(self, config, parent)
    super.setData(self, config, parent)
    self.isPass = true
end

--提示器碰撞触发
function onTriggerStayCall(self, tag, colliderTagID)
    if tag ~= "AirWall" then
        self.isPass = false

        if self.mExecuteThing.onBlock ~= nil then
            self.mExecuteThing:onBlock()
        end
    end
end

--提示器碰撞退出
function onTriggerExitCall(self, tag, colliderTagID)
    self.isPass = true

    if self.mExecuteThing.onPass ~= nil then
        self.mExecuteThing:onPass()
    end
end

function getColliderTags(self)
    return {FieldExplorationConst.ColliderTag.Event}
end

function getIsPass(self)
    -- if self.isPass then
    --     self.mTran.parent.gameObject.name = "pass"
    -- end
    return self.isPass
end

return _M
