-- @FileName:   FieldExplorationPassageEventThing.lua
-- @Description:   通路事件
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.fieldExploration.thing.FieldExplorationPassageEventThing', Class.impl(fieldExploration.FieldExplorationPropEventThing))

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    self.mPassModel = self.mModel.m_modelTrans:Find("light").gameObject
    self.mBlockModel = self.mModel.m_modelTrans:Find("dark").gameObject

    if self.mPassModel then
        self.mPassModel:SetActive(true)
    end
    
    if self.mBlockModel then
        self.mBlockModel:SetActive(false)
    end
end

function onPass(self)
    if self.mPassModel and not self.mPassModel.activeSelf then
        self.mPassModel:SetActive(true)
    end

    if self.mBlockModel and self.mBlockModel.activeSelf then
        self.mBlockModel:SetActive(false)
    end
end

function onBlock(self)
    if self.mPassModel and self.mPassModel.activeSelf then
        self.mPassModel:SetActive(false)
    end

    if self.mBlockModel and not self.mBlockModel.activeSelf then
        self.mBlockModel:SetActive(true)
    end
end

return _M
