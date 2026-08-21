module('ghost.GhostRunGameVo', Class.impl())

function setData(self, index, level, simpleItem)
    self.index = index
    self.level = level
    self.simpleItem = simpleItem
    --simpleItem:getGo():GetComponent(ty.PhysicsCollision2D):SetCollisionCallFun(self, self.onCollision, nil, self.onCollisionExit)
end

function onCollision(self, col)
    if col.collider.gameObject.name == "wall" then
        return
    end

    if col.collider.gameObject.name == "max" then
        GameDispatcher:dispatchEvent(EventName.WARERMELON_GAME_MAX,{
            thisObj = self.simpleItem:getGo(),
            colObj = col.gameObject,
        })
    end

    local index = string.find(col.gameObject.name, "gameItem")
    if index == nil then
        return
    else
        GameDispatcher:dispatchEvent(EventName.WARERMELON_GAME_COMPOUND,{
            thisObj = self.simpleItem:getGo(),
            colObj = col.gameObject,
        })
    end
end

function onCollisionExit(self,col)
    if col.collider.gameObject.name == "max" then
        GameDispatcher:dispatchEvent(EventName.WARERMELON_GAME_MAX_EXIT,{
            thisObj = self.simpleItem:getGo(),
            colObj = col.gameObject,
        })
    end
end
return _M
