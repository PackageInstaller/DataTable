-- @FileName:   FieldExplorationEventModel.lua
-- @Description:   荒野行动模型基类
-- @Author: ZDH
-- @Date:   2023-07-25 15:35:17
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.model.FieldExplorationEventModel', Class.impl(model.modelBase))

function loadFinish(self, go, finishCall, sorceId)
    super.loadFinish(self, go, nil, sorceId)

    if self.m_ani then
        self:setPreLoadAnisByHashList(FieldExplorationConst.EVENT_ACT_LIST, finishCall)
    else
        if finishCall then
            finishCall(false, self)
        end
    end
end

function setModelGoName(self, name)
    if not name then
        local strArr = string.split(self.m_prefabName, "/")
        self.m_rootGo.name = strArr[#strArr] .. "_Root"
    else
        self.m_rootGo.name = name
    end
end

function AddFrameCallEvent(self, acitonName, callback, frameCount)
    if not self.m_ani then
        logError("annimaCtrl is null")
        return
    end
    self.m_ani:AddFrameCallEvent(acitonName, callback, frameCount)
end

function setScale(self, scale)
    self.m_trans.localScale = scale
end

function setVisible(self, beVisible)
    if self.m_rootGo.activeSelf ~= beVisible then
        self.m_rootGo:SetActive(beVisible)
    end
end

return _M
